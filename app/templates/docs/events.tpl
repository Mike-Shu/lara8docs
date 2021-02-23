<h1>События</h1>
<ul>
    <li><a href="events#introduction">Вступление</a></li>
    <li><a href="events#registering-events-and-listeners">Регистрация событий и слушателей</a>
        <ul>
            <li><a href="events#generating-events-and-listeners">Создание событий и слушателей</a></li>
            <li><a href="events#manually-registering-events">Ручная регистрация событий</a></li>
            <li><a href="events#event-discovery">Обнаружение событий</a></li>
        </ul>
    </li>
    <li><a href="events#defining-events">Определение событий</a></li>
    <li><a href="events#defining-listeners">Определение слушателей</a></li>
    <li><a href="events#queued-event-listeners">Слушатели событий в очереди</a>
        <ul>
            <li><a href="events#manually-interacting-the-queue">Взаимодействие с очередью вручную</a></li>
            <li><a href="events#queued-event-listeners-and-database-transactions">Слушатели событий в очереди и
                    транзакции базы данных</a></li>
            <li><a href="events#handling-failed-jobs">Обработка невыполненных заданий</a></li>
        </ul>
    </li>
    <li><a href="events#dispatching-events">Отправка событий</a></li>
    <li><a href="events#event-subscribers">Подписчики событий</a>
        <ul>
            <li><a href="events#writing-event-subscribers">Написание подписчиков на события</a></li>
            <li><a href="events#registering-event-subscribers">Регистрация подписчиков на события</a></li>
        </ul>
    </li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>События Laravel обеспечивают простую реализацию шаблона Наблюдатель, позволяя вам подписываться и отслеживать
    различные события, происходящие в вашем приложении. Классы событий обычно хранятся в каталоге <code>app/Events</code>,
    а их слушатели - в <code>app/Listeners</code>. Не беспокойтесь, если вы не видите эти каталоги в своем
    приложении, так как они будут созданы, когда вы сгенерируете события и слушатели с помощью Artisan-команд.</p>
<p>События служат отличным способом разделения различных аспектов вашего приложения, поскольку одно событие может иметь
    несколько слушателей, которые не зависят друг от друга. Например, вы можете захотеть отправлять уведомление Slack
    своему пользователю каждый раз, когда заказ будет отправлен. Вместо того, чтобы связывать код обработки заказа с
    кодом уведомления Slack, вы можете вызвать событие <code>App\Events\OrderShipped</code>, которое слушатель может
    получить и использовать для отправки уведомления Slack.</p>
<p></p>
<h2 id="registering-events-and-listeners"><a href="#registering-events-and-listeners">Регистрация событий и
        слушателей</a></h2>
<p><code>App\Providers\EventServiceProvider</code> В комплекте с приложением Laravel обеспечивает удобное место для
    регистрации всех слушателей событий вашего приложения. <code>listen</code> Свойство содержит массив всех событий
    (ключи) и их слушателей (значения). Вы можете добавить в этот массив столько событий, сколько требуется вашему
    приложению. Например, добавим <code>OrderShipped</code> событие:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Events<span
                    class="token punctuation">\</span>OrderShipped</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Listeners<span class="token punctuation">\</span>SendShipmentNotification</span><span
                class="token punctuation">;</span>

<span class="token comment">/**
 * The event listener mappings for the application.
 *
 * @var array
 */</span>
<span class="token keyword">protected</span> <span class="token variable">$listen</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span>
    OrderShipped<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token punctuation">[</span>
        SendShipmentNotification<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Команда <code>event:list</code> может использоваться для отображения списка всех событий и прослушивателей,
            зарегистрированных вашим приложением.</p></p></div>
</blockquote>
<p></p>
<h3 id="generating-events-and-listeners"><a href="#generating-events-and-listeners">Создание событий и слушателей</a>
</h3>
<p>Конечно, вручную создавать файлы для каждого события и прослушивателя сложно. Вместо этого добавьте слушателей и
    события в ваш <code>EventServiceProvider</code> и используйте команду <code>event:generate</code> Artisan. Эта
    команда сгенерирует любые события или прослушиватели, которые перечислены в вашем <code>EventServiceProvider</code>,
    но еще не существуют:</p>
<pre class=" language-php"><code class=" language-php">php artisan event<span class="token punctuation">:</span>generate</code></pre>
<p>Кроме того, вы можете использовать <code>make:event</code> и <code>make:listener</code> команды Artisan для создания
    отдельных событий и слушателей:</p>
