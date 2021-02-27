<h1>Шаблоны Blade</h1>
<ul>
    <li><a href="blade#introduction">Вступление</a></li>
    <li><a href="blade#displaying-data">Отображение данных</a>
        <ul>
            <li><a href="blade#html-entity-encoding">Кодировка HTML-объекта</a></li>
            <li><a href="blade#blade-and-javascript-frameworks">Платформы Blade и JavaScript</a></li>
        </ul>
    </li>
    <li><a href="blade#blade-directives">Директивы Blade</a>
        <ul>
            <li><a href="blade#if-statements">Если утверждения</a></li>
            <li><a href="blade#switch-statements">Операторы переключения</a></li>
            <li><a href="blade#loops">Петли</a></li>
            <li><a href="blade#the-loop-variable">Переменная цикла</a></li>
            <li><a href="blade#comments">Комментарии</a></li>
            <li><a href="blade#including-subviews">Включая подвиды</a></li>
            <li><a href="blade#the-once-directive">Директива <code>@once</code></a></li>
            <li><a href="blade#raw-php">Необработанный PHP</a></li>
        </ul>
    </li>
    <li><a href="blade#components">Составные части</a>
        <ul>
            <li><a href="blade#rendering-components">Компоненты рендеринга</a></li>
            <li><a href="blade#passing-data-to-components">Передача данных в компоненты</a></li>
            <li><a href="blade#component-attributes">Компонент Атрибуты</a></li>
            <li><a href="blade#slots">Слоты</a></li>
            <li><a href="blade#inline-component-views">Встроенные представления компонентов</a></li>
            <li><a href="blade#anonymous-components">Анонимные компоненты</a></li>
            <li><a href="blade#dynamic-components">Динамические компоненты</a></li>
            <li><a href="blade#manually-registering-components">Регистрация компонентов вручную</a></li>
        </ul>
    </li>
    <li><a href="blade#building-layouts">Макеты зданий</a>
        <ul>
            <li><a href="blade#layouts-using-components">Макеты с использованием компонентов</a></li>
            <li><a href="blade#layouts-using-template-inheritance">Макеты с использованием наследования шаблонов</a>
            </li>
        </ul>
    </li>
    <li><a href="blade#forms">Формы</a>
        <ul>
            <li><a href="blade#csrf-field">CSRF поле</a></li>
            <li><a href="blade#method-field">Поле метода</a></li>
            <li><a href="blade#validation-errors">Ошибки валидации</a></li>
        </ul>
    </li>
    <li><a href="blade#stacks">Стеки</a></li>
    <li><a href="blade#service-injection">Внедрение услуг</a></li>
    <li><a href="blade#extending-blade">Расширение Blade</a>
        <ul>
            <li><a href="blade#custom-if-statements">Пользовательские операторы If</a></li>
        </ul>
    </li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Blade - это простой, но мощный движок для создания шаблонов, входящий в состав Laravel. В отличие от некоторых
    шаблонизаторов PHP, Blade не ограничивает вас в использовании простого кода PHP в ваших шаблонах. Фактически, все
    шаблоны Blade компилируются в простой код PHP и кэшируются до тех пор, пока они не будут изменены, что означает, что
    Blade практически не добавляет накладных расходов вашему приложению. Файлы шаблонов Blade используют <code>.blade.php</code> расширение
    файла и обычно хранятся в <code>resources/views</code> каталоге.</p>
<p>Представления Blade могут быть возвращены из маршрутов или контроллера с помощью глобального <code>view</code> помощника.
    Конечно, как упоминалось в документации по <a href="views">представлениям</a>, данные могут быть переданы в
    представление Blade, используя <code>view</code> второй аргумент помощника:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token function">view</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'greeting'</span><span class="token punctuation">,</span> <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token single-quoted-string string">'Finn'</span><span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Прежде чем углубиться в Blade, обязательно прочтите <a href="views">документацию</a> Laravel <a href="views">View</a>
           .</p></p></div>
</blockquote>
<p></p>
<h2 id="displaying-data"><a href="#displaying-data">Отображение данных</a></h2>
<p>Вы можете отображать данные, которые передаются в представления Blade, заключив переменную в фигурные скобки.
    Например, учитывая следующий маршрут:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token function">view</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'welcome'</span><span class="token punctuation">,</span> <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token single-quoted-string string">'Samantha'</span><span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы можете отобразить содержимое <code>name</code> переменной следующим образом:</p>
<pre class=" language-php"><code class=" language-php">Hello<span class="token punctuation">,</span> <span
                class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">{literal}{{/literal}</span> <span class="token variable">$name</span> <span class="token punctuation">}</span><span class="token punctuation">}</span><span
                class="token punctuation">.</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <span class="mb-0 lg:ml-6">
            Операторы <code>{json_decode('"\u007B\u007B \u007D\u007D"')}</code> автоматически обрабатываются через
            PHP-функцию <code>htmlspecialchars</code> для предотвращения XSS-атак.</span></div>
</blockquote>
<p>Вы не ограничены отображением содержимого переменных, переданных в представление. Вы также можете повторить
    результаты любой функции PHP. Фактически, вы можете поместить любой PHP-код в выражение Blade echo:</p>
<pre class=" language-php"><code class=" language-php">The current <span class="token constant">UNIX</span> timestamp is <span
                class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">{literal}{{/literal}</span> <span class="token function">time</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">}</span><span class="token punctuation">}</span><span
                class="token punctuation">.</span></code></pre>
<p></p>
<h4 id="rendering-json"><a href="#rendering-json">Рендеринг JSON</a></h4>
<p>Иногда вы можете передать массив вашему представлению с намерением отобразить его как JSON, чтобы инициализировать
    переменную JavaScript. Например:</p>
<pre class=" language-php"><code class=" language-php"><span class="token tag"><span class="token tag"><span
                        class="token punctuation">&lt;</span>script</span><span
                    class="token punctuation">&gt;</span></span><span class="token script"><span
                    class="token language-javascript">
    <span class="token keyword">var</span> app <span class="token operator">=</span> <span
                        class="token php language-php"><span class="token delimiter important">&lt;?php</span> <span
                            class="token keyword">echo</span> <span class="token function">json_encode</span><span
                            class="token punctuation">(</span><span class="token variable">$array</span><span
                            class="token punctuation">)</span><span class="token punctuation">;</span> <span
                            class="token delimiter important">?&gt;</span></span><span
                        class="token punctuation">;</span>
</span></span><span class="token tag"><span class="token tag"><span
                        class="token punctuation">&lt;/</span>script</span><span
                    class="token punctuation">&gt;</span></span></code></pre>
<p>Однако вместо ручного вызова <code>json_encode</code> вы можете использовать <code>@json</code> директиву Blade. <code>@json</code> Директива
    принимает те же аргументы, что и в PHP <code>json_encode</code> функции. По умолчанию <code>@json</code> директива
    вызывает <code>json_encode</code> функцию с <code>JSON_HEX_TAG</code>, <code>JSON_HEX_APOS</code>,
    <code>JSON_HEX_AMP</code> и <code>JSON_HEX_QUOT</code> флаги:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>script<span
                class="token operator">&gt;</span>
    <span class="token keyword">var</span> app <span class="token operator">=</span> @<span
                class="token function">json</span><span class="token punctuation">(</span><span class="token variable">$array</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

    <span class="token keyword">var</span> app <span class="token operator">=</span> @<span
                class="token function">json</span><span class="token punctuation">(</span><span class="token variable">$array</span><span
                class="token punctuation">,</span> <span class="token constant">JSON_PRETTY_PRINT</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token operator">&lt;</span><span class="token operator">/</span>script<span
                class="token operator">&gt;</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Вы должны использовать <code>@json</code> директиву только для отображения существующих переменных в формате
            JSON. Шаблон Blade основан на регулярных выражениях, и попытки передать сложное выражение в директиву могут
            вызвать неожиданные сбои.</p></p></div>
</blockquote>
<p></p>
<h3 id="html-entity-encoding"><a href="#html-entity-encoding">Кодировка HTML-объекта</a></h3>
<p>По умолчанию Blade (и <code>e</code> помощник Laravel ) будет дважды кодировать объекты HTML. Если вы хотите отключить
    двойное кодирование, вызовите <code>Blade::withoutDoubleEncoding</code> метод из <code>boot</code> метода вашего
    <code>AppServiceProvider</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Providers</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Blade</span><span class="token punctuation">;</span>
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
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">boot</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        Blade<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">withoutDoubleEncoding</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h4 id="displaying-unescaped-data"><a href="#displaying-unescaped-data">Отображение неэкранированных данных</a></h4>
<p>По умолчанию <code>{literal}{{ }}{/literal}</code> операторы Blade автоматически отправляются через <code>htmlspecialchars</code> функцию
    PHP для предотвращения атак XSS. Если вы не хотите, чтобы ваши данные были экранированы, вы можете использовать
    следующий синтаксис:</p>
<pre class=" language-php"><code class=" language-php">Hello<span class="token punctuation">,</span> <span
                class="token punctuation">{literal}{{/literal}</span><span class="token operator">!</span><span class="token operator">!</span> <span class="token variable">$name</span> <span class="token operator">!</span><span class="token operator">!</span><span class="token punctuation">}</span><span
                class="token punctuation">.</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Будьте очень осторожны при повторении содержимого, предоставленного пользователями вашего приложения. Обычно
            следует использовать экранированный синтаксис двойных фигурных скобок, чтобы предотвратить атаки XSS при
            отображении данных, предоставленных пользователем.</p></p></div>
</blockquote>
<p></p>
<h3 id="blade-and-javascript-frameworks"><a href="#blade-and-javascript-frameworks">Платформы Blade и JavaScript</a>
</h3>
<p>Поскольку во многих фреймворках JavaScript также используются «фигурные» скобки, чтобы указать, что данное выражение
    должно отображаться в браузере, вы можете использовать этот <code>@</code> символ, чтобы сообщить механизму
    рендеринга Blade, что выражение должно оставаться нетронутым. Например:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>h1<span
                class="token operator">&gt;</span>Laravel<span class="token operator">&lt;</span><span
                class="token operator">/</span>h1<span class="token operator">&gt;</span>

Hello<span class="token punctuation">,</span> @<span
                class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">{literal}{{/literal}</span> name <span class="token punctuation">}</span><span class="token punctuation">}</span><span
                class="token punctuation">.</span></code></pre>
<p>В этом примере <code>@</code> символ будет удален Blade; тем не менее, <code>{literal}{{ name }}{/literal}</code> выражение останется
    нетронутым движком Blade, что позволит обработать его вашей инфраструктурой JavaScript.</p>
<p>Этот <code>@</code> символ также может использоваться для выхода из директив Blade:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">{literal}{{/literal}</span><span class="token operator">--</span> Blade template <span class="token operator">--</span><span class="token punctuation">}</span><span class="token punctuation">}</span>
@@<span class="token function">json</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>

<span class="token operator">&lt;</span><span class="token operator">!</span><span
                class="token operator">--</span> <span class="token constant">HTML</span> output <span
                class="token operator">--</span><span class="token operator">&gt;</span>
@<span class="token function">json</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span></code></pre>
<p></p>
<h4 id="the-at-verbatim-directive"><a href="#the-at-verbatim-directive"><code>@verbatim</code> Директива</a></h4>
<p>Если вы отображаете переменные JavaScript в большой части вашего шаблона, вы можете заключить HTML в
    <code>@verbatim</code> директиву, чтобы вам не приходилось префикс каждого оператора Blade echo с помощью
    <code>@</code> символа:</p>
<pre class=" language-php"><code class=" language-php">@verbatim
    <span class="token operator">&lt;</span>div <span class="token keyword">class</span><span
                class="token operator">=</span><span class="token double-quoted-string string">"container"</span><span
                class="token operator">&gt;</span>
        Hello<span class="token punctuation">,</span> <span
                class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">{literal}{{/literal}</span> name <span class="token punctuation">}</span><span class="token punctuation">}</span><span
                class="token punctuation">.</span>
    <span class="token operator">&lt;</span><span class="token operator">/</span>div<span
                class="token operator">&gt;</span>
@endverbatim</code></pre>
<p></p>
<h2 id="blade-directives"><a href="#blade-directives">Директивы Blade</a></h2>
<p>Помимо наследования шаблонов и отображения данных, Blade также предоставляет удобные ярлыки для стандартных
    управляющих структур PHP, таких как условные операторы и циклы. Эти сочетания клавиш обеспечивают очень чистый и
    лаконичный способ работы с управляющими структурами PHP, но при этом остаются знакомыми своим аналогам PHP.</p>
<p></p>
<h3 id="if-statements"><a href="#if-statements">Если утверждения</a></h3>
<p>Вы можете построить <code>if</code> заявления, используя <code>@if</code>, <code>@elseif</code>, <code>@else</code> и
    <code>@endif</code> директивы. Эти директивы работают так же, как и их аналоги в PHP:</p>
<pre class=" language-php"><code class=" language-php">@<span class="token keyword">if</span> <span
                class="token punctuation">(</span><span class="token function">count</span><span
                class="token punctuation">(</span><span class="token variable">$records</span><span
                class="token punctuation">)</span> <span class="token operator">===</span> <span
                class="token number">1</span><span class="token punctuation">)</span>
    <span class="token constant">I</span> have one record<span class="token operator">!</span>
@<span class="token keyword">elseif</span> <span class="token punctuation">(</span><span
                class="token function">count</span><span class="token punctuation">(</span><span class="token variable">$records</span><span
                class="token punctuation">)</span> <span class="token operator">&gt;</span> <span
                class="token number">1</span><span class="token punctuation">)</span>
    <span class="token constant">I</span> have multiple records<span class="token operator">!</span>
@<span class="token keyword">else</span>
    <span class="token constant">I</span> don't have any records<span class="token operator">!</span>
@<span class="token keyword">endif</span></code></pre>
<p>Для удобства Blade также предоставляет <code>@unless</code> директиву:</p>
<pre class=" language-php"><code class=" language-php">@unless <span class="token punctuation">(</span>Auth<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">check</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span>
    You are not signed in<span class="token punctuation">.</span>
@endunless</code></pre>
<p>В дополнении к условным директивам уже говорились, <code>@isset</code> и <code>@empty</code> директивы могут быть
    использована в качестве удобных клавиш для их соответствующих функций PHP:</p>
<pre class=" language-php"><code class=" language-php">@<span class="token keyword">isset</span><span
                class="token punctuation">(</span><span class="token variable">$records</span><span
                class="token punctuation">)</span>
    <span class="token comment">// $records is defined and is not null...</span>
@endisset

@<span class="token keyword">empty</span><span class="token punctuation">(</span><span
                class="token variable">$records</span><span class="token punctuation">)</span>
    <span class="token comment">// $records is "empty"...</span>
@endempty</code></pre>
<p></p>
<h4 id="authentication-directives"><a href="#authentication-directives">Директивы аутентификации</a></h4>
<p><code>@auth</code> И <code>@guest</code> директивы могут использоваться, чтобы быстро определить, если текущий
    пользователь <a href="authentication">проверку подлинности</a> или гость:</p>
<pre class=" language-php"><code class=" language-php">@auth
    <span class="token comment">// The user is authenticated...</span>
@endauth

@guest
    <span class="token comment">// The user is not authenticated...</span>
@endguest</code></pre>
<p>При необходимости, вы можете указать охранник аутентификации, которые должны быть проверены при использовании <code>@auth</code> и
    <code>@guest</code> директив:</p>
<pre class=" language-php"><code class=" language-php">@<span class="token function">auth</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'admin'</span><span
                class="token punctuation">)</span>
    <span class="token comment">// The user is authenticated...</span>
@endauth

@<span class="token function">guest</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'admin'</span><span class="token punctuation">)</span>
    <span class="token comment">// The user is not authenticated...</span>
@endguest</code></pre>
<p></p>
<h4 id="environment-directives"><a href="#environment-directives">Директивы по окружающей среде</a></h4>
<p>Вы можете проверить, работает ли приложение в производственной среде, с помощью <code>@production</code> директивы:
</p>
<pre class=" language-php"><code class=" language-php">@production
    <span class="token comment">// Production specific content...</span>
@endproduction</code></pre>
<p>Или вы можете определить, работает ли приложение в определенной среде, с помощью <code>@env</code> директивы:</p>
<pre class=" language-php"><code class=" language-php">@<span class="token function">env</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'staging'</span><span
                class="token punctuation">)</span>
    <span class="token comment">// The application is running in "staging"...</span>
