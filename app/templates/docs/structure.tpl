<h1>Структура каталогов</h1>
<ul>
    <li><a href="structure#introduction">Вступление</a></li>
    <li><a href="structure#the-root-directory">Корневой каталог</a>
        <ul>
            <li><a href="structure#the-root-app-directory"><code>app</code> Справочник</a></li>
            <li><a href="structure#the-bootstrap-directory"><code>bootstrap</code> Справочник</a></li>
            <li><a href="structure#the-config-directory"><code>config</code> Справочник</a></li>
            <li><a href="structure#the-database-directory"><code>database</code> Справочник</a></li>
            <li><a href="structure#the-public-directory"><code>public</code> Справочник</a></li>
            <li><a href="structure#the-resources-directory"><code>resources</code> Справочник</a></li>
            <li><a href="structure#the-routes-directory"><code>routes</code> Справочник</a></li>
            <li><a href="structure#the-storage-directory"><code>storage</code> Справочник</a></li>
            <li><a href="structure#the-tests-directory"><code>tests</code> Справочник</a></li>
            <li><a href="structure#the-vendor-directory"><code>vendor</code> Справочник</a></li>
        </ul>
    </li>
    <li><a href="structure#the-app-directory">Каталог приложений</a>
        <ul>
            <li><a href="structure#the-broadcasting-directory"><code>Broadcasting</code> Справочник</a></li>
            <li><a href="structure#the-console-directory"><code>Console</code> Справочник</a></li>
            <li><a href="structure#the-events-directory"><code>Events</code> Справочник</a></li>
            <li><a href="structure#the-exceptions-directory"><code>Exceptions</code> Справочник</a></li>
            <li><a href="structure#the-http-directory"><code>Http</code> Справочник</a></li>
            <li><a href="structure#the-jobs-directory"><code>Jobs</code> Справочник</a></li>
            <li><a href="structure#the-listeners-directory"><code>Listeners</code> Справочник</a></li>
            <li><a href="structure#the-mail-directory"><code>Mail</code> Справочник</a></li>
            <li><a href="structure#the-models-directory"><code>Models</code> Справочник</a></li>
            <li><a href="structure#the-notifications-directory"><code>Notifications</code> Справочник</a></li>
            <li><a href="structure#the-policies-directory"><code>Policies</code> Справочник</a></li>
            <li><a href="structure#the-providers-directory"><code>Providers</code> Справочник</a></li>
            <li><a href="structure#the-rules-directory"><code>Rules</code> Справочник</a></li>
        </ul>
    </li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Структура приложения Laravel по умолчанию предназначена для обеспечения отличной отправной точки как для больших, так
    и для небольших приложений. Но вы можете организовать свое приложение так, как вам нравится. Laravel почти не
    налагает ограничений на расположение любого данного класса - до тех пор, пока Composer может автоматически загружать
    класс.</p>
<p></p>
<h2 id="the-root-directory"><a href="#the-root-directory">Корневой каталог</a></h2>
<p></p>
<h4 id="the-root-app-directory"><a href="#the-root-app-directory">Каталог приложений</a></h4>
<p><code>app</code> Каталог содержит основной код приложения. Вскоре мы рассмотрим этот каталог более подробно; однако
    почти все классы в вашем приложении будут в этом каталоге.</p>
<p></p>
<h4 id="the-bootstrap-directory"><a href="#the-bootstrap-directory">Каталог Bootstrap</a></h4>
<p><code>bootstrap</code> Каталог содержит <code>app.php</code> файл, который бутстрэпы рамки. В этом каталоге также
    находится <code>cache</code> каталог, содержащий файлы, сгенерированные каркасом для оптимизации производительности,
    такие как файлы кэша маршрутов и служб. Обычно вам не нужно изменять какие-либо файлы в этом каталоге.</p>
<p></p>
<h4 id="the-config-directory"><a href="#the-config-directory">Каталог конфигурации</a></h4>
<p><code>config</code> Каталог, как следует из названия, содержит все файлы конфигурации вашего приложения. Это отличная
    идея прочитать все эти файлы и ознакомиться со всеми доступными вам вариантами.</p>
<p></p>
<h4 id="the-database-directory"><a href="#the-database-directory">Каталог базы данных</a></h4>
<p><code>database</code> Каталог содержит ваши миграции базы данных, модели заводов, и семена. При желании вы также
    можете использовать этот каталог для хранения базы данных SQLite.</p>
