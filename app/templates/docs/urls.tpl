<h1>Генерация URL</h1>
<ul>
    <li><a href="urls#introduction">Вступление</a></li>
    <li><a href="urls#the-basics">Основы</a>
        <ul>
            <li><a href="urls#generating-urls">Создание URL-адресов</a></li>
            <li><a href="urls#accessing-the-current-url">Доступ к текущему URL</a></li>
        </ul>
    </li>
    <li><a href="urls#urls-for-named-routes">URL-адреса для именованных маршрутов</a>
        <ul>
            <li><a href="urls#signed-urls">Подписанные URL</a></li>
        </ul>
    </li>
    <li><a href="urls#urls-for-controller-actions">URL-адреса для действий контроллера</a></li>
    <li><a href="urls#default-values">Значения по умолчанию</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Laravel предоставляет несколько помощников, которые помогут вам в создании URL-адресов для вашего приложения. Эти
    помощники в первую очередь полезны при построении ссылок в ваших шаблонах и ответах API или при создании ответов
    перенаправления в другую часть вашего приложения.</p>
<p></p>
<h2 id="the-basics"><a href="#the-basics">Основы</a></h2>
<p></p>
<h3 id="generating-urls"><a href="#generating-urls">Создание URL-адресов</a></h3>
<p><code>url</code> Помощник может быть использован для создания произвольной URL - адреса для вашего приложения.
    Сгенерированный URL-адрес будет автоматически использовать схему (HTTP или HTTPS) и хост из текущего запроса,
    обрабатываемого приложением:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$post</span> <span
                class="token operator">=</span> App\<span class="token package">Models<span
                    class="token punctuation">\</span>Post</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">echo</span> <span class="token function">url</span><span
                class="token punctuation">(</span><span class="token double-quoted-string string">"/posts/<span
                    class="token interpolation"><span
                        class="token punctuation">{literal}{{/literal}</span><span class="token variable">$post</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">id</span><span class="token punctuation">}</span></span>"</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// http://example.com/posts/1</span></code></pre>
<p></p>
<h3 id="accessing-the-current-url"><a href="#accessing-the-current-url">Доступ к текущему URL</a></h3>
<p>Если для <code>url</code> помощника не указан путь, <code>Illuminate\Routing\UrlGenerator</code> возвращается
    экземпляр, позволяющий получить доступ к информации о текущем URL:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">// Get the current URL without the query string...</span>
<span class="token keyword">echo</span> <span class="token function">url</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">current</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// Get the current URL including the query string...</span>
<span class="token keyword">echo</span> <span class="token function">url</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">full</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// Get the full URL for the previous request...</span>
<span class="token keyword">echo</span> <span class="token function">url</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">previous</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>К каждому из этих методов можно также получить доступ через <code>URL</code> <a href="facades">фасад</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>URL</span><span
                class="token punctuation">;</span>

<span class="token keyword">echo</span> <span class="token constant">URL</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">current</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="urls-for-named-routes"><a href="#urls-for-named-routes">URL-адреса для именованных маршрутов</a></h2>
<p><code>route</code> Помощник может быть использован для создания URL - адресов для <a href="routing#named-routes">именованных
        маршрутов</a>. Именованные маршруты позволяют создавать URL-адреса без привязки к фактическому URL-адресу,
    определенному в маршруте. Следовательно, если URL-адрес маршрута изменится, никаких изменений в ваши вызовы <code>route</code>
    функции вносить не нужно. Например, представьте, что ваше приложение содержит маршрут, определенный следующим
    образом:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'/post/{literal}{post}{/literal}'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">name</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'post.show'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Чтобы сгенерировать URL-адрес этого маршрута, вы можете использовать <code>route</code> помощник следующим образом:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">echo</span> <span
                class="token function">route</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'post.show'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'post'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">1</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// http://example.com/post/1</span></code></pre>
<p>Конечно, <code>route</code> помощник также может использоваться для генерации URL-адресов для маршрутов с несколькими
    параметрами:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'/post/{literal}{post}{/literal}/comment/{literal}{comment}{/literal}'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">name</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'comment.show'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">echo</span> <span class="token function">route</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'comment.show'</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span><span class="token single-quoted-string string">'post'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'comment'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">3</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// http://example.com/post/1/comment/3</span></code></pre>
<p>Любые дополнительные элементы массива, не соответствующие параметрам определения маршрута, будут добавлены в строку
    запроса URL:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">echo</span> <span
                class="token function">route</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'post.show'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'post'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">1</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'search'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'rocket'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// http://example.com/post/1?search=rocket</span></code></pre>
<p></p>
<h4 id="eloquent-models"><a href="#eloquent-models">Красноречивые модели</a></h4>
<p>Вы часто будете генерировать URL-адреса, используя первичный ключ <a href="eloquent">моделей Eloquent</a>. По этой
    причине вы можете передавать модели Eloquent в качестве значений параметров. <code>route</code> Помощник будет
    автоматически извлечь первичный ключ модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">echo</span> <span
                class="token function">route</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'post.show'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'post'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$post</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="signed-urls"><a href="#signed-urls">Подписанные URL</a></h3>
<p>Laravel позволяет вам легко создавать «подписанные» URL-адреса для именованных маршрутов. Эти URL-адреса имеют хэш
    «подписи», добавленный к строке запроса, который позволяет Laravel проверять, что URL-адрес не был изменен с момента
    его создания. Подписанные URL-адреса особенно полезны для маршрутов, которые являются общедоступными, но нуждаются в
    защите от манипуляций с URL-адресами.</p>
<p>Например, вы можете использовать подписанные URL-адреса для реализации общедоступной ссылки «отказаться от подписки»,
    которая отправляется вашим клиентам по электронной почте. Чтобы создать подписанный URL-адрес для именованного
    маршрута, используйте <code>signedRoute</code> метод <code>URL</code> фасада:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>URL</span><span
                class="token punctuation">;</span>

<span class="token keyword">return</span> <span class="token constant">URL</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">signedRoute</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'unsubscribe'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'user'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">1</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Если вы хотите сгенерировать временный подписанный URL-адрес маршрута, срок действия которого истекает через
    определенное время, вы можете использовать этот <code>temporarySignedRoute</code> метод. Когда Laravel проверяет
    временный подписанный URL-адрес маршрута, он гарантирует, что метка времени истечения срока, закодированная в
    подписанный URL-адрес, не истекла:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>URL</span><span
                class="token punctuation">;</span>

<span class="token keyword">return</span> <span class="token constant">URL</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">temporarySignedRoute</span><span
                class="token punctuation">(</span>
    <span class="token single-quoted-string string">'unsubscribe'</span><span class="token punctuation">,</span> <span
                class="token function">now</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">addMinutes</span><span
                class="token punctuation">(</span><span class="token number">30</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span><span class="token single-quoted-string string">'user'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">1</span><span class="token punctuation">]</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="validating-signed-route-requests"><a href="#validating-signed-route-requests">Проверка подписанных запросов
        маршрута</a></h4>
<p>Чтобы убедиться, что входящий запрос имеет действительную подпись, вы должны вызвать <code>hasValidSignature</code>
    метод для входящего <code>Request</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/unsubscribe/{literal}{user}{/literal}'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>Request <span class="token variable">$request</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token operator">!</span> <span class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">hasValidSignature</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token function">abort</span><span class="token punctuation">(</span><span class="token number">401</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>

    <span class="token comment">//...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">name</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'unsubscribe'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>В качестве альтернативы вы можете назначить <code>Illuminate\Routing\Middleware\ValidateSignature</code> <a
            href="middleware">промежуточное ПО</a> для маршрута. Если его еще нет, вы должны назначить этому
    промежуточному программному обеспечению ключ в <code>routeMiddleware</code> массиве вашего ядра HTTP:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * The application's route middleware.
 *
 * These middleware may be assigned to groups or used individually.
 *
 * @var array
 */</span>
<span class="token keyword">protected</span> <span class="token variable">$routeMiddleware</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'signed'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> \<span class="token package">Illuminate<span
                    class="token punctuation">\</span>Routing<span class="token punctuation">\</span>Middleware<span
                    class="token punctuation">\</span>ValidateSignature</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">;</span></code></pre>
<p>После того, как вы зарегистрировали промежуточное ПО в своем ядре, вы можете присоединить его к маршруту. Если
    входящий запрос не имеет действительной подписи, промежуточное ПО автоматически вернет <code>403</code> HTTP-ответ:
</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">post</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'/unsubscribe/{literal}{user}{/literal}'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>Request <span class="token variable">$request</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">name</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'unsubscribe'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">middleware</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'signed'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="urls-for-controller-actions"><a href="#urls-for-controller-actions">URL-адреса для действий контроллера</a></h2>
<p><code>action</code> Функция генерирует URL - адрес для данного контроллера действий:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>HomeController</span><span
                class="token punctuation">;</span>

<span class="token variable">$url</span> <span class="token operator">=</span> <span
                class="token function">action</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span>HomeController<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'index'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Если метод контроллера принимает параметры маршрута, вы можете передать ассоциативный массив параметров маршрута в
    качестве второго аргумента функции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$url</span> <span
                class="token operator">=</span> <span class="token function">action</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>UserController<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'profile'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span><span class="token single-quoted-string string">'id'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">1</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="default-values"><a href="#default-values">Значения по умолчанию</a></h2>
<p>Для некоторых приложений вы можете указать значения по умолчанию для определенных параметров URL-адреса. Например,
    представьте, что многие из ваших маршрутов определяют <code>{literal}{locale}{/literal}</code> параметр:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'/{literal}{locale}{/literal}/posts'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">name</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'post.index'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Громоздко всегда передавать <code>locale</code> каждый раз, когда вы вызываете <code>route</code> помощника. Таким
    образом, вы можете использовать этот <code>URL::defaults</code> метод для определения значения по умолчанию для
    этого параметра, которое всегда будет применяться во время текущего запроса. Вы можете вызвать этот метод из <a
            href="middleware#assigning-middleware-to-routes">промежуточного программного обеспечения маршрута,</a> чтобы
    иметь доступ к текущему запросу:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Middleware</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Closure</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span class="token punctuation">\</span>URL</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">SetDefaultLocaleForUrls</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Handle the incoming request.
    *
    * @param  \Illuminate\Http\Request  $request
    * @param  \Closure  $next
    * @return \Illuminate\Http\Response
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">handle</span><span class="token punctuation">(</span><span class="token variable">$request</span><span class="token punctuation">,</span> Closure <span class="token variable">$next</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token constant">URL</span><span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">defaults</span><span class="token punctuation">(</span><span class="token punctuation">[</span><span class="token single-quoted-string string">'locale'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">user</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">locale</span><span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token keyword">return</span> <span class="token variable">$next</span><span class="token punctuation">(</span><span class="token variable">$request</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>После установки значения по умолчанию для <code>locale</code> параметра вам больше не требуется передавать его
    значение при генерации URL-адресов с помощью <code>route</code> помощника.</p>
<p></p>
<h4 id="url-defaults-middleware-priority"><a href="#url-defaults-middleware-priority">Параметры URL по умолчанию и
        приоритет промежуточного программного обеспечения</a></h4>
<p>Установка значений URL по умолчанию может мешать Laravel обрабатывать неявные привязки модели. Следовательно, вы
    должны отдавать <a href="middleware#sorting-middleware">приоритет своему промежуточному программному
        обеспечению,</a> которое устанавливает значения URL по умолчанию для выполнения перед собственным <code>SubstituteBindings</code>
    промежуточным программным обеспечением Laravel. Вы можете добиться этого, убедившись, что ваше промежуточное
    программное обеспечение находится перед <code>SubstituteBindings</code> промежуточным программным обеспечением в
    <code>$middlewarePriority</code> свойстве ядра HTTP вашего приложения.</p>
<p><code>$middlewarePriority</code> Свойство определено в базовом <code>Illuminate\Foundation\Http\Kernel</code> классе.
    Вы можете скопировать его определение из этого класса и перезаписать его в ядре HTTP вашего приложения, чтобы
    изменить его:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * The priority-sorted list of middleware.
 *
 * This forces non-global middleware to always be in the given order.
 *
 * @var array
 */</span>
<span class="token keyword">protected</span> <span class="token variable">$middlewarePriority</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span>
    <span class="token comment">//...</span>
    \<span class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Middleware<span class="token punctuation">\</span>SetDefaultLocaleForUrls</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
    \<span class="token package">Illuminate<span class="token punctuation">\</span>Routing<span
                    class="token punctuation">\</span>Middleware<span class="token punctuation">\</span>SubstituteBindings</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
    <span class="token comment">//...</span>
<span class="token punctuation">]</span><span class="token punctuation">;</span></code></pre> 
