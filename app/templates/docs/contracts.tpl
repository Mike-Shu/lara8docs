<h1>Контракты</h1>
<ul>
    <li><a href="contracts#introduction">Вступление</a>
        <ul>
            <li><a href="contracts#contracts-vs-facades">Контракты vs. Фасады</a></li>
        </ul>
    </li>
    <li><a href="contracts#when-to-use-contracts">Когда использовать контракты</a></li>
    <li><a href="contracts#how-to-use-contracts">Как использовать контракты</a></li>
    <li><a href="contracts#contract-reference">Ссылка на контракт</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>«Контракты» Laravel - это набор интерфейсов, которые определяют основные сервисы, предоставляемые фреймворком.
    Например, <code>Illuminate\Contracts\Queue\Queue</code> контракт определяет методы, необходимые для постановки
    заданий в очередь, а <code>Illuminate\Contracts\Mail\Mailer</code> контракт определяет методы, необходимые для
    отправки электронной почты.</p>
<p>Каждый контракт имеет соответствующую реализацию, предусмотренную структурой. Например, Laravel предоставляет
    реализацию очереди с множеством драйверов и реализацию почтовой программы, работающую на <a
            href="https://swiftmailer.symfony.com/">SwiftMailer</a>.</p>
<p>Все контракты Laravel находятся в <a href="https://github.com/illuminate/contracts">собственном репозитории
        GitHub</a>. Это обеспечивает быструю справочную информацию для всех доступных контрактов, а также единый,
    развязанный пакет, который можно использовать при создании пакетов, взаимодействующих со службами Laravel.</p>
<p></p>
<h3 id="contracts-vs-facades"><a href="#contracts-vs-facades">Контракты vs. Фасады</a></h3>
<p><a href="facades">Фасады</a> и вспомогательные функции Laravel обеспечивают простой способ использования сервисов
    Laravel без необходимости вводить подсказки и разрешать контракты из контейнера сервиса. В большинстве случаев
    каждый фасад имеет эквивалентный контракт.</p>
<p>В отличие от фасадов, которые не требуют, чтобы вы требовали их в конструкторе вашего класса, контракты позволяют вам
    определять явные зависимости для ваших классов. Некоторые разработчики предпочитают явно определять свои зависимости
    таким образом и поэтому предпочитают использовать контракты, в то время как другим разработчикам нравится удобство
    фасадов. <strong>В общем, большинство приложений могут без проблем использовать фасады во время разработки.</strong>
</p>
<p></p>
<h2 id="when-to-use-contracts"><a href="#when-to-use-contracts">Когда использовать контракты</a></h2>
<p>Решение использовать контракты или фасады будет зависеть от личного вкуса и вкусов вашей команды разработчиков. И
    контракты, и фасады могут использоваться для создания надежных, хорошо протестированных приложений Laravel.
    Контракты и фасады не исключают друг друга. Некоторые части ваших приложений могут использовать фасады, а другие
    зависят от контрактов. Пока вы сосредотачиваете обязанности своего класса, вы заметите очень мало практических
    различий между использованием контрактов и фасадов.</p>
<p>В общем, большинство приложений могут без проблем использовать фасады во время разработки. Если вы создаете пакет,
    который интегрируется с несколькими фреймворками PHP, вы можете использовать <code>illuminate/contracts</code> пакет
    для определения вашей интеграции со службами Laravel без необходимости требовать конкретных реализаций Laravel в
    <code>composer.json</code> файле вашего пакета.</p>
<p></p>
<h2 id="how-to-use-contracts"><a href="#how-to-use-contracts">Как использовать контракты</a></h2>
<p>Итак, как получить выполнение контракта? На самом деле это довольно просто.</p>
<p>Многие типы классов в Laravel разрешаются через <a href="container">контейнер службы</a>, включая контроллеры,
    прослушиватели событий, промежуточное ПО, задания в очереди и даже закрытие маршрутов. Итак, чтобы получить
    реализацию контракта, вы можете просто «напечатать» интерфейс в конструкторе разрешаемого класса.</p>