<p></p>
<h4 id="the-public-directory"><a href="#the-public-directory">Публичный каталог</a></h4>
<p><code>public</code> Каталог содержит <code>index.php</code> файл, который является точкой входа для всех запросов,
    поступающих приложение и настраивает автозагрузку. В этом каталоге также хранятся ваши активы, такие как
    изображения, JavaScript и CSS.</p>
<p></p>
<h4 id="the-resources-directory"><a href="#the-resources-directory">Справочник ресурсов</a></h4>
<p><code>resources</code> Каталог содержит ваши <a href="views">взгляды</a>, а также сырые, оон скомпилированных
    активов, такие как CSS или JavaScript. В этом каталоге также находятся все ваши языковые файлы.</p>
<p></p>
<h4 id="the-routes-directory"><a href="#the-routes-directory">Каталог маршрутов</a></h4>
<p><code>routes</code> Каталог содержит все определения маршрута для вашего приложения. По умолчанию несколько файлов
    маршрута включены Laravel: <code>web.php</code>, <code>api.php</code>, <code>console.php</code>, и <code>channels.php</code>.
</p>
<p><code>web.php</code> Файл содержит маршруты, что <code>RouteServiceProvider</code> места в <code>web</code>
    межплатформенной группе, которая обеспечивает состояние сеанса, защиту от CSRF, и шифрование печенья. Если ваше
    приложение не предлагает RESTful API без сохранения состояния, то, скорее всего, все ваши маршруты будут определены
    в <code>web.php</code> файле.</p>
<p>Этот <code>api.php</code> файл содержит маршруты, которые <code>RouteServiceProvider</code> размещаются в группе
    <code>api</code> промежуточного программного обеспечения. Эти маршруты предназначены для без сохранения состояния,
    поэтому запросы, поступающие в приложение через эти маршруты, предназначены для аутентификации с <a href="sanctum">помощью
        токенов</a> и не будут иметь доступа к состоянию сеанса.</p>
<p>В этом <code>console.php</code> файле вы можете определить все свои консольные команды на основе закрытия. Каждое
    замыкание привязано к экземпляру команды, что обеспечивает простой подход к взаимодействию с методами ввода-вывода
    каждой команды. Несмотря на то, что этот файл не определяет маршруты HTTP, он определяет точки входа (маршруты) в
    ваше приложение на основе консоли.</p>
<p>В этом <code>channels.php</code> файле вы можете зарегистрировать все каналы <a href="broadcasting">трансляции
        событий,</a> которые поддерживает ваше приложение.</p>
<p></p>
<h4 id="the-storage-directory"><a href="#the-storage-directory">Каталог хранилища</a></h4>
<p><code>storage</code> Каталог содержит журналы, скомпилированные шаблоны отвала, сеансы на основе файлов, кэш - память
    файлов, а также другие файлы, созданных в рамках. Этот каталог разделяется на <code>app</code>,
    <code>framework</code> и <code>logs</code> каталоги. <code>app</code> Каталог может быть использован для хранения
    любых файлов, генерируемых приложением. <code>framework</code> Каталог используется для хранения каркасных
    сгенерированных файлов и кэшей. Наконец, <code>logs</code> каталог содержит файлы журнала вашего приложения.</p>
<p><code>storage/app/public</code> Каталог может быть использован для хранения сгенерированных пользователем файлов,
    таких как профильными аватары, которые должны быть доступны для общественности. Вы должны создать символическую
    ссылку, <code>public/storage</code> указывающую на этот каталог. Вы можете создать ссылку с помощью Artisan-команды
    <code>php artisan storage:link</code>.</p>
<p></p>
<h4 id="the-tests-directory"><a href="#the-tests-directory">Справочник тестов</a></h4>
<p><code>tests</code> Каталог содержит автоматизированные тесты. Примеры модульных тестов <a href="https://phpunit.de/">PHPUnit</a>
    и функциональных тестов предоставляются по умолчанию. Каждый тестовый класс должен иметь суффикс <code>Test</code>.
    Вы можете запускать свои тесты с помощью команд <code>phpunit</code> или <code>php vendor/bin/phpunit</code>. Или,
    если вы хотите более подробное и красивое представление результатов ваших тестов, вы можете запускать их с помощью
    команды <code>php artisan test</code> Artisan.</p>