@endenv

@<span class="token function">env</span><span class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'staging'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'production'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span>
    <span class="token comment">// The application is running in "staging" or "production"...</span>
@endenv</code></pre>
<p></p>
<h4 id="section-directives"><a href="#section-directives">Раздел Директивы</a></h4>
<p>Вы можете определить, есть ли в разделе наследования шаблона содержимое, используя <code>@hasSection</code> директиву:
</p>
<pre class=" language-html"><code class=" language-html">@hasSection('navigation')
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>div</span> <span
                class="token attr-name">class</span><span class="token attr-value"><span
                    class="token punctuation attr-equals">=</span><span
                    class="token punctuation">"</span>pull-right<span class="token punctuation">"</span></span><span
                class="token punctuation">&gt;</span></span>
        @yield('navigation')
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>div</span><span
                class="token punctuation">&gt;</span></span>

    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>div</span> <span
                class="token attr-name">class</span><span class="token attr-value"><span
                    class="token punctuation attr-equals">=</span><span class="token punctuation">"</span>clearfix<span
                    class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span><span
                class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>div</span><span
                    class="token punctuation">&gt;</span></span>
@endif</code></pre>
<p>Вы можете использовать <code>sectionMissing</code> директиву, чтобы определить, нет ли в разделе содержимого:</p>
<pre class=" language-html"><code class=" language-html">@sectionMissing('navigation')
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>div</span> <span
                class="token attr-name">class</span><span class="token attr-value"><span
                    class="token punctuation attr-equals">=</span><span
                    class="token punctuation">"</span>pull-right<span class="token punctuation">"</span></span><span
                class="token punctuation">&gt;</span></span>
        @include('default-navigation')
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>div</span><span
                class="token punctuation">&gt;</span></span>
@endif</code></pre>
<p></p>
<h3 id="switch-statements"><a href="#switch-statements">Операторы переключения</a></h3>
<p>Заявления коммутатора могут быть построены с использованием <code>@switch</code>, <code>@case</code>,
    <code>@break</code>, <code>@default</code> и <code>@endswitch</code> директивы:</p>
<pre class=" language-php"><code class=" language-php">@<span class="token keyword">switch</span><span
                class="token punctuation">(</span><span class="token variable">$i</span><span class="token punctuation">)</span>
    @<span class="token keyword">case</span><span class="token punctuation">(</span><span
                class="token number">1</span><span class="token punctuation">)</span>
        First <span class="token keyword">case</span><span class="token punctuation">.</span><span
                class="token punctuation">.</span><span class="token punctuation">.</span>
        @<span class="token keyword">break</span>

    @<span class="token keyword">case</span><span class="token punctuation">(</span><span
                class="token number">2</span><span class="token punctuation">)</span>
        Second <span class="token keyword">case</span><span class="token punctuation">.</span><span
                class="token punctuation">.</span><span class="token punctuation">.</span>
        @<span class="token keyword">break</span>

    @<span class="token keyword">default</span>
        <span class="token keyword">Default</span> <span class="token keyword">case</span><span
                class="token punctuation">.</span><span class="token punctuation">.</span><span
                class="token punctuation">.</span>
@<span class="token keyword">endswitch</span></code></pre>
<p></p>
<h3 id="loops"><a href="#loops">Петли</a></h3>
<p>В дополнение к условным операторам Blade предоставляет простые директивы для работы со структурами циклов PHP. Опять
    же, каждая из этих директив функционирует идентично своим аналогам PHP:</p>
<pre class=" language-php"><code class=" language-php">@<span class="token keyword">for</span> <span
                class="token punctuation">(</span><span class="token variable">$i</span> <span
                class="token operator">=</span> <span class="token number">0</span><span
                class="token punctuation">;</span> <span class="token variable">$i</span> <span class="token operator">&lt;</span> <span
                class="token number">10</span><span class="token punctuation">;</span> <span
                class="token variable">$i</span><span class="token operator">++</span><span
                class="token punctuation">)</span>
    The current value is <span
                class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">{literal}{{/literal}</span> <span class="token variable">$i</span> <span class="token punctuation">}</span><span class="token punctuation">}</span>
@<span class="token keyword">endfor</span>

@<span class="token keyword">foreach</span> <span class="token punctuation">(</span><span
                class="token variable">$users</span> <span class="token keyword">as</span> <span class="token variable">$user</span><span
                class="token punctuation">)</span>
    <span class="token operator">&lt;</span>p<span class="token operator">&gt;</span>This is user <span
                class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">{literal}{{/literal}</span> <span class="token variable">$user</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">id</span> <span class="token punctuation">}</span><span class="token punctuation">}</span><span
                class="token operator">&lt;</span><span class="token operator">/</span>p<span class="token operator">&gt;</span>
@<span class="token keyword">endforeach</span>

@forelse <span class="token punctuation">(</span><span class="token variable">$users</span> <span class="token keyword">as</span> <span
                class="token variable">$user</span><span class="token punctuation">)</span>
    <span class="token operator">&lt;</span>li<span class="token operator">&gt;</span><span
                class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">{literal}{{/literal}</span> <span class="token variable">$user</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">name</span> <span class="token punctuation">}</span><span class="token punctuation">}</span><span
                class="token operator">&lt;</span><span class="token operator">/</span>li<span class="token operator">&gt;</span>
@<span class="token keyword">empty</span>
    <span class="token operator">&lt;</span>p<span class="token operator">&gt;</span>No users<span
                class="token operator">&lt;</span><span class="token operator">/</span>p<span class="token operator">&gt;</span>
@endforelse

@<span class="token keyword">while</span> <span class="token punctuation">(</span><span class="token boolean constant">true</span><span
                class="token punctuation">)</span>
    <span class="token operator">&lt;</span>p<span class="token operator">&gt;</span><span
                class="token constant">I</span>'m looping forever<span class="token punctuation">.</span><span
                class="token operator">&lt;</span><span class="token operator">/</span>p<span class="token operator">&gt;</span>
@<span class="token keyword">endwhile</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>При выполнении цикла вы можете использовать <a href="blade#the-loop-variable">переменную цикла,</a> чтобы
            получить ценную информацию о цикле, например, находитесь ли вы на первой или последней итерации цикла.
        </p></p></div>
</blockquote>
<p>При использовании петли вы можете закончить цикл или пропустить текущую итерацию с использованием
    <code>@continue</code> и <code>@break</code> директив:</p>
<pre class=" language-php"><code class=" language-php">@<span class="token keyword">foreach</span> <span
                class="token punctuation">(</span><span class="token variable">$users</span> <span
                class="token keyword">as</span> <span class="token variable">$user</span><span
                class="token punctuation">)</span>
    @<span class="token keyword">if</span> <span class="token punctuation">(</span><span
                class="token variable">$user</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">type</span> <span class="token operator">==</span> <span
                class="token number">1</span><span class="token punctuation">)</span>
        @<span class="token keyword">continue</span>
    @<span class="token keyword">endif</span>

    <span class="token operator">&lt;</span>li<span class="token operator">&gt;</span><span
                class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">{literal}{{/literal}</span> <span class="token variable">$user</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">name</span> <span class="token punctuation">}</span><span class="token punctuation">}</span><span
                class="token operator">&lt;</span><span class="token operator">/</span>li<span class="token operator">&gt;</span>

    @<span class="token keyword">if</span> <span class="token punctuation">(</span><span
                class="token variable">$user</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">number</span> <span class="token operator">==</span> <span
                class="token number">5</span><span class="token punctuation">)</span>
        @<span class="token keyword">break</span>
    @<span class="token keyword">endif</span>
