<h1>Установка</h1>
<ul>
    <li><a href="installation#meet-laravel">Познакомьтесь с Laravel</a>
        <ul>
            <li><a href="installation#why-laravel">Почему именно Laravel?</a></li>
        </ul>
    </li>
    <li><a href="installation#your-first-laravel-project">Ваш первый проект на Laravel</a>
        <ul>
            <li><a href="installation#getting-started-on-macos">Начало работы в macOS</a></li>
            <li><a href="installation#getting-started-on-windows">Начало работы в Windows</a></li>
            <li><a href="installation#getting-started-on-linux">Начало работы в Linux</a></li>
            <li><a href="installation#installation-via-composer">Установка через Composer</a></li>
        </ul>
    </li>
    <li><a href="installation#initial-configuration">Начальная конфигурация</a></li>
    <li><a href="installation#next-steps">Следующие шаги</a>
        <ul>
            <li><a href="installation#laravel-the-fullstack-framework">Laravel - фреймворк Full Stack</a></li>
            <li><a href="installation#laravel-the-api-backend">Laravel Бэкэнд API</a></li>
        </ul>
    </li>
</ul>
<p></p>
<h2 id="meet-laravel"><a href="#meet-laravel">Познакомьтесь с Laravel</a></h2>
<p>Laravel - это среда веб-приложений с выразительным элегантным синтаксисом. Веб-фреймворк обеспечивает структуру и
    отправную точку для создания вашего приложения, позволяя вам сосредоточиться на создании чего-то удивительного, пока
    мы не будем вдаваться в детали.</p>
<p>Laravel стремится обеспечить потрясающий опыт разработчика, предоставляя при этом мощные функции, такие как
    тщательное внедрение зависимостей, выразительный уровень абстракции базы данных, очереди и запланированные задания,
    модульное и интеграционное тестирование и многое другое.</p>
<p>Независимо от того, новичок ли вы в PHP или веб-фреймворках или имеете многолетний опыт, Laravel - это фреймворк,
    который может расти вместе с вами. Мы поможем вам сделать первые шаги в качестве веб-разработчика или подскажем, как
    вы выведете свой опыт на новый уровень. Нам не терпится увидеть, что вы построите.</p>
<p></p>
<h3 id="why-laravel"><a href="#why-laravel">Почему именно Laravel?</a></h3>
<p>При создании веб-приложения вам доступны различные инструменты и платформы. Однако мы считаем, что Laravel - лучший
    выбор для создания современных полнофункциональных веб-приложений.</p>
<h4>Прогрессивная структура</h4>
<p>Нам нравится называть Laravel «прогрессивным» фреймворком. Под этим мы подразумеваем, что Laravel растет вместе с
    вами. Если вы только делаете первые шаги в веб-разработке, обширная библиотека документации, руководств и <a
            href="https://laracasts.com/">видеоуроков</a> Laravel поможет вам изучить основы, не перегружая себя.</p>
<p>Если вы старший разработчик, Laravel предоставляет вам надежные инструменты для <a href="container">внедрения
        зависимостей</a> , <a href="testing&">модульного тестирования</a> , <a href="queues">очередей</a> , <a
            href="broadcasting">событий в реальном времени</a> и многого другого. Laravel оптимизирован для создания
    профессиональных веб-приложений и готов обрабатывать корпоративные рабочие нагрузки.</p>
<h4>Масштабируемая структура</h4>
<p>Laravel невероятно масштабируем. Благодаря удобному для масштабирования характеру PHP и встроенной поддержке Laravel
    быстрых распределенных систем кеширования, таких как Redis, горизонтальное масштабирование с помощью Laravel очень
    просто. Фактически, приложения Laravel легко масштабируются для обработки сотен миллионов запросов в месяц.</p>
<p>Требуется экстремальное масштабирование? Такие платформы, как <a href="https://vapor.laravel.com/">Laravel Vapor,</a>
    позволяют запускать приложение Laravel в практически неограниченном масштабе с использованием новейшей бессерверной
    технологии AWS.</p>