<pre class=" language-php"><code class=" language-php">php artisan make<span class="token punctuation">:</span>event PodcastProcessed

php artisan make<span class="token punctuation">:</span>listener SendPodcastNotification <span
                class="token operator">--</span>event<span class="token operator">=</span>PodcastProcessed</code></pre>
<p></p>
<h3 id="manually-registering-events"><a href="#manually-registering-events">Ручная регистрация событий</a></h3>
<p>Обычно события должны регистрироваться через <code>EventServiceProvider</code> <code>$listen</code> массив; однако вы
    также можете зарегистрировать прослушиватели событий на основе классов или замыканий вручную в <code>boot</code>
    методе вашего <code>EventServiceProvider</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Events<span
                    class="token punctuation">\</span>PodcastProcessed</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Listeners<span class="token punctuation">\</span>SendPodcastNotification</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Event</span><span
                class="token punctuation">;</span>

<span class="token comment">/**
 * Register any other events for your application.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">boot</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    Event<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">listen</span><span
                class="token punctuation">(</span>
        PodcastProcessed<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span><span class="token punctuation">,</span>
        <span class="token punctuation">[</span>SendPodcastNotification<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'handle'</span><span
                class="token punctuation">]</span>
    <span class="token punctuation">)</span><span class="token punctuation">;</span>
    
    Event<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">listen</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span>PodcastProcessed <span class="token variable">$event</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="queuable-anonymous-event-listeners"><a href="#queuable-anonymous-event-listeners">Слушатели анонимных событий в
        очереди</a></h4>
<p>При регистрации слушателей событий, основанных на закрытии, вручную, вы можете заключить закрытие слушателя в <code>Illuminate\Events\queueable</code>
    функцию, чтобы дать Laravel команду выполнить прослушиватель с использованием <a href="queues">очереди</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Events<span
                    class="token punctuation">\</span>PodcastProcessed</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">function</span> Illuminate\<span
                class="token package">Events<span class="token punctuation">\</span>queueable</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Event</span><span
                class="token punctuation">;</span>

<span class="token comment">/**
 * Register any other events for your application.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">boot</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    Event<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">listen</span><span
                class="token punctuation">(</span><span class="token function">queueable</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span>PodcastProcessed <span class="token variable">$event</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Как очереди заданий, вы можете использовать <code>onConnection</code>, <code>onQueue</code> и <code>delay</code>
    методы, чтобы настроить выполнение очереди слушателя:</p>
<pre class=" language-php"><code class=" language-php">Event<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">listen</span><span
                class="token punctuation">(</span><span class="token function">queueable</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span>PodcastProcessed <span class="token variable">$event</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">onConnection</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'redis'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">onQueue</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'podcasts'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">delay</span><span
                class="token punctuation">(</span><span class="token function">now</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">addSeconds</span><span
                class="token punctuation">(</span><span class="token number">10</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если вы хотите обрабатывать сбои анонимного прослушивателя в очереди, вы можете обеспечить закрытие
    <code>catch</code> метода при определении <code>queueable</code> прослушивателя. Это закрытие получит экземпляр
    события и <code>Throwable</code> экземпляр, вызвавший отказ слушателя:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Events<span
                    class="token punctuation">\</span>PodcastProcessed</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">function</span> Illuminate\<span
                class="token package">Events<span class="token punctuation">\</span>queueable</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Event</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Throwable</span><span
                class="token punctuation">;</span>

Event<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">listen</span><span class="token punctuation">(</span><span
                class="token function">queueable</span><span class="token punctuation">(</span><span
                class="token keyword">function</span> <span class="token punctuation">(</span>PodcastProcessed <span
                class="token variable">$event</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token keyword">catch</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span>PodcastProcessed <span class="token variable">$event</span><span
                class="token punctuation">,</span> Throwable <span class="token variable">$e</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// The queued listener failed...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="wildcard-event-listeners"><a href="#wildcard-event-listeners">Слушатели событий с подстановочными знаками</a>
</h4>
<p>Вы даже можете зарегистрировать слушателей, используя параметр <code>*</code> в качестве подстановочного знака, что
    позволит вам перехватывать несколько событий на одном слушателе. Слушатели подстановочных знаков получают имя
    события в качестве первого аргумента и весь массив данных события в качестве второго аргумента:</p>
<pre class=" language-php"><code class=" language-php">Event<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">listen</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'event.*'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$eventName</span><span
                class="token punctuation">,</span> <span class="token keyword">array</span> <span
                class="token variable">$data</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="event-discovery"><a href="#event-discovery">Обнаружение событий</a></h3>
<p>Вместо того, чтобы вручную регистрировать события и прослушиватели в <code>$listen</code> массиве <code>EventServiceProvider</code>,
    вы можете включить автоматическое обнаружение событий. Когда обнаружение событий включено, Laravel автоматически
    найдет и зарегистрирует ваши события и слушателей, сканируя <code>Listeners</code> каталог вашего приложения. Кроме
    того, любые явно определенные события, перечисленные в списке, по- <code>EventServiceProvider</code> прежнему будут
    регистрироваться.</p>
<p>Laravel находит слушателей событий, сканируя классы слушателей с помощью служб отражения PHP. Когда Laravel находит
    какой-либо метод класса слушателя, который начинается с <code>handle</code>, Laravel зарегистрирует эти методы как
    слушатели событий для события, тип которого указан в сигнатуре метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Events<span
                    class="token punctuation">\</span>PodcastProcessed</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">SendPodcastNotification</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Handle the given event.
    *
    * @param  \App\Events\PodcastProcessed
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">handle</span><span
                class="token punctuation">(</span>PodcastProcessed <span class="token variable">$event</span><span
                class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></code></pre>
<p>Обнаружение событий отключено по умолчанию, но вы можете включить его, переопределив
    <code>shouldDiscoverEvents</code> метод вашего приложения <code>EventServiceProvider</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Determine if events and listeners should be automatically discovered.
 *
 * @return bool
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">shouldDiscoverEvents</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token boolean constant">true</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>По умолчанию все слушатели в каталоге вашего приложения <code>app/Listeners</code> будут сканироваться. Если вы
    хотите определить дополнительные каталоги для сканирования, вы можете переопределить
    <code>discoverEventsWithin</code> метод в своем <code>EventServiceProvider</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the listener directories that should be used to discover events.
 *
 * @return array
 */</span>
