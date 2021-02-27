<h1>Разработка пакетов <sup>Package development</sup></h1>
<ul>
    <li><a href="packages#introduction">Вступление</a>
        <ul>
            <li><a href="packages#a-note-on-facades">Примечание о фасадах</a></li>
        </ul>
    </li>
    <li><a href="packages#package-discovery">Обнаружение пакетов</a></li>
    <li><a href="packages#service-providers">Поставщики услуг</a></li>
    <li><a href="packages#resources">Ресурсы</a>
        <ul>
            <li><a href="packages#configuration">Конфигурация</a></li>
            <li><a href="packages#migrations">Миграции</a></li>
            <li><a href="packages#routes">Маршруты</a></li>
            <li><a href="packages#translations">Переводы</a></li>
            <li><a href="packages#views">Представления</a></li>
            <li><a href="packages#view-components">Компоненты представлений</a></li>
        </ul>
    </li>
    <li><a href="packages#commands">Команды</a></li>
    <li><a href="packages#public-assets">Общественные активы</a></li>
    <li><a href="packages#publishing-file-groups">Публикация файловых групп</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Пакеты - это основной способ добавления функциональности в Laravel. Пакеты могут быть чем угодно: от отличного
    способа работы с датами, например <a href="https://github.com/briannesbitt/Carbon">Carbon,</a> до пакета, который
    позволяет вам связывать файлы с моделями Eloquent, такими как Spatie's <a
            href="https://github.com/spatie/laravel-medialibrary">Laravel Media Library</a>.</p>
<p>Есть разные типы пакетов. Некоторые пакеты являются автономными, что означает, что они работают с любой
    инфраструктурой PHP. Carbon и PHPUnit - это примеры автономных пакетов. Любой из этих пакетов можно использовать с
    Laravel, потребовав их в вашем <code>composer.json</code> файле.</p>
<p>С другой стороны, другие пакеты специально предназначены для использования с Laravel. Эти пакеты могут иметь
    маршруты, контроллеры, представления и конфигурацию, специально предназначенные для улучшения приложения Laravel.
    Это руководство в первую очередь касается разработки тех пакетов, которые относятся к Laravel.</p>
<p></p>
<h3 id="a-note-on-facades"><a href="#a-note-on-facades">Примечание о фасадах</a></h3>
<p>При написании приложения Laravel обычно не имеет значения, используете ли вы контракты или фасады, поскольку оба
    обеспечивают по существу равные уровни тестируемости. Однако при написании пакетов ваш пакет обычно не будет иметь
    доступа ко всем помощникам тестирования Laravel. Если вы хотите иметь возможность писать тесты пакетов, как если бы
    пакет был установлен внутри типичного приложения Laravel, вы можете использовать пакет <a
            href="https://github.com/orchestral/testbench">Orchestral Testbench</a>.</p>
<p></p>
<h2 id="package-discovery"><a href="#package-discovery">Обнаружение пакетов</a></h2>
<p>В <code>config/app.php</code> файле конфигурации приложения Laravel <code>providers</code> параметр определяет список
    поставщиков услуг, которые должны быть загружены Laravel. Когда кто-то устанавливает ваш пакет, вы обычно хотите,
    чтобы ваш поставщик услуг был включен в этот список. Вместо того, чтобы требовать от пользователей вручную добавлять
    вашего поставщика услуг в список, вы можете определить поставщика в <code>extra</code> разделе
    <code>composer.json</code> файла вашего пакета. Помимо поставщиков услуг, вы также можете указать любые <a
            href="facades">фасады, которые</a> вы хотите зарегистрировать:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token double-quoted-string string">"extra"</span><span class="token punctuation">:</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token double-quoted-string string">"laravel"</span><span
                class="token punctuation">:</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token double-quoted-string string">"providers"</span><span
                class="token punctuation">:</span> <span class="token punctuation">[</span>
            <span class="token double-quoted-string string">"Barryvdh\\Debugbar\\ServiceProvider"</span>
        <span class="token punctuation">]</span><span class="token punctuation">,</span>
        <span class="token double-quoted-string string">"aliases"</span><span
                class="token punctuation">:</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token double-quoted-string string">"Debugbar"</span><span
                class="token punctuation">:</span> <span class="token double-quoted-string string">"Barryvdh\\Debugbar\\Facade"</span>
        <span class="token punctuation">}</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">,</span></code></pre>
