<h1>Laravel Dusk</h1>
<ul>
    <li><a href="dusk#introduction">Вступление</a></li>
    <li><a href="dusk#installation">Установка</a>
        <ul>
            <li><a href="dusk#managing-chromedriver-installations">Управление установками ChromeDriver</a></li>
            <li><a href="dusk#using-other-browsers">Использование других браузеров</a></li>
        </ul>
    </li>
    <li><a href="dusk#getting-started">Начиная</a>
        <ul>
            <li><a href="dusk#generating-tests">Создание тестов</a></li>
            <li><a href="dusk#migrations">Перенос базы данных</a></li>
            <li><a href="dusk#running-tests">Запуск тестов</a></li>
            <li><a href="dusk#environment-handling">Обработка окружающей среды</a></li>
        </ul>
    </li>
    <li><a href="dusk#browser-basics">Основы работы с браузером</a>
        <ul>
            <li><a href="dusk#creating-browsers">Создание браузеров</a></li>
            <li><a href="dusk#navigation">Навигация</a></li>
            <li><a href="dusk#resizing-browser-windows">Изменение размера окна браузера</a></li>
            <li><a href="dusk#browser-macros">Макросы браузера</a></li>
            <li><a href="dusk#authentication">Аутентификация</a></li>
            <li><a href="dusk#cookies">Печенье</a></li>
            <li><a href="dusk#executing-javascript">Выполнение JavaScript</a></li>
            <li><a href="dusk#taking-a-screenshot">Снимок экрана</a></li>
            <li><a href="dusk#storing-console-output-to-disk">Сохранение вывода консоли на диск</a></li>
            <li><a href="dusk#storing-page-source-to-disk">Сохранение исходного кода страницы на диск</a></li>
        </ul>
    </li>
    <li><a href="dusk#interacting-with-elements">Взаимодействие с элементами</a>
        <ul>
            <li><a href="dusk#dusk-selectors">Селекторы сумерек</a></li>
            <li><a href="dusk#text-values-and-attributes">Текст, значения и атрибуты</a></li>
            <li><a href="dusk#interacting-with-forms">Взаимодействие с формами</a></li>
            <li><a href="dusk#attaching-files">Прикрепление файлов</a></li>
            <li><a href="dusk#pressing-buttons">Нажатие кнопок</a></li>
            <li><a href="dusk#clicking-links">Щелчок по ссылкам</a></li>
            <li><a href="dusk#using-the-keyboard">Использование клавиатуры</a></li>
            <li><a href="dusk#using-the-mouse">Использование мыши</a></li>
            <li><a href="dusk#javascript-dialogs">Диалоги JavaScript</a></li>
            <li><a href="dusk#scoping-selectors">Селекторы области видимости</a></li>
            <li><a href="dusk#waiting-for-elements">В ожидании элементов</a></li>
            <li><a href="dusk#scrolling-an-element-into-view">Прокрутка элемента в представление</a></li>
        </ul>
    </li>
    <li><a href="dusk#available-assertions">Доступные утверждения</a></li>
    <li><a href="dusk#pages">Страницы</a>
        <ul>
            <li><a href="dusk#generating-pages">Создание страниц</a></li>
            <li><a href="dusk#configuring-pages">Настройка страниц</a></li>
            <li><a href="dusk#navigating-to-pages">Переход к страницам</a></li>
            <li><a href="dusk#shorthand-selectors">Сокращенные селекторы</a></li>
            <li><a href="dusk#page-methods">Методы страницы</a></li>
        </ul>
    </li>
    <li><a href="dusk#components">Составные части</a>
        <ul>
            <li><a href="dusk#generating-components">Создание компонентов</a></li>
            <li><a href="dusk#using-components">Использование компонентов</a></li>
        </ul>
    </li>
    <li><a href="dusk#continuous-integration">Непрерывная интеграция</a>
        <ul>
            <li><a href="dusk#running-tests-on-heroku-ci">Heroku CI</a></li>
            <li><a href="dusk#running-tests-on-travis-ci">Travis CI</a></li>
            <li><a href="dusk#running-tests-on-github-actions">Действия GitHub</a></li>
        </ul>
    </li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Laravel Dusk предоставляет выразительный, простой в использовании API для автоматизации и тестирования браузера. По
    умолчанию Dusk не требует установки JDK или Selenium на ваш локальный компьютер. Вместо этого Dusk использует
    автономную установку <a href="https://sites.google.com/a/chromium.org/chromedriver/home">ChromeDriver</a>. Однако вы
    можете использовать любой другой драйвер, совместимый с Selenium, который пожелаете.</p>
<p></p>
<h2 id="installation"><a href="#installation">Установка</a></h2>
<p>Для начала вы должны добавить в <code>laravel/dusk</code> свой проект зависимость Composer:</p>
<pre class=" language-php"><code class=" language-php">composer <span class="token keyword">require</span> <span
                class="token operator">--</span>dev laravel<span class="token operator">/</span>dusk</code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Если вы вручную регистрируете поставщика услуг Dusk, вам <strong>никогда не</strong> следует регистрировать
            его в производственной среде, поскольку это может привести к тому, что произвольные пользователи смогут
            пройти аутентификацию в вашем приложении.</p></p></div>
</blockquote>
<p>После установки пакета Dusk выполните команду <code>dusk:install</code> Artisan. Команда <code>dusk:install</code>
    создаст <code>tests/Browser</code> каталог и пример теста Dusk:</p>
<pre class=" language-php"><code class=" language-php">php artisan dusk<span
                class="token punctuation">:</span>install</code></pre>
<p>Затем установите <code>APP_URL</code> переменную среды в <code>.env</code> файле вашего приложения. Это значение
    должно соответствовать URL-адресу, который вы используете для доступа к вашему приложению в браузере.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Если вы используете <a href="sail">Laravel Sail</a> для управления локальной средой разработки, ознакомьтесь
            также с документацией Sail по <a href="sail#laravel-dusk">настройке и запуску тестов Dusk</a>.</p></p></div>
</blockquote>
<p></p>
<h3 id="managing-chromedriver-installations"><a href="#managing-chromedriver-installations">Управление установками
        ChromeDriver</a></h3>
<p>Если вы хотите установить версию ChromeDriver, отличную от той, которая включена в Laravel Dusk, вы можете
    использовать <code>dusk:chrome-driver</code> команду:</p>
<pre class=" language-php"><code class=" language-php"><span class="token shell-comment comment"># Install the latest version of ChromeDriver for your OS...</span>
php artisan dusk<span class="token punctuation">:</span>chrome<span class="token operator">-</span>driver

<span class="token shell-comment comment"># Install a given version of ChromeDriver for your OS...</span>
php artisan dusk<span class="token punctuation">:</span>chrome<span class="token operator">-</span>driver <span
                class="token number">86</span>

<span class="token shell-comment comment"># Install a given version of ChromeDriver for all supported OSs...</span>
php artisan dusk<span class="token punctuation">:</span>chrome<span class="token operator">-</span>driver <span
                class="token operator">--</span>all

<span class="token shell-comment comment"># Install the version of ChromeDriver that matches the detected version of Chrome / Chromium for your OS...</span>
php artisan dusk<span class="token punctuation">:</span>chrome<span class="token operator">-</span>driver <span
                class="token operator">--</span>detect</code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Dusk требует, чтобы <code>chromedriver</code> двоичные файлы были исполняемыми. Если у вас возникли проблемы
            с запуском Dusk, вы должны убедиться, что исполняемые файлы являются исполняемыми с помощью следующей
            команды: <code>chmod -R 0755 vendor/laravel/dusk/bin/</code>.</p></p></div>
</blockquote>
<p></p>
<h3 id="using-other-browsers"><a href="#using-other-browsers">Использование других браузеров</a></h3>
<p>По умолчанию Dusk использует Google Chrome и автономную установку <a
            href="https://sites.google.com/a/chromium.org/chromedriver/home">ChromeDriver</a> для запуска тестов вашего
    браузера. Однако вы можете запустить свой собственный сервер Selenium и запускать тесты в любом браузере по вашему
    желанию.</p>
<p>Для начала откройте <code>tests/DuskTestCase.php</code> файл, который является базовым тестовым примером Dusk для
    вашего приложения. В этом файле вы можете удалить вызов <code>startChromeDriver</code> метода. Это остановит Dusk от
    автоматического запуска ChromeDriver:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Prepare for Dusk test execution.
 *
 * @beforeClass
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">static</span> <span
                class="token keyword">function</span> <span class="token function">prepare</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// static::startChromeDriver();</span>
<span class="token punctuation">}</span></code></pre>
<p>Затем вы можете изменить <code>driver</code> метод подключения к URL-адресу и порту по вашему выбору. Кроме того, вы
    можете изменить «желаемые возможности», которые следует передать WebDriver:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Create the RemoteWebDriver instance.
 *
 * @return \Facebook\WebDriver\Remote\RemoteWebDriver
 */</span>
<span class="token keyword">protected</span> <span class="token keyword">function</span> <span class="token function">driver</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> RemoteWebDriver<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">create</span><span
                class="token punctuation">(</span>
        <span class="token single-quoted-string string">'http://localhost:4444/wd/hub'</span><span
                class="token punctuation">,</span> DesiredCapabilities<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">phantomjs</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h2 id="getting-started"><a href="#getting-started">Начиная</a></h2>
<p></p>
<h3 id="generating-tests"><a href="#generating-tests">Создание тестов</a></h3>
<p>Чтобы сгенерировать тест Dusk, используйте команду <code>dusk:make</code> Artisan. Сгенерированный тест будет помещен
    в <code>tests/Browser</code> каталог:</p>
<pre class=" language-php"><code class=" language-php">php artisan dusk<span class="token punctuation">:</span>make LoginTest</code></pre>
<p></p>
<h3 id="migrations"><a href="#migrations">Перенос базы данных</a></h3>
<p>Большинство тестов, которые вы пишете, будут взаимодействовать со страницами, которые извлекают данные из базы данных
    вашего приложения; тем не менее, ваши тесты Dusk никогда не должны использовать эту <code>RefreshDatabase</code>
    черту. Эта <code>RefreshDatabase</code> черта использует транзакции базы данных, которые не будут применяться или
    доступны через HTTP-запросы. Вместо этого используйте <code>DatabaseMigrations</code> трейт, который повторно
    переносит базу данных для каждого теста:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">Tests<span class="token punctuation">\</span>Browser</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Testing<span class="token punctuation">\</span>DatabaseMigrations</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Laravel<span
                        class="token punctuation">\</span>Dusk<span class="token punctuation">\</span>Chrome</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Tests<span class="token punctuation">\</span>DuskTestCase</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ExampleTest</span> <span class="token keyword">extends</span> <span
                    class="token class-name">DuskTestCase</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">use</span> <span class="token package">DatabaseMigrations</span><span
                    class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Базы данных SQLite в памяти нельзя использовать при выполнении тестов Dusk. Поскольку браузер выполняет свой
            собственный процесс, он не сможет получить доступ к базам данных других процессов в памяти.</p></p></div>
</blockquote>
<p></p>
<h3 id="running-tests"><a href="#running-tests">Запуск тестов</a></h3>
<p>Чтобы запустить тесты браузера, выполните <code>dusk</code> Artisan-команду:</p>
<pre class=" language-php"><code class=" language-php">php artisan dusk</code></pre>
<p>Если при последнем <code>dusk</code> запуске команды у вас были ошибки тестирования, вы можете сэкономить время,
    повторно запустив сначала неудачные тесты с помощью <code>dusk:fails</code> команды:</p>
<pre class=" language-php"><code class=" language-php">php artisan dusk<span
                class="token punctuation">:</span>fails</code></pre>
<p>Команда <code>dusk</code> принимает любой аргумент, который обычно принимается средством запуска тестов PHPUnit,
    например, позволяющий запускать тесты только для данной <a
            href="https://phpunit.de/manual/current/en/appendixes.annotations.html%23appendixes.annotations.group">группы</a>:
</p>
<pre class=" language-php"><code class=" language-php">php artisan dusk <span class="token operator">--</span>group<span
                class="token operator">=</span>foo</code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Если вы используете <a href="sail">Laravel Sail</a> для управления локальной средой разработки, обратитесь к
            документации Sail по <a href="sail#laravel-dusk">настройке и запуску тестов Dusk</a>.</p></p></div>
</blockquote>
<p></p>
<h4 id="manually-starting-chromedriver"><a href="#manually-starting-chromedriver">Запуск ChromeDriver вручную</a></h4>
<p>По умолчанию Dusk автоматически пытается запустить ChromeDriver. Если это не работает для вашей конкретной системы,
    вы можете вручную запустить ChromeDriver перед выполнением <code>dusk</code> команды. Если вы решили запустить
    ChromeDriver вручную, закомментируйте следующую строку <code>tests/DuskTestCase.php</code> файла:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Prepare for Dusk test execution.
 *
 * @beforeClass
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">static</span> <span
                class="token keyword">function</span> <span class="token function">prepare</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// static::startChromeDriver();</span>
<span class="token punctuation">}</span></code></pre>
<p>Кроме того, если вы запускаете ChromeDriver на порту, отличном от 9515, вам следует изменить <code>driver</code>
    метод того же класса, чтобы отразить правильный порт:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Create the RemoteWebDriver instance.
 *
 * @return \Facebook\WebDriver\Remote\RemoteWebDriver
 */</span>
