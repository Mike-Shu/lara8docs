<h1>Мокинг <sup>Mocking</sup></h1>
<ul>
    <li><a href="mocking#introduction">Вступление <sup>Introduction</sup></a></li>
    <li><a href="mocking#mocking-objects">Мокинг объектов <sup>Mocking objects</sup></a></li>
    <li><a href="mocking#mocking-facades">Мокинг фасадов <sup>Mocking facades</sup></a>
        <ul>
            <li><a href="mocking#facade-spies">Фасадные шпионы <sup>Facade spies</sup></a></li>
        </ul>
    </li>
    <li><a href="mocking#bus-fake">Bus Fake</a>
        <ul>
            <li><a href="mocking#bus-job-chains">Цепочки заданий <sup>Job chains</sup></a></li>
            <li><a href="mocking#job-batches">Пакеты заданий <sup>Job batches</sup></a></li>
        </ul>
    </li>
    <li><a href="mocking#event-fake">Поддельное событие <sup>Event fake</sup></a>
        <ul>
            <li><a href="mocking#scoped-event-fakes">Подделки событий с ограниченным объемом <sup>Scoped event fakes</sup></a></li>
        </ul>
    </li>
    <li><a href="mocking#http-fake">Поддельный HTTP <sup>HTTP fake</sup></a></li>
    <li><a href="mocking#mail-fake">Поддельный емейл <sup>Mail fake</sup></a></li>
    <li><a href="mocking#notification-fake">Поддельное уведомление <sup>Notification fake</sup></a></li>
    <li><a href="mocking#queue-fake">Поддельная очередь <sup>Queue fake</sup></a>
        <ul>
            <li><a href="mocking#job-chains">Цепочки заданий <sup>Job chains</sup></a></li>
        </ul>
    </li>
    <li><a href="mocking#storage-fake">Поддельное хранилище <sup>Storage fake</sup></a></li>
    <li><a href="mocking#interacting-with-time">Взаимодействие со временем <sup>Interacting with time</sup></a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление <sup>Introduction</sup></a></h2>
<p>При тестировании приложений Laravel вы можете захотеть «имитировать» определенные аспекты вашего приложения, чтобы
    они фактически не выполнялись во время данного теста. Например, при тестировании контроллера, который отправляет
    событие, вы можете имитировать прослушиватели событий, чтобы они фактически не выполнялись во время теста. Это
    позволяет вам тестировать только HTTP-ответ контроллера, не беспокоясь о выполнении слушателей событий, поскольку
    слушатели событий могут быть протестированы в их собственном тестовом примере.</p>
<p>Laravel предоставляет полезные методы для имитации событий, заданий и других фасадов из коробки. Эти помощники в
    первую очередь обеспечивают удобный уровень над Mockery, поэтому вам не нужно вручную выполнять сложные вызовы
    методов Mockery.</p>
<p></p>
<h2 id="mocking-objects"><a href="#mocking-objects">Мокинг объектов <sup>Mocking objects</sup></a></h2>
<p>При имитации объекта, который будет внедрен в ваше приложение через <a href="container">сервисный контейнер</a>
    Laravel, вам нужно будет привязать ваш фиктивный экземпляр к контейнеру в качестве <code>instance</code> привязки.
    Это даст указание контейнеру использовать ваш фиктивный экземпляр объекта вместо создания самого объекта:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Service</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Mockery</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Mockery<span class="token punctuation">\</span>MockInterface</span><span
                class="token punctuation">;</span>

