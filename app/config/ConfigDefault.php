<?php

namespace App\config;

/**
 * Настройки для приложения (по умолчанию).
 *
 * (!) Этот класс НЕ ПРЕДНАЗНАЧЕН для редактирования.
 *
 * Если необходимо изменить значения свойств, то:
 *  - создайте класс "ConfigUser" расширяющий "ConfigDefault" (файл "ConfigUser.php" в каталоге "config");
 *  - в этот класс добавьте те свойства, которые желаете изменить.
 *
 * Например:
 * ```
 * class ConfigUser extends ConfigDefault
 * {
 *
 *    public bool $fixedNavigation = false;
 *
 * }
 * ```
 *
 * @package App\config
 */
class ConfigDefault
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