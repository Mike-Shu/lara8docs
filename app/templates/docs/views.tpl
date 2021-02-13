<h1>Представления</h1>
<ul>
    <li><a href="views#introduction">Вступление</a></li>
    <li><a href="views#creating-and-rendering-views">Создание и рендеринг представлений</a>
        <ul>
            <li><a href="views#nested-view-directories">Вложенные каталоги просмотра</a></li>
            <li><a href="views#creating-the-first-available-view">Создание первого доступного представления</a></li>
            <li><a href="views#determining-if-a-view-exists">Определение наличия представления</a></li>
        </ul></li>
    <li><a href="views#passing-data-to-views">Передача данных в представления</a>
        <ul>
            <li><a href="views#sharing-data-with-all-views">Совместное использование данных со всеми представлениями</a></li>
        </ul></li>
    <li><a href="views#view-composers">Посмотреть композиторов</a>
        <ul>
            <li><a href="views#view-creators">Посмотреть авторов</a></li>
        </ul></li>
    <li><a href="views#optimizing-views">Оптимизация просмотров</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Конечно, нецелесообразно возвращать целые строки HTML-документов непосредственно из ваших маршрутов и контроллеров. К счастью, представления предоставляют удобный способ разместить весь наш HTML в отдельных файлах. Представления отделяют логику вашего контроллера / приложения от логики представления и хранятся в <code>resources/views</code> каталоге. Простой вид может выглядеть примерно так:</p>
<pre class=" language-html"><code class=" language-html"><span class="token comment">&lt;!-- View stored in resources/views/greeting.blade.php --&gt;</span>

<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>html</span><span class="token punctuation">&gt;</span></span>
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>body</span><span class="token punctuation">&gt;</span></span>
        <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>h1</span><span class="token punctuation">&gt;</span></span>Hello, {literal}{{ $name }}{/literal}<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>h1</span><span class="token punctuation">&gt;</span></span>
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>body</span><span class="token punctuation">&gt;</span></span>
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>html</span><span class="token punctuation">&gt;</span></span></code></pre>
<p>Поскольку это представление хранится в <code>resources/views/greeting.blade.php</code>, мы можем вернуть его с помощью глобального <code>view</code> помощника, например:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token function">view</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'greeting'</span><span class="token punctuation">,</span> <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token single-quoted-string string">'James'</span><span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout"><div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div><p class="mb-0 lg:ml-6"><p>Ищете дополнительную информацию о том, как писать шаблоны Blade? Ознакомьтесь с полной <a href="blade">документацией Blade,</a> чтобы начать работу.</p></p></div>
</blockquote>
<p></p>
<h2 id="creating-and-rendering-views"><a href="#creating-and-rendering-views">Создание и рендеринг представлений</a></h2>
<p>Вы можете создать представление, поместив файл с <code>.blade.php</code> расширением в <code>resources/views</code> каталог вашего приложения. <code>.blade.php</code> Расширение информирует рамки, что файл содержит <a href="blade">шаблон клинка</a>. Шаблоны Blade содержат HTML, а также директивы Blade, которые позволяют легко отображать значения, создавать операторы if, выполнять итерацию по данным и многое другое.</p>
<p>После того, как вы создали представление, вы можете вернуть его из одного из маршрутов или контроллеров вашего приложения с помощью глобального <code>view</code> помощника:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token function">view</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'greeting'</span><span class="token punctuation">,</span> <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token single-quoted-string string">'James'</span><span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Представления также могут быть возвращены с помощью <code>View</code> фасада:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span class="token punctuation">\</span>Facades<span class="token punctuation">\</span>View</span><span class="token punctuation">;</span>

<span class="token keyword">return</span> View<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">make</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'greeting'</span><span class="token punctuation">,</span> <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token single-quoted-string string">'James'</span><span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Как видите, первый аргумент, переданный <code>view</code> помощнику, соответствует имени файла представления в <code>resources/views</code> каталоге. Второй аргумент - это массив данных, которые должны быть доступны для представления. В этом случае мы передаем <code>name</code> переменную, которая отображается в представлении с использованием <a href="blade">синтаксиса Blade</a>.</p>
<p></p>
<h3 id="nested-view-directories"><a href="#nested-view-directories">Вложенные каталоги просмотра</a></h3>
<p>Представления также могут быть вложены в подкаталоги <code>resources/views</code> каталога. Обозначение «точка» может использоваться для ссылки на вложенные представления. Например, если ваше представление хранится в <code>resources/views/admin/profile.blade.php</code>, вы можете вернуть его из одного из маршрутов / контроллеров вашего приложения следующим образом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span class="token function">view</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'admin.profile'</span><span class="token punctuation">,</span> <span class="token variable">$data</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout"><div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img src="/img/callouts/exclamation.min.svg" class="opacity-75"></div><p class="mb-0 lg:ml-6"><p>Имена каталогов просмотра не должны содержать <code>.</code> символа.</p></p></div>
</blockquote>
<p></p>
<h3 id="creating-the-first-available-view"><a href="#creating-the-first-available-view">Создание первого доступного представления</a></h3>
<p>Используя метод <code>View</code> фасада <code>first</code>, вы можете создать первое представление, которое существует в данном массиве представлений. Это может быть полезно, если ваше приложение или пакет позволяет настраивать или перезаписывать представления:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span class="token punctuation">\</span>Facades<span class="token punctuation">\</span>View</span><span class="token punctuation">;</span>