<h4>Структура сообщества</h4>
<p>Laravel объединяет лучшие пакеты в экосистеме PHP, чтобы предложить наиболее надежную и удобную для разработчиков
    структуру. Кроме того, тысячи талантливых разработчиков со всего мира <a
            href="https://github.com/laravel/framework">внесли свой вклад в этот фреймворк</a>. Кто знает, возможно, вы
    даже станете участником Laravel.</p>
<p></p>
<h2 id="your-first-laravel-project"><a href="#your-first-laravel-project">Ваш первый проект на Laravel</a></h2>
<p>Мы хотим, чтобы начать работу с Laravel было как можно проще. Существует множество вариантов разработки и запуска
    проекта Laravel на вашем собственном компьютере. Хотя вы, возможно, захотите изучить эти варианты позже, Laravel
    предоставляет <a href="sail">Sail</a> , встроенное решение для запуска вашего проекта Laravel с помощью <a
            href="https://www.docker.com/">Docker</a>.</p>
<p>Docker - это инструмент для запуска приложений и служб в небольших и легких «контейнерах», которые не мешают
    установленному на вашем локальном компьютере программному обеспечению или конфигурации. Это означает, что вам не
    нужно беспокоиться о настройке или настройке сложных инструментов разработки, таких как веб-серверы и базы данных на
    вашем персональном компьютере. Для начала вам нужно всего лишь установить <a
            href="https://www.docker.com/products/docker-desktop">Docker Desktop</a>.</p>
<p>Laravel Sail - это легкий интерфейс командной строки для взаимодействия с конфигурацией Docker по умолчанию для
    Laravel. Sail обеспечивает отличную отправную точку для создания приложения Laravel с использованием PHP, MySQL и
    Redis без предварительного опыта работы с Docker.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Уже являетесь экспертом по Docker? Не волнуйтесь! Все в Sail можно настроить с помощью <code>docker-compose.yml</code> файла,
            включенного в Laravel.</p></p></div>
</blockquote>
<p></p>
<h3 id="getting-started-on-macos"><a href="#getting-started-on-macos">Начало работы в macOS</a></h3>
<p>Если вы разрабатываете на Mac и <a href="https://www.docker.com/products/docker-desktop">Docker Desktop</a> уже
    установлен, вы можете использовать простую команду терминала для создания нового проекта Laravel. Например, чтобы
    создать новое приложение Laravel в каталоге с именем «example-app», вы можете запустить следующую команду в своем
    терминале:</p>
<pre class=" language-nothing"><code
            class=" language-nothing">curl -s https://laravel.build/example-app | bash</code></pre>
<p>Конечно, вы можете изменить "example-app" в этом URL на что угодно. Каталог приложения Laravel будет создан в
    каталоге, из которого вы выполняете команду.</p>
<p>После создания проекта вы можете перейти в каталог приложения и запустить Laravel Sail. Laravel Sail предоставляет
    простой интерфейс командной строки для взаимодействия с конфигурацией Docker по умолчанию в Laravel:</p>
<pre class=" language-nothing"><code class=" language-nothing">cd example-app

./vendor/bin/sail up</code></pre>
<p>При первом запуске <code>up</code> команды Sail на вашем компьютере будут созданы контейнеры приложений Sail. Это
    может занять несколько минут. <strong>Не волнуйтесь, последующие попытки запустить Sail будут намного
        быстрее.</strong></p>
<p>После запуска контейнеров Docker приложения вы можете получить доступ к приложению в своем веб-браузере по адресу: <a
            href="http://localhost/">http://localhost</a>.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Чтобы продолжить узнавать больше о Laravel Sail, просмотрите <a href="sail">полную документацию к нему</a>.
        </p></p></div>
