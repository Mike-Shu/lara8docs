<h1>Фасады</h1>
<ul>
    <li><a href="facades#introduction">Вступление</a></li>
    <li><a href="facades#when-to-use-facades">Когда использовать фасады</a>
        <ul>
            <li><a href="facades#facades-vs-dependency-injection">Фасады Vs. Внедрение зависимости</a></li>
            <li><a href="facades#facades-vs-helper-functions">Фасады Vs. Вспомогательные функции</a></li>
        </ul>
    </li>
    <li><a href="facades#how-facades-work">Как работают фасады</a></li>
    <li><a href="facades#real-time-facades">Фасады в реальном времени</a></li>
    <li><a href="facades#facade-class-reference">Справочник классов фасадов</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>В документации Laravel вы увидите примеры кода, который взаимодействует с функциями Laravel через «фасады». Фасады
    предоставляют «статический» интерфейс для классов, доступных в <a href="container">сервисном контейнере
        приложения</a>. Laravel поставляется с множеством фасадов, которые обеспечивают доступ почти ко всем функциям
    Laravel.</p>
<p>Фасады Laravel служат «статическими прокси» для базовых классов в сервисном контейнере, обеспечивая преимущества
    краткого выразительного синтаксиса при сохранении большей тестируемости и гибкости, чем традиционные статические
    методы. Это прекрасно, если вы не совсем понимаете, как фасады работают под капотом - просто плывите по течению и
    продолжайте изучать Laravel.</p>
<p>Все фасады Laravel определены в <code>Illuminate\Support\Facades</code> пространстве имен. Итак, мы можем легко
    получить доступ к такому фасаду:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Cache</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/cache'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> Cache<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'key'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>В документации Laravel во многих примерах будут использоваться фасады для демонстрации различных функций
    фреймворка.</p>
<p></p>
<h4 id="helper-functions"><a href="#helper-functions">Вспомогательные функции</a></h4>
<p>В дополнение к фасадам Laravel предлагает множество глобальных «вспомогательных функций», которые упрощают
    взаимодействие с общими функциями Laravel. Некоторые из общих вспомогательных функций, которые могут
    взаимодействовать с являются <code>view</code>, <code>response</code>, <code>url</code>, <code>config</code> и многим
    другим. Каждая вспомогательная функция, предлагаемая Laravel, документирована с соответствующей функцией; однако
    полный список доступен в специальной <a href="helpers">вспомогательной документации</a>.</p>
<p>Например, вместо использования <code>Illuminate\Support\Facades\Response</code> фасада для генерации ответа JSON мы
    можем просто использовать <code>response</code> функцию. Поскольку вспомогательные функции доступны глобально, вам не
    нужно импортировать какие-либо классы, чтобы использовать их:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span
                    class="token punctuation">\</span>Response</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/users'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> Response<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">json</span><span class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token comment">//...</span>
    <span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/users'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token function">response</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">json</span><span class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token comment">//...</span>
    <span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="when-to-use-facades"><a href="#when-to-use-facades">Когда использовать фасады</a></h2>
<p>У фасадов много преимуществ. Они предоставляют краткий, запоминающийся синтаксис, который позволяет вам использовать
    функции Laravel, не запоминая длинные имена классов, которые необходимо вводить или настраивать вручную. Более того,
    благодаря уникальному использованию динамических методов PHP их легко протестировать.</p>
<p>Однако при использовании фасадов необходимо соблюдать некоторую осторожность. Основная опасность фасадов - это класс
    «ползучесть». Поскольку фасады настолько просты в использовании и не требуют инъекций, можно легко позволить вашим
    классам продолжать расти и использовать множество фасадов в одном классе. При использовании внедрения зависимостей
    этот потенциал снижается за счет визуальной обратной связи, которую дает большой конструктор о том, что ваш класс
    становится слишком большим. Итак, при использовании фасадов обратите особое внимание на размер вашего класса, чтобы
    объем его ответственности оставался узким. Если ваш класс становится слишком большим, рассмотрите возможность
    разделения его на несколько более мелких классов.</p>
<p></p>
<h3 id="facades-vs-dependency-injection"><a href="#facades-vs-dependency-injection">Фасады Vs. Внедрение зависимости</a>
</h3>
<p>Одним из основных преимуществ внедрения зависимостей является возможность поменять местами реализации внедренного
    класса. Это полезно во время тестирования, так как вы можете ввести имитацию или заглушку и утверждать, что для
    заглушки были вызваны различные методы.</p>
