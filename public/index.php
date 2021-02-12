<?php

require __DIR__ . '/../vendor/autoload.php';

$dispatcher = \FastRoute\simpleDispatcher(function (\FastRoute\RouteCollector $r) {

	$r->addRoute('GET', '/', 'home');

});

// Fetch method and URI from somewhere.
$httpMethod = $_SERVER['REQUEST_METHOD'];
$uri = $_SERVER['REQUEST_URI'];

// Strip query string (?foo=bar) and decode URI.
if (false !== $pos = strpos($uri, '?')) {
	$uri = substr($uri, 0, $pos);
}

$uri = rawurldecode($uri);

$routeInfo = $dispatcher->dispatch($httpMethod, $uri);

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

		$handler = $routeInfo[1];
		$vars = $routeInfo[2];

		$smarty = new Smarty();

		break;

}