<p></p>
<h4 id="the-vendor-directory"><a href="#the-vendor-directory">Каталог поставщиков</a></h4>
<p><code>vendor</code> Каталог содержит вашу <a href="https://getcomposer.org/">Composer</a> зависимость.</p>
<p></p>
<h2 id="the-app-directory"><a href="#the-app-directory">Каталог приложений</a></h2>
<p>Большая часть вашего приложения размещается в <code>app</code> каталоге. По умолчанию этот каталог находится в
    пространстве имен <code>App</code> и автоматически загружается Composer с использованием <a
            href="https://www.php-fig.org/psr/psr-4/">стандарта автозагрузки PSR-4</a>.</p>
<p><code>app</code> Каталог содержит множество дополнительных каталогов, таких как <code>Console</code>,
    <code>Http</code> и <code>Providers</code>. Подумайте о <code>Console</code> и <code>Http</code> каталогах,
    обеспечивая API в ядро приложения. Протокол HTTP и интерфейс командной строки являются механизмами взаимодействия с
    вашим приложением, но фактически не содержат логики приложения. Другими словами, это два способа подачи команд
    вашему приложению. <code>Console</code> Каталог содержит все ваши команды Artisan, в то время как <code>Http</code>
    каталог содержит ваши контроллеры, промежуточное и запросы.</p>
<p>Множество других каталогов будет создано внутри <code>app</code> каталога, когда вы будете использовать
    <code>make</code> команды Artisan для создания классов. Так, например, <code>app/Jobs</code> каталог не будет
    существовать, пока вы не выполните команду <code>make:job</code> Artisan для создания класса задания.</p>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Многие классы в <code>app</code> каталоге могут быть созданы Artisan с помощью команд. Чтобы просмотреть
            доступные команды, запустите <code>php artisan list make</code> команду в своем терминале.</p></p></div>
</blockquote>
<p></p>
<h4 id="the-broadcasting-directory"><a href="#the-broadcasting-directory">Справочник вещания</a></h4>
<p><code>Broadcasting</code> Каталог содержит все классы широковещательных каналов для вашего приложения. Эти классы
    создаются с помощью <code>make:channel</code> команды. Этот каталог не существует по умолчанию, но будет создан для
    вас, когда вы создадите свой первый канал. Чтобы узнать больше о каналах, ознакомьтесь с документацией по <a
            href="broadcasting">трансляции событий</a>.</p>
<p></p>
<h4 id="the-console-directory"><a href="#the-console-directory">Каталог консоли</a></h4>
<p><code>Console</code> Каталог содержит все команды пользовательской Artisan для вашего приложения. Эти команды могут
    быть созданы с помощью <code>make:command</code> команды. В этом каталоге также находится ядро вашей консоли, в
    котором регистрируются ваши пользовательские команды Artisan и определяются ваши <a href="scheduling">запланированные
        задачи</a>.</p>
<p></p>
<h4 id="the-events-directory"><a href="#the-events-directory">Каталог событий</a></h4>
<p>Этот каталог не существует по умолчанию, но будет создан для вас командами Artisan <code>event:generate</code> и
    <code>make:event</code>. В <code>Events</code> каталоге размещены <a href="events">классы событий</a>. События могут
    использоваться для предупреждения других частей вашего приложения о том, что произошло определенное действие,
    обеспечивая большую гибкость и развязку.</p>
<p></p>
<h4 id="the-exceptions-directory"><a href="#the-exceptions-directory">Каталог исключений</a></h4>
<p><code>Exceptions</code> Каталог содержит обработчик исключений вашего приложения, а также является хорошим местом
    для размещения каких - либо исключений, брошенных вашим приложением. Если вы хотите настроить, как ваши исключения
    регистрируются или обрабатываются, вам следует изменить <code>Handler</code> класс в этом каталоге.</p>
<p></p>
<h4 id="the-http-directory"><a href="#the-http-directory">Каталог Http</a></h4>
<p><code>Http</code> Каталог содержит ваши контроллеры, запросы промежуточного слоя и формы. Практически вся логика
    обработки запросов, поступающих в ваше приложение, будет размещена в этом каталоге.</p>