</blockquote>
<p></p>
<h3 id="getting-started-on-windows"><a href="#getting-started-on-windows">Начало работы в Windows</a></h3>
<p>Прежде чем мы создадим новое приложение Laravel на вашем компьютере с Windows, обязательно установите <a
            href="https://www.docker.com/products/docker-desktop">Docker Desktop</a>. Затем вы должны убедиться, что
    подсистема Windows для Linux 2 (WSL2) установлена и включена. WSL позволяет запускать двоичные исполняемые файлы
    Linux изначально в Windows 10. Информацию о том, как установить и включить WSL2, можно найти в <a
            href="https://docs.microsoft.com/en-us/windows/wsl/install-win10">документации по среде разработчика</a>
    Microsoft .</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>После установки и включения WSL2 вы должны убедиться, что Docker Desktop <a
                    href="https://docs.docker.com/docker-for-windows/wsl/">настроен для использования серверной части
                WSL2</a>.</p></p></div>
</blockquote>
<p>Затем вы готовы создать свой первый проект Laravel. Запустите <a
            href="https://www.microsoft.com/en-us/p/windows-terminal/9n0dx20hk701%3Frtc%3D1%26activetab%3Dpivot:overviewtab">Windows
        Terminal</a> и начните новый сеанс терминала для вашей операционной системы WSL2 Linux. Затем вы можете
    использовать простую команду терминала для создания нового проекта Laravel. Например, чтобы создать новое приложение
    Laravel в каталоге с именем «example-app», вы можете запустить следующую команду в своем терминале:</p>
<pre class=" language-nothing"><code
            class=" language-nothing">curl -s https://laravel.build/example-app | bash</code></pre>
<p>Конечно, вы можете изменить "example-app" в этом URL на что угодно. Каталог приложения Laravel будет создан в
    каталоге, из которого вы выполняете команду.</p>
<p>После создания проекта вы можете перейти в каталог приложения и запустить Laravel Sail. Laravel Sail предоставляет
    простой интерфейс командной строки для взаимодействия с конфигурацией Docker по умолчанию в Laravel:</p>
<pre class=" language-nothing"><code class=" language-nothing">cd example-app

./vendor/bin/sail up</code></pre>
<p>При первом запуске <code>up</code> команды Sail на вашем компьютере будут созданы контейнеры приложений Sail. Это
    может занять несколько минут. <strong>Не волнуйтесь, последующие попытки запустить Sail будут намного
        быстрее.</strong></p>
<p>После запуска контейнеров Docker приложения вы можете получить доступ к приложению в своем веб-браузере по адресу: <a
            href="http://localhost/">http://localhost</a>.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Чтобы продолжить узнавать больше о Laravel Sail, просмотрите <a href="sail">полную документацию к нему</a>.
        </p></p></div>
</blockquote>
<h4>Разработка в WSL2</h4>
<p>Конечно, вам нужно будет иметь возможность изменять файлы приложения Laravel, которые были созданы в вашей установке
    WSL2. Для этого мы рекомендуем использовать редактор Microsoft <a href="https://code.visualstudio.com/">Visual
        Studio Code</a> и их собственное расширение для <a
            href="https://marketplace.visualstudio.com/items%3FitemName%3Dms-vscode-remote.vscode-remote-extensionpack">удаленной
        разработки</a>.</p>
<p>После установки этих инструментов вы можете открыть любой проект Laravel, выполнив <code>code .</code> команду из
    корневого каталога вашего приложения с помощью Терминала Windows.</p>
<p></p>
<h3 id="getting-started-on-linux"><a href="#getting-started-on-linux">Начало работы в Linux</a></h3>
<p>Если вы разрабатываете в Linux и <a href="https://www.docker.com/">Docker</a> уже установлен, вы можете использовать
    простую команду терминала для создания нового проекта Laravel. Например, чтобы создать новое приложение Laravel в
    каталоге с именем «example-app», вы можете запустить следующую команду в своем терминале:</p>
<pre class=" language-nothing"><code
            class=" language-nothing">curl -s https://laravel.build/example-app | bash</code></pre>
<p>Конечно, вы можете изменить "example-app" в этом URL на что угодно. Каталог приложения Laravel будет создан в
    каталоге, из которого вы выполняете команду.</p>
