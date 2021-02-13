<?php

require __DIR__ . "/../vendor/autoload.php";

// Получаем URI, очищаем его от лишних символов (а-ля ?foo=bar) и декодируем.
$uri = $_SERVER['REQUEST_URI'];

if (false !== $pos = strpos($uri, '?')) {
	$uri = substr($uri, 0, $pos);
}

$uri = rawurldecode($uri);

// Маршруты.
$dispatcher = \FastRoute\simpleDispatcher(function (\FastRoute\RouteCollector $r) use ($uri) {

	$r->addRoute('GET', '/', 'installation');

	// Маршрут добавляется автоматически на основе переданного URI (чтобы не прописывать все нужные значения вручную).
	if ($uri !== "/") {
		$r->addRoute('GET', $uri, substr($uri, 1));
	}

});

$routeInfo = $dispatcher->dispatch($_SERVER['REQUEST_METHOD'], $uri);

switch ($routeInfo[0]) {

	case \FastRoute\Dispatcher::NOT_FOUND:

		// 404
		echo "Page not found";

		break;

	case \FastRoute\Dispatcher::METHOD_NOT_ALLOWED:

		// 405
		$allowedMethods = $routeInfo[1];
		echo "Method not allowed";

		break;

	case \FastRoute\Dispatcher::FOUND:

		$templateName = $routeInfo[1];
//		$vars = $routeInfo[2];

		try {

			$smarty = new Smarty();

			$smarty->setConfigDir(__DIR__ . "/../app/config");
			$smarty->setTemplateDir(__DIR__ . "/../app/templates");
			$smarty->setCacheDir(__DIR__ . "/../smarty/cache");
			$smarty->setCompileDir(__DIR__ . "/../smarty/templates_c");

			$smarty->assign('name', $templateName);

			$smarty->display("index.tpl");

		} catch (Exception $e) {
			echo $e->getMessage();
		}

		break;

}

