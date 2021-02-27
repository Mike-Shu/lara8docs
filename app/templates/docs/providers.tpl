<h1>Поставщики услуг</h1>
<ul>
    <li><a href="providers#introduction">Вступление</a></li>
    <li><a href="providers#writing-service-providers">Написание поставщиков услуг</a>
        <ul>
            <li><a href="providers#the-register-method">Метод регистрации</a></li>
            <li><a href="providers#the-boot-method">Метод загрузки</a></li>
        </ul>
    </li>
    <li><a href="providers#registering-providers">Регистрация провайдеров</a></li>
    <li><a href="providers#deferred-providers">Отложенные поставщики</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Поставщики услуг - это центральное место при начальной загрузке всех приложений Laravel. Ваше собственное приложение,
    а также все основные службы Laravel загружаются через поставщиков услуг.</p>
<p>Но что мы подразумеваем под «самозагрузкой»? В общем, мы имеем в виду <strong>регистрацию</strong> вещей, включая
    регистрацию привязок сервисных контейнеров, прослушивателей событий, промежуточного программного обеспечения и даже
    маршрутов. Поставщики услуг - это центральное место для настройки вашего приложения.</p>
<p>Если вы откроете <code>config/app.php</code> файл, включенный в Laravel, вы увидите <code>providers</code> массив. Это
    все классы поставщиков услуг, которые будут загружены для вашего приложения. По умолчанию в этом массиве перечислены
    основные поставщики услуг Laravel. Эти поставщики загружают основные компоненты Laravel, такие как почтовая
    программа, очередь, кеш и другие. Многие из этих поставщиков являются «отложенными» поставщиками, то есть они не
    будут загружаться при каждом запросе, а только тогда, когда предоставляемые ими услуги действительно необходимы.</p>
<p>В этом обзоре вы узнаете, как написать собственных поставщиков услуг и зарегистрировать их в приложении Laravel.</p>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Если вы хотите узнать больше о том, как Laravel обрабатывает запросы и работает внутри, ознакомьтесь с нашей
            документацией по <a href="lifecycle">жизненному</a> циклу <a href="lifecycle">запросов</a> Laravel.</p></p>
    </div>
</blockquote>
<p></p>
<h2 id="writing-service-providers"><a href="#writing-service-providers">Написание поставщиков услуг</a></h2>
<p>Все поставщики услуг расширяют <code>Illuminate\Support\ServiceProvider</code> класс. Большинство поставщиков услуг
    содержат <code>register</code> и в <code>boot</code> метод. Внутри <code>register</code> метода вы должны <strong>привязывать
        вещи только к <a href="container">сервисному контейнеру</a></strong>. Вы никогда не должны пытаться
    регистрировать какие-либо прослушиватели событий, маршруты или любую другую часть функциональности в
    <code>register</code> методе.</p>
<p>Artisan CLI может сгенерировать нового провайдера с помощью <code>make:provider</code> команды:</p>
<pre class=" language-php"><code class=" language-php">php artisan make<span class="token punctuation">:</span>provider RiakServiceProvider</code></pre>
<p></p>
<h3 id="the-register-method"><a href="#the-register-method">Метод регистрации</a></h3>
<p>Как упоминалось ранее, внутри <code>register</code> метода вы должны привязывать вещи только к <a href="container">сервисному
        контейнеру</a>. Вы никогда не должны пытаться регистрировать какие-либо прослушиватели событий, маршруты или
    любую другую часть функциональности в <code>register</code> методе. В противном случае вы можете случайно
    воспользоваться услугой, предоставляемой поставщиком услуг, но еще не загруженной.</p>
<p>Давайте посмотрим на основного поставщика услуг. В рамках любого из методов вашего поставщика услуг у вас всегда есть
    доступ к <code>$app</code> свойству, которое предоставляет доступ к контейнеру службы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Providers</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Services<span class="token punctuation">\</span>Riak<span
                        class="token punctuation">\</span>Connection</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>ServiceProvider</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">RiakServiceProvider</span> <span
                    class="token keyword">extends</span> <span class="token class-name">ServiceProvider</span>