<p></p>
<h4 id="the-jobs-directory"><a href="#the-jobs-directory">Каталог вакансий</a></h4>
<p>Этот каталог не существует по умолчанию, но будет создан для вас, если вы выполните команду <code>make:job</code>
    Artisan. В <code>Jobs</code> каталоге хранятся <a href="queues">задания</a> в <a href="queues">очереди</a> для
    вашего приложения. Задания могут быть поставлены в очередь вашим приложением или выполняться синхронно в рамках
    текущего жизненного цикла запроса. Задания, которые выполняются синхронно во время текущего запроса, иногда называют
    «командами», поскольку они являются реализацией <a href="https://en.wikipedia.org/wiki/Command_pattern">шаблона
        команд</a>.</p>
<p></p>
<h4 id="the-listeners-directory"><a href="#the-listeners-directory">Каталог слушателей</a></h4>
<p>Этот каталог не существует по умолчанию, но будет создан для вас, если вы выполните команды Artisan <code>event:generate</code>
    или <code>make:listener</code>. <code>Listeners</code> Каталог содержит классы, которые обрабатывают свои <a
            href="events">события</a>. Слушатели событий получают экземпляр события и выполняют логику в ответ на
    запускаемое событие. Например, <code>UserRegistered</code> событие может быть обработано
    <code>SendWelcomeEmail</code> слушателем.</p>
<p></p>
<h4 id="the-mail-directory"><a href="#the-mail-directory">Почтовый каталог</a></h4>
<p>Этот каталог не существует по умолчанию, но будет создан для вас, если вы выполните команду <code>make:mail</code>
    Artisan. <code>Mail</code> Каталог содержит все ваши <a href="mail">классы, которые представляют собой электронные
        письма</a>, отправленные вашим приложением. Почтовые объекты позволяют вам инкапсулировать всю логику создания
    электронной почты в одном простом классе, который может быть отправлен с помощью <code>Mail::send</code> метода.</p>
<p></p>
<h4 id="the-models-directory"><a href="#the-models-directory">Каталог моделей</a></h4>
<p><code>Models</code> Каталог содержит все ваши <a href="eloquent">модели классов красноречивы</a>. Eloquent ORM,
    включенный в Laravel, предоставляет красивую и простую реализацию ActiveRecord для работы с вашей базой данных.
    Каждая таблица базы данных имеет соответствующую «Модель», которая используется для взаимодействия с этой таблицей.
    Модели позволяют запрашивать данные в таблицах, а также вставлять новые записи в таблицу.</p>
<p></p>
<h4 id="the-notifications-directory"><a href="#the-notifications-directory">Каталог уведомлений</a></h4>
<p>Этот каталог не существует по умолчанию, но будет создан для вас, если вы выполните команду
    <code>make:notification</code> Artisan. <code>Notifications</code> Каталог содержит все «транзакционных» <a
            href="notifications">уведомлений</a>, отправляемых приложением, например, простых уведомлений о событиях,
    которые происходят в вашем приложении. Уведомления Laravel позволяют абстрагироваться от отправки уведомлений по
    различным драйверам, таким как электронная почта, Slack, SMS, или хранятся в базе данных.</p>
<p></p>
<h4 id="the-policies-directory"><a href="#the-policies-directory">Каталог политик</a></h4>
<p>Этот каталог не существует по умолчанию, но будет создан для вас, если вы выполните команду <code>make:policy</code>
    Artisan. <code>Policies</code> Каталог содержит <a href="authorization">классы политики авторизации</a> для вашего
    приложения. Политики используются для определения того, может ли пользователь выполнить определенное действие с
    ресурсом.</p>
<p></p>
<h4 id="the-providers-directory"><a href="#the-providers-directory">Справочник поставщиков</a></h4>
<p><code>Providers</code> Каталог содержит все <a href="providers">поставщиков услуг</a> для вашего приложения.
    Поставщики услуг загружают ваше приложение, привязывая службы к контейнеру служб, регистрируя события или выполняя
    любые другие задачи для подготовки вашего приложения к входящим запросам.</p>
<p>В новом приложении Laravel этот каталог уже будет содержать несколько провайдеров. При необходимости вы можете
    добавлять своих собственных провайдеров в этот каталог.</p>
<p></p>
<h4 id="the-rules-directory"><a href="#the-rules-directory">Справочник правил</a></h4>
<p>Этот каталог не существует по умолчанию, но будет создан для вас, если вы выполните команду <code>make:rule</code>
    Artisan. <code>Rules</code> Каталог содержит специальные объекты проверки правил для вашего приложения. Правила
    используются для инкапсуляции сложной логики проверки в простой объект. Для получения дополнительной информации
    ознакомьтесь с <a href="validation">документацией</a> по <a href="validation">валидации</a>.</p>
