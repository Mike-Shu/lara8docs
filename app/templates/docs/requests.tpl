<h1>HTTP-запросы</h1>
<ul>
    <li><a href="requests#introduction">Вступление</a></li>
    <li><a href="requests#interacting-with-the-request">Взаимодействие с запросом</a>
        <ul>
            <li><a href="requests#accessing-the-request">Доступ к запросу</a></li>
            <li><a href="requests#request-path-and-method">Путь и метод запроса</a></li>
            <li><a href="requests#request-headers">Заголовки запроса</a></li>
            <li><a href="requests#request-ip-address">Запросить IP-адрес</a></li>
            <li><a href="requests#content-negotiation">Согласование содержания</a></li>
            <li><a href="requests#psr7-requests">PSR-7 Запросы</a></li>
        </ul>
    </li>
    <li><a href="requests#input">Вход</a>
        <ul>
            <li><a href="requests#retrieving-input">Получение ввода</a></li>
            <li><a href="requests#determining-if-input-is-present">Определение наличия ввода</a></li>
            <li><a href="requests#old-input">Старый ввод</a></li>
            <li><a href="requests#cookies">Печенье</a></li>
            <li><a href="requests#input-trimming-and-normalization">Обрезка и нормализация ввода</a></li>
        </ul>
    </li>
    <li><a href="requests#files">Файлы</a>
        <ul>
            <li><a href="requests#retrieving-uploaded-files">Получение загруженных файлов</a></li>
            <li><a href="requests#storing-uploaded-files">Хранение загруженных файлов</a></li>
        </ul>
    </li>
    <li><a href="requests#configuring-trusted-proxies">Настройка доверенных прокси</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p><code>Illuminate\Http\Request</code> Класс Laravel предоставляет объектно-ориентированный способ взаимодействия с
    текущим HTTP-запросом, обрабатываемым вашим приложением, а также для получения входных данных, файлов cookie и
    файлов, отправленных с запросом.</p>