<span class="token keyword">protected</span> <span class="token keyword">function</span> <span class="token function">discoverEventsWithin</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">[</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">app</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">path</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Listeners'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="event-discovery-in-production"><a href="#event-discovery-in-production">Обнаружение событий в производстве</a>
</h4>
<p>В производственной среде для фреймворка неэффективно сканировать всех ваших слушателей по каждому запросу.
    Следовательно, во время процесса развертывания вы должны запустить команду <code>event:cache</code> Artisan, чтобы
    кэшировать манифест всех событий и слушателей вашего приложения. Этот манифест будет использоваться платформой для
    ускорения процесса регистрации события. Команда <code>event:clear</code> может использоваться для уничтожения кеша.
</p>
<p></p>
<h2 id="defining-events"><a href="#defining-events">Определение событий</a></h2>
<p>Класс событий - это, по сути, контейнер данных, который содержит информацию, относящуюся к событию. Например,
    предположим, что <code>App\Events\OrderShipped</code> событие получает объект <a href="eloquent">Eloquent ORM</a>:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Events</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span
                        class="token punctuation">\</span>Order</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Broadcasting<span
                        class="token punctuation">\</span>InteractsWithSockets</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Events<span
                        class="token punctuation">\</span>Dispatchable</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>SerializesModels</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">OrderShipped</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">use</span> <span class="token package">Dispatchable</span><span
                    class="token punctuation">,</span> InteractsWithSockets<span class="token punctuation">,</span> SerializesModels<span
                    class="token punctuation">;</span>

    <span class="token comment">/**
    * The order instance.
    *
    * @var \App\Models\Order
    */</span>
    <span class="token keyword">public</span> <span class="token variable">$order</span><span class="token punctuation">;</span>

    <span class="token comment">/**
    * Create a new event instance.
    *
    * @param  \App\Models\Order  $order
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">__construct</span><span
                    class="token punctuation">(</span>Order <span class="token variable">$order</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token property">order</span> <span
                    class="token operator">=</span> <span class="token variable">$order</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Как видите, в этом классе событий нет логики. Это контейнер для <code>App\Models\Order</code> приобретенного
    экземпляра. <code>SerializesModels</code> Черта используется событие будет корректно сериализовать любые модели
    красноречива, если объект события сериализации с помощью РНР <code>serialize</code> функции, например, при
    использовании в <a href="events#queued-event-listeners">очередь слушателей</a>.</p>
<p></p>
<h2 id="defining-listeners"><a href="#defining-listeners">Определение слушателей</a></h2>
<p>Затем давайте посмотрим на слушателя для нашего примера события. Слушатели событий получают экземпляры событий в
    своем <code>handle</code> методе. В <code>event:generate</code> и <code>make:listener</code> команде Artisan будет
    автоматически импортировать собственный класс событий и типа-намекает событие на <code>handle</code> методе. В
    рамках <code>handle</code> метода вы можете выполнять любые действия, необходимые для ответа на событие:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Listeners</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Events<span
                        class="token punctuation">\</span>OrderShipped</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">SendShipmentNotification</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Create the event listener.
    *
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">__construct</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
    * Handle the event.
    *
    * @param  \App\Events\OrderShipped  $event
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">handle</span><span
                    class="token punctuation">(</span>OrderShipped <span class="token variable">$event</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">// Access the order using $event-&gt;order...</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Ваши слушатели событий также могут указывать любые зависимости, которые им нужны, от их конструкторов. Все
            прослушиватели событий разрешаются через <a href="container">сервисный контейнер</a> Laravel, поэтому
            зависимости будут внедрены автоматически.</p></p></div>
</blockquote>
<p></p>
<h4 id="stopping-the-propagation-of-an-event"><a href="#stopping-the-propagation-of-an-event">Остановка распространения
        события</a></h4>
<p>Иногда вы можете захотеть остановить распространение события среди других слушателей. Вы можете сделать это,
    вернувшись <code>false</code> из <code>handle</code> метода вашего слушателя.</p>
<p></p>
<h2 id="queued-event-listeners"><a href="#queued-event-listeners">Слушатели событий в очереди</a></h2>
<p>Слушатели очереди могут быть полезны, если ваш слушатель собирается выполнять медленную задачу, такую ​​как отправка
    электронной почты или выполнение HTTP-запроса. Перед использованием прослушивателей в очереди обязательно <a
            href="queues">настройте очередь</a> и запустите обработчик очереди на своем сервере или в локальной среде
    разработки.</p>
<p>Чтобы указать, что слушатель должен быть поставлен в очередь, добавьте <code>ShouldQueue</code> интерфейс в класс
    слушателя. Слушатели, созданные командами <code>event:generate</code> и <code>make:listener</code> Artisan, уже
    импортировали этот интерфейс в текущее пространство имен, поэтому вы можете сразу его использовать:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Listeners</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Events<span
                        class="token punctuation">\</span>OrderShipped</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>ShouldQueue</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">SendShipmentNotification</span> <span
                    class="token keyword">implements</span> <span class="token class-name">ShouldQueue</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Вот и все! Теперь, когда отправляется событие, обработанное этим слушателем, слушатель автоматически ставится в
    очередь диспетчером событий с использованием <a href="queues">системы очередей</a> Laravel. Если при выполнении
    слушателя очередью не возникает никаких исключений, задание в очереди будет автоматически удалено после завершения
    обработки.</p>
<p></p>
<h4 id="customizing-the-queue-connection-queue-name"><a href="#customizing-the-queue-connection-queue-name">Настройка
        подключения к очереди и имени очереди</a></h4>
<p>Если вы хотите, чтобы настроить подключение очереди, очереди имени или очередь время задержки прослушивателя событий,
    вы можете определить <code>$connection</code>, <code>$queue</code> или <code>$delay</code> свойства на классе
    слушателя:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Listeners</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Events<span
                        class="token punctuation">\</span>OrderShipped</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>ShouldQueue</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">SendShipmentNotification</span> <span
                    class="token keyword">implements</span> <span class="token class-name">ShouldQueue</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * The name of the connection the job should be sent to.
    *
    * @var string|null
    */</span>
    <span class="token keyword">public</span> <span class="token variable">$connection</span> <span
                    class="token operator">=</span> <span class="token single-quoted-string string">'sqs'</span><span
                    class="token punctuation">;</span>

    <span class="token comment">/**
    * The name of the queue the job should be sent to.
    *
    * @var string|null
    */</span>
    <span class="token keyword">public</span> <span class="token variable">$queue</span> <span
                    class="token operator">=</span> <span
                    class="token single-quoted-string string">'listeners'</span><span class="token punctuation">;</span>

    <span class="token comment">/**
    * The time (seconds) before the job should be processed.
    *
    * @var int
    */</span>
    <span class="token keyword">public</span> <span class="token variable">$delay</span> <span
                    class="token operator">=</span> <span class="token number">60</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Если вы хотите определить очередь слушателя во время выполнения, вы можете определить <code>viaQueue</code> метод в
    слушателе:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the name of the listener's queue.
 *
 * @return string
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">viaQueue</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token single-quoted-string string">'listeners'</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="conditionally-queueing-listeners"><a href="#conditionally-queueing-listeners">Условно стоящие в очереди
        слушатели</a></h4>