<p>Как правило, невозможно издеваться над действительно статическим методом класса или заглушить его. Однако, поскольку
    фасады используют динамические методы для проксирования вызовов методов к объектам, разрешенным из контейнера
    службы, мы фактически можем тестировать фасады так же, как тестировали бы внедренный экземпляр класса. Например,
    учитывая следующий маршрут:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Cache</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/cache'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> Cache<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'key'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Используя методы тестирования фасадов Laravel, мы можем написать следующий тест, чтобы убедиться, что <code>Cache::get</code> метод
    был вызван с ожидаемым аргументом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Cache</span><span
                class="token punctuation">;</span>

<span class="token comment">/**
 * A basic functional test example.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">testBasicExample</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    Cache<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">shouldReceive</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'get'</span><span class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">with</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'key'</span><span class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">andReturn</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'value'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

    <span class="token variable">$response</span> <span class="token operator">=</span> <span class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/cache'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

    <span class="token variable">$response</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSee</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'value'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="facades-vs-helper-functions"><a href="#facades-vs-helper-functions">Фасады Vs. Вспомогательные функции</a></h3>
<p>Помимо фасадов, Laravel включает в себя множество «вспомогательных» функций, которые могут выполнять общие задачи,
    такие как создание представлений, запуск событий, диспетчеризация заданий или отправка HTTP-ответов. Многие из этих
    вспомогательных функций выполняют ту же функцию, что и соответствующий фасад. Например, этот вызов фасада и вызов
    помощника эквивалентны:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> Illuminate\<span
                class="token package">Support<span class="token punctuation">\</span>Facades<span
                    class="token punctuation">\</span>View</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">make</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'profile'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">return</span> <span class="token function">view</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'profile'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Практической разницы между фасадами и вспомогательными функциями нет абсолютно никакой. При использовании
    вспомогательных функций вы все равно можете тестировать их точно так же, как и соответствующий фасад. Например,
    учитывая следующий маршрут:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/cache'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token function">cache</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'key'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Под капотом <code>cache</code> помощник будет вызывать <code>get</code> метод класса, лежащего в основе
    <code>Cache</code> фасада. Итак, даже если мы используем вспомогательную функцию, мы можем написать следующий тест,
    чтобы убедиться, что метод был вызван с ожидаемым аргументом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Cache</span><span
                class="token punctuation">;</span>

<span class="token comment">/**
 * A basic functional test example.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">testBasicExample</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    Cache<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">shouldReceive</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'get'</span><span class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">with</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'key'</span><span class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">andReturn</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'value'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

    <span class="token variable">$response</span> <span class="token operator">=</span> <span class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'/cache'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

    <span class="token variable">$response</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSee</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'value'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h2 id="how-facades-work"><a href="#how-facades-work">Как работают фасады</a></h2>
<p>В приложении Laravel фасад - это класс, который предоставляет доступ к объекту из контейнера. Техника, которая
    выполняет эту работу, находится в своем <code>Facade</code> классе. Фасады Laravel и любые пользовательские фасады,
    которые вы создаете, расширят базовый <code>Illuminate\Support\Facades\Facade</code> класс.</p>
<p>В <code>Facade</code> базовом классе использует <code>__callStatic()</code> магический способ отложить звонки с вашего
    фасада к объекту разрешен из контейнера. В приведенном ниже примере выполняется вызов кэш-системы Laravel. Взглянув
    на этот код, можно предположить, что статический <code>get</code> метод вызывается для <code>Cache</code> класса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>Controller</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Cache</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">UserController</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Show the profile for the given user.
    *
    * @param  int  $id
    * @return Response
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">showProfile</span><span class="token punctuation">(</span><span class="token variable">$id</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$user</span> <span class="token operator">=</span> Cache<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'user:'</span><span class="token punctuation">.</span><span class="token variable">$id</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token keyword">return</span> <span class="token function">view</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'profile'</span><span class="token punctuation">,</span> <span class="token punctuation">[</span><span class="token single-quoted-string string">'user'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token variable">$user</span><span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Обратите внимание, что в верхней части файла мы «импортируем» <code>Cache</code> фасад. Этот фасад служит прокси для
    доступа к базовой реализации <code>Illuminate\Contracts\Cache\Factory</code> интерфейса. Любые вызовы, которые мы
    делаем с использованием фасада, будут передаваться в базовый экземпляр службы кеширования Laravel.</p>
<p>Если мы посмотрим на этот <code>Illuminate\Support\Facades\Cache</code> класс, вы увидите, что статического метода нет
    <code>get</code> :</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">class</span> <span
                class="token class-name">Cache</span> <span class="token keyword">extends</span> <span
                class="token class-name">Facade</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Get the registered name of the component.
    *
    * @return string
    */</span>
    <span class="token keyword">protected</span> <span class="token keyword">static</span> <span class="token keyword">function</span> <span class="token function">getFacadeAccessor</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span> <span class="token keyword">return</span> <span class="token single-quoted-string string">'cache'</span><span class="token punctuation">;</span> <span class="token punctuation">}</span>