<p>После создания проекта вы можете перейти в каталог приложения и запустить Laravel Sail. Laravel Sail предоставляет
    простой интерфейс командной строки для взаимодействия с конфигурацией Docker по умолчанию в Laravel:</p>
<pre class=" language-nothing"><code class=" language-nothing">cd example-app

./vendor/bin/sail up</code></pre>
<p>При первом запуске <code>up</code> команды Sail на вашем компьютере будут созданы контейнеры приложений Sail. Это
    может занять несколько минут. <strong>Не волнуйтесь, последующие попытки запустить Sail будут намного
        быстрее.</strong></p>
<p>После запуска контейнеров Docker приложения вы можете получить доступ к приложению в своем веб-браузере по адресу: <a
            href="http://localhost/">http: // localhost</a>.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Чтобы продолжить узнавать больше о Laravel Sail, просмотрите <a href="sail">полную документацию к нему</a>.
        </p></p></div>
</blockquote>
<p></p>
<h3 id="installation-via-composer"><a href="#installation-via-composer">Установка через Composer</a></h3>
<p>Если на вашем компьютере уже установлены PHP и Composer, вы можете создать новый проект Laravel, используя Composer
    напрямую. После создания приложения вы можете запустить локальный сервер разработки Laravel, используя команду
    Artisan CLI <code>serve</code> :</p>
<pre class=" language-php"><code class=" language-php">composer create<span class="token operator">-</span>project laravel<span
                class="token operator">/</span>laravel example<span class="token operator">-</span>app

cd example<span class="token operator">-</span>app

php artisan serve</code></pre>
<p></p>
<h4 id="the-laravel-installer"><a href="#the-laravel-installer">Установщик Laravel</a></h4>
<p>Или вы можете установить установщик Laravel как глобальную зависимость Composer:</p>
<pre class=" language-nothing"><code class=" language-nothing">composer global require laravel/installer

laravel new example-app

cd example-app

php artisan serve</code></pre>
<p>Обязательно поместите общесистемный каталог bin поставщика Composer в ваш, <code>$PATH</code> чтобы
    <code>laravel</code> исполняемый файл мог быть обнаружен вашей системой. Этот каталог существует в разных местах в
    зависимости от вашей операционной системы; однако некоторые общие местоположения включают:</p>
<div class="content-list">
    <ul>
        <li>macOS: <code>$HOME/.composer/vendor/bin</code></li>
        <li>Windows: <code>%USERPROFILE%\AppData\Roaming\Composer\vendor\bin</code></li>
        <li>Дистрибутивы GNU / Linux:
            <code>$HOME/.config/composer/vendor/bin</code> или<code>$HOME/.composer/vendor/bin</code></li>
    </ul>
</div>
<p></p>
<h2 id="initial-configuration"><a href="#initial-configuration">Начальная конфигурация</a></h2>
<p>Все файлы конфигурации для фреймворка Laravel хранятся в <code>config</code> каталоге. Каждый параметр
    задокументирован, поэтому не стесняйтесь просматривать файлы и знакомиться с доступными вам вариантами.</p>
<p>Laravel практически не требует дополнительной настройки из коробки. Вы можете начать разработку! Однако вы можете
    просмотреть <code>config/app.php</code> файл и его документацию. Он содержит несколько опций, таких как <code>timezone</code> и,
    <code>locale</code> которые вы можете изменить в соответствии с вашим приложением.</p>
<p></p>
<h4 id="environment-configuration"><a href="#environment-configuration">Конфигурация на основе среды</a></h4>
<p>Поскольку многие значения параметров конфигурации Laravel могут различаться в зависимости от того, работает ли ваше
    приложение на локальном компьютере или на рабочем веб-сервере, многие важные значения конфигурации определяются с
    использованием <code>.env</code> файла, который существует в корне вашего приложения.</p>