<p>Иногда вам может потребоваться определить, следует ли ставить слушателя в очередь на основе некоторых данных, которые
    доступны только во время выполнения. Для этого <code>shouldQueue</code> к слушателю может быть добавлен метод, чтобы
    определить, следует ли поставить слушателя в очередь. Если <code>shouldQueue</code> метод вернется
    <code>false</code>, слушатель не будет выполнен:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Listeners</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Events<span
                        class="token punctuation">\</span>OrderCreated</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>ShouldQueue</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">RewardGiftCard</span> <span
                    class="token keyword">implements</span> <span class="token class-name">ShouldQueue</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Reward a gift card to the customer.
    *
    * @param  \App\Events\OrderCreated  $event
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">handle</span><span
                    class="token punctuation">(</span>OrderCreated <span class="token variable">$event</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
    * Determine whether the listener should be queued.
    *
    * @param  \App\Events\OrderCreated  $event
    * @return bool
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">shouldQueue</span><span
                    class="token punctuation">(</span>OrderCreated <span class="token variable">$event</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$event</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">order</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">subtotal</span> <span
                    class="token operator">&gt;=</span> <span class="token number">5000</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h3 id="manually-interacting-the-queue"><a href="#manually-interacting-the-queue">Взаимодействие с очередью вручную</a>
</h3>
<p>Если вам нужно вручную получить доступ к базовым заданиям <code>delete</code> и <code>release</code> методам очереди
    слушателя, вы можете сделать это с помощью <code>Illuminate\Queue\InteractsWithQueue</code> трейта. Этот трейт по
    умолчанию импортируется в сгенерированные слушатели и предоставляет доступ к этим методам:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Listeners</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Events<span
                        class="token punctuation">\</span>OrderShipped</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>ShouldQueue</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>InteractsWithQueue</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">SendShipmentNotification</span> <span
                    class="token keyword">implements</span> <span class="token class-name">ShouldQueue</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">use</span> <span class="token package">InteractsWithQueue</span><span
                    class="token punctuation">;</span>

    <span class="token comment">/**
    * Handle the event.
    *
    * @param  \App\Events\OrderShipped  $event
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">handle</span><span
                    class="token punctuation">(</span>OrderShipped <span class="token variable">$event</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token boolean constant">true</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token variable">$this</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">release</span><span
                    class="token punctuation">(</span><span class="token number">30</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h3 id="queued-event-listeners-and-database-transactions"><a href="#queued-event-listeners-and-database-transactions">Слушатели
        событий в очереди и транзакции базы данных</a></h3>
<p>Когда прослушиватели в очереди отправляются в транзакциях базы данных, они могут быть обработаны очередью до того,
    как транзакция базы данных будет зафиксирована. Когда это происходит, любые обновления, внесенные вами в модели или
    записи базы данных во время транзакции базы данных, могут еще не быть отражены в базе данных. Кроме того, любые
    модели или записи базы данных, созданные в рамках транзакции, могут не существовать в базе данных. Если ваш
    слушатель зависит от этих моделей, могут возникнуть непредвиденные ошибки при обработке задания, которое отправляет
    поставленный в очередь слушатель.</p>
<p>Если <code>after_commit</code> для параметра конфигурации соединения с очередью задано значение <code>false</code>,
    вы все равно можете указать, что конкретный прослушиватель в очереди должен быть отправлен после того, как все
    транзакции открытой базы данных были зафиксированы, путем определения <code>$afterCommit</code> свойства в классе
    прослушивателя:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Listeners</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>ShouldQueue</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>InteractsWithQueue</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">SendShipmentNotification</span> <span
                    class="token keyword">implements</span> <span class="token class-name">ShouldQueue</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">use</span> <span class="token package">InteractsWithQueue</span><span
                    class="token punctuation">;</span>

    <span class="token keyword">public</span> <span class="token variable">$afterCommit</span> <span
                    class="token operator">=</span> <span class="token boolean constant">true</span><span
                    class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Чтобы узнать больше о том, как обойти эти проблемы, ознакомьтесь с документацией, касающейся <a
                    href="queues#jobs-and-database-transactions">заданий в очереди и транзакций базы данных</a>.</p></p>
    </div>
</blockquote>
<p></p>
<h3 id="handling-failed-jobs"><a href="#handling-failed-jobs">Обработка невыполненных заданий</a></h3>
<p>Иногда ваши прослушиватели событий в очереди могут дать сбой. Если прослушиватель в очереди превышает максимальное
    количество попыток, определенное <code>failed</code> вашим обработчиком очереди, метод будет вызван для вашего
    прослушивателя. <code>failed</code> Метод получает экземпляр события и <code>Throwable</code> что причиной сбоя:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Listeners</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Events<span
                        class="token punctuation">\</span>OrderShipped</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>ShouldQueue</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>InteractsWithQueue</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">SendShipmentNotification</span> <span
                    class="token keyword">implements</span> <span class="token class-name">ShouldQueue</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">use</span> <span class="token package">InteractsWithQueue</span><span
                    class="token punctuation">;</span>

    <span class="token comment">/**
    * Handle the event.
    *
    * @param  \App\Events\OrderShipped  $event
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">handle</span><span
                    class="token punctuation">(</span>OrderShipped <span class="token variable">$event</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
    * Handle a job failure.
    *
    * @param  \App\Events\OrderShipped  $event
    * @param  \Throwable  $exception
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">failed</span><span
                    class="token punctuation">(</span>OrderShipped <span class="token variable">$event</span><span
                    class="token punctuation">,</span> <span class="token variable">$exception</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h4 id="specifying-queued-listener-maximum-attempts"><a href="#specifying-queued-listener-maximum-attempts">Указание
        максимального количества попыток прослушивателя в очереди</a></h4>
<p>Если один из ваших слушателей в очереди обнаруживает ошибку, вы, вероятно, не хотите, чтобы он продолжал повторять
    попытки бесконечно. Таким образом, Laravel предоставляет различные способы указать, сколько раз и как долго может
    выполняться попытка прослушивания.</p>
<p>Вы можете определить <code>$tries</code> свойство в своем классе слушателя, чтобы указать, сколько раз можно
    попытаться выполнить прослушиватель, прежде чем он будет считаться неудачным:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Listeners</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Events<span
                        class="token punctuation">\</span>OrderShipped</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>ShouldQueue</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>InteractsWithQueue</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">SendShipmentNotification</span> <span
                    class="token keyword">implements</span> <span class="token class-name">ShouldQueue</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">use</span> <span class="token package">InteractsWithQueue</span><span
                    class="token punctuation">;</span>

    <span class="token comment">/**
    * The number of times the queued listener may be attempted.
    *
    * @var int
    */</span>
    <span class="token keyword">public</span> <span class="token variable">$tries</span> <span
                    class="token operator">=</span> <span class="token number">5</span><span
                    class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
<p>В качестве альтернативы определению того, сколько раз можно попытаться выполнить прослушиватель, прежде чем он
    потерпит неудачу, вы можете определить время, в которое приемник больше не должен выполняться. Это позволяет
    попытаться выполнить прослушивание любое количество раз в течение заданного периода времени. Чтобы определить время,
    в которое больше не следует предпринимать попытки прослушивания, добавьте <code>retryUntil</code> метод в свой класс
    прослушивателя. Этот метод должен возвращать <code>DateTime</code> экземпляр:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Determine the time at which the listener should timeout.
 *
 * @return \DateTime
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">retryUntil</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token function">now</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">addMinutes</span><span
                class="token punctuation">(</span><span class="token number">5</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h2 id="dispatching-events"><a href="#dispatching-events">Отправка событий</a></h2>
<p>Чтобы отправить событие, вы можете вызвать статический <code>dispatch</code> метод для события. Этот метод доступен в
    событии с помощью <code>Illuminate\Foundation\Events\Dispatchable</code> трейта. Любые аргументы, переданные <code>dispatch</code>
    методу, будут переданы конструктору события:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Events<span
                        class="token punctuation">\</span>OrderShipped</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>Controller</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span
                        class="token punctuation">\</span>Order</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">OrderShipmentController</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Ship the given order.
    *
    * @param  \Illuminate\Http\Request  $request
    * @return \Illuminate\Http\Response
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">store</span><span
                    class="token punctuation">(</span>Request <span class="token variable">$request</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$order</span> <span class="token operator">=</span> Order<span
                    class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">findOrFail</span><span class="token punctuation">(</span><span
                    class="token variable">$request</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token property">order_id</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token comment">// Order shipment logic...</span>

        OrderShipped<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">dispatch</span><span class="token punctuation">(</span><span
                    class="token variable">$order</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>При тестировании может быть полезно утверждать, что определенные события были отправлены без фактического
            запуска их слушателей. <a href="mocking#event-fake">Встроенные помощники по тестированию</a> Laravel делают
            его легким.</p></p></div>
</blockquote>
<p></p>
<h2 id="event-subscribers"><a href="#event-subscribers">Подписчики событий</a></h2>
<p></p>
<h3 id="writing-event-subscribers"><a href="#writing-event-subscribers">Написание подписчиков на события</a></h3>
<p>Подписчики событий - это классы, которые могут подписываться на несколько событий внутри самого класса подписчика,
    что позволяет вам определять несколько обработчиков событий в одном классе. Подписчики должны определить <code>subscribe</code>
    метод, которому будет передан экземпляр диспетчера событий. Вы можете вызвать <code>listen</code> метод данного
    диспетчера для регистрации слушателей событий:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Listeners</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">UserEventSubscriber</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Handle user login events.
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">handleUserLogin</span><span
                    class="token punctuation">(</span><span class="token variable">$event</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span><span
                    class="token punctuation">}</span>

    <span class="token comment">/**
    * Handle user logout events.
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">handleUserLogout</span><span
                    class="token punctuation">(</span><span class="token variable">$event</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span><span
                    class="token punctuation">}</span>

    <span class="token comment">/**
    * Register the listeners for the subscriber.
    *
    * @param  \Illuminate\Events\Dispatcher  $events
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">subscribe</span><span
                    class="token punctuation">(</span><span class="token variable">$events</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$events</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">listen</span><span
                    class="token punctuation">(</span>
            <span class="token single-quoted-string string">'Illuminate\Auth\Events\Login'</span><span
                    class="token punctuation">,</span>
            <span class="token punctuation">[</span>UserEventSubscriber<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">,</span> <span
                    class="token single-quoted-string string">'handleUserLogin'</span><span
                    class="token punctuation">]</span>
        <span class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token variable">$events</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">listen</span><span
                    class="token punctuation">(</span>
            <span class="token single-quoted-string string">'Illuminate\Auth\Events\Logout'</span><span
                    class="token punctuation">,</span>
            <span class="token punctuation">[</span>UserEventSubscriber<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">,</span> <span class="token single-quoted-string string">'handleUserLogout'</span><span
                    class="token punctuation">]</span>
        <span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h3 id="registering-event-subscribers"><a href="#registering-event-subscribers">Регистрация подписчиков на
        события</a></h3>
<p>После написания подписчика вы готовы зарегистрировать его в диспетчере событий. Вы можете зарегистрировать
    подписчиков, используя <code>$subscribe</code> свойство на сайте <code>EventServiceProvider</code>. Например,
    добавим <code>UserEventSubscriber</code> в список:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Providers</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Listeners<span class="token punctuation">\</span>UserEventSubscriber</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Support<span class="token punctuation">\</span>Providers<span
                        class="token punctuation">\</span>EventServiceProvider</span> <span
                    class="token keyword">as</span> ServiceProvider<span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">EventServiceProvider</span> <span
                    class="token keyword">extends</span> <span class="token class-name">ServiceProvider</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * The event listener mappings for the application.
    *
    * @var array
    */</span>
    <span class="token keyword">protected</span> <span class="token variable">$listen</span> <span
                    class="token operator">=</span> <span class="token punctuation">[</span>
        <span class="token comment">//</span>
    <span class="token punctuation">]</span><span class="token punctuation">;</span>

    <span class="token comment">/**
    * The subscriber classes to register.
    *
    * @var array
    */</span>
    <span class="token keyword">protected</span> <span class="token variable">$subscribe</span> <span
                    class="token operator">=</span> <span class="token punctuation">[</span>
        UserEventSubscriber<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token keyword">class</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
