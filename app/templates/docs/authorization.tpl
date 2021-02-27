<h1>Авторизация <sup>Authorization</sup></h1>
<ul>
    <li><a href="authorization#introduction">Вступление</a></li>
    <li><a href="authorization#gates">Ворота</a>
        <ul>
            <li><a href="authorization#writing-gates">Написание Гейтса</a></li>
            <li><a href="authorization#authorizing-actions-via-gates">Авторизация действий</a></li>
            <li><a href="authorization#gate-responses">Ответы шлюза</a></li>
            <li><a href="authorization#intercepting-gate-checks">Перехват проверок ворот</a></li>
        </ul>
    </li>
    <li><a href="authorization#creating-policies">Создание политик</a>
        <ul>
            <li><a href="authorization#generating-policies">Создание политик</a></li>
            <li><a href="authorization#registering-policies">Регистрация политик</a></li>
        </ul>
    </li>
    <li><a href="authorization#writing-policies">Написание политик</a>
        <ul>
            <li><a href="authorization#policy-methods">Политические методы</a></li>
            <li><a href="authorization#policy-responses">Ответы политики</a></li>
            <li><a href="authorization#methods-without-models">Методы без моделей</a></li>
            <li><a href="authorization#guest-users">Гостевые пользователи</a></li>
            <li><a href="authorization#policy-filters">Фильтры политики</a></li>
        </ul>
    </li>
    <li><a href="authorization#authorizing-actions-using-policies">Авторизация действий с использованием политик</a>
        <ul>
            <li><a href="authorization#via-the-user-model">Через модель пользователя</a></li>
            <li><a href="authorization#via-controller-helpers">Через помощников контроллера</a></li>
            <li><a href="authorization#via-middleware">Через промежуточное ПО</a></li>
            <li><a href="authorization#via-blade-templates">Через шаблоны Blade</a></li>
            <li><a href="authorization#supplying-additional-context">Предоставление дополнительного контекста</a></li>
        </ul>
    </li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Помимо предоставления встроенных служб <a href="authentication">аутентификации</a>, Laravel также предоставляет
    простой способ авторизации действий пользователя в отношении заданного ресурса. Например, даже если пользователь
    аутентифицирован, он может быть не авторизован для обновления или удаления определенных моделей Eloquent или записей
    базы данных, управляемых вашим приложением. Функции авторизации Laravel обеспечивают простой и организованный способ
    управления этими типами проверок авторизации.</p>
<p>Laravel предоставляет два основных способа авторизации действий: <a href="authorization#gates">шлюзы</a> и <a
            href="authorization#creating-policies">политики</a>. Подумайте о воротах и ​​политиках, таких как маршруты и
    контроллеры. Gates обеспечивает простой подход к авторизации, основанный на закрытии, в то время как политики, такие
    как контроллеры, группируют логику вокруг конкретной модели или ресурса. В этой документации мы сначала рассмотрим
    шлюзы, а затем рассмотрим политики.</p>
<p>Вам не нужно выбирать между использованием исключительно шлюзов или исключительно политиками при создании приложения.
    Большинство приложений, скорее всего, будут содержать смесь шлюзов и политик, и это нормально! Шлюзы наиболее
    применимы к действиям, не связанным с какой-либо моделью или ресурсом, например к просмотру панели администратора.
    Напротив, политики следует использовать, когда вы хотите разрешить действие для конкретной модели или ресурса.</p>
<p></p>
<h2 id="gates"><a href="#gates">Ворота</a></h2>
<p></p>
<h3 id="writing-gates"><a href="#writing-gates">Написание Гейтса</a></h3>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Gates - отличный способ изучить основы функций авторизации Laravel; однако при создании надежных приложений
            Laravel вам следует рассмотреть возможность использования <a
                    href="authorization#creating-policies">политик</a> для организации ваших правил авторизации.</p></p>
    </div>
</blockquote>
<p>Шлюз - это просто закрытие, которое определяет, имеет ли пользователь право выполнять данное действие. Обычно ворота
    определяются в <code>boot</code> методе <code>App\Providers\AuthServiceProvider</code> класса с использованием
    <code>Gate</code> фасада. Гейтс всегда получает пользовательский экземпляр в качестве своего первого аргумента и
    может дополнительно получать дополнительные аргументы, такие как соответствующая модель Eloquent.</p>
<p>В этом примере мы определим ворота, чтобы определить, может ли пользователь обновить данную
    <code>App\Models\Post</code> модель. Gate выполнит это, сравнивая пользователя <code>id</code> с
    <code>user_id</code> пользователем, создавшим сообщение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Post</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Gate</span><span
                class="token punctuation">;</span>

