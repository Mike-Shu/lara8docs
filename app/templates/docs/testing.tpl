<h1>Тестирование: начало работы <sup>Testing: getting started</sup></h1>
<ul>
    <li><a href="testing#introduction">Вступление</a></li>
    <li><a href="testing#environment">Окружение</a></li>
    <li><a href="testing#creating-tests">Создание тестов</a></li>
    <li><a href="testing#running-tests">Запуск тестов</a>
        <ul>
            <li><a href="testing#running-tests-in-parallel">Параллельное выполнение тестов</a></li>
        </ul>
    </li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Laravel построен с учетом требований тестирования. Фактически, поддержка тестирования с помощью PHPUnit включена
    прямо из коробки, и <code>phpunit.xml</code> файл уже настроен для вашего приложения. Платформа также поставляется с
    удобными вспомогательными методами, позволяющими выразительно тестировать ваши приложения.</p>
<p>По умолчанию <code>tests</code> каталог вашего приложения содержит два каталога: <code>Feature</code> и
    <code>Unit</code>. Модульные тесты - это тесты, которые сосредоточены на очень небольшой изолированной части вашего
    кода. Фактически, большинство модульных тестов, вероятно, сосредоточено на одном методе. Тесты в вашем каталоге
    «Модульных» тестов не загружают ваше приложение Laravel и, следовательно, не могут получить доступ к базе данных
    вашего приложения или другим службам фреймворка.</p>
<p>Тесты функций могут тестировать большую часть вашего кода, в том числе то, как несколько объектов взаимодействуют
    друг с другом, или даже полный HTTP-запрос к конечной точке JSON. <strong>Как правило, большинство ваших тестов
        должны быть функциональными. Эти типы тестов обеспечивают максимальную уверенность в том, что ваша система в
        целом функционирует должным образом.</strong></p>
<p><code>ExampleTest.php</code> Файл предоставляется в обоих <code>Feature</code> и <code>Unit</code> тестовых
    каталогах. После установки нового приложения Laravel выполните команды <code>vendor/bin/phpunit</code> или
    <code>php artisan test</code> для запуска тестов.</p>
<p></p>
<h2 id="environment"><a href="#environment">Окружение</a></h2>
<p>При выполнении тестов, Laravel автоматически установит <a href="configuration#environment-configuration">среду
        конфигурации</a> в <code>testing</code> связи с переменным окружением, определенные в <code>phpunit.xml</code>
    файле. Laravel также автоматически настраивает сеанс и кеш для <code>array</code> драйвера во время тестирования,
    что означает, что данные сеанса или кеша не будут сохраняться во время тестирования.</p>
<p>При необходимости вы можете определить другие значения конфигурации среды тестирования. В <code>testing</code>
    переменных окружениях может быть сконфигурированы в вашем приложении <code>phpunit.xml</code> файл, но убедитесь,
    чтобы очистить кэш конфигурации, используя <code>config:clear</code> команду Artisan перед запуском тесты!</p>
<p></p>
<h4 id="the-env-testing-environment-file"><a href="#the-env-testing-environment-file">Файл окружения <code>.env.testing</code></a></h4>
<p>Кроме того, вы можете создать <code>.env.testing</code> файл в корне вашего проекта. Этот файл будет использоваться
    вместо <code>.env</code> файла при запуске тестов PHPUnit или выполнении команд Artisan с <code>--env=testing</code>
    параметром.</p>
<p></p>
<h4 id="the-creates-application-trait"><a href="#the-creates-application-trait">Трейт <code>CreatesApplication</code></a>
</h4>
<p>Laravel включает трейт <code>CreatesApplication</code>, который применяется к базовому классу <code>TestCase</code>
    вашего приложения. Этот трейт содержит метод <code>createApplication</code>, который загружает приложение Laravel
    перед запуском ваших тестов. Важно, чтобы вы оставили этот трейт на его исходном месте, так как от него зависят
    некоторые функции, такие как функция параллельного тестирования Laravel.</p>
<p></p>
<h2 id="creating-tests"><a href="#creating-tests">Создание тестов</a></h2>
<p>Чтобы создать новый тестовый пример, используйте команду <code>make:test</code> Artisan. По умолчанию тесты будут
    помещены в <code>tests/Feature</code> каталог:</p>