<p>После того, как ваш пакет настроен для обнаружения, Laravel автоматически зарегистрирует своих поставщиков услуг и
    фасадов при его установке, создавая удобный опыт установки для пользователей вашего пакета.</p>
<p></p>
<h3 id="opting-out-of-package-discovery"><a href="#opting-out-of-package-discovery">Отказ от обнаружения пакетов</a>
</h3>
<p>Если вы являетесь потребителем пакета и хотите отключить обнаружение пакетов для пакета, вы можете указать имя пакета
    в <code>extra</code> разделе <code>composer.json</code> файла приложения:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token double-quoted-string string">"extra"</span><span class="token punctuation">:</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token double-quoted-string string">"laravel"</span><span
                class="token punctuation">:</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token double-quoted-string string">"dont-discover"</span><span
                class="token punctuation">:</span> <span class="token punctuation">[</span>
            <span class="token double-quoted-string string">"barryvdh/laravel-debugbar"</span>
        <span class="token punctuation">]</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">,</span></code></pre>
<p>Вы можете отключить обнаружение пакетов для всех пакетов, используя <code>*</code> символ внутри
    <code>dont-discover</code> директивы вашего приложения:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token double-quoted-string string">"extra"</span><span class="token punctuation">:</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token double-quoted-string string">"laravel"</span><span
                class="token punctuation">:</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token double-quoted-string string">"dont-discover"</span><span
                class="token punctuation">:</span> <span class="token punctuation">[</span>
            <span class="token double-quoted-string string">"*"</span>
        <span class="token punctuation">]</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">,</span></code></pre>
<p></p>
<h2 id="service-providers"><a href="#service-providers">Поставщики услуг</a></h2>
<p><a href="providers">Поставщики услуг</a> - это точка соединения между вашим пакетом и Laravel. Поставщик услуг
    отвечает за привязку вещей к <a href="container">сервисному контейнеру</a> Laravel и сообщает Laravel, куда
    загружать ресурсы пакета, такие как представления, файлы конфигурации и локализации.</p>
<p>Поставщик услуг расширяет <code>Illuminate\Support\ServiceProvider</code> класс и содержит два метода:
    <code>register</code> и <code>boot</code>. Базовый <code>ServiceProvider</code> класс находится в <code>illuminate/support</code>
    пакете Composer, который вы должны добавить в зависимости вашего собственного пакета. Чтобы узнать больше о
    структуре и назначении поставщиков услуг, ознакомьтесь с <a href="providers">их документацией</a>.</p>
<p></p>
<h2 id="resources"><a href="#resources">Ресурсы</a></h2>
<p></p>
<h3 id="configuration"><a href="#configuration">Конфигурация</a></h3>
<p>Как правило, вам нужно будет опубликовать файл конфигурации вашего пакета в каталоге приложения <code>config</code>.
    Это позволит пользователям вашего пакета легко переопределить параметры конфигурации по умолчанию. Чтобы разрешить
    публикацию файлов конфигурации, вызовите <code>publishes</code> метод из <code>boot</code> метода вашего поставщика
    услуг:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Bootstrap any package services.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">boot</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">publishes</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
        <span class="token constant">__DIR__</span><span class="token punctuation">.</span><span
                class="token single-quoted-string string">'/../config/courier.php'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token function">config_path</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'courier.php'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Теперь, когда пользователи вашего пакета выполняют <code>vendor:publish</code> команду Laravel, ваш файл будет
    скопирован в указанное место публикации. После публикации вашей конфигурации к ее значениям можно будет получить
    доступ, как к любому другому файлу конфигурации:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$value</span> <span
                class="token operator">=</span> <span class="token function">config</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'courier.option'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Вы не должны определять замыкания в своих файлах конфигурации. Они не могут быть правильно сериализованы,
            когда пользователи выполняют команду <code>config:cache</code> Artisan.</p></p></div>
</blockquote>
<p></p>
<h4 id="default-package-configuration"><a href="#default-package-configuration">Конфигурация пакета по умолчанию</a>
</h4>
<p>Вы также можете объединить свой собственный файл конфигурации пакета с опубликованной копией приложения. Это позволит
    вашим пользователям определять только те параметры, которые они действительно хотят переопределить в опубликованной
    копии файла конфигурации. Чтобы объединить значения файла конфигурации, используйте <code>mergeConfigFrom</code>
    метод в методе вашего поставщика услуг <code>register</code>.</p>
