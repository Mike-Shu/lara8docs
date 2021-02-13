<h1>CSRF защита</h1>
<ul>
    <li><a href="csrf#csrf-introduction">Вступление</a></li>
    <li><a href="csrf#preventing-csrf-requests">Предотвращение запросов CSRF</a>
        <ul>
            <li><a href="csrf#csrf-excluding-uris">Исключение URI</a></li>
        </ul>
    </li>
    <li><a href="csrf#csrf-x-csrf-token">X-CSRF-токен</a></li>
    <li><a href="csrf#csrf-x-xsrf-token">X-XSRF-токен</a></li>
</ul>
<p></p>
<h2 id="csrf-introduction"><a href="#csrf-introduction">Вступление</a></h2>
<p>Подделка межсайтовых запросов - это разновидность вредоносного эксплойта, при котором неавторизованные команды
    выполняются от имени аутентифицированного пользователя. К счастью, Laravel позволяет легко защитить ваше приложение
    от атак с <a href="https://en.wikipedia.org/wiki/Cross-site_request_forgery">подделкой межсайтовых запросов</a>
    (CSRF).</p>
<p></p>
<h4 id="csrf-explanation"><a href="#csrf-explanation">Объяснение уязвимости</a></h4>
<p>Если вы не знакомы с подделками межсайтовых запросов, давайте обсудим пример того, как можно использовать эту
    уязвимость. Представьте, что у вашего приложения есть <code>/user/email</code> маршрут, который принимает
    <code>POST</code> запрос на изменение адреса электронной почты аутентифицированного пользователя. Скорее всего, этот
    маршрут ожидает, что <code>email</code> поле ввода будет содержать адрес электронной почты, который пользователь
    хотел бы начать использовать.</p>
<p>Без защиты CSRF вредоносный веб-сайт может создать HTML-форму, которая указывает на <code>/user/email</code> маршрут
    вашего приложения и отправляет собственный адрес электронной почты злонамеренного пользователя:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>form action<span
                class="token operator">=</span><span class="token double-quoted-string string">"https://your-application.com/user/email"</span> method<span
                class="token operator">=</span><span class="token double-quoted-string string">"POST"</span><span
                class="token operator">&gt;</span>
    <span class="token operator">&lt;</span>input type<span class="token operator">=</span><span
                class="token double-quoted-string string">"email"</span> value<span class="token operator">=</span><span
                class="token double-quoted-string string">"malicious-email@example.com"</span><span
                class="token operator">&gt;</span>
<span class="token operator">&lt;</span><span class="token operator">/</span>form<span
                class="token operator">&gt;</span>

