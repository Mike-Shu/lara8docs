<h1>Уведомления <sup>Notifications</sup></h1>
<ul>
    <li><a href="notifications#introduction">Вступление</a></li>
    <li><a href="notifications#generating-notifications">Генерация уведомлений</a></li>
    <li><a href="notifications#sending-notifications">Отправка уведомлений</a>
        <ul>
            <li><a href="notifications#using-the-notifiable-trait">Использование свойства, подлежащего уведомлению</a>
            </li>
            <li><a href="notifications#using-the-notification-facade">Использование фасада уведомлений</a></li>
            <li><a href="notifications#specifying-delivery-channels">Указание каналов доставки</a></li>
            <li><a href="notifications#queueing-notifications">Уведомления в очереди</a></li>
            <li><a href="notifications#on-demand-notifications">Уведомления по запросу</a></li>
        </ul>
    </li>
    <li><a href="notifications#mail-notifications">Почтовые уведомления</a>
        <ul>
            <li><a href="notifications#formatting-mail-messages">Форматирование почтовых сообщений</a></li>
            <li><a href="notifications#customizing-the-sender">Настройка отправителя</a></li>
            <li><a href="notifications#customizing-the-recipient">Настройка получателя</a></li>
            <li><a href="notifications#customizing-the-subject">Настройка темы</a></li>
            <li><a href="notifications#customizing-the-mailer">Настройка почтовой программы</a></li>
            <li><a href="notifications#customizing-the-templates">Настройка шаблонов</a></li>
            <li><a href="notifications#mail-attachments">Вложения</a></li>
            <li><a href="notifications#using-mailables">Использование почтовых сообщений</a></li>
            <li><a href="notifications#previewing-mail-notifications">Предварительный просмотр почтовых уведомлений</a>
            </li>
        </ul>
    </li>
    <li><a href="notifications#markdown-mail-notifications">Почтовые уведомления Markdown</a>
        <ul>
            <li><a href="notifications#generating-the-message">Создание сообщения</a></li>
            <li><a href="notifications#writing-the-message">Написание сообщения</a></li>
            <li><a href="notifications#customizing-the-components">Настройка компонентов</a></li>
        </ul>
    </li>
    <li><a href="notifications#database-notifications">Уведомления базы данных</a>
        <ul>
            <li><a href="notifications#database-prerequisites">Предпосылки</a></li>
            <li><a href="notifications#formatting-database-notifications">Форматирование уведомлений базы данных</a>
            </li>
            <li><a href="notifications#accessing-the-notifications">Доступ к уведомлениям</a></li>
            <li><a href="notifications#marking-notifications-as-read">Пометка уведомлений как прочитанных</a></li>
        </ul>
    </li>
    <li><a href="notifications#broadcast-notifications">Уведомления о трансляции</a>
        <ul>
            <li><a href="notifications#broadcast-prerequisites">Предпосылки</a></li>
            <li><a href="notifications#formatting-broadcast-notifications">Форматирование широковещательных
                    уведомлений</a></li>
            <li><a href="notifications#listening-for-notifications">Прослушивание уведомлений</a></li>
        </ul>
    </li>
    <li><a href="notifications#sms-notifications">SMS-уведомления</a>
        <ul>
            <li><a href="notifications#sms-prerequisites">Предпосылки</a></li>
            <li><a href="notifications#formatting-sms-notifications">Форматирование SMS-уведомлений</a></li>
            <li><a href="notifications#formatting-shortcode-notifications">Форматирование уведомлений о шорткодах</a>
            </li>
            <li><a href="notifications#customizing-the-from-number">Настройка номера "От"</a></li>
            <li><a href="notifications#routing-sms-notifications">Маршрутизация SMS-уведомлений</a></li>
        </ul>
    </li>
    <li><a href="notifications#slack-notifications">Уведомления Slack</a>
        <ul>
            <li><a href="notifications#slack-prerequisites">Предпосылки</a></li>
            <li><a href="notifications#formatting-slack-notifications">Форматирование уведомлений Slack</a></li>
            <li><a href="notifications#slack-attachments">Слабые вложения</a></li>
            <li><a href="notifications#routing-slack-notifications">Маршрутизация уведомлений Slack</a></li>
        </ul>
    </li>
    <li><a href="notifications#localizing-notifications">Локализация уведомлений</a></li>
    <li><a href="notifications#notification-events">Уведомления о событиях</a></li>
    <li><a href="notifications#custom-channels">Клиентские каналы</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Помимо поддержки <a href="mail">отправки электронной почты</a>, Laravel предоставляет поддержку для отправки
    уведомлений по различным каналам доставки, включая электронную почту, SMS (через <a
            href="https://www.vonage.com/communications-apis/">Vonage</a>, ранее известную как Nexmo) и <a
            href="https://slack.com">Slack</a>. Кроме того, было создано множество <a
            href="https://laravel-notification-channels.com/about/%23suggesting-a-new-channel">каналов уведомлений</a>,
    созданных <a href="https://laravel-notification-channels.com/about/%23suggesting-a-new-channel">сообществом,</a> для
    отправки уведомлений по десяткам разных каналов! Уведомления также могут храниться в базе данных, поэтому они могут
    отображаться в вашем веб-интерфейсе.</p>
<p>Как правило, уведомления должны быть короткими информационными сообщениями, которые уведомляют пользователей о том,
    что произошло в вашем приложении. Например, если вы пишете приложение для выставления счетов, вы можете отправить
    своим пользователям уведомление «Счет оплачен» по каналам электронной почты и SMS.</p>
<p></p>
<h2 id="generating-notifications"><a href="#generating-notifications">Генерация уведомлений</a></h2>
<p>В Laravel каждое уведомление представлено одним классом, который обычно хранится в <code>app/Notifications</code>
    каталоге. Не беспокойтесь, если вы не видите этот каталог в своем приложении - он будет создан для вас, когда вы
    запустите команду <code>make:notification</code> Artisan:</p>
<pre class=" language-php"><code class=" language-php">php artisan make<span class="token punctuation">:</span>notification InvoicePaid</code></pre>
<p>Эта команда поместит новый класс уведомлений в ваш <code>app/Notifications</code> каталог. Каждый класс уведомлений
    содержит <code>via</code> метод и переменное количество методов построения сообщений, таких как <code>toMail</code>
    или <code>toDatabase</code>, которые преобразуют уведомление в сообщение, адаптированное для этого конкретного
    канала.</p>
<p></p>
<h2 id="sending-notifications"><a href="#sending-notifications">Отправка уведомлений</a></h2>
<p></p>
<h3 id="using-the-notifiable-trait"><a href="#using-the-notifiable-trait">Использование свойства, подлежащего
        уведомлению</a></h3>
<p>Уведомления могут быть отправлены двумя способами: с использованием <code>notify</code> метода
    <code>Notifiable</code> трейта или с помощью <code>Notification</code> <a href="facades">фасада</a>. Эта <code>Notifiable</code>
    черта включена в <code>App\Models\User</code> модель вашего приложения по умолчанию:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Auth<span class="token punctuation">\</span>User</span> <span
                    class="token keyword">as</span> Authenticatable<span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Notifications<span
                        class="token punctuation">\</span>Notifiable</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">User</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Authenticatable</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">use</span> <span class="token package">Notifiable</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
<p><code>notify</code> Метод, который обеспечивается эта черта ожидает получить экземпляр уведомления:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Notifications<span
                    class="token punctuation">\</span>InvoicePaid</span><span class="token punctuation">;</span>

