<?php

namespace App;

use DOMXPath;
use Exception;
use Masterminds\HTML5;

/**
 * Функционал для получения названий страниц (title).
 *
 * @package App
 */
class PageTitle
{

	/**
	 * Шаблон с навигационным меню, из которого нужно прочитать названия страниц.
	 *
	 * @var string
	 */
	private string $navigationFile = __DIR__ . "/templates/common/navigation-bar.tpl";

	/**
	 * Коллекция с названиями страниц.
	 *
	 * @var array
	 */
	private array $pageTitles;

	/**
	 * @throws Exception
	 */
	public function __construct()
	{

//		$this->readFromCache(); // TODO: запилить получение данных из кеша.

		if (empty($this->pageTitles)) {
			$this->pageTitles = $this->readFromNavigator();
		}

	}

	/**
	 * Возвращает название страницы, опираясь на переданный URI. Например, для страницы "http://example.com/releases"
	 * URI будет равен "releases" и метод вернет название "Примечания к выпуску", описанное в шаблоне "navigation-bar.tpl".
	 *
	 * @param string $uri
	 * @param string $postfix
	 * @return string
	 */
	public function getByTemplateName(string $uri, string $postfix = ""): string
	{

		$result = ""; // By default

		$uri = trim($uri);

		if (!empty($uri) && array_key_exists($uri, $this->pageTitles)) {

			$postfix = trim($postfix);

			if (!empty($postfix)) {

				$result_arr = [
					$this->pageTitles[$uri],
					$postfix,
				];

				$result = implode(": ", $result_arr);

			} else {
				$result = $this->pageTitles[$uri];
			}

		}

		return $result;

	}

	/**
	 * Читает названия страниц из шаблона "navigation-bar.tpl".
	 * Помещает данные в коллекцию и возвращает ее.
	 *
	 * @return array
	 * @throws Exception
	 */
	private function readFromNavigator(): array
	{

		if (!file_exists($this->navigationFile)) {
			throw new Exception("Navigation file not found");
		}

		$htmlContent = trim(file_get_contents($this->navigationFile));

		if (empty($htmlContent)) {
			throw new Exception("Navigation file is empty");
		}

		$dom = (new HTML5())->loadHTML($htmlContent);

		if (is_null($dom->documentElement)) {
			throw new Exception("Navigation file has no DOM elements");
		}

		$xPath = new DOMXPath($dom);

		// Вытащим родительский DOM-элемент, в котором перечислены ссылки на страницы.
		$node = $xPath->query("//*[contains(@class, 'docs_sidebar')]");

		if ($node->length != 1) {
			throw new Exception("Required DOM element is missing from the navigation file");
		}

		$node = $node->item(0);
		$links = $node->getElementsByTagName('a'); // Согласен, не шибко элегантно.

		if ($links->length == 0) {
			throw new Exception("Required DOM element is empty");
		}

		$result = [];

		foreach ($links as $_link) {

			$uri = trim($_link->getAttribute('href'));
			$title = trim($_link->nodeValue);

			if (!empty($uri) && !empty($title)) {
				$result[$uri] = $title;
			}

		}

		return $result;

	}

}