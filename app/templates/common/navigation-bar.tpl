{* Navigation bar *}

{$_uri = $uri|default:"installation"}
{$_fixed_navigation = $fixed_navigation|default:false}

<aside class="fixed top-0 bottom-0 left-0 z-20 h-full w-16 flex flex-col bg-gradient-to-b from-gray-100 to-white transition-all duration-300 overflow-hidden lg:sticky lg:w-80 lg:flex-shrink-0 lg:flex lg:justify-end lg:items-end 2xl:max-w-lg 2xl:w-full">

    <div class="relative min-h-0 flex-1 flex flex-col xl:w-80"{if $_fixed_navigation} style="position: fixed !important; top: 0;"{/if}>

        <a href="/" class="flex items-center py-8 px-4 lg:px-8 xl:px-16">
            <img class="w-8 h-8 flex-shrink-0 transition-all duration-300 lg:w-12 lg:h-12" src="img/logomark.min.svg">
            <img class="hidden ml-4 lg:block" src="img/logotype.min.svg">
        </a>

        <div class="overflow-y-auto overflow-x-hidden px-4 lg:overflow-hidden lg:px-8 xl:px-16">
            <nav id="indexed-nav" class="hidden lg:block lg:mt-4">
                <div class="docs_sidebar">
                    <ul>
                        <li>
                            <h2>Пролог <sub>Prologue</sub></h2>
                            <ul>
                                <li><a href="releases">Примечания к выпуску <sub>Release notes</sub></a></li>
                                <li><a href="upgrade">Руководство по обновлению <sub>Upgrade guide</sub></a></li>
                                <li><a href="contributions">Руководство по вкладу <sub>Contribution guide</sub></a></li>
                            </ul>
                        </li>
                        <li>
                            <h2>Начало работы <sub>Getting started</sub></h2>
                            <ul>
                                <li><a href="installation">Установка <sub>Installation</sub></a></li>
                                <li><a href="configuration">Конфигурация <sub>Configuration</sub></a></li>
                                <li><a href="structure">Структура каталогов <sub>Directory structure</sub></a></li>
                                <li><a href="starter-kits">Стартовые наборы <sub>Starter kits</sub></a></li>
                                <li><a href="deployment">Развертывание <sub>Deployment</sub></a></li>
                            </ul>
                        </li>
                        <li>
                            <h2>Архитектурные концепции <sub>Architecture concepts</sub></h2>
                            <ul>
                                <li><a href="lifecycle">Жизненный цикл запроса <sub>Request lifecycle</sub></a></li>
                                <li><a href="container">Сервисный контейнер <sub>Service container</sub></a></li>
                                <li><a href="providers">Поставщики услуг <sub>Service providers</sub></a></li>
                                <li><a href="facades">Фасады <sub>Facades</sub></a></li>
                            </ul>
                        </li>
                        <li>
                            <h2>Основы <sub>The basics</sub></h2>
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
                            <h2>Погружаясь глубже <sub>Digging deeper</sub></h2>
                            <ul>
                                <li><a href="artisan">Консоль Artisan <sub>Artisan console</sub></a></li>
                                <li><a href="broadcasting">Вещание <sub>Broadcasting</sub></a></li>
                                <li><a href="cache">Кеш <sub>Cache</sub></a></li>
                                <li><a href="collections">Коллекции <sub>Collections</sub></a></li>
                                <li><a href="mix">Компиляция ассетов <sub>Compiling assets</sub></a></li>
                                <li><a href="contracts">Контракты <sub>Contracts</sub></a></li>
                                <li><a href="events">События <sub>Events</sub></a></li>
                                <li><a href="filesystem">Файловое хранилище <sub>File storage</sub></a></li>
                                <li><a href="helpers">Помощники <sub>Helpers</sub></a></li>
                                <li><a href="http-client">HTTP-клиент <sub>HTTP client</sub></a></li>
                                <li><a href="localization">Локализация <sub>Localization</sub></a></li>
                                <li><a href="mail">Почта <sub>Mail</sub></a></li>
                                <li><a href="notifications">Уведомления <sub>Notifications</sub></a></li>
                                <li><a href="packages">Разработка пакетов <sub>Package development</sub></a></li>
                                <li><a href="queues">Очереди <sub>Queues</sub></a></li>
                                <li><a href="scheduling">Планирование задач <sub>Task scheduling</sub></a></li>
                            </ul>
                        </li>
                        <li>
                            <h2>Безопасность <sub>Security</sub></h2>
                            <ul>
                                <li><a href="authentication">Аутентификация <sub>Authentication</sub></a></li>
                                <li><a href="authorization">Авторизация <sub>Authorization</sub></a></li>
                                <li><a href="verification">Подтверждение по email <sub>Email verification</sub></a></li>
                                <li><a href="encryption">Шифрование <sub>Encryption</sub></a></li>
                                <li><a href="hashing">Хеширование <sub>Hashing</sub></a></li>
                                <li><a href="passwords">Сброс пароля <sub>Password reset</sub></a></li>
                            </ul>
                        </li>
                        <li>
                            <h2>База данных <sub>Database</sub></h2>
                            <ul>
                                <li><a href="database">Начало работы <sub>Getting started</sub></a></li>
                                <li><a href="queries">Конструктор запросов <sub>Query builder</sub></a></li>
                                <li><a href="pagination">Пагинация <sub>Pagination</sub></a></li>
                                <li><a href="migrations">Миграции <sub>Migrations</sub></a></li>
                                <li><a href="seeding">Посев <sub>Seeding</sub></a></li>
                                <li><a href="redis">Redis</a></li>
                            </ul>
                        </li>
                        <li>
                            <h2>Eloquent ORM</h2>
                            <ul>
                                <li><a href="eloquent">Начало работы <sub>Getting started</sub></a></li>
                                <li><a href="eloquent-relationships">Отношения <sub>Relationships</sub></a></li>
                                <li><a href="eloquent-collections">Коллекции <sub>Collections</sub></a></li>
                                <li><a href="eloquent-mutators">Мутаторы/Приводы <sub>Mutators/Casts</sub></a></li>
                                <li><a href="eloquent-resources">Ресурсы API <sub>API resources</sub></a></li>
                                <li><a href="eloquent-serialization">Сериализация <sub>Serialization</sub></a></li>
                            </ul>
                        </li>
                        <li>
                            <h2>Тестирование <sub>Testing</sub></h2>
                            <ul>
                                <li><a href="testing">Начало работы <sub>Getting started</sub></a></li>
                                <li><a href="http-tests">HTTP-тесты <sub>HTTP tests</sub></a></li>
                                <li><a href="console-tests">Консольные тесты <sub>Console tests</sub></a></li>
                                <li><a href="dusk">Браузерные тесты <sub>Browser tests</sub></a></li>
                                <li><a href="database-testing">База данных <sub>Database</sub></a></li>
                                <li><a href="mocking">Мокинг <sub>Mocking</sub></a></li>
                            </ul>
                        </li>
                        <li>
                            <h2>Пакеты <sub>Packages</sub></h2>
                            <ul>
                                <li><a href="starter-kits#laravel-breeze">Breeze</a></li>
                                <li><a class="external" href="https://laravel.com/docs/8.x/billing">Cashier (Stripe) (eng)</a></li>
                                <li><a class="external" href="https://laravel.com/docs/8.x/cashier-paddle">Cashier (Paddle) (eng)</a></li>
                                <li><a href="dusk">Dusk</a></li>
                                <li><a class="external" href="https://laravel.com/docs/8.x/envoy">Envoy (eng)</a></li>
                                <li><a class="external" href="https://laravel.com/docs/8.x/fortify">Fortify (eng)</a></li>
                                <li><a class="external" href="https://laravel.com/docs/8.x/homestead">Homestead (eng)</a></li>
                                <li><a class="external" href="https://laravel.com/docs/8.x/horizon">Horizon (eng)</a></li>
                                <li><a href="starter-kits#laravel-jetstream">Jetstream</a></li>
                                <li><a class="external" href="https://laravel.com/docs/8.x/passport">Passport (eng)</a></li>
                                <li><a class="external" href="https://laravel.com/docs/8.x/sail">Sail (eng)</a></li>
                                <li><a class="external" href="https://laravel.com/docs/8.x/sanctum">Sanctum (eng)</a></li>
                                <li><a class="external" href="https://laravel.com/docs/8.x/scout">Scout (eng)</a></li>
                                <li><a class="external" href="https://laravel.com/docs/8.x/socialite">Socialite (eng)</a></li>
                                <li><a class="external" href="https://laravel.com/docs/8.x/telescope">Telescope (eng)</a></li>
                                <li><a class="external" href="https://laravel.com/docs/8.x/valet">Valet (eng)</a></li>
                            </ul>
                        </li>
                        <li><a class="external" href="https://laravel.com/api/8.x/" target="_blank">Документация по API (eng)</a></li>
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