<span class="token keyword">return</span> View<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">first</span><span class="token punctuation">(</span><span class="token punctuation">[</span><span class="token single-quoted-string string">'custom.admin'</span><span class="token punctuation">,</span> <span class="token single-quoted-string string">'admin'</span><span class="token punctuation">]</span><span class="token punctuation">,</span> <span class="token variable">$data</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="determining-if-a-view-exists"><a href="#determining-if-a-view-exists">Определение наличия представления</a></h3>
<p>Если вам нужно определить, существует ли представление, вы можете использовать <code>View</code> фасад. <code>exists</code> Метод будет возвращать, <code>true</code> если представление существует:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span class="token punctuation">\</span>Facades<span class="token punctuation">\</span>View</span><span class="token punctuation">;</span>

<span class="token keyword">if</span> <span class="token punctuation">(</span>View<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">exists</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'emails.customer'</span><span class="token punctuation">)</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h2 id="passing-data-to-views"><a href="#passing-data-to-views">Передача данных в представления</a></h2>
<p>Как вы видели в предыдущих примерах, вы можете передать массив данных представлениям, чтобы сделать эти данные доступными для представления:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span class="token function">view</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'greetings'</span><span class="token punctuation">,</span> <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token single-quoted-string string">'Victoria'</span><span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>При передаче информации таким образом данные должны быть массивом с парами ключ / значение. После предоставления данных в представление вы можете получить доступ к каждому значению в вашем представлении с помощью ключей данных, например <code>&lt;?php echo $name; ?&gt;</code>.</p>
<p>В качестве альтернативы передаче полного массива данных <code>view</code> вспомогательной функции вы можете использовать этот <code>with</code> метод для добавления отдельных фрагментов данных в представление. <code>with</code> Метод возвращает экземпляр объекта вида, так что вы можете продолжать цепочки методов, прежде чем вернуться вид:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span class="token function">view</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'greeting'</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">with</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span class="token punctuation">,</span> <span class="token single-quoted-string string">'Victoria'</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">with</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'occupation'</span><span class="token punctuation">,</span> <span class="token single-quoted-string string">'Astronaut'</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="sharing-data-with-all-views"><a href="#sharing-data-with-all-views">Совместное использование данных со всеми представлениями</a></h3>
<p>Иногда вам может потребоваться поделиться данными со всеми представлениями, отображаемыми вашим приложением. Вы можете сделать это с помощью метода <code>View</code> фасада <code>share</code>. Как правило, вы должны размещать вызовы <code>share</code> метода внутри метода поставщика услуг <code>boot</code>. Вы можете добавить их в <code>App\Providers\AppServiceProvider</code> класс или создать отдельного поставщика услуг для их размещения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Providers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span class="token punctuation">\</span>Facades<span class="token punctuation">\</span>View</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">AppServiceProvider</span> <span class="token keyword">extends</span> <span class="token class-name">ServiceProvider</span>
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
        View<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">share</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'key'</span><span class="token punctuation">,</span> <span class="token single-quoted-string string">'value'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h2 id="view-composers"><a href="#view-composers">Посмотреть композиторов</a></h2>
<p>Компоновщики представления - это обратные вызовы или методы класса, которые вызываются при визуализации представления. Если у вас есть данные, которые вы хотите привязать к представлению каждый раз при его визуализации, составитель представлений может помочь вам организовать эту логику в одном месте. Компоновщики представлений могут оказаться особенно полезными, если одно и то же представление возвращается несколькими маршрутами или контроллерами в вашем приложении и всегда требует определенного фрагмента данных.</p>
<p>Как правило, составители представлений регистрируются в одном из <a href="providers">поставщиков услуг</a> вашего приложения. В этом примере мы предположим, что мы создали новый объект <code>App\Providers\ViewServiceProvider</code> для размещения этой логики.</p>
<p>Мы будем использовать метод <code>View</code> фасада, <code>composer</code> чтобы зарегистрировать составитель представления. Laravel не включает каталог по умолчанию для составителей представлений на основе классов, поэтому вы можете организовать их, как хотите. Например, вы можете создать <code>app/Http/View/Composers</code> каталог для размещения всех составителей представлений вашего приложения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Providers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Http<span class="token punctuation">\</span>View<span class="token punctuation">\</span>Composers<span class="token punctuation">\</span>ProfileComposer</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span class="token punctuation">\</span>Facades<span class="token punctuation">\</span>View</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span class="token punctuation">\</span>ServiceProvider</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ViewServiceProvider</span> <span class="token keyword">extends</span> <span class="token class-name">ServiceProvider</span>
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
        <span class="token comment">// Using class based composers...</span>
        View<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">composer</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'profile'</span><span class="token punctuation">,</span> ProfileComposer<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token comment">// Using closure based composers...</span>
        View<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">composer</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'dashboard'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token variable">$view</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">//</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout"><div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img src="/img/callouts/exclamation.min.svg" class="opacity-75"></div><p class="mb-0 lg:ml-6"><p>Помните, что если вы создаете нового поставщика услуг, который будет содержать ваши регистрации композитора представления, вам нужно будет добавить поставщика услуг в <code>providers</code> массив в <code>config/app.php</code> файле конфигурации.</p></p></div>
</blockquote>
<p>Теперь, когда мы зарегистрировали композитор, <code>compose</code> метод <code>App\Http\View\Composers\ProfileComposer</code> класса будет выполняться каждый раз <code>profile</code>, когда визуализируется представление. Давайте посмотрим на пример класса композитора:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span class="token punctuation">\</span>View<span class="token punctuation">\</span>Composers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Repositories<span class="token punctuation">\</span>UserRepository</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>View<span class="token punctuation">\</span>View</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ProfileComposer</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * The user repository implementation.
    *
    * @var \App\Repositories\UserRepository
    */</span>
    <span class="token keyword">protected</span> <span class="token variable">$users</span><span class="token punctuation">;</span>

    <span class="token comment">/**
    * Create a new profile composer.
    *
    * @param  \App\Repositories\UserRepository  $users
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">__construct</span><span class="token punctuation">(</span>UserRepository <span class="token variable">$users</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">// Dependencies are automatically resolved by the service container...</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">users</span> <span class="token operator">=</span> <span class="token variable">$users</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
    * Bind data to the view.
    *
    * @param  \Illuminate\View\View  $view
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">compose</span><span class="token punctuation">(</span>View <span class="token variable">$view</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$view</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">with</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'count'</span><span class="token punctuation">,</span> <span class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">users</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">count</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Как видите, все составители представлений разрешаются через <a href="container">контейнер службы</a>, поэтому вы можете указать любые зависимости, которые вам нужны, в конструкторе композитора.</p>
<p></p>
<h4 id="attaching-a-composer-to-multiple-views"><a href="#attaching-a-composer-to-multiple-views">Присоединение композитора к нескольким представлениям</a></h4>
<p>Вы можете присоединить композитор представлений к нескольким представлениям одновременно, передав массив представлений в качестве первого аргумента <code>composer</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Http<span class="token punctuation">\</span>Views<span class="token punctuation">\</span>Composers<span class="token punctuation">\</span>MultiComposer</span><span class="token punctuation">;</span>

View<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">composer</span><span class="token punctuation">(</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'profile'</span><span class="token punctuation">,</span> <span class="token single-quoted-string string">'dashboard'</span><span class="token punctuation">]</span><span class="token punctuation">,</span>
    MultiComposer<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Этот <code>composer</code> метод также принимает <code>*</code> символ как подстановочный знак, позволяя вам прикрепить композитор ко всем представлениям:</p>
<pre class=" language-php"><code class=" language-php">View<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">composer</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'*'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token variable">$view</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="view-creators"><a href="#view-creators">Посмотреть авторов</a></h3>
<p>Представления «Создатели» очень похожи на представления композиторов; тем не менее, они выполняются сразу после создания экземпляра представления, вместо того, чтобы ждать, пока представление будет отображено. Чтобы зарегистрировать создателя представления, используйте <code>creator</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Http<span class="token punctuation">\</span>View<span class="token punctuation">\</span>Creators<span class="token punctuation">\</span>ProfileCreator</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span class="token punctuation">\</span>Facades<span class="token punctuation">\</span>View</span><span class="token punctuation">;</span>

View<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">creator</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'profile'</span><span class="token punctuation">,</span> ProfileCreator<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="optimizing-views"><a href="#optimizing-views">Оптимизация представлений</a></h2>
<p>По умолчанию представления шаблонов Blade компилируются по запросу. Когда выполняется запрос, который отображает представление, Laravel определит, существует ли скомпилированная версия представления. Если файл существует, Laravel затем определит, было ли некомпилированное представление изменено позже, чем скомпилированное представление. Если скомпилированное представление либо не существует, либо некомпилированное представление было изменено, Laravel перекомпилирует представление.</p>
<p>Компиляция представлений во время запроса может иметь небольшое негативное влияние на производительность, поэтому Laravel предоставляет Artisan-команду <code>view:cache</code> для предварительной компиляции всех представлений, используемых вашим приложением. Для повышения производительности вы можете выполнить эту команду как часть процесса развертывания:</p>
<pre class=" language-php"><code class=" language-php">php artisan view<span class="token punctuation">:</span>cache</code></pre>
<p>Для удаления скомпилированных представлений вы можете использовать команду <code>view:clear</code>.</p>
<pre class=" language-php"><code class=" language-php">php artisan view<span class="token punctuation">:</span>clear</code></pre>