<span class="token punctuation">{literal}{{/literal}</span>
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
                    class="token punctuation">(</span>Connection<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">,</span> <span class="token keyword">function</span> <span
                    class="token punctuation">(</span><span class="token variable">$app</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> <span class="token keyword">new</span> <span class="token class-name">Connection</span><span
                    class="token punctuation">(</span><span class="token function">config</span><span
                    class="token punctuation">(</span><span class="token single-quoted-string string">'riak'</span><span
                    class="token punctuation">)</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Этот поставщик услуг только определяет <code>register</code> метод и использует этот метод для определения реализации
    <code>App\Services\Riak\Connection</code> в контейнере службы. Если вы еще не знакомы с сервисным контейнером
    Laravel, ознакомьтесь с <a href="container">его документацией</a>.</p>
<p></p>
<h4 id="the-bindings-and-singletons-properties"><a href="#the-bindings-and-singletons-properties">В
        <code>bindings</code> И <code>singletons</code> Свойства</a></h4>
<p>Если поставщик услуг регистрирует множество простых привязок, вы можете использовать <code>bindings</code> и <code>singletons</code> свойство
    вместо того, чтобы вручную регистрировать каждый контейнер связывания. Когда поставщик услуг загружается
    платформой, он автоматически проверяет эти свойства и регистрирует их привязки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Providers</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Contracts<span class="token punctuation">\</span>DowntimeNotifier</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Contracts<span class="token punctuation">\</span>ServerProvider</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Services<span class="token punctuation">\</span>DigitalOceanServerProvider</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Services<span class="token punctuation">\</span>PingdomDowntimeNotifier</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Services<span class="token punctuation">\</span>ServerToolsProvider</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>ServiceProvider</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">AppServiceProvider</span> <span
                    class="token keyword">extends</span> <span class="token class-name">ServiceProvider</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * All of the container bindings that should be registered.
    *
    * @var array
    */</span>
    <span class="token keyword">public</span> <span class="token variable">$bindings</span> <span
                    class="token operator">=</span> <span class="token punctuation">[</span>
        ServerProvider<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token keyword">class</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> DigitalOceanServerProvider<span
                    class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token keyword">class</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">;</span>

    <span class="token comment">/**
    * All of the container singletons that should be registered.
    *
    * @var array
    */</span>
    <span class="token keyword">public</span> <span class="token variable">$singletons</span> <span
                    class="token operator">=</span> <span class="token punctuation">[</span>
        DowntimeNotifier<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token keyword">class</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> PingdomDowntimeNotifier<span
                    class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token keyword">class</span><span class="token punctuation">,</span>
        ServerProvider<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token keyword">class</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> ServerToolsProvider<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h3 id="the-boot-method"><a href="#the-boot-method">Метод загрузки</a></h3>
<p>Итак, что, если нам нужно зарегистрировать <a href="views#view-composers">композитор представления</a> в нашем
    сервис-провайдере? Это должно быть сделано в рамках <code>boot</code> метода. <strong>Этот метод вызывается после
        того, как все другие поставщики услуг были зарегистрированы</strong>, то есть у вас есть доступ ко всем другим
    услугам, которые были зарегистрированы фреймворком:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Providers</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>View</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>ServiceProvider</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ComposerServiceProvider</span> <span
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
        View<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">composer</span><span
                    class="token punctuation">(</span><span class="token single-quoted-string string">'view'</span><span
                    class="token punctuation">,</span> <span class="token keyword">function</span> <span
                    class="token punctuation">(</span><span class="token punctuation">)</span> <span
                    class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">//</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h4 id="boot-method-dependency-injection"><a href="#boot-method-dependency-injection">Внедрение зависимости метода
        загрузки</a></h4>
<p>Вы можете указать зависимости для <code>boot</code> метода вашего поставщика услуг. <a href="container">Контейнерный
        сервис</a> будет автоматически вводить какую - либо зависимость, нужно:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                    class="token punctuation">\</span>Routing<span
                    class="token punctuation">\</span>ResponseFactory</span><span class="token punctuation">;</span>

<span class="token comment">/**
 * Bootstrap any application services.
 *
 * @param  \Illuminate\Contracts\Routing\ResponseFactory
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">boot</span><span class="token punctuation">(</span>ResponseFactory <span
                class="token variable">$response</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$response</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">macro</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'serialized'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$value</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h2 id="registering-providers"><a href="#registering-providers">Регистрация провайдеров</a></h2>
<p>Все поставщики услуг зарегистрированы в <code>config/app.php</code> файле конфигурации. Этот файл содержит <code>providers</code> массив,
    в котором вы можете перечислить имена классов ваших поставщиков услуг. По умолчанию в этом массиве перечислены
    основные поставщики услуг Laravel. Эти поставщики загружают основные компоненты Laravel, такие как почтовая
    программа, очередь, кеш и другие.</p>
<p>Чтобы зарегистрировать своего провайдера, добавьте его в массив:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'providers'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token comment">// Other Service Providers</span>

    App\<span class="token package">Providers<span class="token punctuation">\</span>ComposerServiceProvider</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p></p>
<h2 id="deferred-providers"><a href="#deferred-providers">Отложенные поставщики</a></h2>
<p>Если ваш провайдер <strong>только</strong> регистрирует привязки в <a href="container">сервисном контейнере</a>, вы
    можете отложить его регистрацию до тех пор, пока одна из зарегистрированных привязок не понадобится. Отсрочка
    загрузки такого провайдера улучшит производительность вашего приложения, поскольку оно не загружается из файловой
    системы при каждом запросе.</p>
<p>Laravel компилирует и хранит список всех услуг, предоставляемых отложенными поставщиками услуг, вместе с именем
    своего класса поставщика услуг. Затем, только когда вы пытаетесь разрешить одну из этих служб, Laravel загружает
    поставщика услуг.</p>
<p>Чтобы отложить загрузку поставщика, реализуйте <code>\Illuminate\Contracts\Support\DeferrableProvider</code> интерфейс
    и определите <code>provides</code> метод. <code>provides</code> Метод должен вернуть контейнер службы привязок,
    зарегистрированных поставщиком:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Providers</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Services<span class="token punctuation">\</span>Riak<span
                        class="token punctuation">\</span>Connection</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Support<span class="token punctuation">\</span>DeferrableProvider</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>ServiceProvider</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">RiakServiceProvider</span> <span
                    class="token keyword">extends</span> <span class="token class-name">ServiceProvider</span> <span
                    class="token keyword">implements</span> <span class="token class-name">DeferrableProvider</span>
<span class="token punctuation">{literal}{{/literal}</span>
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
                    class="token punctuation">(</span>Connection<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">,</span> <span class="token keyword">function</span> <span
                    class="token punctuation">(</span><span class="token variable">$app</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> <span class="token keyword">new</span> <span class="token class-name">Connection</span><span
                    class="token punctuation">(</span><span class="token variable">$app</span><span
                    class="token punctuation">[</span><span
                    class="token single-quoted-string string">'config'</span><span
                    class="token punctuation">]</span><span class="token punctuation">[</span><span
                    class="token single-quoted-string string">'riak'</span><span class="token punctuation">]</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
    * Get the services provided by the provider.
    *
    * @return array
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">provides</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token punctuation">[</span>Connection<span
                    class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token keyword">class</span><span class="token punctuation">]</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