<span class="token keyword">protected</span> <span class="token keyword">function</span> <span class="token function">driver</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> RemoteWebDriver<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">create</span><span
                class="token punctuation">(</span>
        <span class="token single-quoted-string string">'http://localhost:9515'</span><span
                class="token punctuation">,</span> DesiredCapabilities<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">chrome</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="environment-handling"><a href="#environment-handling">Обработка окружающей среды</a></h3>
<p>Чтобы заставить Dusk использовать собственный файл среды при запуске тестов, создайте
    <code>.env.dusk.{literal}{environment}{/literal}</code> файл в корне вашего проекта. Например, если вы будете запускать
    <code>dusk</code> команду из своей <code>local</code> среды, вам следует создать <code>.env.dusk.local</code> файл.
</p>
<p>При запуске тестов Dusk создаст резервную копию вашего <code>.env</code> файла и переименует вашу среду Dusk в <code>.env</code>.
    После завершения тестов ваш <code>.env</code> файл будет восстановлен.</p>
<p></p>
<h2 id="browser-basics"><a href="#browser-basics">Основы работы с браузером</a></h2>
<p></p>
<h3 id="creating-browsers"><a href="#creating-browsers">Создание браузеров</a></h3>
<p>Для начала давайте напишем тест, который проверяет, можем ли мы войти в наше приложение. После создания теста мы
    можем изменить его, чтобы перейти на страницу входа, ввести некоторые учетные данные и нажать кнопку «Войти». Чтобы
    создать экземпляр браузера, вы можете вызвать <code>browse</code> метод из своего теста Dusk:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">Tests<span class="token punctuation">\</span>Browser</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Testing<span class="token punctuation">\</span>DatabaseMigrations</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Laravel<span
                        class="token punctuation">\</span>Dusk<span class="token punctuation">\</span>Chrome</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Tests<span class="token punctuation">\</span>DuskTestCase</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ExampleTest</span> <span class="token keyword">extends</span> <span
                    class="token class-name">DuskTestCase</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">use</span> <span class="token package">DatabaseMigrations</span><span
                    class="token punctuation">;</span>

    <span class="token comment">/**
     * A basic browser test example.
     *
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">test_basic_example</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$user</span> <span class="token operator">=</span> User<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token function">factory</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">create</span><span
                    class="token punctuation">(</span><span class="token punctuation">[</span>
            <span class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token single-quoted-string string">'taylor@laravel.com'</span><span
                    class="token punctuation">,</span>
        <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>

        <span class="token variable">$this</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">browse</span><span
                    class="token punctuation">(</span><span class="token keyword">function</span> <span
                    class="token punctuation">(</span><span class="token variable">$browser</span><span
                    class="token punctuation">)</span> <span class="token keyword">use</span> <span
                    class="token punctuation">(</span><span class="token variable">$user</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token variable">$browser</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">visit</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'/login'</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">type</span><span class="token punctuation">(</span><span
                    class="token single-quoted-string string">'email'</span><span
                    class="token punctuation">,</span> <span class="token variable">$user</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">email</span><span
                    class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">type</span><span class="token punctuation">(</span><span
                    class="token single-quoted-string string">'password'</span><span class="token punctuation">,</span> <span
                    class="token single-quoted-string string">'password'</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">press</span><span class="token punctuation">(</span><span
                    class="token single-quoted-string string">'Login'</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertPathIs</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'/home'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Как видно из приведенного выше примера, <code>browse</code> метод принимает закрытие. Экземпляр браузера будет
    автоматически передан в это закрытие Dusk и является основным объектом, используемым для взаимодействия с вашим
    приложением и создания утверждений против него.</p>
<p></p>
<h4 id="creating-multiple-browsers"><a href="#creating-multiple-browsers">Создание нескольких браузеров</a></h4>
<p>Иногда для правильного проведения теста может потребоваться несколько браузеров. Например, для тестирования экрана
    чата, взаимодействующего с веб-сокетами, может потребоваться несколько браузеров. Чтобы создать несколько браузеров,
    просто добавьте больше аргументов браузера к сигнатуре закрытия, данной <code>browse</code> методу:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">browse</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$first</span><span
                class="token punctuation">,</span> <span class="token variable">$second</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$first</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">loginAs</span><span class="token punctuation">(</span>User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">visit</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/home'</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">waitForText</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Message'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
            
    <span class="token variable">$second</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">loginAs</span><span
                class="token punctuation">(</span>User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">2</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">visit</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/home'</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">waitForText</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Message'</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">type</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'message'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Hey Taylor'</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">press</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Send'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
            
    <span class="token variable">$first</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">waitForText</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Hey Taylor'</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSee</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'Jeffrey Way'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="navigation"><a href="#navigation">Навигация</a></h3>
<p>Этот <code>visit</code> метод может использоваться для перехода к заданному URI в вашем приложении:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">visit</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/login'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете использовать этот <code>visitRoute</code> метод для перехода к <a href="routing#named-routes">именованному
        маршруту</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">visitRoute</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'login'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете перейти «назад» и «вперед», используя <code>back</code> и <code>forward</code> методы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">back</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">forward</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы можете использовать <code>refresh</code> метод для обновления страницы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">refresh</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="resizing-browser-windows"><a href="#resizing-browser-windows">Изменение размера окна браузера</a></h3>
<p>Вы можете использовать этот <code>resize</code> метод для настройки размера окна браузера:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">resize</span><span
                class="token punctuation">(</span><span class="token number">1920</span><span class="token punctuation">,</span> <span
                class="token number">1080</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Этот <code>maximize</code> метод можно использовать для увеличения окна браузера:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">maximize</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p><code>fitContent</code> Метод будет изменять размеры окна браузера, чтобы соответствовать размеру его содержания:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">fitContent</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Когда тест не проходит, Dusk автоматически изменяет размер браузера в соответствии с содержимым, прежде чем делать
    снимок экрана. Вы можете отключить эту функцию, вызвав <code>disableFitOnFailure</code> метод в своем тесте:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">disableFitOnFailure</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы можете использовать этот <code>move</code> метод, чтобы переместить окно браузера в другое место на экране:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">move</span><span class="token punctuation">(</span><span class="token variable">$x</span> <span
                class="token operator">=</span> <span class="token number">100</span><span
                class="token punctuation">,</span> <span class="token variable">$y</span> <span
                class="token operator">=</span> <span class="token number">100</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="browser-macros"><a href="#browser-macros">Макросы браузера</a></h3>
<p>Если вы хотите определить собственный метод браузера, который вы можете повторно использовать в различных тестах, вы
    можете использовать этот <code>macro</code> метод в <code>Browser</code> классе. Как правило, этот метод следует
    вызывать из метода <a href="providers">поставщика услуг</a> <code>boot</code> :</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Providers</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>ServiceProvider</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Laravel<span
                        class="token punctuation">\</span>Dusk<span
                        class="token punctuation">\</span>Browser</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">DuskServiceProvider</span> <span
                    class="token keyword">extends</span> <span class="token class-name">ServiceProvider</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Register Dusk's browser macros.
     *
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">boot</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        Browser<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">macro</span><span class="token punctuation">(</span><span
                    class="token single-quoted-string string">'scrollToElement'</span><span
                    class="token punctuation">,</span> <span class="token keyword">function</span> <span
                    class="token punctuation">(</span><span class="token variable">$element</span> <span
                    class="token operator">=</span> <span class="token constant">null</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">script</span><span class="token punctuation">(</span><span
                    class="token double-quoted-string string">"$('html, body').animate({ scrollTop: $('<span
                        class="token interpolation"><span class="token variable">$element</span></span>').offset().top }, 0);"</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

            <span class="token keyword">return</span> <span class="token variable">$this</span><span
                    class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p><code>macro</code> Функция принимает имя в качестве первого аргумента, и закрытие в качестве второго. Закрытие
    макроса будет выполнено при вызове макроса как метода в <code>Browser</code> экземпляре:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">browse</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$browser</span><span
                class="token punctuation">)</span> <span class="token keyword">use</span> <span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">visit</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/pay'</span><span
                class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">scrollToElement</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'#credit-card-details'</span><span
                class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSee</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Enter Credit Card Details'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="authentication"><a href="#authentication">Аутентификация</a></h3>
<p>Часто вы будете тестировать страницы, требующие аутентификации. Вы можете использовать <code>loginAs</code> метод
    Dusk, чтобы избежать взаимодействия с экраном входа в систему вашего приложения во время каждого теста. <code>loginAs</code>
    Метод принимает первичный ключ, связанный с вашей моделью или его подлинности экземпляра модели его подлинности:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

<span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">browse</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$browser</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">loginAs</span><span
                class="token punctuation">(</span>User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span>
          <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">visit</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/home'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>После использования <code>loginAs</code> метода сеанс пользователя будет поддерживаться для всех тестов в
            файле.</p></p></div>
</blockquote>
<p></p>
<h3 id="cookies"><a href="#cookies">Печенье</a></h3>
<p>Вы можете использовать этот <code>cookie</code> метод для получения или установки значения зашифрованного файла
    cookie. По умолчанию все файлы cookie, созданные Laravel, зашифрованы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">cookie</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">cookie</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'Taylor'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете использовать этот <code>plainCookie</code> метод для получения или установки значения незашифрованного
    файла cookie:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">plainCookie</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">plainCookie</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'Taylor'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете использовать <code>deleteCookie</code> метод для удаления данного файла cookie:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">deleteCookie</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="executing-javascript"><a href="#executing-javascript">Выполнение JavaScript</a></h3>
<p>Вы можете использовать этот <code>script</code> метод для выполнения произвольных операторов JavaScript в браузере:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$output</span> <span
                class="token operator">=</span> <span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">script</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'document.documentElement.scrollTop = 0'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$output</span> <span class="token operator">=</span> <span
                class="token variable">$browser</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">script</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span>
    <span class="token single-quoted-string string">'document.body.scrollTop = 0'</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'document.documentElement.scrollTop = 0'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="taking-a-screenshot"><a href="#taking-a-screenshot">Снимок экрана</a></h3>
<p>Вы можете использовать этот <code>screenshot</code> метод, чтобы сделать снимок экрана и сохранить его с указанным
    именем файла. Все скриншоты будут храниться в <code>tests/Browser/screenshots</code> каталоге:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">screenshot</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'filename'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="storing-console-output-to-disk"><a href="#storing-console-output-to-disk">Сохранение вывода консоли на диск</a>
</h3>
<p>Вы можете использовать этот <code>storeConsoleLog</code> метод для записи вывода консоли текущего браузера на диск с
    заданным именем файла. Вывод консоли будет храниться в <code>tests/Browser/console</code> каталоге:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">storeConsoleLog</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'filename'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="storing-page-source-to-disk"><a href="#storing-page-source-to-disk">Сохранение исходного кода страницы на
        диск</a></h3>
<p>Вы можете использовать этот <code>storeSource</code> метод для записи исходного кода текущей страницы на диск с
    заданным именем файла. Исходный код страницы будет храниться в <code>tests/Browser/source</code> каталоге:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">storeSource</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'filename'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="interacting-with-elements"><a href="#interacting-with-elements">Взаимодействие с элементами</a></h2>
<p></p>
<h3 id="dusk-selectors"><a href="#dusk-selectors">Селекторы сумерек</a></h3>
<p>Выбор хороших селекторов CSS для взаимодействия с элементами - одна из самых сложных частей при написании тестов
    Dusk. Со временем изменения внешнего интерфейса могут привести к тому, что селекторы CSS, подобные приведенным ниже,
    нарушат ваши тесты:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">// HTML...</span>

<span class="token operator">&lt;</span>button<span class="token operator">&gt;</span>Login<span class="token operator">&lt;</span><span
                class="token operator">/</span>button<span class="token operator">&gt;</span>

<span class="token comment">// Test...</span>

<span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">click</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'.login-page.container div &gt; button'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Селекторы сумерек позволяют сосредоточиться на написании эффективных тестов, а не на запоминании селекторов CSS.
    Чтобы определить селектор, добавьте <code>dusk</code> атрибут в свой HTML-элемент. Затем при взаимодействии с
    браузером Dusk добавьте к селектору префикс, <code>@</code> чтобы управлять присоединенным элементом в вашем тесте:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">// HTML...</span>

<span class="token operator">&lt;</span>button dusk<span class="token operator">=</span><span
                class="token double-quoted-string string">"login-button"</span><span class="token operator">&gt;</span>Login<span
                class="token operator">&lt;</span><span class="token operator">/</span>button<span
                class="token operator">&gt;</span>

<span class="token comment">// Test...</span>

<span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">click</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'@login-button'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="text-values-and-attributes"><a href="#text-values-and-attributes">Текст, значения и атрибуты</a></h3>
<p></p>
<h4 id="retrieving-setting-values"><a href="#retrieving-setting-values">Получение и установка значений</a></h4>
<p>Dusk предоставляет несколько методов для взаимодействия с текущим значением, отображаемым текстом и атрибутами
    элементов на странице. Например, чтобы получить «значение» элемента, которое соответствует заданному селектору CSS
    или Dusk, используйте <code>value</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">// Retrieve the value...</span>
<span class="token variable">$value</span> <span class="token operator">=</span> <span
                class="token variable">$browser</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">value</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'selector'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// Set the value...</span>
<span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">value</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'selector'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'value'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете использовать этот <code>inputValue</code> метод, чтобы получить «значение» элемента ввода с заданным именем
    поля:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$value</span> <span
                class="token operator">=</span> <span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">inputValue</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'field'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="retrieving-text"><a href="#retrieving-text">Получение текста</a></h4>
<p><code>text</code> Способ может быть использован для получения отображения текста элемента, который соответствует
    данному селектору:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$text</span> <span
                class="token operator">=</span> <span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">text</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'selector'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="retrieving-attributes"><a href="#retrieving-attributes">Получение атрибутов</a></h4>
<p>Наконец, этот <code>attribute</code> метод можно использовать для получения значения атрибута элемента,
    соответствующего данному селектору:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$attribute</span> <span
                class="token operator">=</span> <span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">attribute</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'selector'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'value'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="interacting-with-forms"><a href="#interacting-with-forms">Взаимодействие с формами</a></h3>
<p></p>
<h4 id="typing-values"><a href="#typing-values">Ввод значений</a></h4>
<p>Dusk предоставляет множество методов для взаимодействия с формами и элементами ввода. Во-первых, давайте взглянем на
    пример ввода текста в поле ввода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">type</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'email'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'taylor@laravel.com'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Обратите внимание, что хотя метод при необходимости принимает его, нам не требуется передавать селектор CSS в <code>type</code>
    метод. Если селектор CSS не указан, Dusk будет искать поле <code>input</code> или <code>textarea</code> с заданным
    <code>name</code> атрибутом.</p>
<p>Чтобы добавить текст в поле, не очищая его содержимое, вы можете использовать <code>append</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">type</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'tags'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'foo'</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">append</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'tags'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">', bar, baz'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете очистить значение ввода, используя <code>clear</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">clear</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'email'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете указать Dusk печатать медленно, используя этот <code>typeSlowly</code> метод. По умолчанию Dusk будет
    делать паузу на 100 миллисекунд между нажатиями клавиш. Чтобы настроить время между нажатиями клавиш, вы можете
    передать соответствующее количество миллисекунд в качестве третьего аргумента метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">typeSlowly</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'mobile'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'+1 (202) 555-5555'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">typeSlowly</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'mobile'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'+1 (202) 555-5555'</span><span
                class="token punctuation">,</span> <span class="token number">300</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы можете использовать этот <code>appendSlowly</code> метод для медленного добавления текста:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">type</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'tags'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'foo'</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">appendSlowly</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'tags'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">', bar, baz'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="dropdowns"><a href="#dropdowns">Выпадающие списки</a></h4>
<p>Чтобы выбрать значение, доступное для <code>select</code> элемента, вы можете использовать <code>select</code> метод.
    Как и <code>type</code> метод, для <code>select</code> метода не требуется полный селектор CSS. При передаче
    значения <code>select</code> методу вы должны передать базовое значение параметра вместо отображаемого текста:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">select</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'size'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'Large'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете выбрать случайный вариант, опуская второй аргумент:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">select</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'size'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="checkboxes"><a href="#checkboxes">Флажки</a></h4>
<p>Чтобы «отметить» ввод флажка, вы можете использовать <code>check</code> метод. Как и для многих других методов,
    связанных с вводом, полный селектор CSS не требуется. Если совпадение селектора CSS не найдено, Dusk будет искать
    флажок с соответствующим <code>name</code> атрибутом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">check</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'terms'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p><code>uncheck</code> Метод может быть использован для «снимите флажок» вход флажок:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">uncheck</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'terms'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="radio-buttons"><a href="#radio-buttons">Радио-кнопки</a></h4>
<p>Чтобы «выбрать» <code>radio</code> вариант ввода, вы можете использовать <code>radio</code> метод. Как и многие
    другие методы, связанные с вводом, полный селектор CSS не требуется. Если совпадение селектора CSS не может быть
    найдено, Dusk будет искать <code>radio</code> ввод с соответствием <code>name</code> и <code>value</code>
    атрибутами:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">radio</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'size'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'large'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="attaching-files"><a href="#attaching-files">Прикрепление файлов</a></h3>
<p><code>attach</code> Метод может быть использован, чтобы прикрепить файл к <code>file</code> входному элементу. Как и
    для многих других методов, связанных с вводом, полный селектор CSS не требуется. Если совпадение селектора CSS не
    может быть найдено, Dusk будет искать <code>file</code> вход с соответствующим <code>name</code> атрибутом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">attach</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'photo'</span><span
                class="token punctuation">,</span> <span class="token constant">__DIR__</span><span
                class="token punctuation">.</span><span class="token single-quoted-string string">'/photos/mountains.png'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Функция присоединения требует, <code>Zip</code> чтобы на вашем сервере было установлено и включено расширение
            PHP.</p></p></div>
</blockquote>
<p></p>
<h3 id="pressing-buttons"><a href="#pressing-buttons">Нажатие кнопок</a></h3>
<p><code>press</code> Метод может быть использован, чтобы нажать на кнопку элемент на странице. Первым аргументом,
    передаваемым <code>press</code> методу, может быть либо отображаемый текст кнопки, либо селектор CSS / Dusk:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">press</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Login'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>При отправке форм многие приложения отключают кнопку отправки формы после ее нажатия, а затем снова включают кнопку,
    когда HTTP-запрос отправки формы завершен. Чтобы нажать кнопку и дождаться повторного включения кнопки, вы можете
    использовать <code>pressAndWaitFor</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">// Press the button and wait a maximum of 5 seconds for it to be enabled...</span>
<span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">pressAndWaitFor</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Save'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// Press the button and wait a maximum of 1 second for it to be enabled...</span>
<span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">pressAndWaitFor</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Save'</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="clicking-links"><a href="#clicking-links">Щелчок по ссылкам</a></h3>
<p>Чтобы щелкнуть ссылку, вы можете использовать <code>clickLink</code> метод в экземпляре браузера.
    <code>clickLink</code> Метод будет нажать на ссылку, которая имеет данный текст дисплея:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">clickLink</span><span
                class="token punctuation">(</span><span class="token variable">$linkText</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете использовать этот <code>seeLink</code> метод, чтобы определить, видна ли на странице ссылка с заданным
    отображаемым текстом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">if</span> <span
                class="token punctuation">(</span><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">seeLink</span><span
                class="token punctuation">(</span><span class="token variable">$linkText</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//...</span>
<span class="token punctuation">}</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Эти методы взаимодействуют с jQuery. Если jQuery недоступен на странице, Dusk автоматически вставит его на
            страницу, чтобы он был доступен на время теста.</p></p></div>
</blockquote>
<p></p>
<h3 id="using-the-keyboard"><a href="#using-the-keyboard">Использование клавиатуры</a></h3>
<p>Этот <code>keys</code> метод позволяет вам предоставить более сложные входные последовательности для данного
    элемента, чем обычно позволяет <code>type</code> метод. Например, вы можете указать Dusk удерживать
    клавиши-модификаторы при вводе значений. В этом примере <code>shift</code> ключ будет удерживаться при
    <code>taylor</code> вводе в элемент, соответствующий данному селектору. После <code>taylor</code> ввода
    <code>swift</code> будет набрано без каких-либо клавиш-модификаторов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">keys</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'selector'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'{literal}{shift}{/literal}'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'taylor'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'swift'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Другой ценный вариант использования <code>keys</code> метода - это отправка комбинации «горячих клавиш» в основной
    селектор CSS для вашего приложения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">keys</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'.app'</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span><span
                class="token single-quoted-string string">'{literal}{command}{/literal}'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'j'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Все ключи-модификаторы, такие как <code>command</code>, заключены в <code>{literal}{}{/literal}</code>
            символы и соответствуют константам, определенным в классе <code>Facebook\WebDriver\WebDriverKeys</code>,
            который можно найти на <a href="https://github.com/php-webdriver/php-webdriver/blob/master/lib/WebDriverKeys.php">GitHub</a>.</p></p></div>
</blockquote>
<p></p>
<h3 id="using-the-mouse"><a href="#using-the-mouse">Использование мыши</a></h3>
<p></p>
<h4 id="clicking-on-elements"><a href="#clicking-on-elements">Щелчок по элементам</a></h4>
<p><code>click</code> Метод может быть использован, чтобы нажать на элемент согласования данного CSS или селектор Dusk:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">click</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'.selector'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p><code>clickAtXPath</code> Метод может быть использован, чтобы нажать на элементе, соответствующий заданное выражение
    XPath:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">clickAtXPath</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'//div[@class = "selector"]'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Этот <code>clickAtPoint</code> метод может использоваться для щелчка по самому верхнему элементу с заданной парой
    координат относительно видимой области браузера:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">clickAtPoint</span><span
                class="token punctuation">(</span><span class="token variable">$x</span> <span
                class="token operator">=</span> <span class="token number">0</span><span
                class="token punctuation">,</span> <span class="token variable">$y</span> <span
                class="token operator">=</span> <span class="token number">0</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p><code>doubleClick</code> Метод может быть использован для имитации двойной щелчок мыши:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">doubleClick</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p><code>rightClick</code> Метод может быть использован для имитации щелчка правой мыши:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">rightClick</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">rightClick</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'.selector'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Этот <code>clickAndHold</code> метод может использоваться для имитации нажатия и удержания кнопки мыши. Последующий
    вызов <code>releaseMouse</code> метода отменяет это поведение и отпускает кнопку мыши:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">clickAndHold</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">pause</span><span class="token punctuation">(</span><span class="token number">1000</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">releaseMouse</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="mouseover"><a href="#mouseover">Наведение мыши</a></h4>
<p><code>mouseover</code> Метод может быть использован, когда вам нужно переместить курсор к элементу, соответствующему
    заданному CSS или селектор Dusk:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">mouseover</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'.selector'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="drag-drop"><a href="#drag-drop">Перетаскивания</a></h4>
<p><code>drag</code> Метод может быть использован, чтобы перетащить элемент, соответствующий заданный селектор к другому
    элементу:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">drag</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'.from-selector'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'.to-selector'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Или вы можете перетащить элемент в одном направлении:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">dragLeft</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'.selector'</span><span
                class="token punctuation">,</span> <span class="token variable">$pixels</span> <span
                class="token operator">=</span> <span class="token number">10</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">dragRight</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'.selector'</span><span
                class="token punctuation">,</span> <span class="token variable">$pixels</span> <span
                class="token operator">=</span> <span class="token number">10</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">dragUp</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'.selector'</span><span
                class="token punctuation">,</span> <span class="token variable">$pixels</span> <span
                class="token operator">=</span> <span class="token number">10</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">dragDown</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'.selector'</span><span
                class="token punctuation">,</span> <span class="token variable">$pixels</span> <span
                class="token operator">=</span> <span class="token number">10</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Наконец, вы можете перетащить элемент на заданное смещение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">dragOffset</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'.selector'</span><span
                class="token punctuation">,</span> <span class="token variable">$x</span> <span
                class="token operator">=</span> <span class="token number">10</span><span
                class="token punctuation">,</span> <span class="token variable">$y</span> <span
                class="token operator">=</span> <span class="token number">10</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="javascript-dialogs"><a href="#javascript-dialogs">Диалоги JavaScript</a></h3>
<p>Dusk предоставляет различные методы для взаимодействия с диалогами JavaScript. Например, вы можете использовать этот
    <code>waitForDialog</code> метод, чтобы дождаться появления диалогового окна JavaScript. Этот метод принимает
    необязательный аргумент, указывающий, сколько секунд ждать появления диалогового окна:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">waitForDialog</span><span
                class="token punctuation">(</span><span class="token variable">$seconds</span> <span
                class="token operator">=</span> <span class="token constant">null</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p><code>assertDialogOpened</code> Метод может быть использован для утверждают, что это диалоговое окно и содержит
    данное сообщение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertDialogOpened</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'Dialog message'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если диалоговое окно JavaScript содержит приглашение, вы можете использовать этот <code>typeInDialog</code> метод для
    ввода значения в приглашение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">typeInDialog</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'Hello World'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Чтобы закрыть открытое диалоговое окно JavaScript, нажав кнопку «ОК», вы можете вызвать <code>acceptDialog</code>
    метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">acceptDialog</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Чтобы закрыть открытый диалог JavaScript, нажав кнопку «Отмена», вы можете вызвать <code>dismissDialog</code> метод:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">dismissDialog</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="scoping-selectors"><a href="#scoping-selectors">Селекторы области видимости</a></h3>
<p>Иногда вы можете захотеть выполнить несколько операций, просматривая все операции в рамках данного селектора.
    Например, вы можете утверждать, что некоторый текст существует только в таблице, а затем щелкнуть кнопку в этой
    таблице. Вы можете использовать для этого <code>with</code> метод. Все операции, выполняемые в рамках данного <code>with</code>
    метода замыкания, будут привязаны к исходному селектору:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">with</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'.table'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token variable">$table</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">assertSee</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'Hello World'</span><span class="token punctuation">)</span>
          <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">clickLink</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Delete'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Иногда вам может потребоваться выполнить утверждения за пределами текущей области. Вы можете использовать <code>elsewhere</code>
    и <code>elsewhereWhenAvailable</code> методы для достижения этой цели:</p>
<pre class=" language-php"><code class=" language-php"> <span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">with</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'.table'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token variable">$table</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// Current scope is `body.table`...</span>

    <span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">elsewhere</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'.page-title'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$title</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">// Current scope is `body.page-title`...</span>
        <span class="token variable">$title</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">assertSee</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'Hello World'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

    <span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">elsewhereWhenAvailable</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'.page-title'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$title</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">// Current scope is `body.page-title`...</span>
        <span class="token variable">$title</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">assertSee</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'Hello World'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
 <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="waiting-for-elements"><a href="#waiting-for-elements">В ожидании элементов</a></h3>
<p>При тестировании приложений, широко использующих JavaScript, часто возникает необходимость «подождать», пока не
    станут доступны определенные элементы или данные, прежде чем приступить к тесту. Сумерки делают это легким.
    Используя различные методы, вы можете подождать, пока элементы будут видны на странице, или даже дождаться, пока
    данное выражение JavaScript не примет значение <code>true</code>.</p>
<p></p>
<h4 id="waiting"><a href="#waiting">Ожидающий</a></h4>
<p>Если вам просто нужно приостановить тест на заданное количество миллисекунд, используйте <code>pause</code> метод:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">pause</span><span
                class="token punctuation">(</span><span class="token number">1000</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="waiting-for-selectors"><a href="#waiting-for-selectors">Ожидание селекторов</a></h4>
<p>Этот <code>waitFor</code> метод может использоваться для приостановки выполнения теста до тех пор, пока на странице
    не отобразится элемент, соответствующий заданному CSS или селектору Dusk. По умолчанию тест приостанавливается
    максимум на пять секунд перед выдачей исключения. При необходимости вы можете передать настраиваемый порог тайм-аута
    в качестве второго аргумента метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">// Wait a maximum of five seconds for the selector...</span>
<span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">waitFor</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'.selector'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// Wait a maximum of one second for the selector...</span>
<span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">waitFor</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'.selector'</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы также можете подождать, пока элемент, соответствующий данному селектору, не будет содержать данный текст:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">// Wait a maximum of five seconds for the selector to contain the given text...</span>
<span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">waitForTextIn</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'.selector'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Hello World'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// Wait a maximum of one second for the selector to contain the given text...</span>
<span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">waitForTextIn</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'.selector'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Hello World'</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы также можете подождать, пока элемент, соответствующий данному селектору, не исчезнет со страницы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">// Wait a maximum of five seconds until the selector is missing...</span>
<span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">waitUntilMissing</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'.selector'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// Wait a maximum of one second until the selector is missing...</span>
<span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">waitUntilMissing</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'.selector'</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="scoping-selectors-when-available"><a href="#scoping-selectors-when-available">Селекторы области видимости, когда
        они доступны</a></h4>
<p>Иногда вы можете подождать появления элемента, который соответствует заданному селектору, а затем взаимодействовать с
    этим элементом. Например, вы можете подождать, пока не станет доступным модальное окно, а затем нажать кнопку «ОК» в
    модальном окне. Для этого <code>whenAvailable</code> можно использовать метод. Все операции с элементами,
    выполняемые в рамках данного замыкания, будут привязаны к исходному селектору:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">whenAvailable</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'.modal'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$modal</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$modal</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">assertSee</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'Hello World'</span><span class="token punctuation">)</span>
          <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">press</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'OK'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="waiting-for-text"><a href="#waiting-for-text">Ожидание текста</a></h4>
<p><code>waitForText</code> Метод может быть использован ждать, пока данный текст не отображается на странице:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">// Wait a maximum of five seconds for the text...</span>
<span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">waitForText</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'Hello World'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// Wait a maximum of one second for the text...</span>
<span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">waitForText</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'Hello World'</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете использовать этот <code>waitUntilMissingText</code> метод, чтобы дождаться, пока отображаемый текст не
    будет удален со страницы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">// Wait a maximum of five seconds for the text to be removed...</span>
<span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">waitUntilMissingText</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'Hello World'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// Wait a maximum of one second for the text to be removed...</span>
<span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">waitUntilMissingText</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'Hello World'</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="waiting-for-links"><a href="#waiting-for-links">Жду ссылок</a></h4>
<p><code>waitForLink</code> Метод может быть использован ждать, пока данный текст ссылки не отображаются на странице:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">// Wait a maximum of five seconds for the link...</span>
<span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">waitForLink</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Create'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// Wait a maximum of one second for the link...</span>
<span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">waitForLink</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Create'</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="waiting-on-the-page-location"><a href="#waiting-on-the-page-location">Ожидание на странице</a></h4>
<p>При создании утверждения пути, например <code>$browser-&gt;assertPathIs('/home')</code>, утверждение может
    завершиться ошибкой, если <code>window.location.pathname</code> обновляется асинхронно. Вы можете использовать этот
    <code>waitForLocation</code> метод, чтобы дождаться, пока местоположение не станет заданным значением:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">waitForLocation</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/secret'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы также можете дождаться местоположения <a href="routing#named-routes">названного маршрута</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">waitForRoute</span><span
                class="token punctuation">(</span><span class="token variable">$routeName</span><span
                class="token punctuation">,</span> <span class="token variable">$parameters</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="waiting-for-page-reloads"><a href="#waiting-for-page-reloads">Ожидание перезагрузки страницы</a></h4>
<p>Если вам нужно сделать утверждения после перезагрузки страницы, используйте <code>waitForReload</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">click</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'.some-action'</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">waitForReload</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSee</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'something'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="waiting-on-javascript-expressions"><a href="#waiting-on-javascript-expressions">Ожидание выражений
        JavaScript</a></h4>
<p>Иногда вам может потребоваться приостановить выполнение теста до тех пор, пока данное выражение JavaScript не даст
    результат <code>true</code>. Вы легко можете сделать это с помощью <code>waitUntil</code> метода. При передаче
    выражения в этот метод не нужно включать <code>return</code> ключевое слово или конечную точку с запятой:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">// Wait a maximum of five seconds for the expression to be true...</span>
<span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">waitUntil</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'App.data.servers.length &gt; 0'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// Wait a maximum of one second for the expression to be true...</span>
<span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">waitUntil</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'App.data.servers.length &gt; 0'</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="waiting-on-vue-expressions"><a href="#waiting-on-vue-expressions">Ожидание выражений Vue</a></h4>
<p>Эти <code>waitUntilVue</code> и <code>waitUntilVueIsNot</code> методы могут быть использованы, чтобы ждать, пока <a
            href="https://vuejs.org">компонент Вьет</a> атрибут не имеет заданное значение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">// Wait until the component attribute contains the given value...</span>
<span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">waitUntilVue</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'user.name'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'Taylor'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'@user'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// Wait until the component attribute doesn't contain the given value...</span>
<span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">waitUntilVueIsNot</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'user.name'</span><span
                class="token punctuation">,</span> <span class="token constant">null</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'@user'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="waiting-with-a-callback"><a href="#waiting-with-a-callback">Ожидание с обратным вызовом</a></h4>
<p>Многие методы ожидания в Dusk полагаются на основной <code>waitUsing</code> метод. Вы можете использовать этот метод
    напрямую, чтобы дождаться возврата данного закрытия <code>true</code>. <code>waitUsing</code> Метод принимает
    максимальное количество секунд ожидания, интервал, в котором укупорочное средство должно быть оценены, закрытие и
    дополнительное сообщение отказа:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">waitUsing</span><span
                class="token punctuation">(</span><span class="token number">10</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token keyword">use</span> <span
                class="token punctuation">(</span><span class="token variable">$something</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$something</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">isReady</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">,</span> <span
                class="token double-quoted-string string">"Something wasn't ready in time."</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="scrolling-an-element-into-view"><a href="#scrolling-an-element-into-view">Прокрутка элемента в представление</a>
</h3>
<p>Иногда вы не можете щелкнуть элемент, потому что он находится за пределами области просмотра браузера. <code>scrollIntoView</code>
    Метод прокрутка окна браузера, пока элемент в данном селекторе не находится в поле зрения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">scrollIntoView</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'.selector'</span><span class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">click</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'.selector'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="available-assertions"><a href="#available-assertions">Доступные утверждения</a></h2>
<p>Dusk предлагает множество утверждений, которые вы можете сделать против своего приложения. Все доступные утверждения
    задокументированы в списке ниже:</p>
<style>
    .collection-method-list > p {
        column-count: 3;
        -moz-column-count: 3;
        -webkit-column-count: 3;
        column-gap: 2em;
        -moz-column-gap: 2em;
        -webkit-column-gap: 2em;
    }

    .collection-method-list a {
        display: block;
    }
</style>
<div class="collection-method-list">
    <p><a href="dusk#assert-title">assertTitle</a> <a href="dusk#assert-title-contains">assertTitleContains</a> <a
                href="dusk#assert-url-is">assertUrlIs</a> <a href="dusk#assert-scheme-is">assertSchemeIs</a> <a
                href="dusk#assert-scheme-is-not">assertSchemeIsNot</a> <a href="dusk#assert-host-is">assertHostIs</a> <a
                href="dusk#assert-host-is-not">assertHostIsNot</a> <a href="dusk#assert-port-is">assertPortIs</a> <a
                href="dusk#assert-port-is-not">assertPortIsNot</a> <a href="dusk#assert-path-begins-with">assertPathBeginsWith</a>
        <a href="dusk#assert-path-is">assertPathIs</a> <a href="dusk#assert-path-is-not">assertPathIsNot</a> <a
                href="dusk#assert-route-is">assertRouteIs</a> <a href="dusk#assert-query-string-has">assertQueryStringHas</a>
        <a href="dusk#assert-query-string-missing">assertQueryStringMissing</a> <a href="dusk#assert-fragment-is">assertFragmentIs</a>
        <a href="dusk#assert-fragment-begins-with">assertFragmentBeginsWith</a> <a href="dusk#assert-fragment-is-not">assertFragmentIsNot</a>
        <a href="dusk#assert-has-cookie">assertHasCookie</a> <a
                href="dusk#assert-has-plain-cookie">assertHasPlainCookie</a> <a href="dusk#assert-cookie-missing">assertCookieMissing</a>
        <a href="dusk#assert-plain-cookie-missing">assertPlainCookieMissing</a> <a href="dusk#assert-cookie-value">assertCookieValue</a>
        <a href="dusk#assert-plain-cookie-value">assertPlainCookieValue</a> <a href="dusk#assert-see">assertSee</a> <a
                href="dusk#assert-dont-see">assertDontSee</a> <a href="dusk#assert-see-in">assertSeeIn</a> <a
                href="dusk#assert-dont-see-in">assertDontSeeIn</a> <a href="dusk#assert-see-anything-in">assertSeeAnythingIn</a>
        <a href="dusk#assert-see-nothing-in">assertSeeNothingIn</a> <a href="dusk#assert-script">assertScript</a> <a
                href="dusk#assert-source-has">assertSourceHas</a> <a href="dusk#assert-source-missing">assertSourceMissing</a>
        <a href="dusk#assert-see-link">assertSeeLink</a> <a href="dusk#assert-dont-see-link">assertDontSeeLink</a> <a
                href="dusk#assert-input-value">assertInputValue</a> <a href="dusk#assert-input-value-is-not">assertInputValueIsNot</a>
        <a href="dusk#assert-checked">assertChecked</a> <a href="dusk#assert-not-checked">assertNotChecked</a> <a
                href="dusk#assert-radio-selected">assertRadioSelected</a> <a href="dusk#assert-radio-not-selected">assertRadioNotSelected</a>
        <a href="dusk#assert-selected">assertSelected</a> <a href="dusk#assert-not-selected">assertNotSelected</a> <a
                href="dusk#assert-select-has-options">assertSelectHasOptions</a> <a
                href="dusk#assert-select-missing-options">assertSelectMissingOptions</a> <a
                href="dusk#assert-select-has-option">assertSelectHasOption</a> <a
                href="dusk#assert-select-missing-option">assertSelectMissingOption</a> <a href="dusk#assert-value">assertValue</a>
        <a href="dusk#assert-attribute">assertAttribute</a> <a href="dusk#assert-aria-attribute">assertAriaAttribute</a>
        <a href="dusk#assert-data-attribute">assertDataAttribute</a> <a href="dusk#assert-visible">assertVisible</a> <a
                href="dusk#assert-present">assertPresent</a> <a href="dusk#assert-not-present">assertNotPresent</a> <a
                href="dusk#assert-missing">assertMissing</a> <a href="dusk#assert-dialog-opened">assertDialogOpened</a>
        <a href="dusk#assert-enabled">assertEnabled</a> <a href="dusk#assert-disabled">assertDisabled</a> <a
                href="dusk#assert-button-enabled">assertButtonEnabled</a> <a href="dusk#assert-button-disabled">assertButtonDisabled</a>
        <a href="dusk#assert-focused">assertFocused</a> <a href="dusk#assert-not-focused">assertNotFocused</a> <a
                href="dusk#assert-authenticated">assertAuthenticated</a> <a href="dusk#assert-guest">assertGuest</a> <a
                href="dusk#assert-authenticated-as">assertAuthenticatedAs</a> <a href="dusk#assert-vue">assertVue</a> <a
                href="dusk#assert-vue-is-not">assertVueIsNot</a> <a
                href="dusk#assert-vue-contains">assertVueContains</a> <a href="dusk#assert-vue-does-not-contain">assertVueDoesNotContain</a>
    </p>
</div>
<p></p>
<h4 id="assert-title"><a href="#assert-title">assertTitle</a></h4>
<p>Убедитесь, что заголовок страницы соответствует данному тексту:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertTitle</span><span
                class="token punctuation">(</span><span class="token variable">$title</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-title-contains"><a href="#assert-title-contains">assertTitleContains</a></h4>
<p>Утверждают, что заголовок страницы содержит данный текст:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertTitleContains</span><span
                class="token punctuation">(</span><span class="token variable">$title</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-url-is"><a href="#assert-url-is">assertUrlIs</a></h4>
<p>Подтвердите, что текущий URL (без строки запроса) соответствует заданной строке:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertUrlIs</span><span
                class="token punctuation">(</span><span class="token variable">$url</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-scheme-is"><a href="#assert-scheme-is">assertSchemeIs</a></h4>
<p>Подтвердите, что текущая схема URL соответствует данной схеме:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSchemeIs</span><span
                class="token punctuation">(</span><span class="token variable">$scheme</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-scheme-is-not"><a href="#assert-scheme-is-not">assertSchemeIsNot</a></h4>
<p>Утверждают, что текущая схема URL не соответствует данной схеме:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSchemeIsNot</span><span
                class="token punctuation">(</span><span class="token variable">$scheme</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-host-is"><a href="#assert-host-is">assertHostIs</a></h4>
<p>Подтвердите, что текущий URL-адрес соответствует данному хосту:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertHostIs</span><span
                class="token punctuation">(</span><span class="token variable">$host</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-host-is-not"><a href="#assert-host-is-not">assertHostIsNot</a></h4>
<p>Подтвердите, что текущий URL-адрес хоста не соответствует данному хосту:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertHostIsNot</span><span
                class="token punctuation">(</span><span class="token variable">$host</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-port-is"><a href="#assert-port-is">assertPortIs</a></h4>
<p>Подтвердите, что текущий порт URL-адреса соответствует данному порту:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertPortIs</span><span
                class="token punctuation">(</span><span class="token variable">$port</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-port-is-not"><a href="#assert-port-is-not">assertPortIsNot</a></h4>
<p>Подтвердите, что текущий порт URL-адреса не соответствует данному порту:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertPortIsNot</span><span
                class="token punctuation">(</span><span class="token variable">$port</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-path-begins-with"><a href="#assert-path-begins-with">assertPathBeginsWith</a></h4>
<p>Утверждают, что текущий URL-путь начинается с указанного пути:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertPathBeginsWith</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/home'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-path-is"><a href="#assert-path-is">assertPathIs</a></h4>
<p>Утверждают, что текущий путь соответствует заданному пути:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertPathIs</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/home'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-path-is-not"><a href="#assert-path-is-not">assertPathIsNot</a></h4>
<p>Утверждают, что текущий путь не соответствует указанному пути:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertPathIsNot</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/home'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-route-is"><a href="#assert-route-is">assertRouteIs</a></h4>
<p>Подтвердите, что текущий URL-адрес соответствует указанному URL-адресу <a href="routing#named-routes">именованного
        маршрута</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertRouteIs</span><span
                class="token punctuation">(</span><span class="token variable">$name</span><span
                class="token punctuation">,</span> <span class="token variable">$parameters</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-query-string-has"><a href="#assert-query-string-has">assertQueryStringHas</a></h4>
<p>Убедитесь, что данный параметр строки запроса присутствует:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertQueryStringHas</span><span
                class="token punctuation">(</span><span class="token variable">$name</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Убедитесь, что данный параметр строки запроса присутствует и имеет заданное значение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertQueryStringHas</span><span
                class="token punctuation">(</span><span class="token variable">$name</span><span
                class="token punctuation">,</span> <span class="token variable">$value</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-query-string-missing"><a href="#assert-query-string-missing">assertQueryStringMissing</a></h4>
<p>Утверждают, что данный параметр строки запроса отсутствует:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertQueryStringMissing</span><span
                class="token punctuation">(</span><span class="token variable">$name</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-fragment-is"><a href="#assert-fragment-is">assertFragmentIs</a></h4>
<p>Убедитесь, что текущий хеш-фрагмент URL-адреса соответствует данному фрагменту:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertFragmentIs</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'anchor'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-fragment-begins-with"><a href="#assert-fragment-begins-with">assertFragmentBeginsWith</a></h4>
<p>Утверждают, что текущий хеш-фрагмент URL-адреса начинается с данного фрагмента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertFragmentBeginsWith</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'anchor'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-fragment-is-not"><a href="#assert-fragment-is-not">assertFragmentIsNot</a></h4>
<p>Утверждают, что текущий хэш-фрагмент URL-адреса не соответствует данному фрагменту:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertFragmentIsNot</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'anchor'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-has-cookie"><a href="#assert-has-cookie">assertHasCookie</a></h4>
<p>Подтвердите, что данный зашифрованный файл cookie присутствует:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertHasCookie</span><span
                class="token punctuation">(</span><span class="token variable">$name</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-has-plain-cookie"><a href="#assert-has-plain-cookie">assertHasPlainCookie</a></h4>
<p>Подтвердите наличие данного незашифрованного файла cookie:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertHasPlainCookie</span><span
                class="token punctuation">(</span><span class="token variable">$name</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-cookie-missing"><a href="#assert-cookie-missing">assertCookieMissing</a></h4>
<p>Утверждают, что данный зашифрованный файл cookie отсутствует:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertCookieMissing</span><span
                class="token punctuation">(</span><span class="token variable">$name</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-plain-cookie-missing"><a href="#assert-plain-cookie-missing">assertPlainCookieMissing</a></h4>
<p>Утверждают, что данный незашифрованный файл cookie отсутствует:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertPlainCookieMissing</span><span
                class="token punctuation">(</span><span class="token variable">$name</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-cookie-value"><a href="#assert-cookie-value">assertCookieValue</a></h4>
<p>Утверждают, что зашифрованный файл cookie имеет заданное значение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertCookieValue</span><span
                class="token punctuation">(</span><span class="token variable">$name</span><span
                class="token punctuation">,</span> <span class="token variable">$value</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-plain-cookie-value"><a href="#assert-plain-cookie-value">assertPlainCookieValue</a></h4>
<p>Утверждают, что незашифрованный файл cookie имеет заданное значение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertPlainCookieValue</span><span
                class="token punctuation">(</span><span class="token variable">$name</span><span
                class="token punctuation">,</span> <span class="token variable">$value</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-see"><a href="#assert-see">assertSee</a></h4>
<p>Утверждают, что данный текст присутствует на странице:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSee</span><span
                class="token punctuation">(</span><span class="token variable">$text</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-dont-see"><a href="#assert-dont-see">assertDontSee</a></h4>
<p>Утверждают, что данного текста нет на странице:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertDontSee</span><span
                class="token punctuation">(</span><span class="token variable">$text</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-see-in"><a href="#assert-see-in">assertSeeIn</a></h4>
<p>Подтвердите, что данный текст присутствует в селекторе:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSeeIn</span><span
                class="token punctuation">(</span><span class="token variable">$selector</span><span
                class="token punctuation">,</span> <span class="token variable">$text</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-dont-see-in"><a href="#assert-dont-see-in">assertDontSeeIn</a></h4>
<p>Утверждают, что данный текст отсутствует в селекторе:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertDontSeeIn</span><span
                class="token punctuation">(</span><span class="token variable">$selector</span><span
                class="token punctuation">,</span> <span class="token variable">$text</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-see-anything-in"><a href="#assert-see-anything-in">assertSeeAnythingIn</a></h4>
<p>Убедитесь, что в селекторе присутствует какой-либо текст:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSeeAnythingIn</span><span
                class="token punctuation">(</span><span class="token variable">$selector</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-see-nothing-in"><a href="#assert-see-nothing-in">assertSeeNothingIn</a></h4>
<p>Убедитесь, что в селекторе нет текста:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSeeNothingIn</span><span
                class="token punctuation">(</span><span class="token variable">$selector</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-script"><a href="#assert-script">assertScript</a></h4>
<p>Утверждают, что данное выражение JavaScript дает указанное значение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertScript</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'window.isLoaded'</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertScript</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'document.readyState'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'complete'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-source-has"><a href="#assert-source-has">assertSourceHas</a></h4>
<p>Утверждают, что данный исходный код присутствует на странице:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSourceHas</span><span
                class="token punctuation">(</span><span class="token variable">$code</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-source-missing"><a href="#assert-source-missing">assertSourceMissing</a></h4>
<p>Утверждают, что данный исходный код отсутствует на странице:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSourceMissing</span><span
                class="token punctuation">(</span><span class="token variable">$code</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-see-link"><a href="#assert-see-link">assertSeeLink</a></h4>
<p>Утверждают, что данная ссылка присутствует на странице:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSeeLink</span><span
                class="token punctuation">(</span><span class="token variable">$linkText</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-dont-see-link"><a href="#assert-dont-see-link">assertDontSeeLink</a></h4>
<p>Утверждают, что данной ссылки нет на странице:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertDontSeeLink</span><span
                class="token punctuation">(</span><span class="token variable">$linkText</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-input-value"><a href="#assert-input-value">assertInputValue</a></h4>
<p>Утверждают, что данное поле ввода имеет заданное значение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertInputValue</span><span
                class="token punctuation">(</span><span class="token variable">$field</span><span
                class="token punctuation">,</span> <span class="token variable">$value</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-input-value-is-not"><a href="#assert-input-value-is-not">assertInputValueIsNot</a></h4>
<p>Утверждают, что данное поле ввода не имеет заданного значения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertInputValueIsNot</span><span
                class="token punctuation">(</span><span class="token variable">$field</span><span
                class="token punctuation">,</span> <span class="token variable">$value</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-checked"><a href="#assert-checked">assertChecked</a></h4>
<p>Утверждают, что данный флажок установлен:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertChecked</span><span
                class="token punctuation">(</span><span class="token variable">$field</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-not-checked"><a href="#assert-not-checked">assertNotChecked</a></h4>
<p>Утверждают, что данный флажок не установлен:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertNotChecked</span><span
                class="token punctuation">(</span><span class="token variable">$field</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-radio-selected"><a href="#assert-radio-selected">assertRadioSelected</a></h4>
<p>Утверждают, что данное радиополе выбрано:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertRadioSelected</span><span
                class="token punctuation">(</span><span class="token variable">$field</span><span
                class="token punctuation">,</span> <span class="token variable">$value</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-radio-not-selected"><a href="#assert-radio-not-selected">assertRadioNotSelected</a></h4>
<p>Утверждают, что данное радио поле не выбрано:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertRadioNotSelected</span><span
                class="token punctuation">(</span><span class="token variable">$field</span><span
                class="token punctuation">,</span> <span class="token variable">$value</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-selected"><a href="#assert-selected">assertSelected</a></h4>
<p>Убедитесь, что в данном раскрывающемся списке выбрано данное значение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSelected</span><span
                class="token punctuation">(</span><span class="token variable">$field</span><span
                class="token punctuation">,</span> <span class="token variable">$value</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-not-selected"><a href="#assert-not-selected">assertNotSelected</a></h4>
<p>Подтвердите, что в данном раскрывающемся списке не выбрано данное значение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertNotSelected</span><span
                class="token punctuation">(</span><span class="token variable">$field</span><span
                class="token punctuation">,</span> <span class="token variable">$value</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-select-has-options"><a href="#assert-select-has-options">assertSelectHasOptions</a></h4>
<p>Утверждают, что данный массив значений доступен для выбора:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSelectHasOptions</span><span
                class="token punctuation">(</span><span class="token variable">$field</span><span
                class="token punctuation">,</span> <span class="token variable">$values</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-select-missing-options"><a href="#assert-select-missing-options">assertSelectMissingOptions</a></h4>
<p>Утверждают, что данный массив значений недоступен для выбора:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSelectMissingOptions</span><span
                class="token punctuation">(</span><span class="token variable">$field</span><span
                class="token punctuation">,</span> <span class="token variable">$values</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-select-has-option"><a href="#assert-select-has-option">assertSelectHasOption</a></h4>
<p>Утверждают, что данное значение доступно для выбора в данном поле:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSelectHasOption</span><span
                class="token punctuation">(</span><span class="token variable">$field</span><span
                class="token punctuation">,</span> <span class="token variable">$value</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-select-missing-option"><a href="#assert-select-missing-option">assertSelectMissingOption</a></h4>
<p>Утверждают, что данное значение недоступно для выбора:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSelectMissingOption</span><span
                class="token punctuation">(</span><span class="token variable">$field</span><span
                class="token punctuation">,</span> <span class="token variable">$value</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-value"><a href="#assert-value">assertValue</a></h4>
<p>Утверждают, что элемент, соответствующий данному селектору, имеет заданное значение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertValue</span><span
                class="token punctuation">(</span><span class="token variable">$selector</span><span
                class="token punctuation">,</span> <span class="token variable">$value</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-attribute"><a href="#assert-attribute">assertAttribute</a></h4>
<p>Утверждают, что элемент, соответствующий данному селектору, имеет данное значение в предоставленном атрибуте:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertAttribute</span><span
                class="token punctuation">(</span><span class="token variable">$selector</span><span
                class="token punctuation">,</span> <span class="token variable">$attribute</span><span
                class="token punctuation">,</span> <span class="token variable">$value</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-aria-attribute"><a href="#assert-aria-attribute">assertAriaAttribute</a></h4>
<p>Подтвердите, что элемент, соответствующий данному селектору, имеет заданное значение в предоставленном атрибуте
    aria:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertAriaAttribute</span><span
                class="token punctuation">(</span><span class="token variable">$selector</span><span
                class="token punctuation">,</span> <span class="token variable">$attribute</span><span
                class="token punctuation">,</span> <span class="token variable">$value</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Например, учитывая разметку <code>&lt;button aria-label="Add"&gt;&lt;/button&gt;</code>, вы можете утверждать против
    <code>aria-label</code> атрибута следующим образом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertAriaAttribute</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'button'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'label'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'Add'</span><span
                class="token punctuation">)</span></code></pre>
<p></p>
<h4 id="assert-data-attribute"><a href="#assert-data-attribute">assertDataAttribute</a></h4>
<p>Утверждают, что элемент, соответствующий данному селектору, имеет заданное значение в предоставленном атрибуте
    данных:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertDataAttribute</span><span
                class="token punctuation">(</span><span class="token variable">$selector</span><span
                class="token punctuation">,</span> <span class="token variable">$attribute</span><span
                class="token punctuation">,</span> <span class="token variable">$value</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Например, учитывая разметку <code>&lt;tr id="row-1" data-content="attendees"&gt;&lt;/tr&gt;</code>, вы можете
    утверждать против <code>data-label</code> атрибута следующим образом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertDataAttribute</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'#row-1'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'content'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'attendees'</span><span
                class="token punctuation">)</span></code></pre>
<p></p>
<h4 id="assert-visible"><a href="#assert-visible">assertVisible</a></h4>
<p>Утверждают, что элемент, соответствующий данному селектору, видим:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertVisible</span><span
                class="token punctuation">(</span><span class="token variable">$selector</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-present"><a href="#assert-present">assertPresent</a></h4>
<p>Утверждают, что элемент, соответствующий данному селектору, присутствует:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertPresent</span><span
                class="token punctuation">(</span><span class="token variable">$selector</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-not-present"><a href="#assert-not-present">assertNotPresent</a></h4>
<p>Утверждают, что элемент, соответствующий данному селектору, отсутствует в источнике:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertNotPresent</span><span
                class="token punctuation">(</span><span class="token variable">$selector</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-missing"><a href="#assert-missing">assertMissing</a></h4>
<p>Утверждают, что элемент, соответствующий данному селектору, не виден:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertMissing</span><span
                class="token punctuation">(</span><span class="token variable">$selector</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-dialog-opened"><a href="#assert-dialog-opened">assertDialogOpened</a></h4>
<p>Убедитесь, что диалог JavaScript с данным сообщением был открыт:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertDialogOpened</span><span
                class="token punctuation">(</span><span class="token variable">$message</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-enabled"><a href="#assert-enabled">assertEnabled</a></h4>
<p>Утверждают, что данное поле включено:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertEnabled</span><span
                class="token punctuation">(</span><span class="token variable">$field</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-disabled"><a href="#assert-disabled">assertDisabled</a></h4>
<p>Утверждают, что данное поле отключено:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertDisabled</span><span
                class="token punctuation">(</span><span class="token variable">$field</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-button-enabled"><a href="#assert-button-enabled">assertButtonEnabled</a></h4>
<p>Утверждают, что данная кнопка активирована:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertButtonEnabled</span><span
                class="token punctuation">(</span><span class="token variable">$button</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-button-disabled"><a href="#assert-button-disabled">assertButtonDisabled</a></h4>
<p>Утверждают, что данная кнопка отключена:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertButtonDisabled</span><span
                class="token punctuation">(</span><span class="token variable">$button</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-focused"><a href="#assert-focused">assertFocused</a></h4>
<p>Утверждают, что данное поле сфокусировано:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertFocused</span><span
                class="token punctuation">(</span><span class="token variable">$field</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-not-focused"><a href="#assert-not-focused">assertNotFocused</a></h4>
<p>Утверждают, что данное поле не сфокусировано:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertNotFocused</span><span
                class="token punctuation">(</span><span class="token variable">$field</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-authenticated"><a href="#assert-authenticated">assertAuthenticated</a></h4>
<p>Утверждают, что пользователь аутентифицирован:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertAuthenticated</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-guest"><a href="#assert-guest">assertGuest</a></h4>
<p>Утверждают, что пользователь не аутентифицирован:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertGuest</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-authenticated-as"><a href="#assert-authenticated-as">assertAuthenticatedAs</a></h4>
<p>Подтвердите, что пользователь аутентифицирован как данный пользователь:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertAuthenticatedAs</span><span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-vue"><a href="#assert-vue">assertVue</a></h4>
<p>Dusk даже позволяет делать утверждения о состоянии данных <a href="https://vuejs.org">компонента Vue</a>. Например,
    представьте, что ваше приложение содержит следующий компонент Vue:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">// HTML...</span>

<span class="token operator">&lt;</span>profile dusk<span class="token operator">=</span><span
                class="token double-quoted-string string">"profile-component"</span><span
                class="token operator">&gt;</span><span class="token operator">&lt;</span><span
                class="token operator">/</span>profile<span class="token operator">&gt;</span>

<span class="token comment">// Component Definition...</span>

Vue<span class="token punctuation">.</span><span class="token function">component</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'profile'</span><span class="token punctuation">,</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    template<span class="token punctuation">:</span> <span class="token single-quoted-string string">'&lt;div&gt;{literal}{{ user.name }}{/literal}&lt;/div&gt;'</span><span
                class="token punctuation">,</span>
                    
    data<span class="token punctuation">:</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span
                class="token punctuation">{literal}{{/literal}</span>
            user<span class="token punctuation">:</span> <span
                class="token punctuation">{literal}{{/literal}</span>
                name<span class="token punctuation">:</span> <span class="token single-quoted-string string">'Taylor'</span>
            <span class="token punctuation">}</span>
        <span class="token punctuation">}</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы можете утверждать состояние компонента Vue следующим образом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * A basic Vue test example.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">testVue</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">browse</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span>Browser <span class="token variable">$browser</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">visit</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/'</span><span
                class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">assertVue</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'user.name'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'Taylor'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'@profile-component'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="assert-vue-is-not"><a href="#assert-vue-is-not">assertVueIsNot</a></h4>
<p>Утверждают, что данное свойство данных компонента Vue не соответствует заданному значению:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertVueIsNot</span><span
                class="token punctuation">(</span><span class="token variable">$property</span><span
                class="token punctuation">,</span> <span class="token variable">$value</span><span
                class="token punctuation">,</span> <span class="token variable">$componentSelector</span> <span
                class="token operator">=</span> <span class="token constant">null</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-vue-contains"><a href="#assert-vue-contains">assertVueContains</a></h4>
<p>Утверждают, что данное свойство данных компонента Vue является массивом и содержит заданное значение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertVueContains</span><span
                class="token punctuation">(</span><span class="token variable">$property</span><span
                class="token punctuation">,</span> <span class="token variable">$value</span><span
                class="token punctuation">,</span> <span class="token variable">$componentSelector</span> <span
                class="token operator">=</span> <span class="token constant">null</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-vue-does-not-contain"><a href="#assert-vue-does-not-contain">assertVueDoesNotContain</a></h4>
<p>Утверждают, что данное свойство данных компонента Vue является массивом и не содержит заданного значения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertVueDoesNotContain</span><span
                class="token punctuation">(</span><span class="token variable">$property</span><span
                class="token punctuation">,</span> <span class="token variable">$value</span><span
                class="token punctuation">,</span> <span class="token variable">$componentSelector</span> <span
                class="token operator">=</span> <span class="token constant">null</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="pages"><a href="#pages">Страницы</a></h2>
<p>Иногда тесты требуют последовательного выполнения нескольких сложных действий. Это может затруднить чтение и
    понимание ваших тестов. Dusk Pages позволяют вам определять выразительные действия, которые затем могут быть
    выполнены на данной странице с помощью одного метода. Страницы также позволяют вам определять ярлыки для общих
    селекторов для вашего приложения или для отдельной страницы.</p>
<p></p>
<h3 id="generating-pages"><a href="#generating-pages">Создание страниц</a></h3>
<p>Чтобы создать объект страницы, выполните команду <code>dusk:page</code> Artisan. Все объекты страницы будут помещены
    в <code>tests/Browser/Pages</code> каталог вашего приложения:</p>
<pre class=" language-php"><code class=" language-php">php artisan dusk<span class="token punctuation">:</span>page Login</code></pre>
<p></p>
<h3 id="configuring-pages"><a href="#configuring-pages">Настройка страниц</a></h3>
<p>По умолчанию, страницы имеют три метода: <code>url</code>, <code>assert</code>, и <code>elements</code>. Сейчас мы
    обсудим методы <code>url</code> и <code>assert</code>. <a href="dusk#shorthand-selectors">Более подробно</a> этот
    <code>elements</code> метод будет <a href="dusk#shorthand-selectors">рассмотрен ниже</a>.</p>
<p></p>
<h4 id="the-url-method"><a href="#the-url-method"><code>url</code> Метод</a></h4>
<p><code>url</code> Метод должен возвращать путь к URL, который представляет страницу. Dusk будет использовать этот
    URL-адрес при переходе на страницу в браузере:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the URL for the page.
 *
 * @return string
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">url</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token single-quoted-string string">'/login'</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="the-assert-method"><a href="#the-assert-method"><code>assert</code> Метод</a></h4>
<p><code>assert</code> Метод может делать какое - либо утверждение, необходимым для проверки того, что браузер на самом
    деле на данной странице. На самом деле нет необходимости размещать что-либо в этом методе; однако вы можете сделать
    эти утверждения, если хотите. Эти утверждения будут запускаться автоматически при переходе на страницу:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Assert that the browser is on the page.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">assert</span><span
                class="token punctuation">(</span>Browser <span class="token variable">$browser</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">assertPathIs</span><span
                class="token punctuation">(</span><span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">url</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="navigating-to-pages"><a href="#navigating-to-pages">Переход к страницам</a></h3>
<p>После определения страницы вы можете перейти к ней с помощью <code>visit</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Tests<span class="token punctuation">\</span>Browser<span
                    class="token punctuation">\</span>Pages<span class="token punctuation">\</span>Login</span><span
                class="token punctuation">;</span>

<span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">visit</span><span
                class="token punctuation">(</span><span class="token keyword">new</span> <span class="token class-name">Login</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Иногда вы уже находитесь на данной странице, и вам нужно «загрузить» селекторы и методы страницы в текущий контекст
    теста. Это обычное явление, когда вы нажимаете кнопку и перенаправляетесь на заданную страницу без явного перехода к
    ней. В этой ситуации вы можете использовать <code>on</code> метод для загрузки страницы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Tests<span class="token punctuation">\</span>Browser<span
                    class="token punctuation">\</span>Pages<span class="token punctuation">\</span>CreatePlaylist</span><span
                class="token punctuation">;</span>

<span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">visit</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'/dashboard'</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">clickLink</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'Create Playlist'</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">on</span><span class="token punctuation">(</span><span
                class="token keyword">new</span> <span class="token class-name">CreatePlaylist</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSee</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'@create'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="shorthand-selectors"><a href="#shorthand-selectors">Сокращенные селекторы</a></h3>
<p><code>elements</code> Метод в классах страниц позволяет определить быстро, легко запоминающиеся ярлыки для любого
    селектора CSS на вашей странице. Например, давайте определим ярлык для поля ввода «электронная почта» на странице
    входа в приложение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the element shortcuts for the page.
 *
 * @return array
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">elements</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'@email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'input[name=email]'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>После того, как ярлык был определен, вы можете использовать сокращенный селектор в любом месте, где вы обычно
    используете полный селектор CSS:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$browser</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">type</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'@email'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'taylor@laravel.com'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="global-shorthand-selectors"><a href="#global-shorthand-selectors">Глобальные сокращенные селекторы</a></h4>
<p>После установки Dusk базовый <code>Page</code> класс будет помещен в ваш <code>tests/Browser/Pages</code> каталог.
    Этот класс содержит <code>siteElements</code> метод, который можно использовать для определения глобальных
    сокращенных селекторов, которые должны быть доступны на каждой странице вашего приложения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the global element shortcuts for the site.
 *
 * @return array
 */</span>
<span class="token keyword">public</span> <span class="token keyword">static</span> <span
                class="token keyword">function</span> <span class="token function">siteElements</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'@element'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'#selector'</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="page-methods"><a href="#page-methods">Методы страницы</a></h3>
<p>В дополнение к методам по умолчанию, определенным на страницах, вы можете определить дополнительные методы, которые
    могут использоваться в ваших тестах. Например, представим, что мы создаем приложение для управления музыкой. Обычным
    действием для одной страницы приложения может быть создание списка воспроизведения. Вместо того, чтобы переписывать
    логику создания списка воспроизведения в каждом тесте, вы можете определить <code>createPlaylist</code> метод в
    классе страницы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">Tests<span class="token punctuation">\</span>Browser<span
                        class="token punctuation">\</span>Pages</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Laravel<span
                        class="token punctuation">\</span>Dusk<span
                        class="token punctuation">\</span>Browser</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">Dashboard</span> <span class="token keyword">extends</span> <span
                    class="token class-name">Page</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// Other page methods...</span>

    <span class="token comment">/**
     * Create a new playlist.
     *
     * @param  \Laravel\Dusk\Browser  $browser
     * @param  string  $name
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">createPlaylist</span><span
                    class="token punctuation">(</span>Browser <span class="token variable">$browser</span><span
                    class="token punctuation">,</span> <span class="token variable">$name</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$browser</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">type</span><span
                    class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                    class="token punctuation">,</span> <span class="token variable">$name</span><span
                    class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">check</span><span class="token punctuation">(</span><span
                    class="token single-quoted-string string">'share'</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">press</span><span class="token punctuation">(</span><span
                    class="token single-quoted-string string">'Create Playlist'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Как только метод определен, вы можете использовать его в любом тесте, использующем страницу. Экземпляр браузера будет
    автоматически передан в качестве первого аргумента пользовательским методам страницы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Tests<span class="token punctuation">\</span>Browser<span
                    class="token punctuation">\</span>Pages<span class="token punctuation">\</span>Dashboard</span><span
                class="token punctuation">;</span>

<span class="token variable">$browser</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">visit</span><span
                class="token punctuation">(</span><span class="token keyword">new</span> <span class="token class-name">Dashboard</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">createPlaylist</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'My Playlist'</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSee</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'My Playlist'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="components"><a href="#components">Составные части</a></h2>
<p>Компоненты похожи на «объекты страницы» Dusk, но предназначены для частей пользовательского интерфейса и функций,
    которые повторно используются в вашем приложении, например, панели навигации или окна уведомлений. Таким образом,
    компоненты не привязаны к конкретным URL-адресам.</p>
<p></p>
<h3 id="generating-components"><a href="#generating-components">Создание компонентов</a></h3>
<p>Чтобы создать компонент, выполните команду <code>dusk:component</code> Artisan. Новые компоненты помещаются в <code>tests/Browser/Components</code>
    каталог:</p>
<pre class=" language-php"><code class=" language-php">php artisan dusk<span class="token punctuation">:</span>component DatePicker</code></pre>
<p>Как показано выше, «выбор даты» является примером компонента, который может присутствовать в вашем приложении на
    различных страницах. Может оказаться обременительным вручную написать логику автоматизации браузера для выбора даты
    в десятках тестов в вашем наборе тестов. Вместо этого мы можем определить компонент Dusk для представления средства
    выбора даты, что позволит нам инкапсулировать эту логику внутри компонента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">Tests<span class="token punctuation">\</span>Browser<span
                        class="token punctuation">\</span>Components</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Laravel<span
                        class="token punctuation">\</span>Dusk<span
                        class="token punctuation">\</span>Browser</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Laravel<span
                        class="token punctuation">\</span>Dusk<span
                        class="token punctuation">\</span>Component</span> <span class="token keyword">as</span> BaseComponent<span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">DatePicker</span> <span class="token keyword">extends</span> <span
                    class="token class-name">BaseComponent</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Get the root selector for the component.
     *
     * @return string
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">selector</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token single-quoted-string string">'.date-picker'</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
     * Assert that the browser page contains the component.
     *
     * @param  Browser  $browser
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">assert</span><span
                    class="token punctuation">(</span>Browser <span class="token variable">$browser</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$browser</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">assertVisible</span><span
                    class="token punctuation">(</span><span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">selector</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
     * Get the element shortcuts for the component.
     *
     * @return array
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">elements</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token punctuation">[</span>
            <span class="token single-quoted-string string">'@date-field'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token single-quoted-string string">'input.datepicker-input'</span><span
                    class="token punctuation">,</span>
            <span class="token single-quoted-string string">'@year-list'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token single-quoted-string string">'div &gt; div.datepicker-years'</span><span
                    class="token punctuation">,</span>
            <span class="token single-quoted-string string">'@month-list'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token single-quoted-string string">'div &gt; div.datepicker-months'</span><span
                    class="token punctuation">,</span>
            <span class="token single-quoted-string string">'@day-list'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token single-quoted-string string">'div &gt; div.datepicker-days'</span><span
                    class="token punctuation">,</span>
        <span class="token punctuation">]</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
     * Select the given date.
     *
     * @param  \Laravel\Dusk\Browser  $browser
     * @param  int  $year
     * @param  int  $month
     * @param  int  $day
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">selectDate</span><span
                    class="token punctuation">(</span>Browser <span class="token variable">$browser</span><span
                    class="token punctuation">,</span> <span class="token variable">$year</span><span
                    class="token punctuation">,</span> <span class="token variable">$month</span><span
                    class="token punctuation">,</span> <span class="token variable">$day</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$browser</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">click</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'@date-field'</span><span
                    class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">within</span><span class="token punctuation">(</span><span
                    class="token single-quoted-string string">'@year-list'</span><span
                    class="token punctuation">,</span> <span class="token keyword">function</span> <span
                    class="token punctuation">(</span><span class="token variable">$browser</span><span
                    class="token punctuation">)</span> <span class="token keyword">use</span> <span
                    class="token punctuation">(</span><span class="token variable">$year</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
                <span class="token variable">$browser</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">click</span><span
                    class="token punctuation">(</span><span class="token variable">$year</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">within</span><span class="token punctuation">(</span><span
                    class="token single-quoted-string string">'@month-list'</span><span
                    class="token punctuation">,</span> <span class="token keyword">function</span> <span
                    class="token punctuation">(</span><span class="token variable">$browser</span><span
                    class="token punctuation">)</span> <span class="token keyword">use</span> <span
                    class="token punctuation">(</span><span class="token variable">$month</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
                <span class="token variable">$browser</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">click</span><span
                    class="token punctuation">(</span><span class="token variable">$month</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">within</span><span class="token punctuation">(</span><span
                    class="token single-quoted-string string">'@day-list'</span><span class="token punctuation">,</span> <span
                    class="token keyword">function</span> <span class="token punctuation">(</span><span
                    class="token variable">$browser</span><span class="token punctuation">)</span> <span
                    class="token keyword">use</span> <span class="token punctuation">(</span><span
                    class="token variable">$day</span><span class="token punctuation">)</span> <span
                    class="token punctuation">{literal}{{/literal}</span>
                <span class="token variable">$browser</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">click</span><span
                    class="token punctuation">(</span><span class="token variable">$day</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h3 id="using-components"><a href="#using-components">Использование компонентов</a></h3>
<p>Как только компонент определен, мы можем легко выбрать дату в средстве выбора даты из любого теста. И, если логика,
    необходимая для выбора даты, изменится, нам нужно только обновить компонент:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">Tests<span class="token punctuation">\</span>Browser</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Testing<span class="token punctuation">\</span>DatabaseMigrations</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Laravel<span
                        class="token punctuation">\</span>Dusk<span
                        class="token punctuation">\</span>Browser</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Tests<span
                        class="token punctuation">\</span>Browser<span class="token punctuation">\</span>Components<span
                        class="token punctuation">\</span>DatePicker</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Tests<span class="token punctuation">\</span>DuskTestCase</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ExampleTest</span> <span class="token keyword">extends</span> <span
                    class="token class-name">DuskTestCase</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * A basic component test example.
     *
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">testBasicExample</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">browse</span><span
                    class="token punctuation">(</span><span class="token keyword">function</span> <span
                    class="token punctuation">(</span>Browser <span class="token variable">$browser</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
                <span class="token variable">$browser</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">visit</span><span
                    class="token punctuation">(</span><span class="token single-quoted-string string">'/'</span><span
                    class="token punctuation">)</span>
                    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">within</span><span class="token punctuation">(</span><span
                    class="token keyword">new</span> <span class="token class-name">DatePicker</span><span
                    class="token punctuation">,</span> <span class="token keyword">function</span> <span
                    class="token punctuation">(</span><span class="token variable">$browser</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
                        <span class="token variable">$browser</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">selectDate</span><span
                    class="token punctuation">(</span><span class="token number">2019</span><span
                    class="token punctuation">,</span> <span class="token number">1</span><span
                    class="token punctuation">,</span> <span class="token number">30</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
                    <span class="token punctuation">}</span><span class="token punctuation">)</span>
                    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">assertSee</span><span class="token punctuation">(</span><span
                    class="token single-quoted-string string">'January'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h2 id="continuous-integration"><a href="#continuous-integration">Непрерывная интеграция</a></h2>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Большинство конфигураций непрерывной интеграции Dusk предполагают, что ваше приложение Laravel будет
            обслуживаться с помощью встроенного сервера разработки PHP на порту 8000. Поэтому, прежде чем продолжить, вы
            должны убедиться, что ваша среда непрерывной интеграции имеет <code>APP_URL</code> значение переменной среды
            <code>http://127.0.0.1:8000</code>.</p></p></div>
</blockquote>
<p></p>
<h3 id="running-tests-on-heroku-ci"><a href="#running-tests-on-heroku-ci">Heroku CI</a></h3>
<p>Чтобы запустить тесты Dusk на <a href="https://www.heroku.com/continuous-integration">Heroku CI</a>, добавьте
    следующий пакет сборки и скрипты Google Chrome в свой <code>app.json</code> файл Heroku:</p>
<pre class=" language-php"><code class=" language-php"><span class="token punctuation">{literal}{{/literal}</span>
    <span class="token double-quoted-string string">"environments"</span><span class="token punctuation">:</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token double-quoted-string string">"test"</span><span class="token punctuation">:</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token double-quoted-string string">"buildpacks"</span><span class="token punctuation">:</span> <span class="token punctuation">[</span>
                <span class="token punctuation">{literal}{{/literal}</span> <span class="token double-quoted-string string">"url"</span><span class="token punctuation">:</span> <span class="token double-quoted-string string">"heroku/php"</span> <span class="token punctuation">}</span><span class="token punctuation">,</span>
                <span class="token punctuation">{literal}{{/literal}</span> <span class="token double-quoted-string string">"url"</span><span class="token punctuation">:</span> <span class="token double-quoted-string string">"https://github.com/heroku/heroku-buildpack-google-chrome"</span> <span class="token punctuation">}</span>
            <span class="token punctuation">]</span><span class="token punctuation">,</span>
            <span class="token double-quoted-string string">"scripts"</span><span class="token punctuation">:</span> <span class="token punctuation">{literal}{{/literal}</span>
                <span class="token double-quoted-string string">"test-setup"</span><span class="token punctuation">:</span> <span class="token double-quoted-string string">"cp .env.testing .env"</span><span class="token punctuation">,</span>
                <span class="token double-quoted-string string">"test"</span><span class="token punctuation">:</span> <span class="token double-quoted-string string">"nohup bash -c './vendor/laravel/dusk/bin/chromedriver-linux &gt; /dev/null 2&gt;&amp;1 &amp;' &amp;&amp; nohup bash -c 'php artisan serve &gt; /dev/null 2&gt;&amp;1 &amp;' &amp;&amp; php artisan dusk"</span>
            <span class="token punctuation">}</span>
        <span class="token punctuation">}</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="running-tests-on-travis-ci"><a href="#running-tests-on-travis-ci">Travis CI</a></h3>
<p>Чтобы запустить тесты Dusk на <a href="https://travis-ci.org">Travis CI</a>, используйте следующую
    <code>.travis.yml</code> конфигурацию. Поскольку Travis CI не является графической средой, нам нужно будет
    предпринять некоторые дополнительные шаги, чтобы запустить браузер Chrome. Кроме того, мы будем использовать
    <code>php artisan serve</code> для запуска встроенного веб-сервера PHP:</p>
<pre class=" language-php"><code class=" language-php">language<span class="token punctuation">:</span> php

php<span class="token punctuation">:</span>
  <span class="token operator">-</span> <span class="token number">7.3</span>

addons<span class="token punctuation">:</span>
  chrome<span class="token punctuation">:</span> stable

install<span class="token punctuation">:</span>
  <span class="token operator">-</span> cp <span class="token punctuation">.</span>env<span
                class="token punctuation">.</span>testing <span class="token punctuation">.</span>env
  <span class="token operator">-</span> travis_retry composer install <span class="token operator">--</span>no<span
                class="token operator">-</span>interaction <span class="token operator">--</span>prefer<span
                class="token operator">-</span>dist <span class="token operator">--</span>no<span
                class="token operator">-</span>suggest
  <span class="token operator">-</span> php artisan key<span class="token punctuation">:</span>generate
  <span class="token operator">-</span> php artisan dusk<span class="token punctuation">:</span>chrome<span
                class="token operator">-</span>driver

before_script<span class="token punctuation">:</span>
  <span class="token operator">-</span> google<span class="token operator">-</span>chrome<span
                class="token operator">-</span>stable <span class="token operator">--</span>headless <span
                class="token operator">--</span>disable<span class="token operator">-</span>gpu <span
                class="token operator">--</span>remote<span class="token operator">-</span>debugging<span
                class="token operator">-</span>port<span class="token operator">=</span><span
                class="token number">9222</span> http<span class="token punctuation">:</span><span
                class="token comment">//localhost &amp;</span>
  <span class="token operator">-</span> php artisan serve <span class="token operator">&amp;</span>

script<span class="token punctuation">:</span>
  <span class="token operator">-</span> php artisan dusk</code></pre>
<p></p>
<h3 id="running-tests-on-github-actions"><a href="#running-tests-on-github-actions">Действия GitHub</a></h3>
<p>Если вы используете <a href="https://github.com/features/actions">Github Actions</a> для запуска тестов Dusk, вы
    можете использовать следующий файл конфигурации в качестве отправной точки. Как и TravisCI, мы будем использовать
    <code>php artisan serve</code> команду для запуска встроенного веб-сервера PHP:</p>
<pre class=" language-php"><code class=" language-php">name<span class="token punctuation">:</span> <span
                class="token constant">CI</span>
on<span class="token punctuation">:</span> <span class="token punctuation">[</span>push<span
                class="token punctuation">]</span>
jobs<span class="token punctuation">:</span>

  dusk<span class="token operator">-</span>php<span class="token punctuation">:</span>
    runs<span class="token operator">-</span>on<span class="token punctuation">:</span> ubuntu<span
                class="token operator">-</span>latest
    steps<span class="token punctuation">:</span>
      <span class="token operator">-</span> uses<span class="token punctuation">:</span> actions<span
                class="token operator">/</span>checkout@v2
      <span class="token operator">-</span> name<span class="token punctuation">:</span> Prepare The Environment
        run<span class="token punctuation">:</span> cp <span class="token punctuation">.</span>env<span
                class="token punctuation">.</span>example <span class="token punctuation">.</span>env
      <span class="token operator">-</span> name<span class="token punctuation">:</span> Create Database
        run<span class="token punctuation">:</span> <span class="token operator">|</span>
          sudo systemctl start mysql
          mysql <span class="token operator">--</span>user<span class="token operator">=</span><span
                class="token double-quoted-string string">"root"</span> <span
                class="token operator">--</span>password<span class="token operator">=</span><span
                class="token double-quoted-string string">"root"</span> <span class="token operator">-</span>e <span
                class="token double-quoted-string string">"CREATE DATABASE 'my-database' character set UTF8mb4 collate utf8mb4_bin;"</span>
      <span class="token operator">-</span> name<span class="token punctuation">:</span> Install Composer Dependencies
        run<span class="token punctuation">:</span> composer install <span class="token operator">--</span>no<span
                class="token operator">-</span>progress <span class="token operator">--</span>no<span
                class="token operator">-</span>suggest <span class="token operator">--</span>prefer<span
                class="token operator">-</span>dist <span class="token operator">--</span>optimize<span
                class="token operator">-</span>autoloader
      <span class="token operator">-</span> name<span class="token punctuation">:</span> Generate Application Key
        run<span class="token punctuation">:</span> php artisan key<span class="token punctuation">:</span>generate
      <span class="token operator">-</span> name<span class="token punctuation">:</span> Upgrade Chrome Driver
        run<span class="token punctuation">:</span> php artisan dusk<span class="token punctuation">:</span>chrome<span
                class="token operator">-</span>driver `<span class="token operator">/</span>opt<span
                class="token operator">/</span>google<span class="token operator">/</span>chrome<span
                class="token operator">/</span>chrome <span class="token operator">--</span>version <span
                class="token operator">|</span> cut <span class="token operator">-</span>d <span
                class="token double-quoted-string string">" "</span> <span class="token operator">-</span>f3 <span
                class="token operator">|</span> cut <span class="token operator">-</span>d <span
                class="token double-quoted-string string">"."</span> <span class="token operator">-</span>f1`
      <span class="token operator">-</span> name<span class="token punctuation">:</span> Start Chrome Driver
        run<span class="token punctuation">:</span> <span class="token punctuation">.</span><span
                class="token operator">/</span>vendor<span class="token operator">/</span>laravel<span
                class="token operator">/</span>dusk<span class="token operator">/</span>bin<span class="token operator">/</span>chromedriver<span
                class="token operator">-</span>linux <span class="token operator">&amp;</span>
      <span class="token operator">-</span> name<span class="token punctuation">:</span> Run Laravel Server
        run<span class="token punctuation">:</span> php artisan serve <span class="token operator">&amp;</span>
      <span class="token operator">-</span> name<span class="token punctuation">:</span> Run Dusk Tests
        env<span class="token punctuation">:</span>
          <span class="token constant">APP_URL</span><span class="token punctuation">:</span> <span
                class="token double-quoted-string string">"http://127.0.0.1:8000"</span>
        run<span class="token punctuation">:</span> php artisan dusk
      <span class="token operator">-</span> name<span class="token punctuation">:</span> Upload Screenshots
        <span class="token keyword">if</span><span class="token punctuation">:</span> <span class="token function">failure</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
        uses<span class="token punctuation">:</span> actions<span class="token operator">/</span>upload<span
                class="token operator">-</span>artifact@v2
        with<span class="token punctuation">:</span>
          name<span class="token punctuation">:</span> screenshots
          path<span class="token punctuation">:</span> tests<span class="token operator">/</span>Browser<span
                class="token operator">/</span>screenshots
      <span class="token operator">-</span> name<span class="token punctuation">:</span> Upload Console Logs
        <span class="token keyword">if</span><span class="token punctuation">:</span> <span class="token function">failure</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
        uses<span class="token punctuation">:</span> actions<span class="token operator">/</span>upload<span
                class="token operator">-</span>artifact@v2
        with<span class="token punctuation">:</span>
          name<span class="token punctuation">:</span> console
          path<span class="token punctuation">:</span> tests<span class="token operator">/</span>Browser<span
                class="token operator">/</span>console</code></pre>
