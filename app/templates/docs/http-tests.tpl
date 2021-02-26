<h1>HTTP-тесты <sup>HTTP Tests</sup></h1>
<ul>
    <li><a href="http-tests#introduction">Вступление</a></li>
    <li><a href="http-tests#making-requests">Выполнение запросов <sup>Making requests</sup></a>
        <ul>
            <li><a href="http-tests#customizing-request-headers">Настройка заголовков запросов</a></li>
            <li><a href="http-tests#cookies">Cookies</a></li>
            <li><a href="http-tests#session-and-authentication">Сессия/Аутентификация</a></li>
            <li><a href="http-tests#debugging-responses">Отладочные ответы</a></li>
        </ul>
    </li>
    <li><a href="http-tests#testing-json-apis">Тестирование JSON API</a></li>
    <li><a href="http-tests#testing-file-uploads">Тестирование загрузки файлов</a></li>
    <li><a href="http-tests#testing-views">Тестирование просмотров</a>
        <ul>
            <li><a href="http-tests#rendering-blade-and-components">Рендеринг Blade и компоненты</a></li>
        </ul>
    </li>
    <li><a href="http-tests#available-assertions">Доступные утверждения <sup>Available assertions</sup></a>
        <ul>
            <li><a href="http-tests#response-assertions">Утверждения ответа <sup>Response assertions</sup></a></li>
            <li><a href="http-tests#authentication-assertions">Утверждения аутентификации <sup>Authentication assertions</sup></a></li>
        </ul>
    </li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Laravel предоставляет очень плавный API для выполнения HTTP-запросов к вашему приложению и изучения ответов.
    Например, взгляните на тест функции, определенный ниже:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">Tests<span class="token punctuation">\</span>Feature</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Testing<span class="token punctuation">\</span>RefreshDatabase</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Testing<span class="token punctuation">\</span>WithoutMiddleware</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Tests<span class="token punctuation">\</span>TestCase</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ExampleTest</span> <span class="token keyword">extends</span> <span
                    class="token class-name">TestCase</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * A basic test example.
     *
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">test_a_basic_request</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$response</span> <span class="token operator">=</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">get</span><span
                    class="token punctuation">(</span><span class="token single-quoted-string string">'/'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token variable">$response</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">assertStatus</span><span
                    class="token punctuation">(</span><span class="token number">200</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Метод <code>get</code> делает <code>GET</code> запрос в приложение, в то время как метод <code>assertStatus</code>
    утверждает, что возвращаемый ответ должен иметь заданный HTTP код статуса. Помимо этого простого утверждения,
    Laravel также содержит множество утверждений для проверки заголовков ответов, содержимого, структуры JSON и т. Д.
</p>
<p></p>
<h2 id="making-requests"><a href="#making-requests">Выполнение запросов <sup>Making requests</sup></a></h2>
<p>Для того, чтобы сделать запрос к вашему приложению, вы можете призываете <code>get</code>, <code>post</code>, <code>put</code>,
    <code>patch</code>, или <code>delete</code> методы в рамках теста. Эти методы фактически не отправляют вашему
    приложению «настоящий» HTTP-запрос. Вместо этого внутри моделируется весь сетевой запрос.</p>
<p>Вместо того чтобы возвращать <code>Illuminate\Http\Response</code> экземпляр, методы тестового запроса возвращают
    экземпляр <code>Illuminate\Testing\TestResponse</code>, который предоставляет <a
            href="http-tests#available-assertions">множество полезных утверждений,</a> которые позволяют вам проверять
    ответы вашего приложения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">Tests<span class="token punctuation">\</span>Feature</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Testing<span class="token punctuation">\</span>RefreshDatabase</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Testing<span class="token punctuation">\</span>WithoutMiddleware</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Tests<span class="token punctuation">\</span>TestCase</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ExampleTest</span> <span class="token keyword">extends</span> <span
                    class="token class-name">TestCase</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * A basic test example.
     *
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">test_a_basic_request</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$response</span> <span class="token operator">=</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">get</span><span
                    class="token punctuation">(</span><span class="token single-quoted-string string">'/'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token variable">$response</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">assertStatus</span><span
                    class="token punctuation">(</span><span class="token number">200</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p> Для удобства промежуточное ПО CSRF автоматически отключается при запуске тестов.</p></p></div>
</blockquote>
<p></p>
<h3 id="customizing-request-headers"><a href="#customizing-request-headers">Настройка заголовков запросов</a></h3>
<p>Вы можете использовать этот <code>withHeaders</code> метод для настройки заголовков запроса перед его отправкой в
    ​​приложение. Этот метод позволяет вам добавлять в запрос любые пользовательские заголовки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">Tests<span class="token punctuation">\</span>Feature</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Tests<span class="token punctuation">\</span>TestCase</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ExampleTest</span> <span class="token keyword">extends</span> <span
                    class="token class-name">TestCase</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * A basic functional test example.
     *
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">test_interacting_with_headers</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$response</span> <span class="token operator">=</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">withHeaders</span><span
                    class="token punctuation">(</span><span class="token punctuation">[</span>
            <span class="token single-quoted-string string">'X-Header'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span
                    class="token single-quoted-string string">'Value'</span><span class="token punctuation">,</span>
        <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">post</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'/user'</span><span
                    class="token punctuation">,</span> <span class="token punctuation">[</span><span
                    class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span
                    class="token single-quoted-string string">'Sally'</span><span
                    class="token punctuation">]</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>

        <span class="token variable">$response</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">assertStatus</span><span
                    class="token punctuation">(</span><span class="token number">201</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h3 id="cookies"><a href="#cookies">Cookies</a></h3>
<p>Вы можете использовать методы <code>withCookie</code> или <code>withCookies</code> для установки значений файлов
    cookie перед отправкой запроса. <code>withCookie</code> Метод принимает имя куки и значение в качестве своих двух
    аргументов, в то время как <code>withCookies</code> метод принимает массив пар имя / значение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">Tests<span class="token punctuation">\</span>Feature</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Tests<span class="token punctuation">\</span>TestCase</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ExampleTest</span> <span class="token keyword">extends</span> <span
                    class="token class-name">TestCase</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">test_interacting_with_cookies</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$response</span> <span class="token operator">=</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">withCookie</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'color'</span><span
                    class="token punctuation">,</span> <span
                    class="token single-quoted-string string">'blue'</span><span class="token punctuation">)</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">get</span><span
                    class="token punctuation">(</span><span class="token single-quoted-string string">'/'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token variable">$response</span> <span class="token operator">=</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">withCookies</span><span
                    class="token punctuation">(</span><span class="token punctuation">[</span>
            <span class="token single-quoted-string string">'color'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span
                    class="token single-quoted-string string">'blue'</span><span class="token punctuation">,</span>
            <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span
                    class="token single-quoted-string string">'Taylor'</span><span class="token punctuation">,</span>
        <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">get</span><span
                    class="token punctuation">(</span><span class="token single-quoted-string string">'/'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h3 id="session-and-authentication"><a href="#session-and-authentication">Сессия / Аутентификация</a></h3>
<p>Laravel предоставляет несколько помощников для взаимодействия с сеансом во время HTTP-тестирования. Во-первых, вы
    можете установить данные сеанса в заданный массив с помощью <code>withSession</code> метода. Это полезно для
    загрузки сеанса данными перед отправкой запроса вашему приложению:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">Tests<span class="token punctuation">\</span>Feature</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Tests<span class="token punctuation">\</span>TestCase</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ExampleTest</span> <span class="token keyword">extends</span> <span
                    class="token class-name">TestCase</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">test_interacting_with_the_session</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$response</span> <span class="token operator">=</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">withSession</span><span
                    class="token punctuation">(</span><span class="token punctuation">[</span><span
                    class="token single-quoted-string string">'banned'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token boolean constant">false</span><span
                    class="token punctuation">]</span><span class="token punctuation">)</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">get</span><span
                    class="token punctuation">(</span><span class="token single-quoted-string string">'/'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Сеанс Laravel обычно используется для поддержания состояния текущего аутентифицированного пользователя.
    Следовательно, <code>actingAs</code> вспомогательный метод предоставляет простой способ аутентифицировать данного
    пользователя как текущего пользователя. Например, мы можем использовать <a
            href="database-testing#writing-factories">фабрику моделей</a> для генерации и аутентификации пользователя:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">Tests<span class="token punctuation">\</span>Feature</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Tests<span class="token punctuation">\</span>TestCase</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ExampleTest</span> <span class="token keyword">extends</span> <span
                    class="token class-name">TestCase</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">test_an_action_that_requires_authentication</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$user</span> <span class="token operator">=</span> User<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token function">factory</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">create</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>

        <span class="token variable">$response</span> <span class="token operator">=</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">actingAs</span><span
                    class="token punctuation">(</span><span class="token variable">$user</span><span
                    class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">withSession</span><span
                    class="token punctuation">(</span><span class="token punctuation">[</span><span
                    class="token single-quoted-string string">'banned'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token boolean constant">false</span><span
                    class="token punctuation">]</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">get</span><span
                    class="token punctuation">(</span><span class="token single-quoted-string string">'/'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Вы также можете указать, какое средство защиты должно использоваться для аутентификации данного пользователя, передав
    имя защиты в качестве второго аргумента <code>actingAs</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">actingAs</span><span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'api'</span><span
                class="token punctuation">)</span></code></pre>
<p></p>
<h3 id="debugging-responses"><a href="#debugging-responses">Отладочные ответы</a></h3>
<p>После создания запроса тестирования для вашего приложения, то <code>dump</code>, <code>dumpHeaders</code> и <code>dumpSession</code>
    методы могут быть использованы для проверки и отладки содержимого ответа:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">Tests<span class="token punctuation">\</span>Feature</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Testing<span class="token punctuation">\</span>RefreshDatabase</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Testing<span class="token punctuation">\</span>WithoutMiddleware</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Tests<span class="token punctuation">\</span>TestCase</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ExampleTest</span> <span class="token keyword">extends</span> <span
                    class="token class-name">TestCase</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * A basic test example.
     *
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">test_basic_test</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$response</span> <span class="token operator">=</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">get</span><span
                    class="token punctuation">(</span><span class="token single-quoted-string string">'/'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token variable">$response</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">dumpHeaders</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>

        <span class="token variable">$response</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">dumpSession</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>

        <span class="token variable">$response</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">dump</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h2 id="testing-json-apis"><a href="#testing-json-apis">Тестирование JSON API</a></h2>
<p>Laravel также предоставляет несколько помощников для тестирования API-интерфейсов JSON и их ответов. Так, например,
    <code>json</code>, <code>getJson</code>, <code>postJson</code>, <code>putJson</code>, <code>patchJson</code>, <code>deleteJson</code>,
    и <code>optionsJson</code> методы могут быть использованы для выдачи JSON запросов с различными HTTP глаголами. Вы
    также можете легко передавать данные и заголовки этим методам. Для начала давайте напишем тест, чтобы сделать <code>POST</code>
    запрос <code>/api/user</code> и убедиться, что ожидаемые данные JSON были возвращены:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">Tests<span class="token punctuation">\</span>Feature</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Tests<span class="token punctuation">\</span>TestCase</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ExampleTest</span> <span class="token keyword">extends</span> <span
                    class="token class-name">TestCase</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * A basic functional test example.
     *
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">test_making_an_api_request</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$response</span> <span class="token operator">=</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">postJson</span><span
                    class="token punctuation">(</span><span class="token single-quoted-string string">'/api/user'</span><span
                    class="token punctuation">,</span> <span class="token punctuation">[</span><span
                    class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span
                    class="token single-quoted-string string">'Sally'</span><span
                    class="token punctuation">]</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>

        <span class="token variable">$response<span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertStatus</span><span
                    class="token punctuation">(</span><span class="token number">201</span><span
                    class="token punctuation">)</span></span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">assertJson</span><span class="token punctuation">(</span><span
                    class="token punctuation">[</span>
                <span class="token single-quoted-string string">'created'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token boolean constant">true</span><span
                    class="token punctuation">,</span>
            <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Кроме того, к данным ответа JSON можно получить доступ как к переменным массива в ответе, что позволяет удобно
    просматривать отдельные значения, возвращаемые в ответе JSON:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertTrue</span><span
                class="token punctuation">(</span><span class="token variable">$response</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'created'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p><code>assertJson</code> Метод преобразует ответ на массив и использует,
            <code>PHPUnit::assertArraySubset</code> чтобы убедиться, что данный массив существует в ответ JSON,
            возвращаемом приложением. Итак, если в ответе JSON есть другие свойства, этот тест все равно будет
            проходить, пока присутствует данный фрагмент.</p></p></div>
</blockquote>
<p></p>
<h4 id="verifying-exact-match"><a href="#verifying-exact-match">Утверждение точных совпадений JSON</a></h4>
<p>Как упоминалось ранее, этот <code>assertJson</code> метод может использоваться для подтверждения наличия фрагмента
    JSON в ответе JSON. Если вы хотите убедиться, что данный массив <strong>точно соответствует</strong> JSON,
    возвращаемому вашим приложением, вы должны использовать <code>assertExactJson</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">Tests<span class="token punctuation">\</span>Feature</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Tests<span class="token punctuation">\</span>TestCase</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ExampleTest</span> <span class="token keyword">extends</span> <span
                    class="token class-name">TestCase</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * A basic functional test example.
     *
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">test_asserting_an_exact_json_match</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$response</span> <span class="token operator">=</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">json</span><span
                    class="token punctuation">(</span><span class="token single-quoted-string string">'POST'</span><span
                    class="token punctuation">,</span> <span
                    class="token single-quoted-string string">'/user'</span><span
                    class="token punctuation">,</span> <span class="token punctuation">[</span><span
                    class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span
                    class="token single-quoted-string string">'Sally'</span><span
                    class="token punctuation">]</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>

        <span class="token variable">$response<span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertStatus</span><span
                    class="token punctuation">(</span><span class="token number">201</span><span
                    class="token punctuation">)</span></span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertExactJson</span><span
                    class="token punctuation">(</span><span class="token punctuation">[</span>
                <span class="token single-quoted-string string">'created'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token boolean constant">true</span><span
                    class="token punctuation">,</span>
            <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h4 id="verifying-json-paths"><a href="#verifying-json-paths">Утверждение на путях JSON</a></h4>
<p>Если вы хотите убедиться, что ответ JSON содержит данные по указанному пути, вам следует использовать <code>assertJsonPath</code>
    метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">Tests<span class="token punctuation">\</span>Feature</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Tests<span class="token punctuation">\</span>TestCase</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ExampleTest</span> <span class="token keyword">extends</span> <span
                    class="token class-name">TestCase</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * A basic functional test example.
     *
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">test_asserting_a_json_paths_value</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$response</span> <span class="token operator">=</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">json</span><span
                    class="token punctuation">(</span><span class="token single-quoted-string string">'POST'</span><span
                    class="token punctuation">,</span> <span
                    class="token single-quoted-string string">'/user'</span><span
                    class="token punctuation">,</span> <span class="token punctuation">[</span><span
                    class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span
                    class="token single-quoted-string string">'Sally'</span><span
                    class="token punctuation">]</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>

        <span class="token variable">$response</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertStatus</span><span
                    class="token punctuation">(</span><span class="token number">201</span><span
                    class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertJsonPath</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'team.owner.name'</span><span
                    class="token punctuation">,</span> <span
                    class="token single-quoted-string string">'Darian'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h2 id="testing-file-uploads"><a href="#testing-file-uploads">Тестирование загрузки файлов</a></h2>
<p><code>Illuminate\Http\UploadedFile</code> Класс предоставляет <code>fake</code> метод, который может быть использован
    для создания фиктивных файлов или изображений для тестирования. Это в сочетании с методом <code>Storage</code>
    фасада <code>fake</code> значительно упрощает тестирование загрузки файлов. Например, вы можете объединить эти две
    функции, чтобы легко протестировать форму загрузки аватара:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">Tests<span class="token punctuation">\</span>Feature</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Testing<span class="token punctuation">\</span>RefreshDatabase</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Testing<span class="token punctuation">\</span>WithoutMiddleware</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>UploadedFile</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Storage</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Tests<span class="token punctuation">\</span>TestCase</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ExampleTest</span> <span class="token keyword">extends</span> <span
                    class="token class-name">TestCase</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">test_avatars_can_be_uploaded</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        Storage<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">fake</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'avatars'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token variable">$file</span> <span class="token operator">=</span> UploadedFile<span
                    class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">fake</span><span class="token punctuation">(</span><span
                    class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">image</span><span class="token punctuation">(</span><span
                    class="token single-quoted-string string">'avatar.jpg'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token variable">$response</span> <span class="token operator">=</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">post</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'/avatar'</span><span
                    class="token punctuation">,</span> <span class="token punctuation">[</span>
            <span class="token single-quoted-string string">'avatar'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token variable">$file</span><span
                    class="token punctuation">,</span>
        <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>

        Storage<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">disk</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'avatars'</span><span
                    class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">assertExists</span><span class="token punctuation">(</span><span
                    class="token variable">$file</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">hashName</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Если вы хотите утверждать, что данный файл не существует, вы можете использовать <code>assertMissing</code> метод,
    предоставляемый <code>Storage</code> фасадом:</p>
<pre class=" language-php"><code class=" language-php">Storage<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">fake</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'avatars'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">//...</span>

Storage<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">disk</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'avatars'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertMissing</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'missing.jpg'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="fake-file-customization"><a href="#fake-file-customization">Настройка поддельного файла</a></h4>
<p>При создании файлов с использованием <code>fake</code> метода, предоставленного <code>UploadedFile</code> классом, вы
    можете указать ширину, высоту и размер изображения (в килобайтах), чтобы лучше протестировать правила проверки
    вашего приложения:</p>
<pre class=" language-php"><code class=" language-php">UploadedFile<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">fake</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">image</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'avatar.jpg'</span><span
                class="token punctuation">,</span> <span class="token variable">$width</span><span
                class="token punctuation">,</span> <span class="token variable">$height</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">size</span><span
                class="token punctuation">(</span><span class="token number">100</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Помимо создания изображений, вы можете создавать файлы любого другого типа, используя <code>create</code> метод:</p>
<pre class=" language-php"><code class=" language-php">UploadedFile<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">fake</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">create</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'document.pdf'</span><span class="token punctuation">,</span> <span
                class="token variable">$sizeInKilobytes</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>При необходимости вы можете передать <code>$mimeType</code> аргумент методу, чтобы явно определить тип MIME, который
    должен возвращать файл:</p>
<pre class=" language-php"><code class=" language-php">UploadedFile<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">fake</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">create</span><span
                class="token punctuation">(</span>
    <span class="token single-quoted-string string">'document.pdf'</span><span class="token punctuation">,</span> <span
                class="token variable">$sizeInKilobytes</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'application/pdf'</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="testing-views"><a href="#testing-views">Тестирование просмотров</a></h2>
<p>Laravel также позволяет отображать представление без имитации HTTP-запроса к приложению. Для этого вы можете вызвать
    <code>view</code> метод в своем тесте. <code>view</code> Метод принимает имя представления и дополнительный массив
    данных. Метод возвращает экземпляр <code>Illuminate\Testing\TestView</code>, который предлагает несколько методов
    для удобного утверждения содержимого представления:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">Tests<span class="token punctuation">\</span>Feature</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Tests<span class="token punctuation">\</span>TestCase</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ExampleTest</span> <span class="token keyword">extends</span> <span
                    class="token class-name">TestCase</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">test_a_welcome_view_can_be_rendered</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$view</span> <span class="token operator">=</span> <span
                    class="token variable">$this</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">view</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'welcome'</span><span
                    class="token punctuation">,</span> <span class="token punctuation">[</span><span
                    class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span
                    class="token single-quoted-string string">'Taylor'</span><span
                    class="token punctuation">]</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>

        <span class="token variable">$view</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">assertSee</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'Taylor'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p><code>TestView</code> Класс предоставляет следующие методы утверждения: <code>assertSee</code>, <code>assertSeeInOrder</code>,
    <code>assertSeeText</code>, <code>assertSeeTextInOrder</code>, <code>assertDontSee</code>, и
    <code>assertDontSeeText</code>.</p>
<p>При необходимости вы можете получить необработанное визуализированное содержимое представления, преобразовав <code>TestView</code>
    экземпляр в строку:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$contents</span> <span
                class="token operator">=</span> <span class="token punctuation">(</span>string<span
                class="token punctuation">)</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">view</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'welcome'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="sharing-errors"><a href="#sharing-errors">Обмен ошибками</a></h4>
<p>Некоторые представления могут зависеть от ошибок, представленных в <a
            href="validation#quick-displaying-the-validation-errors">глобальном пакете ошибок, предоставленном
        Laravel</a>. Чтобы наполнить пакет ошибок сообщениями об ошибках, вы можете использовать
    <code>withViewErrors</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$view</span> <span
                class="token operator">=</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">withViewErrors</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'Please provide a valid name.'</span><span
                class="token punctuation">]</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">view</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'form'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$view</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">assertSee</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Please provide a valid name.'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="rendering-blade-and-components"><a href="#rendering-blade-and-components">Рендеринг Blade и компоненты</a></h3>
<p>При необходимости вы можете использовать этот <code>blade</code> метод для оценки и визуализации необработанной
    строки <a href="blade">Blade</a>. Как и <code>view</code> метод, <code>blade</code> метод возвращает экземпляр
    <code>Illuminate\Testing\TestView</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$view</span> <span
                class="token operator">=</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">blade</span><span
                class="token punctuation">(</span>
    <span class="token single-quoted-string string">'&lt;x-component :name="$name" /&gt;'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Taylor'</span><span class="token punctuation">]</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$view</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">assertSee</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Taylor'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете использовать этот <code>component</code> метод для оценки и рендеринга <a href="blade#components">компонента
        Blade</a>. Как и <code>view</code> метод, <code>component</code> метод возвращает экземпляр <code>Illuminate\Testing\TestView</code>:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$view</span> <span
                class="token operator">=</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">component</span><span
                class="token punctuation">(</span>Profile<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Taylor'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$view</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">assertSee</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Taylor'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="available-assertions"><a href="#available-assertions">Доступные утверждения <sup>Available assertions</sup></a></h2>
<p></p>
<h3 id="response-assertions"><a href="#response-assertions">Утверждения ответа <sup>Response assertions</sup></a></h3>
<p><code>Illuminate\Testing\TestResponse</code> Класс Laravel предоставляет множество настраиваемых методов утверждения,
    которые вы можете использовать при тестировании своего приложения. Эти утверждения могут быть доступны на ответ,
    который возвращается в <code>json</code>, <code>get</code>, <code>post</code>, <code>put</code>, и
    <code>delete</code> методы испытаний:</p>
<style>
    .collection-method-list > p {
        column-count: 2;
        -moz-column-count: 2;
        -webkit-column-count: 2;
        column-gap: 2em;
        -moz-column-gap: 2em;
        -webkit-column-gap: 2em;
    }

    .collection-method-list a {
        display: block;
    }
</style>
<div class="collection-method-list">
    <p><a href="http-tests#assert-cookie">assertCookie</a> <a href="http-tests#assert-cookie-expired">assertCookieExpired</a>
        <a href="http-tests#assert-cookie-not-expired">assertCookieNotExpired</a> <a
                href="http-tests#assert-cookie-missing">assertCookieMissing</a> <a href="http-tests#assert-created">assertCreated</a>
        <a href="http-tests#assert-dont-see">assertDontSee</a> <a href="http-tests#assert-dont-see-text">assertDontSeeText</a>
        <a href="http-tests#assert-exact-json">assertExactJson</a> <a
                href="http-tests#assert-forbidden">assertForbidden</a> <a
                href="http-tests#assert-header">assertHeader</a> <a href="http-tests#assert-header-missing">assertHeaderMissing</a>
        <a href="http-tests#assert-json">assertJson</a> <a href="http-tests#assert-json-count">assertJsonCount</a> <a
                href="http-tests#assert-json-fragment">assertJsonFragment</a> <a href="http-tests#assert-json-missing">assertJsonMissing</a>
        <a href="http-tests#assert-json-missing-exact">assertJsonMissingExact</a> <a
                href="http-tests#assert-json-missing-validation-errors">assertJsonMissingValidationErrors</a> <a
                href="http-tests#assert-json-path">assertJsonPath</a> <a href="http-tests#assert-json-structure">assertJsonStructure</a>
        <a href="http-tests#assert-json-validation-errors">assertJsonValidationErrors</a> <a
                href="http-tests#assert-location">assertLocation</a> <a href="http-tests#assert-no-content">assertNoContent</a>
        <a href="http-tests#assert-not-found">assertNotFound</a> <a href="http-tests#assert-ok">assertOk</a> <a
                href="http-tests#assert-plain-cookie">assertPlainCookie</a> <a href="http-tests#assert-redirect">assertRedirect</a>
        <a href="http-tests#assert-see">assertSee</a> <a href="http-tests#assert-see-in-order">assertSeeInOrder</a> <a
                href="http-tests#assert-see-text">assertSeeText</a> <a href="http-tests#assert-see-text-in-order">assertSeeTextInOrder</a>
        <a href="http-tests#assert-session-has">assertSessionHas</a> <a href="http-tests#assert-session-has-input">assertSessionHasInput</a>
        <a href="http-tests#assert-session-has-all">assertSessionHasAll</a> <a
                href="http-tests#assert-session-has-errors">assertSessionHasErrors</a> <a
                href="http-tests#assert-session-has-errors-in">assertSessionHasErrorsIn</a> <a
                href="http-tests#assert-session-has-no-errors">assertSessionHasNoErrors</a> <a
                href="http-tests#assert-session-doesnt-have-errors">assertSessionDoesntHaveErrors</a> <a
                href="http-tests#assert-session-missing">assertSessionMissing</a> <a href="http-tests#assert-status">assertStatus</a>
        <a href="http-tests#assert-successful">assertSuccessful</a> <a href="http-tests#assert-unauthorized">assertUnauthorized</a>
        <a href="http-tests#assert-view-has">assertViewHas</a> <a
                href="http-tests#assert-view-has-all">assertViewHasAll</a> <a href="http-tests#assert-view-is">assertViewIs</a>
        <a href="http-tests#assert-view-missing">assertViewMissing</a></p>
</div>
<p></p>
<h4 id="assert-cookie"><a href="#assert-cookie">assertCookie</a></h4>
<p>Утверждают, что ответ содержит данный файл cookie:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertCookie</span><span
                class="token punctuation">(</span><span class="token variable">$cookieName</span><span
                class="token punctuation">,</span> <span class="token variable">$value</span> <span
                class="token operator">=</span> <span class="token constant">null</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-cookie-expired"><a href="#assert-cookie-expired">assertCookieExpired</a></h4>
<p>Подтвердите, что ответ содержит данный файл cookie и срок его действия истек:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertCookieExpired</span><span
                class="token punctuation">(</span><span class="token variable">$cookieName</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-cookie-not-expired"><a href="#assert-cookie-not-expired">assertCookieNotExpired</a></h4>
<p>Подтвердите, что ответ содержит данный файл cookie и срок его действия не истек:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertCookieNotExpired</span><span
                class="token punctuation">(</span><span class="token variable">$cookieName</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-cookie-missing"><a href="#assert-cookie-missing">assertCookieMissing</a></h4>
<p>Утверждают, что ответ не содержит данного файла cookie:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertCookieMissing</span><span
                class="token punctuation">(</span><span class="token variable">$cookieName</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-created"><a href="#assert-created">assertCreated</a></h4>
<p>Убедитесь, что ответ имеет код состояния HTTP 201:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertCreated</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-dont-see"><a href="#assert-dont-see">assertDontSee</a></h4>
<p>Утверждают, что данная строка не содержится в ответе, возвращаемом приложением. Это утверждение автоматически
    экранирует данную строку, если вы не передадите второй аргумент <code>false</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertDontSee</span><span
                class="token punctuation">(</span><span class="token variable">$value</span><span
                class="token punctuation">,</span> <span class="token variable">$escaped</span> <span
                class="token operator">=</span> <span class="token boolean constant">true</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-dont-see-text"><a href="#assert-dont-see-text">assertDontSeeText</a></h4>
<p>Утверждают, что данная строка не содержится в тексте ответа. Это утверждение автоматически экранирует данную строку,
    если вы не передадите второй аргумент <code>false</code>. Этот метод передаст содержимое ответа
    <code>strip_tags</code> функции PHP перед тем, как сделать утверждение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertDontSeeText</span><span
                class="token punctuation">(</span><span class="token variable">$value</span><span
                class="token punctuation">,</span> <span class="token variable">$escaped</span> <span
                class="token operator">=</span> <span class="token boolean constant">true</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-exact-json"><a href="#assert-exact-json">assertExactJson</a></h4>
<p>Утверждают, что ответ содержит точное совпадение данных JSON:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertExactJson</span><span
                class="token punctuation">(</span><span class="token keyword">array</span> <span class="token variable">$data</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-forbidden"><a href="#assert-forbidden">assertForbidden</a></h4>
<p>Утверждают, что ответ имеет запрещенный (403) код статуса HTTP:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertForbidden</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-header"><a href="#assert-header">assertHeader</a></h4>
<p>Убедитесь, что данный заголовок и значение присутствуют в ответе:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertHeader</span><span
                class="token punctuation">(</span><span class="token variable">$headerName</span><span
                class="token punctuation">,</span> <span class="token variable">$value</span> <span
                class="token operator">=</span> <span class="token constant">null</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-header-missing"><a href="#assert-header-missing">assertHeaderMissing</a></h4>
<p>Утверждают, что данный заголовок отсутствует в ответе:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertHeaderMissing</span><span
                class="token punctuation">(</span><span class="token variable">$headerName</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-json"><a href="#assert-json">assertJson</a></h4>
<p>Утверждают, что ответ содержит данные JSON:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertJson</span><span
                class="token punctuation">(</span><span class="token keyword">array</span> <span class="token variable">$data</span><span
                class="token punctuation">,</span> <span class="token variable">$strict</span> <span
                class="token operator">=</span> <span class="token boolean constant">false</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p><code>assertJson</code> Метод преобразует ответ на массив и использует, <code>PHPUnit::assertArraySubset</code> чтобы
    убедиться, что данный массив существует в ответ JSON, возвращаемом приложением. Итак, если в ответе JSON есть другие
    свойства, этот тест все равно будет проходить, пока присутствует данный фрагмент.</p>
<p></p>
<h4 id="assert-json-count"><a href="#assert-json-count">assertJsonCount</a></h4>
<p>Утверждают, что ответ JSON имеет массив с ожидаемым количеством элементов по данному ключу:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertJsonCount</span><span
                class="token punctuation">(</span><span class="token variable">$count</span><span
                class="token punctuation">,</span> <span class="token variable">$key</span> <span
                class="token operator">=</span> <span class="token constant">null</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-json-fragment"><a href="#assert-json-fragment">assertJsonFragment</a></h4>
<p>Убедитесь, что ответ содержит данные JSON в любом месте ответа:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/users'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'users'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
            <span class="token punctuation">[</span>
                <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Taylor Otwell'</span><span class="token punctuation">,</span>
            <span class="token punctuation">]</span><span class="token punctuation">,</span>
        <span class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$response</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">assertJsonFragment</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Taylor Otwell'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-json-missing"><a href="#assert-json-missing">assertJsonMissing</a></h4>
<p>Утверждают, что ответ не содержит данных JSON:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertJsonMissing</span><span
                class="token punctuation">(</span><span class="token keyword">array</span> <span class="token variable">$data</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-json-missing-exact"><a href="#assert-json-missing-exact">assertJsonMissingExact</a></h4>
<p>Утверждают, что ответ не содержит точных данных JSON:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertJsonMissingExact</span><span
                class="token punctuation">(</span><span class="token keyword">array</span> <span class="token variable">$data</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-json-missing-validation-errors"><a href="#assert-json-missing-validation-errors">assertJsonMissingValidationErrors</a>
</h4>
<p>Убедитесь, что ответ не содержит ошибок проверки JSON для данных ключей:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertJsonMissingValidationErrors</span><span
                class="token punctuation">(</span><span class="token variable">$keys</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-json-path"><a href="#assert-json-path">assertJsonPath</a></h4>
<p>Утверждают, что ответ содержит данные по указанному пути:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertJsonPath</span><span
                class="token punctuation">(</span><span class="token variable">$path</span><span
                class="token punctuation">,</span> <span class="token keyword">array</span> <span
                class="token variable">$data</span><span class="token punctuation">,</span> <span
                class="token variable">$strict</span> <span class="token operator">=</span> <span
                class="token boolean constant">true</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Например, если ответ JSON, возвращаемый вашим приложением, содержит следующие данные:</p>
<pre class=" language-js"><code class=" language-js"><span class="token punctuation">{literal}{{/literal}</span>
    <span class="token string">"user"</span><span class="token operator">:</span> <span
                class="token punctuation">{literal}{{/literal}</span>
        <span class="token string">"name"</span><span class="token operator">:</span> <span class="token string">"Steve Schoger"</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></code></pre>
<p>Вы можете утверждать, что <code>name</code> свойство <code>user</code> объекта соответствует заданному значению,
    например:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertJsonPath</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'user.name'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Steve Schoger'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-json-structure"><a href="#assert-json-structure">assertJsonStructure</a></h4>
<p>Утверждают, что ответ имеет заданную структуру JSON:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertJsonStructure</span><span
                class="token punctuation">(</span><span class="token keyword">array</span> <span class="token variable">$structure</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Например, если ответ JSON, возвращаемый вашим приложением, содержит следующие данные:</p>
<pre class=" language-js"><code class=" language-js"><span class="token punctuation">{literal}{{/literal}</span>
    <span class="token string">"user"</span><span class="token operator">:</span> <span
                class="token punctuation">{literal}{{/literal}</span>
        <span class="token string">"name"</span><span class="token operator">:</span> <span class="token string">"Steve Schoger"</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></code></pre>
<p>Вы можете утверждать, что структура JSON соответствует вашим ожиданиям, вот так:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertJsonStructure</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'user'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'name'</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-json-validation-errors"><a href="#assert-json-validation-errors">assertJsonValidationErrors</a></h4>
<p>Утверждение, что ответ содержит данные ошибки проверки JSON для данных ключей. Этот метод следует использовать при
    утверждении ответов, в которых ошибки проверки возвращаются в виде структуры JSON, а не передаются в сеанс:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertJsonValidationErrors</span><span
                class="token punctuation">(</span><span class="token keyword">array</span> <span class="token variable">$data</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-location"><a href="#assert-location">assertLocation</a></h4>
<p>Подтвердите, что ответ имеет данное значение URI в <code>Location</code> заголовке:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertLocation</span><span
                class="token punctuation">(</span><span class="token variable">$uri</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-no-content"><a href="#assert-no-content">assertNoContent</a></h4>
<p>Утверждают, что ответ имеет указанный код состояния HTTP и не содержит содержимого:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertNoContent</span><span
                class="token punctuation">(</span><span class="token variable">$status</span> <span
                class="token operator">=</span> <span class="token number">204</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-not-found"><a href="#assert-not-found">assertNotFound</a></h4>
<p>Подтвердите, что ответ содержит код состояния HTTP не найден (404):</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertNotFound</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-ok"><a href="#assert-ok">assertOk</a></h4>
<p>Убедитесь, что ответ имеет код состояния HTTP 200:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertOk</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-plain-cookie"><a href="#assert-plain-cookie">assertPlainCookie</a></h4>
<p>Утверждают, что ответ содержит данный незашифрованный файл cookie:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertPlainCookie</span><span
                class="token punctuation">(</span><span class="token variable">$cookieName</span><span
                class="token punctuation">,</span> <span class="token variable">$value</span> <span
                class="token operator">=</span> <span class="token constant">null</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-redirect"><a href="#assert-redirect">assertRedirect</a></h4>
<p>Утверждают, что ответ является перенаправлением на данный URI:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertRedirect</span><span
                class="token punctuation">(</span><span class="token variable">$uri</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-see"><a href="#assert-see">assertSee</a></h4>
<p>Утверждают, что данная строка содержится в ответе. Это утверждение автоматически экранирует данную строку, если вы не
    передадите второй аргумент <code>false</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSee</span><span
                class="token punctuation">(</span><span class="token variable">$value</span><span
                class="token punctuation">,</span> <span class="token variable">$escaped</span> <span
                class="token operator">=</span> <span class="token boolean constant">true</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-see-in-order"><a href="#assert-see-in-order">assertSeeInOrder</a></h4>
<p>Утверждают, что данные строки содержатся в ответе по порядку. Это утверждение автоматически экранирует заданные
    строки, если вы не передадите второй аргумент <code>false</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSeeInOrder</span><span
                class="token punctuation">(</span><span class="token keyword">array</span> <span class="token variable">$values</span><span
                class="token punctuation">,</span> <span class="token variable">$escaped</span> <span
                class="token operator">=</span> <span class="token boolean constant">true</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-see-text"><a href="#assert-see-text">assertSeeText</a></h4>
<p>Утверждают, что данная строка содержится в тексте ответа. Это утверждение автоматически экранирует данную строку,
    если вы не передадите второй аргумент <code>false</code>. Содержимое ответа будет передано <code>strip_tags</code>
    функции PHP до того, как будет сделано утверждение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSeeText</span><span
                class="token punctuation">(</span><span class="token variable">$value</span><span
                class="token punctuation">,</span> <span class="token variable">$escaped</span> <span
                class="token operator">=</span> <span class="token boolean constant">true</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-see-text-in-order"><a href="#assert-see-text-in-order">assertSeeTextInOrder</a></h4>
<p>Подтвердите, что данные строки содержатся в тексте ответа по порядку. Это утверждение автоматически экранирует
    указанные строки, если вы не передадите второй аргумент <code>false</code>. Содержимое ответа будет передано <code>strip_tags</code>
    функции PHP до того, как будет сделано утверждение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSeeTextInOrder</span><span
                class="token punctuation">(</span><span class="token keyword">array</span> <span class="token variable">$values</span><span
                class="token punctuation">,</span> <span class="token variable">$escaped</span> <span
                class="token operator">=</span> <span class="token boolean constant">true</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-session-has"><a href="#assert-session-has">assertSessionHas</a></h4>
<p>Утверждают, что сеанс содержит заданный фрагмент данных:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSessionHas</span><span
                class="token punctuation">(</span><span class="token variable">$key</span><span
                class="token punctuation">,</span> <span class="token variable">$value</span> <span
                class="token operator">=</span> <span class="token constant">null</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-session-has-input"><a href="#assert-session-has-input">assertSessionHasInput</a></h4>
<p>Утверждают, что сеанс имеет заданное значение во <a href="responses#redirecting-with-flashed-session-data">вспыхнувшем
        входном массиве</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSessionHasInput</span><span
                class="token punctuation">(</span><span class="token variable">$key</span><span
                class="token punctuation">,</span> <span class="token variable">$value</span> <span
                class="token operator">=</span> <span class="token constant">null</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-session-has-all"><a href="#assert-session-has-all">assertSessionHasAll</a></h4>
<p>Утверждают, что сеанс содержит заданный массив пар ключ / значение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSessionHasAll</span><span
                class="token punctuation">(</span><span class="token keyword">array</span> <span class="token variable">$data</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Например, если сессия вашего приложения содержит <code>name</code> и <code>status</code> ключи, вы можете утверждать,
    что оба они существуют и имеют указанные значения следующим образом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSessionHasAll</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Taylor Otwell'</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'status'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'active'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-session-has-errors"><a href="#assert-session-has-errors">assertSessionHasErrors</a></h4>
<p>Утверждают, что сеанс содержит ошибку для данного <code>$keys</code>. Если <code>$keys</code> является ассоциативным
    массивом, следует утверждать, что сеанс содержит конкретное сообщение об ошибке (значение) для каждого поля (ключа).
    Этот метод следует использовать при тестировании маршрутов, которые передают ошибки проверки в сеанс вместо того,
    чтобы возвращать их в виде структуры JSON:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSessionHasErrors</span><span
                class="token punctuation">(</span>
    <span class="token keyword">array</span> <span class="token variable">$keys</span><span
                class="token punctuation">,</span> <span class="token variable">$format</span> <span
                class="token operator">=</span> <span class="token constant">null</span><span class="token punctuation">,</span> <span
                class="token variable">$errorBag</span> <span class="token operator">=</span> <span
                class="token single-quoted-string string">'default'</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Например, чтобы утверждать, что <code>name</code> и <code>email</code> поля есть сообщения об ошибках валидации,
    которые были мелькнули на сессию, вы можете вызвать <code>assertSessionHasErrors</code> метод следующим образом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSessionHasErrors</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'name'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'email'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Или вы можете утверждать, что данное поле имеет конкретное сообщение об ошибке проверки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSessionHasErrors</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'The given name was invalid.'</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-session-has-errors-in"><a href="#assert-session-has-errors-in">assertSessionHasErrorsIn</a></h4>
<p>Утверждают, что сеанс содержит ошибку для заданного <code>$keys</code> в конкретном <a
            href="validation#named-error-bags">пакете ошибок</a>. Если <code>$keys</code> это ассоциативный массив,
    убедитесь, что сеанс содержит конкретное сообщение об ошибке (значение) для каждого поля (ключа) в пакете ошибок:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSessionHasErrorsIn</span><span
                class="token punctuation">(</span><span class="token variable">$errorBag</span><span
                class="token punctuation">,</span> <span class="token variable">$keys</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span> <span class="token variable">$format</span> <span
                class="token operator">=</span> <span class="token constant">null</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-session-has-no-errors"><a href="#assert-session-has-no-errors">assertSessionHasNoErrors</a></h4>
<p>Убедитесь, что в сеансе нет ошибок проверки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSessionHasNoErrors</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-session-doesnt-have-errors"><a
            href="#assert-session-doesnt-have-errors">assertSessionDoesntHaveErrors</a></h4>
<p>Подтвердите, что сеанс не имеет ошибок проверки для данных ключей:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSessionDoesntHaveErrors</span><span
                class="token punctuation">(</span><span class="token variable">$keys</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span> <span class="token variable">$format</span> <span
                class="token operator">=</span> <span class="token constant">null</span><span class="token punctuation">,</span> <span
                class="token variable">$errorBag</span> <span class="token operator">=</span> <span
                class="token single-quoted-string string">'default'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-session-missing"><a href="#assert-session-missing">assertSessionMissing</a></h4>
<p>Утверждают, что сеанс не содержит данного ключа:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSessionMissing</span><span
                class="token punctuation">(</span><span class="token variable">$key</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-status"><a href="#assert-status">assertStatus</a></h4>
<p>Утверждают, что ответ имеет данный код состояния HTTP:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertStatus</span><span
                class="token punctuation">(</span><span class="token variable">$code</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-successful"><a href="#assert-successful">assertSuccessful</a></h4>
<p>Убедитесь, что ответ имеет успешный (&gt; = 200 и &lt;300) код состояния HTTP:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSuccessful</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-unauthorized"><a href="#assert-unauthorized">assertUnauthorized</a></h4>
<p>Подтвердите, что ответ имеет неавторизованный (401) код состояния HTTP:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertUnauthorized</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-view-has"><a href="#assert-view-has">assertViewHas</a></h4>
<p>Утверждают, что представление ответа содержит заданный фрагмент данных:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertViewHas</span><span
                class="token punctuation">(</span><span class="token variable">$key</span><span
                class="token punctuation">,</span> <span class="token variable">$value</span> <span
                class="token operator">=</span> <span class="token constant">null</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Кроме того, данные просмотра могут быть доступны как переменные массива в ответе, что позволяет вам удобно
    просматривать их:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertEquals</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Taylor'</span><span
                class="token punctuation">,</span> <span class="token variable">$response</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-view-has-all"><a href="#assert-view-has-all">assertViewHasAll</a></h4>
<p>Утвердите, что в представлении ответа есть заданный список данных:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertViewHasAll</span><span
                class="token punctuation">(</span><span class="token keyword">array</span> <span class="token variable">$data</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Этот метод может использоваться, чтобы утверждать, что представление просто содержит данные, соответствующие заданным
    ключам:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertViewHasAll</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'name'</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'email'</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Или вы можете утверждать, что данные представления присутствуют и имеют определенные значения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertViewHasAll</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Taylor Otwell'</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'taylor@example.com,'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-view-is"><a href="#assert-view-is">assertViewIs</a></h4>
<p>Утверждают, что данное представление было возвращено маршрутом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertViewIs</span><span
                class="token punctuation">(</span><span class="token variable">$value</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-view-missing"><a href="#assert-view-missing">assertViewMissing</a></h4>
<p>Утверждают, что данный ключ данных не был доступен для представления, возвращенного в ответе приложения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertViewMissing</span><span
                class="token punctuation">(</span><span class="token variable">$key</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="authentication-assertions"><a href="#authentication-assertions">Утверждения аутентификации <sup>Authentication assertions</sup></a></h3>
<p>Laravel также предоставляет множество утверждений, связанных с аутентификацией, которые вы можете использовать в
    тестах функций вашего приложения. Обратите внимание, что эти методы вызываются в самом тестовом классе, а не в
    <code>Illuminate\Testing\TestResponse</code> экземпляре, возвращаемом такими методами, как <code>get</code> и <code>post</code>.
</p>
<p></p>
<h4 id="assert-authenticated"><a href="#assert-authenticated">assertAuthenticated</a></h4>
<p>Утверждают, что пользователь аутентифицирован:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertAuthenticated</span><span
                class="token punctuation">(</span><span class="token variable">$guard</span> <span
                class="token operator">=</span> <span class="token constant">null</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-guest"><a href="#assert-guest">assertGuest</a></h4>
<p>Утверждают, что пользователь не аутентифицирован:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertGuest</span><span
                class="token punctuation">(</span><span class="token variable">$guard</span> <span
                class="token operator">=</span> <span class="token constant">null</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-authenticated-as"><a href="#assert-authenticated-as">assertAuthenticatedAs</a></h4>
<p>Утверждают, что конкретный пользователь аутентифицирован:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertAuthenticatedAs</span><span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">,</span> <span class="token variable">$guard</span> <span
                class="token operator">=</span> <span class="token constant">null</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
