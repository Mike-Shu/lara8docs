<?php

namespace App\config;

/**
 * Возвращает настройки для приложения.
 *
 * @package App\config
 */
class Config
{

	/**
	 * @return ConfigDefault
	 */
	public static function get(): ConfigDefault
	{

		if (class_exists("App\\config\\ConfigUser")) {

			return new ConfigUser();

		}

		return new ConfigDefault();


	}

}