<span class="token comment">/**
 * Register any authentication / authorization services.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">boot</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">registerPolicies</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    
    Gate<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">define</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'update-post'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>User <span class="token variable">$user</span><span
                class="token punctuation">,</span> Post <span class="token variable">$post</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span> <span class="token operator">===</span> <span class="token variable">$post</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">user_id</span><span
                class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Как и контроллеры, ворота также могут быть определены с использованием массива обратного вызова класса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Policies<span
                    class="token punctuation">\</span>PostPolicy</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Gate</span><span
                class="token punctuation">;</span>

<span class="token comment">/**
 * Register any authentication / authorization services.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">boot</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">registerPolicies</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    
    Gate<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">define</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'update-post'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>PostPolicy<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'update'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="authorizing-actions-via-gates"><a href="#authorizing-actions-via-gates">Авторизация действий</a></h3>
<p>Чтобы авторизовать действие с помощью шлюзов, вы должны использовать методы <code>allows</code> или,
    <code>denies</code> предоставляемые <code>Gate</code> фасадом. Обратите внимание, что вам не требуется передавать в
    эти методы аутентифицированного в данный момент пользователя. Laravel автоматически позаботится о переходе
    пользователя в закрытие ворот. Обычно методы авторизации шлюза вызываются в контроллерах вашего приложения перед
    выполнением действия, требующего авторизации:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>Controller</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span class="token punctuation">\</span>Post</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Gate</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">PostController</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Update the given post.
    *
    * @param  \Illuminate\Http\Request  $request
    * @param  \App\Models\Post  $post
    * @return \Illuminate\Http\Response
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">update</span><span
                    class="token punctuation">(</span>Request <span class="token variable">$request</span><span
                    class="token punctuation">,</span> Post <span class="token variable">$post</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token operator">!</span> Gate<span
                    class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">allows</span><span class="token punctuation">(</span><span
                    class="token single-quoted-string string">'update-post'</span><span
                    class="token punctuation">,</span> <span class="token variable">$post</span><span
                    class="token punctuation">)</span><span class="token punctuation">)</span> <span
                    class="token punctuation">{literal}{{/literal}</span>
            <span class="token function">abort</span><span class="token punctuation">(</span><span
                    class="token number">403</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
        <span class="token punctuation">}</span>

        <span class="token comment">// Update the post...</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Если вы хотите определить, авторизован ли пользователь, отличный от текущего аутентифицированного пользователя, для
    выполнения действия, вы можете использовать <code>forUser</code> метод на <code>Gate</code> фасаде:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">if</span> <span
                class="token punctuation">(</span>Gate<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">forUser</span><span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">allows</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'update-post'</span><span
                class="token punctuation">,</span> <span class="token variable">$post</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// The user can update the post...</span>
<span class="token punctuation">}</span>

<span class="token keyword">if</span> <span class="token punctuation">(</span>Gate<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">forUser</span><span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">denies</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'update-post'</span><span
                class="token punctuation">,</span> <span class="token variable">$post</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// The user can't update the post...</span>
<span class="token punctuation">}</span></code></pre>
<p>Вы можете авторизовать несколько действий одновременно, используя методы <code>any</code> или <code>none</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">if</span> <span
                class="token punctuation">(</span>Gate<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">any</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'update-post'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'delete-post'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span> <span class="token variable">$post</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// The user can update or delete the post...</span>
<span class="token punctuation">}</span>

<span class="token keyword">if</span> <span class="token punctuation">(</span>Gate<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">none</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'update-post'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'delete-post'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span> <span class="token variable">$post</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// The user can't update or delete the post...</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="authorizing-or-throwing-exceptions"><a href="#authorizing-or-throwing-exceptions">Авторизация или выдача
        исключений</a></h4>
<p>Если вы хотите попытаться авторизовать действие и автоматически выдать сообщение, <code>Illuminate\Auth\Access\AuthorizationException</code>
    если пользователю не разрешено выполнять данное действие, вы можете использовать метод <code>Gate</code> фасада
    <code>authorize</code>. Экземпляры <code>AuthorizationException</code> автоматически преобразуются в ответ 403 HTTP
    обработчиком исключений Laravel:</p>
<pre class=" language-php"><code class=" language-php">Gate<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">authorize</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'update-post'</span><span
                class="token punctuation">,</span> <span class="token variable">$post</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// The action is authorized...</span></code></pre>
<p></p>
<h4 id="gates-supplying-additional-context"><a href="#gates-supplying-additional-context">Предоставление дополнительного
        контекста</a></h4>
<p>Методы затворов для санкционирования способностей ( <code>allows</code>, <code>denies</code>, <code>check</code>,
    <code>any</code>, <code>none</code>, <code>authorize</code>, <code>can</code>, <code>cannot</code> ) и авторизация
    <a href="authorization#via-blade-templates">директиву Блейда</a> ( <code>@can</code>, <code>@cannot</code>, <code>@canany</code>
    ) могут принимать массив в качестве второго аргумента. Эти элементы массива передаются в качестве параметров для
    закрытия ворот и могут использоваться для дополнительного контекста при принятии решений об авторизации:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Category</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Gate</span><span
                class="token punctuation">;</span>

Gate<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">define</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'create-post'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>User <span class="token variable">$user</span><span
                class="token punctuation">,</span> Category <span class="token variable">$category</span><span
                class="token punctuation">,</span> <span class="token variable">$pinned</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">if</span> <span class="token punctuation">(</span><span
                class="token operator">!</span> <span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">canPublishToGroup</span><span
                class="token punctuation">(</span><span class="token variable">$category</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">group</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token boolean constant">false</span><span
                class="token punctuation">;</span>
    <span class="token punctuation">}</span> <span class="token keyword">elseif</span> <span
                class="token punctuation">(</span><span class="token variable">$pinned</span> <span
                class="token operator">&amp;&amp;</span> <span class="token operator">!</span> <span
                class="token variable">$user</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">canPinPosts</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token boolean constant">false</span><span
                class="token punctuation">;</span>
    <span class="token punctuation">}</span>
            
    <span class="token keyword">return</span> <span class="token boolean constant">true</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token keyword">if</span> <span class="token punctuation">(</span>Gate<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">check</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'create-post'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span class="token variable">$category</span><span
                class="token punctuation">,</span> <span class="token variable">$pinned</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// The user can create the post...</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="gate-responses"><a href="#gate-responses">Ответы шлюза</a></h3>
<p>До сих пор мы исследовали только элементы, возвращающие простые логические значения. Однако иногда вы можете захотеть
    вернуть более подробный ответ, включая сообщение об ошибке. Для этого вы можете вернуть <code>Illuminate\Auth\Access\Response</code>
    из своих ворот:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Auth<span
                    class="token punctuation">\</span>Access<span class="token punctuation">\</span>Response</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Gate</span><span
                class="token punctuation">;</span>

Gate<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">define</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'edit-settings'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span>User <span
                class="token variable">$user</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">isAdmin</span>
    <span class="token operator">?</span> Response<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">allow</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">:</span> Response<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">deny</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'You must be an administrator.'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Даже если вы вернете ответ авторизации от своего шлюза, <code>Gate::allows</code> метод все равно вернет простое
    логическое значение; однако вы можете использовать этот <code>Gate::inspect</code> метод, чтобы получить полный
    ответ авторизации, возвращаемый шлюзом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span> <span
                class="token operator">=</span> Gate<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">inspect</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'edit-settings'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">if</span> <span class="token punctuation">(</span><span
                class="token variable">$response</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">allowed</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// The action is authorized...</span>
<span class="token punctuation">}</span> <span class="token keyword">else</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">echo</span> <span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">message</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>При использовании <code>Gate::authorize</code> метода, который выдает, <code>AuthorizationException</code> если
    действие не авторизовано, сообщение об ошибке, предоставленное ответом авторизации, будет передано в ответ HTTP:</p>
<pre class=" language-php"><code class=" language-php">Gate<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">authorize</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'edit-settings'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// The action is authorized...</span></code></pre>
<p></p>
<h3 id="intercepting-gate-checks"><a href="#intercepting-gate-checks">Перехват проверок ворот</a></h3>
<p>Иногда вы можете захотеть предоставить все возможности конкретному пользователю. Вы можете использовать этот <code>before</code>
    метод для определения закрытия, которое запускается перед всеми другими проверками авторизации:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Gate</span><span
                class="token punctuation">;</span>

Gate<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">before</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">,</span> <span class="token variable">$ability</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">isAdministrator</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token boolean constant">true</span><span
                class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Если <code>before</code> закрытие возвращает ненулевой результат, этот результат будет считаться результатом проверки
    авторизации.</p>
<p>Вы можете использовать этот <code>after</code> метод для определения закрытия, которое будет выполняться после всех
    других проверок авторизации:</p>
<pre class=" language-php"><code class=" language-php">Gate<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">after</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">,</span> <span class="token variable">$ability</span><span
                class="token punctuation">,</span> <span class="token variable">$result</span><span
                class="token punctuation">,</span> <span class="token variable">$arguments</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">isAdministrator</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token boolean constant">true</span><span
                class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Подобно <code>before</code> методу, если <code>after</code> замыкание возвращает ненулевой результат, этот результат
    будет считаться результатом проверки авторизации.</p>
<p></p>
<h2 id="creating-policies"><a href="#creating-policies">Создание политик</a></h2>
<p></p>
<h3 id="generating-policies"><a href="#generating-policies">Создание политик</a></h3>
<p>Политики - это классы, которые организуют логику авторизации для конкретной модели или ресурса. Например, если ваше
    приложение представляет собой блог, у вас может быть <code>App\Models\Post</code> модель и соответствующий объект
    <code>App\Policies\PostPolicy</code> для авторизации действий пользователя, таких как создание или обновление
    сообщений.</p>
<p>Вы можете создать политику с помощью <code>make:policy</code> Artisan-команды. Сгенерированная политика будет
    помещена в <code>app/Policies</code> каталог. Если этот каталог не существует в вашем приложении, Laravel создаст
    его для вас:</p>
<pre class=" language-php"><code class=" language-php">php artisan make<span class="token punctuation">:</span>policy PostPolicy</code></pre>
<p>Команда <code>make:policy</code> сгенерирует пустой класс политики. Если вы хотите создать класс с примерами методов
    политики, связанных с просмотром, созданием, обновлением и удалением ресурса, вы можете указать <code>--model</code>
    параметр при выполнении команды:</p>
<pre class=" language-php"><code class=" language-php">php artisan make<span class="token punctuation">:</span>policy PostPolicy <span
                class="token operator">--</span>model<span class="token operator">=</span>Post</code></pre>
<p></p>
<h3 id="registering-policies"><a href="#registering-policies">Регистрация политик</a></h3>
<p>После создания класса политики его необходимо зарегистрировать. Регистрация политик - это то, как мы можем сообщить
    Laravel, какую политику использовать при авторизации действий для данного типа модели.</p>
<p><code>App\Providers\AuthServiceProvider</code> В комплекте с новыми приложениями Laravel содержит
    <code>policies</code> свойство, которое отображает ваши модели красноречив в их соответствующих политике.
    Регистрация политики проинструктирует Laravel, какую политику использовать при авторизации действий для данной
    модели Eloquent:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Providers</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span class="token punctuation">\</span>Post</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Policies<span
                        class="token punctuation">\</span>PostPolicy</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Support<span class="token punctuation">\</span>Providers<span
                        class="token punctuation">\</span>AuthServiceProvider</span> <span
                    class="token keyword">as</span> ServiceProvider<span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Gate</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">AuthServiceProvider</span> <span
                    class="token keyword">extends</span> <span class="token class-name">ServiceProvider</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * The policy mappings for the application.
    *
    * @var array
    */</span>
    <span class="token keyword">protected</span> <span class="token variable">$policies</span> <span
                    class="token operator">=</span> <span class="token punctuation">[</span>
        Post<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span> <span
                    class="token operator">=</span><span class="token operator">&gt;</span> PostPolicy<span
                    class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token keyword">class</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">;</span>

    <span class="token comment">/**
    * Register any application authentication / authorization services.
    *
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">boot</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">registerPolicies</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>

        <span class="token comment">//</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h4 id="policy-auto-discovery"><a href="#policy-auto-discovery">Автоматическое обнаружение политики</a></h4>
<p>Вместо того, чтобы вручную регистрировать политики модели, Laravel может автоматически обнаруживать политики, если
    модель и политика соответствуют стандартным соглашениям об именах Laravel. В частности, политики должны находиться в
    <code>Policies</code> каталоге в каталоге, в котором находятся ваши модели, или выше него. Так, например, модели
    могут быть помещены в <code>app/Models</code> каталог, а политики могут быть размещены в <code>app/Policies</code>
    каталоге. В этой ситуации, Laravel будет проверять политику в <code>app/Models/Policies</code> то
    <code>app/Policies</code>. Кроме того, имя политики должно совпадать с названием модели и иметь <code>Policy</code>
    суффикс. Итак, <code>User</code> модель будет соответствовать <code>UserPolicy</code> классу политики.</p>
<p>Если вы хотите определить свою собственную логику обнаружения политики, вы можете зарегистрировать обратный вызов для
    обнаружения настраиваемой политики с помощью этого <code>Gate::guessPolicyNamesUsing</code> метода. Обычно этот
    метод следует вызывать из <code>boot</code> метода вашего приложения <code>AuthServiceProvider</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Gate</span><span
                class="token punctuation">;</span>

Gate<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">guessPolicyNamesUsing</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$modelClass</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// Return the name of the policy class for the given model...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Любые политики, которые явно указаны в вашем файле, <code>AuthServiceProvider</code> будут иметь приоритет
            над любыми потенциально автоматически обнаруженными политиками.</p></p></div>
</blockquote>
<p></p>
<h2 id="writing-policies"><a href="#writing-policies">Написание политик</a></h2>
<p></p>
<h3 id="policy-methods"><a href="#policy-methods">Политические методы</a></h3>
<p>После регистрации класса политики вы можете добавлять методы для каждого действия, которое он разрешает. Например,
    давайте определим <code>update</code> на нашем методе, <code>PostPolicy</code> который определяет, может ли данный
    <code>App\Models\User</code> объект обновлять данный <code>App\Models\Post</code> экземпляр.</p>
<p><code>update</code> Метод получит <code>User</code> и в <code>Post</code> экземпляре в качестве аргументов, и он
    должен возвращать <code>true</code> или <code>false</code> указание авторизовано ли пользователь обновить данными
    <code>Post</code>. Таким образом, в этом примере, мы проверим, что пользователя <code>id</code> совпадает с <code>user_id</code>
    на сообщение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Policies</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span class="token punctuation">\</span>Post</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">PostPolicy</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Determine if the given post can be updated by the user.
    *
    * @param  \App\Models\User  $user
    * @param  \App\Models\Post  $post
    * @return bool
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">update</span><span
                    class="token punctuation">(</span>User <span class="token variable">$user</span><span
                    class="token punctuation">,</span> Post <span class="token variable">$post</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$user</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">id</span> <span
                    class="token operator">===</span> <span class="token variable">$post</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">user_id</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Вы можете продолжить определение дополнительных методов в политике по мере необходимости для различных действий,
    которые она разрешает. Например, вы можете определить методы <code>view</code> или <code>delete</code> для
    авторизации различных <code>Post</code> связанных действий, но помните, что вы можете давать своим методам политики
    любое имя, какое захотите.</p>
<p>Если вы использовали <code>--model</code> параметр при создании вашей политики с помощью консоли Artisan, он уже
    будет содержать методы для <code>viewAny</code>, <code>view</code>, <code>create</code>, <code>update</code>, <code>delete</code>,
    <code>restore</code>, и <code>forceDelete</code> действия.</p>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Все политики разрешаются через <a href="container">сервисный контейнер</a> Laravel, что позволяет вам
            указывать любые необходимые зависимости в конструкторе политики для их автоматического внедрения.</p></p>
    </div>
</blockquote>
<p></p>
<h3 id="policy-responses"><a href="#policy-responses">Ответы политики</a></h3>
<p>До сих пор мы исследовали только методы политики, возвращающие простые логические значения. Однако иногда вы можете
    захотеть вернуть более подробный ответ, включая сообщение об ошибке. Для этого вы можете вернуть <code>Illuminate\Auth\Access\Response</code>
    экземпляр из своего метода политики:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Post</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Auth<span
                    class="token punctuation">\</span>Access<span class="token punctuation">\</span>Response</span><span
                class="token punctuation">;</span>

<span class="token comment">/**
 * Determine if the given post can be updated by the user.
 *
 * @param  \App\Models\User  $user
 * @param  \App\Models\Post  $post
 * @return \Illuminate\Auth\Access\Response
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">update</span><span
                class="token punctuation">(</span>User <span class="token variable">$user</span><span
                class="token punctuation">,</span> Post <span class="token variable">$post</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span> <span class="token operator">===</span> <span class="token variable">$post</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">user_id</span>
    <span class="token operator">?</span> Response<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">allow</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">:</span> Response<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">deny</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'You do not own this post.'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>При возврате ответа авторизации из вашей политики <code>Gate::allows</code> метод по-прежнему будет возвращать
    простое логическое значение; однако вы можете использовать этот <code>Gate::inspect</code> метод, чтобы получить
    полный ответ авторизации, возвращаемый шлюзом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Gate</span><span
                class="token punctuation">;</span>

<span class="token variable">$response</span> <span class="token operator">=</span> Gate<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">inspect</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'update'</span><span
                class="token punctuation">,</span> <span class="token variable">$post</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">if</span> <span class="token punctuation">(</span><span
                class="token variable">$response</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">allowed</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// The action is authorized...</span>
<span class="token punctuation">}</span> <span class="token keyword">else</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">echo</span> <span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">message</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>При использовании <code>Gate::authorize</code> метода, который выдает, <code>AuthorizationException</code> если
    действие не авторизовано, сообщение об ошибке, предоставленное ответом авторизации, будет передано в ответ HTTP:</p>
<pre class=" language-php"><code class=" language-php">Gate<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">authorize</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'update'</span><span
                class="token punctuation">,</span> <span class="token variable">$post</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// The action is authorized...</span></code></pre>
<p></p>
<h3 id="methods-without-models"><a href="#methods-without-models">Методы без моделей</a></h3>
<p>Некоторые методы политики получают только экземпляр аутентифицированного в данный момент пользователя. Эта ситуация
    чаще всего встречается при авторизации <code>create</code> действий. Например, если вы создаете блог, вы можете
    определить, имеет ли пользователь право вообще создавать какие-либо сообщения. В этих ситуациях ваш метод политики
    должен рассчитывать только на получение экземпляра пользователя:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Determine if the given user can create posts.
 *
 * @param  \App\Models\User  $user
 * @return bool
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">create</span><span
                class="token punctuation">(</span>User <span class="token variable">$user</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">role</span> <span class="token operator">==</span> <span
                class="token single-quoted-string string">'writer'</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="guest-users"><a href="#guest-users">Гостевые пользователи</a></h3>
<p>По умолчанию все шлюзы и политики автоматически возвращаются, <code>false</code> если входящий HTTP-запрос не был
    инициирован аутентифицированным пользователем. Однако вы можете разрешить прохождение этих проверок авторизации к
    вашим шлюзам и политикам, объявив «необязательный» тип-подсказку или предоставив <code>null</code> значение по
    умолчанию для определения аргумента пользователя:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Policies</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span class="token punctuation">\</span>Post</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">PostPolicy</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Determine if the given post can be updated by the user.
    *
    * @param  \App\Models\User  $user
    * @param  \App\Models\Post  $post
    * @return bool
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">update</span><span
                    class="token punctuation">(</span><span class="token operator">?</span>User <span
                    class="token variable">$user</span><span class="token punctuation">,</span> Post <span
                    class="token variable">$post</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token function">optional</span><span
                    class="token punctuation">(</span><span class="token variable">$user</span><span
                    class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token property">id</span> <span class="token operator">===</span> <span
                    class="token variable">$post</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token property">user_id</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h3 id="policy-filters"><a href="#policy-filters">Фильтры политики</a></h3>
<p>Для определенных пользователей вы можете разрешить все действия в рамках данной политики. Для этого определите <code>before</code>
    метод в политике. Этот <code>before</code> метод будет выполнен перед любыми другими методами в политике, что даст
    вам возможность авторизовать действие до того, как намеченный метод политики будет фактически вызван. Эта функция
    чаще всего используется для авторизации администраторов приложений на выполнение любых действий:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

<span class="token comment">/**
 * Perform pre-authorization checks.
 *
 * @param  \App\Models\User  $user
 * @param  string  $ability
 * @return void|bool
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">before</span><span
                class="token punctuation">(</span>User <span class="token variable">$user</span><span
                class="token punctuation">,</span> <span class="token variable">$ability</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">if</span> <span class="token punctuation">(</span><span
                class="token variable">$user</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">isAdministrator</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token boolean constant">true</span><span
                class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></code></pre>
<p>Если вы хотите отклонить все проверки авторизации для определенного типа пользователя, вы можете вернуться <code>false</code>
    из <code>before</code> метода. Если <code>null</code> возвращается, проверка авторизации будет выполняться методом
    политики.</p>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p><code>before</code> Метод класса политики не будет вызываться, если класс не содержит метод с именем,
            совпадающим с именем способности проверяемым.</p></p></div>
</blockquote>
<p></p>
<h2 id="authorizing-actions-using-policies"><a href="#authorizing-actions-using-policies">Авторизация действий с
        использованием политик</a></h2>
<p></p>
<h3 id="via-the-user-model"><a href="#via-the-user-model">Через модель пользователя</a></h3>
<p><code>App\Models\User</code> Модель, которая поставляется вместе с приложением Laravel включает в себя две полезные
    методы для санкционирования действий: <code>can</code> а <code>cannot</code>. <code>can</code> И <code>cannot</code>
    методы получают название действия, которое вы хотите разрешить и соответствующей модели. Например, давайте
    определим, имеет ли пользователь право обновлять данную <code>App\Models\Post</code> модель. Обычно это делается с
    помощью метода контроллера:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>Controller</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span class="token punctuation">\</span>Post</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">PostController</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Update the given post.
    *
    * @param  \Illuminate\Http\Request  $request
    * @param  \App\Models\Post  $post
    * @return \Illuminate\Http\Response
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">update</span><span
                    class="token punctuation">(</span>Request <span class="token variable">$request</span><span
                    class="token punctuation">,</span> Post <span class="token variable">$post</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">if</span> <span class="token punctuation">(</span><span
                    class="token variable">$request</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">user</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">cannot</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'update'</span><span
                    class="token punctuation">,</span> <span class="token variable">$post</span><span
                    class="token punctuation">)</span><span class="token punctuation">)</span> <span
                    class="token punctuation">{literal}{{/literal}</span>
            <span class="token function">abort</span><span class="token punctuation">(</span><span
                    class="token number">403</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
        <span class="token punctuation">}</span>

        <span class="token comment">// Update the post...</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Если для данной модели <a href="authorization#registering-policies">зарегистрирована политика</a>, <code>can</code>
    метод автоматически вызовет соответствующую политику и вернет логический результат. Если для модели не
    зарегистрировано никакой политики, <code>can</code> метод попытается вызвать шлюз на основе закрытия,
    соответствующий заданному имени действия.</p>
<p></p>
<h4 id="user-model-actions-that-dont-require-models"><a href="#user-model-actions-that-dont-require-models">Действия, не
        требующие моделей</a></h4>
<p>Помните, что некоторые действия могут соответствовать методам политики, <code>create</code> которым не требуется
    экземпляр модели. В этих ситуациях вы можете передать <code>can</code> методу имя класса. Имя класса будет
    использоваться для определения того, какую политику использовать при авторизации действия:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>Controller</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span class="token punctuation">\</span>Post</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">PostController</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Create a post.
    *
    * @param  \Illuminate\Http\Request  $request
    * @return \Illuminate\Http\Response
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">store</span><span
                    class="token punctuation">(</span>Request <span class="token variable">$request</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">if</span> <span class="token punctuation">(</span><span
                    class="token variable">$request</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">user</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">cannot</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'create'</span><span class="token punctuation">,</span> Post<span
                    class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token keyword">class</span><span class="token punctuation">)</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token function">abort</span><span class="token punctuation">(</span><span
                    class="token number">403</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
        <span class="token punctuation">}</span>

        <span class="token comment">// Create the post...</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h3 id="via-controller-helpers"><a href="#via-controller-helpers">Через помощников контроллера</a></h3>
<p>В дополнение к полезным методам, предоставленным <code>App\Models\User</code> модели, Laravel предоставляет полезный
    <code>authorize</code> метод для любого из ваших контроллеров, который расширяет <code>App\Http\Controllers\Controller</code>
    базовый класс.</p>
<p>Как и <code>can</code> метод, этот метод принимает имя действия, которое вы хотите разрешить, и соответствующую
    модель. Если действие не авторизовано, <code>authorize</code> метод вызовет <code>Illuminate\Auth\Access\AuthorizationException</code>
    исключение, которое обработчик исключений Laravel автоматически преобразует в HTTP-ответ с кодом состояния 403:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>Controller</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span class="token punctuation">\</span>Post</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">PostController</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Update the given blog post.
    *
    * @param  \Illuminate\Http\Request  $request
    * @param  \App\Models\Post  $post
    * @return \Illuminate\Http\Response
    *
    * @throws \Illuminate\Auth\Access\AuthorizationException
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">update</span><span
                    class="token punctuation">(</span>Request <span class="token variable">$request</span><span
                    class="token punctuation">,</span> Post <span class="token variable">$post</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">authorize</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'update'</span><span
                    class="token punctuation">,</span> <span class="token variable">$post</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token comment">// The current user can update the blog post...</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h4 id="controller-actions-that-dont-require-models"><a href="#controller-actions-that-dont-require-models">Действия, не
        требующие моделей</a></h4>
<p>Как обсуждалось ранее, некоторые методы политики, например <code>create</code>, не требуют экземпляра модели. В таких
    ситуациях вы должны передать <code>authorize</code> методу имя класса. Имя класса будет использоваться для
    определения того, какую политику использовать при авторизации действия:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Post</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>

<span class="token comment">/**
 * Create a new blog post.
 *
 * @param  \Illuminate\Http\Request  $request
 * @return \Illuminate\Http\Response
 *
 * @throws \Illuminate\Auth\Access\AuthorizationException
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">create</span><span
                class="token punctuation">(</span>Request <span class="token variable">$request</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">authorize</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'create'</span><span
                class="token punctuation">,</span> Post<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
    
    <span class="token comment">// The current user can create blog posts...</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="authorizing-resource-controllers"><a href="#authorizing-resource-controllers">Авторизация контроллеров
        ресурсов</a></h4>
<p>Если вы используете <a href="controllers#resource-controllers">контроллеры ресурсов</a>, вы можете использовать
    <code>authorizeResource</code> метод в конструкторе вашего контроллера. Этот метод присоединит соответствующие
    <code>can</code> определения промежуточного программного обеспечения к методам контроллера ресурсов.</p>
<p><code>authorizeResource</code> Метод принимает имя класса модели в качестве первого аргумента, и имени параметра
    маршрута / запроса, который будет содержать идентификатор модели в качестве второго аргумента. Вы должны убедиться,
    что ваш <a href="controllers#resource-controllers">контроллер ресурсов</a> создан с использованием
    <code>--model</code> флага, чтобы он имел необходимые сигнатуры методов и подсказки типов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>Controller</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span class="token punctuation">\</span>Post</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">PostController</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Create the controller instance.
    *
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">__construct</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">authorizeResource</span><span
                    class="token punctuation">(</span>Post<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">,</span> <span
                    class="token single-quoted-string string">'post'</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Следующие методы контроллера будут сопоставлены с их соответствующим методом политики. Когда запросы направляются к
    данному методу контроллера, соответствующий метод политики будет автоматически вызываться перед выполнением метода
    контроллера:</p>
<table>
    <thead>
    <tr>
        <th>Метод контроллера</th>
        <th>Метод политики</th>
    </tr>
    </thead>
    <tbody>

    <tr>
        <td>index</td>
        <td>viewAny</td>
    </tr>
    <tr>
        <td>show</td>
        <td>view</td>
    </tr>
    <tr>
        <td>create</td>
        <td>create</td>
    </tr>
    <tr>
        <td>store</td>
        <td>create</td>
    </tr>
    <tr>
        <td>edit</td>
        <td>update</td>
    </tr>
    <tr>
        <td>update</td>
        <td>update</td>
    </tr>
    <tr>
        <td>destroy</td>
        <td>delete</td>
    </tr>
    </tbody>
</table>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Вы можете использовать <code>make:policy</code> команду с <code>--model</code> возможностью быстро создать
            класс политики для данной модели: <code>php artisan make:policy PostPolicy --model=Post</code>.</p></p>
    </div>
</blockquote>
<p></p>
<h3 id="via-middleware"><a href="#via-middleware">Через промежуточное ПО</a></h3>
<p>Laravel включает промежуточное ПО, которое может авторизовать действия до того, как входящий запрос достигнет ваших
    маршрутов или контроллеров. По умолчанию <code>Illuminate\Auth\Middleware\Authorize</code> промежуточному
    программному обеспечению назначается <code>can</code> ключ в вашем <code>App\Http\Kernel</code> классе. Давайте
    рассмотрим пример использования <code>can</code> промежуточного программного обеспечения для авторизации того, что
    пользователь может обновлять сообщение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Post</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">put</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/post/{literal}{post}{/literal}'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span>Post <span
                class="token variable">$post</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// The current user may update the post...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">middleware</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'can:update,post'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>В этом примере мы передаем <code>can</code> промежуточному программному обеспечению два аргумента. Первый - это имя
    действия, которое мы хотим авторизовать, а второй - параметр маршрута, который мы хотим передать методу политики. В
    этом случае, поскольку мы используем <a href="routing#implicit-binding">неявную привязку модели</a>, <code>App\Models\Post</code>
    модель будет передана методу политики. Если пользователь не авторизован для выполнения данного действия,
    промежуточное ПО вернет ответ HTTP с кодом состояния 403.</p>
<p></p>
<h4 id="middleware-actions-that-dont-require-models"><a href="#middleware-actions-that-dont-require-models">Действия, не
        требующие моделей</a></h4>
<p>Опять же, некоторые методы политики, например <code>create</code>, не требуют экземпляра модели. В этих ситуациях вы
    можете передать имя класса промежуточному программному обеспечению. Имя класса будет использоваться для определения
    того, какую политику использовать при авторизации действия:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">post</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/post'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// The current user may create posts...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">middleware</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'can:create,App\Models\Post'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="via-blade-templates"><a href="#via-blade-templates">Через шаблоны Blade</a></h3>
<p>При написании шаблонов Blade вы можете захотеть отобразить часть страницы только в том случае, если пользователь
    авторизован для выполнения данного действия. Например, вы можете захотеть показать форму обновления для сообщения в
    блоге, только если пользователь действительно может обновить сообщение. В этой ситуации, вы можете использовать
    <code>@can</code> и <code>@cannot</code> директивы:</p>
<pre class=" language-html"><code class=" language-html">@can('update', $post)
    <span class="token comment">&lt;!-- The current user can update the post... --&gt;</span>
@elsecan('create', App\Models\Post::class)
    <span class="token comment">&lt;!-- The current user can create new posts... --&gt;</span>
@endcan

@cannot('update', $post)
    <span class="token comment">&lt;!-- The current user cannot update the post... --&gt;</span>
@elsecannot('create', App\Models\Post::class)
    <span class="token comment">&lt;!-- The current user can now create new posts... --&gt;</span>
@endcannot</code></pre>
<p>Эти директивы - удобные ярлыки для написания <code>@if</code> и <code>@unless</code> утверждений. В <code>@can</code>
    и <code>@cannot</code> выше утверждения эквивалентны следующие утверждения:</p>
<pre class=" language-html"><code class=" language-html">@if (Auth::user()-&gt;can('update', $post))
    <span class="token comment">&lt;!-- The current user can update the post... --&gt;</span>
@endif

@unless (Auth::user()-&gt;can('update', $post))
    <span class="token comment">&lt;!-- The current user cannot update the post... --&gt;</span>
@endunless</code></pre>
<p>Вы также можете определить, авторизован ли пользователь для выполнения какого-либо действия из заданного массива
    действий. Для этого используйте <code>@canany</code> директиву:</p>
<pre class=" language-html"><code class=" language-html">@canany(['update', 'view', 'delete'], $post)
    <span class="token comment">&lt;!-- The current user can update, view, or delete the post... --&gt;</span>
@elsecanany(['create'], \App\Models\Post::class)
    <span class="token comment">&lt;!-- The current user can create a post... --&gt;</span>
@endcanany</code></pre>
<p></p>
<h4 id="blade-actions-that-dont-require-models"><a href="#blade-actions-that-dont-require-models">Действия, не требующие
        моделей</a></h4>
<p>Как и большинство других методов авторизации, вы можете передать имя класса к <code>@can</code> и
    <code>@cannot</code> директивам, если действие не требует экземпляра модели:</p>
<pre class=" language-html"><code class=" language-html">@can('create', App\Models\Post::class)
    <span class="token comment">&lt;!-- The current user can create posts... --&gt;</span>
@endcan

@cannot('create', App\Models\Post::class)
    <span class="token comment">&lt;!-- The current user can't create posts... --&gt;</span>
@endcannot</code></pre>
<p></p>
<h3 id="supplying-additional-context"><a href="#supplying-additional-context">Предоставление дополнительного
        контекста</a></h3>
<p>При авторизации действий с использованием политик вы можете передать массив в качестве второго аргумента различным
    функциям авторизации и помощникам. Первый элемент в массиве будет использоваться для определения того, какая
    политика должна быть вызвана, в то время как остальные элементы массива передаются как параметры методу политики и
    могут использоваться для дополнительного контекста при принятии решений об авторизации. Например, рассмотрим
    следующее <code>PostPolicy</code> определение метода, которое содержит дополнительный <code>$category</code>
    параметр:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Determine if the given post can be updated by the user.
 *
 * @param  \App\Models\User  $user
 * @param  \App\Models\  $post
 * @param  int  $category
 * @return bool
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">update</span><span
                class="token punctuation">(</span>User <span class="token variable">$user</span><span
                class="token punctuation">,</span> Post <span class="token variable">$post</span><span
                class="token punctuation">,</span> int <span class="token variable">$category</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span> <span class="token operator">===</span> <span class="token variable">$post</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">user_id</span> <span
                class="token operator">&amp;&amp;</span>
        <span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">canUpdateCategory</span><span
                class="token punctuation">(</span><span class="token variable">$category</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>При попытке определить, может ли аутентифицированный пользователь обновить данное сообщение, мы можем вызвать этот
    метод политики следующим образом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Update the given blog post.
 *
 * @param  \Illuminate\Http\Request  $request
 * @param  \App\Models\Post  $post
 * @return \Illuminate\Http\Response
 *
 * @throws \Illuminate\Auth\Access\AuthorizationException
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">update</span><span
                class="token punctuation">(</span>Request <span class="token variable">$request</span><span
                class="token punctuation">,</span> Post <span class="token variable">$post</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">authorize</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'update'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span class="token variable">$post</span><span
                class="token punctuation">,</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">category</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    
    <span class="token comment">// The current user can update the blog post...</span>
<span class="token punctuation">}</span></code></pre>
