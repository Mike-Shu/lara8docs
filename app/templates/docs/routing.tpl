<h1>Маршрутизация</h1>
<ul>
    <li><a href="routing#basic-routing">Базовая маршрутизация</a>
        <ul>
            <li><a href="routing#redirect-routes">Перенаправить маршруты</a></li>
            <li><a href="routing#view-routes">Посмотреть маршруты</a></li>
        </ul></li>
    <li><a href="routing#route-parameters">Параметры маршрута</a>
        <ul>
            <li><a href="routing#required-parameters">Обязательные параметры</a></li>
            <li><a href="routing#parameters-optional-parameters">Дополнительные параметры</a></li>
            <li><a href="routing#parameters-regular-expression-constraints">Ограничения регулярного выражения</a></li>
        </ul></li>
    <li><a href="routing#named-routes">Именованные маршруты</a></li>
    <li><a href="routing#route-groups">Группы маршрутов</a>
        <ul>
            <li><a href="routing#route-group-middleware">ПО промежуточного слоя</a></li>
            <li><a href="routing#route-group-subdomain-routing">Маршрутизация поддоменов</a></li>
            <li><a href="routing#route-group-prefixes">Префиксы маршрутов</a></li>
            <li><a href="routing#route-group-name-prefixes">Префиксы имени маршрута</a></li>
        </ul></li>
    <li><a href="routing#route-model-binding">Привязка модели маршрута</a>
        <ul>
            <li><a href="routing#implicit-binding">Неявная привязка</a></li>
            <li><a href="routing#explicit-binding">Явная привязка</a></li>
        </ul></li>
    <li><a href="routing#fallback-routes">Резервные маршруты</a></li>
    <li><a href="routing#rate-limiting">Ограничение скорости</a>
        <ul>
            <li><a href="routing#defining-rate-limiters">Определение ограничителей скорости</a></li>
            <li><a href="routing#attaching-rate-limiters-to-routes">Прикрепление ограничителей скорости к маршрутам</a></li>
        </ul></li>
    <li><a href="routing#form-method-spoofing">Спуфинг метода формы</a></li>
    <li><a href="routing#accessing-the-current-route">Доступ к текущему маршруту</a></li>
    <li><a href="routing#cors">Совместное использование ресурсов между источниками (CORS)</a></li>
    <li><a href="routing#route-caching">Кэширование маршрута</a></li>
