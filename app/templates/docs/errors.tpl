<h1>Обработка ошибок</h1>
<ul>
    <li><a href="errors#introduction">Вступление</a></li>
    <li><a href="errors#configuration">Конфигурация</a></li>
    <li><a href="errors#the-exception-handler">Обработчик исключений</a>
        <ul>
            <li><a href="errors#reporting-exceptions">Отчет об исключениях</a></li>
            <li><a href="errors#ignoring-exceptions-by-type">Игнорирование исключений по типу</a></li>
            <li><a href="errors#rendering-exceptions">Отображение исключений</a></li>
            <li><a href="errors#renderable-exceptions">Отчетные и отображаемые исключения</a></li>
        </ul>
    </li>
    <li><a href="errors#http-exceptions">Исключения HTTP</a>
        <ul>
            <li><a href="errors#custom-http-error-pages">Пользовательские страницы ошибок HTTP</a></li>
        </ul>
    </li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Когда вы запускаете новый проект Laravel, обработка ошибок и исключений уже настроена для вас. <code>App\Exceptions\Handler</code> Класс
   , где все исключения брошенных приложений регистрируются, а затем оказываются пользователю. В этой документации мы
    углубимся в этот класс.</p>
<p></p>
<h2 id="configuration"><a href="#configuration">Конфигурация</a></h2>
<p>Параметр <code>debug</code> в вашем <code>config/app.php</code> файле конфигурации определяет, сколько информации об
    ошибке фактически отображается пользователю. По умолчанию этот параметр настроен на соблюдение значения <code>APP_DEBUG</code> переменной
    среды, которая хранится в вашем <code>.env</code> файле.</p>
<p>Во время локальной разработки вы должны установить для <code>APP_DEBUG</code> переменной среды значение
    <code>true</code>. <strong>В вашей производственной среде это значение всегда должно быть <code>false</code>. Если
        значение установлено <code>true</code> в производственной среде, вы рискуете раскрыть конфиденциальные значения
        конфигурации конечным пользователям вашего приложения.</strong></p>
<p></p>
<h2 id="the-exception-handler"><a href="#the-exception-handler">Обработчик исключений</a></h2>
<p></p>
<h3 id="reporting-exceptions"><a href="#reporting-exceptions">Отчет об исключениях</a></h3>
<p>Все исключения обрабатываются <code>App\Exceptions\Handler</code> классом. Этот класс содержит <code>register</code> метод,
    в котором вы можете зарегистрировать настраиваемые отчеты об исключениях и обратные вызовы отрисовки. Мы подробно
    рассмотрим каждую из этих концепций. Отчет об исключениях используется для регистрации исключений или отправки их во
    внешнюю службу, такую как <a href="https://flareapp.io">Flare</a>, <a href="https://bugsnag.com">Bugsnag</a> или
    <a href="https://github.com/getsentry/sentry-laravel">Sentry</a>. По умолчанию исключения будут регистрироваться в
    зависимости от вашей конфигурации <a href="logging">ведения журнала</a>. Однако вы можете регистрировать исключения
    как хотите.</p>
<p>Например, если вам нужно сообщить о различных типах исключений по-разному, вы можете использовать этот <code>reportable</code> метод
    для регистрации закрытия, которое должно выполняться, когда необходимо сообщить об исключении данного типа. Laravel
    определит, какой тип исключения сообщает о закрытии, изучив подсказку типа закрытия:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Exceptions<span
                    class="token punctuation">\</span>InvalidOrderException</span><span
                class="token punctuation">;</span>

