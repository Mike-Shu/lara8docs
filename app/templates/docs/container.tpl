<h1>Сервисный контейнер (Service Container)</h1>
<ul>
    <li><a href="container#introduction">Вступление</a>
        <ul>
            <li><a href="container#zero-configuration-resolution">Нулевое разрешение конфигурации</a></li>
            <li><a href="container#when-to-use-the-container">Когда использовать контейнер</a></li>
        </ul>
    </li>
    <li><a href="container#binding">Привязка</a>
        <ul>
            <li><a href="container#binding-basics">Основы привязки</a></li>
            <li><a href="container#binding-interfaces-to-implementations">Привязка интерфейсов к реализациям</a></li>
            <li><a href="container#contextual-binding">Контекстная привязка</a></li>
            <li><a href="container#binding-primitives">Связывание примитивов</a></li>
            <li><a href="container#binding-typed-variadics">Привязка типизированных переменных</a></li>
            <li><a href="container#tagging">Теги</a></li>
            <li><a href="container#extending-bindings">Расширение привязок</a></li>
        </ul>
    </li>
    <li><a href="container#resolving">Разрешение</a>
        <ul>
            <li><a href="container#the-make-method">Метод создания</a></li>
            <li><a href="container#automatic-injection">Автоматический впрыск</a></li>
        </ul>
    </li>
    <li><a href="container#container-events">События контейнера</a></li>
    <li><a href="container#psr-11">ПСР-11</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Сервисный контейнер Laravel - это мощный инструмент для управления зависимостями классов и выполнения внедрения
    зависимостей. Внедрение зависимостей - это причудливая фраза, которая по существу означает следующее: зависимости
    классов «вводятся» в класс через конструктор или, в некоторых случаях, методы «установки».</p>