@<span class="token keyword">endforeach</span></code></pre>
<p>Вы также можете включить условие продолжения или прерывания в объявление директивы:</p>
<pre class=" language-php"><code class=" language-php">@<span class="token keyword">foreach</span> <span
                class="token punctuation">(</span><span class="token variable">$users</span> <span
                class="token keyword">as</span> <span class="token variable">$user</span><span
                class="token punctuation">)</span>
    @<span class="token keyword">continue</span><span class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">type</span> <span class="token operator">==</span> <span
                class="token number">1</span><span class="token punctuation">)</span>

    <span class="token operator">&lt;</span>li<span class="token operator">&gt;</span><span
                class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">{literal}{{/literal}</span> <span class="token variable">$user</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">name</span> <span class="token punctuation">}</span><span class="token punctuation">}</span><span
                class="token operator">&lt;</span><span class="token operator">/</span>li<span class="token operator">&gt;</span>

    @<span class="token keyword">break</span><span class="token punctuation">(</span><span
                class="token variable">$user</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">number</span> <span class="token operator">==</span> <span
                class="token number">5</span><span class="token punctuation">)</span>
@<span class="token keyword">endforeach</span></code></pre>
<p></p>
<h3 id="the-loop-variable"><a href="#the-loop-variable">Переменная цикла</a></h3>
<p>При выполнении цикла <code>$loop</code> переменная будет доступна внутри вашего цикла. Эта переменная обеспечивает
    доступ к некоторым полезным битам информации, такой как индекс текущего цикла, а также к тому, является ли это
    первой или последней итерацией цикла:</p>
<pre class=" language-php"><code class=" language-php">@<span class="token keyword">foreach</span> <span
                class="token punctuation">(</span><span class="token variable">$users</span> <span
                class="token keyword">as</span> <span class="token variable">$user</span><span
                class="token punctuation">)</span>
    @<span class="token keyword">if</span> <span class="token punctuation">(</span><span
                class="token variable">$loop</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">first</span><span class="token punctuation">)</span>
        This is the first iteration<span class="token punctuation">.</span>
    @<span class="token keyword">endif</span>

    @<span class="token keyword">if</span> <span class="token punctuation">(</span><span
                class="token variable">$loop</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">last</span><span class="token punctuation">)</span>
        This is the last iteration<span class="token punctuation">.</span>
    @<span class="token keyword">endif</span>

    <span class="token operator">&lt;</span>p<span class="token operator">&gt;</span>This is user <span
                class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">{literal}{{/literal}</span> <span class="token variable">$user</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">id</span> <span class="token punctuation">}</span><span class="token punctuation">}</span><span
                class="token operator">&lt;</span><span class="token operator">/</span>p<span class="token operator">&gt;</span>
@<span class="token keyword">endforeach</span></code></pre>
<p>Если вы находитесь во вложенном цикле, вы можете получить доступ к <code>$loop</code> переменной родительского цикла
    через <code>parent</code> свойство:</p>
<pre class=" language-php"><code class=" language-php">@<span class="token keyword">foreach</span> <span
                class="token punctuation">(</span><span class="token variable">$users</span> <span
                class="token keyword">as</span> <span class="token variable">$user</span><span
                class="token punctuation">)</span>
    @<span class="token keyword">foreach</span> <span class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">posts</span> <span
                class="token keyword">as</span> <span class="token variable">$post</span><span
                class="token punctuation">)</span>
        @<span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token variable">$loop</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token keyword">parent</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">first</span><span
                class="token punctuation">)</span>
            This is the first iteration of the <span class="token keyword">parent</span> loop<span
                class="token punctuation">.</span>
        @<span class="token keyword">endif</span>
    @<span class="token keyword">endforeach</span>
@<span class="token keyword">endforeach</span></code></pre>
<p><code>$loop</code> Переменная содержит также множество других полезных свойств:</p>
<table>
    <thead>
    <tr>
        <th>Свойство</th>
        <th>Описание</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td><code>$loop-&gt;index</code></td>
        <td>Индекс текущей итерации цикла (начинается с 0).</td>
    </tr>
    <tr>
        <td><code>$loop-&gt;iteration</code></td>
        <td>Текущая итерация цикла (начинается с 1).</td>
    </tr>
    <tr>
        <td><code>$loop-&gt;remaining</code></td>
        <td>Итерации, оставшиеся в цикле.</td>
    </tr>
    <tr>
        <td><code>$loop-&gt;count</code></td>
        <td>Общее количество элементов в повторяемом массиве.</td>
    </tr>
    <tr>
        <td><code>$loop-&gt;first</code></td>
        <td>Является ли это первой итерацией цикла.</td>
    </tr>
    <tr>
        <td><code>$loop-&gt;last</code></td>
        <td>Является ли это последней итерацией цикла.</td>
    </tr>
    <tr>
        <td><code>$loop-&gt;even</code></td>
        <td>Является ли это четным повторением цикла.</td>
    </tr>
    <tr>
        <td><code>$loop-&gt;odd</code></td>
        <td>Является ли это нечетным повторением цикла.</td>
    </tr>
    <tr>
        <td><code>$loop-&gt;depth</code></td>
        <td>Уровень вложенности текущего цикла.</td>
    </tr>
    <tr>
        <td><code>$loop-&gt;parent</code></td>
        <td>Находясь во вложенном цикле, переменная родительского цикла.</td>
    </tr>
    </tbody>
</table>
<p></p>
<h3 id="comments"><a href="#comments">Комментарии</a></h3>
<p>Blade также позволяет вам определять комментарии в ваших представлениях. Однако, в отличие от комментариев HTML,
    комментарии Blade не включаются в HTML, возвращаемый вашим приложением:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">{literal}{{/literal}</span><span class="token operator">--</span> This comment will not be present in the rendered <span class="token constant">HTML</span> <span class="token operator">--</span><span class="token punctuation">}</span><span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="including-subviews"><a href="#including-subviews">Включая подвиды</a></h3>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Хотя вы можете использовать <code>@include</code> директиву, <a href="blade#components">компоненты</a> Blade
            предоставляют аналогичные функции и предлагают несколько преимуществ по сравнению с <code>@include</code> директивой,
            например привязку данных и атрибутов.</p></p></div>
</blockquote>
<p><code>@include</code> Директива Blade позволяет вам включать представление Blade из другого представления. Все
    переменные, доступные для родительского представления, будут доступны для включенного представления:</p>
<pre class=" language-html"><code class=" language-html"><span class="token tag"><span class="token tag"><span
                        class="token punctuation">&lt;</span>div</span><span
                    class="token punctuation">&gt;</span></span>
    @include('shared.errors')

    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>form</span><span
                class="token punctuation">&gt;</span></span>
        <span class="token comment">&lt;!-- Form Contents --&gt;</span>
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>form</span><span
                class="token punctuation">&gt;</span></span>
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>div</span><span
            class="token punctuation">&gt;</span></span></code></pre>
<p>Несмотря на то, что включенное представление унаследует все данные, доступные в родительском представлении, вы также
    можете передать массив дополнительных данных, которые должны быть доступны для включенного представления:</p>
<pre class=" language-php"><code class=" language-php">@<span class="token keyword">include</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'view.name'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'status'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'complete'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span></code></pre>
<p>Если вы попытаетесь <code>@include</code> открыть несуществующее представление, Laravel выдаст ошибку. Если вы хотите
    включить представление, которое может присутствовать или отсутствовать, вам следует использовать
    <code>@includeIf</code> директиву:</p>
<pre class=" language-php"><code class=" language-php">@<span class="token function">includeIf</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'view.name'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'status'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'complete'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span></code></pre>
<p>Если вы хотели бы <code>@include</code> вид, если данное логическое выражение принимает значение <code>true</code> или
    <code>false</code>, вы можете использовать <code>@includeWhen</code> и <code>@includeUnless</code> директивы:</p>
<pre class=" language-php"><code class=" language-php">@<span class="token function">includeWhen</span><span
                class="token punctuation">(</span><span class="token variable">$boolean</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'view.name'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'status'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'complete'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span>

@<span class="token function">includeUnless</span><span class="token punctuation">(</span><span class="token variable">$boolean</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'view.name'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'status'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'complete'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span></code></pre>
<p>Чтобы включить первое представление, которое существует из данного массива представлений, вы можете использовать
    <code>includeFirst</code> директиву:</p>
<pre class=" language-php"><code class=" language-php">@<span class="token function">includeFirst</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'custom.admin'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'admin'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'status'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'complete'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Вы должны избегать использования <code>__DIR__</code> и <code>__FILE__</code> констант в ваших взглядах Клинка,
            так как они относятся к месту кешированного, составитель зрения.</p></p></div>
</blockquote>
<p></p>
<h4 id="rendering-views-for-collections"><a href="#rendering-views-for-collections">Визуализация представлений для
        коллекций</a></h4>
<p>Вы можете комбинировать циклы и включать в одну строку с помощью <code>@each</code> директивы Blade:</p>
<pre class=" language-php"><code class=" language-php">@<span class="token function">each</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'view.name'</span><span
                class="token punctuation">,</span> <span class="token variable">$jobs</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'job'</span><span
                class="token punctuation">)</span></code></pre>
<p>В <code>@each</code> первом аргументе директивы является представлением для визуализации для каждого элемента массива
    или коллекции. Второй аргумент - это массив или коллекция, которые вы хотите перебрать, а третий аргумент - это имя
    переменной, которая будет присвоена текущей итерации в представлении. Так, например, если вы выполняете итерацию по
    массиву <code>jobs</code>, обычно вам нужно обращаться к каждому заданию как к <code>job</code> переменной в
    представлении. Ключ массива для текущей итерации будет доступен как <code>key</code> переменная в представлении.</p>
<p>Вы также можете передать <code>@each</code> директиве четвертый аргумент. Этот аргумент определяет представление,
    которое будет отображаться, если данный массив пуст.</p>
<pre class=" language-php"><code class=" language-php">@<span class="token function">each</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'view.name'</span><span
                class="token punctuation">,</span> <span class="token variable">$jobs</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'job'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'view.empty'</span><span
                class="token punctuation">)</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Представления, отображаемые с помощью <code>@each</code>, не наследуют переменные родительского
            представления. Если дочернему представлению требуются эти переменные, вам следует использовать вместо них
            директивы <code>@foreach</code> и <code>@include</code>.</p></p></div>
</blockquote>
<p></p>
<h3 id="the-once-directive"><a href="#the-once-directive"><code>@once</code> Директива</a></h3>
<p><code>@once</code> Директива позволяет определить часть шаблона, который будет оцениваться только один раз за цикл
    рендеринга. Это может быть полезно для вставки заданного фрагмента JavaScript в заголовок страницы с помощью <a
            href="blade#stacks">стеков</a>. Например, если вы визуализируете данный <a href="blade#components">компонент</a>
    в цикле, вы можете захотеть вставить JavaScript в заголовок только при первом визуализации компонента:</p>
<pre class=" language-php"><code class=" language-php">@once
    @<span class="token function">push</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'scripts'</span><span class="token punctuation">)</span>
        <span class="token operator">&lt;</span>script<span class="token operator">&gt;</span>
            <span class="token comment">// Your custom JavaScript...</span>
        <span class="token operator">&lt;</span><span class="token operator">/</span>script<span class="token operator">&gt;</span>
    @endpush
@endonce</code></pre>
<p></p>
<h2 id="building-layouts"><a href="#building-layouts">Макеты зданий</a></h2>
<p></p>
<h3 id="layouts-using-components"><a href="#layouts-using-components">Макеты с использованием компонентов</a></h3>
<p>Большинство веб-приложений поддерживают одинаковый общий макет на разных страницах. Было бы невероятно громоздко и
    сложно поддерживать наше приложение, если бы нам пришлось повторять весь HTML макета в каждом создаваемом
    представлении. К счастью, этот макет удобно определить как отдельный <a href="blade#components">компонент Blade,</a>
    а затем использовать его во всем приложении.</p>
<p></p>
<h4 id="defining-the-layout-component"><a href="#defining-the-layout-component">Определение компонента макета</a></h4>
<p>Например, представьте, что мы создаем приложение со списком задач. Мы могли бы определить <code>layout</code> компонент,
    который выглядит следующим образом:</p>
<pre class=" language-html"><code class=" language-html"><span class="token comment">&lt;!-- resources/views/components/layout.blade.php --&gt;</span>