<span class="token comment">/**
 * Register the exception handling callbacks for the application.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">register</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">reportable</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span class="token punctuation">(</span>InvalidOrderException <span class="token variable">$e</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span></code></pre>
<p>Когда вы регистрируете пользовательский обратный вызов для отчетов об исключениях, используя этот
    <code>reportable</code> метод, Laravel по-прежнему будет регистрировать исключение, используя конфигурацию ведения
    журнала по умолчанию для приложения. Если вы хотите остановить распространение исключения в стек журналов по
    умолчанию, вы можете использовать этот <code>stop</code> метод при определении обратного вызова отчета или возврата
    <code>false</code> из обратного вызова:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">reportable</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span>InvalidOrderException <span class="token variable">$e</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">//</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">stop</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">reportable</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span>InvalidOrderException <span class="token variable">$e</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> <span class="token boolean constant">false</span><span class="token punctuation">;</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Чтобы настроить отчет об исключениях для данного исключения, вы также можете рассмотреть возможность
            использования отчетов об <a href="errors#renderable-exceptions">исключениях.</a></p></p></div>
</blockquote>
<p></p>
<h4 id="global-log-context"><a href="#global-log-context">Глобальный контекст журнала</a></h4>
<p>Если доступно, Laravel автоматически добавляет идентификатор текущего пользователя в каждое сообщение журнала
    исключения в качестве контекстных данных. Вы можете определить свои собственные глобальные контекстные данные,
    переопределив <code>context</code> метод класса вашего приложения <code>App\Exceptions\Handler</code>. Эта информация
    будет включена в каждое сообщение журнала исключения, написанное вашим приложением:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the default context variables for logging.
 *
 * @return array
 */</span>
