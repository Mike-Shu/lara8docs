<h1>ПО промежуточного слоя (Middleware)</h1>
<ul>
    <li><a href="middleware#introduction">Вступление</a></li>
    <li><a href="middleware#defining-middleware">Определение промежуточного программного
            обеспечения</a></li>
    <li><a href="middleware#registering-middleware">Регистрация промежуточного программного
            обеспечения</a>
        <ul>
            <li><a href="middleware#global-middleware">Глобальное промежуточное ПО</a></li>
            <li><a href="middleware#assigning-middleware-to-routes">Назначение промежуточного
                    программного обеспечения для маршрутов</a></li>
            <li><a href="middleware#middleware-groups">Группы промежуточного программного
                    обеспечения</a></li>
            <li><a href="middleware#sorting-middleware">Сортировка промежуточного программного
                    обеспечения</a></li>
        </ul>
    </li>
    <li><a href="middleware#middleware-parameters">Параметры промежуточного программного
            обеспечения</a></li>
    <li><a href="middleware#terminable-middleware">Завершаемое промежуточное ПО</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Промежуточное ПО обеспечивает удобный механизм для проверки и фильтрации HTTP-запросов, поступающих в ваше
    приложение. Например, Laravel включает промежуточное программное обеспечение, которое проверяет, аутентифицирован ли
    пользователь вашего приложения. Если пользователь не аутентифицирован, промежуточное ПО перенаправит пользователя на
    экран входа в систему вашего приложения. Однако, если пользователь аутентифицирован, промежуточное программное
    обеспечение позволит запросу продолжить работу в приложении.</p>
<p>Может быть написано дополнительное промежуточное ПО для выполнения множества задач помимо аутентификации. Например,
    промежуточное ПО для ведения журнала может регистрировать все входящие запросы к вашему приложению. В структуру
    Laravel включено несколько промежуточного программного обеспечения, включая промежуточное ПО для аутентификации и
    защиты CSRF. Все это промежуточное ПО находится в <code>app/Http/Middleware</code> каталоге.</p>
