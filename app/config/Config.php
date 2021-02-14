<?php

namespace App\config;

/**
 * Настройки для приложения.
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