<p><code>mergeConfigFrom</code> Метод принимает путь к файлу конфигурации вашего пакета в качестве первого аргумента и
    имя экземпляра приложения конфигурационного файла в качестве второго аргумента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Register any application services.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">register</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">mergeConfigFrom</span><span
                class="token punctuation">(</span>
        <span class="token constant">__DIR__</span><span class="token punctuation">.</span><span
                class="token single-quoted-string string">'/../config/courier.php'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'courier'</span>
    <span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Этот метод объединяет только первый уровень массива конфигурации. Если ваши пользователи частично определяют
            многомерный массив конфигурации, отсутствующие параметры не будут объединены.</p></p></div>
</blockquote>
<p></p>
<h3 id="routes"><a href="#routes">Маршруты</a></h3>
<p>Если ваш пакет содержит маршруты, вы можете загрузить их с помощью <code>loadRoutesFrom</code> метода. Этот метод
    автоматически определяет, кэшируются ли маршруты приложения, и не загружает ваш файл маршрутов, если маршруты уже
    были кэшированы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Bootstrap any package services.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">boot</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">loadRoutesFrom</span><span
                class="token punctuation">(</span><span class="token constant">__DIR__</span><span
                class="token punctuation">.</span><span
                class="token single-quoted-string string">'/../routes/web.php'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="migrations"><a href="#migrations">Миграции</a></h3>
<p>Если ваш пакет содержит <a href="migrations">миграции базы данных</a>, вы можете использовать этот <code>loadMigrationsFrom</code>
    метод, чтобы сообщить Laravel, как их загрузить. <code>loadMigrationsFrom</code> Метод принимает путь к миграции
    вашего пакета в качестве единственного аргумента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Bootstrap any package services.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">boot</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">loadMigrationsFrom</span><span
                class="token punctuation">(</span><span class="token constant">__DIR__</span><span
                class="token punctuation">.</span><span class="token single-quoted-string string">'/../database/migrations'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>После регистрации миграции вашего пакета они будут автоматически запускаться при выполнении <code>php artisan
        migrate</code> команды. Их не нужно экспортировать в <code>database/migrations</code> каталог приложения.</p>
<p></p>
<h3 id="translations"><a href="#translations">Переводы</a></h3>
<p>Если ваш пакет содержит <a href="localization">файлы перевода</a>, вы можете использовать этот <code>loadTranslationsFrom</code>
    метод, чтобы сообщить Laravel, как их загрузить. Например, если ваш пакет назван <code>courier</code>, вы должны
    добавить в <code>boot</code> метод поставщика услуг следующее:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Bootstrap any package services.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">boot</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">loadTranslationsFrom</span><span
                class="token punctuation">(</span><span class="token constant">__DIR__</span><span
                class="token punctuation">.</span><span
                class="token single-quoted-string string">'/../resources/lang'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'courier'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>На переводы пакетов ссылаются с использованием <code>package::file.line</code> соглашения о синтаксисе. Итак, вы
    можете загрузить строку <code>courier</code> пакета <code>welcome</code> из <code>messages</code> файла следующим
    образом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">echo</span> <span
                class="token function">trans</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'courier::messages.welcome'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="publishing-translations"><a href="#publishing-translations">Публикация переводов</a></h4>
<p>Если вы хотите опубликовать переводы вашего пакета в <code>resources/lang/vendor</code> каталоге приложения, вы
    можете использовать метод поставщика услуг <code>publishes</code>. <code>publishes</code> Метод принимает массив
    путей пакетов и их желаемых публиковать места. Например, чтобы опубликовать файлы перевода для <code>courier</code>
    пакета, вы можете сделать следующее:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Bootstrap any package services.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">boot</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">loadTranslationsFrom</span><span
                class="token punctuation">(</span><span class="token constant">__DIR__</span><span
                class="token punctuation">.</span><span
                class="token single-quoted-string string">'/../resources/lang'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'courier'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
    
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">publishes</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
        <span class="token constant">__DIR__</span><span class="token punctuation">.</span><span
                class="token single-quoted-string string">'/../resources/lang'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token function">resource_path</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'lang/vendor/courier'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Теперь, когда пользователи вашего пакета выполняют <code>vendor:publish</code> команду Artisan Laravel, переводы
    вашего пакета будут опубликованы в указанном месте публикации.</p>
<p></p>
<h3 id="views"><a href="#views">Представления</a></h3>
<p>Для регистрации своего пакета, открывается <a href="views">вид</a> с Laravel, вы должны сказать Laravel, где мнения
    расположены. Вы можете сделать это, используя метод поставщика услуг <code>loadViewsFrom</code>.
    <code>loadViewsFrom</code> Метод принимает два аргумента: путь к шаблонам просмотра и имени вашего пакета. Например,
    если имя вашего пакета - это <code>courier</code>, вы должны добавить следующее к <code>boot</code> методу вашего
    поставщика услуг:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Bootstrap any package services.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">boot</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">loadViewsFrom</span><span
                class="token punctuation">(</span><span class="token constant">__DIR__</span><span
                class="token punctuation">.</span><span
                class="token single-quoted-string string">'/../resources/views'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'courier'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>На представления пакетов ссылаются с использованием <code>package::view</code> соглашения о синтаксисе. Итак, как
    только ваш путь просмотра будет зарегистрирован у поставщика услуг, вы можете загрузить <code>admin</code>
    представление из <code>courier</code> пакета следующим образом:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'/dashboard'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token function">view</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'courier::dashboard'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="overriding-package-views"><a href="#overriding-package-views">Переопределение представлений пакета</a></h4>
<p>Когда вы используете этот <code>loadViewsFrom</code> метод, Laravel фактически регистрирует два местоположения для
    ваших представлений: <code>resources/views/vendor</code> каталог приложения и указанный вами каталог. Итак,
    используя <code>courier</code> пакет в качестве примера, Laravel сначала проверит, была ли пользовательская версия
    представления помещена в <code>resources/views/vendor/courier</code> каталог разработчиком. Затем, если
    представление не было настроено, Laravel будет искать каталог представления пакета, который вы указали при вызове
    <code>loadViewsFrom</code>. Это позволяет пользователям пакета легко настраивать / переопределять представления
    вашего пакета.</p>
<p></p>
<h4 id="publishing-views"><a href="#publishing-views">Публикация просмотров</a></h4>
<p>Если вы хотите, чтобы ваши представления были доступны для публикации в <code>resources/views/vendor</code> каталоге
    приложения, вы можете использовать метод поставщика услуг <code>publishes</code>. <code>publishes</code> Метод
    принимает массив просмотреть пакет путей и их желаемым публиковать место:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Bootstrap the package services.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">boot</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">loadViewsFrom</span><span
                class="token punctuation">(</span><span class="token constant">__DIR__</span><span
                class="token punctuation">.</span><span
                class="token single-quoted-string string">'/../resources/views'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'courier'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
    
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">publishes</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
        <span class="token constant">__DIR__</span><span class="token punctuation">.</span><span
                class="token single-quoted-string string">'/../resources/views'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token function">resource_path</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'views/vendor/courier'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Теперь, когда пользователи вашего пакета выполняют <code>vendor:publish</code> команду Artisan Laravel, представления
    вашего пакета будут скопированы в указанное место публикации.</p>
<p></p>
<h3 id="view-components"><a href="#view-components">Компоненты представлений</a></h3>
<p>Если ваш пакет содержит <a href="blade#components">компоненты представления</a>, вы можете использовать этот <code>loadViewComponentsAs</code>
    метод, чтобы сообщить Laravel, как их загрузить. <code>loadViewComponentsAs</code> Метод принимает два аргумента:
    тег префикс для компонентов просмотра и массив ваших просмотра имен классов компонентов. Например, если префикс
    вашего пакета - <code>courier</code> и у вас есть <code>Alert</code> и <code>Button</code> просматриваются
    компоненты, вы должны добавить следующее к <code>boot</code> методу вашего поставщика услуг:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Courier<span class="token punctuation">\</span>Components<span
                    class="token punctuation">\</span>Alert</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Courier<span class="token punctuation">\</span>Components<span
                    class="token punctuation">\</span>Button</span><span class="token punctuation">;</span>

<span class="token comment">/**
 * Bootstrap any package services.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">boot</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">loadViewComponentsAs</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'courier'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
        Alert<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
        Button<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>После того, как ваши компоненты представления зарегистрированы у поставщика услуг, вы можете ссылаться на них в своем
    представлении следующим образом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>x<span
                class="token operator">-</span>courier<span class="token operator">-</span>alert <span
                class="token operator">/</span><span class="token operator">&gt;</span>

<span class="token operator">&lt;</span>x<span class="token operator">-</span>courier<span
                class="token operator">-</span>button <span class="token operator">/</span><span class="token operator">&gt;</span></code></pre>
<p></p>
<h4 id="anonymous-components"><a href="#anonymous-components">Анонимные компоненты</a></h4>
<p>Если ваш пакет содержит анонимные компоненты, они должны быть помещены в <code>components</code> каталог каталога
    "views" вашего пакета (как указано <code>loadViewsFrom</code> ). Затем вы можете отобразить их, добавив к имени
    компонента префикс пространства имен представления пакета:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>x<span
                class="token operator">-</span>courier<span class="token punctuation">:</span><span
                class="token punctuation">:</span>alert <span class="token operator">/</span><span
                class="token operator">&gt;</span></code></pre>
<p></p>
<h2 id="commands"><a href="#commands">Команды</a></h2>
<p>Чтобы зарегистрировать Artisan-команды вашего пакета в Laravel, вы можете использовать <code>commands</code> метод.
    Этот метод ожидает массив имен классов команд. После регистрации команд вы можете выполнять их с помощью <a
            href="artisan">Artisan CLI</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Courier<span class="token punctuation">\</span>Console<span
                    class="token punctuation">\</span>Commands<span
                    class="token punctuation">\</span>InstallCommand</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Courier<span class="token punctuation">\</span>Console<span
                    class="token punctuation">\</span>Commands<span
                    class="token punctuation">\</span>NetworkCommand</span><span class="token punctuation">;</span>

<span class="token comment">/**
 * Bootstrap any package services.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">boot</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">if</span> <span class="token punctuation">(</span><span
                class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">app</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">runningInConsole</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">commands</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
            InstallCommand<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span><span class="token punctuation">,</span>
            NetworkCommand<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span><span class="token punctuation">,</span>
        <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h2 id="public-assets"><a href="#public-assets">Общественные активы</a></h2>
<p>В вашем пакете могут быть такие ресурсы, как JavaScript, CSS и изображения. Чтобы опубликовать эти ресурсы в <code>public</code>
    каталоге приложения, используйте метод поставщика услуг <code>publishes</code>. В этом примере мы также добавим
    <code>public</code> тег группы активов, который можно использовать для простой публикации групп связанных активов:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Bootstrap any package services.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">boot</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">publishes</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
        <span class="token constant">__DIR__</span><span class="token punctuation">.</span><span
                class="token single-quoted-string string">'/../public'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">public_path</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'vendor/courier'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'public'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Теперь, когда пользователи вашего пакета выполнят <code>vendor:publish</code> команду, ваши ресурсы будут скопированы
    в указанное место публикации. Поскольку пользователям обычно требуется перезаписывать активы каждый раз при
    обновлении пакета, вы можете использовать <code>--force</code> флаг:</p>
<pre class=" language-php"><code class=" language-php">php artisan vendor<span class="token punctuation">:</span>publish <span
                class="token operator">--</span>tag<span class="token operator">=</span><span class="token keyword">public</span> <span
                class="token operator">--</span>force</code></pre>
<p></p>
<h2 id="publishing-file-groups"><a href="#publishing-file-groups">Публикация файловых групп</a></h2>
<p>Вы можете публиковать группы активов и ресурсов пакета отдельно. Например, вы можете разрешить своим пользователям
    публиковать файлы конфигурации вашего пакета без необходимости публиковать ресурсы вашего пакета. Вы можете сделать
    это, «пометив» их при вызове <code>publishes</code> метода от поставщика услуг пакета. Например, давайте используем
    теги для определения двух групп публикации ( <code>config</code> и <code>migrations</code> ) в <code>boot</code>
    методе поставщика услуг пакета:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Bootstrap any package services.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">boot</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">publishes</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
        <span class="token constant">__DIR__</span><span class="token punctuation">.</span><span
                class="token single-quoted-string string">'/../config/package.php'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token function">config_path</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'package.php'</span><span class="token punctuation">)</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'config'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">publishes</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
        <span class="token constant">__DIR__</span><span class="token punctuation">.</span><span
                class="token single-quoted-string string">'/../database/migrations/'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token function">database_path</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'migrations'</span><span class="token punctuation">)</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'migrations'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Теперь ваши пользователи могут публиковать эти группы отдельно, ссылаясь на их тег при выполнении <code>vendor:publish</code>
    команды:</p>
<pre class=" language-php"><code class=" language-php">php artisan vendor<span class="token punctuation">:</span>publish <span
                class="token operator">--</span>tag<span class="token operator">=</span>config</code></pre>
