<?php

namespace App\config;

/**
 * Настройки для приложения.
 *
 * (!) Внимание! Этот файл не предназначен для пользовательского редактирования.
 *
 * Если необходимо внести изменения в конфигурацию, то:
 *  - создайте класс "ConfigUser" (файл "ConfigUser.php" в каталоге "config");
 *  - в этот класс добавьте те свойства, которые желаете изменить. Например: "public bool $fixedNavigation = false;".
 *
 * @package App\config
 */
class Config
{

	/**
	 * Фиксация навигационного меню:
	 *  "true"  - меню прилипнет к верхнему краю окна;
	 *  "false" - меню будет прокручиваться вместе со страницей.
	 *
	 * @var bool
	 */
	public bool $fixedNavigation = true;

	/**
	 * Показать/скрыть блок "Перевод выполнен средствами…".
	 *
	 * @var bool
	 */
	public bool $showTranslatedWith = true;

}

/**
 * Если найден файл с пользовательской конфигурацией.
 */
if (is_file(dirname(__FILE__) . "/ConfigUser.php")) {

	include_once "ConfigUser.php";

	if (class_exists("ConfigUser")) {

		$default_vars = get_class_vars("Config");

		foreach ($default_vars as $_var => $_value) {

			if (property_exists("ConfigUser", $_var)) {
				Config::$$_var = ConfigUser::$$_var;
			}

		}

	}

}