<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>html</span><span
            class="token punctuation">&gt;</span></span>
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>head</span><span
                class="token punctuation">&gt;</span></span>
        <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>title</span><span
                    class="token punctuation">&gt;</span></span>{literal}{{ $title ?? 'Todo Manager' }}{/literal}<span
                class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>title</span><span
                    class="token punctuation">&gt;</span></span>
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>head</span><span
                class="token punctuation">&gt;</span></span>
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>body</span><span
                class="token punctuation">&gt;</span></span>
        <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>h1</span><span
                    class="token punctuation">&gt;</span></span>Todos<span class="token tag"><span
                    class="token tag"><span class="token punctuation">&lt;/</span>h1</span><span
                    class="token punctuation">&gt;</span></span>
        <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>hr</span><span
                    class="token punctuation">/&gt;</span></span>
        {literal}{{ $slot }}{/literal}
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>body</span><span
                class="token punctuation">&gt;</span></span>
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>html</span><span
            class="token punctuation">&gt;</span></span></code></pre>
<p></p>
<h4 id="applying-the-layout-component"><a href="#applying-the-layout-component">Применение компонента макета</a></h4>
<p>Как только <code>layout</code> компонент определен, мы можем создать представление Blade, которое использует этот
    компонент. В этом примере мы определим простое представление, которое отображает наш список задач:</p>
<pre class=" language-html"><code class=" language-html"><span class="token comment">&lt;!-- resources/views/tasks.blade.php --&gt;</span>

<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>x-layout</span><span
            class="token punctuation">&gt;</span></span>
    @foreach ($tasks as $task)
        {literal}{{ $task }}{/literal}
    @endforeach
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>x-layout</span><span
            class="token punctuation">&gt;</span></span></code></pre>
<p>Помните, что контент, который вводится в компонент, будет передан <code>$slot</code> переменной по умолчанию в нашем
    <code>layout</code> компоненте. Как вы могли заметить, мы <code>layout</code> также уважаем <code>$title</code> слот,
    если он есть; в противном случае отображается заголовок по умолчанию. Мы можем вставить настраиваемый заголовок из
    нашего представления списка задач, используя стандартный синтаксис слота, описанный в <a href="blade#components">документации
        компонента</a>:</p>
<pre class=" language-html"><code class=" language-html"><span class="token comment">&lt;!-- resources/views/tasks.blade.php --&gt;</span>

<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>x-layout</span><span
            class="token punctuation">&gt;</span></span>
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>x-slot</span> <span
                class="token attr-name">name</span><span class="token attr-value"><span
                    class="token punctuation attr-equals">=</span><span class="token punctuation">"</span>title<span
                    class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span>
        Custom Title
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>x-slot</span><span
                class="token punctuation">&gt;</span></span>

    @foreach ($tasks as $task)
        {literal}{{ $task }}{/literal}
    @endforeach
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>x-layout</span><span
            class="token punctuation">&gt;</span></span></code></pre>
<p>Теперь, когда мы определили наш макет и представления списка задач, нам просто нужно вернуть <code>task</code> представление
    из маршрута:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Task</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/tasks'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> <span class="token function">view</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'tasks'</span><span class="token punctuation">,</span> <span class="token punctuation">[</span><span class="token single-quoted-string string">'tasks'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> Task<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">all</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="layouts-using-template-inheritance"><a href="#layouts-using-template-inheritance">Макеты с использованием
        наследования шаблонов</a></h3>
<p></p>
<h4 id="defining-a-layout"><a href="#defining-a-layout">Определение макета</a></h4>
<p>Макеты также могут быть созданы с помощью «наследования шаблонов». Это был основной способ создания приложений до
    появления <a href="blade#components">компонентов</a>.</p>
<p>Для начала рассмотрим простой пример. Сначала мы рассмотрим макет страницы. Поскольку большинство веб-приложений
    поддерживают одинаковый общий макет на разных страницах, удобно определить этот макет как единое представление
    Blade:</p>
<pre class=" language-html"><code class=" language-html"><span class="token comment">&lt;!-- resources/views/layouts/app.blade.php --&gt;</span>

<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>html</span><span
            class="token punctuation">&gt;</span></span>
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>head</span><span
                class="token punctuation">&gt;</span></span>
        <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>title</span><span
                    class="token punctuation">&gt;</span></span>App Name - @yield('title')<span class="token tag"><span
                    class="token tag"><span class="token punctuation">&lt;/</span>title</span><span
                    class="token punctuation">&gt;</span></span>
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>head</span><span
                class="token punctuation">&gt;</span></span>
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>body</span><span
                class="token punctuation">&gt;</span></span>
        @section('sidebar')
            This is the master sidebar.
        @show

        <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>div</span> <span
                    class="token attr-name">class</span><span class="token attr-value"><span
                        class="token punctuation attr-equals">=</span><span
                        class="token punctuation">"</span>container<span class="token punctuation">"</span></span><span
                    class="token punctuation">&gt;</span></span>
            @yield('content')
        <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>div</span><span
                    class="token punctuation">&gt;</span></span>
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>body</span><span
                class="token punctuation">&gt;</span></span>
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>html</span><span
            class="token punctuation">&gt;</span></span></code></pre>
<p>Как видите, этот файл содержит типичную разметку HTML. Тем не менее, принять к сведению <code>@section</code> и <code>@yield</code> директив.
    <code>@section</code> Директива, как следует из названия, определяет сечение содержания, в то время как
    <code>@yield</code> директива используется для отображения содержимого данного раздела.</p>
<p>Теперь, когда мы определили макет для нашего приложения, давайте определим дочернюю страницу, которая наследует
    макет.</p>
<p></p>
<h4 id="extending-a-layout"><a href="#extending-a-layout">Расширение макета</a></h4>
<p>При определении дочернего представления используйте <code>@extends</code> директиву Blade, чтобы указать, какой макет
    дочернее представление должно «наследовать». Представления, которые расширяют макет Blade, могут вставлять контент в
    разделы макета с помощью <code>@section</code> директив. Помните, как показано в приведенном выше примере, содержимое
    этих разделов будет отображаться в макете с использованием <code>@yield</code>:</p>
<pre class=" language-html"><code class=" language-html"><span class="token comment">&lt;!-- resources/views/child.blade.php --&gt;</span>

@extends('layouts.app')

@section('title', 'Page Title')

@section('sidebar')
    @parent

    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>p</span><span
                class="token punctuation">&gt;</span></span>This is appended to the master sidebar.<span
                class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>p</span><span
                    class="token punctuation">&gt;</span></span>
@endsection

@section('content')
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>p</span><span
                class="token punctuation">&gt;</span></span>This is my body content.<span class="token tag"><span
                    class="token tag"><span class="token punctuation">&lt;/</span>p</span><span
                    class="token punctuation">&gt;</span></span>
@endsection</code></pre>
<p>В этом примере в <code>sidebar</code> разделе используется <code>@parent</code> директива для добавления (а не
    перезаписи) содержимого на боковую панель макета. <code>@parent</code> Директива будет заменено на содержимое макета
   , когда представление визуализируется.</p>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>В отличие от предыдущего примера, этот <code>sidebar</code> раздел заканчивается <code>@endsection</code> вместо
            <code>@show</code>. <code>@endsection</code> Директива будет определять только раздел в то время как <code>@show</code> будет
            определять и <strong>сразу выход</strong> из этой секции.</p></p></div>
</blockquote>
<p><code>@yield</code> Директива также принимает значение по умолчанию, в качестве второго параметра. Это значение будет
    отображено, если получаемый раздел не определен:</p>
<pre class=" language-php"><code class=" language-php">@<span class="token keyword">yield</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'content'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Default content'</span><span
                class="token punctuation">)</span></code></pre>
<p></p>
<h2 id="forms"><a href="#forms">Формы</a></h2>
<p></p>
<h3 id="csrf-field"><a href="#csrf-field">CSRF поле</a></h3>
<p>Каждый раз, когда вы определяете HTML-форму в своем приложении, вы должны включать в форму скрытое поле токена <a
            href="csrf">CSRF, чтобы</a> промежуточное ПО <a href="csrf">защиты CSRF</a> могло проверить запрос. Вы
    можете использовать <code>@csrf</code> директиву Blade для создания поля токена:</p>
<pre class=" language-html"><code class=" language-html"><span class="token tag"><span class="token tag"><span
                        class="token punctuation">&lt;</span>form</span> <span
                    class="token attr-name">method</span><span class="token attr-value"><span
                        class="token punctuation attr-equals">=</span><span class="token punctuation">"</span>POST<span
                        class="token punctuation">"</span></span> <span class="token attr-name">action</span><span
                    class="token attr-value"><span class="token punctuation attr-equals">=</span><span
                        class="token punctuation">"</span>/profile<span class="token punctuation">"</span></span><span
                    class="token punctuation">&gt;</span></span>
    @csrf

   ...
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>form</span><span
            class="token punctuation">&gt;</span></span></code></pre>
<p></p>
<h3 id="method-field"><a href="#method-field">Поле метода</a></h3>
<p>Поскольку HTML-формы не могут создавать <code>PUT</code>, <code>PATCH</code> или <code>DELETE</code> запросы, вам нужно
    будет добавить скрытое <code>_method</code> поле для имитации этих HTTP-глаголов. <code>@method</code> Директива
    клинка может создать это поле для Вас:</p>
<pre class=" language-html"><code class=" language-html"><span class="token tag"><span class="token tag"><span
                        class="token punctuation">&lt;</span>form</span> <span
                    class="token attr-name">action</span><span class="token attr-value"><span
                        class="token punctuation attr-equals">=</span><span
                        class="token punctuation">"</span>/foo/bar<span class="token punctuation">"</span></span> <span
                    class="token attr-name">method</span><span class="token attr-value"><span
                        class="token punctuation attr-equals">=</span><span class="token punctuation">"</span>POST<span
                        class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span>
    @method('PUT')

   ...
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>form</span><span
            class="token punctuation">&gt;</span></span></code></pre>
<p></p>
<h3 id="validation-errors"><a href="#validation-errors">Ошибки валидации</a></h3>
<p><code>@error</code> Директива может использоваться, чтобы быстро проверить, <a
            href="validation#quick-displaying-the-validation-errors">сообщения об ошибках проверок</a> существуют для
    данного атрибута. Внутри <code>@error</code> директивы вы можете повторить <code>$message</code> переменную, чтобы
    отобразить сообщение об ошибке:</p>
<pre class=" language-html"><code class=" language-html"><span class="token comment">&lt;!-- /resources/views/post/create.blade.php --&gt;</span>

<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>label</span> <span
            class="token attr-name">for</span><span class="token attr-value"><span
                class="token punctuation attr-equals">=</span><span class="token punctuation">"</span>title<span
                class="token punctuation">"</span></span><span
            class="token punctuation">&gt;</span></span>Post Title<span class="token tag"><span class="token tag"><span
                        class="token punctuation">&lt;/</span>label</span><span
                    class="token punctuation">&gt;</span></span>

<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>input</span> <span
            class="token attr-name">id</span><span class="token attr-value"><span class="token punctuation attr-equals">=</span><span
                class="token punctuation">"</span>title<span class="token punctuation">"</span></span> <span
            class="token attr-name">type</span><span class="token attr-value"><span
                class="token punctuation attr-equals">=</span><span class="token punctuation">"</span>text<span
                class="token punctuation">"</span></span> <span class="token attr-name">class</span><span
            class="token attr-value"><span class="token punctuation attr-equals">=</span><span
                class="token punctuation">"</span>@error(<span class="token punctuation">'</span>title<span
                class="token punctuation">'</span>) is-invalid @enderror<span
                class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span>

@error('title')
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>div</span> <span
                class="token attr-name">class</span><span class="token attr-value"><span
                    class="token punctuation attr-equals">=</span><span class="token punctuation">"</span>alert alert-danger<span
                    class="token punctuation">"</span></span><span
                class="token punctuation">&gt;</span></span>{literal}{{ $message }}{/literal}<span class="token tag"><span
                    class="token tag"><span class="token punctuation">&lt;/</span>div</span><span
                    class="token punctuation">&gt;</span></span>
@enderror</code></pre>
<p>Вы можете передать <a href="validation#named-error-bags">имя конкретного пакета ошибок</a> в качестве второго
    параметра <code>@error</code> директиве для получения сообщений об ошибках проверки на страницах, содержащих
    несколько форм:</p>
<pre class=" language-html"><code class=" language-html"><span class="token comment">&lt;!-- /resources/views/auth.blade.php --&gt;</span>