<p></p>
<h2 id="defining-middleware"><a href="#defining-middleware">Определение промежуточного программного обеспечения</a></h2>
<p>Чтобы создать новое промежуточное ПО, используйте <code>make:middleware</code> Artisan-команду:</p>
<pre class=" language-php"><code class=" language-php">php artisan make<span class="token punctuation">:</span>middleware EnsureTokenIsValid</code></pre>
<p>Эта команда поместит новый <code>EnsureTokenIsValid</code> класс в ваш <code>app/Http/Middleware</code> каталог. В этом
    промежуточном программном обеспечении мы разрешим доступ к маршруту только в том случае, если предоставленный <code>token</code> ввод
    соответствует указанному значению. В противном случае мы перенаправим пользователей обратно на <code>home</code> URI:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Middleware</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Closure</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">EnsureTokenIsValid</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Handle an incoming request.
    *
    * @param  \Illuminate\Http\Request  $request
    * @param  \Closure  $next
    * @return mixed
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">handle</span><span
                    class="token punctuation">(</span><span class="token variable">$request</span><span
                    class="token punctuation">,</span> Closure <span class="token variable">$next</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">if</span> <span class="token punctuation">(</span><span
                    class="token variable">$request</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">input</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'token'</span><span
                    class="token punctuation">)</span> <span class="token operator">!==</span> <span
                    class="token single-quoted-string string">'my-secret-token'</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> <span class="token function">redirect</span><span
                    class="token punctuation">(</span><span class="token single-quoted-string string">'home'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span>

        <span class="token keyword">return</span> <span class="token variable">$next</span><span
                    class="token punctuation">(</span><span class="token variable">$request</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Как видите, если данное <code>token</code> не соответствует нашему секретному токену, промежуточное ПО вернет клиенту
    HTTP-перенаправление; в противном случае запрос будет передан в приложение. Чтобы передать запрос глубже в
    приложение (позволяя промежуточному программному обеспечению «пройти»), вы должны вызвать <code>$next</code> обратный
    вызов с расширением <code>$request</code>.</p>
<p>Лучше всего представить себе промежуточное ПО как серию «слоев» HTTP-запросов, которые должны пройти, прежде чем они
    попадут в ваше приложение. Каждый уровень может изучить запрос и даже полностью его отклонить.</p>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Все промежуточное программное обеспечение разрешается через <a href=">{literal}{{/literal}<container">сервисный
                контейнер</a>, поэтому вы можете указать любые необходимые зависимости в конструкторе промежуточного
            программного обеспечения.</p></p></div>
</blockquote>
<p></p>
<h4 id="middleware-and-responses"><a href="#middleware-and-responses"><a href="#middleware-and-responses">Промежуточное
            ПО и ответы</a></a></h4>
<p>Конечно, промежуточное ПО может выполнять задачи до или после передачи запроса в приложение. Например, следующее
    промежуточное программное обеспечение выполнит некоторую задачу <strong>до</strong> того, как запрос будет обработан
    приложением:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Middleware</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Closure</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">BeforeMiddleware</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">handle</span><span
                    class="token punctuation">(</span><span class="token variable">$request</span><span
                    class="token punctuation">,</span> Closure <span class="token variable">$next</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">// Perform action</span>

        <span class="token keyword">return</span> <span class="token variable">$next</span><span
                    class="token punctuation">(</span><span class="token variable">$request</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Однако это промежуточное ПО будет выполнять свою задачу <strong>после того,</strong> как запрос будет обработан
    приложением:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Middleware</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Closure</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">AfterMiddleware</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">handle</span><span
                    class="token punctuation">(</span><span class="token variable">$request</span><span
                    class="token punctuation">,</span> Closure <span class="token variable">$next</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$response</span> <span class="token operator">=</span> <span class="token variable">$next</span><span
                    class="token punctuation">(</span><span class="token variable">$request</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token comment">// Perform action</span>

        <span class="token keyword">return</span> <span class="token variable">$response</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h2 id="registering-middleware"><a href="#registering-middleware">Регистрация промежуточного программного
        обеспечения</a></h2>
<p></p>
<h3 id="global-middleware"><a href="#global-middleware">Глобальное промежуточное ПО</a></h3>
<p>Если вы хотите, чтобы промежуточное ПО запускалось во время каждого HTTP-запроса к вашему приложению, <code>$middleware</code> укажите
    <code>app/Http/Kernel.php</code> класс промежуточного ПО в свойстве вашего класса.</p>
<p></p>
<h3 id="assigning-middleware-to-routes"><a href="#assigning-middleware-to-routes">Назначение промежуточного программного
        обеспечения для маршрутов</a></h3>
<p>Если вы хотите назначить промежуточное программное обеспечение для определенных маршрутов, вы должны сначала
    назначить промежуточному программному обеспечению ключ в <code>app/Http/Kernel.php</code> файле вашего приложения.
    По умолчанию <code>$routeMiddleware</code> свойство этого класса содержит записи для промежуточного программного
    обеспечения, включенного в Laravel. Вы можете добавить свое собственное промежуточное ПО в этот список и назначить
    ему ключ по вашему выбору:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token comment">// Within App\Http\Kernel class...</span>

<span class="token keyword">protected</span> <span class="token variable">$routeMiddleware</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'auth'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> \<span class="token package">App<span
                    class="token punctuation">\</span>Http<span class="token punctuation">\</span>Middleware<span
                    class="token punctuation">\</span>Authenticate</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'auth.basic'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> \<span class="token package">Illuminate<span
                    class="token punctuation">\</span>Auth<span class="token punctuation">\</span>Middleware<span
                    class="token punctuation">\</span>AuthenticateWithBasicAuth</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'bindings'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> \<span class="token package">Illuminate<span
                    class="token punctuation">\</span>Routing<span class="token punctuation">\</span>Middleware<span
                    class="token punctuation">\</span>SubstituteBindings</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'cache.headers'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> \<span class="token package">Illuminate<span
                    class="token punctuation">\</span>Http<span class="token punctuation">\</span>Middleware<span
                    class="token punctuation">\</span>SetCacheHeaders</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'can'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> \<span class="token package">Illuminate<span
                    class="token punctuation">\</span>Auth<span class="token punctuation">\</span>Middleware<span
                    class="token punctuation">\</span>Authorize</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'guest'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> \<span class="token package">App<span
                    class="token punctuation">\</span>Http<span class="token punctuation">\</span>Middleware<span
                    class="token punctuation">\</span>RedirectIfAuthenticated</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'signed'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> \<span class="token package">Illuminate<span
                    class="token punctuation">\</span>Routing<span class="token punctuation">\</span>Middleware<span
                    class="token punctuation">\</span>ValidateSignature</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'throttle'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> \<span class="token package">Illuminate<span
                    class="token punctuation">\</span>Routing<span class="token punctuation">\</span>Middleware<span
                    class="token punctuation">\</span>ThrottleRequests</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'verified'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> \<span class="token package">Illuminate<span
                    class="token punctuation">\</span>Auth<span class="token punctuation">\</span>Middleware<span
                    class="token punctuation">\</span>EnsureEmailIsVerified</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">;</span></code></pre>
<p>После определения промежуточного программного обеспечения в ядре HTTP вы можете использовать этот
    <code>middleware</code> метод для назначения промежуточного программного обеспечения для маршрута:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/profile'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">middleware</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'auth'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете назначить несколько промежуточных программ для маршрута, передав массив имен промежуточных программ в
    <code>middleware</code> метод:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">middleware</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'first'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'second'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>При назначении промежуточного программного обеспечения вы также можете передать полное имя класса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Middleware<span class="token punctuation">\</span>EnsureTokenIsValid</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/profile'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">middleware</span><span
                class="token punctuation">(</span>EnsureTokenIsValid<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>При назначении промежуточного программного обеспечения группе маршрутов иногда может потребоваться запретить
    применение промежуточного программного обеспечения к отдельному маршруту в группе. Вы можете сделать это с помощью
    <code>withoutMiddleware</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Middleware<span class="token punctuation">\</span>EnsureTokenIsValid</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">middleware</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>EnsureTokenIsValid<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">group</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
            
    Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/profile'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">withoutMiddleware</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>EnsureTokenIsValid<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p><code>withoutMiddleware</code> Метод может удалить только маршрут промежуточного уровня и не относится к <a
            href=">{literal}{{/literal}<middleware#global-middleware">глобальному промежуточному слою</a>.</p>
<p></p>
<h3 id="middleware-groups"><a href="#middleware-groups">Группы промежуточного программного обеспечения</a></h3>
<p>Иногда вам может потребоваться сгруппировать несколько промежуточных программ под одним ключом, чтобы упростить их
    назначение маршрутам. Вы можете сделать это, используя <code>$middlewareGroups</code> свойство вашего HTTP-ядра.</p>
<p>Из коробки, Laravel поставляется с <code>web</code> и <code>api</code> промежуточным слоем группа, которые содержат
    общие промежуточное программное обеспечение вы можете применить к вебу и API маршрутам. Помните, что эта группа
    промежуточного программного обеспечения автоматически применяется <code>App\Providers\RouteServiceProvider</code> поставщиком
    услуг вашего приложения для маршрутов в соответствующих файлах <code>web</code> и <code>api</code> файлах маршрутов:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * The application's route middleware groups.
 *
 * @var array
 */</span>
<span class="token keyword">protected</span> <span class="token variable">$middlewareGroups</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'web'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        \<span class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Middleware<span
                    class="token punctuation">\</span>EncryptCookies</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
        \<span class="token package">Illuminate<span class="token punctuation">\</span>Cookie<span
                    class="token punctuation">\</span>Middleware<span class="token punctuation">\</span>AddQueuedCookiesToResponse</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
        \<span class="token package">Illuminate<span class="token punctuation">\</span>Session<span
                    class="token punctuation">\</span>Middleware<span
                    class="token punctuation">\</span>StartSession</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
        <span class="token comment">// \Illuminate\Session\Middleware\AuthenticateSession::class,</span>
        \<span class="token package">Illuminate<span class="token punctuation">\</span>View<span
                    class="token punctuation">\</span>Middleware<span class="token punctuation">\</span>ShareErrorsFromSession</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
        \<span class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Middleware<span class="token punctuation">\</span>VerifyCsrfToken</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
        \<span class="token package">Illuminate<span class="token punctuation">\</span>Routing<span
                    class="token punctuation">\</span>Middleware<span class="token punctuation">\</span>SubstituteBindings</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>

    <span class="token single-quoted-string string">'api'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'throttle:api'</span><span class="token punctuation">,</span>
        \<span class="token package">Illuminate<span class="token punctuation">\</span>Routing<span
                    class="token punctuation">\</span>Middleware<span class="token punctuation">\</span>SubstituteBindings</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">;</span></code></pre>
<p>Группы промежуточного программного обеспечения могут быть назначены маршрутам и действиям контроллера с
    использованием того же синтаксиса, что и индивидуальное промежуточное программное обеспечение. Опять же, группы
    промежуточного программного обеспечения упрощают одновременное назначение нескольких промежуточных программ для
    маршрута:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">middleware</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'web'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">middleware</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'web'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">group</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Из коробки, то <code>web</code> и <code>api</code> промежуточный слой группа автоматически применяются к вашему
            приложению, соответствующим <code>routes/web.php</code> и <code>routes/api.php</code> файлам по <code>App\Providers\RouteServiceProvider</code>.
        </p></p></div>
</blockquote>
<p></p>
<h3 id="sorting-middleware"><a href="#sorting-middleware">Сортировка промежуточного программного обеспечения</a></h3>
<p>В редких случаях вам может понадобиться ваше промежуточное программное обеспечение для выполнения в определенном
    порядке, но вы не сможете контролировать их порядок, когда они назначены маршруту. В этом случае вы можете указать
    свой приоритет промежуточного программного обеспечения, используя <code>$middlewarePriority</code> свойство вашего
    <code>app/Http/Kernel.php</code> файла. Это свойство может отсутствовать в вашем HTTP-ядре по умолчанию. Если он не
    существует, вы можете скопировать его определение по умолчанию ниже:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * The priority-sorted list of middleware.
 *
 * This forces non-global middleware to always be in the given order.
 *
 * @var array
 */</span>
<span class="token keyword">protected</span> <span class="token variable">$middlewarePriority</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span>
    \<span class="token package">Illuminate<span class="token punctuation">\</span>Cookie<span
                    class="token punctuation">\</span>Middleware<span
                    class="token punctuation">\</span>EncryptCookies</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
    \<span class="token package">Illuminate<span class="token punctuation">\</span>Session<span
                    class="token punctuation">\</span>Middleware<span
                    class="token punctuation">\</span>StartSession</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
    \<span class="token package">Illuminate<span class="token punctuation">\</span>View<span
                    class="token punctuation">\</span>Middleware<span class="token punctuation">\</span>ShareErrorsFromSession</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
    \<span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                    class="token punctuation">\</span>Auth<span class="token punctuation">\</span>Middleware<span
                    class="token punctuation">\</span>AuthenticatesRequests</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
    \<span class="token package">Illuminate<span class="token punctuation">\</span>Routing<span
                    class="token punctuation">\</span>Middleware<span class="token punctuation">\</span>ThrottleRequests</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
    \<span class="token package">Illuminate<span class="token punctuation">\</span>Session<span
                    class="token punctuation">\</span>Middleware<span class="token punctuation">\</span>AuthenticateSession</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
    \<span class="token package">Illuminate<span class="token punctuation">\</span>Routing<span
                    class="token punctuation">\</span>Middleware<span class="token punctuation">\</span>SubstituteBindings</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
    \<span class="token package">Illuminate<span class="token punctuation">\</span>Auth<span
                    class="token punctuation">\</span>Middleware<span class="token punctuation">\</span>Authorize</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="middleware-parameters"><a href="#middleware-parameters">Параметры промежуточного программного обеспечения</a>
</h2>
<p>Промежуточное ПО также может получать дополнительные параметры. Например, если вашему приложению необходимо
    проверить, что аутентифицированный пользователь имеет заданную «роль» перед выполнением заданного действия, вы
    можете создать <code>EnsureUserHasRole</code> промежуточное ПО, которое получает имя роли в качестве дополнительного
    аргумента.</p>
<p>Дополнительные параметры промежуточного программного обеспечения будут переданы промежуточному программному
    обеспечению после <code>$next</code> аргумента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Middleware</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Closure</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">EnsureUserHasRole</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Handle the incoming request.
    *
    * @param  \Illuminate\Http\Request  $request
    * @param  \Closure  $next
    * @param  string  $role
    * @return mixed
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">handle</span><span
                    class="token punctuation">(</span><span class="token variable">$request</span><span
                    class="token punctuation">,</span> Closure <span class="token variable">$next</span><span
                    class="token punctuation">,</span> <span class="token variable">$role</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token operator">!</span> <span
                    class="token variable">$request</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">user</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">hasRole</span><span
                    class="token punctuation">(</span><span class="token variable">$role</span><span
                    class="token punctuation">)</span><span class="token punctuation">)</span> <span
                    class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">// Redirect...</span>
        <span class="token punctuation">}</span>

        <span class="token keyword">return</span> <span class="token variable">$next</span><span
                    class="token punctuation">(</span><span class="token variable">$request</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>

<span class="token punctuation">}</span></span></code></pre>
<p>Параметры промежуточного программного обеспечения можно указать при определении маршрута, разделив имя промежуточного
    программного обеспечения и параметры расширением <code>:</code>. Несколько параметров следует разделять запятыми:
</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">put</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'/post/{literal}{id}{/literal}'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$id</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">middleware</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'role:editor'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="terminable-middleware"><a href="#terminable-middleware">Завершаемое промежуточное ПО</a></h2>
<p>Иногда промежуточному программному обеспечению может потребоваться выполнить некоторую работу после того, как
    HTTP-ответ был отправлен в браузер. Если вы определяете <code>terminate</code> метод в промежуточном программном
    обеспечении, а ваш веб-сервер использует FastCGI, <code>terminate</code> метод будет автоматически вызываться после
    отправки ответа в браузер:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">Illuminate<span
                        class="token punctuation">\</span>Session<span
                        class="token punctuation">\</span>Middleware</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Closure</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">TerminatingMiddleware</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Handle an incoming request.
    *
    * @param  \Illuminate\Http\Request  $request
    * @param  \Closure  $next
    * @return mixed
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">handle</span><span
                    class="token punctuation">(</span><span class="token variable">$request</span><span
                    class="token punctuation">,</span> Closure <span class="token variable">$next</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$next</span><span
                    class="token punctuation">(</span><span class="token variable">$request</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
    * Handle tasks after the response has been sent to the browser.
    *
    * @param  \Illuminate\Http\Request  $request
    * @param  \Illuminate\Http\Response  $response
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">terminate</span><span
                    class="token punctuation">(</span><span class="token variable">$request</span><span
                    class="token punctuation">,</span> <span class="token variable">$response</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//...</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p><code>terminate</code> Метод должен получить как запрос и ответ. После того, как вы определили завершаемое
    промежуточное программное обеспечение, вы должны добавить его в список маршрутов или глобального промежуточного
    программного обеспечения в <code>app/Http/Kernel.php</code> файле.</p>
<p>При вызове <code>terminate</code> метода в вашем промежуточном программном обеспечении Laravel разрешит новый
    экземпляр промежуточного программного обеспечения из <a href=">{literal}{{/literal}<container">контейнера службы</a>
   . Если вы хотели бы использовать тот же экземпляр промежуточного слоя, когда <code>handle</code> и
    <code>terminate</code> методы называются, зарегистрировать промежуточный с контейнером с использованием контейнера
    <code>singleton</code> метода. Обычно это следует делать с помощью <code>register</code> метода вашего <code>AppServiceProvider</code>:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Middleware<span class="token punctuation">\</span>TerminatingMiddleware</span><span
                class="token punctuation">;</span>

<span class="token comment">/**
 * Register any application services.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">register</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">app</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">singleton</span><span
                class="token punctuation">(</span>TerminatingMiddleware<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