<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">test_something_can_be_mocked</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">instance</span><span
                class="token punctuation">(</span>
        Service<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
        Mockery<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">mock</span><span
                class="token punctuation">(</span>Service<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>MockInterface <span class="token variable">$mock</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token variable">$mock</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">shouldReceive</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'process'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">once</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span>
    <span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Чтобы сделать это более удобным, вы можете использовать <code>mock</code> метод, предоставляемый классом базового
    тестового примера Laravel. Например, следующий пример эквивалентен приведенному выше примеру:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Service</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Mockery<span class="token punctuation">\</span>MockInterface</span><span
                class="token punctuation">;</span>

<span class="token variable">$mock</span> <span class="token operator">=</span> <span
                class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">mock</span><span class="token punctuation">(</span>Service<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>MockInterface <span class="token variable">$mock</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$mock</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">shouldReceive</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'process'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">once</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы можете использовать этот <code>partialMock</code> метод, когда вам нужно имитировать только несколько методов
    объекта. Методы, которые не были имитированы, будут нормально выполняться при вызове:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Service</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Mockery<span class="token punctuation">\</span>MockInterface</span><span
                class="token punctuation">;</span>

<span class="token variable">$mock</span> <span class="token operator">=</span> <span
                class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">partialMock</span><span class="token punctuation">(</span>Service<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>MockInterface <span class="token variable">$mock</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$mock</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">shouldReceive</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'process'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">once</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Точно так же, если вы хотите <a href="http://docs.mockery.io/en/latest/reference/spies.html">шпионить</a> за
    объектом, базовый класс тестового случая Laravel предлагает <code>spy</code> метод в качестве удобной оболочки
    вокруг <code>Mockery::spy</code> метода. Шпионы похожи на издевательств; однако шпионы записывают любое
    взаимодействие между шпионом и тестируемым кодом, позволяя вам делать утверждения после выполнения кода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Service</span><span
                class="token punctuation">;</span>

<span class="token variable">$spy</span> <span class="token operator">=</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">spy</span><span class="token punctuation">(</span>Service<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">//...</span>

<span class="token variable">$spy</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">shouldHaveReceived</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'process'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="mocking-facades"><a href="#mocking-facades">Мокинг фасадов <sup>Mocking facades</sup></a></h2>
<p>В отличие от вызовов традиционных статических методов, <a href="facades">фасады</a> (включая <a href="facades">фасады
        в </a><a href="facades#real-time-facades">реальном времени</a> ) можно имитировать. Это дает большое
    преимущество перед традиционными статическими методами и дает такую ​​же тестируемость, как если бы вы использовали
    традиционную инъекцию зависимостей. При тестировании вы часто можете имитировать вызов фасада Laravel, который
    происходит в одном из ваших контроллеров. Например, рассмотрим следующее действие контроллера:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Cache</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">UserController</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Retrieve a list of all users of the application.
     *
     * @return \Illuminate\Http\Response
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">index</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$value</span> <span class="token operator">=</span> Cache<span
                    class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">get</span><span class="token punctuation">(</span><span
                    class="token single-quoted-string string">'key'</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>

        <span class="token comment">//</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Мы можем имитировать вызов <code>Cache</code> фасада, используя <code>shouldReceive</code> метод, который вернет
    экземпляр <a href="https://github.com/padraic/mockery">mockery</a>. Поскольку фасады фактически решаются и
    управляются <a href="container">сервисным контейнером</a> Laravel, они имеют гораздо большую тестируемость, чем
    типичный статический класс. Например, давайте смоделируем наш вызов метода <code>Cache</code> фасада
    <code>get</code>:</p>
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
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Cache</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Tests<span class="token punctuation">\</span>TestCase</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">UserControllerTest</span> <span
                    class="token keyword">extends</span> <span class="token class-name">TestCase</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">testGetIndex</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        Cache<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">shouldReceive</span><span
                    class="token punctuation">(</span><span class="token single-quoted-string string">'get'</span><span
                    class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">once</span><span class="token punctuation">(</span><span
                    class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">with</span><span class="token punctuation">(</span><span
                    class="token single-quoted-string string">'key'</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">andReturn</span><span class="token punctuation">(</span><span
                    class="token single-quoted-string string">'value'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token variable">$response</span> <span class="token operator">=</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">get</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'/users'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token comment">//...</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Не стоит издеваться над <code>Request</code> фасадом. Вместо этого передайте желаемые входные данные в <a
                    href="http-tests">методы тестирования HTTP,</a> такие как <code>get</code> и <code>post</code> при
            запуске теста. Точно так же вместо издевательства над <code>Config</code> фасадом вызовите
            <code>Config::set</code> метод в своих тестах.</p></p></div>
</blockquote>
<p></p>
<h3 id="facade-spies"><a href="#facade-spies">Фасадные шпионы <sup>Facade spies</sup></a></h3>
<p>Если вы хотите <a href="http://docs.mockery.io/en/latest/reference/spies.html">следить</a> за фасадом, вы можете
    вызвать <code>spy</code> метод на соответствующем фасаде. Шпионы похожи на издевательств; однако шпионы записывают
    любое взаимодействие между шпионом и тестируемым кодом, позволяя вам делать утверждения после выполнения кода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Cache</span><span
                class="token punctuation">;</span>

<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">test_values_are_be_stored_in_cache</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    Cache<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">spy</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

    <span class="token variable">$response</span> <span class="token operator">=</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

    <span class="token variable">$response</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">assertStatus</span><span
                class="token punctuation">(</span><span class="token number">200</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

    Cache<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">shouldHaveReceived</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'put'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">once</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">with</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'name'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Taylor'</span><span class="token punctuation">,</span> <span
                class="token number">10</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h2 id="bus-fake"><a href="#bus-fake">Bus Fake</a></h2>
<p>При тестировании кода, который отправляет задания, вы обычно хотите подтвердить, что данное задание было отправлено,
    но не помещает его в очередь или не выполняет задание. Это связано с тем, что выполнение задания обычно можно
    протестировать в отдельном тестовом классе.</p>
<p>Вы можете использовать метод <code>Bus</code> фасада, <code>fake</code> чтобы предотвратить отправку заданий в
    очередь. Затем, после выполнения кода тестируемых, вы можете проверять, какие работы приложения пыталось направить
    используя <code>assertDispatched</code> и <code>assertNotDispatched</code> методы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">Tests<span class="token punctuation">\</span>Feature</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Jobs<span
                        class="token punctuation">\</span>ShipOrder</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Testing<span class="token punctuation">\</span>RefreshDatabase</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Testing<span class="token punctuation">\</span>WithoutMiddleware</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Bus</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Tests<span class="token punctuation">\</span>TestCase</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ExampleTest</span> <span class="token keyword">extends</span> <span
                    class="token class-name">TestCase</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">test_orders_can_be_shipped</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        Bus<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">fake</span><span class="token punctuation">(</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token comment">// Perform order shipping...</span>

        <span class="token comment">// Assert that a job was dispatched...</span>
        Bus<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">assertDispatched</span><span
                    class="token punctuation">(</span>ShipOrder<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token comment">// Assert a job was not dispatched...</span>
        Bus<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">assertNotDispatched</span><span
                    class="token punctuation">(</span>AnotherJob<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Вы можете передать закрытие в методы <code>assertDispatched</code> или <code>assertNotDispatched</code>, чтобы
    утверждать, что было отправлено задание, которое проходит заданный «тест истинности». Если было отправлено хотя бы
    одно задание, которое проходит заданный тест на истинность, то утверждение будет успешным. Например, вы можете
    подтвердить, что задание было отправлено для определенного заказа:</p>
<pre class=" language-php"><code class=" language-php">Bus<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">assertDispatched</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span>ShipOrder <span class="token variable">$job</span><span
                class="token punctuation">)</span> <span class="token keyword">use</span> <span
                class="token punctuation">(</span><span class="token variable">$order</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$job</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">order</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span> <span class="token operator">===</span> <span class="token variable">$order</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="bus-job-chains"><a href="#bus-job-chains">Цепочки заданий <sup>Job chains</sup></a></h3>
<p>Метод <code>Bus</code> фасада <code>assertChained</code> может использоваться, чтобы утверждать, что была отправлена
    <a href="queues#job-chaining">цепочка заданий</a>. <code>assertChained</code> Метод принимает массив прикованной
    работы в качестве первого аргумента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Jobs<span
                    class="token punctuation">\</span>RecordShipment</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Jobs<span
                    class="token punctuation">\</span>ShipOrder</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Jobs<span
                    class="token punctuation">\</span>UpdateInventory</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Bus</span><span
                class="token punctuation">;</span>

Bus<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">assertChained</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    ShipOrder<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span><span class="token punctuation">,</span>
    RecordShipment<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span><span class="token punctuation">,</span>
    UpdateInventory<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Как вы можете видеть в приведенном выше примере, массив связанных заданий может быть массивом имен классов заданий.
    Однако вы также можете предоставить массив фактических экземпляров задания. При этом Laravel гарантирует, что
    экземпляры задания относятся к одному классу и имеют одинаковые значения свойств связанных заданий, отправленных
    вашим приложением:</p>
<pre class=" language-php"><code class=" language-php">Bus<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">assertChained</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token keyword">new</span> <span class="token class-name">ShipOrder</span><span
                class="token punctuation">,</span>
    <span class="token keyword">new</span> <span class="token class-name">RecordShipment</span><span
                class="token punctuation">,</span>
    <span class="token keyword">new</span> <span class="token class-name">UpdateInventory</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="job-batches"><a href="#job-batches">Пакеты заданий <sup>Job batches</sup></a></h3>
<p>Метод <code>Bus</code> фасада <code>assertBatched</code> может использоваться для подтверждения того, что был
    отправлен <a href="queues#job-batching">пакет заданий</a>. Закрытие, данное <code>assertBatched</code> методу,
    получает экземпляр <code>Illuminate\Bus\PendingBatch</code>, который можно использовать для проверки заданий в
    пакете:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Bus<span
                    class="token punctuation">\</span>PendingBatch</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Bus</span><span
                class="token punctuation">;</span>

Bus<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">assertBatched</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span>PendingBatch <span class="token variable">$batch</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$batch</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">name</span> <span class="token operator">==</span> <span
                class="token single-quoted-string string">'import-csv'</span> <span
                class="token operator">&amp;&amp;</span>
    <span class="token variable">$batch</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">jobs</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">count</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token operator">===</span> <span
                class="token number">10</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="event-fake"><a href="#event-fake">Поддельное событие <sup>Event fake</sup></a></h2>
<p>При тестировании кода, отправляющего события, вы можете указать Laravel на самом деле не выполнять слушателей
    событий. Используя <code>Event</code> фасад в <code>fake</code> метод, вы можете предотвратить слушатель от
    выполнения, выполнить код при испытании, а затем утверждает, какие события были отправлены вашим приложением,
    используя <code>assertDispatched</code>, <code>assertNotDispatched</code> и <code>assertNothingDispatched</code>
    методы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">Tests<span class="token punctuation">\</span>Feature</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Events<span class="token punctuation">\</span>OrderFailedToShip</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Events<span
                        class="token punctuation">\</span>OrderShipped</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Testing<span class="token punctuation">\</span>RefreshDatabase</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Testing<span class="token punctuation">\</span>WithoutMiddleware</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Event</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Tests<span class="token punctuation">\</span>TestCase</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ExampleTest</span> <span class="token keyword">extends</span> <span
                    class="token class-name">TestCase</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Test order shipping.
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">test_orders_can_be_shipped</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        Event<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">fake</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>

        <span class="token comment">// Perform order shipping...</span>

        <span class="token comment">// Assert that an event was dispatched...</span>
        Event<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">assertDispatched</span><span
                    class="token punctuation">(</span>OrderShipped<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token comment">// Assert an event was dispatched twice...</span>
        Event<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">assertDispatched</span><span
                    class="token punctuation">(</span>OrderShipped<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">,</span> <span class="token number">2</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token comment">// Assert an event was not dispatched...</span>
        Event<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">assertNotDispatched</span><span
                    class="token punctuation">(</span>OrderFailedToShip<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token comment">// Assert that no events were dispatched...</span>
        Event<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">assertNothingDispatched</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Вы можете передать закрытие в методы <code>assertDispatched</code> или <code>assertNotDispatched</code>, чтобы
    утверждать, что было отправлено событие, которое проходит заданный «тест истинности». Если было отправлено хотя бы
    одно событие, которое проходит данный тест истинности, то утверждение будет успешным:</p>
<pre class=" language-php"><code class=" language-php">Event<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">assertDispatched</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span>OrderShipped <span class="token variable">$event</span><span
                class="token punctuation">)</span> <span class="token keyword">use</span> <span
                class="token punctuation">(</span><span class="token variable">$order</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$event</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">order</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span> <span class="token operator">===</span> <span class="token variable">$order</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>После вызова <code>Event::fake()</code> прослушиватели событий выполняться не будут. Итак, если ваши тесты
            используют фабрики моделей, которые полагаются на события, такие как создание UUID во время
            <code>creating</code> события модели, вы должны позвонить <code>Event::fake()</code> <strong>после</strong>
            использования ваших фабрик.</p></p></div>
</blockquote>
<p></p>
<h4 id="faking-a-subset-of-events"><a href="#faking-a-subset-of-events">Подделка подмножества событий</a></h4>
<p>Если вы хотите подделать прослушиватели событий только для определенного набора событий, вы можете передать их методу
    <code>fake</code> или <code>fakeFor</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Test order process.
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">test_orders_can_be_processed</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    Event<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">fake</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
        OrderCreated<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

    <span class="token variable">$order</span> <span class="token operator">=</span> Order<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

    Event<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">assertDispatched</span><span
                class="token punctuation">(</span>OrderCreated<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

    <span class="token comment">// Other events are dispatched as normal...</span>
    <span class="token variable">$order</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">update</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token punctuation">.</span><span class="token punctuation">.</span><span
                class="token punctuation">.</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="scoped-event-fakes"><a href="#scoped-event-fakes">Подделки событий с ограниченным объемом <sup>Scoped event fakes</sup></a></h3>
<p>Если вы хотите подделать слушателей событий только для части вашего теста, вы можете использовать
    <code>fakeFor</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">Tests<span class="token punctuation">\</span>Feature</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Events<span
                        class="token punctuation">\</span>OrderCreated</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span
                        class="token punctuation">\</span>Order</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Testing<span class="token punctuation">\</span>RefreshDatabase</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Event</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Testing<span class="token punctuation">\</span>WithoutMiddleware</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Tests<span class="token punctuation">\</span>TestCase</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ExampleTest</span> <span class="token keyword">extends</span> <span
                    class="token class-name">TestCase</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Test order process.
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">test_orders_can_be_processed</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$order</span> <span class="token operator">=</span> Event<span
                    class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">fakeFor</span><span class="token punctuation">(</span><span
                    class="token keyword">function</span> <span class="token punctuation">(</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token variable">$order</span> <span class="token operator">=</span> Order<span
                    class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">factory</span><span class="token punctuation">(</span><span
                    class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">create</span><span class="token punctuation">(</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

            Event<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">assertDispatched</span><span
                    class="token punctuation">(</span>OrderCreated<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

            <span class="token keyword">return</span> <span class="token variable">$order</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>

        <span class="token comment">// Events are dispatched as normal and observers will run...</span>
        <span class="token variable">$order</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">update</span><span
                    class="token punctuation">(</span><span class="token punctuation">[</span><span
                    class="token punctuation">.</span><span class="token punctuation">.</span><span
                    class="token punctuation">.</span><span class="token punctuation">]</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h2 id="http-fake"><a href="#http-fake">Поддельный HTTP <sup>HTTP fake</sup></a></h2>
<p>Метод <code>Http</code> фасада <code>fake</code> позволяет указать HTTP-клиенту возвращать заглушенные / фиктивные
    ответы при выполнении запросов. Дополнительные сведения о подделке исходящих HTTP-запросов см. В <a
            href="http-client#testing">документации по тестированию HTTP-клиента</a>.</p>
<p></p>
<h2 id="mail-fake"><a href="#mail-fake">Поддельный емейл <sup>Mail fake</sup></a></h2>
<p>Вы можете использовать метод <code>Mail</code> фасада, <code>fake</code> чтобы предотвратить отправку почты. Обычно
    отправка почты не связана с кодом, который вы фактически тестируете. Скорее всего, достаточно просто заявить, что
    Laravel получил указание отправить данное почтовое сообщение.</p>
<p>После вызова метода <code>Mail</code> фасада <code>fake</code> вы можете утверждать, что <a href="mail">почтовые
        сообщения</a> были отправлены пользователям, и даже проверять данные, полученные почтовыми сообщениями:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">Tests<span class="token punctuation">\</span>Feature</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Mail<span
                        class="token punctuation">\</span>OrderShipped</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Testing<span class="token punctuation">\</span>RefreshDatabase</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Testing<span class="token punctuation">\</span>WithoutMiddleware</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Mail</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Tests<span class="token punctuation">\</span>TestCase</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ExampleTest</span> <span class="token keyword">extends</span> <span
                    class="token class-name">TestCase</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">test_orders_can_be_shipped</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        Mail<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">fake</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>

        <span class="token comment">// Perform order shipping...</span>

        <span class="token comment">// Assert that no mailables were sent...</span>
        Mail<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">assertNothingSent</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>

        <span class="token comment">// Assert that a mailable was sent...</span>
        Mail<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">assertSent</span><span
                    class="token punctuation">(</span>OrderShipped<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token comment">// Assert a mailable was sent twice...</span>
        Mail<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">assertSent</span><span
                    class="token punctuation">(</span>OrderShipped<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">,</span> <span class="token number">2</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token comment">// Assert a mailable was not sent...</span>
        Mail<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">assertNotSent</span><span
                    class="token punctuation">(</span>AnotherMailable<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Если вы ставите почтовые отправления в очередь для доставки в фоновом режиме, вы должны использовать этот <code>assertQueued</code>
    метод вместо <code>assertSent</code>:</p>
<pre class=" language-php"><code class=" language-php">Mail<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">assertQueued</span><span
                class="token punctuation">(</span>OrderShipped<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

Mail<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">assertNotQueued</span><span
                class="token punctuation">(</span>OrderShipped<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

Mail<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">assertNothingQueued</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы можете передать закрытие в методы <code>assertSent</code> или <code>assertNotSent</code>, чтобы утверждать, что
    было отправлено почтовое сообщение, которое проходит заданный «тест истинности». Если было отправлено хотя бы одно
    почтовое сообщение, которое проходит заданный тест на истинность, утверждение будет успешным:</p>
<pre class=" language-php"><code class=" language-php">Mail<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">assertSent</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span>OrderShipped <span class="token variable">$mail</span><span
                class="token punctuation">)</span> <span class="token keyword">use</span> <span
                class="token punctuation">(</span><span class="token variable">$order</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$mail</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">order</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span> <span class="token operator">===</span> <span class="token variable">$order</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>При вызове <code>Mail</code> методов утверждения фасада почтовый экземпляр, принятый предоставленным закрытием,
    предоставляет полезные методы для проверки получателей почтового сообщения:</p>
<pre class=" language-php"><code class=" language-php">Mail<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">assertSent</span><span
                class="token punctuation">(</span>OrderShipped<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$mail</span><span
                class="token punctuation">)</span> <span class="token keyword">use</span> <span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$mail</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">hasTo</span><span
                class="token punctuation">(</span><span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">email</span><span
                class="token punctuation">)</span> <span class="token operator">&amp;&amp;</span>
    <span class="token variable">$mail</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">hasCc</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'...'</span><span class="token punctuation">)</span> <span
                class="token operator">&amp;&amp;</span>
    <span class="token variable">$mail</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">hasBcc</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'...'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="notification-fake"><a href="#notification-fake">Поддельное уведомление <sup>Notification fake</sup></a></h2>
<p>Вы можете использовать метод <code>Notification</code> фасада, <code>fake</code> чтобы предотвратить отправку
    уведомлений. Обычно отправка уведомлений не связана с кодом, который вы фактически тестируете. Скорее всего,
    достаточно просто заявить, что Laravel получил указание отправить данное уведомление.</p>
<p>После вызова метода <code>Notification</code> фасада <code>fake</code> вы можете утверждать, что <a
            href="notifications">уведомления</a> были отправлены пользователям, и даже проверять данные, полученные в
    уведомлениях:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">Tests<span class="token punctuation">\</span>Feature</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Notifications<span
                        class="token punctuation">\</span>OrderShipped</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Testing<span class="token punctuation">\</span>RefreshDatabase</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Testing<span class="token punctuation">\</span>WithoutMiddleware</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Notification</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Tests<span class="token punctuation">\</span>TestCase</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ExampleTest</span> <span class="token keyword">extends</span> <span
                    class="token class-name">TestCase</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">test_orders_can_be_shipped</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        Notification<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">fake</span><span class="token punctuation">(</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token comment">// Perform order shipping...</span>

        <span class="token comment">// Assert that no notifications were sent...</span>
        Notification<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">assertNothingSent</span><span class="token punctuation">(</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token comment">// Assert a notification was sent to the given users...</span>
        Notification<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">assertSentTo</span><span class="token punctuation">(</span>
            <span class="token punctuation">[</span><span class="token variable">$user</span><span
                    class="token punctuation">]</span><span class="token punctuation">,</span> OrderShipped<span
                    class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token keyword">class</span>
        <span class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token comment">// Assert a notification was not sent...</span>
        Notification<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">assertNotSentTo</span><span class="token punctuation">(</span>
            <span class="token punctuation">[</span><span class="token variable">$user</span><span
                    class="token punctuation">]</span><span class="token punctuation">,</span> AnotherNotification<span
                    class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token keyword">class</span>
        <span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Вы можете передать закрытие в методы <code>assertSentTo</code> или <code>assertNotSentTo</code>, чтобы утверждать,
    что было отправлено уведомление, которое проходит заданный «тест истинности». Если было отправлено хотя бы одно
    уведомление, которое проходит заданный тест на истинность, то утверждение будет успешным:</p>
<pre class=" language-php"><code class=" language-php">Notification<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">assertSentTo</span><span
                class="token punctuation">(</span>
    <span class="token variable">$user</span><span class="token punctuation">,</span>
    <span class="token keyword">function</span> <span class="token punctuation">(</span>OrderShipped <span
                class="token variable">$notification</span><span class="token punctuation">,</span> <span
                class="token variable">$channels</span><span class="token punctuation">)</span> <span
                class="token keyword">use</span> <span class="token punctuation">(</span><span class="token variable">$order</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$notification</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">order</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span> <span class="token operator">===</span> <span class="token variable">$order</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="on-demand-notifications"><a href="#on-demand-notifications">Уведомления по запросу</a></h4>
<p>Если код, который вы тестируете, отправляет <a href="notifications#on-demand-notifications">уведомления по
        запросу</a>, вам нужно будет подтвердить, что уведомление было отправлено <code>Illuminate\Notifications\AnonymousNotifiable</code>
    экземпляру:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Notifications<span
                    class="token punctuation">\</span>AnonymousNotifiable</span><span class="token punctuation">;</span>

Notification<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">assertSentTo</span><span class="token punctuation">(</span>
    <span class="token keyword">new</span> <span class="token class-name">AnonymousNotifiable</span><span
                class="token punctuation">,</span> OrderShipped<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Передав закрытие в качестве третьего аргумента методам утверждения уведомления, вы можете определить, было ли
    отправлено уведомление по запросу на правильный адрес «маршрута»:</p>
<pre class=" language-php"><code class=" language-php">Notification<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">assertSentTo</span><span
                class="token punctuation">(</span>
    <span class="token keyword">new</span> <span class="token class-name">AnonymousNotifiable</span><span
                class="token punctuation">,</span>
    OrderShipped<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span><span class="token punctuation">,</span>
    <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token variable">$notification</span><span
                class="token punctuation">,</span> <span class="token variable">$channels</span><span
                class="token punctuation">,</span> <span class="token variable">$notifiable</span><span
                class="token punctuation">)</span> <span class="token keyword">use</span> <span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$notifiable</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">routes</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'mail'</span><span
                class="token punctuation">]</span> <span class="token operator">===</span> <span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">email</span><span
                class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="queue-fake"><a href="#queue-fake">Поддельная очередь <sup>Queue fake</sup></a></h2>
<p>Вы можете использовать метод <code>Queue</code> фасада, <code>fake</code> чтобы не допустить помещения заданий в
    очередь в очередь. Скорее всего, достаточно просто утверждать, что Laravel получил указание поместить данное задание
    в очередь, поскольку сами задания в очереди могут быть протестированы в другом тестовом классе.</p>
<p>После вызова метода <code>Queue</code> фасада <code>fake</code> вы можете утверждать, что приложение пыталось
    отправить задания в очередь:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">Tests<span class="token punctuation">\</span>Feature</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Jobs<span
                        class="token punctuation">\</span>AnotherJob</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Jobs<span
                        class="token punctuation">\</span>FinalJob</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Jobs<span
                        class="token punctuation">\</span>ShipOrder</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Testing<span class="token punctuation">\</span>RefreshDatabase</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Testing<span class="token punctuation">\</span>WithoutMiddleware</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Queue</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Tests<span class="token punctuation">\</span>TestCase</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ExampleTest</span> <span class="token keyword">extends</span> <span
                    class="token class-name">TestCase</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">test_orders_can_be_shipped</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        Queue<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">fake</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>

        <span class="token comment">// Perform order shipping...</span>

        <span class="token comment">// Assert that no jobs were pushed...</span>
        Queue<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">assertNothingPushed</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>

        <span class="token comment">// Assert a job was pushed to a given queue...</span>
        Queue<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">assertPushedOn</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'queue-name'</span><span
                    class="token punctuation">,</span> ShipOrder<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token comment">// Assert a job was pushed twice...</span>
        Queue<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">assertPushed</span><span
                    class="token punctuation">(</span>ShipOrder<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">,</span> <span class="token number">2</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token comment">// Assert a job was not pushed...</span>
        Queue<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">assertNotPushed</span><span
                    class="token punctuation">(</span>AnotherJob<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Вы можете передать закрытие в методы <code>assertPushed</code> или <code>assertNotPushed</code>, чтобы утверждать,
    что было отправлено задание, которое проходит заданный «тест истинности». Если было отправлено хотя бы одно задание,
    которое проходит заданный тест истинности, то утверждение будет успешным:</p>
<pre class=" language-php"><code class=" language-php">Queue<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">assertPushed</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span>ShipOrder <span class="token variable">$job</span><span
                class="token punctuation">)</span> <span class="token keyword">use</span> <span
                class="token punctuation">(</span><span class="token variable">$order</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$job</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">order</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span> <span class="token operator">===</span> <span class="token variable">$order</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="job-chains"><a href="#job-chains">Цепочки заданий <sup>Job chains</sup></a></h3>
<p><code>Queue</code> Фасад это <code>assertPushedWithChain</code> и <code>assertPushedWithoutChain</code> методы могут
    быть использованы для проверки рабочих мест цепи толкаемой работы. <code>assertPushedWithChain</code> Метод
    принимает основную работу в качестве первого аргумента и массив прикованных рабочих мест в качестве второго
    аргумента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Jobs<span
                    class="token punctuation">\</span>RecordShipment</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Jobs<span
                    class="token punctuation">\</span>ShipOrder</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Jobs<span
                    class="token punctuation">\</span>UpdateInventory</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Queue</span><span
                class="token punctuation">;</span>

Queue<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">assertPushedWithChain</span><span
                class="token punctuation">(</span>ShipOrder<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
    RecordShipment<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span><span class="token punctuation">,</span>
    UpdateInventory<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Как вы можете видеть в приведенном выше примере, массив связанных заданий может быть массивом имен классов заданий.
    Однако вы также можете предоставить массив фактических экземпляров задания. При этом Laravel гарантирует, что
    экземпляры задания относятся к одному классу и имеют одинаковые значения свойств связанных заданий, отправленных
    вашим приложением:</p>
<pre class=" language-php"><code class=" language-php">Queue<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">assertPushedWithChain</span><span
                class="token punctuation">(</span>ShipOrder<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
    <span class="token keyword">new</span> <span class="token class-name">RecordShipment</span><span
                class="token punctuation">,</span>
    <span class="token keyword">new</span> <span class="token class-name">UpdateInventory</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете использовать этот <code>assertPushedWithoutChain</code> метод, чтобы утверждать, что задание было
    отправлено без цепочки заданий:</p>
<pre class=" language-php"><code class=" language-php">Queue<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">assertPushedWithoutChain</span><span
                class="token punctuation">(</span>ShipOrder<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="storage-fake"><a href="#storage-fake">Поддельное хранилище <sup>Storage fake</sup></a></h2>
<p>Метод <code>Storage</code> фасада <code>fake</code> позволяет легко сгенерировать фальшивый диск, который в сочетании
    с утилитами для создания файлов этого <code>Illuminate\Http\UploadedFile</code> класса значительно упрощает
    тестирование загрузки файлов. Например:</p>
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
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">test_albums_can_be_uploaded</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        Storage<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">fake</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'photos'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token variable">$response</span> <span class="token operator">=</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">json</span><span
                    class="token punctuation">(</span><span class="token single-quoted-string string">'POST'</span><span
                    class="token punctuation">,</span> <span
                    class="token single-quoted-string string">'/photos'</span><span
                    class="token punctuation">,</span> <span class="token punctuation">[</span>
            UploadedFile<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">fake</span><span class="token punctuation">(</span><span
                    class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">image</span><span class="token punctuation">(</span><span
                    class="token single-quoted-string string">'photo1.jpg'</span><span
                    class="token punctuation">)</span><span class="token punctuation">,</span>
            UploadedFile<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">fake</span><span class="token punctuation">(</span><span
                    class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">image</span><span class="token punctuation">(</span><span
                    class="token single-quoted-string string">'photo2.jpg'</span><span
                    class="token punctuation">)</span>
        <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>

        <span class="token comment">// Assert one or more files were stored...</span>
        Storage<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">disk</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'photos'</span><span
                    class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">assertExists</span><span class="token punctuation">(</span><span
                    class="token single-quoted-string string">'photo1.jpg'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
        Storage<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">disk</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'photos'</span><span
                    class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">assertExists</span><span class="token punctuation">(</span><span
                    class="token punctuation">[</span><span
                    class="token single-quoted-string string">'photo1.jpg'</span><span
                    class="token punctuation">,</span> <span
                    class="token single-quoted-string string">'photo2.jpg'</span><span
                    class="token punctuation">]</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>

        <span class="token comment">// Assert one or more files were not stored...</span>
        Storage<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">disk</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'photos'</span><span
                    class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">assertMissing</span><span class="token punctuation">(</span><span
                    class="token single-quoted-string string">'missing.jpg'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
        Storage<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">disk</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'photos'</span><span
                    class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">assertMissing</span><span class="token punctuation">(</span><span
                    class="token punctuation">[</span><span
                    class="token single-quoted-string string">'missing.jpg'</span><span
                    class="token punctuation">,</span> <span class="token single-quoted-string string">'non-existing.jpg'</span><span
                    class="token punctuation">]</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Для получения дополнительной информации о тестировании загрузки файлов вы можете ознакомиться с <a
            href="http-tests#testing-file-uploads">информацией о загрузке файлов в документации по тестированию HTTP</a>.
</p>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>По умолчанию <code>fake</code> метод удаляет все файлы во временном каталоге. Если вы хотите сохранить эти
            файлы, вы можете использовать вместо них метод «persistentFake».</p></p></div>
</blockquote>
<p></p>
<h2 id="interacting-with-time"><a href="#interacting-with-time">Взаимодействие со временем <sup>Interacting with time</sup></a></h2>
<p>При тестировании вам может иногда потребоваться изменить время, возвращаемое такими помощниками, как <code>now</code>
    или <code>Illuminate\Support\Carbon::now()</code>. К счастью, базовый класс тестирования функций Laravel включает
    помощников, которые позволяют вам управлять текущим временем:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">public</span> <span
                class="token keyword">function</span> <span class="token function">testTimeCanBeManipulated</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// Travel into the future...</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">travel</span><span
                class="token punctuation">(</span><span class="token number">5</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">milliseconds</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">travel</span><span
                class="token punctuation">(</span><span class="token number">5</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">seconds</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">travel</span><span
                class="token punctuation">(</span><span class="token number">5</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">minutes</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">travel</span><span
                class="token punctuation">(</span><span class="token number">5</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">hours</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">travel</span><span
                class="token punctuation">(</span><span class="token number">5</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">days</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">travel</span><span
                class="token punctuation">(</span><span class="token number">5</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">weeks</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">travel</span><span
                class="token punctuation">(</span><span class="token number">5</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">years</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    
    <span class="token comment">// Travel into the past...</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">travel</span><span
                class="token punctuation">(</span><span class="token operator">-</span><span
                class="token number">5</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">hours</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    
    <span class="token comment">// Travel to an explicit time...</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">travelTo</span><span
                class="token punctuation">(</span><span class="token function">now</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">subHours</span><span
                class="token punctuation">(</span><span class="token number">6</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    
    <span class="token comment">// Return back to the present time...</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">travelBack</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