<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>label</span> <span
            class="token attr-name">for</span><span class="token attr-value"><span
                class="token punctuation attr-equals">=</span><span class="token punctuation">"</span>email<span
                class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span>Email address<span
                class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>label</span><span
                    class="token punctuation">&gt;</span></span>

<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>input</span> <span
            class="token attr-name">id</span><span class="token attr-value"><span class="token punctuation attr-equals">=</span><span
                class="token punctuation">"</span>email<span class="token punctuation">"</span></span> <span
            class="token attr-name">type</span><span class="token attr-value"><span
                class="token punctuation attr-equals">=</span><span class="token punctuation">"</span>email<span
                class="token punctuation">"</span></span> <span class="token attr-name">class</span><span
            class="token attr-value"><span class="token punctuation attr-equals">=</span><span
                class="token punctuation">"</span>@error(<span class="token punctuation">'</span>email<span
                class="token punctuation">'</span>, <span class="token punctuation">'</span>login<span
                class="token punctuation">'</span>) is-invalid @enderror<span
                class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span>

@error('email', 'login')
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>div</span> <span
                class="token attr-name">class</span><span class="token attr-value"><span
                    class="token punctuation attr-equals">=</span><span class="token punctuation">"</span>alert alert-danger<span
                    class="token punctuation">"</span></span><span
                class="token punctuation">&gt;</span></span>{literal}{{ $message }}{/literal}<span class="token tag"><span
                    class="token tag"><span class="token punctuation">&lt;/</span>div</span><span
                    class="token punctuation">&gt;</span></span>
@enderror</code></pre>
<p></p>
<h3 id="raw-php"><a href="#raw-php">Необработанный PHP</a></h3>
<p>В некоторых ситуациях полезно встраивать PHP-код в ваши представления. Вы можете использовать <code>@php</code> директиву
    Blade для выполнения блока простого PHP в вашем шаблоне:</p>
<pre class=" language-php"><code class=" language-php">@php
    <span class="token variable">$counter</span> <span class="token operator">=</span> <span
                class="token number">1</span><span class="token punctuation">;</span>
@endphp</code></pre>
<p></p>
<h2 id="components"><a href="#components">Составные части</a></h2>
<p>Компоненты и слоты предоставляют те же преимущества, что и разделы, макеты и включает; однако некоторым может быть
    легче понять мысленную модель компонентов и слотов. Есть два подхода к написанию компонентов: компоненты на основе
    классов и анонимные компоненты.</p>
<p>Чтобы создать компонент на основе класса, вы можете использовать команду <code>make:component</code> Artisan. Чтобы
    проиллюстрировать, как использовать компоненты, мы создадим простой <code>Alert</code> компонент. Команда <code>make:component</code> поместит
    компонент в <code>App\View\Components</code> каталог:</p>
<pre class=" language-php"><code class=" language-php">php artisan make<span class="token punctuation">:</span>component Alert</code></pre>
<p>Команда <code>make:component</code> также создаст шаблон представления для компонента. Представление будет помещено в
    <code>resources/views/components</code> каталог. При написании компонентов для вашего собственного приложения
    компоненты автоматически обнаруживаются в <code>app/View/Components</code> каталоге и <code>resources/views/components</code> каталоге,
    поэтому дополнительная регистрация компонентов обычно не требуется.</p>
<p>Вы также можете создавать компоненты в подкаталогах:</p>
<pre class=" language-php"><code class=" language-php">php artisan make<span class="token punctuation">:</span>component Forms<span
                class="token operator">/</span>Input</code></pre>
<p>Приведенная выше команда создаст <code>Input</code> компонент в <code>App\View\Components\Forms</code> каталоге, и
    представление будет помещено в <code>resources/views/components/forms</code> каталог.</p>
<p></p>
<h4 id="manually-registering-package-components"><a href="#manually-registering-package-components">Ручная регистрация
        компонентов пакета</a></h4>
<p>При написании компонентов для вашего собственного приложения компоненты автоматически обнаруживаются в <code>app/View/Components</code> каталоге
    и <code>resources/views/components</code> каталоге.</p>
<p>Однако, если вы создаете пакет, который использует компоненты Blade, вам необходимо вручную зарегистрировать класс
    компонента и его псевдоним HTML-тега. Обычно вы должны регистрировать свои компоненты в <code>boot</code> методе
    поставщика услуг вашего пакета:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Blade</span><span
                class="token punctuation">;</span>

