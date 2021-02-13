<h1>Развертывание</h1>
<ul>
    <li><a href="deployment#introduction">Вступление</a></li>
    <li><a href="deployment#server-requirements">Требования к серверу</a></li>
    <li><a href="deployment#server-configuration">Конфигурация сервера</a>
        <ul>
            <li><a href="deployment#nginx">Nginx</a></li>
        </ul></li>
    <li><a href="deployment#optimization">Оптимизация</a>
        <ul>
            <li><a href="deployment#autoloader-optimization">Оптимизация автозагрузчика</a></li>
            <li><a href="deployment#optimizing-configuration-loading">Оптимизация загрузки конфигурации</a></li>
            <li><a href="deployment#optimizing-route-loading">Оптимизация загрузки маршрута</a></li>
            <li><a href="deployment#optimizing-view-loading">Оптимизация загрузки просмотра</a></li>
        </ul></li>
    <li><a href="deployment#debug-mode">Режим отладки</a></li>
    <li><a href="deployment#deploying-with-forge-or-vapor">Развертывание с помощью Forge / Vapor</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Когда вы будете готовы развернуть приложение Laravel в производственной среде, вы можете сделать несколько важных вещей, чтобы убедиться, что ваше приложение работает как можно более эффективно. В этом документе мы рассмотрим несколько отличных отправных точек, чтобы убедиться, что ваше приложение Laravel развернуто правильно.</p>
<p></p>
<h2 id="server-requirements"><a href="#server-requirements">Требования к серверу</a></h2>
<p>Фреймворк Laravel имеет несколько системных требований. Вы должны убедиться, что ваш веб-сервер имеет следующую минимальную версию PHP и расширения:</p>
<div class="content-list">
    <ul>
        <li>PHP &gt;= 7.3</li>
        <li>Расширение BCMath PHP</li>
        <li>Расширение Ctype PHP</li>
        <li>Расширение Fileinfo PHP</li>
        <li>Расширение JSON PHP</li>
        <li>Расширение Mbstring PHP</li>
        <li>Расширение OpenSSL PHP</li>
        <li>Расширение PDO PHP</li>
        <li>Расширение Tokenizer PHP</li>
        <li>Расширение XML PHP</li>
    </ul>