<span class="token punctuation">}</span></code></pre>
<p>Вместо этого <code>Cache</code> фасад расширяет базовый <code>Facade</code> класс и определяет метод <code>getFacadeAccessor()</code>.
    Задача этого метода - вернуть имя привязки контейнера службы. Когда пользователь ссылается на какой-либо статический
    метод на <code>Cache</code> фасаде, Laravel разрешает <code>cache</code> привязку из <a href="container">контейнера
        службы</a> и запускает запрошенный метод (в данном случае <code>get</code> ) для этого объекта.</p>
<p></p>
<h2 id="real-time-facades"><a href="#real-time-facades">Фасады в реальном времени</a></h2>
<p>Используя фасады в реальном времени, вы можете рассматривать любой класс в своем приложении, как если бы он был
    фасадом. Чтобы проиллюстрировать, как это можно использовать, давайте сначала рассмотрим код, который не использует
    фасады в реальном времени. Например, предположим, что у нашей <code>Podcast</code> модели есть <code>publish</code> метод.
    Однако, чтобы опубликовать подкаст, нам нужно внедрить <code>Publisher</code> экземпляр:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Publisher</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Model</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">Podcast</span> <span class="token keyword">extends</span> <span
                    class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Publish the podcast.
    *
    * @param  Publisher  $publisher
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">publish</span><span class="token punctuation">(</span>Publisher <span class="token variable">$publisher</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">update</span><span class="token punctuation">(</span><span class="token punctuation">[</span><span class="token single-quoted-string string">'publishing'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token function">now</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token variable">$publisher</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">publish</span><span class="token punctuation">(</span><span class="token variable">$this</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Внедрение реализации издателя в метод позволяет нам легко тестировать метод изолированно, поскольку мы можем
    имитировать внедренного издателя. Однако для этого требуется, чтобы мы всегда передавали экземпляр издателя при
    каждом вызове <code>publish</code> метода. Используя фасады в реальном времени, мы можем поддерживать такую же
    тестируемость, при этом не требуя явной передачи <code>Publisher</code> экземпляра. Чтобы создать фасад реального
    времени, добавьте к пространству имен импортируемого класса префикс <code>Facades</code> :</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Facades<span
                        class="token punctuation">\</span>App<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Publisher</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Model</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">Podcast</span> <span class="token keyword">extends</span> <span
                    class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Publish the podcast.
    *
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">publish</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">update</span><span class="token punctuation">(</span><span class="token punctuation">[</span><span class="token single-quoted-string string">'publishing'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token function">now</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

        Publisher<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">publish</span><span class="token punctuation">(</span><span class="token variable">$this</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Когда используется фасад реального времени, реализация издателя будет разрешена из контейнера службы с использованием
    части интерфейса или имени класса, которая появляется после <code>Facades</code> префикса. При тестировании мы можем
    использовать встроенные помощники Laravel по тестированию фасадов, чтобы имитировать вызов этого метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">Tests<span class="token punctuation">\</span>Feature</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span
                        class="token punctuation">\</span>Podcast</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Facades<span
                        class="token punctuation">\</span>App<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Publisher</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Testing<span class="token punctuation">\</span>RefreshDatabase</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Tests<span class="token punctuation">\</span>TestCase</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">PodcastTest</span> <span class="token keyword">extends</span> <span
                    class="token class-name">TestCase</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">use</span> <span class="token package">RefreshDatabase</span><span class="token punctuation">;</span>

    <span class="token comment">/**
    * A test example.
    *
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">test_podcast_can_be_published</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$podcast</span> <span class="token operator">=</span> Podcast<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">factory</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">create</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

        Publisher<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">shouldReceive</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'publish'</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">once</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">with</span><span class="token punctuation">(</span><span class="token variable">$podcast</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token variable">$podcast</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">publish</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h2 id="facade-class-reference"><a href="#facade-class-reference">Справочник классов фасадов</a></h2>
<p>Ниже вы найдете каждый фасад и его базовый класс. Это полезный инструмент для быстрого изучения документации API для
    данного корня фасада. <a href="container">Службы контейнера привязки</a> ключа также включены, где это применимо.
</p>
<table>
    <thead>
    <tr>
        <th>Facade</th>
        <th>Class</th>
        <th>Service Container Binding</th>
    </tr>
    </thead>
    <tbody>

    <tr>
        <td>App</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Foundation/Application.html">Illuminate\Foundation\Application</a></td>
        <td><code>app</code></td>
    </tr>
    <tr>
        <td>Artisan</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Contracts/Console/Kernel.html">Illuminate\Contracts\Console\Kernel</a></td>
        <td><code>artisan</code></td>
    </tr>
    <tr>
        <td>Auth</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Auth/AuthManager.html">Illuminate\Auth\AuthManager</a></td>
        <td><code>auth</code></td>
    </tr>
    <tr>
        <td>Auth (Instance)</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Contracts/Auth/Guard.html">Illuminate\Contracts\Auth\Guard</a></td>
        <td><code>auth.driver</code></td>
    </tr>
    <tr>
        <td>Blade</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/View/Compilers/BladeCompiler.html">Illuminate\View\Compilers\BladeCompiler</a></td>
        <td><code>blade.compiler</code></td>
    </tr>
    <tr>
        <td>Broadcast</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Contracts/Broadcasting/Factory.html">Illuminate\Contracts\Broadcasting\Factory</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>Broadcast (Instance)</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Contracts/Broadcasting/Broadcaster.html">Illuminate\Contracts\Broadcasting\Broadcaster</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>Bus</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Contracts/Bus/Dispatcher.html">Illuminate\Contracts\Bus\Dispatcher</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>Cache</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Cache/CacheManager.html">Illuminate\Cache\CacheManager</a></td>
        <td><code>cache</code></td>
    </tr>
    <tr>
        <td>Cache (Instance)</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Cache/Repository.html">Illuminate\Cache\Repository</a></td>
        <td><code>cache.store</code></td>
    </tr>
    <tr>
        <td>Config</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Config/Repository.html">Illuminate\Config\Repository</a></td>
        <td><code>config</code></td>
    </tr>
    <tr>
        <td>Cookie</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Cookie/CookieJar.html">Illuminate\Cookie\CookieJar</a></td>
        <td><code>cookie</code></td>
    </tr>
    <tr>
        <td>Crypt</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Encryption/Encrypter.html">Illuminate\Encryption\Encrypter</a></td>
        <td><code>encrypter</code></td>
    </tr>
    <tr>
        <td>DB</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Database/DatabaseManager.html">Illuminate\Database\DatabaseManager</a></td>
        <td><code>db</code></td>
    </tr>
    <tr>
        <td>DB (Instance)</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Database/Connection.html">Illuminate\Database\Connection</a></td>
        <td><code>db.connection</code></td>
    </tr>
    <tr>
        <td>Event</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Events/Dispatcher.html">Illuminate\Events\Dispatcher</a></td>
        <td><code>events</code></td>
    </tr>
    <tr>
        <td>File</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Filesystem/Filesystem.html">Illuminate\Filesystem\Filesystem</a></td>
        <td><code>files</code></td>
    </tr>
    <tr>
        <td>Gate</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Contracts/Auth/Access/Gate.html">Illuminate\Contracts\Auth\Access\Gate</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>Hash</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Contracts/Hashing/Hasher.html">Illuminate\Contracts\Hashing\Hasher</a></td>
        <td><code>hash</code></td>
    </tr>
    <tr>
        <td>Http</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Http/Client/Factory.html">Illuminate\Http\Client\Factory</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>Lang</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Translation/Translator.html">Illuminate\Translation\Translator</a></td>
        <td><code>translator</code></td>
    </tr>
    <tr>
        <td>Log</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Log/LogManager.html">Illuminate\Log\LogManager</a></td>
        <td><code>log</code></td>
    </tr>
    <tr>
        <td>Mail</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Mail/Mailer.html">Illuminate\Mail\Mailer</a></td>
        <td><code>mailer</code></td>
    </tr>
    <tr>
        <td>Notification</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Notifications/ChannelManager.html">Illuminate\Notifications\ChannelManager</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>Password</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Auth/Passwords/PasswordBrokerManager.html">Illuminate\Auth\Passwords\PasswordBrokerManager</a></td>
        <td><code>auth.password</code></td>
    </tr>
    <tr>
        <td>Password (Instance)</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Auth/Passwords/PasswordBroker.html">Illuminate\Auth\Passwords\PasswordBroker</a></td>
        <td><code>auth.password.broker</code></td>
    </tr>
    <tr>
        <td>Queue</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Queue/QueueManager.html">Illuminate\Queue\QueueManager</a></td>
        <td><code>queue</code></td>
    </tr>
    <tr>
        <td>Queue (Instance)</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Contracts/Queue/Queue.html">Illuminate\Contracts\Queue\Queue</a></td>
        <td><code>queue.connection</code></td>
    </tr>
    <tr>
        <td>Queue (Base Class)</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Queue/Queue.html">Illuminate\Queue\Queue</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>Redirect</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Routing/Redirector.html">Illuminate\Routing\Redirector</a></td>
        <td><code>redirect</code></td>
    </tr>
    <tr>
        <td>Redis</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Redis/RedisManager.html">Illuminate\Redis\RedisManager</a></td>
        <td><code>redis</code></td>
    </tr>
    <tr>
        <td>Redis (Instance)</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Redis/Connections/Connection.html">Illuminate\Redis\Connections\Connection</a></td>
        <td><code>redis.connection</code></td>
    </tr>
    <tr>
        <td>Request</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Http/Request.html">Illuminate\Http\Request</a></td>
        <td><code>request</code></td>
    </tr>
    <tr>
        <td>Response</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Contracts/Routing/ResponseFactory.html">Illuminate\Contracts\Routing\ResponseFactory</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>Response (Instance)</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Http/Response.html">Illuminate\Http\Response</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>Route</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Routing/Router.html">Illuminate\Routing\Router</a></td>
        <td><code>router</code></td>
    </tr>
    <tr>
        <td>Schema</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Database/Schema/Builder.html">Illuminate\Database\Schema\Builder</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>Session</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Session/SessionManager.html">Illuminate\Session\SessionManager</a></td>
        <td><code>session</code></td>
    </tr>
    <tr>
        <td>Session (Instance)</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Session/Store.html">Illuminate\Session\Store</a></td>
        <td><code>session.store</code></td>
    </tr>
    <tr>
        <td>Storage</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Filesystem/FilesystemManager.html">Illuminate\Filesystem\FilesystemManager</a></td>
        <td><code>filesystem</code></td>
    </tr>
    <tr>
        <td>Storage (Instance)</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Contracts/Filesystem/Filesystem.html">Illuminate\Contracts\Filesystem\Filesystem</a></td>
        <td><code>filesystem.disk</code></td>
    </tr>
    <tr>
        <td>URL</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Routing/UrlGenerator.html">Illuminate\Routing\UrlGenerator</a></td>
        <td><code>url</code></td>
    </tr>
    <tr>
        <td>Validator</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Validation/Factory.html">Illuminate\Validation\Factory</a></td>
        <td><code>validator</code></td>
    </tr>
    <tr>
        <td>Validator (Instance)</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/Validation/Validator.html">Illuminate\Validation\Validator</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>View</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/View/Factory.html">Illuminate\View\Factory</a></td>
        <td><code>view</code></td>
    </tr>
    <tr>
        <td>View (Instance)</td>
        <td><a href="https://laravel.com/api/8.x/Illuminate/View/View.html">Illuminate\View\View</a></td>
        <td>&nbsp;</td>
    </tr>
    </tbody>
</table> 
