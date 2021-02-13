{* Navigation bar *}

{$_uri = $uri|default:"installation"}

<aside class="fixed top-0 bottom-0 left-0 z-20 h-full w-16 flex flex-col bg-gradient-to-b from-gray-100 to-white transition-all duration-300 overflow-hidden lg:sticky lg:w-80 lg:flex-shrink-0 lg:flex lg:justify-end lg:items-end 2xl:max-w-lg 2xl:w-full">

    <div class="relative min-h-0 flex-1 flex flex-col xl:w-80">

        <a href="/" class="flex items-center py-8 px-4 lg:px-8 xl:px-16">
            <img class="w-8 h-8 flex-shrink-0 transition-all duration-300 lg:w-12 lg:h-12" src="img/logomark.min.svg">
            <img class="hidden ml-4 lg:block" src="img/logotype.min.svg">
        </a>

        <div class="overflow-y-auto overflow-x-hidden px-4 lg:overflow-hidden lg:px-8 xl:px-16">
            <nav id="indexed-nav" class="hidden lg:block lg:mt-4">
                <div class="docs_sidebar">
                    <ul>
                        <li>
                            <h2>Пролог</h2>
                            <ul>
                                <li><a href="releases">Примечания к выпуску</a></li>
                                <li><a href="upgrade">Руководство по обновлению</a></li>
                                <li><a href="contributions">Руководство по вкладу</a></li>
                            </ul>
                        </li>
                        <li>
                            <h2>Начиная</h2>
                            <ul>
                                <li><a href="installation">Установка</a></li>
                                <li><a href="configuration">Конфигурация</a></li>
                                <li><a href="structure">Структура каталогов</a></li>
                                <li><a href="starter-kits">Стартовые наборы</a></li>
                                <li><a href="deployment">Развертывание</a></li>
                            </ul>
                        </li>
                        <li>
                            <h2>Архитектурные концепции</h2>
                            <ul>
                                <li><a href="lifecycle">Жизненный цикл запроса</a></li>
                                <li><a href="container">Сервисный контейнер</a></li>
                                <li><a href="providers">Поставщики услуг</a></li>
                                <li><a href="facades">Фасады</a></li>
                            </ul>
                        </li>
                        <li>
                            <h2>Основы</h2>
                            <ul>
                                <li><a href="routing">Маршрутизация</a></li>
                                <li><a href="middleware">Промежуточное ПО</a></li>
                                <li><a href="csrf">CSRF защита</a></li>
                                <li><a href="controllers">Контроллеры</a></li>
                                <li><a href="requests">Запросы</a></li>
                                <li><a href="responses">Ответы</a></li>
                                <li><a href="views">Представления</a></li>
                                <li><a href="blade">Шаблоны Blade</a></li>
                                <li><a href="urls">Генерация URL</a></li>
                                <li><a href="session">Сессия</a></li>
                                <li><a href="validation">Валидация</a></li>
                                <li><a href="errors">Обработка ошибок</a></li>
                                <li><a href="logging">Логирование</a></li>
                            </ul>
                        </li>
                        <li>
                            <h2>Копать глубже</h2>
                            <ul>
                                <li><a href="artisan">Консоль Artisan</a></li>
                                <li><a href="broadcasting">Вещание</a></li>
                                <li><a href="cache">Кеш</a></li>
                                <li><a href="collections">Коллекции</a></li>
                                <li><a href="mix">Компиляция активов</a></li>
                                <li><a href="contracts">Контракты</a></li>
                                <li><a href="events">События</a></li>
                                <li><a href="filesystem">Файловое хранилище</a></li>
                                <li><a href="helpers">Помощники</a></li>
                                <li><a href="http-client">HTTP-клиент</a></li>
                                <li><a href="localization">Локализация</a></li>
                                <li><a href="mail">Почта</a></li>
                                <li><a href="notifications">Уведомления</a></li>
                                <li><a href="packages">Разработка пакетов</a></li>
                                <li><a href="queues">Очереди</a></li>
                                <li><a href="scheduling">Планирование задач</a></li>
                            </ul>
                        </li>
                        <li>
                            <h2>Безопасность</h2>
                            <ul>
                                <li><a href="authentication">Аутентификация</a></li>
                                <li><a href="authorization">Авторизация</a></li>
                                <li><a href="verification">Подтверждение по элетронной почте</a></li>
                                <li><a href="encryption">Шифрование</a></li>
                                <li><a href="hashing">Хеширование</a></li>
                                <li><a href="passwords">Сброс пароля</a></li>
                            </ul>
                        </li>
                        <li>
                            <h2>База данных</h2>
                            <ul>
                                <li><a href="database">Начиная</a></li>
                                <li><a href="queries">Конструктор запросов</a></li>
                                <li><a href="pagination">Пагинация</a></li>
                                <li><a href="migrations">Миграции</a></li>
                                <li><a href="seeding">Посев</a></li>
                                <li><a href="redis">Redis</a></li>
                            </ul>
                        </li>
                        <li>
                            <h2>Красноречивый ORM</h2>
                            <ul>
                                <li><a href="eloquent">Начиная</a></li>
                                <li><a href="eloquent-relationships">Отношения</a></li>
                                <li><a href="eloquent-collections">Коллекции</a></li>
                                <li><a href="eloquent-mutators">Мутаторы / Приводы</a></li>
                                <li><a href="eloquent-resources">Ресурсы API</a></li>
                                <li><a href="eloquent-serialization">Сериализация</a></li>
                            </ul>
                        </li>
                        <li>
                            <h2>Тестирование</h2>
                            <ul>
                                <li><a href="testing">Начиная</a></li>
                                <li><a href="http-tests">HTTP-тесты</a></li>
                                <li><a href="console-tests">Консольные тесты</a></li>
                                <li><a href="dusk">Браузерные тесты</a></li>
                                <li><a href="database-testing">База данных</a></li>
                                <li><a href="mocking">Издевательство</a></li>
                            </ul>
                        </li>
                        <li>
                            <h2>Пакеты</h2>
                            <ul>
                                <li><a href="starter-kits#laravel-breeze">Breeze</a></li>
                                <li><a href="billing">Cashier (Stripe)</a></li>
                                <li><a href="cashier-paddle">Cashier (Paddle)</a></li>
                                <li><a href="dusk">Dusk</a></li>
                                <li><a href="envoy">Envoy</a></li>
                                <li><a href="fortify">Fortify</a></li>
                                <li><a href="homestead">Homestead</a></li>
                                <li><a href="horizon">Horizon</a></li>
                                <li><a href="https://jetstream.laravel.com">Jetstream</a></li>
                                <li><a href="passport">Passport</a></li>
                                <li><a href="sail">Sail</a></li>
                                <li><a href="sanctum">Sanctum</a></li>
                                <li><a href="scout">Scout</a></li>
                                <li><a href="socialite">Socialite</a></li>
                                <li><a href="telescope">Telescope</a></li>
                                <li><a href="valet">Valet</a></li>
                            </ul>
                        </li>
                        <li><a href="https://laravel.com/api/8.x/">Документация по API (eng)</a></li>
                    </ul>
                </div>
            </nav>
        </div>
    </div>

    <script>
        $(document).ready(function () {

            var $navigatorItem = $('.docs_sidebar').find('a[href={$_uri}]').closest('li');

            console.log('{$_uri}');

            $navigatorItem.addClass('active');
            $navigatorItem.parent('ul').closest('li').addClass('sub--on');

        });
    </script>

</aside>