</div>
<p></p>
<h2 id="server-configuration"><a href="#server-configuration">Конфигурация сервера</a></h2>
<p></p>
<h3 id="nginx"><a href="#nginx">Nginx</a></h3>
<p>Если вы развертываете свое приложение на сервере, на котором работает Nginx, вы можете использовать следующий файл конфигурации в качестве отправной точки для настройки вашего веб-сервера. Скорее всего, этот файл нужно будет настроить в зависимости от конфигурации вашего сервера. <strong>Если вам нужна помощь в управлении вашим сервером, рассмотрите возможность использования собственной службы управления и развертывания серверов Laravel, такой как <a href="https://forge.laravel.com">Laravel Forge</a>.</strong></p>
<p>Убедитесь, что, как и в конфигурации ниже, ваш веб-сервер направляет все запросы в <code>public/index.php</code> файл вашего приложения. Никогда не следует пытаться переместить <code>index.php</code> файл в корень вашего проекта, поскольку обслуживание приложения из корня проекта откроет доступ ко многим конфиденциальным файлам конфигурации в общедоступный Интернет:</p>
<pre class=" language-php"><code class=" language-php">server <span class="token punctuation">{literal}{{/literal}</span>
    listen <span class="token number">80</span><span class="token punctuation">;</span>
    server_name example<span class="token punctuation">.</span>com<span class="token punctuation">;</span>
    root <span class="token operator">/</span>srv<span class="token operator">/</span>example<span class="token punctuation">.</span>com<span class="token operator">/</span><span class="token keyword">public</span><span class="token punctuation">;</span>
            
    add_header <span class="token constant">X</span><span class="token operator">-</span>Frame<span class="token operator">-</span>Options <span class="token double-quoted-string string">"SAMEORIGIN"</span><span class="token punctuation">;</span>
    add_header <span class="token constant">X</span><span class="token operator">-</span><span class="token constant">XSS</span><span class="token operator">-</span>Protection <span class="token double-quoted-string string">"1; mode=block"</span><span class="token punctuation">;</span>
    add_header <span class="token constant">X</span><span class="token operator">-</span>Content<span class="token operator">-</span>Type<span class="token operator">-</span>Options <span class="token double-quoted-string string">"nosniff"</span><span class="token punctuation">;</span>
            
    index index<span class="token punctuation">.</span>php<span class="token punctuation">;</span>
            
    charset utf<span class="token operator">-</span><span class="token number">8</span><span class="token punctuation">;</span>
            
    location <span class="token operator">/</span> <span class="token punctuation">{literal}{{/literal}</span>
        try_files <span class="token variable">$uri</span> <span class="token variable">$uri</span><span class="token operator">/</span> <span class="token operator">/</span>index<span class="token punctuation">.</span>php<span class="token operator">?</span><span class="token variable">$query_string</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
            
    location <span class="token operator">=</span> <span class="token operator">/</span>favicon<span class="token punctuation">.</span>ico <span class="token punctuation">{literal}{{/literal}</span> access_log off<span class="token punctuation">;</span> log_not_found off<span class="token punctuation">;</span> <span class="token punctuation">}</span>
    location <span class="token operator">=</span> <span class="token operator">/</span>robots<span class="token punctuation">.</span>txt  <span class="token punctuation">{literal}{{/literal}</span> access_log off<span class="token punctuation">;</span> log_not_found off<span class="token punctuation">;</span> <span class="token punctuation">}</span>
            
    error_page <span class="token number">404</span> <span class="token operator">/</span>index<span class="token punctuation">.</span>php<span class="token punctuation">;</span>
            
    location <span class="token operator">~</span> \<span class="token punctuation">.</span>php$ <span class="token punctuation">{literal}{{/literal}</span>
        fastcgi_pass unix<span class="token punctuation">:</span><span class="token operator">/</span><span class="token keyword">var</span><span class="token operator">/</span>run<span class="token operator">/</span>php<span class="token operator">/</span>php7<span class="token punctuation">.</span><span class="token number">4</span><span class="token operator">-</span>fpm<span class="token punctuation">.</span>sock<span class="token punctuation">;</span>
        fastcgi_param <span class="token constant">SCRIPT_FILENAME</span> <span class="token variable">$realpath_root</span><span class="token variable">$fastcgi_script_name</span><span class="token punctuation">;</span>
        <span class="token keyword">include</span> fastcgi_params<span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
            
    location <span class="token operator">~</span> <span class="token operator">/</span>\<span class="token punctuation">.</span><span class="token punctuation">(</span><span class="token operator">?</span><span class="token operator">!</span>well<span class="token operator">-</span>known<span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token operator">*</span> <span class="token punctuation">{literal}{{/literal}</span>
        deny all<span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h2 id="optimization"><a href="#optimization">Оптимизация</a></h2>
<p></p>
<h3 id="autoloader-optimization"><a href="#autoloader-optimization">Оптимизация автозагрузчика</a></h3>
<p>При развертывании в производственной среде убедитесь, что вы оптимизируете карту автозагрузчика классов Composer, чтобы Composer мог быстро найти нужный файл для загрузки для данного класса:</p>
<pre class=" language-php"><code class=" language-php">composer install <span class="token operator">--</span>optimize<span class="token operator">-</span>autoloader <span class="token operator">--</span>no<span class="token operator">-</span>dev</code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout"><div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div><p class="mb-0 lg:ml-6"><p>Помимо оптимизации автозагрузчика, вы всегда должны обязательно включать <code>composer.lock</code> файл в репозиторий системы управления версиями вашего проекта. Зависимости вашего проекта могут быть установлены намного быстрее при наличии <code>composer.lock</code> файла.</p></p></div>
</blockquote>
<p></p>
<h3 id="optimizing-configuration-loading"><a href="#optimizing-configuration-loading">Оптимизация загрузки конфигурации</a></h3>
<p>При развертывании приложения в производственной среде вы должны убедиться, что вы <code>config:cache</code> выполнили команду Artisan в процессе развертывания:</p>
<pre class=" language-php"><code class=" language-php">php artisan config<span class="token punctuation">:</span>cache</code></pre>
<p>Эта команда объединит все файлы конфигурации Laravel в один кешированный файл, что значительно сокращает количество обращений, которые фреймворк должен совершить к файловой системе при загрузке значений вашей конфигурации.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout"><div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img src="/img/callouts/exclamation.min.svg" class="opacity-75"></div><p class="mb-0 lg:ml-6"><p>Если вы выполняете <code>config:cache</code> команду в процессе развертывания, вы должны быть уверены, что вызываете <code>env</code> функцию только из своих файлов конфигурации. После кэширования конфигурации <code>.env</code> файл не будет загружен, и все вызовы <code>env</code> функции для <code>.env</code> переменных вернутся <code>null</code>.</p></p></div>
</blockquote>
<p></p>
<h3 id="optimizing-route-loading"><a href="#optimizing-route-loading">Оптимизация загрузки маршрута</a></h3>
<p>Если вы создаете большое приложение с множеством маршрутов, вам следует убедиться, что вы выполняете команду <code>route:cache</code> Artisan в процессе развертывания:</p>
<pre class=" language-php"><code class=" language-php">php artisan route<span class="token punctuation">:</span>cache</code></pre>
<p>Эта команда сокращает все ваши регистрации маршрутов до одного вызова метода в кэшированном файле, повышая производительность регистрации маршрутов при регистрации сотен маршрутов.</p>
<p></p>
<h3 id="optimizing-view-loading"><a href="#optimizing-view-loading">Оптимизация загрузки просмотра</a></h3>
<p>При развертывании приложения в производственной среде вы должны убедиться, что вы <code>view:cache</code> выполнили команду Artisan в процессе развертывания:</p>
<pre class=" language-php"><code class=" language-php">php artisan view<span class="token punctuation">:</span>cache</code></pre>
<p>Эта команда предварительно компилирует все ваши представления Blade, чтобы они не компилировались по запросу, повышая производительность каждого запроса, возвращающего представление.</p>
<p></p>
<h2 id="debug-mode"><a href="#debug-mode">Режим отладки</a></h2>
<p>Параметр отладки в файле конфигурации config / app.php определяет, сколько информации об ошибке фактически отображается пользователю. По умолчанию для этого параметра задано значение переменной среды APP_DEBUG, которая хранится в вашем файле.env.</p>
<p><strong>В вашей production-среде это значение всегда должно быть <code>false</code>. Если в продакшене для переменной <code>APP_DEBUG</code> установлено значение <code>true</code>, то вы рискуете раскрыть конфиденциальные значения конфигурации конечным пользователям вашего приложения.</strong></p>
<p></p>
<h2 id="deploying-with-forge-or-vapor"><a href="#deploying-with-forge-or-vapor">Развертывание с помощью Forge / Vapor</a></h2>
<p></p>
<h4 id="laravel-forge"><a href="#laravel-forge">Laravel Forge</a></h4>
<p>Если вы не совсем готовы управлять конфигурацией своего сервера или вам неудобно настраивать все различные службы, необходимые для запуска надежного приложения <a href="https://forge.laravel.com">Laravel</a>, <a href="https://forge.laravel.com">Laravel Forge</a> - прекрасная альтернатива.</p>
<p>Laravel Forge может создавать серверы у различных поставщиков инфраструктуры, таких как DigitalOcean, Linode, AWS и других. Кроме того, Forge устанавливает и управляет всеми инструментами, необходимыми для создания надежных приложений Laravel, таких как Nginx, MySQL, Redis, Memcached, Beanstalk и других.</p>
<p></p>
<h4 id="laravel-vapor"><a href="#laravel-vapor">Laravel Vapor</a></h4>
<p>Если вам нужна полностью бессерверная платформа развертывания с автоматическим масштабированием, настроенная для Laravel, попробуйте <a href="https://vapor.laravel.com">Laravel Vapor</a>. Laravel Vapor - это платформа для бессерверного развертывания Laravel, работающая на AWS. Запустите свою инфраструктуру Laravel на Vapor и влюбитесь в масштабируемую простоту бессерверной архитектуры. Laravel Vapor настроен создателями Laravel для беспрепятственной работы с фреймворком, поэтому вы можете продолжать писать свои приложения Laravel точно так же, как вы привыкли.</p> 