<p>Давайте посмотрим на простой пример:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>Controller</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Repositories<span
                        class="token punctuation">\</span>UserRepository</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">UserController</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * The user repository implementation.
    *
    * @var UserRepository
    */</span>
    <span class="token keyword">protected</span> <span class="token variable">$users</span><span class="token punctuation">;</span>

    <span class="token comment">/**
    * Create a new controller instance.
    *
    * @param  UserRepository  $users
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">__construct</span><span class="token punctuation">(</span>UserRepository <span class="token variable">$users</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">users</span> <span class="token operator">=</span> <span class="token variable">$users</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
    * Show the profile for the given user.
    *
    * @param  int  $id
    * @return Response
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">show</span><span class="token punctuation">(</span><span class="token variable">$id</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$user</span> <span class="token operator">=</span> <span class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">users</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">find</span><span class="token punctuation">(</span><span class="token variable">$id</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token keyword">return</span> <span class="token function">view</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'user.profile'</span><span class="token punctuation">,</span> <span class="token punctuation">[</span><span class="token single-quoted-string string">'user'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token variable">$user</span><span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>В этом примере <code>UserController</code> необходимо получить пользователей из источника данных. Итак, мы <strong>внедрим</strong>
    службу, которая может получать пользователей. В этом контексте мы, <code>UserRepository</code> скорее всего,
    используем <a href="eloquent">Eloquent</a> для извлечения информации о пользователях из базы данных. Однако,
    поскольку репозиторий внедрен, мы можем легко заменить его другой реализацией. Мы также можем легко «имитировать»
    или создать фиктивную реализацию класса <code>UserRepository</code> при тестировании нашего приложения.</p>
<p>Глубокое понимание сервисного контейнера Laravel необходимо для создания мощного, большого приложения, а также для
    внесения вклада в само ядро Laravel.</p>
<p></p>
<h3 id="zero-configuration-resolution"><a href="#zero-configuration-resolution">Нулевое разрешение конфигурации</a></h3>
<p>Если класс не имеет зависимостей или зависит только от других конкретных классов (не интерфейсов), контейнер не нужно
    инструктировать о том, как разрешить этот класс. Например, вы можете поместить в свой <code>routes/web.php</code> файл
    следующий код :</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">class</span> <span class="token class-name">Service</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">get</span><span class="token punctuation">(</span><span
                    class="token single-quoted-string string">'/'</span><span class="token punctuation">,</span> <span
                    class="token keyword">function</span> <span class="token punctuation">(</span>Service <span
                    class="token variable">$service</span><span class="token punctuation">)</span> <span
                    class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">die</span><span class="token punctuation">(</span><span class="token function">get_class</span><span class="token punctuation">(</span><span class="token variable">$service</span><span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span></span></code></pre>
<p>В этом примере попадание в <code>/</code> маршрут вашего приложения автоматически разрешит <code>Service</code> класс и
    вставит его в обработчик вашего маршрута. Это меняет правила игры. Это означает, что вы можете разработать свое
    приложение и воспользоваться преимуществами внедрения зависимостей, не беспокоясь о раздутых файлах конфигурации.
</p>
<p>К счастью, многие классы, которые вы напишете при создании приложения Laravel, автоматически получают свои
    зависимости через контейнер, включая <a href="controllers">контроллеры</a>, <a href="events">прослушиватели
        событий</a>, <a href="middleware">промежуточное ПО</a> и т. Д. Кроме того, вы можете указать зависимости в
    <code>handle</code> методе <a href="queues">задания</a> в <a href="queues">очереди</a>. Как только вы почувствуете
    всю мощь автоматической инъекции зависимостей с нулевой конфигурацией, вы почувствуете невозможность разработки без
    нее.</p>
<p></p>
<h3 id="when-to-use-the-container"><a href="#when-to-use-the-container">Когда использовать контейнер</a></h3>
<p>Благодаря нулевому разрешению конфигурации вы часто будете указывать зависимости типа на маршрутах, контроллерах,
    прослушивателях событий и других местах, даже не взаимодействуя с контейнером вручную. Например, вы можете ввести
    <code>Illuminate\Http\Request</code> объект в определении маршрута, чтобы легко получить доступ к текущему запросу.
    Несмотря на то, что нам никогда не нужно взаимодействовать с контейнером для написания этого кода, он управляет
    внедрением этих зависимостей за кулисами:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span>Request <span
                class="token variable">$request</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Во многих случаях, благодаря инъекции автоматической зависимости и <a href="facades">фасадов</a>, вы можете
    создавать приложения Laravel без <strong>когда-либо</strong> вручную связывания или разрешения что-либо из
    контейнера. <strong>Итак, когда бы вы когда-нибудь вручную взаимодействовали с контейнером?</strong> Рассмотрим две
    ситуации.</p>
<p>Во-первых, если вы пишете класс, реализующий интерфейс, и хотите <a
            href="container#binding-interfaces-to-implementations">указать</a> тип этого интерфейса в конструкторе
    маршрута или класса, вы должны <a href="container#binding-interfaces-to-implementations">сообщить контейнеру, как
        разрешить этот интерфейс</a>. Во-вторых, если вы <a href="packages">пишете пакет Laravel,</a> которым
    планируете поделиться с другими разработчиками Laravel, вам может потребоваться привязать службы вашего пакета к
    контейнеру.</p>
<p></p>
<h2 id="binding"><a href="#binding">Привязка</a></h2>
<p></p>
<h3 id="binding-basics"><a href="#binding-basics">Основы привязки</a></h3>
<p></p>
<h4 id="simple-bindings"><a href="#simple-bindings">Простые привязки</a></h4>
<p>Почти все привязки вашего сервисного контейнера будут зарегистрированы у <a href="providers">сервис-провайдеров</a>,
    поэтому в большинстве этих примеров будет продемонстрировано использование контейнера в этом контексте.</p>
<p>Внутри поставщика услуг у вас всегда есть доступ к контейнеру через <code>$this-&gt;app</code> свойство. Мы можем
    зарегистрировать привязку с помощью <code>bind</code> метода, передав имя класса или интерфейса, которые мы хотим
    зарегистрировать, вместе с закрытием, которое возвращает экземпляр класса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Services<span
                    class="token punctuation">\</span>Transistor</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Services<span
                    class="token punctuation">\</span>PodcastParser</span><span class="token punctuation">;</span>

<span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">app</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">bind</span><span class="token punctuation">(</span>Transistor<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$app</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token keyword">new</span> <span class="token class-name">Transistor</span><span class="token punctuation">(</span><span class="token variable">$app</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">make</span><span class="token punctuation">(</span>PodcastParser<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Обратите внимание, что мы получаем сам контейнер в качестве аргумента для распознавателя. Затем мы можем использовать
    контейнер для разрешения подчиненных зависимостей объекта, который мы создаем.</p>
<p>Как уже упоминалось, вы обычно будете взаимодействовать с контейнером внутри поставщиков услуг; однако, если вы
    хотите взаимодействовать с контейнером вне поставщика услуг, вы можете сделать это через <code>App</code>  <a
            href="facades">фасад</a> :</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Services<span
                    class="token punctuation">\</span>Transistor</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>App</span><span
                class="token punctuation">;</span>

App<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">bind</span><span class="token punctuation">(</span>Transistor<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$app</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Нет необходимости привязывать классы к контейнеру, если они не зависят от каких-либо интерфейсов. Контейнер
            не нужно указывать, как создавать эти объекты, поскольку он может автоматически разрешать эти объекты с
            помощью отражения.</p></p></div>
</blockquote>
<p></p>
<h4 id="binding-a-singleton"><a href="#binding-a-singleton">Связывание синглтона</a></h4>
<p><code>singleton</code> Метод связывает класс или интерфейс в контейнер, который должен быть разрешен только один раз.
    Как только привязка singleton разрешена, тот же экземпляр объекта будет возвращен при последующих вызовах
    контейнера:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Services<span
                    class="token punctuation">\</span>Transistor</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Services<span
                    class="token punctuation">\</span>PodcastParser</span><span class="token punctuation">;</span>

<span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">app</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">singleton</span><span
                class="token punctuation">(</span>Transistor<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$app</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token keyword">new</span> <span class="token class-name">Transistor</span><span class="token punctuation">(</span><span class="token variable">$app</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">make</span><span class="token punctuation">(</span>PodcastParser<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="binding-instances"><a href="#binding-instances">Привязка экземпляров</a></h4>
<p>Вы также можете привязать существующий экземпляр объекта к контейнеру, используя этот <code>instance</code> метод.
    Данный экземпляр всегда будет возвращаться при последующих вызовах контейнера:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Services<span
                    class="token punctuation">\</span>Transistor</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Services<span
                    class="token punctuation">\</span>PodcastParser</span><span class="token punctuation">;</span>

<span class="token variable">$service</span> <span class="token operator">=</span> <span
                class="token keyword">new</span> <span class="token class-name">Transistor</span><span
                class="token punctuation">(</span><span class="token keyword">new</span> <span class="token class-name">PodcastParser</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">app</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">instance</span><span
                class="token punctuation">(</span>Transistor<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token variable">$service</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="binding-interfaces-to-implementations"><a href="#binding-interfaces-to-implementations">Привязка интерфейсов к
        реализациям</a></h3>
<p>Очень мощная функция контейнера служб - это его способность связывать интерфейс с заданной реализацией. Например,
    предположим, что у нас есть <code>EventPusher</code> интерфейс и <code>RedisEventPusher</code> реализация. После того,
    как мы закодировали нашу <code>RedisEventPusher</code> реализацию этого интерфейса, мы можем зарегистрировать ее в
    сервисном контейнере следующим образом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Contracts<span
                    class="token punctuation">\</span>EventPusher</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Services<span
                    class="token punctuation">\</span>RedisEventPusher</span><span class="token punctuation">;</span>

<span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">app</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">bind</span><span class="token punctuation">(</span>EventPusher<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> RedisEventPusher<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Этот оператор сообщает контейнеру, что он должен внедрить, <code>RedisEventPusher</code> когда классу требуется
    реализация <code>EventPusher</code>. Теперь мы можем указать <code>EventPusher</code> интерфейс в конструкторе
    класса, который разрешается контейнером. Помните, что контроллеры, прослушиватели событий, промежуточное ПО и
    различные другие типы классов в приложениях Laravel всегда разрешаются с помощью контейнера:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Contracts<span
                    class="token punctuation">\</span>EventPusher</span><span class="token punctuation">;</span>

<span class="token comment">/**
 * Create a new class instance.
 *
 * @param  \App\Contracts\EventPusher  $pusher
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">__construct</span><span
                class="token punctuation">(</span>EventPusher <span class="token variable">$pusher</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">pusher</span> <span class="token operator">=</span> <span class="token variable">$pusher</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="contextual-binding"><a href="#contextual-binding">Контекстная привязка</a></h3>
<p>Иногда у вас может быть два класса, которые используют один и тот же интерфейс, но вы хотите внедрить разные
    реализации в каждый класс. Например, два контроллера могут зависеть от разных реализаций <code>Illuminate\Contracts\Filesystem\Filesystem</code> 
    <a href="contracts">контракта</a>. Laravel предоставляет простой и понятный интерфейс для определения этого
    поведения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>PhotoController</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>UploadController</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>VideoController</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                    class="token punctuation">\</span>Filesystem<span
                    class="token punctuation">\</span>Filesystem</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Storage</span><span
                class="token punctuation">;</span>

<span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">app</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">when</span><span class="token punctuation">(</span>PhotoController<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span>
          <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">needs</span><span
                class="token punctuation">(</span>Filesystem<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span>
          <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">give</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> Storage<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">disk</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'local'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
          <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">app</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">when</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span>VideoController<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> UploadController<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span>
          <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">needs</span><span
                class="token punctuation">(</span>Filesystem<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span>
          <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">give</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> Storage<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">disk</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'s3'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
          <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="binding-primitives"><a href="#binding-primitives">Связывание примитивов</a></h3>
<p>Иногда у вас может быть класс, который получает некоторые внедренные классы, но также требует внедренного
    примитивного значения, такого как целое число. Вы можете легко использовать контекстную привязку, чтобы ввести любое
    значение, которое может понадобиться вашему классу:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">app</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">when</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'App\Http\Controllers\UserController'</span><span
                class="token punctuation">)</span>
          <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">needs</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'$variableName'</span><span
                class="token punctuation">)</span>
          <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">give</span><span class="token punctuation">(</span><span class="token variable">$value</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Иногда класс может зависеть от массива <a href="container#tagging">помеченных</a> экземпляров. Используя этот <code>giveTagged</code> метод,
    вы можете легко внедрить все привязки контейнера с этим тегом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">app</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">when</span><span
                class="token punctuation">(</span>ReportAggregator<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">needs</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'$reports'</span><span class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">giveTagged</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'reports'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="binding-typed-variadics"><a href="#binding-typed-variadics">Привязка типизированных переменных</a></h3>
<p>Иногда у вас может быть класс, который получает массив типизированных объектов с использованием аргумента
    вариативного конструктора:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span
                        class="token punctuation">\</span>Filter</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Services<span
                        class="token punctuation">\</span>Logger</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">Firewall</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * The logger instance.
    *
    * @var \App\Services\Logger
    */</span>
    <span class="token keyword">protected</span> <span class="token variable">$logger</span><span class="token punctuation">;</span>

    <span class="token comment">/**
    * The filter instances.
    *
    * @var array
    */</span>
    <span class="token keyword">protected</span> <span class="token variable">$filters</span><span class="token punctuation">;</span>

    <span class="token comment">/**
    * Create a new class instance.
    *
    * @param  \App\Services\Logger  $logger
    * @param  array  $filters
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">__construct</span><span class="token punctuation">(</span>Logger <span class="token variable">$logger</span><span class="token punctuation">,</span> Filter <span class="token punctuation">.</span><span class="token punctuation">.</span><span class="token punctuation">.</span><span class="token variable">$filters</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">logger</span> <span class="token operator">=</span> <span class="token variable">$logger</span><span class="token punctuation">;</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">filters</span> <span class="token operator">=</span> <span class="token variable">$filters</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Используя контекстную привязку, вы можете разрешить эту зависимость, предоставив <code>give</code> методу замыкание,
    которое возвращает массив разрешенных <code>Filter</code> экземпляров:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">app</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">when</span><span
                class="token punctuation">(</span>Firewall<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span>
          <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">needs</span><span
                class="token punctuation">(</span>Filter<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span>
          <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">give</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$app</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
                <span class="token keyword">return</span> <span class="token punctuation">[</span>
                    <span class="token variable">$app</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">make</span><span class="token punctuation">(</span>NullFilter<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
                    <span class="token variable">$app</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">make</span><span class="token punctuation">(</span>ProfanityFilter<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
                    <span class="token variable">$app</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">make</span><span class="token punctuation">(</span>TooLongFilter<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
                <span class="token punctuation">]</span><span class="token punctuation">;</span>
          <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Для удобства вы также можете просто предоставить массив имен классов, который будет разрешаться контейнером всякий
    раз, когда <code>Firewall</code> требуются <code>Filter</code> экземпляры:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">app</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">when</span><span
                class="token punctuation">(</span>Firewall<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span>
          <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">needs</span><span
                class="token punctuation">(</span>Filter<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span>
          <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">give</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span>
              NullFilter<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span><span class="token punctuation">,</span>
              ProfanityFilter<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span><span class="token punctuation">,</span>
              TooLongFilter<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span><span class="token punctuation">,</span>
          <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="variadic-tag-dependencies"><a href="#variadic-tag-dependencies">Вариативные зависимости тегов</a></h4>
<p>Иногда у класса может быть вариативная зависимость, указывающая на тип как данный class ( <code>Report ...$reports</code> ).
    Использование <code>needs</code> и <code>giveTagged</code> метод, вы можете легко вводить все
    контейнерные переплетах с этой <a href="container#tagging">меткой</a> для данной зависимости:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">app</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">when</span><span
                class="token punctuation">(</span>ReportAggregator<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">needs</span><span class="token punctuation">(</span>Report<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">giveTagged</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'reports'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="tagging"><a href="#tagging">Теги</a></h3>
<p>Иногда может потребоваться разрешить все привязки определенной «категории». Например, возможно, вы создаете
    анализатор отчетов, который получает массив из множества различных <code>Report</code> реализаций интерфейса. После
    регистрации <code>Report</code> реализаций вы можете присвоить им тег с помощью <code>tag</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">app</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">bind</span><span
                class="token punctuation">(</span>CpuReport<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">app</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">bind</span><span class="token punctuation">(</span>MemoryReport<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">app</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">tag</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span>CpuReport<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> MemoryReport<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'reports'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>После того, как сервисы были помечены, вы можете легко разрешить их все с помощью <code>tagged</code> метода
    контейнера :</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">app</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">bind</span><span
                class="token punctuation">(</span>ReportAnalyzer<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$app</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token keyword">new</span> <span class="token class-name">ReportAnalyzer</span><span class="token punctuation">(</span><span class="token variable">$app</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">tagged</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'reports'</span><span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="extending-bindings"><a href="#extending-bindings">Расширение привязок</a></h3>
<p><code>extend</code> Метод позволяет модификацию решенных услуг. Например, когда служба разрешена, вы можете запустить
    дополнительный код для украшения или настройки службы. <code>extend</code> Метод принимает замыкание, которое должно
    вернуть модифицированную услугу, в качестве единственного аргумента. Замыкание получает разрешаемую службу и
    экземпляр контейнера:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">app</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">extend</span><span
                class="token punctuation">(</span>Service<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$service</span><span
                class="token punctuation">,</span> <span class="token variable">$app</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token keyword">new</span> <span class="token class-name">DecoratedService</span><span class="token punctuation">(</span><span class="token variable">$service</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="resolving"><a href="#resolving">Разрешение</a></h2>
<p></p>
<h3 id="the-make-method"><a href="#the-make-method"><code>make</code> Метод</a></h3>
<p>Вы можете использовать этот <code>make</code> метод для разрешения экземпляра класса из контейнера. <code>make</code> Метод
    принимает имя класса или интерфейса, который вы хотите, чтобы решить:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Services<span
                    class="token punctuation">\</span>Transistor</span><span class="token punctuation">;</span>

<span class="token variable">$transistor</span> <span class="token operator">=</span> <span
                class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">app</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">make</span><span
                class="token punctuation">(</span>Transistor<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если некоторые из зависимостей вашего класса не могут быть разрешены через контейнер, вы можете ввести их, передав их
    как ассоциативный массив в <code>makeWith</code> метод. Например, мы можем вручную передать <code>$id</code> аргумент
    конструктора, необходимый для <code>Transistor</code> службы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Services<span
                    class="token punctuation">\</span>Transistor</span><span class="token punctuation">;</span>

<span class="token variable">$transistor</span> <span class="token operator">=</span> <span
                class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">app</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">makeWith</span><span
                class="token punctuation">(</span>Transistor<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">1</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Если вы находитесь за пределами поставщика услуг в том месте вашего кода, которое не имеет доступа к
    <code>$app</code> переменной, вы можете использовать <code>App</code>  <a href="facades">фасад</a> для разрешения
    экземпляра класса из контейнера:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Services<span
                    class="token punctuation">\</span>Transistor</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>App</span><span
                class="token punctuation">;</span>

<span class="token variable">$transistor</span> <span class="token operator">=</span> App<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">make</span><span
                class="token punctuation">(</span>Transistor<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если вы хотите, чтобы сам экземпляр контейнера Laravel был внедрен в класс, который разрешается контейнером, вы
    можете ввести <code>Illuminate\Container\Container</code> класс в конструкторе вашего класса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Container<span
                    class="token punctuation">\</span>Container</span><span class="token punctuation">;</span>

<span class="token comment">/**
 * Create a new class instance.
 *
 * @param  \Illuminate\Container\Container
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">__construct</span><span
                class="token punctuation">(</span>Container <span class="token variable">$container</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">container</span> <span class="token operator">=</span> <span class="token variable">$container</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="automatic-injection"><a href="#automatic-injection">Автоматический впрыск</a></h3>
<p>В качестве альтернативы, что важно, вы можете указать тип зависимости в конструкторе класса, который разрешается
    контейнером, включая <a href="controllers">контроллеры</a>, <a href="events">прослушиватели событий</a>, <a
            href="middleware">промежуточное ПО</a> и т. Д. Кроме того, вы можете указать зависимости в
    <code>handle</code> методе <a href="queues">задания</a> в <a href="queues">очереди</a>. На практике именно так
    контейнер должен разрешать большинство ваших объектов.</p>
<p>Например, вы можете указать репозиторий, определенный вашим приложением, в конструкторе контроллера. Репозиторий
    будет автоматически разрешен и введен в класс:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Repositories<span
                        class="token punctuation">\</span>UserRepository</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">UserController</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * The user repository instance.
    *
    * @var \App\Repositories\UserRepository
    */</span>
    <span class="token keyword">protected</span> <span class="token variable">$users</span><span class="token punctuation">;</span>

    <span class="token comment">/**
    * Create a new controller instance.
    *
    * @param  \App\Repositories\UserRepository  $users
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">__construct</span><span class="token punctuation">(</span>UserRepository <span class="token variable">$users</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">users</span> <span class="token operator">=</span> <span class="token variable">$users</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
    * Show the user with the given ID.
    *
    * @param  int  $id
    * @return \Illuminate\Http\Response
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">show</span><span class="token punctuation">(</span><span class="token variable">$id</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h2 id="container-events"><a href="#container-events">События контейнера</a></h2>
<p>Сервисный контейнер запускает событие каждый раз, когда разрешает объект. Вы можете прослушать это событие, используя
    <code>resolving</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Services<span
                    class="token punctuation">\</span>Transistor</span><span class="token punctuation">;</span>

<span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">app</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">resolving</span><span
                class="token punctuation">(</span>Transistor<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$transistor</span><span
                class="token punctuation">,</span> <span class="token variable">$app</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// Called when container resolves objects of type "Transistor"...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">app</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">resolving</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$object</span><span
                class="token punctuation">,</span> <span class="token variable">$app</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// Called when container resolves object of any type...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Как видите, решаемый объект будет передан в обратный вызов, что позволит вам установить любые дополнительные свойства
    объекта, прежде чем он будет передан его потребителю.</p>
<p></p>
<h2 id="psr-11"><a href="#psr-11">PSR-11</a></h2>
<p>Сервисный контейнер Laravel реализует интерфейс <a
            href="https://translate.google.com/website?sl=en&amp;tl=ru&amp;prev=search&amp;u=https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-11-container.md">PSR-11</a>.
    Поэтому вы можете ввести подсказку к интерфейсу контейнера PSR-11, чтобы получить экземпляр контейнера Laravel:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Services<span
                    class="token punctuation">\</span>Transistor</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Psr<span
                    class="token punctuation">\</span>Container<span class="token punctuation">\</span>ContainerInterface</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span>ContainerInterface <span
                class="token variable">$container</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$service</span> <span class="token operator">=</span> <span class="token variable">$container</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">get</span><span class="token punctuation">(</span>Transistor<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Если данный идентификатор не может быть разрешен, создается исключение. Исключением будет случай, <code>Psr\Container\NotFoundExceptionInterface</code> если
    идентификатор никогда не был привязан. Если идентификатор был привязан, но не может быть разрешен, <code>Psr\Container\ContainerExceptionInterface</code> будет
    брошен экземпляр.</p> 