<span class="token operator">&lt;</span>script<span class="token operator">&gt;</span>
    document<span class="token punctuation">.</span>forms<span class="token punctuation">[</span><span
            class="token number">0</span><span class="token punctuation">]</span><span
            class="token punctuation">.</span><span class="token function">submit</span><span class="token punctuation">(</span><span
            class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token operator">&lt;</span><span class="token operator">/</span>script<span
            class="token operator">&gt;</span></code></pre>
<p>Если вредоносный веб-сайт автоматически отправляет форму при загрузке страницы, злоумышленнику нужно только
    соблазнить ничего не подозревающего пользователя вашего приложения посетить свой веб-сайт, и его адрес электронной
    почты будет изменен в вашем приложении.</p>
<p>Чтобы предотвратить эту уязвимость, мы должны проверять каждый входящий <code>POST</code>, <code>PUT</code>, <code>PATCH</code> или
    <code>DELETE</code> запрос на секретную стоимость сеанса, что вредоносные приложения не в состоянии получить доступ.
</p>
<p></p>
<h2 id="preventing-csrf-requests"><a href="#preventing-csrf-requests">Предотвращение запросов CSRF</a></h2>
<p>Laravel автоматически генерирует «токен» CSRF для каждой активной <a href="session">пользовательской сессии,</a>
    управляемой приложением. Этот токен используется для проверки того, что аутентифицированный пользователь является
    лицом, действительно выполняющим запросы к приложению. Поскольку этот токен хранится в сеансе пользователя и
    изменяется каждый раз при повторном создании сеанса, вредоносное приложение не может получить к нему доступ.</p>
<p>К токену CSRF текущего сеанса можно получить доступ через сеанс запроса или через <code>csrf_token</code> вспомогательную
    функцию:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
            class="token function">get</span><span class="token punctuation">(</span><span
            class="token single-quoted-string string">'/token'</span><span class="token punctuation">,</span> <span
            class="token keyword">function</span> <span class="token punctuation">(</span>Request <span
            class="token variable">$request</span><span class="token punctuation">)</span> <span
            class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$token</span> <span class="token operator">=</span> <span
            class="token variable">$request</span><span class="token operator">-</span><span
            class="token operator">&gt;</span><span class="token function">session</span><span
            class="token punctuation">(</span><span class="token punctuation">)</span><span
            class="token operator">-</span><span class="token operator">&gt;</span><span
            class="token function">token</span><span class="token punctuation">(</span><span
            class="token punctuation">)</span><span class="token punctuation">;</span>
            
    <span class="token variable">$token</span> <span class="token operator">=</span> <span
                        class="token function">csrf_token</span><span class="token punctuation">(</span><span
                        class="token punctuation">)</span><span class="token punctuation">;</span>
            
    <span class="token comment">//...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                        class="token punctuation">;</span></code></pre>
<p>Каждый раз, когда вы определяете HTML-форму в своем приложении, вы должны включать в форму скрытое
    <code>_token</code> поле CSRF, чтобы промежуточное ПО защиты CSRF могло проверить запрос. Для удобства вы можете
    использовать <code>@csrf</code> директиву Blade для генерации поля ввода скрытого токена:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>form method<span
                class="token operator">=</span><span class="token double-quoted-string string">"POST"</span> action<span
                class="token operator">=</span><span class="token double-quoted-string string">"/profile"</span><span
                class="token operator">&gt;</span>
    @csrf

    <span class="token operator">&lt;</span><span class="token operator">!</span><span class="token operator">--</span> Equivalent to<span
            class="token punctuation">.</span><span class="token punctuation">.</span><span
            class="token punctuation">.</span> <span class="token operator">--</span><span
            class="token operator">&gt;</span>
    <span class="token operator">&lt;</span>input type<span class="token operator">=</span><span
            class="token double-quoted-string string">"hidden"</span> name<span class="token operator">=</span><span
            class="token double-quoted-string string">"_token"</span> value<span class="token operator">=</span><span
            class="token double-quoted-string string">"{literal}{{ csrf_token() }}{/literal}"</span> <span
            class="token operator">/</span><span class="token operator">&gt;</span>
<span class="token operator">&lt;</span><span class="token operator">/</span>form<span
            class="token operator">&gt;</span></code></pre>
<p><code>App\Http\Middleware\VerifyCsrfToken</code>  <a href="middleware">Промежуточный слой</a>, который входит в
    <code>web</code> группе промежуточного слоя по умолчанию, будет автоматически проверять, что маркер на входе запроса
    соответствует маркеру хранится в сессии. Когда эти два токена совпадают, мы знаем, что аутентифицированный
    пользователь инициирует запрос.</p>
<p></p>
<h3 id="csrf-tokens-and-spas"><a href="#csrf-tokens-and-spas">Токены CSRF и SPAs</a></h3>
<p>Если вы создаете SPA, который использует Laravel в качестве серверной части API, вам следует обратиться к <a
            href="sanctum">документации Laravel Sanctum</a> для получения информации об аутентификации с помощью вашего
    API и защите от уязвимостей CSRF.</p>
<p></p>
<h3 id="csrf-excluding-uris"><a href="#csrf-excluding-uris">Исключение URI из защиты CSRF</a></h3>
<p>Иногда вы можете захотеть исключить набор URI из защиты CSRF. Например, если вы используете <a
            href="https://stripe.com/">Stripe</a> для обработки платежей и используете их систему веб-перехватчиков, вам
    нужно будет исключить свой маршрут обработчика веб-перехватчиков Stripe из защиты CSRF, поскольку Stripe не будет
    знать, какой токен CSRF отправлять на ваши маршруты.</p>
<p>Обычно такие маршруты следует размещать вне группы <code>web</code> промежуточного программного обеспечения, которая
    <code>App\Providers\RouteServiceProvider</code> применяется ко всем маршрутам в <code>routes/web.php</code> файле.
    Однако вы также можете исключить маршруты, добавив их URI в <code>$except</code> свойство
    <code>VerifyCsrfToken</code> промежуточного программного обеспечения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Middleware</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Http<span class="token punctuation">\</span>Middleware<span
                        class="token punctuation">\</span>VerifyCsrfToken</span> <span class="token keyword">as</span> Middleware<span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">VerifyCsrfToken</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Middleware</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * The URIs that should be excluded from CSRF verification.
    *
    * @var array
    */</span>
    <span class="token keyword">protected</span> <span class="token variable">$except</span> <span
                    class="token operator">=</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'stripe/*'</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'http://example.com/foo/bar'</span><span
                    class="token punctuation">,</span>
        <span class="token single-quoted-string string">'http://example.com/foo/*'</span><span
                    class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Для удобства промежуточное ПО CSRF автоматически отключается для всех маршрутов при <a href="testing">запуске
                тестов</a>.</p></p></div>
</blockquote>
<p></p>
<h2 id="csrf-x-csrf-token"><a href="#csrf-x-csrf-token">X-CSRF-TOKEN</a></h2>
<p>Помимо проверки токена CSRF в качестве параметра POST, <code>App\Http\Middleware\VerifyCsrfToken</code> промежуточное
    ПО также проверяет <code>X-CSRF-TOKEN</code> заголовок запроса. Вы можете, например, сохранить токен в
    <code>meta</code> теге HTML :</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>meta name<span
                class="token operator">=</span><span class="token double-quoted-string string">"csrf-token"</span> content<span
                class="token operator">=</span><span
                class="token double-quoted-string string">"{literal}{{ csrf_token() }}{/literal}"</span><span
                class="token operator">&gt;</span></code></pre>
<p>Затем вы можете указать библиотеке, такой как jQuery, автоматически добавлять токен во все заголовки запросов. Это
    обеспечивает простую и удобную защиту CSRF для ваших приложений на основе AJAX с использованием устаревшей
    технологии JavaScript:</p>
<pre class=" language-php"><code class=" language-php">$<span class="token punctuation">.</span><span
                class="token function">ajaxSetup</span><span class="token punctuation">(</span><span
                class="token punctuation">{literal}{{/literal}</span>
    headers<span class="token punctuation">:</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token single-quoted-string string">'X-CSRF-TOKEN'</span><span
                class="token punctuation">:</span> $<span class="token punctuation">(</span><span
                class="token single-quoted-string string">'meta[name="csrf-token"]'</span><span
                class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">attr</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'content'</span><span
                class="token punctuation">)</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="csrf-x-xsrf-token"><a href="#csrf-x-xsrf-token">X-XSRF-TOKEN</a></h2>
<p>Laravel хранит текущий токен CSRF в зашифрованном <code>XSRF-TOKEN</code> файле cookie, который включается в каждый
    ответ, сгенерированный платформой. Вы можете использовать значение cookie для установки <code>X-XSRF-TOKEN</code> заголовка
    запроса.</p>
<p>Этот файл cookie в первую очередь отправляется для удобства разработчика, поскольку некоторые фреймворки и библиотеки
    JavaScript, такие как Angular и Axios, автоматически помещают его значение в <code>X-XSRF-TOKEN</code> заголовок в
    запросах с одним и тем же источником.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>По умолчанию <code>resources/js/bootstrap.js</code> файл включает HTTP-библиотеку Axios, которая
            автоматически отправит <code>X-XSRF-TOKEN</code> вам заголовок.</p></p></div>
</blockquote>