<span class="token keyword">protected</span> <span class="token keyword">function</span> <span class="token function">context</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token function">array_merge</span><span class="token punctuation">(</span><span class="token keyword">parent</span><span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">context</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">,</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'foo'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token single-quoted-string string">'bar'</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="the-report-helper"><a href="#the-report-helper"><code>report</code> Helper</a></h4>
<p>Иногда вам может потребоваться сообщить об исключении, но продолжить обработку текущего запроса. <code>report</code> Вспомогательная
    функция позволяет быстро сообщать исключение через обработчик исключений без рендеринга страницы ошибок для
    пользователя:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">public</span> <span
                class="token keyword">function</span> <span class="token function">isValid</span><span
                class="token punctuation">(</span><span class="token variable">$value</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">try</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// Validate the value...</span>
    <span class="token punctuation">}</span> <span class="token keyword">catch</span> <span class="token punctuation">(</span>Throwable <span class="token variable">$e</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token function">report</span><span class="token punctuation">(</span><span class="token variable">$e</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

    <span class="token keyword">return</span> <span class="token boolean constant">false</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
    <span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="ignoring-exceptions-by-type"><a href="#ignoring-exceptions-by-type">Игнорирование исключений по типу</a></h3>
<p>При создании приложения будут некоторые типы исключений, которые вы просто хотите игнорировать и никогда не сообщать.
    Обработчик исключений вашего приложения содержит <code>$dontReport</code> свойство, которое инициализируется пустым
    массивом. Ни о каких классах, добавленных к этому свойству, никогда не будет сообщено; однако у них все еще может
    быть собственная логика рендеринга:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Exceptions<span
                    class="token punctuation">\</span>InvalidOrderException</span><span
                class="token punctuation">;</span>

<span class="token comment">/**
 * A list of the exception types that should not be reported.
 *
 * @var array
 */</span>
<span class="token keyword">protected</span> <span class="token variable">$dontReport</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span>
    InvalidOrderException<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p> За кулисами Laravel уже игнорирует для вас некоторые типы ошибок, такие как исключения, возникающие из-за
            ошибок 404 HTTP «не найдено» или 419 ответов HTTP, сгенерированных недопустимыми токенами CSRF.</p></p>
    </div>
</blockquote>
<p></p>
<h3 id="rendering-exceptions"><a href="#rendering-exceptions">Отображение исключений</a></h3>
<p>По умолчанию обработчик исключений Laravel будет преобразовывать исключения в HTTP-ответ за вас. Однако вы можете
    зарегистрировать настраиваемое закрытие отрисовки для исключений данного типа. Вы можете сделать это с помощью
    <code>renderable</code> метода вашего обработчика исключений.</p>
<p>Замыкание, переданное <code>renderable</code> методу, должно возвращать экземпляр
    <code>Illuminate\Http\Response</code>, который может быть сгенерирован с помощью <code>response</code> помощника.
    Laravel определит, какой тип исключения рендерит закрытие, исследуя подсказку типа закрытия:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Exceptions<span
                    class="token punctuation">\</span>InvalidOrderException</span><span
                class="token punctuation">;</span>

<span class="token comment">/**
 * Register the exception handling callbacks for the application.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">register</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">renderable</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span class="token punctuation">(</span>InvalidOrderException <span class="token variable">$e</span><span class="token punctuation">,</span> <span class="token variable">$request</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token function">response</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">view</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'errors.invalid-order'</span><span class="token punctuation">,</span> <span class="token punctuation">[</span><span class="token punctuation">]</span><span class="token punctuation">,</span> <span class="token number">500</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="renderable-exceptions"><a href="#renderable-exceptions">Отчетные и отображаемые исключения</a></h3>
<p>Вместо исключений типа проверки в обработчик исключений в <code>register</code> методе, вы можете определить <code>report</code> и
    <code>render</code> методы непосредственно на пользовательских исключений. Когда эти методы существуют, они будут
    автоматически вызываться фреймворком:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Exceptions</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Exception</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">InvalidOrderException</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Exception</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Report the exception.
    *
    * @return bool|null
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">report</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
    * Render the exception into an HTTP response.
    *
    * @param  \Illuminate\Http\Request  $request
    * @return \Illuminate\Http\Response
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">render</span><span class="token punctuation">(</span><span class="token variable">$request</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token function">response</span><span class="token punctuation">(</span><span class="token punctuation">.</span><span class="token punctuation">.</span><span class="token punctuation">.</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
    <span class="token punctuation">}</span></span></code></pre>
<p>Если ваше исключение содержит настраиваемую логику отчетности, которая необходима только при выполнении определенных
    условий, вам может потребоваться указать Laravel иногда сообщать об исключении, используя конфигурацию обработки
    исключений по умолчанию. Для этого вы можете вернуться <code>false</code> из <code>report</code> метода исключения:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Report the exception.
 *
 * @return bool|null
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">report</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// Determine if the exception needs custom reporting...</span>

    <span class="token keyword">return</span> <span class="token boolean constant">false</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Вы можете указать любые требуемые зависимости <code>report</code> метода, и они будут автоматически введены в
            метод <a href="container">контейнером служб</a> Laravel.</p></p></div>
</blockquote>
<p></p>
<h2 id="http-exceptions"><a href="#http-exceptions">Исключения HTTP</a></h2>
<p>Некоторые исключения описывают коды ошибок HTTP с сервера. Например, это может быть ошибка «страница не найдена»
    (404), «неавторизованная ошибка» (401) или даже ошибка 500, сгенерированная разработчиком. Чтобы сгенерировать такой
    ответ из любого места вашего приложения, вы можете использовать <code>abort</code> помощник:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">abort</span><span
                class="token punctuation">(</span><span class="token number">404</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="custom-http-error-pages"><a href="#custom-http-error-pages">Пользовательские страницы ошибок HTTP</a></h3>
<p>Laravel позволяет легко отображать настраиваемые страницы ошибок для различных кодов состояния HTTP. Например, если
    вы хотите настроить страницу ошибок для кодов состояния 404 HTTP, создайте файл <code>resources/views/errors/404.blade.php</code>.
    Этот файл будет использоваться для всех ошибок 404, сгенерированных вашим приложением. Представления в этом каталоге
    должны быть названы в соответствии с кодом состояния HTTP, которому они соответствуют. <code>Symfony\Component\HttpKernel\Exception\HttpException</code> Экземпляр
    поднятых <code>abort</code> функций будет передан в представление в качестве <code>$exception</code> переменного:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>h2<span
                class="token operator">&gt;</span><span
                class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">{literal}{{/literal}</span> <span class="token variable">$exception</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">getMessage</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">}</span><span class="token punctuation">}</span><span
                class="token operator">&lt;</span><span class="token operator">/</span>h2<span class="token operator">&gt;</span></code></pre>
<p>Вы можете опубликовать шаблоны страниц ошибок Laravel по умолчанию с помощью команды <code>vendor:publish</code> Artisan.
    После публикации шаблонов вы можете настроить их по своему вкусу:</p>
<pre class=" language-php"><code class=" language-php">php artisan vendor<span class="token punctuation">:</span>publish <span
                class="token operator">--</span>tag<span class="token operator">=</span>laravel<span
                class="token operator">-</span>errors</code></pre> 