<pre class=" language-php"><code class=" language-php">php artisan make<span class="token punctuation">:</span>test UserTest</code></pre>
<p>Если вы хотите создать тест в <code>tests/Unit</code> каталоге, вы можете использовать <code>--unit</code> опцию при
    выполнении <code>make:test</code> команды:</p>
<pre class=" language-php"><code class=" language-php">php artisan make<span class="token punctuation">:</span>test UserTest <span
                class="token operator">--</span>unit</code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Заготовки тестов могут быть настроены с помощью <a href="artisan#stub-customization">публикации заглушек</a>
        </p></p></div>
</blockquote>
<p>После создания теста вы можете определить методы тестирования, как обычно, используя <a href="https://phpunit.de">PHPUnit</a>.
    Чтобы запустить тесты, выполните команду <code>vendor/bin/phpunit</code> или <code>php artisan test</code> с вашего
    терминала:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">Tests<span class="token punctuation">\</span>Unit</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">PHPUnit<span class="token punctuation">\</span>Framework<span
                        class="token punctuation">\</span>TestCase</span><span class="token punctuation">;</span>

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
        <span class="token variable">$this</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">assertTrue</span><span
                    class="token punctuation">(</span><span class="token boolean constant">true</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Если вы определяете свои собственные <code>setUp</code> / <code>tearDown</code> методы в тестовом классе,
            обязательно вызывайте соответствующие <code>parent::setUp()</code> / <code>parent::tearDown()</code> методы
            в родительском классе.</p></p></div>
</blockquote>
<p></p>
<h2 id="running-tests"><a href="#running-tests">Запуск тестов</a></h2>
<p>Как упоминалось ранее, после того, как вы написали тесты, вы можете запускать их, используя <code>phpunit</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token punctuation">.</span><span
                class="token operator">/</span>vendor<span class="token operator">/</span>bin<span
                class="token operator">/</span>phpunit</code></pre>
<p>В дополнение к <code>phpunit</code> команде вы можете использовать команду <code>test</code> Artisan для запуска
    тестов. Средство выполнения тестов Artisan предоставляет подробные отчеты о тестах, чтобы упростить разработку и
    отладку:</p>
<pre class=" language-php"><code class=" language-php">php artisan test</code></pre>
<p>Любые аргументы, которые могут быть переданы <code>phpunit</code> команде, также могут быть переданы команде Artisan
    <code>test</code>:</p>
<pre class=" language-php"><code class=" language-php">php artisan test <span
                class="token operator">--</span>testsuite<span class="token operator">=</span>Feature <span
                class="token operator">--</span>stop<span class="token operator">-</span>on<span class="token operator">-</span>failure</code></pre>
<p></p>
<h3 id="running-tests-in-parallel"><a href="#running-tests-in-parallel">Параллельное выполнение тестов</a></h3>
<p>По умолчанию Laravel и PHPUnit выполняют ваши тесты последовательно в рамках одного процесса. Однако вы можете
    значительно сократить время, необходимое для запуска ваших тестов, запустив тесты одновременно в нескольких
    процессах. Для начала включите <code>--parallel</code> опцию при выполнении <code>test</code> Artisan-команды:</p>
<pre class=" language-php"><code class=" language-php">php artisan test <span
                class="token operator">--</span>parallel</code></pre>
<p>По умолчанию Laravel создает столько процессов, сколько ядер ЦП доступно на вашем компьютере. Однако вы можете
    настроить количество процессов, используя <code>--processes</code> опцию:</p>
<pre class=" language-php"><code class=" language-php">php artisan test <span
                class="token operator">--</span>parallel <span class="token operator">--</span>processes<span
                class="token operator">=</span><span class="token number">4</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>При параллельном запуске тестов некоторые параметры PHPUnit (например, <code>--do-not-cache-result</code> )
            могут быть недоступны.</p></p></div>
</blockquote>
<p></p>
<h4 id="parallel-testing-and-databases"><a href="#parallel-testing-and-databases">Параллельное тестирование и базы
        данных</a></h4>
<p>Laravel автоматически обрабатывает создание и перенос тестовой базы данных для каждого параллельного процесса, в
    котором выполняются ваши тесты. К тестовым базам данных будет добавлен суффикс процесса, уникальный для каждого
    процесса. Например, если у вас есть два параллельных процесса тестирования, Laravel будет создавать, использовать
    <code>your_db_test_1</code> и <code>your_db_test_2</code> тестировать базы данных.</p>
<p>По умолчанию тестовые базы данных сохраняются между вызовами команды <code>test</code> Artisan, чтобы их можно было
    снова использовать при последующих <code>test</code> вызовах. Однако вы можете воссоздать их, используя <code>--recreate-databases</code>
    опцию:</p>
<pre class=" language-php"><code class=" language-php">php artisan test <span
                class="token operator">--</span>parallel <span class="token operator">--</span>recreate<span
                class="token operator">-</span>databases</code></pre>
<p></p>
<h4 id="parallel-testing-hooks"><a href="#parallel-testing-hooks">Крючки для параллельного тестирования</a></h4>
<p>Иногда вам может потребоваться подготовить определенные ресурсы, используемые тестами вашего приложения, чтобы их
    можно было безопасно использовать в нескольких процессах тестирования.</p>
<p>Используя <code>ParallelTesting</code> фасад, вы можете указать код, который будет выполняться в <code>setUp</code> и
    <code>tearDown</code> процесса или тестового примера. Данные замыкания получать <code>$token</code> и <code>$testCase</code>
    переменные, которые содержат маркер процесса и текущий тестовый пример, соответственно:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Providers</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Artisan</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span class="token punctuation">\</span>ParallelTesting</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>ServiceProvider</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">AppServiceProvider</span> <span
                    class="token keyword">extends</span> <span class="token class-name">ServiceProvider</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Bootstrap any application services.
     *
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">boot</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        ParallelTesting<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">setUpProcess</span><span class="token punctuation">(</span><span
                    class="token keyword">function</span> <span class="token punctuation">(</span><span
                    class="token variable">$token</span><span class="token punctuation">)</span> <span
                    class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">//...</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>

        ParallelTesting<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">setUpTestCase</span><span class="token punctuation">(</span><span
                    class="token keyword">function</span> <span class="token punctuation">(</span><span
                    class="token variable">$token</span><span class="token punctuation">,</span> <span
                    class="token variable">$testCase</span><span class="token punctuation">)</span> <span
                    class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">//...</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>

        <span class="token comment">// Executed when a test database is created...</span>
        ParallelTesting<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">setUpTestDatabase</span><span class="token punctuation">(</span><span
                    class="token keyword">function</span> <span class="token punctuation">(</span><span
                    class="token variable">$database</span><span class="token punctuation">,</span> <span
                    class="token variable">$token</span><span class="token punctuation">)</span> <span
                    class="token punctuation">{literal}{{/literal}</span>
            Artisan<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">call</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'db:seed'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>

        ParallelTesting<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">tearDownTestCase</span><span class="token punctuation">(</span><span
                    class="token keyword">function</span> <span class="token punctuation">(</span><span
                    class="token variable">$token</span><span class="token punctuation">,</span> <span
                    class="token variable">$testCase</span><span class="token punctuation">)</span> <span
                    class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">//...</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>

        ParallelTesting<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">tearDownProcess</span><span class="token punctuation">(</span><span
                    class="token keyword">function</span> <span class="token punctuation">(</span><span
                    class="token variable">$token</span><span class="token punctuation">)</span> <span
                    class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">//...</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h4 id="accessing-the-parallel-testing-token"><a href="#accessing-the-parallel-testing-token">Доступ к токену
        параллельного тестирования</a></h4>
<p>Если вы хотите получить доступ к «токену» текущего параллельного процесса из любого другого места в тестовом коде
    вашего приложения, вы можете использовать этот <code>token</code> метод. Этот токен представляет собой уникальный
    целочисленный идентификатор для отдельного процесса тестирования и может использоваться для сегментации ресурсов по
    параллельным процессам тестирования. Например, Laravel автоматически добавляет этот токен в конец тестовых баз
    данных, создаваемых каждым параллельным процессом тестирования:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$token</span> <span
                class="token operator">=</span> ParallelTesting<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">token</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