<p>Например, взгляните на этот прослушиватель событий:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Listeners</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Events<span
                        class="token punctuation">\</span>OrderWasPlaced</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Redis<span
                        class="token punctuation">\</span>Factory</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">CacheOrderInformation</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * The Redis factory implementation.
    *
    * @var \Illuminate\Contracts\Redis\Factory
    */</span>
    <span class="token keyword">protected</span> <span class="token variable">$redis</span><span
                    class="token punctuation">;</span>

    <span class="token comment">/**
    * Create a new event handler instance.
    *
    * @param  \Illuminate\Contracts\Redis\Factory  $redis
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">__construct</span><span
                    class="token punctuation">(</span>Factory <span class="token variable">$redis</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token property">redis</span> <span
                    class="token operator">=</span> <span class="token variable">$redis</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
    * Handle the event.
    *
    * @param  \App\Events\OrderWasPlaced  $event
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">handle</span><span
                    class="token punctuation">(</span>OrderWasPlaced <span class="token variable">$event</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Когда прослушиватель событий разрешен, сервис-контейнер будет читать подсказки типов в конструкторе класса и вводить
    соответствующее значение. Чтобы узнать больше о регистрации вещей в сервис-контейнере, ознакомьтесь с <a
            href="container">его документацией</a>.</p>
<p></p>
<h2 id="contract-reference"><a href="#contract-reference">Ссылка на контракт</a></h2>
<p>Эта таблица предоставляет быстрый справочник по всем контрактам Laravel и их эквивалентным фасадам:</p>
<table>
    <thead>
    <tr>
        <th>Контракт</th>
        <th>Эквивалентный Фасад</th>
    </tr>
    </thead>
    <tbody>

    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Auth/Access/Authorizable.php">Illuminate\Contracts\Auth\Access\Authorizable</a></td>
        <td>&nbsp;&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Auth/Access/Gate.php">Illuminate\Contracts\Auth\Access\Gate</a></td>
        <td><code>Gate</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Auth/Authenticatable.php">Illuminate\Contracts\Auth\Authenticatable</a></td>
        <td>&nbsp;&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Auth/CanResetPassword.php">Illuminate\Contracts\Auth\CanResetPassword</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Auth/Factory.php">Illuminate\Contracts\Auth\Factory</a></td>
        <td><code>Auth</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Auth/Guard.php">Illuminate\Contracts\Auth\Guard</a></td>
        <td><code>Auth::guard()</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Auth/PasswordBroker.php">Illuminate\Contracts\Auth\PasswordBroker</a></td>
        <td><code>Password::broker()</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Auth/PasswordBrokerFactory.php">Illuminate\Contracts\Auth\PasswordBrokerFactory</a></td>
        <td><code>Password</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Auth/StatefulGuard.php">Illuminate\Contracts\Auth\StatefulGuard</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Auth/SupportsBasicAuth.php">Illuminate\Contracts\Auth\SupportsBasicAuth</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Auth/UserProvider.php">Illuminate\Contracts\Auth\UserProvider</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Bus/Dispatcher.php">Illuminate\Contracts\Bus\Dispatcher</a></td>
        <td><code>Bus</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Bus/QueueingDispatcher.php">Illuminate\Contracts\Bus\QueueingDispatcher</a></td>
        <td><code>Bus::dispatchToQueue()</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Broadcasting/Factory.php">Illuminate\Contracts\Broadcasting\Factory</a></td>
        <td><code>Broadcast</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Broadcasting/Broadcaster.php">Illuminate\Contracts\Broadcasting\Broadcaster</a></td>
        <td><code>Broadcast::connection()</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Broadcasting/ShouldBroadcast.php">Illuminate\Contracts\Broadcasting\ShouldBroadcast</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Broadcasting/ShouldBroadcastNow.php">Illuminate\Contracts\Broadcasting\ShouldBroadcastNow</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Cache/Factory.php">Illuminate\Contracts\Cache\Factory</a></td>
        <td><code>Cache</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Cache/Lock.php">Illuminate\Contracts\Cache\Lock</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Cache/LockProvider.php">Illuminate\Contracts\Cache\LockProvider</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Cache/Repository.php">Illuminate\Contracts\Cache\Repository</a></td>
        <td><code>Cache::driver()</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Cache/Store.php">Illuminate\Contracts\Cache\Store</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Config/Repository.php">Illuminate\Contracts\Config\Repository</a></td>
        <td><code>Config</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Console/Application.php">Illuminate\Contracts\Console\Application</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Console/Kernel.php">Illuminate\Contracts\Console\Kernel</a></td>
        <td><code>Artisan</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Container/Container.php">Illuminate\Contracts\Container\Container</a></td>
        <td><code>App</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Cookie/Factory.php">Illuminate\Contracts\Cookie\Factory</a></td>
        <td><code>Cookie</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Cookie/QueueingFactory.php">Illuminate\Contracts\Cookie\QueueingFactory</a></td>
        <td><code>Cookie::queue()</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Database/ModelIdentifier.php">Illuminate\Contracts\Database\ModelIdentifier</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Debug/ExceptionHandler.php">Illuminate\Contracts\Debug\ExceptionHandler</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Encryption/Encrypter.php">Illuminate\Contracts\Encryption\Encrypter</a></td>
        <td><code>Crypt</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Events/Dispatcher.php">Illuminate\Contracts\Events\Dispatcher</a></td>
        <td><code>Event</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Filesystem/Cloud.php">Illuminate\Contracts\Filesystem\Cloud</a></td>
        <td><code>Storage::cloud()</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Filesystem/Factory.php">Illuminate\Contracts\Filesystem\Factory</a></td>
        <td><code>Storage</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Filesystem/Filesystem.php">Illuminate\Contracts\Filesystem\Filesystem</a></td>
        <td><code>Storage::disk()</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Foundation/Application.php">Illuminate\Contracts\Foundation\Application</a></td>
        <td><code>App</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Hashing/Hasher.php">Illuminate\Contracts\Hashing\Hasher</a></td>
        <td><code>Hash</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Http/Kernel.php">Illuminate\Contracts\Http\Kernel</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Mail/MailQueue.php">Illuminate\Contracts\Mail\MailQueue</a></td>
        <td><code>Mail::queue()</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Mail/Mailable.php">Illuminate\Contracts\Mail\Mailable</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Mail/Mailer.php">Illuminate\Contracts\Mail\Mailer</a></td>
        <td><code>Mail</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Notifications/Dispatcher.php">Illuminate\Contracts\Notifications\Dispatcher</a></td>
        <td><code>Notification</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Notifications/Factory.php">Illuminate\Contracts\Notifications\Factory</a></td>
        <td><code>Notification</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Pagination/LengthAwarePaginator.php">Illuminate\Contracts\Pagination\LengthAwarePaginator</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Pagination/Paginator.php">Illuminate\Contracts\Pagination\Paginator</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Pipeline/Hub.php">Illuminate\Contracts\Pipeline\Hub</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Pipeline/Pipeline.php">Illuminate\Contracts\Pipeline\Pipeline</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Queue/EntityResolver.php">Illuminate\Contracts\Queue\EntityResolver</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Queue/Factory.php">Illuminate\Contracts\Queue\Factory</a></td>
        <td><code>Queue</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Queue/Job.php">Illuminate\Contracts\Queue\Job</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Queue/Monitor.php">Illuminate\Contracts\Queue\Monitor</a></td>
        <td><code>Queue</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Queue/Queue.php">Illuminate\Contracts\Queue\Queue</a></td>
        <td><code>Queue::connection()</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Queue/QueueableCollection.php">Illuminate\Contracts\Queue\QueueableCollection</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Queue/QueueableEntity.php">Illuminate\Contracts\Queue\QueueableEntity</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Queue/ShouldQueue.php">Illuminate\Contracts\Queue\ShouldQueue</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Redis/Factory.php">Illuminate\Contracts\Redis\Factory</a></td>
        <td><code>Redis</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Routing/BindingRegistrar.php">Illuminate\Contracts\Routing\BindingRegistrar</a></td>
        <td><code>Route</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Routing/Registrar.php">Illuminate\Contracts\Routing\Registrar</a></td>
        <td><code>Route</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Routing/ResponseFactory.php">Illuminate\Contracts\Routing\ResponseFactory</a></td>
        <td><code>Response</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Routing/UrlGenerator.php">Illuminate\Contracts\Routing\UrlGenerator</a></td>
        <td><code>URL</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Routing/UrlRoutable.php">Illuminate\Contracts\Routing\UrlRoutable</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Session/Session.php">Illuminate\Contracts\Session\Session</a></td>
        <td><code>Session::driver()</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Support/Arrayable.php">Illuminate\Contracts\Support\Arrayable</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Support/Htmlable.php">Illuminate\Contracts\Support\Htmlable</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Support/Jsonable.php">Illuminate\Contracts\Support\Jsonable</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Support/MessageBag.php">Illuminate\Contracts\Support\MessageBag</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Support/MessageProvider.php">Illuminate\Contracts\Support\MessageProvider</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Support/Renderable.php">Illuminate\Contracts\Support\Renderable</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Support/Responsable.php">Illuminate\Contracts\Support\Responsable</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Translation/Loader.php">Illuminate\Contracts\Translation\Loader</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Translation/Translator.php">Illuminate\Contracts\Translation\Translator</a></td>
        <td><code>Lang</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Validation/Factory.php">Illuminate\Contracts\Validation\Factory</a></td>
        <td><code>Validator</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Validation/ImplicitRule.php">Illuminate\Contracts\Validation\ImplicitRule</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Validation/Rule.php">Illuminate\Contracts\Validation\Rule</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Validation/ValidatesWhenResolved.php">Illuminate\Contracts\Validation\ValidatesWhenResolved</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/Validation/Validator.php">Illuminate\Contracts\Validation\Validator</a></td>
        <td><code>Validator::make()</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/View/Engine.php">Illuminate\Contracts\View\Engine</a></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/View/Factory.php">Illuminate\Contracts\View\Factory</a></td>
        <td><code>View</code></td>
    </tr>
    <tr>
        <td><a href="https://github.com/illuminate/contracts/blob/8.x/View/View.php">Illuminate\Contracts\View\View</a></td>
        <td><code>View::make()</code></td>
    </tr>
    </tbody>
</table> 
       