</ul>
<p></p>
<h2 id="basic-routing"><a href="#basic-routing">Базовая маршрутизация</a></h2>
<p>Самые основные маршруты Laravel принимают URI и закрытие, обеспечивая очень простой и выразительный метод определения маршрутов и поведения без сложных файлов конфигурации маршрутизации:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Route</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/greeting'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token single-quoted-string string">'Hello World'</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="the-default-route-files"><a href="#the-default-route-files">Файлы маршрута по умолчанию</a></h4>
<p>Все маршруты Laravel определены в ваших файлах маршрутов, которые находятся в <code>routes</code> каталоге. Эти файлы автоматически загружаются вашим приложением <code>App\Providers\RouteServiceProvider</code>. Этот <code>routes/web.php</code> файл определяет маршруты для вашего веб-интерфейса. Этим маршрутам назначается <code>web</code> группа промежуточного программного обеспечения, которая обеспечивает такие функции, как состояние сеанса и защита CSRF. Маршруты в не <code>routes/api.php</code> сохраняют состояние и назначаются группе <code>api</code> промежуточного программного обеспечения.</p>
<p>Для большинства приложений вы начнете с определения маршрутов в вашем <code>routes/web.php</code> файле. <code>routes/web.php</code> Доступ к маршрутам, определенным в, можно получить, введя URL-адрес определенного маршрута в браузере. Например, вы можете получить доступ к следующему маршруту, перейдя <code>http://example.com/user</code> в своем браузере:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Http<span class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>UserController</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/user'</span><span class="token punctuation">,</span> <span class="token punctuation">[</span>UserController<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span class="token punctuation">,</span> <span class="token single-quoted-string string">'index'</span><span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Маршруты, определенные в <code>routes/api.php</code> файле, вложены в группу маршрутов расширением <code>RouteServiceProvider</code>. В этой группе <code>/api</code> префикс URI применяется автоматически, поэтому вам не нужно вручную применять его к каждому маршруту в файле. Вы можете изменить префикс и другие параметры группы маршрутов, изменив свой <code>RouteServiceProvider</code> класс.</p>
<p></p>
<h4 id="available-router-methods"><a href="#available-router-methods">Доступные методы маршрутизатора</a></h4>
<p>Маршрутизатор позволяет регистрировать маршруты, отвечающие на любой HTTP-глагол:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token variable">$uri</span><span class="token punctuation">,</span> <span class="token variable">$callback</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">post</span><span class="token punctuation">(</span><span class="token variable">$uri</span><span class="token punctuation">,</span> <span class="token variable">$callback</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">put</span><span class="token punctuation">(</span><span class="token variable">$uri</span><span class="token punctuation">,</span> <span class="token variable">$callback</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">patch</span><span class="token punctuation">(</span><span class="token variable">$uri</span><span class="token punctuation">,</span> <span class="token variable">$callback</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">delete</span><span class="token punctuation">(</span><span class="token variable">$uri</span><span class="token punctuation">,</span> <span class="token variable">$callback</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">options</span><span class="token punctuation">(</span><span class="token variable">$uri</span><span class="token punctuation">,</span> <span class="token variable">$callback</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Иногда вам может потребоваться зарегистрировать маршрут, который отвечает на несколько HTTP-глаголов. Вы можете сделать это с помощью <code>match</code> метода. Или вы даже можете зарегистрировать маршрут, который отвечает на все HTTP-команды, используя <code>any</code> метод:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">match</span><span class="token punctuation">(</span><span class="token punctuation">[</span><span class="token single-quoted-string string">'get'</span><span class="token punctuation">,</span> <span class="token single-quoted-string string">'post'</span><span class="token punctuation">]</span><span class="token punctuation">,</span> <span class="token single-quoted-string string">'/'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">any</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="dependency-injection"><a href="#dependency-injection">Внедрение зависимости</a></h4>
<p>Вы можете указать любые зависимости, необходимые для вашего маршрута, в сигнатуре обратного вызова вашего маршрута. Объявленные зависимости будут автоматически разрешены и введены в обратный вызов <a href="container">сервисным контейнером</a> Laravel. Например, вы можете указать <code>Illuminate\Http\Request</code> классу, чтобы текущий HTTP-запрос автоматически вставлялся в обратный вызов вашего маршрута:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/users'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span>Request <span class="token variable">$request</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="csrf-protection"><a href="#csrf-protection">CSRF защита</a></h4>
<p>Помните, что любые HTML - форму, указывающую <code>POST</code>, <code>PUT</code>, <code>PATCH</code>, или <code>DELETE</code> маршруты, которые определены в <code>web</code> файле маршруты должны включать маркер поле CSRF. В противном случае запрос будет отклонен. Вы можете прочитать больше о защите <a href="csrf">CSRF в документации CSRF</a> :</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>form method<span class="token operator">=</span><span class="token double-quoted-string string">"POST"</span> action<span class="token operator">=</span><span class="token double-quoted-string string">"/profile"</span><span class="token operator">&gt;</span>
    @csrf
    <span class="token punctuation">.</span><span class="token punctuation">.</span><span class="token punctuation">.</span>
<span class="token operator">&lt;</span><span class="token operator">/</span>form<span class="token operator">&gt;</span></code></pre>
<p></p>
<h3 id="redirect-routes"><a href="#redirect-routes">Перенаправить маршруты</a></h3>
<p>Если вы определяете маршрут, который перенаправляет на другой URI, вы можете использовать этот <code>Route::redirect</code> метод. Этот метод предоставляет удобный ярлык, так что вам не нужно определять полный маршрут или контроллер для выполнения простого перенаправления:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">redirect</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/here'</span><span class="token punctuation">,</span> <span class="token single-quoted-string string">'/there'</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>По умолчанию <code>Route::redirect</code> возвращает <code>302</code> код состояния. Вы можете настроить код состояния, используя необязательный третий параметр:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">redirect</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/here'</span><span class="token punctuation">,</span> <span class="token single-quoted-string string">'/there'</span><span class="token punctuation">,</span> <span class="token number">301</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Или вы можете использовать этот <code>Route::permanentRedirect</code> метод для возврата <code>301</code> кода состояния:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">permanentRedirect</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/here'</span><span class="token punctuation">,</span> <span class="token single-quoted-string string">'/there'</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout"><div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img src="/img/callouts/exclamation.min.svg" class="opacity-75"></div><p class="mb-0 lg:ml-6"><p>При использовании параметров маршрута в маршрутах перенаправления следующие параметры зарезервированы Laravel и не могут использоваться: <code>destination</code> и <code>status</code>.</p></p></div>
</blockquote>
<p></p>
<h3 id="view-routes"><a href="#view-routes">Посмотреть маршруты</a></h3>
<p>Если ваш маршрут должен возвращать только <a href="views">представление</a>, вы можете использовать этот <code>Route::view</code> метод. Как и <code>redirect</code> метод, этот метод предоставляет простой ярлык, поэтому вам не нужно определять полный маршрут или контроллер. <code>view</code> Метод принимает URI в качестве первого аргумента и имени представления в качестве второго аргумента. Кроме того, вы можете предоставить массив данных для передачи в представление в качестве необязательного третьего аргумента:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">view</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/welcome'</span><span class="token punctuation">,</span> <span class="token single-quoted-string string">'welcome'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">view</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/welcome'</span><span class="token punctuation">,</span> <span class="token single-quoted-string string">'welcome'</span><span class="token punctuation">,</span> <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token single-quoted-string string">'Taylor'</span><span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout"><div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img src="/img/callouts/exclamation.min.svg" class="opacity-75"></div><p class="mb-0 lg:ml-6"><p>При использовании параметров маршрута в поле зрения маршрутов, следующие параметры зарезервированы Laravel и не могут быть использованы: <code>view</code>, <code>data</code>, <code>status</code>, и <code>headers</code>.</p></p></div>
</blockquote>
<p></p>
<h2 id="route-parameters"><a href="#route-parameters">Параметры маршрута</a></h2>
<p></p>
<h3 id="required-parameters"><a href="#required-parameters">Обязательные параметры</a></h3>
<p>Иногда вам может потребоваться захватить сегменты URI в вашем маршруте. Например, вам может потребоваться захватить идентификатор пользователя из URL-адреса. Вы можете сделать это, указав параметры маршрута:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/user/{literal}{id}{/literal}'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token variable">{literal}$id{/literal}</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token single-quoted-string string">'User '</span><span class="token punctuation">.</span><span class="token variable">{literal}$id{/literal}</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете определить столько параметров маршрута, сколько требуется для вашего маршрута:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/posts/{literal}{post}{/literal}/comments/{literal}{comment}{/literal}'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token variable">{literal}$postId{/literal}</span><span class="token punctuation">,</span> <span class="token variable">{literal}$commentId{/literal}</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Параметры маршрута всегда заключаются в <code>{literal}{}{/literal}</code> фигурные скобки и должны состоять из буквенных символов. Подчеркивание ( <code>_</code> ) также допускается в именах параметров маршрута. Параметры маршрута вводятся в обратные вызовы маршрута / контроллеры в зависимости от их порядка - имена аргументов обратного вызова маршрута / контроллера не имеют значения.</p>
<p></p>
<h4 id="parameters-and-dependency-injection"><a href="#parameters-and-dependency-injection">Параметры и внедрение зависимостей</a></h4>
<p>Если ваш маршрут имеет зависимости, которые вы хотели бы, чтобы сервисный контейнер Laravel автоматически вставлял в обратный вызов вашего маршрута, вы должны указать свои параметры маршрута после ваших зависимостей:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/user/{literal}{id}{/literal}'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span>Request <span class="token variable">{literal}$request{/literal}</span><span class="token punctuation">,</span> <span class="token variable">{literal}$id{/literal}</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token single-quoted-string string">'User '</span><span class="token punctuation">.</span><span class="token variable">{literal}$id{/literal}</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="parameters-optional-parameters"><a href="#parameters-optional-parameters">Дополнительные параметры</a></h3>
<p>Иногда может потребоваться указать параметр маршрута, который не всегда может присутствовать в URI. Вы можете сделать это, поставив <code>?</code> отметку после имени параметра. Не забудьте присвоить соответствующей переменной маршрута значение по умолчанию:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/user/{literal}{name?}{/literal}'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token variable">{literal}$name{/literal}</span> <span class="token operator">=</span> <span class="token constant">null</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$name</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/user/{literal}{name?}{/literal}'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token variable">{literal}$name{/literal}</span> <span class="token operator">=</span> <span class="token single-quoted-string string">'John'</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$name</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="parameters-regular-expression-constraints"><a href="#parameters-regular-expression-constraints">Ограничения регулярного выражения</a></h3>
<p>Вы можете ограничить формат параметров вашего маршрута, используя <code>where</code> метод экземпляра маршрута. <code>where</code> Метод принимает имя параметра и регулярного выражения, определяющего, как должен ограничиваться параметр:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/user/{literal}{name}{/literal}'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token variable">{literal}$name{/literal}</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">where</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span class="token punctuation">,</span> <span class="token single-quoted-string string">'[A-Za-z]+'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/user/{literal}{id}{/literal}'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token variable">{literal}$id{/literal}</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">where</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'id'</span><span class="token punctuation">,</span> <span class="token single-quoted-string string">'[0-9]+'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/user/{literal}{id}{/literal}/{literal}{name}{/literal}'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token variable">{literal}$id{/literal}</span><span class="token punctuation">,</span> <span class="token variable">$name</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">where</span><span class="token punctuation">(</span><span class="token punctuation">[</span><span class="token single-quoted-string string">'id'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token single-quoted-string string">'[0-9]+'</span><span class="token punctuation">,</span> <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token single-quoted-string string">'[a-z]+'</span><span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Для удобства в некоторых часто используемых шаблонах регулярных выражений есть вспомогательные методы, которые позволяют быстро добавлять ограничения шаблонов к вашим маршрутам:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/user/{literal}{id}{/literal}/{literal}{name}{/literal}'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token variable">{literal}$id{/literal}</span><span class="token punctuation">,</span> <span class="token variable">$name</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">whereNumber</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'id'</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">whereAlpha</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/user/{literal}{name}{/literal}'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token variable">$name</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">whereAlphaNumeric</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/user/{literal}{id}{/literal}'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token variable">{literal}$id{/literal}</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">whereUuid</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'id'</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если входящий запрос не соответствует ограничениям шаблона маршрута, будет возвращен ответ HTTP 404.</p>
<p></p>
<h4 id="parameters-global-constraints"><a href="#parameters-global-constraints">Глобальные ограничения</a></h4>
<p>Если вы хотите, чтобы параметр маршрута всегда ограничивался данным регулярным выражением, вы можете использовать этот <code>pattern</code> метод. Вы должны определить эти шаблоны в <code>boot</code> методе вашего <code>App\Providers\RouteServiceProvider</code> класса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Define your route model bindings, pattern filters, etc.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">boot</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">pattern</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'id'</span><span class="token punctuation">,</span> <span class="token single-quoted-string string">'[0-9]+'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Как только шаблон определен, он автоматически применяется ко всем маршрутам, использующим это имя параметра:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/user/{literal}{id}{/literal}'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token variable">{literal}$id{/literal}</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// Only executed if {literal}{id}{/literal} is numeric...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="parameters-encoded-forward-slashes"><a href="#parameters-encoded-forward-slashes">Кодированные прямые косые черты</a></h4>
<p>Компонент маршрутизации Laravel позволяет всем символам, кроме <code>/</code> присутствующих в значениях параметров маршрута. Вы должны явно разрешить <code>/</code> быть частью вашего заполнителя, используя <code>where</code> регулярное выражение условия:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/search/{literal}{search}{/literal}'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token variable">$search</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$search</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">where</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'search'</span><span class="token punctuation">,</span> <span class="token single-quoted-string string">'.*'</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout"><div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img src="/img/callouts/exclamation.min.svg" class="opacity-75"></div><p class="mb-0 lg:ml-6"><p> Кодированные косые черты поддерживаются только в пределах последнего сегмента маршрута.</p></p></div>
</blockquote>
<p></p>
<h2 id="named-routes"><a href="#named-routes">Именованные маршруты</a></h2>
<p>Именованные маршруты позволяют удобно создавать URL-адреса или перенаправления для определенных маршрутов. Вы можете указать имя для маршрута, связав <code>name</code> метод с определением маршрута:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/user/profile'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">name</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'profile'</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы также можете указать имена маршрутов для действий контроллера:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span>
    <span class="token single-quoted-string string">'/user/profile'</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span>UserProfileController<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span class="token punctuation">,</span> <span class="token single-quoted-string string">'show'</span><span class="token punctuation">]</span>
<span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">name</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'profile'</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout"><div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img src="/img/callouts/exclamation.min.svg" class="opacity-75"></div><p class="mb-0 lg:ml-6"><p> Имена маршрутов всегда должны быть уникальными.</p></p></div>
</blockquote>
<p></p>
<h4 id="generating-urls-to-named-routes"><a href="#generating-urls-to-named-routes">Создание URL-адресов для именованных маршрутов</a></h4>
<p>После того, как вы присвоили имя данному маршруту, вы можете использовать имя маршрута при генерации URL-адресов или перенаправлений через Laravel <code>route</code> и <code>redirect</code> вспомогательные функции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">// Generating URLs...</span>
<span class="token variable">$url</span> <span class="token operator">=</span> <span class="token function">route</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'profile'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// Generating Redirects...</span>
<span class="token keyword">return</span> <span class="token function">redirect</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">route</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'profile'</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если именованный маршрут определяет параметры, вы можете передать их в качестве второго аргумента <code>route</code> функции. Указанные параметры будут автоматически вставлены в сгенерированный URL в их правильных местах:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/user/{literal}{id}{/literal}/profile'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token variable">{literal}$id{/literal}</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">name</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'profile'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$url</span> <span class="token operator">=</span> <span class="token function">route</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'profile'</span><span class="token punctuation">,</span> <span class="token punctuation">[</span><span class="token single-quoted-string string">'id'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token number">1</span><span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если вы передадите дополнительные параметры в массиве, эти пары ключ / значение будут автоматически добавлены в сгенерированную строку запроса URL:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/user/{literal}{id}{/literal}/profile'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token variable">{literal}$id{/literal}</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">name</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'profile'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$url</span> <span class="token operator">=</span> <span class="token function">route</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'profile'</span><span class="token punctuation">,</span> <span class="token punctuation">[</span><span class="token single-quoted-string string">'id'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token number">1</span><span class="token punctuation">,</span> <span class="token single-quoted-string string">'photos'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token single-quoted-string string">'yes'</span><span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// /user/1/profile?photos=yes</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout"><div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div><p class="mb-0 lg:ml-6"><p>Иногда вам может потребоваться указать значения по умолчанию для всего запроса для параметров URL, например, текущий языковой стандарт. Для этого вы можете использовать <a href="urls#default-values"><code>URL::defaults</code> метод</a>.</p></p></div>
</blockquote>
<p></p>
<h4 id="inspecting-the-current-route"><a href="#inspecting-the-current-route">Проверка текущего маршрута</a></h4>
<p>Если вы хотите определить, был ли текущий запрос направлен на заданный именованный маршрут, вы можете использовать этот <code>named</code> метод в экземпляре Route. Например, вы можете проверить имя текущего маршрута из промежуточного программного обеспечения маршрута:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Handle an incoming request.
 *
 * @param  \Illuminate\Http\Request  $request
 * @param  \Closure  $next
 * @return mixed
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">handle</span><span class="token punctuation">(</span><span class="token variable">$request</span><span class="token punctuation">,</span> Closure <span class="token variable">$next</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">route</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">named</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'profile'</span><span class="token punctuation">)</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//</span>
    <span class="token punctuation">}</span>
    
    <span class="token keyword">return</span> <span class="token variable">$next</span><span class="token punctuation">(</span><span class="token variable">$request</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h2 id="route-groups"><a href="#route-groups">Группы маршрутов</a></h2>
<p>Группы маршрутов позволяют совместно использовать атрибуты маршрута, такие как промежуточное программное обеспечение, по большому количеству маршрутов без необходимости определять эти атрибуты для каждого отдельного маршрута.</p>
<p>Вложенные группы пытаются разумно «объединить» атрибуты со своей родительской группой. Промежуточное ПО и <code>where</code> условия объединяются, а имена и префиксы добавляются. Разделители пространства имен и косая черта в префиксах URI автоматически добавляются там, где это необходимо.</p>
<p></p>
<h3 id="route-group-middleware"><a href="#route-group-middleware">ПО промежуточного слоя</a></h3>
<p>Чтобы назначить <a href="middleware">промежуточное ПО</a> для всех маршрутов в группе, вы можете использовать <code>middleware</code> метод до определения группы. Промежуточное ПО выполняется в том порядке, в котором они перечислены в массиве:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">middleware</span><span class="token punctuation">(</span><span class="token punctuation">[</span><span class="token single-quoted-string string">'first'</span><span class="token punctuation">,</span> <span class="token single-quoted-string string">'second'</span><span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">group</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">// Uses first &amp; second middleware...</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

    Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/user/profile'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">// Uses first &amp; second middleware...</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="route-group-subdomain-routing"><a href="#route-group-subdomain-routing">Маршрутизация поддоменов</a></h3>
<p>Группы маршрутов также могут использоваться для управления маршрутизацией поддоменов. Поддоменам могут быть назначены параметры маршрута, как и URI маршрута, что позволяет вам захватывать часть поддомена для использования в вашем маршруте или контроллере. Поддомен можно указать, вызвав <code>domain</code> метод перед определением группы:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">domain</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'{literal}{account}{/literal}.example.com'</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">group</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'user/{literal}{id}{/literal}'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token variable">$account</span><span class="token punctuation">,</span> <span class="token variable">{literal}$id{/literal}</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout"><div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img src="/img/callouts/exclamation.min.svg" class="opacity-75"></div><p class="mb-0 lg:ml-6"><p>Чтобы обеспечить доступность маршрутов поддоменов, вы должны зарегистрировать маршруты поддоменов перед регистрацией маршрутов корневого домена. Это предотвратит перезапись маршрутами корневого домена маршрутов поддоменов, имеющих одинаковый путь URI.</p></p></div>
</blockquote>
<p></p>
<h3 id="route-group-prefixes"><a href="#route-group-prefixes">Префиксы маршрутов</a></h3>
<p><code>prefix</code> Метод может быть использован в качестве префикса каждого маршрута в группе с заданной URI. Например, вы можете захотеть поставить перед всеми URI маршрутов в группе префикс <code>admin</code> :</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">prefix</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'admin'</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">group</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/users'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">// Matches The "/admin/users" URL</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="route-group-name-prefixes"><a href="#route-group-name-prefixes">Префиксы имени маршрута</a></h3>
<p><code>name</code> Метод может быть использован в качестве префикса имени каждого маршрута в группе с заданной строкой. Например, вы можете захотеть поставить перед всеми именами сгруппированных маршрутов префикс <code>admin</code>. Данная строка имеет префикс к имени маршрута точно в том виде, в котором он указан, поэтому мы обязательно предоставим завершающий <code>.</code> символ в префиксе:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">name</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'admin.'</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">group</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/users'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">// Route assigned name "admin.users"...</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">name</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="route-model-binding"><a href="#route-model-binding">Привязка модели маршрута</a></h2>
<p>При введении идентификатора модели в действие маршрута или контроллера вы часто будете запрашивать базу данных, чтобы получить модель, соответствующую этому идентификатору. Привязка модели маршрута Laravel обеспечивает удобный способ автоматического внедрения экземпляров модели непосредственно в ваши маршруты. Например, вместо того, чтобы вводить идентификатор пользователя, вы можете внедрить весь <code>User</code> экземпляр модели, который соответствует данному идентификатору.</p>
<p></p>
<h3 id="implicit-binding"><a href="#implicit-binding">Неявная привязка</a></h3>
<p>Laravel автоматически разрешает модели Eloquent, определенные в маршрутах или действиях контроллера, чьи имена переменных с указанием типа соответствуют имени сегмента маршрута. Например:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/users/{literal}{user}{/literal}'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span>User <span class="token variable">$user</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$user</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">email</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Поскольку <code>$user</code> тип переменной соответствует <code>App\Models\User</code> модели Eloquent, а имя переменной соответствует <code>{literal}{user}{/literal}</code> сегменту URI, Laravel автоматически внедрит экземпляр модели, идентификатор которого совпадает с соответствующим значением из URI запроса. Если соответствующий экземпляр модели не найден в базе данных, автоматически будет сгенерирован ответ HTTP 404.</p>
<p>Конечно, неявная привязка также возможна при использовании методов контроллера. Опять же, обратите внимание, что <code>{literal}{user}{/literal}</code> сегмент URI соответствует <code>$user</code> переменной в контроллере, которая содержит <code>App\Models\User</code> подсказку типа:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Http<span class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>UserController</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

<span class="token comment">// Route definition...</span>
Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/users/{literal}{user}{/literal}'</span><span class="token punctuation">,</span> <span class="token punctuation">[</span>UserController<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span class="token punctuation">,</span> <span class="token single-quoted-string string">'show'</span><span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// Controller method definition...</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">show</span><span class="token punctuation">(</span>User <span class="token variable">$user</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token function">view</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'user.profile'</span><span class="token punctuation">,</span> <span class="token punctuation">[</span><span class="token single-quoted-string string">'user'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token variable">$user</span><span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p> </p>
<h4 id="customizing-the-default-key-name"><a href="#customizing-the-default-key-name"><a href="#customizing-the-default-key-name">Настройка ключа</a></a></h4>
<p>Иногда вы можете захотеть разрешить модели Eloquent, используя столбец, отличный от <code>id</code>. Для этого вы можете указать столбец в определении параметра маршрута:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Models<span class="token punctuation">\</span>Post</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/posts/{literal}{post:slug}{/literal}'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span>Post <span class="token variable">{literal}$post{/literal}</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">{literal}$post{/literal}</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если вы хотите, чтобы привязка модели всегда использовала столбец базы данных, кроме <code>id</code> получения данного класса модели, вы можете переопределить <code>getRouteKeyName</code> метод в модели Eloquent:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the route key for the model.
 *
 * @return string
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">getRouteKeyName</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token single-quoted-string string">'slug'</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="implicit-model-binding-scoping"><a href="#implicit-model-binding-scoping">Пользовательские ключи и область действия</a></h4>
<p>При неявном связывании нескольких моделей Eloquent в одном определении маршрута, вы можете захотеть охватить вторую модель Eloquent так, чтобы она была дочерней по отношению к предыдущей модели Eloquent. Например, рассмотрим это определение маршрута, которое извлекает сообщение в блоге по слагу для определенного пользователя:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Models<span class="token punctuation">\</span>Post</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/users/{literal}{user}{/literal}/posts/{literal}{post:slug}{/literal}'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span>User <span class="token variable">$user</span><span class="token punctuation">,</span> Post <span class="token variable">{literal}$post{/literal}</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">{literal}$post{/literal}</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>При использовании настраиваемой неявной привязки с ключом в качестве параметра вложенного маршрута Laravel автоматически задает область запроса для получения вложенной модели своим родителем, используя соглашения, чтобы угадать имя отношения на родительском элементе. В этом случае предполагается, что <code>User</code> модель имеет указанное отношение <code>posts</code> (форма множественного числа от имени параметра маршрута), которое можно использовать для получения <code>Post</code> модели.</p>
<p></p>
<h4 id="customizing-missing-model-behavior"><a href="#customizing-missing-model-behavior">Настройка поведения отсутствующей модели</a></h4>
<p>Обычно ответ HTTP 404 генерируется, если не найдена неявно связанная модель. Однако вы можете настроить это поведение, вызвав <code>missing</code> метод при определении вашего маршрута. <code>missing</code> Метод принимает замыкание, которое будет вызываться, если неявно связанная модель не может быть найдено:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Http<span class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>LocationsController</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/locations/{literal}{location:slug}{/literal}'</span><span class="token punctuation">,</span> <span class="token punctuation">[</span>LocationsController<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span class="token punctuation">,</span> <span class="token single-quoted-string string">'show'</span><span class="token punctuation">]</span><span class="token punctuation">)</span>
       <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">name</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'locations.view'</span><span class="token punctuation">)</span>
       <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">missing</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span class="token punctuation">(</span>Request <span class="token variable">$request</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> Redirect<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">route</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'locations.index'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
       <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="explicit-binding"><a href="#explicit-binding">Явная привязка</a></h3>
<p>Вам не обязательно использовать неявное разрешение модели на основе соглашений Laravel, чтобы использовать привязку модели. Вы также можете явно определить, как параметры маршрута соответствуют моделям. Чтобы зарегистрировать явную привязку, используйте метод маршрутизатора, <code>model</code> чтобы указать класс для данного параметра. Вы должны определить свои явные привязки модели в начале <code>boot</code> метода вашего <code>RouteServiceProvider</code> класса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Route</span><span class="token punctuation">;</span>

<span class="token comment">/**
 * Define your route model bindings, pattern filters, etc.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">boot</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">model</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'user'</span><span class="token punctuation">,</span> User<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    
    <span class="token comment">//...</span>
<span class="token punctuation">}</span></code></pre>
<p>Затем определите маршрут, содержащий <code>{literal}{user}{/literal}</code> параметр:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/users/{literal}{user}{/literal}'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span>User <span class="token variable">$user</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Поскольку мы связали все <code>{literal}{user}{/literal}</code> параметры с <code>App\Models\User</code> моделью, экземпляр этого класса будет вставлен в маршрут. Так, например, запрос на <code>users/1</code> внедрение <code>User</code> экземпляра из базы данных с идентификатором <code>1</code>.</p>
<p>Если соответствующий экземпляр модели не найден в базе данных, автоматически будет сгенерирован HTTP-ответ 404.</p>
<p></p>
<h4 id="customizing-the-resolution-logic"><a href="#customizing-the-resolution-logic">Настройка логики разрешения</a></h4>
<p>Если вы хотите определить свою собственную логику разрешения привязки модели, вы можете использовать этот <code>Route::bind</code> метод. Замыкание, которое вы передаете <code>bind</code> методу, получит значение сегмента URI и должно вернуть экземпляр класса, который должен быть введен в маршрут. Опять же, эта настройка должна выполняться в <code>boot</code> методе вашего приложения <code>RouteServiceProvider</code> :</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Route</span><span class="token punctuation">;</span>

<span class="token comment">/**
 * Define your route model bindings, pattern filters, etc.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">boot</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">bind</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'user'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token variable">$value</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> User<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">where</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span class="token punctuation">,</span> <span class="token variable">$value</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">firstOrFail</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    
    <span class="token comment">//...</span>
<span class="token punctuation">}</span></code></pre>
<p>В качестве альтернативы вы можете переопределить <code>resolveRouteBinding</code> метод в своей модели Eloquent. Этот метод получит значение сегмента URI и должен вернуть экземпляр класса, который должен быть введен в маршрут:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Retrieve the model for a bound value.
 *
 * @param  mixed  $value
 * @param  string|null  $field
 * @return \Illuminate\Database\Eloquent\Model|null
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">resolveRouteBinding</span><span class="token punctuation">(</span><span class="token variable">$value</span><span class="token punctuation">,</span> <span class="token variable">$field</span> <span class="token operator">=</span> <span class="token constant">null</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">where</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span class="token punctuation">,</span> <span class="token variable">$value</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">firstOrFail</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Если в маршруте используется <a href="routing#implicit-model-binding-scoping">неявная область действия привязки</a>, этот <code>resolveChildRouteBinding</code> метод будет использоваться для разрешения дочерней привязки родительской модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Retrieve the child model for a bound value.
 *
 * @param  string  $childType
 * @param  mixed  $value
 * @param  string|null  $field
 * @return \Illuminate\Database\Eloquent\Model|null
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">resolveChildRouteBinding</span><span class="token punctuation">(</span><span class="token variable">$childType</span><span class="token punctuation">,</span> <span class="token variable">$value</span><span class="token punctuation">,</span> <span class="token variable">$field</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token keyword">parent</span><span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">resolveChildRouteBinding</span><span class="token punctuation">(</span><span class="token variable">$childType</span><span class="token punctuation">,</span> <span class="token variable">$value</span><span class="token punctuation">,</span> <span class="token variable">$field</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h2 id="fallback-routes"><a href="#fallback-routes">Резервные маршруты</a></h2>
<p>Используя этот <code>Route::fallback</code> метод, вы можете определить маршрут, который будет выполняться, когда ни один другой маршрут не соответствует входящему запросу. Как правило, необработанные запросы автоматически отображают страницу «404» через обработчик исключений вашего приложения. Однако, поскольку вы обычно определяете <code>fallback</code> маршрут в своем <code>routes/web.php</code> файле, все промежуточное ПО в группе <code>web</code> промежуточного программного обеспечения будет применяться к маршруту. При необходимости вы можете добавить дополнительное ПО промежуточного слоя к этому маршруту:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">fallback</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout"><div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img src="/img/callouts/exclamation.min.svg" class="opacity-75"></div><p class="mb-0 lg:ml-6"><p> Резервный маршрут всегда должен быть последним маршрутом, зарегистрированным вашим приложением.</p></p></div>
</blockquote>
<p></p>
<h2 id="rate-limiting"><a href="#rate-limiting">Ограничение скорости</a></h2>
<p></p>
<h3 id="defining-rate-limiters"><a href="#defining-rate-limiters">Определение ограничителей скорости</a></h3>
<p>Laravel включает мощные и настраиваемые службы ограничения скорости, которые вы можете использовать для ограничения объема трафика для данного маршрута или группы маршрутов. Для начала вы должны определить конфигурации ограничителя скорости, которые соответствуют потребностям вашего приложения. Как правило, это следует делать в рамках <code>configureRateLimiting</code> метода класса вашего приложения <code>App\Providers\RouteServiceProvider</code>.</p>
<p>Ограничители скорости определяются с помощью метода <code>RateLimiter</code> фасада <code>for</code>. <code>for</code> Метод принимает имя ограничителя скорости и замыкание, которое возвращает конфигурацию предела, который должен применяться к маршрутам, которые назначены на ограничитель скорости. Ограничение конфигурации - это экземпляры <code>Illuminate\Cache\RateLimiting\Limit</code> класса. Этот класс содержит полезные методы построения, чтобы вы могли быстро определить свой лимит. Имя ограничителя скорости может быть любой строкой по вашему желанию:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Cache<span class="token punctuation">\</span>RateLimiting<span class="token punctuation">\</span>Limit</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span class="token punctuation">\</span>Facades<span class="token punctuation">\</span>RateLimiter</span><span class="token punctuation">;</span>

<span class="token comment">/**
 * Configure the rate limiters for the application.
 *
 * @return void
 */</span>
<span class="token keyword">protected</span> <span class="token keyword">function</span> <span class="token function">configureRateLimiting</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    RateLimiter<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">for</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'global'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span>Request <span class="token variable">$request</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> Limit<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">perMinute</span><span class="token punctuation">(</span><span class="token number">1000</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Если входящий запрос превышает указанный предел скорости, Laravel автоматически вернет ответ с кодом состояния HTTP 429. Если вы хотите определить свой собственный ответ, который должен возвращать ограничение скорости, вы можете использовать <code>response</code> метод:</p>
<pre class=" language-php"><code class=" language-php">RateLimiter<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">for</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'global'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span>Request <span class="token variable">$request</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> Limit<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">perMinute</span><span class="token punctuation">(</span><span class="token number">1000</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">response</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> <span class="token function">response</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'Custom response...'</span><span class="token punctuation">,</span> <span class="token number">429</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Поскольку обратные вызовы ограничителя скорости получают экземпляр входящего HTTP-запроса, вы можете динамически создать соответствующее ограничение скорости на основе входящего запроса или аутентифицированного пользователя:</p>
<pre class=" language-php"><code class=" language-php">RateLimiter<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">for</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'uploads'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span>Request <span class="token variable">$request</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">user</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">vipCustomer</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token operator">?</span> Limit<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">none</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">:</span> Limit<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">perMinute</span><span class="token punctuation">(</span><span class="token number">100</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="segmenting-rate-limits"><a href="#segmenting-rate-limits">Пределы скорости сегментации</a></h4>
<p>Иногда вы можете захотеть сегментировать ограничения скорости на какое-то произвольное значение. Например, вы можете разрешить пользователям получать доступ к заданному маршруту 100 раз в минуту на каждый IP-адрес. Для этого вы можете использовать <code>by</code> метод при построении лимита скорости:</p>
<pre class=" language-php"><code class=" language-php">RateLimiter<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">for</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'uploads'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span>Request <span class="token variable">$request</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">user</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">vipCustomer</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token operator">?</span> Limit<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">none</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">:</span> Limit<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">perMinute</span><span class="token punctuation">(</span><span class="token number">100</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">by</span><span class="token punctuation">(</span><span class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">ip</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="multiple-rate-limits"><a href="#multiple-rate-limits">Множественные ограничения скорости</a></h4>
<p>При необходимости вы можете вернуть массив ограничений скорости для данной конфигурации ограничителя скорости. Каждое ограничение скорости будет оцениваться для маршрута в зависимости от порядка, в котором они размещены в массиве:</p>
<pre class=" language-php"><code class=" language-php">RateLimiter<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">for</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'login'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span>Request <span class="token variable">$request</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">[</span>
            Limit<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">perMinute</span><span class="token punctuation">(</span><span class="token number">500</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
            Limit<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">perMinute</span><span class="token punctuation">(</span><span class="token number">3</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">by</span><span class="token punctuation">(</span><span class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">input</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'email'</span><span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="attaching-rate-limiters-to-routes"><a href="#attaching-rate-limiters-to-routes">Прикрепление ограничителей скорости к маршрутам</a></h3>
<p>Ограничители скорости могут быть присоединены к маршрутам или группам маршрутов с помощью <code>throttle</code>  <a href="middleware">промежуточного программного обеспечения</a>. Промежуточное программное обеспечение дроссельной заслонки принимает имя ограничителя скорости, которое вы хотите назначить маршруту:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">middleware</span><span class="token punctuation">(</span><span class="token punctuation">[</span><span class="token single-quoted-string string">'throttle:uploads'</span><span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">group</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">post</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/audio'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
            
    Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">post</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/video'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="throttling-with-redis"><a href="#throttling-with-redis">Регулирование с помощью Redis</a></h4>
<p>Обычно <code>throttle</code> промежуточное ПО сопоставляется с <code>Illuminate\Routing\Middleware\ThrottleRequests</code> классом. Это отображение определяется в HTTP-ядре вашего приложения ( <code>App\Http\Kernel</code> ). Однако, если вы используете Redis в качестве драйвера кеша вашего приложения, вы можете изменить это сопоставление для использования <code>Illuminate\Routing\Middleware\ThrottleRequestsWithRedis</code> класса. Этот класс более эффективен при управлении ограничением скорости с помощью Redis:</p>
<pre class=" language-php"><code class=" language-php"><span class="token single-quoted-string string">'throttle'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> \<span class="token package">Illuminate<span class="token punctuation">\</span>Routing<span class="token punctuation">\</span>Middleware<span class="token punctuation">\</span>ThrottleRequestsWithRedis</span><span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span class="token punctuation">,</span></code></pre>
<p></p>
<h2 id="form-method-spoofing"><a href="#form-method-spoofing">Спуфинг метода формы</a></h2>
<p>HTML формы не поддерживают <code>PUT</code>, <code>PATCH</code> или <code>DELETE</code> действия. Таким образом, при определении <code>PUT</code>, <code>PATCH</code> или <code>DELETE</code> маршрутов, которые вызываются из HTML - формы, вам нужно будет добавить скрытое <code>_method</code> поле в форме. Значение, отправленное с <code>_method</code> полем, будет использоваться как метод HTTP-запроса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>form action<span class="token operator">=</span><span class="token double-quoted-string string">"/example"</span> method<span class="token operator">=</span><span class="token double-quoted-string string">"POST"</span><span class="token operator">&gt;</span>
    <span class="token operator">&lt;</span>input type<span class="token operator">=</span><span class="token double-quoted-string string">"hidden"</span> name<span class="token operator">=</span><span class="token double-quoted-string string">"_method"</span> value<span class="token operator">=</span><span class="token double-quoted-string string">"PUT"</span><span class="token operator">&gt;</span>
    <span class="token operator">&lt;</span>input type<span class="token operator">=</span><span class="token double-quoted-string string">"hidden"</span> name<span class="token operator">=</span><span class="token double-quoted-string string">"_token"</span> value<span class="token operator">=</span><span class="token double-quoted-string string">"{literal}{{ csrf_token() }}{/literal}"</span><span class="token operator">&gt;</span>
<span class="token operator">&lt;</span><span class="token operator">/</span>form<span class="token operator">&gt;</span></code></pre>
<p>Для удобства вы можете использовать <code>@method</code>  <a href="blade">директиву Blade</a> для создания <code>_method</code> поля ввода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>form action<span class="token operator">=</span><span class="token double-quoted-string string">"/example"</span> method<span class="token operator">=</span><span class="token double-quoted-string string">"POST"</span><span class="token operator">&gt;</span>
    @<span class="token function">method</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'PUT'</span><span class="token punctuation">)</span>
    @csrf
<span class="token operator">&lt;</span><span class="token operator">/</span>form<span class="token operator">&gt;</span></code></pre>
<p></p>
<h2 id="accessing-the-current-route"><a href="#accessing-the-current-route">Доступ к текущему маршруту</a></h2>
<p>Вы можете использовать <code>current</code>, <code>currentRouteName</code> и <code>currentRouteAction</code> методы на <code>Route</code> фасаде для доступа к информации о обработке входящего запроса маршрута:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Route</span><span class="token punctuation">;</span>

<span class="token variable">$route</span> <span class="token operator">=</span> Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">current</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span> <span class="token comment">// Illuminate\Routing\Route</span>
<span class="token variable">$name</span> <span class="token operator">=</span> Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">currentRouteName</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span> <span class="token comment">// string</span>
<span class="token variable">$action</span> <span class="token operator">=</span> Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">currentRouteAction</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span> <span class="token comment">// string</span></code></pre>
<p>Вы можете обратиться к документации по API и для <a href="https://laravel.com/api/8.x/Illuminate/Routing/Router.html">базового класса фасада маршрута</a> и <a href="https://laravel.com/api/8.x/Illuminate/Routing/Route.html">объекта маршрута</a> рассмотреть все методы, которые доступны на маршрутизатор и маршрутизации классов.</p>
<p></p>
<h2 id="cors"><a href="#cors">Совместное использование ресурсов между источниками (CORS)</a></h2>
<p>Laravel может автоматически отвечать на <code>OPTIONS</code> HTTP-запросы CORS со значениями, которые вы настраиваете. Все параметры CORS можно настроить в <code>config/cors.php</code> файле конфигурации вашего приложения. Эти <code>OPTIONS</code> запросы будут автоматически обрабатываться <code>HandleCors</code>  <a href="middleware">промежуточным слоем</a>, который включен по умолчанию в вашем глобальном стеке промежуточного программного обеспечения. Ваш глобальный стек промежуточного программного обеспечения находится в HTTP-ядре вашего приложения ( <code>App\Http\Kernel</code> ).</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout"><div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div><p class="mb-0 lg:ml-6"><p>Для получения дополнительной информации о заголовках CORS и CORS обратитесь к <a href="https://translate.google.com/website?sl=en&amp;tl=ru&amp;prev=search&amp;u=https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS%23The_HTTP_response_headers">веб-документации MDN по CORS</a>.</p></p></div>
</blockquote>
<p></p>
<h2 id="route-caching"><a href="#route-caching">Кэширование маршрута</a></h2>
<p>При развертывании вашего приложения в производственной среде вы должны воспользоваться кешем маршрутов Laravel. Использование кеша маршрутов значительно сократит время, необходимое для регистрации всех маршрутов вашего приложения. Чтобы сгенерировать кеш маршрута, выполните <code>route:cache</code> Artisan-команду:</p>
<pre class=" language-php"><code class=" language-php">php artisan route<span class="token punctuation">:</span>cache</code></pre>
<p>После выполнения этой команды ваш кешированный файл маршрутов будет загружаться при каждом запросе. Помните, что если вы добавляете какие-либо новые маршруты, вам нужно будет сгенерировать новый кеш маршрутов. Из-за этого вы должны запускать <code>route:cache</code> команду только во время развертывания проекта.</p>
<p>Вы можете использовать <code>route:clear</code> команду для очистки кеша маршрута:</p>
<pre class=" language-php"><code class=" language-php">php artisan route<span class="token punctuation">:</span>clear</code></pre>