<p>Ваш <code>.env</code> файл не должен быть привязан к системе контроля версий вашего приложения, поскольку каждому
    разработчику / серверу, использующему ваше приложение, может потребоваться другая конфигурация среды. Более того,
    это будет угрозой безопасности в случае, если злоумышленник получит доступ к вашему репозиторию системы управления
    версиями, поскольку любые конфиденциальные учетные данные будут раскрыты.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Для получения дополнительных сведений о <code>.env</code> конфигурации на основе файлов и среды ознакомьтесь с
            полной <a href="configuration#environment-configuration">документацией по конфигурации</a>.</p></p></div>
</blockquote>
<p></p>
<h2 id="next-steps"><a href="#next-steps">Следующие шаги</a></h2>
<p>Теперь, когда вы создали свой проект Laravel, вам может быть интересно, чему научиться дальше. Во-первых, мы
    настоятельно рекомендуем ознакомиться с тем, как работает Laravel, прочитав следующую документацию:</p>
<div class="content-list">
    <ul>
        <li><a href="lifecycle">Жизненный цикл запроса</a></li>
        <li><a href="configuration">Конфигурация</a></li>
        <li><a href="structure">Структура каталогов</a></li>
        <li><a href="container">Сервисный контейнер</a></li>
        <li><a href="facades">Фасады</a></li>
    </ul>
</div>
<p>То, как вы хотите использовать Laravel, также будет определять следующие шаги на вашем пути. Существует множество
    способов использования Laravel, и мы рассмотрим два основных варианта использования фреймворка ниже.</p>
<p></p>
<h3 id="laravel-the-fullstack-framework"><a href="#laravel-the-fullstack-framework">Laravel - фреймворк Full Stack</a>
</h3>
<p>Laravel может служить полноценным фреймворком. Под «фреймворком полного стека» мы подразумеваем, что вы собираетесь
    использовать Laravel для маршрутизации запросов к вашему приложению и рендеринга вашего интерфейса через <a
            href="blade">шаблоны Blade</a> или с использованием гибридной технологии одностраничного приложения, такой
    как <a href="https://inertiajs.com/">Inertia.js</a>. Это наиболее распространенный способ использования фреймворка
    Laravel.</p>
<p>Если вы планируете использовать Laravel именно таким образом, вы можете ознакомиться с нашей документацией по <a
            href="routing">маршрутизации</a> , <a href="views">представлениям</a> или <a href="eloquent">Eloquent
        ORM</a>. Кроме того, вам может быть интересно узнать о таких пакетах сообщества, как <a
            href="https://laravel-livewire.com/">Livewire</a> и <a href="https://inertiajs.com/">Inertia.js</a>. Эти
    пакеты позволяют использовать Laravel в качестве фреймворка полного стека, обладая при этом многими преимуществами
    пользовательского интерфейса, предоставляемыми одностраничными приложениями JavaScript.</p>
<p>Если вы используете Laravel в качестве фреймворка полного стека, мы также настоятельно рекомендуем вам научиться
    компилировать CSS и JavaScript вашего приложения с помощью <a href="mix">Laravel Mix</a>.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Если вы хотите начать разработку своего приложения, ознакомьтесь с одним из наших официальных <a
                    href="starter-kits">стартовых наборов приложений</a>.</p></p></div>
</blockquote>
<p></p>
<h3 id="laravel-the-api-backend"><a href="#laravel-the-api-backend">Laravel Бэкэнд API</a></h3>
<p>Laravel также может служить серверной частью API для одностраничного приложения JavaScript или мобильного приложения.
    Например, вы можете использовать Laravel в качестве серверной части API для вашего приложения <a
            href="https://nextjs.org/">Next.js. </a>В этом контексте вы можете использовать Laravel для обеспечения <a
            href="sanctum">аутентификации</a> и хранения / извлечения данных для вашего приложения, а также пользуясь
    преимуществами мощных сервисов Laravel, таких как очереди, электронная почта, уведомления и многое другое.</p>
<p>Если вы планируете использовать Laravel именно таким образом, вы можете проверить нашу документацию по <a
            href="routing">маршрутизации</a> , <a href="sanctum">Laravel Sanctum</a> и <a href="eloquent">Eloquent
        ORM</a>.</p>