<p></p>
<h2 id="interacting-with-the-request"><a href="#interacting-with-the-request">Взаимодействие с запросом</a></h2>
<p></p>
<h3 id="accessing-the-request"><a href="#accessing-the-request">Доступ к запросу</a></h3>
<p>Чтобы получить экземпляр текущего HTTP-запроса через внедрение зависимостей, вы должны ввести <code>Illuminate\Http\Request</code> класс
    в методе закрытия маршрута или контроллера. Экземпляр входящего запроса будет автоматически внедрен <a
            href="container">сервисным контейнером</a> Laravel:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">UserController</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Store a new user.
    *
    * @param  \Illuminate\Http\Request  $request
    * @return \Illuminate\Http\Response
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">store</span><span
                    class="token punctuation">(</span>Request <span class="token variable">$request</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$name</span> <span class="token operator">=</span> <span class="token variable">$request</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">input</span><span
                    class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token comment">//</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Как уже упоминалось, вы также можете указать <code>Illuminate\Http\Request</code> классу при закрытии маршрута.
    Сервисный контейнер автоматически вставит входящий запрос в закрытие при его выполнении:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span>Request <span
                class="token variable">$request</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="dependency-injection-route-parameters"><a href="#dependency-injection-route-parameters">Внедрение зависимостей и
        параметры маршрута</a></h4>
<p>Если ваш метод контроллера также ожидает ввода от параметра маршрута, вы должны указать параметры маршрута после
    других зависимостей. Например, если ваш маршрут определен так:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>UserController</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">put</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/user/{literal}{id}{/literal}'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>UserController<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'update'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы по-прежнему можете напечатать <code>Illuminate\Http\Request</code> и получить доступ к <code>id</code> параметру
    маршрута, определив свой метод контроллера следующим образом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">UserController</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Update the specified user.
    *
    * @param  \Illuminate\Http\Request  $request
    * @param  string  $id
    * @return \Illuminate\Http\Response
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">update</span><span
                    class="token punctuation">(</span>Request <span class="token variable">$request</span><span
                    class="token punctuation">,</span> <span class="token variable">$id</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h3 id="request-path-and-method"><a href="#request-path-and-method">Путь и метод запроса</a></h3>
<p><code>Illuminate\Http\Request</code> Экземпляр предоставляет различные методы для изучения входящего запроса HTTP и
    расширяет <code>Symfony\Component\HttpFoundation\Request</code> класс. Ниже мы обсудим несколько наиболее важных
    методов.</p>
<p></p>
<h4 id="retrieving-the-request-path"><a href="#retrieving-the-request-path">Получение пути запроса</a></h4>
<p><code>path</code> Метод возвращает информацию о пути в запросе. Итак, если входящий запрос нацелен <code>http://example.com/foo/bar</code>,
    <code>path</code> метод вернет <code>foo/bar</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$uri</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">path</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="inspecting-the-request-path"><a href="#inspecting-the-request-path">Проверка пути / маршрута запроса</a></h4>
<p>Этот <code>is</code> метод позволяет проверить, соответствует ли путь входящего запроса заданному шаблону. Вы можете
    использовать этот <code>*</code> символ как подстановочный знак при использовании этого метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">if</span> <span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">is</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'admin/*'</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p>Используя этот <code>routeIs</code> метод, вы можете определить, соответствует ли входящий запрос <a
            href="routing#named-routes">именованному маршруту</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">if</span> <span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">routeIs</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'admin.*'</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="retrieving-the-request-url"><a href="#retrieving-the-request-url">Получение URL-адреса запроса</a></h4>
<p>Чтобы получить полный URL-адрес входящего запроса, вы можете использовать методы <code>url</code> или
    <code>fullUrl</code>. <code>url</code> Метод возвращает URL без строки запроса, в то время как <code>fullUrl</code> метод
    включает в себя строку запроса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$url</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">url</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$urlWithQueryString</span> <span class="token operator">=</span> <span
                class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">fullUrl</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="retrieving-the-request-method"><a href="#retrieving-the-request-method">Получение метода запроса</a></h4>
<p><code>method</code> Метод возвращает глагол HTTP для запроса. Вы можете использовать этот <code>isMethod</code> метод,
    чтобы убедиться, что HTTP-команда соответствует заданной строке:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$method</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">method</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token keyword">if</span> <span class="token punctuation">(</span><span
                class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">isMethod</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'post'</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="request-headers"><a href="#request-headers">Заголовки запроса</a></h3>
<p>Вы можете получить заголовок запроса из <code>Illuminate\Http\Request</code> экземпляра с помощью <code>header</code> метода.
    Если заголовок отсутствует в запросе, <code>null</code> будет возвращен. Однако <code>header</code> метод принимает
    необязательный второй аргумент, который будет возвращен, если заголовок отсутствует в запросе:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$value</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">header</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'X-Header-Name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$value</span> <span class="token operator">=</span> <span
                class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">header</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'X-Header-Name'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'default'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p><code>hasHeader</code> Метод может быть использован, чтобы определить, если запрос содержит данный заголовок:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">if</span> <span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">hasHeader</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'X-Header-Name'</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p>Для удобства <code>bearerToken</code> может использоваться токен-носитель из <code>Authorization</code> заголовка. Если
    такого заголовка нет, будет возвращена пустая строка:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$token</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">bearerToken</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="request-ip-address"><a href="#request-ip-address">Запросить IP-адрес</a></h3>
<p>Этот <code>ip</code> метод можно использовать для получения IP-адреса клиента, который сделал запрос вашему
    приложению:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$ipAddress</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">ip</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="content-negotiation"><a href="#content-negotiation">Согласование содержания</a></h3>
<p>Laravel предоставляет несколько методов для проверки запрошенных типов содержимого входящего запроса через <code>Accept</code> заголовок.
    Во-первых, <code>getAcceptableContentTypes</code> метод вернет массив, содержащий все типы контента, принятые
    запросом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$contentTypes</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">getAcceptableContentTypes</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p><code>accepts</code> Метод принимает массив типов контента и возвращается, <code>true</code> если какие - либо из
    типов контента принимается по требованию. В противном случае <code>false</code> будет возвращено:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">if</span> <span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">accepts</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'text/html'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'application/json'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//...</span>
<span class="token punctuation">}</span></code></pre>
<p>Вы можете использовать этот <code>prefers</code> метод, чтобы определить, какой тип контента из заданного массива
    типов контента является наиболее предпочтительным для запроса. Если ни один из предоставленных типов содержимого не
    принят запросом, <code>null</code> будет возвращено:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$preferred</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">prefers</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'text/html'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'application/json'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Поскольку многие приложения обслуживают только HTML или JSON, вы можете использовать этот <code>expectsJson</code> метод,
    чтобы быстро определить, ожидает ли входящий запрос ответа JSON:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">if</span> <span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">expectsJson</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//...</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="psr7-requests"><a href="#psr7-requests">PSR-7 Запросы</a></h3>
<p>Стандарт <a href="https://www.php-fig.org/psr/psr-7/">PSR-7</a> определяет интерфейсы для HTTP-сообщений, включая
    запросы и ответы. Если вы хотите получить экземпляр запроса PSR-7 вместо запроса Laravel, вам сначала необходимо
    установить несколько библиотек. Laravel использует компонент <em>Symfony HTTP Message Bridge</em> для преобразования
    типичных запросов и ответов Laravel в реализации, совместимые с PSR-7:</p>
<pre class=" language-php"><code class=" language-php">composer <span class="token keyword">require</span> symfony<span
                class="token operator">/</span>psr<span class="token operator">-</span>http<span class="token operator">-</span>message<span
                class="token operator">-</span>bridge
composer <span class="token keyword">require</span> nyholm<span class="token operator">/</span>psr7</code></pre>
<p>После того, как вы установили эти библиотеки, вы можете получить запрос PSR-7, указав тип интерфейса запроса для
    вашего метода закрытия маршрута или контроллера:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Psr<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Message<span class="token punctuation">\</span>ServerRequestInterface</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span
                class="token punctuation">(</span>ServerRequestInterface <span
                class="token variable">$request</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p> Если вы вернете экземпляр ответа PSR-7 из маршрута или контроллера, он будет автоматически преобразован
            обратно в экземпляр ответа Laravel и отображаться платформой.</p></p></div>
</blockquote>
<p></p>
<h2 id="input"><a href="#input">Вход</a></h2>
<p></p>
<h3 id="retrieving-input"><a href="#retrieving-input">Получение ввода</a></h3>
<p></p>
<h4 id="retrieving-all-input-data"><a href="#retrieving-all-input-data">Получение всех входных данных</a></h4>
<p>Вы можете получить все входные данные входящего запроса с <code>array</code> помощью <code>all</code> метода. Этот
    метод можно использовать независимо от того, поступает ли входящий запрос из HTML-формы или является запросом XHR:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$input</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="retrieving-an-input-value"><a href="#retrieving-an-input-value">Получение входного значения</a></h4>
<p>Используя несколько простых методов, вы можете получить доступ ко всему пользовательскому вводу из вашего <code>Illuminate\Http\Request</code> экземпляра,
    не беспокоясь о том, какой HTTP-глагол использовался для запроса. Независимо от HTTP-глагола, этот
    <code>input</code> метод может использоваться для получения пользовательского ввода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$name</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">input</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете передать значение по умолчанию в качестве второго аргумента <code>input</code> метода. Это значение будет
    возвращено, если запрошенное входное значение отсутствует в запросе:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$name</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">input</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'Sally'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>При работе с формами, которые содержат входные данные массива, используйте "точечную" нотацию для доступа к
    массивам:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$name</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">input</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'products.0.name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$names</span> <span class="token operator">=</span> <span
                class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">input</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'products.*.name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете вызвать <code>input</code> метод без аргументов, чтобы получить все входные значения в виде ассоциативного
    массива:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$input</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">input</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="retrieving-input-from-the-query-string"><a href="#retrieving-input-from-the-query-string">Получение ввода из
        строки запроса</a></h4>
<p>В то время как <code>input</code> метод извлекает значения из всей полезной нагрузки запроса (включая строку запроса),
    <code>query</code> метод извлекает значения только из строки запроса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$name</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">query</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если данные значения запрошенной строки запроса отсутствуют, будет возвращен второй аргумент этого метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$name</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">query</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'Helen'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете вызвать <code>query</code> метод без каких-либо аргументов, чтобы получить все значения строки запроса в
    виде ассоциативного массива:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$query</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">query</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="retrieving-json-input-values"><a href="#retrieving-json-input-values">Получение входных значений JSON</a></h4>
<p>При отправке запросов JSON в ваше приложение вы можете получить доступ к данным JSON с помощью <code>input</code> метода,
    если для <code>Content-Type</code> заголовка запроса установлено значение <code>application/json</code>. Вы даже
    можете использовать синтаксис с точкой для извлечения значений, вложенных в массивы JSON:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$name</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">input</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'user.name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="retrieving-boolean-input-values"><a href="#retrieving-boolean-input-values">Получение логических входных
        значений</a></h4>
<p>При работе с элементами HTML, такими как флажки, ваше приложение может получать «правдивые» значения, которые на
    самом деле являются строками. Например, «верно» или «включено». Для удобства вы можете использовать этот <code>boolean</code> метод
    для получения этих значений как логических. В <code>boolean</code> метод возвращает <code>true</code> к 1, «1»,
    правда, «правда», «на», и «да». Все остальные значения вернутся <code>false</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$archived</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">boolean</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'archived'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="retrieving-input-via-dynamic-properties"><a href="#retrieving-input-via-dynamic-properties">Получение ввода
        через динамические свойства</a></h4>
<p>Вы также можете получить доступ к вводу пользователя, используя динамические свойства
    <code>Illuminate\Http\Request</code> экземпляра. Например, если одна из форм вашего приложения содержит
    <code>name</code> поле, вы можете получить доступ к значению поля следующим образом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$name</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">name</span><span class="token punctuation">;</span></code></pre>
<p>При использовании динамических свойств Laravel сначала будет искать значение параметра в полезной нагрузке запроса.
    Если его нет, Laravel будет искать поле в параметрах согласованного маршрута.</p>
<p></p>
<h4 id="retrieving-a-portion-of-the-input-data"><a href="#retrieving-a-portion-of-the-input-data">Получение части
        входных данных</a></h4>
<p>Если вам нужно получить подмножество входных данных, вы можете использовать <code>only</code> и <code>except</code> методу.
    Оба эти метода принимают один <code>array</code> или динамический список аргументов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$input</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">only</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'username'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'password'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$input</span> <span class="token operator">=</span> <span
                class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">only</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'username'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'password'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$input</span> <span class="token operator">=</span> <span
                class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">except</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span
                class="token single-quoted-string string">'credit_card'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$input</span> <span class="token operator">=</span> <span
                class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">except</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'credit_card'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p><code>only</code> Метод возвращает все пары ключ / значение, которые вы запрашиваете; однако он не вернет
            пары ключ / значение, которых нет в запросе.</p></p></div>
</blockquote>
<p></p>
<h3 id="determining-if-input-is-present"><a href="#determining-if-input-is-present">Определение наличия ввода</a></h3>
<p>Вы можете использовать этот <code>has</code> метод, чтобы определить, присутствует ли значение в запросе. В
    <code>has</code> метод возвращает, <code>true</code> если значение присутствует на запросе:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">if</span> <span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">has</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'name'</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p>При получении массива <code>has</code> метод определит, присутствуют ли все указанные значения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">if</span> <span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">has</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'email'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p><code>whenHas</code> Метод будет выполнять данное замыкание, если значение присутствует в запросе:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">whenHas</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$input</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>В <code>hasAny</code> метод возвращает, <code>true</code> если какой - либо из указанных значений присутствуют:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">if</span> <span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">hasAny</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'name'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'email'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p>Если вы хотите определить, присутствует ли значение в запросе и не является ли оно пустым, вы можете использовать
    <code>filled</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">if</span> <span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">filled</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p><code>whenFilled</code> Метод будет выполнять данное замыкание, если значение присутствует на запросе и не пусто:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">whenFilled</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$input</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Чтобы определить, отсутствует ли данный ключ в запросе, вы можете использовать <code>missing</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">if</span> <span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">missing</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="old-input"><a href="#old-input">Старый ввод</a></h3>
<p>Laravel позволяет вам сохранить ввод из одного запроса во время следующего запроса. Эта функция особенно полезна для
    повторного заполнения форм после обнаружения ошибок проверки. Однако, если вы используете встроенные <a
            href="validation">функции проверки</a> Laravel, возможно, вам не придется вручную использовать эти методы
    ввода данных сеанса напрямую, поскольку некоторые из встроенных средств проверки Laravel будут вызывать их
    автоматически.</p>
<p></p>
<h4 id="flashing-input-to-the-session"><a href="#flashing-input-to-the-session">Мигающий ввод для сеанса</a></h4>
<p><code>flash</code> Метод на <code>Illuminate\Http\Request</code> классе будет мигать текущий вход на <a href="session">сессию</a>
   , так что он доступен во время следующего запроса пользователя к приложению:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">flash</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы можете также использовать <code>flashOnly</code> и <code>flashExcept</code> методу прошить подмножество данных
    запроса на сессию. Эти методы полезны для хранения конфиденциальной информации, такой как пароли, вне сеанса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">flashOnly</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'username'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'email'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$request</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">flashExcept</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'password'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="flashing-input-then-redirecting"><a href="#flashing-input-then-redirecting">Мигающий ввод, затем
        перенаправление</a></h4>
<p>Поскольку вам часто требуется выполнить мигание ввода в сеанс, а затем перенаправить на предыдущую страницу, вы
    можете легко связать мигание ввода с перенаправлением, используя <code>withInput</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token function">redirect</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'form'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">withInput</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token keyword">return</span> <span class="token function">redirect</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">route</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'user.create'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">withInput</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token keyword">return</span> <span class="token function">redirect</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'form'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">withInput</span><span
                class="token punctuation">(</span>
    <span class="token variable">$request</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">except</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'password'</span><span
                class="token punctuation">)</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="retrieving-old-input"><a href="#retrieving-old-input">Получение старого ввода</a></h4>
<p>Чтобы получить флэш-ввод из предыдущего запроса, вызовите <code>old</code> метод для экземпляра <code>Illuminate\Http\Request</code>.
    <code>old</code> Метод будет тянуть ранее мелькнула входные данные из <a href="session">сессии</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$username</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">old</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'username'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Laravel также предоставляет глобального <code>old</code> помощника. Если вы показываете старый ввод в <a href="blade">шаблоне
        Blade</a>, удобнее использовать <code>old</code> помощник для повторного заполнения формы. Если для данного поля
    нет старых данных, <code>null</code> будет возвращено:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>input type<span
                class="token operator">=</span><span class="token double-quoted-string string">"text"</span> name<span
                class="token operator">=</span><span
                class="token double-quoted-string string">"username"</span> value<span
                class="token operator">=</span><span
                class="token double-quoted-string string">"{literal}{{ old('username') }}{/literal}"</span><span
                class="token operator">&gt;</span></code></pre>
<p></p>
<h3 id="cookies"><a href="#cookies">Печенье</a></h3>
<p></p>
<h4 id="retrieving-cookies-from-requests"><a href="#retrieving-cookies-from-requests">Получение файлов cookie из
        запросов</a></h4>
<p>Все файлы cookie, созданные фреймворком Laravel, зашифрованы и подписаны кодом аутентификации, что означает, что они
    будут считаться недействительными, если они были изменены клиентом. Чтобы получить значение cookie из запроса,
    используйте <code>cookie</code> метод <code>Illuminate\Http\Request</code> экземпляра:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$value</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">cookie</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="input-trimming-and-normalization"><a href="#input-trimming-and-normalization">Обрезка и нормализация ввода</a>
</h2>
<p>По умолчанию, Laravel включает <code>App\Http\Middleware\TrimStrings</code> и <code>App\Http\Middleware\ConvertEmptyStringsToNull</code> промежуточное
    программное обеспечение глобального стека промежуточного программного приложения. Эти промежуточные программы
    перечислены в глобальном стеке промежуточного программного обеспечения по <code>App\Http\Kernel</code> классам. Это
    промежуточное ПО будет автоматически обрезать все входящие строковые поля в запросе, а также преобразовывать любые
    пустые строковые поля в <code>null</code>. Это позволяет вам не беспокоиться об этих проблемах нормализации в ваших
    маршрутах и контроллерах.</p>
<p>Если вы хотите отключить это поведение, вы можете удалить два промежуточных программного обеспечения из стека
    промежуточного программного обеспечения вашего приложения, удалив их из <code>$middleware</code> свойства вашего
    <code>App\Http\Kernel</code> класса.</p>
<p></p>
<h2 id="files"><a href="#files">Файлы</a></h2>
<p></p>
<h3 id="retrieving-uploaded-files"><a href="#retrieving-uploaded-files">Получение загруженных файлов</a></h3>
<p>Вы можете получить загруженные файлы из <code>Illuminate\Http\Request</code> экземпляра, используя <code>file</code> метод
    или динамические свойства. <code>file</code> Метод возвращает экземпляр <code>Illuminate\Http\UploadedFile</code> класса,
    который расширяет PHP <code>SplFileInfo</code> класс и предоставляет множество методов для взаимодействия с файлом:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$file</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">file</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'photo'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$file</span> <span class="token operator">=</span> <span
                class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">photo</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете определить, присутствует ли файл в запросе, используя <code>hasFile</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">if</span> <span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">hasFile</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'photo'</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="validating-successful-uploads"><a href="#validating-successful-uploads">Проверка успешных загрузок</a></h4>
<p>Помимо проверки наличия файла, вы можете убедиться, что не было проблем с загрузкой файла с помощью
    <code>isValid</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">if</span> <span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">file</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'photo'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">isValid</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="file-paths-extensions"><a href="#file-paths-extensions">Пути к файлам и расширения</a></h4>
<p><code>UploadedFile</code> Класс также содержит методы для получения доступа полного пути к файлу и его расширения.
    <code>extension</code> Метод будет пытаться угадать расширение файла на основе его содержания. Это расширение может
    отличаться от расширения, предоставленного клиентом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$path</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">photo</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">path</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$extension</span> <span class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">photo</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">extension</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="other-file-methods"><a href="#other-file-methods">Другие файловые методы</a></h4>
<p>Для <code>UploadedFile</code> экземпляров доступно множество других методов. Проверьте <a
            href="https://api.symfony.com/master/Symfony/Component/HttpFoundation/File/UploadedFile.html">документацию
        по API для класса</a> для получения дополнительной информации относительно этих методов.</p>
<p></p>
<h3 id="storing-uploaded-files"><a href="#storing-uploaded-files">Хранение загруженных файлов</a></h3>
<p>Для хранения загруженного файла обычно используется одна из настроенных <a href="filesystem">файловых систем</a>. У
    <code>UploadedFile</code> класса есть <code>store</code> метод, который перемещает загруженный файл на один из ваших
    дисков, который может быть местом в вашей локальной файловой системе или облачным хранилищем, например Amazon S3.
</p>
<p><code>store</code> Метод принимает путь к файлу должен быть сохранен относительно сконфигурированный корневой
    директории в файловой системе в. Этот путь не должен содержать имени файла, поскольку в качестве имени файла будет
    автоматически создан уникальный идентификатор.</p>
<p><code>store</code> Метод также принимает необязательный второй аргумент для имени диска, который должен
    использоваться для хранения файла. Метод вернет путь к файлу относительно корня диска:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$path</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">photo</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">store</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'images'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$path</span> <span class="token operator">=</span> <span
                class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">photo</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">store</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'images'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'s3'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Если вы не хотите, чтобы имя файла создавалось автоматически, вы можете использовать <code>storeAs</code> метод,
    который принимает путь, имя файла и имя диска в качестве аргументов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$path</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">photo</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">storeAs</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'images'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'filename.jpg'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$path</span> <span class="token operator">=</span> <span
                class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">photo</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">storeAs</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'images'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'filename.jpg'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'s3'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Для получения дополнительной информации о хранилище файлов в Laravel ознакомьтесь с полной <a
                    href="filesystem">документацией по хранилищу файлов</a>.</p></p></div>
</blockquote>
<p></p>
<h2 id="configuring-trusted-proxies"><a href="#configuring-trusted-proxies">Настройка доверенных прокси</a></h2>
<p>При запуске ваших приложений за балансировщиком нагрузки, который завершает сертификаты TLS/SSL, вы можете
    заметить, что ваше приложение иногда не генерирует ссылки HTTPS при использовании <code>url</code> помощника. Обычно
    это происходит потому, что ваше приложение перенаправляет трафик от вашего балансировщика нагрузки на порт 80 и не
    знает, что оно должно генерировать безопасные ссылки.</p>
<p>Чтобы решить эту проблему, вы можете использовать <code>App\Http\Middleware\TrustProxies</code> промежуточное
    программное обеспечение, включенное в ваше приложение Laravel, которое позволяет вам быстро настраивать
    балансировщики нагрузки или прокси, которым ваше приложение должно доверять. Ваши доверенные прокси-серверы должны
    быть указаны в виде массива в <code>$proxies</code> собственности этого промежуточного программного обеспечения. В
    дополнение к настройке доверенных прокси вы можете настроить прокси, <code>$headers</code> которому следует доверять:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Middleware</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Fideloper<span class="token punctuation">\</span>Proxy<span
                        class="token punctuation">\</span>TrustProxies</span> <span class="token keyword">as</span> Middleware<span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">TrustProxies</span> <span class="token keyword">extends</span> <span
                    class="token class-name">Middleware</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * The trusted proxies for this application.
    *
    * @var string|array
    */</span>
    <span class="token keyword">protected</span> <span class="token variable">$proxies</span> <span
                    class="token operator">=</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'192.168.1.1'</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'192.168.1.2'</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">;</span>

    <span class="token comment">/**
    * The headers that should be used to detect proxies.
    *
    * @var int
    */</span>
    <span class="token keyword">protected</span> <span class="token variable">$headers</span> <span
                    class="token operator">=</span> Request<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token constant">HEADER_X_FORWARDED_FOR</span> <span
                    class="token operator">|</span> Request<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token constant">HEADER_X_FORWARDED_HOST</span> <span
                    class="token operator">|</span> Request<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token constant">HEADER_X_FORWARDED_PORT</span> <span
                    class="token operator">|</span> Request<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token constant">HEADER_X_FORWARDED_PROTO</span><span
                    class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Если вы используете AWS Elastic Load Balancing, ваша <code>$headers</code> ценность должна быть такой <code>Request::HEADER_X_FORWARDED_AWS_ELB</code>.
            Для получения дополнительной информации о константах, которые могут использоваться в <code>$headers</code> свойстве,
            ознакомьтесь с документацией Symfony по <a href="https://symfony.com/doc/current/deployment/proxies.html">доверительным
                прокси</a>.</p></p></div>
</blockquote>
<p></p>
<h4 id="trusting-all-proxies"><a href="#trusting-all-proxies">Доверять всем прокси</a></h4>
<p>Если вы используете Amazon AWS или другой поставщик «облачных» балансировщиков нагрузки, вы можете не знать IP-адреса
    своих фактических балансировщиков. В этом случае вы можете использовать <code>*</code> для доверия всем прокси:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * The trusted proxies for this application.
 *
 * @var string|array
 */</span>
<span class="token keyword">protected</span> <span class="token variable">$proxies</span> <span
                class="token operator">=</span> <span class="token single-quoted-string string">'*'</span><span
                class="token punctuation">;</span></code></pre>
