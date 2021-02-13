<h1>Конфигурация</h1>
<ul>
    <li><a href="configuration#introduction">Вступление</a></li>
    <li><a href="configuration#environment-configuration">Конфигурация среды</a>
        <ul>
            <li><a href="configuration#environment-variable-types">Типы переменных среды</a></li>
            <li><a href="configuration#retrieving-environment-configuration">Получение конфигурации среды</a></li>
            <li><a href="configuration#determining-the-current-environment">Определение текущей среды</a></li>
        </ul>
    </li>
    <li><a href="configuration#accessing-configuration-values">Доступ к значениям конфигурации</a></li>
    <li><a href="configuration#configuration-caching">Кэширование конфигурации</a></li>
    <li><a href="configuration#debug-mode">Режим отладки</a></li>
    <li><a href="configuration#maintenance-mode">Режим технического обслуживания</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Все файлы конфигурации для фреймворка Laravel хранятся в <code>config</code> каталоге. Каждый параметр
    задокументирован, поэтому не стесняйтесь просматривать файлы и знакомиться с доступными вам вариантами.</p>
<p>Эти файлы конфигурации позволяют настраивать такие вещи, как информация о подключении к базе данных, информация о
    почтовом сервере, а также различные другие основные значения конфигурации, такие как часовой пояс приложения и ключ
    шифрования.</p>
<p></p>
<h2 id="environment-configuration"><a href="#environment-configuration">Конфигурация среды</a></h2>
<p>Часто бывает полезно иметь разные значения конфигурации в зависимости от среды, в которой выполняется приложение.
    Например, вы можете захотеть использовать локально другой драйвер кеша, чем на рабочем сервере.</p>
<p>Чтобы сделать это проще, Laravel использует библиотеку <a href="https://github.com/vlucas/phpdotenv">DotEnv</a> PHP.
    В новой установке Laravel корневой каталог вашего приложения будет содержать <code>.env.example</code> файл, который
    определяет многие общие переменные среды. В процессе установки Laravel этот файл будет автоматически скопирован в
    <code>.env</code>.</p>
<p><code>.env</code> Файл Laravel по умолчанию содержит некоторые общие значения конфигурации, которые могут отличаться
    в зависимости от того, работает ли ваше приложение локально или на производственном веб-сервере. Затем эти значения
    извлекаются из различных файлов конфигурации Laravel в <code>config</code> каталоге с помощью <code>env</code>
    функции Laravel.</p>
<p>Если вы работаете в команде, вы можете продолжить включение <code>.env.example</code> файла в свое приложение.
    Помещая значения-заполнители в пример файла конфигурации, другие разработчики в вашей команде могут четко видеть,
    какие переменные среды необходимы для запуска вашего приложения.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Любая переменная в вашем <code>.env</code> файле может быть переопределена внешними переменными среды, такими
            как переменные среды на уровне сервера или системы.</p></p></div>
</blockquote>
<p></p>
<h4 id="environment-file-security"><a href="#environment-file-security">Безопасность файлов среды</a></h4>
<p>Ваш <code>.env</code> файл не должен быть привязан к системе контроля версий вашего приложения, поскольку каждому
    разработчику / серверу, использующему ваше приложение, может потребоваться другая конфигурация среды. Более того,
    это будет угрозой безопасности в случае, если злоумышленник получит доступ к вашему репозиторию системы управления
    версиями, поскольку любые конфиденциальные учетные данные будут раскрыты.</p>
<p></p>
<h3 id="environment-variable-types"><a href="#environment-variable-types">Типы переменных среды</a></h3>
<p>Все переменные в ваших <code>.env</code> файлах обычно анализируются как строки, поэтому были созданы некоторые
    зарезервированные значения, позволяющие вам возвращать более широкий диапазон типов из <code>env()</code> функции:
</p>
<table>
    <thead>
    <tr>
        <th><code>.env</code> Ценить</th>
        <th><code>env()</code> Ценить</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td>истинный</td>
        <td>(булево) правда</td>
    </tr>
    <tr>
        <td>(истинный)</td>
        <td>(булево) правда</td>
    </tr>
    <tr>
        <td>ложный</td>
        <td>(булево) ложь</td>
    </tr>
    <tr>
        <td>(ложный)</td>
        <td>(булево) ложь</td>
    </tr>
    <tr>
        <td>пустой</td>
        <td>(нить) ''</td>
    </tr>
    <tr>
        <td>(пустой)</td>
        <td>(нить) ''</td>
    </tr>
    <tr>
        <td>ноль</td>
        <td>(ноль ноль</td>
    </tr>
    <tr>
        <td>(ноль)</td>
        <td>(ноль ноль</td>
    </tr>
    </tbody>
</table>
<p>Если вам нужно определить переменную среды со значением, содержащим пробелы, вы можете сделать это, заключив значение
    в двойные кавычки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token constant">APP_NAME</span><span
                class="token operator">=</span><span
                class="token double-quoted-string string">"My Application"</span></code></pre>
<p></p>
<h3 id="retrieving-environment-configuration"><a href="#retrieving-environment-configuration">Получение конфигурации
        среды</a></h3>
<p>Все переменные, перечисленные в этом файле, будут загружены в <code>$_ENV</code> суперглобал PHP, когда ваше
    приложение получит запрос. Однако вы можете использовать <code>env</code> помощник для получения значений из этих
    переменных в ваших файлах конфигурации. Фактически, если вы просмотрите файлы конфигурации Laravel, вы заметите, что
    многие параметры уже используют этот помощник:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'debug'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'APP_DEBUG'</span><span
                class="token punctuation">,</span> <span class="token boolean constant">false</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span></code></pre>
<p>Второе значение, переданное в <code>env</code> функцию, - это «значение по умолчанию». Это значение будет возвращено,
    если для данного ключа не существует переменной среды.</p>
<p></p>
<h3 id="determining-the-current-environment"><a href="#determining-the-current-environment">Определение текущей
        среды</a></h3>
<p>Текущая среда приложения определяется <code>APP_ENV</code> переменной из вашего <code>.env</code> файла. Вы можете
    получить доступ к этому значению с помощью <code>environment</code> метода на <code>App</code> <a href="facades">фасаде</a>
    :</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>App</span><span
                class="token punctuation">;</span>

<span class="token variable">$environment</span> <span class="token operator">=</span> App<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">environment</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы также можете передать аргументы <code>environment</code> методу, чтобы определить, соответствует ли среда
    заданному значению. Метод вернется, <code>true</code> если среда соответствует любому из заданных значений:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">if</span> <span
                class="token punctuation">(</span>App<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">environment</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'local'</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// The environment is local</span>
<span class="token punctuation">}</span>

<span class="token keyword">if</span> <span class="token punctuation">(</span>App<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">environment</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'local'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'staging'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// The environment is either local OR staging...</span>
<span class="token punctuation">}</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Текущее определение среды приложения можно переопределить, указав <code>APP_ENV</code> переменную среды на
            уровне сервера.</p></p></div>
</blockquote>
<p></p>
<h2 id="accessing-configuration-values"><a href="#accessing-configuration-values">Доступ к значениям конфигурации</a>
</h2>
<p>Вы можете легко получить доступ к своим значениям конфигурации с помощью глобальной <code>config</code>
    вспомогательной функции из любого места в вашем приложении. Доступ к значениям конфигурации можно получить с помощью
    синтаксиса «точка», который включает имя файла и параметр, к которому вы хотите получить доступ. Также может быть
    указано значение по умолчанию, которое будет возвращено, если параметр конфигурации не существует:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$value</span> <span
                class="token operator">=</span> <span class="token function">config</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'app.timezone'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// Retrieve a default value if the configuration value does not exist...</span>
<span class="token variable">$value</span> <span class="token operator">=</span> <span
                class="token function">config</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'app.timezone'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Asia/Seoul'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Чтобы установить значения конфигурации во время выполнения, передайте массив <code>config</code> помощнику:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">config</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'app.timezone'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'America/Chicago'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="configuration-caching"><a href="#configuration-caching">Кэширование конфигурации</a></h2>
<p>Чтобы ускорить работу вашего приложения, вы должны кэшировать все файлы конфигурации в один файл с помощью команды
    <code>config:cache</code> Artisan. Это объединит все параметры конфигурации вашего приложения в один файл, который
    может быть быстро загружен фреймворком.</p>
<p>Обычно вам следует запускать <code>php artisan config:cache</code> команду как часть производственного процесса
    развертывания. Команду не следует запускать во время локальной разработки, поскольку параметры конфигурации часто
    нужно будет изменять в ходе разработки вашего приложения.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Если вы выполняете <code>config:cache</code> команду в процессе развертывания, вы должны быть уверены, что
            вызываете <code>env</code> функцию только из своих файлов конфигурации. После кэширования конфигурации
            <code>.env</code> файл не будет загружен, и все вызовы <code>env</code> функции вернутся <code>null</code>.
        </p></p></div>
</blockquote>
<p></p>
<h2 id="debug-mode"><a href="#debug-mode">Режим отладки</a></h2>
<p>Параметр <code>debug</code> в вашем <code>config/app.php</code> файле конфигурации определяет, сколько информации об
    ошибке фактически отображается пользователю. По умолчанию этот параметр настроен на соблюдение значения <code>APP_DEBUG</code>
    переменной среды, которая хранится в вашем <code>.env</code> файле.</p>
<p>Для локальной разработки вы должны установить для <code>APP_DEBUG</code> переменной среды значение <code>true</code>.
    <strong>В вашей производственной среде это значение всегда должно быть <code>false</code>. Если для переменной
        задано значение <code>true</code> в рабочей среде, вы рискуете раскрыть конфиденциальные значения конфигурации
        конечным пользователям вашего приложения.</strong></p>
<p></p>
<h2 id="maintenance-mode"><a href="#maintenance-mode">Режим технического обслуживания</a></h2>
<p>Когда ваше приложение находится в режиме обслуживания, для всех запросов к вашему приложению будет отображаться
    настраиваемое представление. Это позволяет легко «отключить» ваше приложение во время его обновления или во время
    обслуживания. Проверка режима обслуживания включена в стек промежуточного программного обеспечения по умолчанию для
    вашего приложения. Если приложение находится в режиме обслуживания, <code>MaintenanceModeException</code> будет
    выдан код состояния 503.</p>
<p>Чтобы включить режим обслуживания, выполните <code>down</code> Artisan-команду:</p>
<pre class=" language-php"><code class=" language-php">php artisan down</code></pre>
<p>Вы также можете указать <code>retry</code> параметр для <code>down</code> команды, который будет установлен как
    значение <code>Retry-After</code> заголовка HTTP:</p>
<pre class=" language-php"><code class=" language-php">php artisan down <span class="token operator">--</span>retry<span
                class="token operator">=</span><span class="token number">60</span></code></pre>
<p></p>
<h4 id="bypassing-maintenance-mode"><a href="#bypassing-maintenance-mode">Обход режима обслуживания</a></h4>
<p>Даже находясь в режиме обслуживания, вы можете использовать <code>secret</code> опцию для указания токена обхода
    режима обслуживания:</p>
<pre class=" language-php"><code class=" language-php">php artisan down <span
                class="token operator">--</span>secret<span class="token operator">=</span><span
                class="token double-quoted-string string">"1630542a-246b-4b66-afa1-dd72a4c43515"</span></code></pre>
<p>После перевода приложения в режим обслуживания вы можете перейти к URL-адресу приложения, соответствующему этому
    токену, и Laravel выдаст вашему браузеру файл cookie обхода режима обслуживания:</p>
<pre class=" language-php"><code class=" language-php">https<span class="token punctuation">:</span><span
                class="token comment">//example.com/1630542a-246b-4b66-afa1-dd72a4c43515</span></code></pre>
<p>При доступе к этому скрытому маршруту вы будете перенаправлены на <code>/</code> маршрут приложения. Как только
    cookie будет отправлен вашему браузеру, вы сможете просматривать приложение в обычном режиме, как если бы оно не
    находилось в режиме обслуживания.</p>
<p></p>
<h4 id="pre-rendering-the-maintenance-mode-view"><a href="#pre-rendering-the-maintenance-mode-view">Предварительная
        визуализация представления режима обслуживания</a></h4>
<p>Если вы используете <code>php artisan down</code> команду во время развертывания, ваши пользователи могут иногда
    сталкиваться с ошибками, если они обращаются к приложению во время обновления ваших зависимостей Composer или других
    компонентов инфраструктуры. Это происходит потому, что значительная часть инфраструктуры Laravel должна загружаться,
    чтобы определить, находится ли ваше приложение в режиме обслуживания, и отобразить представление режима обслуживания
    с помощью механизма шаблонов.</p>
<p>По этой причине Laravel позволяет предварительно отобразить представление режима обслуживания, которое будет
    возвращено в самом начале цикла запроса. Это представление отображается перед загрузкой любой из зависимостей вашего
    приложения. Вы можете предварительно вынести шаблон по своему выбору с помощью <code>down</code> командования <code>render</code>
    опции:</p>
<pre class=" language-php"><code class=" language-php">php artisan down <span
                class="token operator">--</span>render<span class="token operator">=</span><span
                class="token double-quoted-string string">"errors::503"</span></code></pre>
<p></p>
<h4 id="redirecting-maintenance-mode-requests"><a href="#redirecting-maintenance-mode-requests">Перенаправление запросов
        режима обслуживания</a></h4>
<p>В режиме обслуживания Laravel будет отображать представление режима обслуживания для всех URL-адресов приложений, к
    которым пользователь пытается получить доступ. Если хотите, вы можете указать Laravel перенаправлять все запросы на
    определенный URL. Это можно сделать с помощью <code>redirect</code> опции. Например, вы можете перенаправить все
    запросы на <code>/</code> URI:</p>
<pre class=" language-php"><code class=" language-php">php artisan down <span
                class="token operator">--</span>redirect<span class="token operator">=</span><span
                class="token operator">/</span></code></pre>
<p></p>
<h4 id="disabling-maintenance-mode"><a href="#disabling-maintenance-mode">Отключение режима обслуживания</a></h4>
<p>Чтобы отключить режим обслуживания, используйте <code>up</code> команду:</p>
<pre class=" language-php"><code class=" language-php">php artisan up</code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Вы можете настроить шаблон режима обслуживания по умолчанию, определив свой собственный шаблон в <code>resources/views/errors/503.blade.php</code>.
        </p></p></div>
</blockquote>
<p></p>
<h4 id="maintenance-mode-queues"><a href="#maintenance-mode-queues">Режим обслуживания и очереди</a></h4>
<p>Пока ваше приложение находится в режиме обслуживания, <a href="queues">задания в очереди</a> не обрабатываются.
    Задания продолжат обрабатываться в обычном режиме после выхода приложения из режима обслуживания.</p>
<p></p>
<h4 id="alternatives-to-maintenance-mode"><a href="#alternatives-to-maintenance-mode">Альтернативы режиму
        обслуживания</a></h4>
<p>Поскольку режим обслуживания требует, чтобы ваше приложение простояло несколько секунд, рассмотрите альтернативы,
    такие как <a href="https://vapor.laravel.com/">Laravel Vapor</a> и <a href="https://envoyer.io/">Envoyer,</a> для
    выполнения развертывания с нулевым временем простоя с помощью Laravel.</p>