<span class="token comment">/**
 * Bootstrap your package's services.
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">boot</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    Blade<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">component</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'package-alert'</span><span class="token punctuation">,</span> Alert<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>После того, как ваш компонент был зарегистрирован, он может отображаться с использованием псевдонима тега:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>x<span
                class="token operator">-</span>package<span class="token operator">-</span>alert<span
                class="token operator">/</span><span class="token operator">&gt;</span></code></pre>
<p>В качестве альтернативы вы можете использовать этот <code>componentNamespace</code> метод для автоматической загрузки
    классов компонентов по соглашению. Например, <code>Nightshade</code> пакет может иметь <code>Calendar</code> и <code>ColorPicker</code> компоненты
   , которые находятся в <code>Package\Views\Components</code> пространстве имен:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Blade</span><span
                class="token punctuation">;</span>

<span class="token comment">/**
 * Bootstrap your package's services.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">boot</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    Blade<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">componentNamespace</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'Nightshade\\Views\\Components'</span><span class="token punctuation">,</span> <span class="token single-quoted-string string">'nightshade'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Это позволит использовать компоненты пакета в пространстве имен их поставщиков, используя <code>package-name::</code> синтаксис:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>x<span
                class="token operator">-</span>nightshade<span class="token punctuation">:</span><span
                class="token punctuation">:</span>calendar <span class="token operator">/</span><span
                class="token operator">&gt;</span>
<span class="token operator">&lt;</span>x<span class="token operator">-</span>nightshade<span class="token punctuation">:</span><span
                class="token punctuation">:</span>color<span class="token operator">-</span>picker <span
                class="token operator">/</span><span class="token operator">&gt;</span></code></pre>
<p>Blade автоматически обнаружит класс, связанный с этим компонентом, заключив имя компонента в паскаль. Подкаталоги
    также поддерживаются с использованием "точечной" нотации.</p>
<p></p>
<h3 id="rendering-components"><a href="#rendering-components">Компоненты рендеринга</a></h3>
<p>Для отображения компонента вы можете использовать тег компонента Blade в одном из ваших шаблонов Blade. Теги
    компонентов Blade начинаются со строки, <code>x-</code> за которой следует имя кебаба класса компонента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>x<span
                class="token operator">-</span>alert<span class="token operator">/</span><span class="token operator">&gt;</span>

<span class="token operator">&lt;</span>x<span class="token operator">-</span>user<span class="token operator">-</span>profile<span
                class="token operator">/</span><span class="token operator">&gt;</span></code></pre>
<p>Если класс компонента вложен глубже в <code>App\View\Components</code> каталог, вы можете использовать этот
    <code>.</code> символ для обозначения вложенности каталога. Например, если мы предполагаем, что компонент расположен
    в <code>App\View\Components\Inputs\Button.php</code>, мы можем отобразить его так:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>x<span
                class="token operator">-</span>inputs<span class="token punctuation">.</span>button<span
                class="token operator">/</span><span class="token operator">&gt;</span></code></pre>
<p></p>
<h3 id="passing-data-to-components"><a href="#passing-data-to-components">Передача данных в компоненты</a></h3>
<p>Вы можете передавать данные в компоненты Blade, используя атрибуты HTML. Жестко запрограммированные примитивные
    значения могут быть переданы компоненту с помощью простых строк атрибутов HTML. Выражения и переменные PHP должны
    быть переданы компоненту через атрибуты, которые используют <code>:</code> символ в качестве префикса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>x<span
                class="token operator">-</span>alert type<span class="token operator">=</span><span
                class="token double-quoted-string string">"error"</span> <span class="token punctuation">:</span>message<span
                class="token operator">=</span><span class="token double-quoted-string string">"<span
                    class="token interpolation"><span class="token variable">$message</span></span>"</span><span
                class="token operator">/</span><span class="token operator">&gt;</span></code></pre>
<p>Вы должны определить необходимые данные компонента в его конструкторе класса. Все общедоступные свойства компонента
    будут автоматически доступны в представлении компонента. Нет необходимости передавать данные в представление из
    <code>render</code> метода компонента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>View<span
                        class="token punctuation">\</span>Components</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>View<span
                        class="token punctuation">\</span>Component</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">Alert</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Component</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * The alert type.
    *
    * @var string
    */</span>
    <span class="token keyword">public</span> <span class="token variable">$type</span><span class="token punctuation">;</span>

    <span class="token comment">/**
    * The alert message.
    *
    * @var string
    */</span>
    <span class="token keyword">public</span> <span class="token variable">$message</span><span class="token punctuation">;</span>

    <span class="token comment">/**
    * Create the component instance.
    *
    * @param  string  $type
    * @param  string  $message
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">__construct</span><span class="token punctuation">(</span><span class="token variable">$type</span><span class="token punctuation">,</span> <span class="token variable">$message</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">type</span> <span class="token operator">=</span> <span class="token variable">$type</span><span class="token punctuation">;</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">message</span> <span class="token operator">=</span> <span class="token variable">$message</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
    * Get the view / contents that represent the component.
    *
    * @return \Illuminate\View\View|\Closure|string
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">render</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token function">view</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'components.alert'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Когда ваш компонент визуализируется, вы можете отображать содержимое общедоступных переменных вашего компонента,
    повторяя переменные по имени:</p>
<pre class=" language-html"><code class=" language-html"><span class="token tag"><span class="token tag"><span
                        class="token punctuation">&lt;</span>div</span> <span class="token attr-name">class</span><span
                    class="token attr-value"><span class="token punctuation attr-equals">=</span><span
                        class="token punctuation">"</span>alert alert-{literal}{{ $type }}{/literal}<span
                        class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span>
    {literal}{{ $message }}{/literal}
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>div</span><span
            class="token punctuation">&gt;</span></span></code></pre>
<p></p>
<h4 id="casing"><a href="#casing">Кожух</a></h4>
<p>Аргументы конструктора компонентов должны быть указаны с помощью <code>camelCase</code>, а <code>kebab-case</code> должны
    использоваться при ссылке на имена аргументов в ваших атрибутах HTML. Например, учитывая следующий конструктор
    компонента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Create the component instance.
 *
 * @param  string  $alertType
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">__construct</span><span
                class="token punctuation">(</span><span class="token variable">$alertType</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">alertType</span> <span class="token operator">=</span> <span class="token variable">$alertType</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p><code>$alertType</code> Аргумент может быть предусмотрен для компонента, как так:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>x<span
                class="token operator">-</span>alert alert<span class="token operator">-</span>type<span
                class="token operator">=</span><span class="token double-quoted-string string">"danger"</span> <span
                class="token operator">/</span><span class="token operator">&gt;</span></code></pre>
<p></p>
<h4 id="escaping-attribute-rendering"><a href="#escaping-attribute-rendering">Экранирование отрисовки атрибутов</a></h4>
<p>Так как некоторые фреймворки JavaScript, такие как Alpine.js, также используют атрибуты с префиксом двоеточия, вы
    можете использовать <code>::</code> префикс с двойным двоеточием ( ), чтобы сообщить Blade, что атрибут не является
    выражением PHP. Например, учитывая следующий компонент:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>x<span
                class="token operator">-</span>button <span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token operator">=</span><span
                class="token double-quoted-string string">"{ danger: isDeleting }"</span><span class="token operator">&gt;</span>
    Submit
<span class="token operator">&lt;</span><span class="token operator">/</span>x<span class="token operator">-</span>button<span
                class="token operator">&gt;</span></code></pre>
<p>Blade отобразит следующий HTML-код:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>button <span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token operator">=</span><span
                class="token double-quoted-string string">"{ danger: isDeleting }"</span><span class="token operator">&gt;</span>
    Submit
<span class="token operator">&lt;</span><span class="token operator">/</span>button<span
                class="token operator">&gt;</span></code></pre>
<p></p>
<h4 id="component-methods"><a href="#component-methods">Компонентные методы</a></h4>
<p>В дополнение к общедоступным переменным, доступным для вашего шаблона компонента, могут быть вызваны любые
    общедоступные методы компонента. Например, представьте компонент, у которого есть <code>isSelected</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Determine if the given option is the currently selected option.
 *
 * @param  string  $option
 * @return bool
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">isSelected</span><span
                class="token punctuation">(</span><span class="token variable">$option</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$option</span> <span class="token operator">===</span> <span class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">selected</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Вы можете выполнить этот метод из своего шаблона компонента, вызвав переменную, соответствующую имени метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>option <span
                class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">{literal}{{/literal}</span> <span class="token variable">$isSelected</span><span class="token punctuation">(</span><span class="token variable">$value</span><span class="token punctuation">)</span> <span class="token operator">?</span> <span class="token single-quoted-string string">'selected="selected"'</span> <span class="token punctuation">:</span> <span class="token single-quoted-string string">''</span> <span class="token punctuation">}</span><span class="token punctuation">}</span> value<span
                class="token operator">=</span><span
                class="token double-quoted-string string">"{literal}{{{/literal} <span class="token interpolation"><span class="token variable">{literal}$value{/literal}</span></span> }}"</span><span
                class="token operator">&gt;</span>
    <span class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">{literal}{{/literal}</span> <span class="token variable">$label</span> <span class="token punctuation">}</span><span class="token punctuation">}</span>
<span class="token operator">&lt;</span><span class="token operator">/</span>option<span
                class="token operator">&gt;</span></code></pre>
<p></p>
<h4 id="using-attributes-slots-within-component-class"><a href="#using-attributes-slots-within-component-class">Доступ к
        атрибутам и слотам в классах компонентов</a></h4>
<p>Компоненты Blade также позволяют получить доступ к имени компонента, атрибутам и слоту внутри метода рендеринга
    класса. Однако, чтобы получить доступ к этим данным, вы должны вернуть закрытие из <code>render</code> метода вашего
    компонента. Замыкание получит <code>$data</code> массив как единственный аргумент. Этот массив будет содержать
    несколько элементов, предоставляющих информацию о компоненте:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the view / contents that represent the component.
 *
 * @return \Illuminate\View\View|\Closure|string
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">render</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token keyword">array</span> <span class="token variable">$data</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">// $data['componentName'];</span>
        <span class="token comment">// $data['attributes'];</span>
        <span class="token comment">// $data['slot'];</span>

        <span class="token keyword">return</span> <span class="token single-quoted-string string">'&lt;div&gt;Components content&lt;/div&gt;'</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p><code>componentName</code> Равно имя, используемое в HTML - тег после <code>x-</code> префикса. Так <code>componentName</code> для <code>&lt;x-alert /&gt;</code> будет <code>alert</code>. Элемент <code>attributes</code> будет
    содержать все атрибуты, которые присутствовали на HTML теге. Элемент <code>slot</code> представляет собой <code>Illuminate\Support\HtmlString</code> экземпляр
    с содержимым слота компонента.</p>
<p>Замыкание должно возвращать строку. Если возвращенная строка соответствует существующему представлению, это
    представление будет визуализировано; в противном случае возвращенная строка будет оцениваться как встроенное
    представление Blade.</p>
<p></p>
<h4 id="additional-dependencies"><a href="#additional-dependencies">Дополнительные зависимости</a></h4>
<p>Если вашему компоненту требуются зависимости от <a href="container">сервисного контейнера</a> Laravel, вы можете
    перечислить их перед любыми атрибутами данных компонента, и они будут автоматически введены контейнером:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Services<span
                    class="token punctuation">\</span>AlertCreator</span>

<span class="token comment">/**
 * Create the component instance.
 *
 * @param  \App\Services\AlertCreator  $creator
 * @param  string  $type
 * @param  string  $message
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">__construct</span><span
                class="token punctuation">(</span>AlertCreator <span class="token variable">$creator</span><span
                class="token punctuation">,</span> <span class="token variable">$type</span><span
                class="token punctuation">,</span> <span class="token variable">$message</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">creator</span> <span class="token operator">=</span> <span class="token variable">$creator</span><span class="token punctuation">;</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">type</span> <span class="token operator">=</span> <span class="token variable">$type</span><span class="token punctuation">;</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">message</span> <span class="token operator">=</span> <span class="token variable">$message</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="component-attributes"><a href="#component-attributes">Компонент Атрибуты</a></h3>
<p>Мы уже рассмотрели, как передавать атрибуты данных в компонент; однако иногда может потребоваться указать
    дополнительные атрибуты HTML, например <code>class</code>, которые не являются частью данных, необходимых для
    функционирования компонента. Как правило, вы хотите передать эти дополнительные атрибуты корневому элементу шаблона
    компонента. Например, представьте, что мы хотим визуализировать такой <code>alert</code> компонент:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>x<span
                class="token operator">-</span>alert type<span class="token operator">=</span><span
                class="token double-quoted-string string">"error"</span> <span class="token punctuation">:</span>message<span
                class="token operator">=</span><span class="token double-quoted-string string">"<span
                    class="token interpolation"><span class="token variable">$message</span></span>"</span> <span
                class="token keyword">class</span><span class="token operator">=</span><span
                class="token double-quoted-string string">"mt-4"</span><span class="token operator">/</span><span
                class="token operator">&gt;</span></code></pre>
<p>Все атрибуты, которые не являются частью конструктора компонента, будут автоматически добавлены в «мешок атрибутов»
    компонента. Этот набор атрибутов автоматически становится доступным для компонента через <code>$attributes</code> переменную.
    Все атрибуты могут отображаться в компоненте путем повторения этой переменной:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>div <span
                class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">{literal}{{/literal}</span> <span class="token variable">$attributes</span> <span class="token punctuation">}</span><span class="token punctuation">}</span><span
                class="token operator">&gt;</span>
    <span class="token operator">&lt;</span><span class="token operator">!</span><span class="token operator">--</span> Component content <span
                class="token operator">--</span><span class="token operator">&gt;</span>
<span class="token operator">&lt;</span><span class="token operator">/</span>div<span class="token operator">&gt;</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Использование директив, таких как <code>@env</code> внутри тегов компонентов, в настоящее время не
            поддерживается. Например, <code>&lt;x-alert:live="@env('production')"/&gt;</code> не будет компилироваться.
        </p></p></div>
</blockquote>
<p></p>
<h4 id="default-merged-attributes"><a href="#default-merged-attributes">Атрибуты по умолчанию / объединенные
        атрибуты</a></h4>
<p>Иногда вам может потребоваться указать значения по умолчанию для атрибутов или добавить дополнительные значения в
    некоторые атрибуты компонента. Для этого вы можете использовать метод атрибута bag <code>merge</code>. Этот метод
    особенно полезен для определения набора классов CSS по умолчанию, которые всегда должны применяться к компоненту:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>div <span
                class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">{literal}{{/literal}</span> <span class="token variable">$attributes</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">merge</span><span class="token punctuation">(</span><span class="token punctuation">[</span><span class="token single-quoted-string string">'class'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token single-quoted-string string">'alert alert-'</span><span class="token punctuation">.</span><span class="token variable">$type</span><span class="token punctuation">]</span><span class="token punctuation">)</span> <span class="token punctuation">}</span><span class="token punctuation">}</span><span
                class="token operator">&gt;</span>
    <span class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">{literal}{{/literal}</span> <span class="token variable">$message</span> <span class="token punctuation">}</span><span class="token punctuation">}</span>
<span class="token operator">&lt;</span><span class="token operator">/</span>div<span class="token operator">&gt;</span></code></pre>
<p>Если предположить, что этот компонент используется так:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>x<span
                class="token operator">-</span>alert type<span class="token operator">=</span><span
                class="token double-quoted-string string">"error"</span> <span class="token punctuation">:</span>message<span
                class="token operator">=</span><span class="token double-quoted-string string">"<span
                    class="token interpolation"><span class="token variable">$message</span></span>"</span> <span
                class="token keyword">class</span><span class="token operator">=</span><span
                class="token double-quoted-string string">"mb-4"</span><span class="token operator">/</span><span
                class="token operator">&gt;</span></code></pre>
<p>Окончательный обработанный HTML-код компонента будет выглядеть следующим образом:</p>
<pre class=" language-html"><code class=" language-html"><span class="token tag"><span class="token tag"><span
                        class="token punctuation">&lt;</span>div</span> <span class="token attr-name">class</span><span
                    class="token attr-value"><span class="token punctuation attr-equals">=</span><span
                        class="token punctuation">"</span>alert alert-error mb-4<span class="token punctuation">"</span></span><span
                    class="token punctuation">&gt;</span></span>
    <span class="token comment">&lt;!-- Contents of the $message variable --&gt;</span>
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>div</span><span
            class="token punctuation">&gt;</span></span></code></pre>
<p></p>
<h4 id="conditionally-merge-classes"><a href="#conditionally-merge-classes">Условно объединить классы</a></h4>
<p>Иногда вы можете захотеть объединить классы, если есть заданное условие <code>true</code>. Вы можете выполнить это с
    помощью <code>class</code> метода, который принимает массив классов, где ключ массива содержит класс или классы,
    которые вы хотите добавить, а значение является логическим выражением. Если элемент массива имеет числовой ключ, он
    всегда будет включен в отображаемый список классов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>div <span
                class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">{literal}{{/literal}</span> <span class="token variable">$attributes</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token keyword">class</span><span class="token punctuation">(</span><span class="token punctuation">[</span><span class="token single-quoted-string string">'p-4'</span><span class="token punctuation">,</span> <span class="token single-quoted-string string">'bg-red'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token variable">$hasError</span><span class="token punctuation">]</span><span class="token punctuation">)</span> <span class="token punctuation">}</span><span class="token punctuation">}</span><span
                class="token operator">&gt;</span>
    <span class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">{literal}{{/literal}</span> <span class="token variable">$message</span> <span class="token punctuation">}</span><span class="token punctuation">}</span>
<span class="token operator">&lt;</span><span class="token operator">/</span>div<span class="token operator">&gt;</span></code></pre>
<p>Если вам нужно объединить другие атрибуты в свой компонент, вы можете связать <code>merge</code> метод с
    <code>class</code> методом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>button <span
                class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">{literal}{{/literal}</span> <span class="token variable">$attributes</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token keyword">class</span><span class="token punctuation">(</span><span class="token punctuation">[</span><span class="token single-quoted-string string">'p-4'</span><span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">merge</span><span class="token punctuation">(</span><span class="token punctuation">[</span><span class="token single-quoted-string string">'type'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token single-quoted-string string">'button'</span><span class="token punctuation">]</span><span class="token punctuation">)</span> <span class="token punctuation">}</span><span class="token punctuation">}</span><span
                class="token operator">&gt;</span>
    <span class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">{literal}{{/literal}</span> <span class="token variable">$slot</span> <span class="token punctuation">}</span><span class="token punctuation">}</span>
<span class="token operator">&lt;</span><span class="token operator">/</span>button<span
                class="token operator">&gt;</span></code></pre>
<p></p>
<h4 id="non-class-attribute-merging"><a href="#non-class-attribute-merging">Слияние неклассовых атрибутов</a></h4>
<p>При объединении атрибутов, которые не являются <code>class</code> атрибутами, значения, предоставленные
    <code>merge</code> методу, будут считаться значениями "по умолчанию" атрибута. Однако, в отличие от
    <code>class</code> атрибута, эти атрибуты не будут объединены с введенными значениями атрибутов. Вместо этого они
    будут перезаписаны. Например, реализация <code>button</code> компонента может выглядеть следующим образом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>button <span
                class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">{literal}{{/literal}</span> <span class="token variable">$attributes</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">merge</span><span class="token punctuation">(</span><span class="token punctuation">[</span><span class="token single-quoted-string string">'type'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token single-quoted-string string">'button'</span><span class="token punctuation">]</span><span class="token punctuation">)</span> <span class="token punctuation">}</span><span class="token punctuation">}</span><span
                class="token operator">&gt;</span>
    <span class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">{literal}{{/literal}</span> <span class="token variable">$slot</span> <span class="token punctuation">}</span><span class="token punctuation">}</span>
<span class="token operator">&lt;</span><span class="token operator">/</span>button<span
                class="token operator">&gt;</span></code></pre>
<p>Чтобы отобразить компонент кнопки с помощью пользовательского интерфейса <code>type</code>, его можно указать при
    использовании компонента. Если тип не указан, <code>button</code> будет использоваться тип:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>x<span
                class="token operator">-</span>button type<span class="token operator">=</span><span
                class="token double-quoted-string string">"submit"</span><span class="token operator">&gt;</span>
    Submit
<span class="token operator">&lt;</span><span class="token operator">/</span>x<span class="token operator">-</span>button<span
                class="token operator">&gt;</span></code></pre>
<p>Отрендеренный HTML-код <code>button</code> компонента в этом примере будет:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>button type<span
                class="token operator">=</span><span class="token double-quoted-string string">"submit"</span><span
                class="token operator">&gt;</span>
    Submit
<span class="token operator">&lt;</span><span class="token operator">/</span>button<span
                class="token operator">&gt;</span></code></pre>
<p>Если вы хотите, чтобы атрибут, отличный от значения <code>class</code> по умолчанию и введенных значений, были
    объединены вместе, вы можете использовать этот <code>prepends</code> метод. В этом примере
    <code>data-controller</code> атрибут всегда будет начинаться с, <code>profile-controller</code> а любые дополнительные
    введенные <code>data-controller</code> значения будут помещены после этого значения по умолчанию:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>div <span
                class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">{literal}{{/literal}</span> <span class="token variable">$attributes</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">merge</span><span class="token punctuation">(</span><span class="token punctuation">[</span><span class="token single-quoted-string string">'data-controller'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token variable">$attributes</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">prepends</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'profile-controller'</span><span class="token punctuation">)</span><span class="token punctuation">]</span><span class="token punctuation">)</span> <span class="token punctuation">}</span><span class="token punctuation">}</span><span
                class="token operator">&gt;</span>
    <span class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">{literal}{{/literal}</span> <span class="token variable">$slot</span> <span class="token punctuation">}</span><span class="token punctuation">}</span>
<span class="token operator">&lt;</span><span class="token operator">/</span>div<span class="token operator">&gt;</span></code></pre>
<p></p>
<h4 id="filtering-attributes"><a href="#filtering-attributes">Получение и фильтрация атрибутов</a></h4>
<p>Вы можете фильтровать атрибуты с помощью этого <code>filter</code> метода. Этот метод принимает закрытие, которое
    должно возвращаться, <code>true</code> если вы хотите сохранить атрибут в сумке атрибутов:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">{literal}{{/literal}</span> <span class="token variable">$attributes</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">filter</span><span class="token punctuation">(</span>fn <span class="token punctuation">(</span><span class="token variable">$value</span><span class="token punctuation">,</span> <span class="token variable">$key</span><span class="token punctuation">)</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token variable">$key</span> <span class="token operator">==</span> <span class="token single-quoted-string string">'foo'</span><span class="token punctuation">)</span> <span class="token punctuation">}</span><span class="token punctuation">}</span></code></pre>
<p>Для удобства вы можете использовать этот <code>whereStartsWith</code> метод для получения всех атрибутов, ключи
    которых начинаются с заданной строки:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">{literal}{{/literal}</span> <span class="token variable">$attributes</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">whereStartsWith</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'wire:model'</span><span class="token punctuation">)</span> <span class="token punctuation">}</span><span class="token punctuation">}</span></code></pre>
<p>Используя этот <code>first</code> метод, вы можете отобразить первый атрибут в заданном пакете атрибутов:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">{literal}{{/literal}</span> <span class="token variable">$attributes</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">whereStartsWith</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'wire:model'</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">first</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">}</span><span class="token punctuation">}</span></code></pre>
<p>Если вы хотите проверить, присутствует ли атрибут в компоненте, вы можете использовать этот <code>has</code> метод.
    Этот метод принимает имя атрибута в качестве единственного аргумента и возвращает логическое значение, указывающее,
    присутствует ли атрибут:</p>
<pre class=" language-php"><code class=" language-php">@<span class="token keyword">if</span> <span
                class="token punctuation">(</span><span class="token variable">$attributes</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">has</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'class'</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span>
    <span class="token operator">&lt;</span>div<span class="token operator">&gt;</span><span
                class="token keyword">Class</span> attribute is present<span class="token operator">&lt;</span><span
                class="token operator">/</span>div<span class="token operator">&gt;</span>
@<span class="token keyword">endif</span></code></pre>
<p>Вы можете получить значение определенного атрибута, используя <code>get</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">{literal}{{/literal}</span> <span class="token variable">$attributes</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'class'</span><span class="token punctuation">)</span> <span class="token punctuation">}</span><span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="slots"><a href="#slots">Слоты</a></h3>
<p>Вам часто потребуется передать дополнительный контент вашему компоненту через «слоты». Слоты компонентов отображаются
    путем повторения <code>$slot</code> переменной. Чтобы изучить эту концепцию, представим, что <code>alert</code> компонент
    имеет следующую разметку:</p>
<pre class=" language-html"><code class=" language-html"><span class="token comment">&lt;!-- /resources/views/components/alert.blade.php --&gt;</span>

<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>div</span> <span
            class="token attr-name">class</span><span class="token attr-value"><span
                class="token punctuation attr-equals">=</span><span class="token punctuation">"</span>alert alert-danger<span
                class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span>
    {literal}{{ $slot }}{/literal}
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>div</span><span
            class="token punctuation">&gt;</span></span></code></pre>
<p>Мы можем передавать <code>slot</code> контент в компонент, вставляя его в компонент:</p>
<pre class=" language-html"><code class=" language-html"><span class="token tag"><span class="token tag"><span
                        class="token punctuation">&lt;</span>x-alert</span><span
                    class="token punctuation">&gt;</span></span>
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>strong</span><span
                class="token punctuation">&gt;</span></span>Whoops!<span class="token tag"><span class="token tag"><span
                        class="token punctuation">&lt;/</span>strong</span><span
                    class="token punctuation">&gt;</span></span> Something went wrong!
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>x-alert</span><span
            class="token punctuation">&gt;</span></span></code></pre>
<p>Иногда компоненту может потребоваться отобразить несколько разных слотов в разных местах внутри компонента. Давайте
    модифицируем наш компонент оповещения, чтобы учесть вставку слота «заголовок»:</p>
<pre class=" language-html"><code class=" language-html"><span class="token comment">&lt;!-- /resources/views/components/alert.blade.php --&gt;</span>

<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>span</span> <span
            class="token attr-name">class</span><span class="token attr-value"><span
                class="token punctuation attr-equals">=</span><span class="token punctuation">"</span>alert-title<span
                class="token punctuation">"</span></span><span
            class="token punctuation">&gt;</span></span>{literal}{{ $title }}{/literal}<span class="token tag"><span
                    class="token tag"><span class="token punctuation">&lt;/</span>span</span><span
                    class="token punctuation">&gt;</span></span>

<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>div</span> <span
            class="token attr-name">class</span><span class="token attr-value"><span
                class="token punctuation attr-equals">=</span><span class="token punctuation">"</span>alert alert-danger<span
                class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span>
    {literal}{{ $slot }}{/literal}
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>div</span><span
            class="token punctuation">&gt;</span></span></code></pre>
<p>Вы можете определить содержимое названного слота с помощью <code>x-slot</code> тега. Любое содержимое, не входящее в
    явный <code>x-slot</code> тег, будет передано компоненту в <code>$slot</code> переменной:</p>
<pre class=" language-html"><code class=" language-html"><span class="token tag"><span class="token tag"><span
                        class="token punctuation">&lt;</span>x-alert</span><span
                    class="token punctuation">&gt;</span></span>
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>x-slot</span> <span
                class="token attr-name">name</span><span class="token attr-value"><span
                    class="token punctuation attr-equals">=</span><span class="token punctuation">"</span>title<span
                    class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span>
        Server Error
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>x-slot</span><span
                class="token punctuation">&gt;</span></span>

    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>strong</span><span
                class="token punctuation">&gt;</span></span>Whoops!<span class="token tag"><span class="token tag"><span
                        class="token punctuation">&lt;/</span>strong</span><span
                    class="token punctuation">&gt;</span></span> Something went wrong!
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>x-alert</span><span
            class="token punctuation">&gt;</span></span></code></pre>
<p></p>
<h4 id="scoped-slots"><a href="#scoped-slots">Слоты с ограниченным доступом</a></h4>
<p>Если вы использовали платформу JavaScript, такую как Vue, вы, возможно, знакомы с «слотами с заданной областью»,
    которые позволяют получать доступ к данным или методам из компонента в вашем слоте. Вы можете добиться аналогичного
    поведения в Laravel, определив общедоступные методы или свойства в вашем компоненте и получив доступ к компоненту в
    вашем слоте через <code>$component</code> переменную. В этом примере мы предположим, что <code>x-alert</code> компонент
    имеет открытый <code>formatAlert</code> метод, определенный в его классе компонента:</p>
<pre class=" language-html"><code class=" language-html"><span class="token tag"><span class="token tag"><span
                        class="token punctuation">&lt;</span>x-alert</span><span
                    class="token punctuation">&gt;</span></span>
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>x-slot</span> <span
                class="token attr-name">name</span><span class="token attr-value"><span
                    class="token punctuation attr-equals">=</span><span class="token punctuation">"</span>title<span
                    class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span>
        {literal}{{{/literal} $component-&gt;formatAlert('Server Error') }}
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>x-slot</span><span
                class="token punctuation">&gt;</span></span>

    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>strong</span><span
                class="token punctuation">&gt;</span></span>Whoops!<span class="token tag"><span class="token tag"><span
                        class="token punctuation">&lt;/</span>strong</span><span
                    class="token punctuation">&gt;</span></span> Something went wrong!
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>x-alert</span><span
            class="token punctuation">&gt;</span></span></code></pre>
<p></p>
<h3 id="inline-component-views"><a href="#inline-component-views">Встроенные представления компонентов</a></h3>
<p>Для очень маленьких компонентов может показаться обременительным управлять как классом компонента, так и шаблоном
    представления компонента. По этой причине вы можете вернуть разметку компонента прямо из <code>render</code> метода:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the view / contents that represent the component.
 *
 * @return \Illuminate\View\View|\Closure|string
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">render</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token operator">&lt;</span><span class="token operator">&lt;</span><span class="token operator">&lt;</span><span class="token single-quoted-string string">'blade'</span>
    <span class="token operator">&lt;</span>div <span class="token keyword">class</span><span class="token operator">=</span><span class="token double-quoted-string string">"alert alert-danger"</span><span class="token operator">&gt;</span>
    <span class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">{literal}{{/literal}</span> <span class="token variable">$slot</span> <span class="token punctuation">}</span><span class="token punctuation">}</span>
    <span class="token operator">&lt;</span><span class="token operator">/</span>div<span class="token operator">&gt;</span>
    blade<span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="generating-inline-view-components"><a href="#generating-inline-view-components">Создание компонентов встроенного
        представления</a></h4>
<p>Чтобы создать компонент, который отображает встроенное представление, вы можете использовать <code>inline</code> параметр
    при выполнении <code>make:component</code> команды:</p>
<pre class=" language-php"><code class=" language-php">php artisan make<span class="token punctuation">:</span>component Alert <span
                class="token operator">--</span>inline</code></pre>
<p></p>
<h3 id="anonymous-components"><a href="#anonymous-components">Анонимные компоненты</a></h3>
<p>Подобно встроенным компонентам, анонимные компоненты предоставляют механизм для управления компонентом через один
    файл. Однако анонимные компоненты используют один файл представления и не имеют связанного класса. Чтобы определить
    анонимный компонент, вам нужно только разместить шаблон Blade в вашем <code>resources/views/components</code> каталоге.
    Например, если вы определили компонент в <code>resources/views/components/alert.blade.php</code>, вы можете просто
    визуализировать его так:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>x<span
                class="token operator">-</span>alert<span class="token operator">/</span><span class="token operator">&gt;</span></code></pre>
<p>Вы можете использовать этот <code>.</code> символ, чтобы указать, вложен ли компонент глубже в <code>components</code> каталог.
    Например, предполагая, что компонент определен в <code>resources/views/components/inputs/button.blade.php</code>, вы
    можете отобразить его так:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>x<span
                class="token operator">-</span>inputs<span class="token punctuation">.</span>button<span
                class="token operator">/</span><span class="token operator">&gt;</span></code></pre>
<p></p>
<h4 id="data-properties-attributes"><a href="#data-properties-attributes">Свойства / атрибуты данных</a></h4>
<p>Поскольку анонимные компоненты не имеют ассоциированного класса, вы можете задаться вопросом, как можно различить,
    какие данные должны быть переданы компоненту как переменные, а какие атрибуты должны быть помещены в <a
            href="blade#component-attributes">сумку атрибутов</a> компонента.</p>
<p>Вы можете указать, какие атрибуты следует рассматривать как переменные данных, используя <code>@props</code> директиву
    в верхней части шаблона Blade вашего компонента. Все остальные атрибуты компонента будут доступны через мешок
    атрибутов компонента. Если вы хотите присвоить переменной данных значение по умолчанию, вы можете указать имя
    переменной как ключ массива и значение по умолчанию как значение массива:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span><span
                class="token operator">!</span><span class="token operator">--</span> <span
                class="token operator">/</span>resources<span class="token operator">/</span>views<span
                class="token operator">/</span>components<span class="token operator">/</span>alert<span
                class="token punctuation">.</span>blade<span class="token punctuation">.</span>php <span
                class="token operator">--</span><span class="token operator">&gt;</span>

@<span class="token function">props</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'type'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'info'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'message'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span>

<span class="token operator">&lt;</span>div <span
                class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">{literal}{{/literal}</span> <span class="token variable">$attributes</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">merge</span><span class="token punctuation">(</span><span class="token punctuation">[</span><span class="token single-quoted-string string">'class'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token single-quoted-string string">'alert alert-'</span><span class="token punctuation">.</span><span class="token variable">$type</span><span class="token punctuation">]</span><span class="token punctuation">)</span> <span class="token punctuation">}</span><span class="token punctuation">}</span><span
                class="token operator">&gt;</span>
    <span class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">{literal}{{/literal}</span> <span class="token variable">$message</span> <span class="token punctuation">}</span><span class="token punctuation">}</span>
<span class="token operator">&lt;</span><span class="token operator">/</span>div<span class="token operator">&gt;</span></code></pre>
<p>Учитывая приведенное выше определение компонента, мы можем визуализировать компонент следующим образом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>x<span
                class="token operator">-</span>alert type<span class="token operator">=</span><span
                class="token double-quoted-string string">"error"</span> <span class="token punctuation">:</span>message<span
                class="token operator">=</span><span class="token double-quoted-string string">"<span
                    class="token interpolation"><span class="token variable">$message</span></span>"</span> <span
                class="token keyword">class</span><span class="token operator">=</span><span
                class="token double-quoted-string string">"mb-4"</span><span class="token operator">/</span><span
                class="token operator">&gt;</span></code></pre>
<p></p>
<h3 id="dynamic-components"><a href="#dynamic-components">Динамические компоненты</a></h3>
<p>Иногда вам может потребоваться визуализировать компонент, но вы не знаете, какой компонент следует визуализировать,
    до времени выполнения. В этой ситуации вы можете использовать встроенный <code>dynamic-component</code> компонент
    Laravel для рендеринга компонента на основе значения времени выполнения или переменной:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>x<span
                class="token operator">-</span>dynamic<span class="token operator">-</span>component <span
                class="token punctuation">:</span>component<span class="token operator">=</span><span
                class="token double-quoted-string string">"<span class="token interpolation"><span
                        class="token variable">$componentName</span></span>"</span> <span
                class="token keyword">class</span><span class="token operator">=</span><span
                class="token double-quoted-string string">"mt-4"</span> <span class="token operator">/</span><span
                class="token operator">&gt;</span></code></pre>
<p></p>
<h3 id="manually-registering-components"><a href="#manually-registering-components">Регистрация компонентов вручную</a>
</h3>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Следующая документация по ручной регистрации компонентов в первую очередь применима к тем, кто пишет пакеты
            Laravel, которые включают компоненты представления. Если вы не пишете пакет, эта часть документации
            компонента может быть вам не нужна.</p></p></div>
</blockquote>
<p>При написании компонентов для вашего собственного приложения компоненты автоматически обнаруживаются в <code>app/View/Components</code> каталоге
    и <code>resources/views/components</code> каталоге.</p>
<p>Однако, если вы создаете пакет, который использует компоненты Blade или размещаете компоненты в нетрадиционных
    каталогах, вам нужно будет вручную зарегистрировать класс компонента и его псевдоним HTML-тега, чтобы Laravel знал,
    где найти компонент. Обычно вы должны регистрировать свои компоненты в <code>boot</code> методе поставщика услуг
    вашего пакета:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Blade</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">VendorPackage<span class="token punctuation">\</span>View<span
                    class="token punctuation">\</span>Components<span
                    class="token punctuation">\</span>AlertComponent</span><span class="token punctuation">;</span>

<span class="token comment">/**
 * Bootstrap your package's services.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">boot</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    Blade<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">component</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'package-alert'</span><span class="token punctuation">,</span> AlertComponent<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>После того, как ваш компонент был зарегистрирован, он может отображаться с использованием псевдонима тега:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>x<span
                class="token operator">-</span>package<span class="token operator">-</span>alert<span
                class="token operator">/</span><span class="token operator">&gt;</span></code></pre>
<h4>Автозагрузка компонентов пакета</h4>
<p>В качестве альтернативы вы можете использовать этот <code>componentNamespace</code> метод для автоматической загрузки
    классов компонентов по соглашению. Например, <code>Nightshade</code> пакет может иметь <code>Calendar</code> и <code>ColorPicker</code> компоненты
   , которые находятся в <code>Package\Views\Components</code> пространстве имен:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Blade</span><span
                class="token punctuation">;</span>

<span class="token comment">/**
 * Bootstrap your package's services.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">boot</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    Blade<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">componentNamespace</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'Nightshade\\Views\\Components'</span><span class="token punctuation">,</span> <span class="token single-quoted-string string">'nightshade'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Это позволит использовать компоненты пакета в пространстве имен их поставщиков, используя <code>package-name::</code> синтаксис:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>x<span
                class="token operator">-</span>nightshade<span class="token punctuation">:</span><span
                class="token punctuation">:</span>calendar <span class="token operator">/</span><span
                class="token operator">&gt;</span>
<span class="token operator">&lt;</span>x<span class="token operator">-</span>nightshade<span class="token punctuation">:</span><span
                class="token punctuation">:</span>color<span class="token operator">-</span>picker <span
                class="token operator">/</span><span class="token operator">&gt;</span></code></pre>
<p>Blade автоматически обнаружит класс, связанный с этим компонентом, заключив имя компонента в паскаль. Подкаталоги
    также поддерживаются с использованием "точечной" нотации.</p>
<p></p>
<h2 id="stacks"><a href="#stacks">Стеки</a></h2>
<p>Blade позволяет вам нажимать на именованные стеки, которые могут быть отображены где-нибудь в другом виде или макете.
    Это может быть особенно полезно для указания любых библиотек JavaScript, необходимых для ваших дочерних
    представлений:</p>
<pre class=" language-html"><code class=" language-html">@push('scripts')
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>script</span> <span
                class="token attr-name">src</span><span class="token attr-value"><span
                    class="token punctuation attr-equals">=</span><span
                    class="token punctuation">"</span>/example.js<span class="token punctuation">"</span></span><span
                class="token punctuation">&gt;</span></span><span class="token script"></span><span
                class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>script</span><span
                    class="token punctuation">&gt;</span></span>
@endpush</code></pre>
<p>Вы можете помещать в стек сколько угодно раз. Чтобы отобразить полное содержимое стека, передайте имя стека в <code>@stack</code> директиву:
</p>
<pre class=" language-html"><code class=" language-html"><span class="token tag"><span class="token tag"><span
                        class="token punctuation">&lt;</span>head</span><span
                    class="token punctuation">&gt;</span></span>
    <span class="token comment">&lt;!-- Head Contents --&gt;</span>

    @stack('scripts')
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>head</span><span
            class="token punctuation">&gt;</span></span></code></pre>
<p>Если вы хотите добавить контент в начало стека, вы должны использовать <code>@prepend</code> директиву:</p>
<pre class=" language-html"><code class=" language-html">@push('scripts')
    This will be second...
@endpush

// Later...

@prepend('scripts')
    This will be first...
@endprepend</code></pre>
<p></p>
<h2 id="service-injection"><a href="#service-injection">Внедрение услуг</a></h2>
<p><code>@inject</code> Директива может быть использована для получения услуги от Laravel <a href="container">контейнера
        службы</a>. Первый переданный аргумент <code>@inject</code> - это имя переменной, в которую будет помещена
    служба, а второй аргумент - это имя класса или интерфейса службы, которую вы хотите разрешить:</p>
<pre class=" language-html"><code class=" language-html">@inject('metrics', 'App\Services\MetricsService')

<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>div</span><span
            class="token punctuation">&gt;</span></span>
    Monthly Revenue: {literal}{{{/literal} $metrics-&gt;monthlyRevenue() }}.
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>div</span><span
            class="token punctuation">&gt;</span></span></code></pre>
<p></p>
<h2 id="extending-blade"><a href="#extending-blade">Расширение Blade</a></h2>
<p>Blade позволяет вам определять свои собственные настраиваемые директивы с помощью <code>directive</code> метода. Когда
    компилятор Blade встречает настраиваемую директиву, он вызывает предоставленный обратный вызов с выражением,
    содержащимся в директиве.</p>
<p>В следующем примере создается <code>@datetime($var)</code> директива, которая форматирует данное <code>$var</code>,
    которое должно быть экземпляром <code>DateTime</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Providers</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Blade</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>ServiceProvider</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">AppServiceProvider</span> <span
                    class="token keyword">extends</span> <span class="token class-name">ServiceProvider</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Register any application services.
    *
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">register</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
    * Bootstrap any application services.
    *
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">boot</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        Blade<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">directive</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'datetime'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token variable">$expression</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> <span class="token double-quoted-string string">"&lt;?php echo (<span class="token interpolation"><span class="token variable">$expression</span></span>)-&gt;format('m/d/Y H:i'); ?&gt;"</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Как видите, мы привяжем <code>format</code> метод к любому выражению, переданному в директиву. Итак, в этом примере
    последний PHP, сгенерированный этой директивой, будет:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span> <span class="token keyword">echo</span> <span
                    class="token punctuation">(</span><span class="token variable">$var</span><span
                    class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">format</span><span class="token punctuation">(</span><span
                    class="token single-quoted-string string">'m/d/Y H:i'</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span> <span
                    class="token delimiter important">?&gt;</span></span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>После обновления логики директивы Blade вам нужно будет удалить все кэшированные представления Blade.
            Кешированные представления Blade можно удалить с помощью команды <code>view:clear</code> Artisan.</p></p>
    </div>
</blockquote>
<p></p>
<h3 id="custom-if-statements"><a href="#custom-if-statements">Пользовательские операторы If</a></h3>
<p>Программирование настраиваемой директивы иногда бывает более сложным, чем необходимо при определении простых
    настраиваемых условных операторов. По этой причине Blade предоставляет <code>Blade::if</code> метод, позволяющий
    быстро определять пользовательские условные директивы с помощью замыканий. Например, давайте определим настраиваемое
    условие, которое проверяет настроенный по умолчанию «диск» для приложения. Мы можем сделать это в <code>boot</code> нашем
    методе <code>AppServiceProvider</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Blade</span><span
                class="token punctuation">;</span>

<span class="token comment">/**
 * Bootstrap any application services.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">boot</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    Blade<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">if</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'disk'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token variable">$value</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token function">config</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'filesystems.default'</span><span class="token punctuation">)</span> <span class="token operator">===</span> <span class="token variable">$value</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>После того, как пользовательское условие было определено, вы можете использовать его в своих шаблонах:</p>
<pre class=" language-html"><code class=" language-html">@disk('local')
    <span class="token comment">&lt;!-- The application is using the local disk... --&gt;</span>
@elsedisk('s3')
    <span class="token comment">&lt;!-- The application is using the s3 disk... --&gt;</span>
@else
    <span class="token comment">&lt;!-- The application is using some other disk... --&gt;</span>
@enddisk

@unlessdisk('local')
    <span class="token comment">&lt;!-- The application is not using the local disk... --&gt;</span>
@enddisk</code></pre> 