<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">notify</span><span
                class="token punctuation">(</span><span class="token keyword">new</span> <span class="token class-name">InvoicePaid</span><span
                class="token punctuation">(</span><span class="token variable">$invoice</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Помните, вы можете использовать <code>Notifiable</code> трейт на любой из ваших моделей. Вы не ограничены
            только включением его в свою <code>User</code> модель.</p></p></div>
</blockquote>
<p></p>
<h3 id="using-the-notification-facade"><a href="#using-the-notification-facade">Использование фасада уведомлений</a>
</h3>
<p>Как вариант, вы можете отправлять уведомления через <code>Notification</code> <a href="facades">фасад</a>. Этот
    подход полезен, когда вам нужно отправить уведомление нескольким объектам, подлежащим уведомлению, например группе
    пользователей. Чтобы отправлять уведомления с помощью фасада, передайте все уведомляемые сущности и экземпляр
    уведомления <code>send</code> методу:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Notification</span><span
                class="token punctuation">;</span>

Notification<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">send</span><span class="token punctuation">(</span><span class="token variable">$users</span><span
                class="token punctuation">,</span> <span class="token keyword">new</span> <span
                class="token class-name">InvoicePaid</span><span class="token punctuation">(</span><span
                class="token variable">$invoice</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="specifying-delivery-channels"><a href="#specifying-delivery-channels">Указание каналов доставки</a></h3>
<p>У каждого класса уведомлений есть <code>via</code> метод, который определяет, по каким каналам будет доставлено
    уведомление. Уведомления могут быть отправлены на <code>mail</code>, <code>database</code>, <code>broadcast</code>,
    <code>nexmo</code>, и <code>slack</code> каналах.</p>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Если вы хотите использовать другие каналы доставки, такие как Telegram или Pusher, <a
                    href="http://laravel-notification-channels.com">посетите веб-сайт Laravel Notification Channels,</a>
            управляемый сообществом.</p></p></div>
</blockquote>
<p><code>via</code> Метод получает <code>$notifiable</code> экземпляр, который будет экземпляром класса, к которому
    направляется уведомление. Вы можете использовать, <code>$notifiable</code> чтобы определить, по каким каналам должно
    доставляться уведомление:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the notification's delivery channels.
 *
 * @param  mixed  $notifiable
 * @return array
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">via</span><span class="token punctuation">(</span><span class="token variable">$notifiable</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$notifiable</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">prefers_sms</span> <span
                class="token operator">?</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'nexmo'</span><span class="token punctuation">]</span> <span
                class="token punctuation">:</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'mail'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'database'</span><span class="token punctuation">]</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="queueing-notifications"><a href="#queueing-notifications">Уведомления в очереди</a></h3>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Перед постановкой уведомлений в очередь необходимо настроить очередь и <a href="queues">запустить воркер</a>.
        </p></p></div>
</blockquote>
<p>Отправка уведомлений может занять время, особенно если каналу необходимо выполнить внешний вызов API для доставки
    уведомления. Чтобы ускорить время отклика вашего приложения, поставьте ваше уведомление в очередь, добавив <code>ShouldQueue</code>
    интерфейс и <code>Queueable</code> трейт к вашему классу. Интерфейс и трейт уже импортированы для всех уведомлений,
    сгенерированных с помощью <code>make:notification</code> команды, поэтому вы можете сразу добавить их в свой класс
    уведомлений:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Notifications</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Bus<span
                        class="token punctuation">\</span>Queueable</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>ShouldQueue</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Notifications<span
                        class="token punctuation">\</span>Notification</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">InvoicePaid</span> <span class="token keyword">extends</span> <span
                    class="token class-name">Notification</span> <span class="token keyword">implements</span> <span
                    class="token class-name">ShouldQueue</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">use</span> <span class="token package">Queueable</span><span
                    class="token punctuation">;</span>

    <span class="token comment">//...</span>
<span class="token punctuation">}</span></span></code></pre>
<p>После <code>ShouldQueue</code> добавления интерфейса к вашему уведомлению вы можете отправить его как обычно. Laravel
    обнаружит <code>ShouldQueue</code> интерфейс в классе и автоматически поставит в очередь доставку уведомления:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">notify</span><span
                class="token punctuation">(</span><span class="token keyword">new</span> <span class="token class-name">InvoicePaid</span><span
                class="token punctuation">(</span><span class="token variable">$invoice</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Если вы хотите отложить доставку уведомления, вы можете связать <code>delay</code> метод с вашим экземпляром
    уведомления:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$delay</span> <span
                class="token operator">=</span> <span class="token function">now</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">addMinutes</span><span
                class="token punctuation">(</span><span class="token number">10</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">notify</span><span
                class="token punctuation">(</span><span class="token punctuation">(</span><span class="token keyword">new</span> <span
                class="token class-name">InvoicePaid</span><span class="token punctuation">(</span><span
                class="token variable">$invoice</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">delay</span><span
                class="token punctuation">(</span><span class="token variable">$delay</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы можете передать в <code>delay</code> метод массив, чтобы указать величину задержки для определенных каналов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">notify</span><span
                class="token punctuation">(</span><span class="token punctuation">(</span><span class="token keyword">new</span> <span
                class="token class-name">InvoicePaid</span><span class="token punctuation">(</span><span
                class="token variable">$invoice</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">delay</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'mail'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">now</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">addMinutes</span><span
                class="token punctuation">(</span><span class="token number">5</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'sms'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">now</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">addMinutes</span><span
                class="token punctuation">(</span><span class="token number">10</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>При постановке уведомлений в очередь для каждого получателя и комбинации каналов создается задание в очереди.
    Например, в очередь будет отправлено шесть заданий, если у вашего уведомления три получателя и два канала.</p>
<p></p>
<h4 id="customizing-the-notification-queue-connection"><a href="#customizing-the-notification-queue-connection">Настройка
        подключения к очереди уведомлений</a></h4>
<p>По умолчанию уведомления в очереди будут помещены в очередь с использованием соединения очереди вашего приложения по
    умолчанию. Если вы хотите указать другое соединение, которое должно использоваться для конкретного уведомления, вы
    можете определить <code>$connection</code> свойство в классе уведомлений:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * The name of the queue connection to use when queueing the notification.
 *
 * @var string
 */</span>
<span class="token keyword">public</span> <span class="token variable">$connection</span> <span
                class="token operator">=</span> <span class="token single-quoted-string string">'redis'</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="customizing-notification-channel-queues"><a href="#customizing-notification-channel-queues">Настройка очередей
        каналов уведомлений</a></h4>
<p>Если вы хотите указать конкретную очередь, которая должна использоваться для каждого канала уведомления,
    поддерживаемого уведомлением, вы можете определить <code>viaQueues</code> метод в своем уведомлении. Этот метод
    должен возвращать массив пар имя канала / имя очереди:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Determine which queues should be used for each notification channel.
 *
 * @return array
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">viaQueues</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'mail'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'mail-queue'</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'slack'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'slack-queue'</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="queued-notifications-and-database-transactions"><a href="#queued-notifications-and-database-transactions">Уведомления
        в очереди и транзакции базы данных</a></h4>
<p>Когда уведомления в очереди отправляются в транзакциях базы данных, они могут быть обработаны очередью до того, как
    транзакция базы данных будет зафиксирована. Когда это происходит, любые обновления, внесенные вами в модели или
    записи базы данных во время транзакции базы данных, могут еще не быть отражены в базе данных. Кроме того, любые
    модели или записи базы данных, созданные в рамках транзакции, могут не существовать в базе данных. Если ваше
    уведомление зависит от этих моделей, при обработке задания, отправляющего уведомление в очередь, могут возникнуть
    непредвиденные ошибки.</p>
<p>Если <code>after_commit</code> для параметра конфигурации соединения с очередью установлено значение
    <code>false</code>, вы все равно можете указать, что конкретное уведомление в очереди должно быть отправлено после
    того, как все транзакции открытой базы данных были зафиксированы, путем определения <code>$afterCommit</code>
    свойства в классе уведомлений:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Notifications</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Bus<span
                        class="token punctuation">\</span>Queueable</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>ShouldQueue</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Notifications<span
                        class="token punctuation">\</span>Notification</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">InvoicePaid</span> <span class="token keyword">extends</span> <span
                    class="token class-name">Notification</span> <span class="token keyword">implements</span> <span
                    class="token class-name">ShouldQueue</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">use</span> <span class="token package">Queueable</span><span
                    class="token punctuation">;</span>

    <span class="token keyword">public</span> <span class="token variable">$afterCommit</span> <span
                    class="token operator">=</span> <span class="token boolean constant">true</span><span
                    class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Чтобы узнать больше об устранении этих проблем, ознакомьтесь с документацией, касающейся <a
                    href="queues#jobs-and-database-transactions">заданий в очереди и транзакций базы данных</a>.</p></p>
    </div>
</blockquote>
<p></p>
<h3 id="on-demand-notifications"><a href="#on-demand-notifications">Уведомления по запросу</a></h3>
<p>Иногда вам может потребоваться отправить уведомление кому-то, кто не хранится как «пользователь» вашего приложения.
    Используя метод <code>Notification</code> фасада <code>route</code>, вы можете указать информацию о маршрутизации
    специального уведомления перед отправкой уведомления:</p>
<pre class=" language-php"><code class=" language-php">Notification<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">route</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'mail'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'taylor@example.com'</span><span
                class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">route</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'nexmo'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'5555555555'</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">route</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'slack'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'https://hooks.slack.com/services/...'</span><span
                class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">notify</span><span
                class="token punctuation">(</span><span class="token keyword">new</span> <span class="token class-name">InvoicePaid</span><span
                class="token punctuation">(</span><span class="token variable">$invoice</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="mail-notifications"><a href="#mail-notifications">Почтовые уведомления</a></h2>
<p></p>
<h3 id="formatting-mail-messages"><a href="#formatting-mail-messages">Форматирование почтовых сообщений</a></h3>
<p>Если уведомление поддерживает отправку по электронной почте, вы должны определить <code>toMail</code> метод в классе
    уведомлений. Этот метод получит <code>$notifiable</code> сущность и должен вернуть <code>Illuminate\Notifications\Messages\MailMessage</code>
    экземпляр.</p>
<p><code>MailMessage</code> Класс содержит несколько методов, простых, чтобы помочь вам построить транзакционные
    сообщения электронной почты. Почтовые сообщения могут содержать строки текста, а также «призыв к действию». Давайте
    посмотрим на пример <code>toMail</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the mail representation of the notification.
 *
 * @param  mixed  $notifiable
 * @return \Illuminate\Notifications\Messages\MailMessage
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toMail</span><span
                class="token punctuation">(</span><span class="token variable">$notifiable</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$url</span> <span class="token operator">=</span> <span
                class="token function">url</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/invoice/'</span><span
                class="token punctuation">.</span><span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">invoice</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    
    <span class="token keyword">return</span> <span class="token punctuation">(</span><span
                class="token keyword">new</span> <span class="token class-name">MailMessage</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">greeting</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Hello!'</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">line</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'One of your invoices has been paid!'</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">action</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'View Invoice'</span><span class="token punctuation">,</span> <span
                class="token variable">$url</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">line</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Thank you for using our application!'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Обратите внимание, что мы используем <code>$this-&gt;invoice-&gt;id</code> в нашем <code>toMail</code>
            методе. Вы можете передать любые данные, которые необходимы вашему уведомлению для генерации сообщения, в
            конструктор уведомления.</p></p></div>
</blockquote>
<p>В этом примере мы регистрируем приветствие, строку текста, призыв к действию, а затем еще одну строку текста. Эти
    методы, предоставляемые <code>MailMessage</code> объектом, упрощают и ускоряют форматирование небольших
    транзакционных электронных писем. Затем почтовый канал преобразует компоненты сообщения в красивый, отзывчивый
    шаблон электронной почты HTML с аналогом в виде простого текста. Вот пример электронного письма, созданного <code>mail</code>
    каналом:</p>
<img src="https://laravel.com/img/docs/notification-example-2.png">
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>При отправке почтовых уведомлений обязательно установите <code>name</code> параметр
            <code>config/app.php</code> конфигурации в файле конфигурации. Это значение будет использоваться в верхнем и
            нижнем колонтитулах ваших почтовых уведомлений.</p></p></div>
</blockquote>
<p></p>
<h4 id="other-mail-notification-formatting-options"><a href="#other-mail-notification-formatting-options">Другие
        параметры форматирования почтовых уведомлений</a></h4>
<p>Вместо определения «строк» ​​текста в классе уведомлений вы можете использовать этот <code>view</code> метод, чтобы
    указать настраиваемый шаблон, который следует использовать для отображения электронного письма с уведомлением:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the mail representation of the notification.
 *
 * @param  mixed  $notifiable
 * @return \Illuminate\Notifications\Messages\MailMessage
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toMail</span><span
                class="token punctuation">(</span><span class="token variable">$notifiable</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">(</span><span
                class="token keyword">new</span> <span class="token class-name">MailMessage</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">view</span><span
                class="token punctuation">(</span>
        <span class="token single-quoted-string string">'emails.name'</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span><span class="token single-quoted-string string">'invoice'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">invoice</span><span
                class="token punctuation">]</span>
    <span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Вы можете указать текстовое представление для почтового сообщения, передав имя представления в качестве второго
    элемента массива, который передается <code>view</code> методу:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the mail representation of the notification.
 *
 * @param  mixed  $notifiable
 * @return \Illuminate\Notifications\Messages\MailMessage
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toMail</span><span
                class="token punctuation">(</span><span class="token variable">$notifiable</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">(</span><span
                class="token keyword">new</span> <span class="token class-name">MailMessage</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">view</span><span
                class="token punctuation">(</span>
        <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'emails.name.html'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'emails.name.plain'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
        <span class="token punctuation">[</span><span class="token single-quoted-string string">'invoice'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">invoice</span><span
                class="token punctuation">]</span>
    <span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="error-messages"><a href="#error-messages">Сообщения об ошибках</a></h4>
<p>Некоторые уведомления информируют пользователей об ошибках, например о неудачной оплате счета. Вы можете указать, что
    почтовое сообщение содержит ошибку, вызвав <code>error</code> метод при построении сообщения. При использовании
    <code>error</code> метода в почтовом сообщении кнопка призыва к действию будет красной вместо черной:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the mail representation of the notification.
 *
 * @param  mixed  $notifiable
 * @return \Illuminate\Notifications\Message
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toMail</span><span
                class="token punctuation">(</span><span class="token variable">$notifiable</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">(</span><span
                class="token keyword">new</span> <span class="token class-name">MailMessage</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">error</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">subject</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Notification Subject'</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">line</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'...'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="customizing-the-sender"><a href="#customizing-the-sender">Настройка отправителя</a></h3>
<p>По умолчанию адрес отправителя / отправителя электронного письма определяется в <code>config/mail.php</code> файле
    конфигурации. Однако вы можете указать адрес отправителя для конкретного уведомления, используя <code>from</code>
    метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the mail representation of the notification.
 *
 * @param  mixed  $notifiable
 * @return \Illuminate\Notifications\Messages\MailMessage
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toMail</span><span
                class="token punctuation">(</span><span class="token variable">$notifiable</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">(</span><span
                class="token keyword">new</span> <span class="token class-name">MailMessage</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">from</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'barrett@example.com'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Barrett Blair'</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">line</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'...'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="customizing-the-recipient"><a href="#customizing-the-recipient">Настройка получателя</a></h3>
<p>При отправке уведомлений по <code>mail</code> каналу система уведомлений автоматически ищет <code>email</code>
    свойство в вашей уведомляемой сущности. Вы можете настроить, какой адрес электронной почты будет использоваться для
    доставки уведомления, указав <code>routeNotificationForMail</code> метод для объекта уведомления:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Auth<span class="token punctuation">\</span>User</span> <span
                    class="token keyword">as</span> Authenticatable<span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Notifications<span
                        class="token punctuation">\</span>Notifiable</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">User</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Authenticatable</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">use</span> <span class="token package">Notifiable</span><span class="token punctuation">;</span>

    <span class="token comment">/**
    * Route notifications for the mail channel.
    *
    * @param  \Illuminate\Notifications\Notification  $notification
    * @return array|string
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">routeNotificationForMail</span><span
                    class="token punctuation">(</span><span class="token variable">$notification</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">// Return email address only...</span>
        <span class="token keyword">return</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">email_address</span><span
                    class="token punctuation">;</span>

        <span class="token comment">// Return email address and name...</span>
        <span class="token keyword">return</span> <span class="token punctuation">[</span><span
                    class="token variable">$this</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token property">email_address</span> <span
                    class="token operator">=</span><span class="token operator">&gt;</span> <span
                    class="token variable">$this</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token property">name</span><span
                    class="token punctuation">]</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h3 id="customizing-the-subject"><a href="#customizing-the-subject">Настройка темы</a></h3>
<p>По умолчанию темой электронного письма является название класса уведомления в формате «Заголовок». Итак, если ваш
    класс уведомлений назван <code>InvoicePaid</code>, темой электронного письма будет <code>Invoice Paid</code>. Если
    вы хотите указать другую тему для сообщения, вы можете вызвать <code>subject</code> метод при построении сообщения:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the mail representation of the notification.
 *
 * @param  mixed  $notifiable
 * @return \Illuminate\Notifications\Messages\MailMessage
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toMail</span><span
                class="token punctuation">(</span><span class="token variable">$notifiable</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">(</span><span
                class="token keyword">new</span> <span class="token class-name">MailMessage</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">subject</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Notification Subject'</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">line</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'...'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="customizing-the-mailer"><a href="#customizing-the-mailer">Настройка почтовой программы</a></h3>
<p>По умолчанию уведомление по электронной почте будет отправлено с использованием почтовой программы по умолчанию,
    определенной в <code>config/mail.php</code> файле конфигурации. Однако вы можете указать другую почтовую программу
    во время выполнения, вызвав <code>mailer</code> метод при создании сообщения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the mail representation of the notification.
 *
 * @param  mixed  $notifiable
 * @return \Illuminate\Notifications\Messages\MailMessage
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toMail</span><span
                class="token punctuation">(</span><span class="token variable">$notifiable</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">(</span><span
                class="token keyword">new</span> <span class="token class-name">MailMessage</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">mailer</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'postmark'</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">line</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'...'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="customizing-the-templates"><a href="#customizing-the-templates">Настройка шаблонов</a></h3>
<p>Вы можете изменить шаблон HTML и обычного текста, используемый для почтовых уведомлений, опубликовав ресурсы пакета
    уведомлений. После выполнения этой команды шаблоны почтовых уведомлений будут расположены в <code>resources/views/vendor/notifications</code>
    каталоге:</p>
<pre class=" language-php"><code class=" language-php">php artisan vendor<span class="token punctuation">:</span>publish <span
                class="token operator">--</span>tag<span class="token operator">=</span>laravel<span
                class="token operator">-</span>notifications</code></pre>
<p></p>
<h3 id="mail-attachments"><a href="#mail-attachments">Вложения</a></h3>
<p>Чтобы добавить вложения к уведомлению по электронной почте, используйте этот <code>attach</code> метод при создании
    сообщения. <code>attach</code> Метод принимает абсолютный путь к файлу в качестве первого аргумента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the mail representation of the notification.
 *
 * @param  mixed  $notifiable
 * @return \Illuminate\Notifications\Messages\MailMessage
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toMail</span><span
                class="token punctuation">(</span><span class="token variable">$notifiable</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">(</span><span
                class="token keyword">new</span> <span class="token class-name">MailMessage</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">greeting</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Hello!'</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">attach</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/path/to/file'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>При прикреплении файлов к сообщению вы также можете указать отображаемое имя и / или MIME-тип, передав методу в
    <code>array</code> качестве второго аргумента <code>attach</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the mail representation of the notification.
 *
 * @param  mixed  $notifiable
 * @return \Illuminate\Notifications\Messages\MailMessage
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toMail</span><span
                class="token punctuation">(</span><span class="token variable">$notifiable</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">(</span><span
                class="token keyword">new</span> <span class="token class-name">MailMessage</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">greeting</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Hello!'</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">attach</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/path/to/file'</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span>
            <span class="token single-quoted-string string">'as'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'name.pdf'</span><span class="token punctuation">,</span>
            <span class="token single-quoted-string string">'mime'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'application/pdf'</span><span
                class="token punctuation">,</span>
        <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>В отличие от прикрепления файлов к объектам, подлежащим отправке по почте, вы не можете прикреплять файл
    непосредственно с диска хранения, используя <code>attachFromStorage</code>. Лучше использовать <code>attach</code>
    метод с абсолютным путем к файлу на диске хранения. В качестве альтернативы вы можете вернуть <a
            href="mail#generating-mailables">почтовое сообщение</a> из <code>toMail</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Mail<span
                    class="token punctuation">\</span>InvoicePaid</span> <span class="token keyword">as</span> InvoicePaidMailable<span
                class="token punctuation">;</span>

<span class="token comment">/**
 * Get the mail representation of the notification.
 *
 * @param  mixed  $notifiable
 * @return Mailable
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toMail</span><span
                class="token punctuation">(</span><span class="token variable">$notifiable</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">(</span><span
                class="token keyword">new</span> <span class="token class-name">InvoicePaidMailable</span><span
                class="token punctuation">(</span><span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">invoice</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">to</span><span class="token punctuation">(</span><span class="token variable">$notifiable</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">email</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">attachFromStorage</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/path/to/file'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="raw-data-attachments"><a href="#raw-data-attachments">Вложения сырых данных</a></h4>
<p><code>attachData</code> Метод может быть использован, чтобы прикрепить сырую строку байт в качестве вложения. При
    вызове <code>attachData</code> метода вы должны указать имя файла, которое должно быть присвоено вложению:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the mail representation of the notification.
 *
 * @param  mixed  $notifiable
 * @return \Illuminate\Notifications\Messages\MailMessage
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toMail</span><span
                class="token punctuation">(</span><span class="token variable">$notifiable</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">(</span><span
                class="token keyword">new</span> <span class="token class-name">MailMessage</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">greeting</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Hello!'</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">attachData</span><span class="token punctuation">(</span><span
                class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">pdf</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'name.pdf'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
            <span class="token single-quoted-string string">'mime'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'application/pdf'</span><span
                class="token punctuation">,</span>
        <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="using-mailables"><a href="#using-mailables">Использование почтовых сообщений</a></h3>
<p>При необходимости вы можете вернуть полный <a href="mail">почтовый объект</a> из <code>toMail</code> метода вашего
    уведомления. При возврате <code>Mailable</code> вместо a <code>MailMessage</code> вам нужно будет указать получателя
    сообщения с помощью метода почтового объекта <code>to</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Mail<span
                    class="token punctuation">\</span>InvoicePaid</span> <span class="token keyword">as</span> InvoicePaidMailable<span
                class="token punctuation">;</span>

<span class="token comment">/**
 * Get the mail representation of the notification.
 *
 * @param  mixed  $notifiable
 * @return Mailable
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toMail</span><span
                class="token punctuation">(</span><span class="token variable">$notifiable</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">(</span><span
                class="token keyword">new</span> <span class="token class-name">InvoicePaidMailable</span><span
                class="token punctuation">(</span><span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">invoice</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">to</span><span class="token punctuation">(</span><span class="token variable">$notifiable</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">email</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="mailables-and-on-demand-notifications"><a href="#mailables-and-on-demand-notifications">Почтовые отправления и
        уведомления по запросу</a></h4>
<p>Если вы отправляете <a href="notifications#on-demand-notifications">уведомление по запросу</a>,
    <code>$notifiable</code> экземпляр, передаваемый <code>toMail</code> методу, будет экземпляром <code>Illuminate\Notifications\AnonymousNotifiable</code>,
    который предлагает <code>routeNotificationFor</code> метод, который может использоваться для получения адреса
    электронной почты, на который должно быть отправлено уведомление по запросу:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Mail<span
                    class="token punctuation">\</span>InvoicePaid</span> <span class="token keyword">as</span> InvoicePaidMailable<span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Notifications<span
                    class="token punctuation">\</span>AnonymousNotifiable</span><span class="token punctuation">;</span>

<span class="token comment">/**
 * Get the mail representation of the notification.
 *
 * @param  mixed  $notifiable
 * @return Mailable
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toMail</span><span
                class="token punctuation">(</span><span class="token variable">$notifiable</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$address</span> <span class="token operator">=</span> <span class="token variable">$notifiable</span> <span
                class="token keyword">instanceof</span> <span class="token class-name">AnonymousNotifiable</span>
    <span class="token operator">?</span> <span class="token variable">$notifiable</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">routeNotificationFor</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'mail'</span><span
                class="token punctuation">)</span>
    <span class="token punctuation">:</span> <span class="token variable">$notifiable</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">email</span><span
                class="token punctuation">;</span>
    
    <span class="token keyword">return</span> <span class="token punctuation">(</span><span
                class="token keyword">new</span> <span class="token class-name">InvoicePaidMailable</span><span
                class="token punctuation">(</span><span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">invoice</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">to</span><span class="token punctuation">(</span><span class="token variable">$address</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="previewing-mail-notifications"><a href="#previewing-mail-notifications">Предварительный просмотр почтовых
        уведомлений</a></h3>
<p>При разработке шаблона почтового уведомления удобно быстро просмотреть обработанное почтовое сообщение в браузере,
    как в типичном шаблоне Blade. По этой причине Laravel позволяет вам возвращать любое почтовое сообщение,
    сгенерированное почтовым уведомлением, непосредственно из закрытия маршрута или контроллера. Когда
    <code>MailMessage</code> возвращается, он будет обработан и отображен в браузере, что позволит вам быстро
    просмотреть его дизайн, не отправляя его на реальный адрес электронной почты:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Invoice</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Notifications<span
                    class="token punctuation">\</span>InvoicePaid</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/notification'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$invoice</span> <span class="token operator">=</span> Invoice<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
            
    <span class="token keyword">return</span> <span class="token punctuation">(</span><span
                class="token keyword">new</span> <span class="token class-name">InvoicePaid</span><span
                class="token punctuation">(</span><span class="token variable">$invoice</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">toMail</span><span
                class="token punctuation">(</span><span class="token variable">$invoice</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">user</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="markdown-mail-notifications"><a href="#markdown-mail-notifications">Почтовые уведомления Markdown</a></h2>
<p>Почтовые уведомления Markdown позволяют вам использовать заранее созданные шаблоны почтовых уведомлений, давая вам
    больше свободы для написания более длинных, настраиваемых сообщений. Поскольку сообщения написаны в Markdown,
    Laravel может отображать красивые, отзывчивые HTML-шаблоны для сообщений, а также автоматически генерировать аналог
    в виде простого текста.</p>
<p></p>
<h3 id="generating-the-message"><a href="#generating-the-message">Создание сообщения</a></h3>
<p>Чтобы сгенерировать уведомление с соответствующим шаблоном Markdown, вы можете использовать <code>--markdown</code>
    опцию <code>make:notification</code> Artisan-команды:</p>
<pre class=" language-php"><code class=" language-php">php artisan make<span class="token punctuation">:</span>notification InvoicePaid <span
                class="token operator">--</span>markdown<span class="token operator">=</span>mail<span
                class="token punctuation">.</span>invoice<span class="token punctuation">.</span>paid</code></pre>
<p>Как и все другие почтовые уведомления, уведомления, использующие шаблоны Markdown, должны определять
    <code>toMail</code> метод в своем классе уведомлений. Однако, вместо использования <code>line</code> и
    <code>action</code> методов построения уведомления, используйте <code>markdown</code> метод, чтобы указать имя
    шаблона Markdown, который следует использовать. Массив данных, который вы хотите сделать доступным для шаблона,
    может быть передан в качестве второго аргумента метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the mail representation of the notification.
 *
 * @param  mixed  $notifiable
 * @return \Illuminate\Notifications\Messages\MailMessage
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toMail</span><span
                class="token punctuation">(</span><span class="token variable">$notifiable</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$url</span> <span class="token operator">=</span> <span
                class="token function">url</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/invoice/'</span><span
                class="token punctuation">.</span><span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">invoice</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    
    <span class="token keyword">return</span> <span class="token punctuation">(</span><span
                class="token keyword">new</span> <span class="token class-name">MailMessage</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">subject</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Invoice Paid'</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">markdown</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'mail.invoice.paid'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'url'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$url</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="writing-the-message"><a href="#writing-the-message">Написание сообщения</a></h3>
<p>В почтовых уведомлениях Markdown используется комбинация компонентов Blade и синтаксиса Markdown, которые позволяют
    легко создавать уведомления, используя предварительно созданные компоненты уведомлений Laravel:</p>
<pre class=" language-php"><code class=" language-php">@<span class="token function">component</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'mail::message'</span><span
                class="token punctuation">)</span>
<span class="token shell-comment comment"># Invoice Paid</span>

Your invoice has been paid<span class="token operator">!</span>

@<span class="token function">component</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'mail::button'</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span><span class="token single-quoted-string string">'url'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token variable">$url</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span>
View Invoice
@endcomponent

Thanks<span class="token punctuation">,</span><span class="token operator">&lt;</span>br<span class="token operator">&gt;</span>
<span class="token punctuation">{literal}{{/literal}</span><span
                class="token punctuation">{literal}{{/literal}</span> <span class="token function">config</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'app.name'</span><span
                class="token punctuation">)</span> <span class="token punctuation">}</span><span
                class="token punctuation">}</span>
@endcomponent</code></pre>
<p></p>
<h4 id="button-component"><a href="#button-component">Компонент кнопки</a></h4>
<p>Компонент кнопки отображает ссылку на кнопку по центру. Компонент принимает два аргумента: a <code>url</code> и
    необязательный <code>color</code>. Поддерживаемые цвета <code>primary</code>, <code>green</code> и <code>red</code>.
    Вы можете добавить к уведомлению столько компонентов кнопки, сколько захотите:</p>
<pre class=" language-php"><code class=" language-php">@<span class="token function">component</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'mail::button'</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span><span class="token single-quoted-string string">'url'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token variable">$url</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'color'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'green'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span>
View Invoice
@endcomponent</code></pre>
<p></p>
<h4 id="panel-component"><a href="#panel-component">Компонент панели</a></h4>
<p>Компонент панели отображает указанный блок текста на панели, цвет фона которой немного отличается от цвета остальной
    части уведомления. Это позволяет привлечь внимание к заданному блоку текста:</p>
<pre class=" language-php"><code class=" language-php">@<span class="token function">component</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'mail::panel'</span><span class="token punctuation">)</span>
This is the panel content<span class="token punctuation">.</span>
@endcomponent</code></pre>
<p></p>
<h4 id="table-component"><a href="#table-component">Компонент таблицы</a></h4>
<p>Компонент таблицы позволяет преобразовать таблицу Markdown в таблицу HTML. Компонент принимает в качестве содержимого
    таблицу Markdown. Выравнивание столбцов таблицы поддерживается с использованием синтаксиса выравнивания таблицы
    Markdown по умолчанию:</p>
<pre class=" language-php"><code class=" language-php">@<span class="token function">component</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'mail::table'</span><span class="token punctuation">)</span>
<span class="token operator">|</span> Laravel       <span class="token operator">|</span> Table         <span
                class="token operator">|</span> Example  <span class="token operator">|</span>
<span class="token operator">|</span> <span class="token operator">--</span><span class="token operator">--</span><span
                class="token operator">--</span><span class="token operator">--</span><span
                class="token operator">--</span><span class="token operator">--</span><span
                class="token operator">-</span> <span class="token operator">|</span><span
                class="token punctuation">:</span><span class="token operator">--</span><span
                class="token operator">--</span><span class="token operator">--</span><span
                class="token operator">--</span><span class="token operator">--</span><span
                class="token operator">--</span><span class="token operator">-</span><span
                class="token punctuation">:</span><span class="token operator">|</span> <span
                class="token operator">--</span><span class="token operator">--</span><span
                class="token operator">--</span><span class="token operator">--</span><span
                class="token punctuation">:</span><span class="token operator">|</span>
<span class="token operator">|</span> Col <span class="token number">2</span> is      <span
                class="token operator">|</span> Centered      <span class="token operator">|</span> <span
                class="token variable">$10</span>      <span class="token operator">|</span>
<span class="token operator">|</span> Col <span class="token number">3</span> is      <span
                class="token operator">|</span> Right<span class="token operator">-</span>Aligned <span
                class="token operator">|</span> <span class="token variable">$20</span>      <span
                class="token operator">|</span>
@endcomponent</code></pre>
<p></p>
<h3 id="customizing-the-components"><a href="#customizing-the-components">Настройка компонентов</a></h3>
<p>Вы можете экспортировать все компоненты уведомления Markdown в собственное приложение для настройки. Чтобы
    экспортировать компоненты, используйте команду <code>vendor:publish</code> Artisan для публикации
    <code>laravel-mail</code> тега ресурса:</p>
<pre class=" language-php"><code class=" language-php">php artisan vendor<span class="token punctuation">:</span>publish <span
                class="token operator">--</span>tag<span class="token operator">=</span>laravel<span
                class="token operator">-</span>mail</code></pre>
<p>Эта команда опубликует почтовые компоненты Markdown в <code>resources/views/vendor/mail</code> каталоге.
    <code>mail</code> Каталог будет содержать <code>html</code> и в <code>text</code> каталог, каждый из которых
    содержит свои соответствующие представления каждого доступного компонента. Вы можете настроить эти компоненты по
    своему усмотрению.</p>
<p></p>
<h4 id="customizing-the-css"><a href="#customizing-the-css">Настройка CSS</a></h4>
<p>После экспорта компонентов в <code>resources/views/vendor/mail/html/themes</code> каталоге будет
    <code>default.css</code> файл. Вы можете настроить CSS в этом файле, и ваши стили будут автоматически встроены в
    HTML-представления ваших уведомлений Markdown.</p>
<p>Если вы хотите создать совершенно новую тему для компонентов Laravel Markdown, вы можете поместить файл CSS в <code>html/themes</code>
    каталог. После присвоения имени и сохранения файла CSS обновите <code>theme</code> параметр <code>mail</code> файла
    конфигурации, чтобы он соответствовал имени вашей новой темы.</p>
<p>Чтобы настроить тему для отдельного уведомления, вы можете вызвать <code>theme</code> метод при создании почтового
    сообщения уведомления. <code>theme</code> Метод принимает название темы, которую следует использовать при отправке
    уведомления:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the mail representation of the notification.
 *
 * @param  mixed  $notifiable
 * @return \Illuminate\Notifications\Messages\MailMessage
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toMail</span><span
                class="token punctuation">(</span><span class="token variable">$notifiable</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">(</span><span
                class="token keyword">new</span> <span class="token class-name">MailMessage</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">theme</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'invoice'</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">subject</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Invoice Paid'</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">markdown</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'mail.invoice.paid'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'url'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$url</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h2 id="database-notifications"><a href="#database-notifications">Уведомления базы данных</a></h2>
<p></p>
<h3 id="database-prerequisites"><a href="#database-prerequisites">Предпосылки</a></h3>
<p>Канал <code>database</code> уведомления хранит информацию уведомления в таблице базы данных. Эта таблица будет
    содержать такую ​​информацию, как тип уведомления, а также структуру данных JSON, которая описывает уведомление.</p>
<p>Вы можете запросить таблицу, чтобы отобразить уведомления в пользовательском интерфейсе вашего приложения. Но прежде
    чем вы сможете это сделать, вам нужно будет создать таблицу базы данных для хранения ваших уведомлений. Вы можете
    использовать <code>notifications:table</code> команду для генерации <a href="migrations">миграции</a> с правильной
    схемой таблицы:</p>
<pre class=" language-php"><code class=" language-php">php artisan notifications<span class="token punctuation">:</span>table

php artisan migrate</code></pre>
<p></p>
<h3 id="formatting-database-notifications"><a href="#formatting-database-notifications">Форматирование уведомлений базы
        данных</a></h3>
<p>Если уведомление поддерживает сохранение в таблице базы данных, вы должны определить метод <code>toDatabase</code>
    или <code>toArray</code> в классе уведомления. Этот метод получит <code>$notifiable</code> объект и должен вернуть
    простой массив PHP. Возвращенный массив будет закодирован как JSON и сохранен в <code>data</code> столбце вашей
    <code>notifications</code> таблицы. Давайте посмотрим на пример <code>toArray</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the array representation of the notification.
 *
 * @param  mixed  $notifiable
 * @return array
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toArray</span><span
                class="token punctuation">(</span><span class="token variable">$notifiable</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'invoice_id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">invoice</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'amount'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">invoice</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">amount</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="todatabase-vs-toarray"><a href="#todatabase-vs-toarray"><code>toDatabase</code> Против. <code>toArray</code></a>
</h4>
<p>Этот <code>toArray</code> метод также используется <code>broadcast</code> каналом, чтобы определить, какие данные
    следует транслировать в ваш интерфейс на базе JavaScript. Если вы хотели бы иметь два различных представления
    массива для <code>database</code> и <code>broadcast</code> каналов, вы должны определить <code>toDatabase</code>
    метод вместо <code>toArray</code> метода.</p>
<p></p>
<h3 id="accessing-the-notifications"><a href="#accessing-the-notifications">Доступ к уведомлениям</a></h3>
<p>После того, как уведомления сохраняются в базе данных, вам понадобится удобный способ доступа к ним из объектов,
    подлежащих уведомлению. <code>Illuminate\Notifications\Notifiable</code> Черта, которая включена в Laravel по
    умолчанию <code>App\Models\User</code> модели, включает в себя <code>notifications</code> <a
            href="eloquent-relationships">отношения Красноречивых</a>, который возвращает уведомления для объекта. Для
    получения уведомлений вы можете получить доступ к этому методу, как и к любым другим отношениям Eloquent. По
    умолчанию уведомления будут отсортированы по <code>created_at</code> отметке времени с самыми последними
    уведомлениями в начале коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span> <span
                class="token operator">=</span> App\<span class="token package">Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">foreach</span> <span class="token punctuation">(</span><span
                class="token variable">$user</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">notifications</span> <span class="token keyword">as</span> <span
                class="token variable">$notification</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">echo</span> <span class="token variable">$notification</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">type</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Если вы хотите получать только «непрочитанные» уведомления, вы можете использовать <code>unreadNotifications</code>
    отношение. Опять же, эти уведомления будут отсортированы по <code>created_at</code> отметке времени с самыми
    последними уведомлениями в начале коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span> <span
                class="token operator">=</span> App\<span class="token package">Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">foreach</span> <span class="token punctuation">(</span><span
                class="token variable">$user</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">unreadNotifications</span> <span class="token keyword">as</span> <span
                class="token variable">$notification</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">echo</span> <span class="token variable">$notification</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">type</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Чтобы получить доступ к уведомлениям из клиента JavaScript, вы должны определить контроллер уведомлений для
            своего приложения, который возвращает уведомления для объекта, подлежащего уведомлению, например текущего
            пользователя. Затем вы можете сделать HTTP-запрос к URL-адресу этого контроллера из своего клиента
            JavaScript.</p></p></div>
</blockquote>
<p></p>
<h3 id="marking-notifications-as-read"><a href="#marking-notifications-as-read">Пометка уведомлений как прочитанных</a>
</h3>
<p>Как правило, вы хотите пометить уведомление как «прочитанное», когда пользователь его просматривает. <code>Illuminate\Notifications\Notifiable</code>
    Черта предоставляет <code>markAsRead</code> метод, который обновляет <code>read_at</code> столбец на записи базы
    данных в уведомлении по:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span> <span
                class="token operator">=</span> App\<span class="token package">Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">foreach</span> <span class="token punctuation">(</span><span
                class="token variable">$user</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">unreadNotifications</span> <span class="token keyword">as</span> <span
                class="token variable">$notification</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$notification</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">markAsRead</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Однако вместо того, чтобы перебирать каждое уведомление, вы можете использовать этот <code>markAsRead</code> метод
    непосредственно в коллекции уведомлений:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">unreadNotifications</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">markAsRead</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы также можете использовать запрос массового обновления, чтобы пометить все уведомления как прочитанные, не извлекая
    их из базы данных:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span> <span
                class="token operator">=</span> App\<span class="token package">Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">unreadNotifications</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">update</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'read_at'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">now</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы можете <code>delete</code> полностью удалить уведомления из таблицы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">notifications</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">delete</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="broadcast-notifications"><a href="#broadcast-notifications">Уведомления о трансляции</a></h2>
<p></p>
<h3 id="broadcast-prerequisites"><a href="#broadcast-prerequisites">Предпосылки</a></h3>
<p>Перед широковещательной рассылкой уведомлений вы должны настроить и ознакомиться со службами <a href="broadcasting">трансляции
        событий</a> Laravel. Трансляция событий предоставляет способ реагировать на серверные события Laravel из вашего
    внешнего интерфейса на базе JavaScript.</p>
<p></p>
<h3 id="formatting-broadcast-notifications"><a href="#formatting-broadcast-notifications">Форматирование
        широковещательных уведомлений</a></h3>
<p>В <code>broadcast</code> транслирует канал уведомления с использованием Laravel в <a href="broadcasting">событие
        вещания</a> услуг, что позволяет ваш активный внешний интерфейс JavaScript для уведомлений об уловах в режиме
    реального времени. Если уведомление поддерживает широковещательную рассылку, вы можете определить
    <code>toBroadcast</code> метод в классе уведомлений. Этот метод получит <code>$notifiable</code> сущность и должен
    вернуть <code>BroadcastMessage</code> экземпляр. Если <code>toBroadcast</code> метод не существует,
    <code>toArray</code> метод будет использоваться для сбора данных, которые следует транслировать. Возвращенные данные
    будут закодированы как JSON и переданы на ваш интерфейс на базе JavaScript. Давайте посмотрим на пример <code>toBroadcast</code>
    метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Notifications<span
                    class="token punctuation">\</span>Messages<span
                    class="token punctuation">\</span>BroadcastMessage</span><span class="token punctuation">;</span>

<span class="token comment">/**
 * Get the broadcastable representation of the notification.
 *
 * @param  mixed  $notifiable
 * @return BroadcastMessage
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toBroadcast</span><span
                class="token punctuation">(</span><span class="token variable">$notifiable</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token keyword">new</span> <span class="token class-name">BroadcastMessage</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'invoice_id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">invoice</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'amount'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">invoice</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">amount</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="broadcast-queue-configuration"><a href="#broadcast-queue-configuration">Конфигурация широковещательной
        очереди</a></h4>
<p>Все уведомления о трансляции ставятся в очередь для трансляции. Если вы хотите, чтобы настроить имя соединения
    очереди или очереди, которая используется в очереди на операцию широковещательной передачи, вы можете использовать
    <code>onConnection</code> и <code>onQueue</code> методы из <code>BroadcastMessage</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token punctuation">(</span><span class="token keyword">new</span> <span class="token class-name">BroadcastMessage</span><span
                class="token punctuation">(</span><span class="token variable">$data</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">onConnection</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'sqs'</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">onQueue</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'broadcasts'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="customizing-the-notification-type"><a href="#customizing-the-notification-type">Настройка типа уведомления</a>
</h4>
<p>В дополнение к указанным вами данным все широковещательные уведомления также имеют <code>type</code> поле, содержащее
    полное имя класса уведомления. Если вы хотите настроить уведомление <code>type</code>, вы можете определить <code>broadcastType</code>
    метод в классе уведомлений:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Notifications<span
                    class="token punctuation">\</span>Messages<span
                    class="token punctuation">\</span>BroadcastMessage</span><span class="token punctuation">;</span>

<span class="token comment">/**
 * Get the type of the notification being broadcast.
 *
 * @return string
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">broadcastType</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token single-quoted-string string">'broadcast.message'</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="listening-for-notifications"><a href="#listening-for-notifications">Прослушивание уведомлений</a></h3>
<p>Уведомления будут транслироваться по частному каналу, отформатированному с использованием <code>{literal}{notifiable}{/literal}
        .{literal}{id}{/literal}</code> соглашения. Итак, если вы отправляете уведомление <code>App\Models\User</code> экземпляру с
    идентификатором <code>1</code>, уведомление будет транслироваться по <code>App.Models.User.1</code> частному каналу.
    При использовании <a href="broadcasting">Laravel Echo</a> вы можете легко прослушивать уведомления на канале,
    используя <code>notification</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">Echo</span><span
                class="token punctuation">.</span><span class="token keyword">private</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'App.Models.User.'</span> <span
                class="token operator">+</span> userId<span class="token punctuation">)</span>
    <span class="token punctuation">.</span><span class="token function">notification</span><span
                class="token punctuation">(</span><span class="token punctuation">(</span>notification<span
                class="token punctuation">)</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token punctuation">{literal}{{/literal}</span>
        console<span class="token punctuation">.</span><span class="token function">log</span><span
                class="token punctuation">(</span>notification<span class="token punctuation">.</span>type<span
                class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="customizing-the-notification-channel"><a href="#customizing-the-notification-channel">Настройка канала
        уведомлений</a></h4>
<p>Если вы хотите настроить канал, на котором транслируются широковещательные уведомления объекта, вы можете определить
    <code>receivesBroadcastNotificationsOn</code> метод для объекта уведомления:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Broadcasting<span
                        class="token punctuation">\</span>PrivateChannel</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Auth<span class="token punctuation">\</span>User</span> <span
                    class="token keyword">as</span> Authenticatable<span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Notifications<span
                        class="token punctuation">\</span>Notifiable</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">User</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Authenticatable</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">use</span> <span class="token package">Notifiable</span><span class="token punctuation">;</span>

    <span class="token comment">/**
    * The channels the user receives notification broadcasts on.
    *
    * @return string
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">receivesBroadcastNotificationsOn</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token single-quoted-string string">'users.'</span><span
                    class="token punctuation">.</span><span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">id</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h2 id="sms-notifications"><a href="#sms-notifications">SMS-уведомления</a></h2>
<p></p>
<h3 id="sms-prerequisites"><a href="#sms-prerequisites">Предпосылки</a></h3>
<p>Отправка SMS-уведомлений в Laravel обеспечивается <a href="https://www.vonage.com/">Vonage</a> (ранее известный как
    Nexmo). Прежде чем вы сможете отправлять уведомления через Vonage, вам необходимо установить пакеты <code>laravel/nexmo-notification-channel</code>
    и <code>nexmo/laravel</code> Composer.</p>
<pre class=" language-php"><code class=" language-php">composer <span class="token keyword">require</span> laravel<span
                class="token operator">/</span>nexmo<span class="token operator">-</span>notification<span
                class="token operator">-</span>channel nexmo<span class="token operator">/</span>laravel</code></pre>
<p><code>nexmo/laravel</code> Пакет включает в <a
            href="https://github.com/Nexmo/nexmo-laravel/blob/master/config/nexmo.php">свой собственный файл
        конфигурации</a>. Однако вам не обязательно экспортировать этот файл конфигурации в собственное приложение. Вы
    можете просто использовать переменные окружения <code>NEXMO_KEY</code> и <code>NEXMO_SECRET</code> для установки
    публичного и секретного ключей Vonage.</p>
<p>Затем вам нужно будет добавить <code>nexmo</code> запись <code>config/services.php</code> конфигурации в файл
    конфигурации. Вы можете скопировать приведенный ниже пример конфигурации, чтобы начать:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'nexmo'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'sms_from'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'15556666666'</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p><code>sms_from</code> Вариант номер телефона, что ваши SMS сообщения будут отправляться. Вы должны сгенерировать
    номер телефона для своего приложения в панели управления Vonage.</p>
<p></p>
<h3 id="formatting-sms-notifications"><a href="#formatting-sms-notifications">Форматирование SMS-уведомлений</a></h3>
<p>Если уведомление поддерживает отправку в виде SMS, вы должны определить <code>toNexmo</code> метод в классе
    уведомлений. Этот метод получит <code>$notifiable</code> сущность и должен вернуть <code>Illuminate\Notifications\Messages\NexmoMessage</code>
    экземпляр:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the Vonage / SMS representation of the notification.
 *
 * @param  mixed  $notifiable
 * @return \Illuminate\Notifications\Messages\NexmoMessage
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toNexmo</span><span
                class="token punctuation">(</span><span class="token variable">$notifiable</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">(</span><span
                class="token keyword">new</span> <span class="token class-name">NexmoMessage</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">content</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Your SMS message content'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="unicode-content"><a href="#unicode-content">Содержимое Unicode</a></h4>
<p>Если ваше SMS-сообщение будет содержать символы Юникода, вы должны вызвать <code>unicode</code> метод при создании
    <code>NexmoMessage</code> экземпляра:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the Vonage / SMS representation of the notification.
 *
 * @param  mixed  $notifiable
 * @return \Illuminate\Notifications\Messages\NexmoMessage
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toNexmo</span><span
                class="token punctuation">(</span><span class="token variable">$notifiable</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">(</span><span
                class="token keyword">new</span> <span class="token class-name">NexmoMessage</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">content</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Your unicode message'</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">unicode</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="formatting-shortcode-notifications"><a href="#formatting-shortcode-notifications">Форматирование уведомлений о
        шорткодах</a></h3>
<p>Laravel также поддерживает отправку уведомлений с короткими кодами, которые представляют собой предварительно
    определенные шаблоны сообщений в вашей учетной записи Vonage. Чтобы отправить SMS-уведомление с коротким кодом, вы
    должны определить <code>toShortcode</code> метод в своем классе уведомлений. Изнутри этого метода, вы можете вернуть
    массив, указывающий тип уведомления ( <code>alert</code>, <code>2fa</code> или <code>marketing</code> ), а также
    пользовательские значения, которые будут заполняющие шаблон:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the Vonage / Shortcode representation of the notification.
 *
 * @param  mixed  $notifiable
 * @return array
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toShortcode</span><span
                class="token punctuation">(</span><span class="token variable">$notifiable</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'type'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'alert'</span><span
                class="token punctuation">,</span>
        <span class="token single-quoted-string string">'custom'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
            <span class="token single-quoted-string string">'code'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'ABC123'</span><span
                class="token punctuation">,</span>
        <span class="token punctuation">]</span><span class="token punctuation">;</span>
    <span class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Подобно <a href="notifications#routing-sms-notifications">маршрутизации SMS-уведомлений</a>, вы должны
            реализовать этот <code>routeNotificationForShortcode</code> метод в своей модели, подлежащей уведомлению.
        </p></p></div>
</blockquote>
<p></p>
<h3 id="customizing-the-from-number"><a href="#customizing-the-from-number">Настройка номера "От"</a></h3>
<p>Если вы хотите отправлять уведомления с номера телефона, который отличается от номера телефона, указанного в вашем
    <code>config/services.php</code> файле, вы можете вызвать <code>from</code> метод в <code>NexmoMessage</code>
    экземпляре:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the Vonage / SMS representation of the notification.
 *
 * @param  mixed  $notifiable
 * @return NexmoMessage
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toNexmo</span><span
                class="token punctuation">(</span><span class="token variable">$notifiable</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">(</span><span
                class="token keyword">new</span> <span class="token class-name">NexmoMessage</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">content</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Your SMS message content'</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">from</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'15554443333'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="routing-sms-notifications"><a href="#routing-sms-notifications">Маршрутизация SMS-уведомлений</a></h3>
<p>Чтобы направить уведомления Vonage на правильный номер телефона, определите <code>routeNotificationForNexmo</code>
    метод для вашего уведомляемого объекта:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Auth<span class="token punctuation">\</span>User</span> <span
                    class="token keyword">as</span> Authenticatable<span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Notifications<span
                        class="token punctuation">\</span>Notifiable</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">User</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Authenticatable</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">use</span> <span class="token package">Notifiable</span><span class="token punctuation">;</span>

    <span class="token comment">/**
    * Route notifications for the Nexmo channel.
    *
    * @param  \Illuminate\Notifications\Notification  $notification
    * @return string
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">routeNotificationForNexmo</span><span
                    class="token punctuation">(</span><span class="token variable">$notification</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">phone_number</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h2 id="slack-notifications"><a href="#slack-notifications">Уведомления Slack</a></h2>
<p></p>
<h3 id="slack-prerequisites"><a href="#slack-prerequisites">Предпосылки</a></h3>
<p>Прежде чем вы сможете отправлять уведомления через Slack, вы должны установить канал уведомлений Slack через
    Composer:</p>
<pre class=" language-php"><code class=" language-php">composer <span class="token keyword">require</span> laravel<span
                class="token operator">/</span>slack<span class="token operator">-</span>notification<span
                class="token operator">-</span>channel</code></pre>
<p>Вам также нужно будет настроить интеграцию <a href="https://slack.com/apps/A0F7XDUAZ-incoming-webhooks">«Incoming
        Webhook»</a> для вашей команды Slack. Эта интеграция предоставит вам URL-адрес, который вы можете использовать
    при <a href="notifications#routing-slack-notifications">маршрутизации уведомлений Slack</a>.</p>
<p></p>
<h3 id="formatting-slack-notifications"><a href="#formatting-slack-notifications">Форматирование уведомлений Slack</a>
</h3>
<p>Если уведомление поддерживает отправку в виде сообщения Slack, вы должны определить <code>toSlack</code> метод в
    классе уведомлений. Этот метод получит <code>$notifiable</code> сущность и должен вернуть <code>Illuminate\Notifications\Messages\SlackMessage</code>
    экземпляр. Сообщения Slack могут содержать текстовое содержимое, а также «вложение», которое форматирует
    дополнительный текст или массив полей. Давайте посмотрим на простой <code>toSlack</code> пример:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the Slack representation of the notification.
 *
 * @param  mixed  $notifiable
 * @return \Illuminate\Notifications\Messages\SlackMessage
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toSlack</span><span
                class="token punctuation">(</span><span class="token variable">$notifiable</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">(</span><span
                class="token keyword">new</span> <span class="token class-name">SlackMessage</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">content</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'One of your invoices has been paid!'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="customizing-the-sender-recipient"><a href="#customizing-the-sender-recipient">Настройка отправителя и
        получателя</a></h4>
<p>Вы можете использовать <code>from</code> и <code>to</code> методы для настройки отправителя и получателя.
    <code>from</code> Метод принимает имя пользователя и идентификатор эмодзи, в то время как <code>to</code> метод
    принимает канал или имя пользователя:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the Slack representation of the notification.
 *
 * @param  mixed  $notifiable
 * @return \Illuminate\Notifications\Messages\SlackMessage
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toSlack</span><span
                class="token punctuation">(</span><span class="token variable">$notifiable</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">(</span><span
                class="token keyword">new</span> <span class="token class-name">SlackMessage</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">from</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Ghost'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">':ghost:'</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">to</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'#bots'</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">content</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'This will be sent to #bots'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Вы также можете использовать изображение в качестве своего логотипа вместо эмодзи:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the Slack representation of the notification.
 *
 * @param  mixed  $notifiable
 * @return \Illuminate\Notifications\Messages\SlackMessage
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toSlack</span><span
                class="token punctuation">(</span><span class="token variable">$notifiable</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">(</span><span
                class="token keyword">new</span> <span class="token class-name">SlackMessage</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">from</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Laravel'</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">image</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'https://laravel.com/img/favicon/favicon.ico'</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">content</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'This will display the Laravel logo next to the message'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="slack-attachments"><a href="#slack-attachments">Слабые вложения</a></h3>
<p>Вы также можете добавлять «вложения» к сообщениям Slack. Вложения предоставляют более широкие возможности
    форматирования, чем простые текстовые сообщения. В этом примере мы отправим уведомление об ошибке об исключении,
    которое произошло в приложении, включая ссылку для просмотра дополнительных сведений об исключении:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the Slack representation of the notification.
 *
 * @param  mixed  $notifiable
 * @return \Illuminate\Notifications\Messages\SlackMessage
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toSlack</span><span
                class="token punctuation">(</span><span class="token variable">$notifiable</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$url</span> <span class="token operator">=</span> <span
                class="token function">url</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/exceptions/'</span><span
                class="token punctuation">.</span><span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">exception</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    
    <span class="token keyword">return</span> <span class="token punctuation">(</span><span
                class="token keyword">new</span> <span class="token class-name">SlackMessage</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">error</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">content</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Whoops! Something went wrong.'</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">attachment</span><span class="token punctuation">(</span><span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token variable">$attachment</span><span class="token punctuation">)</span> <span
                class="token keyword">use</span> <span class="token punctuation">(</span><span class="token variable">$url</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token variable">$attachment</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">title</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Exception: File Not Found'</span><span
                class="token punctuation">,</span> <span class="token variable">$url</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">content</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'File [background.jpg] was not found.'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Вложения также позволяют указать массив данных, которые должны быть представлены пользователю. Приведенные данные
    будут представлены в формате таблицы для удобства чтения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the Slack representation of the notification.
 *
 * @param  mixed  $notifiable
 * @return SlackMessage
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toSlack</span><span
                class="token punctuation">(</span><span class="token variable">$notifiable</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$url</span> <span class="token operator">=</span> <span
                class="token function">url</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/invoices/'</span><span
                class="token punctuation">.</span><span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">invoice</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    
    <span class="token keyword">return</span> <span class="token punctuation">(</span><span
                class="token keyword">new</span> <span class="token class-name">SlackMessage</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">success</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">content</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'One of your invoices has been paid!'</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">attachment</span><span class="token punctuation">(</span><span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token variable">$attachment</span><span class="token punctuation">)</span> <span
                class="token keyword">use</span> <span class="token punctuation">(</span><span class="token variable">$url</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token variable">$attachment</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">title</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Invoice 1322'</span><span class="token punctuation">,</span> <span
                class="token variable">$url</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">fields</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span>
                    <span class="token single-quoted-string string">'Title'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Server Expenses'</span><span
                class="token punctuation">,</span>
                    <span class="token single-quoted-string string">'Amount'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'$1,234'</span><span
                class="token punctuation">,</span>
                    <span class="token single-quoted-string string">'Via'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'American Express'</span><span
                class="token punctuation">,</span>
                    <span class="token single-quoted-string string">'Was Overdue'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">':-1:'</span><span
                class="token punctuation">,</span>
                <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="markdown-attachment-content"><a href="#markdown-attachment-content">Markdown Attachment Content</a></h4>
<p>Если некоторые из ваших полей вложения содержат Markdown, вы можете использовать этот <code>markdown</code> метод,
    чтобы указать Slack на синтаксический анализ и отображение заданных полей вложения как текста в формате Markdown.
    Значения, принятые по этому методу являются: <code>pretext</code>, <code>text</code> и / или <code>fields</code>.
    Дополнительные сведения о форматировании вложений <a
            href="https://api.slack.com/docs/message-formatting%23message_formatting">Slack см. В документации по API
        Slack</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the Slack representation of the notification.
 *
 * @param  mixed  $notifiable
 * @return SlackMessage
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toSlack</span><span
                class="token punctuation">(</span><span class="token variable">$notifiable</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$url</span> <span class="token operator">=</span> <span
                class="token function">url</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/exceptions/'</span><span
                class="token punctuation">.</span><span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">exception</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    
    <span class="token keyword">return</span> <span class="token punctuation">(</span><span
                class="token keyword">new</span> <span class="token class-name">SlackMessage</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">error</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">content</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Whoops! Something went wrong.'</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">attachment</span><span class="token punctuation">(</span><span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token variable">$attachment</span><span class="token punctuation">)</span> <span
                class="token keyword">use</span> <span class="token punctuation">(</span><span class="token variable">$url</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token variable">$attachment</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">title</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Exception: File Not Found'</span><span
                class="token punctuation">,</span> <span class="token variable">$url</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">content</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'File [background.jpg] was *not found*.'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">markdown</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'text'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="routing-slack-notifications"><a href="#routing-slack-notifications">Маршрутизация уведомлений Slack</a></h3>
<p>Чтобы направить уведомления Slack в соответствующую команду и канал Slack, определите
    <code>routeNotificationForSlack</code> метод для вашей уведомляемой сущности. Это должно вернуть URL-адрес
    веб-перехватчика, на который должно быть доставлено уведомление. URL-адреса веб-перехватчиков могут быть
    сгенерированы путем добавления службы «Входящий веб-перехватчик» в вашу команду Slack:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Auth<span class="token punctuation">\</span>User</span> <span
                    class="token keyword">as</span> Authenticatable<span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Notifications<span
                        class="token punctuation">\</span>Notifiable</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">User</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Authenticatable</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">use</span> <span class="token package">Notifiable</span><span class="token punctuation">;</span>

    <span class="token comment">/**
    * Route notifications for the Slack channel.
    *
    * @param  \Illuminate\Notifications\Notification  $notification
    * @return string
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">routeNotificationForSlack</span><span
                    class="token punctuation">(</span><span class="token variable">$notification</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token single-quoted-string string">'https://hooks.slack.com/services/...'</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h2 id="localizing-notifications"><a href="#localizing-notifications">Локализация уведомлений</a></h2>
<p>Laravel позволяет отправлять уведомления в языковом стандарте, отличном от текущего языкового стандарта HTTP-запроса,
    и даже будет помнить этот языковой стандарт, если уведомление поставлено в очередь.</p>
<p>Для этого <code>Illuminate\Notifications\Notification</code> класс предлагает <code>locale</code> метод установки
    желаемого языка. Приложение изменится на этот языковой стандарт при оценке уведомления, а затем вернется к
    предыдущему языку, когда оценка будет завершена:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">notify</span><span
                class="token punctuation">(</span><span class="token punctuation">(</span><span class="token keyword">new</span> <span
                class="token class-name">InvoicePaid</span><span class="token punctuation">(</span><span
                class="token variable">$invoice</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">locale</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'es'</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Локализация нескольких подлежащих уведомлению записей также может быть достигнута через <code>Notification</code>
    фасад:</p>
<pre class=" language-php"><code class=" language-php">Notification<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">locale</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'es'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">send</span><span
                class="token punctuation">(</span>
    <span class="token variable">$users</span><span class="token punctuation">,</span> <span
                class="token keyword">new</span> <span class="token class-name">InvoicePaid</span><span
                class="token punctuation">(</span><span class="token variable">$invoice</span><span
                class="token punctuation">)</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="user-preferred-locales"><a href="#user-preferred-locales">Предпочитаемые пользователем регионы</a></h3>
<p>Иногда приложения хранят предпочтительный языковой стандарт каждого пользователя. Реализуя
    <code>HasLocalePreference</code> контракт в вашей уведомляемой модели, вы можете указать Laravel использовать этот
    сохраненный языковой стандарт при отправке уведомления:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                    class="token punctuation">\</span>Translation<span class="token punctuation">\</span>HasLocalePreference</span><span
                class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">User</span> <span
                class="token keyword">extends</span> <span class="token class-name">Model</span> <span
                class="token keyword">implements</span> <span class="token class-name">HasLocalePreference</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Get the user's preferred locale.
     *
     * @return string
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">preferredLocale</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">locale</span><span
                class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></code></pre>
<p>После того, как вы внедрили интерфейс, Laravel автоматически будет использовать предпочтительный языковой стандарт
    при отправке уведомлений и почтовых сообщений в модель. Следовательно, <code>locale</code> при использовании этого
    интерфейса нет необходимости вызывать метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">notify</span><span
                class="token punctuation">(</span><span class="token keyword">new</span> <span class="token class-name">InvoicePaid</span><span
                class="token punctuation">(</span><span class="token variable">$invoice</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="notification-events"><a href="#notification-events">Уведомления о событиях</a></h2>
<p>Когда уведомление отправлено, <code>Illuminate\Notifications\Events\NotificationSent</code> <a
            href="events">событие</a> запускается системой уведомлений. Он содержит "уведомляемую" сущность и сам
    экземпляр уведомления. Вы можете зарегистрировать слушателей этого события в своем <code>EventServiceProvider</code>:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * The event listener mappings for the application.
 *
 * @var array
 */</span>
<span class="token keyword">protected</span> <span class="token variable">$listen</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'Illuminate\Notifications\Events\NotificationSent'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'App\Listeners\LogNotification'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>После регистрации слушателей в вашем <code>EventServiceProvider</code>, используйте команду <code>event:generate</code>
            Artisan, чтобы быстро сгенерировать классы слушателей.</p></p></div>
</blockquote>
<p>В качестве слушателя событий, вы можете получить доступ к <code>notifiable</code>, <code>notification</code> и <code>channel</code>
    свойства на события более узнать о получателе уведомления или самого уведомления:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Handle the event.
 *
 * @param  \Illuminate\Notifications\Events\NotificationSent  $event
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">handle</span><span
                class="token punctuation">(</span>NotificationSent <span class="token variable">$event</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// $event-&gt;channel</span>
    <span class="token comment">// $event-&gt;notifiable</span>
    <span class="token comment">// $event-&gt;notification</span>
    <span class="token comment">// $event-&gt;response</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h2 id="custom-channels"><a href="#custom-channels">Клиентские каналы</a></h2>
<p>Laravel поставляется с несколькими каналами уведомлений, но вы можете написать свои собственные драйверы для доставки
    уведомлений по другим каналам. Laravel делает это простым. Для начала определите класс, содержащий <code>send</code>
    метод. Метод должен получать два аргумента: a <code>$notifiable</code> и a <code>$notification</code>.</p>
<p>Внутри <code>send</code> метода вы можете вызывать методы в уведомлении, чтобы получить объект сообщения, понятный
    вашему каналу, а затем отправить уведомление <code>$notifiable</code> экземпляру, как хотите:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Channels</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Notifications<span
                        class="token punctuation">\</span>Notification</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">VoiceChannel</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Send the given notification.
     *
     * @param  mixed  $notifiable
     * @param  \Illuminate\Notifications\Notification  $notification
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">send</span><span
                    class="token punctuation">(</span><span class="token variable">$notifiable</span><span
                    class="token punctuation">,</span> Notification <span
                    class="token variable">$notification</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$message</span> <span class="token operator">=</span> <span class="token variable">$notification</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">toVoice</span><span
                    class="token punctuation">(</span><span class="token variable">$notifiable</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token comment">// Send notification to the $notifiable instance...</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>После определения класса канала уведомлений вы можете вернуть имя класса из <code>via</code> метода любого из ваших
    уведомлений. В этом примере <code>toVoice</code> метод вашего уведомления может возвращать любой объект, который вы
    выбираете для представления голосовых сообщений. Например, вы можете определить свой собственный
    <code>VoiceMessage</code> класс для представления этих сообщений:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Notifications</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Channels<span class="token punctuation">\</span>Messages<span
                        class="token punctuation">\</span>VoiceMessage</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Channels<span
                        class="token punctuation">\</span>VoiceChannel</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Bus<span
                        class="token punctuation">\</span>Queueable</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>ShouldQueue</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Notifications<span
                        class="token punctuation">\</span>Notification</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">InvoicePaid</span> <span class="token keyword">extends</span> <span
                    class="token class-name">Notification</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">use</span> <span class="token package">Queueable</span><span
                    class="token punctuation">;</span>

    <span class="token comment">/**
     * Get the notification channels.
     *
     * @param  mixed  $notifiable
     * @return array|string
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">via</span><span
                    class="token punctuation">(</span><span class="token variable">$notifiable</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token punctuation">[</span>VoiceChannel<span
                    class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token keyword">class</span><span class="token punctuation">]</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
     * Get the voice representation of the notification.
     *
     * @param  mixed  $notifiable
     * @return VoiceMessage
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toVoice</span><span
                    class="token punctuation">(</span><span class="token variable">$notifiable</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//...</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre> 
