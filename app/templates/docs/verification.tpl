<h1>Подтверждение по элетронной почте <sup>Email verification</sup></h1>
<ul>
    <li><a href="verification#introduction">Вступление</a>
        <ul>
            <li><a href="verification#model-preparation">Подготовка модели</a></li>
            <li><a href="verification#database-preparation">Подготовка базы данных</a></li>
        </ul>
    </li>
    <li><a href="verification#verification-routing">Маршрутизация</a>
        <ul>
            <li><a href="verification#the-email-verification-notice">Уведомление о подтверждении электронной почты</a>
            </li>
            <li><a href="verification#the-email-verification-handler">Обработчик проверки электронной почты</a></li>
            <li><a href="verification#resending-the-verification-email">Повторная отправка проверочного письма</a></li>
            <li><a href="verification#protecting-routes">Защита маршрутов</a></li>
        </ul>
    </li>
    <li><a href="verification#customization">Настройка</a></li>
    <li><a href="verification#events">События</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Многие веб-приложения требуют, чтобы пользователи проверяли свои адреса электронной почты перед использованием
    приложения. Вместо того, чтобы заставлять вас заново реализовывать эту функцию вручную для каждого создаваемого вами
    приложения, Laravel предоставляет удобные встроенные службы для отправки и проверки запросов на проверку электронной
    почты.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Хотите быстро приступить к работе? Установите один из <a href="starter-kits">стартовых наборов приложений
                Laravel</a> в новое приложение Laravel. Стартовые комплекты позаботятся о построении всей вашей системы
            аутентификации, включая поддержку проверки электронной почты.</p></p></div>
</blockquote>
<p></p>
<h3 id="model-preparation"><a href="#model-preparation">Подготовка модели</a></h3>
<p>Перед тем как начать, убедитесь, что ваша <code>App\Models\User</code> модель реализует <code>Illuminate\Contracts\Auth\MustVerifyEmail</code>
    контракт:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Auth<span
                        class="token punctuation">\</span>MustVerifyEmail</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Auth<span class="token punctuation">\</span>User</span> <span
                    class="token keyword">as</span> Authenticatable<span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Notifications<span
                        class="token punctuation">\</span>Notifiable</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">User</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Authenticatable</span> <span
                    class="token keyword">implements</span> <span class="token class-name">MustVerifyEmail</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">use</span> <span class="token package">Notifiable</span><span class="token punctuation">;</span>

    <span class="token comment">//...</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Как только этот интерфейс будет добавлен в вашу модель, вновь зарегистрированным пользователям будет автоматически
    отправлено электронное письмо со ссылкой для подтверждения адреса электронной почты. Как вы можете видеть, изучив
    ваше приложение <code>App\Providers\EventServiceProvider</code>, Laravel уже содержит <code>SendEmailVerificationNotification</code>
    <a href="events">слушателя</a>, прикрепленного к <code>Illuminate\Auth\Events\Registered</code> событию. Этот
    прослушиватель событий отправит пользователю ссылку для подтверждения по электронной почте.</p>
<p>Если вы вручную реализуете регистрацию в своем приложении вместо использования <a href="starter-kits">стартового
        набора</a>, вы должны убедиться, что отправляете <code>Illuminate\Auth\Events\Registered</code> событие после
    успешной регистрации пользователя:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Auth<span
                    class="token punctuation">\</span>Events<span
                    class="token punctuation">\</span>Registered</span><span class="token punctuation">;</span>

<span class="token function">event</span><span class="token punctuation">(</span><span class="token keyword">new</span> <span
                class="token class-name">Registered</span><span class="token punctuation">(</span><span
                class="token variable">$user</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="database-preparation"><a href="#database-preparation">Подготовка базы данных</a></h3>
<p>Затем ваша <code>user</code> таблица должна содержать <code>email_verified_at</code> столбец для хранения даты и
    времени, когда адрес электронной почты пользователя был подтвержден. По умолчанию <code>users</code> миграция
    таблиц, включенная в структуру Laravel, уже включает этот столбец. Итак, все, что вам нужно сделать, это запустить
    миграцию базы данных:</p>
<pre class=" language-php"><code class=" language-php">php artisan migrate</code></pre>
<p></p>
<h2 id="verification-routing"><a href="#verification-routing">Маршрутизация</a></h2>
<p>Чтобы правильно реализовать проверку электронной почты, необходимо определить три маршрута. Во-первых, потребуется
    маршрут для отображения уведомления пользователю о том, что он должен щелкнуть ссылку проверки электронной почты в
    проверочном письме, которое Laravel отправил им после регистрации.</p>
<p>Во-вторых, потребуется маршрут для обработки запросов, сгенерированных, когда пользователь щелкает ссылку
    подтверждения электронной почты в электронном письме.</p>
<p>В-третьих, потребуется маршрут для повторной отправки ссылки для подтверждения, если пользователь случайно потеряет
    первую ссылку для подтверждения.</p>
<p></p>
<h3 id="the-email-verification-notice"><a href="#the-email-verification-notice">Уведомление о подтверждении электронной
        почты</a></h3>
<p>Как упоминалось ранее, должен быть определен маршрут, который будет возвращать представление, инструктирующее
    пользователя щелкнуть ссылку для подтверждения адреса электронной почты, отправленную ему Laravel по электронной
    почте после регистрации. Это представление будет отображаться для пользователей, когда они попытаются получить
    доступ к другим частям приложения без предварительной проверки своего адреса электронной почты. Помните, что ссылка
    автоматически отправляется пользователю по электронной почте, если ваша <code>App\Models\User</code> модель
    реализует <code>MustVerifyEmail</code> интерфейс:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/email/verify'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token function">view</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'auth.verify-email'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">middleware</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'auth'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">name</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'verification.notice'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Маршрут, который возвращает уведомление о подтверждении электронной почты, должен быть назван <code>verification.notice</code>.
    Важно, чтобы маршруту было присвоено это точное имя, поскольку <code>verified</code> связующее ПО, <a
            href="verification#protecting-routes">включенное в Laravel,</a> будет автоматически перенаправлять на это
    имя маршрута, если пользователь не подтвердил свой адрес электронной почты.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>При ручном внедрении проверки электронной почты вы должны сами определить содержимое просмотра уведомления о
            проверке. Если вам нужны строительные леса, включающие все необходимые представления для аутентификации и
            проверки, ознакомьтесь со <a href="starter-kits">стартовыми наборами приложений Laravel</a>.</p></p></div>
</blockquote>
<p></p>
<h3 id="the-email-verification-handler"><a href="#the-email-verification-handler">Обработчик проверки электронной
        почты</a></h3>
<p>Затем нам нужно определить маршрут, который будет обрабатывать запросы, сгенерированные, когда пользователь щелкает
    ссылку подтверждения электронной почты, которая была отправлена ​​ему по электронной почте. Этот маршрут должен быть
    назван <code>verification.verify</code> и быть присвоен <code>auth</code> и <code>signed</code> промежуточное
    программное:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                    class="token punctuation">\</span>Auth<span class="token punctuation">\</span>EmailVerificationRequest</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/email/verify/{literal}{id}{/literal}/{literal}{hash}{/literal}'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>EmailVerificationRequest <span
                class="token variable">$request</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$request</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">fulfill</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
            
    <span class="token keyword">return</span> <span class="token function">redirect</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/home'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">middleware</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'auth'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'signed'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">name</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'verification.verify'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Прежде чем двигаться дальше, давайте подробнее рассмотрим этот маршрут. Во-первых, вы заметите, что мы используем
    <code>EmailVerificationRequest</code> тип запроса вместо типичного <code>Illuminate\Http\Request</code> экземпляра.
    <code>EmailVerificationRequest</code> Является <a href="validation#form-request-validation">запросом формы</a>,
    которая входит в Laravel. Этот запрос автоматически позаботится о проверке параметров запроса <code>id</code> и
    <code>hash</code>.</p>
<p>Далее мы можем перейти непосредственно к вызову <code>fulfill</code> метода по запросу. Этот метод вызовет <code>markEmailAsVerified</code>
    метод аутентифицированного пользователя и отправит <code>Illuminate\Auth\Events\Verified</code> событие. <code>markEmailAsVerified</code>
    Метод доступен по умолчанию <code>App\Models\User</code> модели через <code>Illuminate\Foundation\Auth\User</code>
    базовый класс. После подтверждения адреса электронной почты пользователя вы можете перенаправить его куда хотите.
</p>
<p></p>
<h3 id="resending-the-verification-email"><a href="#resending-the-verification-email">Повторная отправка проверочного
        письма</a></h3>
<p>Иногда пользователь может потерять или случайно удалить письмо с подтверждением адреса электронной почты. Чтобы
    учесть это, вы можете определить маршрут, позволяющий пользователю запрашивать повторную отправку проверочного
    письма. Затем вы можете сделать запрос по этому маршруту, разместив простую кнопку отправки формы в <a
            href="verification#the-email-verification-notice">окне уведомления о проверке</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">post</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/email/verification-notification'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>Request <span class="token variable">$request</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$request</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">user</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">sendEmailVerificationNotification</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
            
    <span class="token keyword">return</span> <span class="token function">back</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">with</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'message'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Verification link sent!'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">middleware</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'auth'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'throttle:6,1'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">name</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'verification.send'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="protecting-routes"><a href="#protecting-routes">Защита маршрутов</a></h3>
<p><a href="middleware">Промежуточное ПО маршрута</a> может использоваться только для того, чтобы разрешить доступ к
    заданному маршруту только проверенным пользователям. Laravel поставляется с <code>verified</code> промежуточным ПО,
    которое ссылается на <code>Illuminate\Auth\Middleware\EnsureEmailIsVerified</code> класс. Поскольку это
    промежуточное ПО уже зарегистрировано в HTTP-ядре вашего приложения, все, что вам нужно сделать, это прикрепить
    промежуточное ПО к определению маршрута:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/profile'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// Only verified users may access this route...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">middleware</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'verified'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если непроверенный пользователь попытается получить доступ к маршруту, которому назначено это промежуточное ПО, он
    будет автоматически перенаправлен на <code>verification.notice</code> <a href="routing#named-routes">указанный
        маршрут</a>.</p>
<p></p>
<h2 id="customization"><a href="#customization">Настройка</a></h2>
<p></p>
<h4 id="verification-email-customization"><a href="#verification-email-customization">Настройка адреса электронной почты
        для подтверждения</a></h4>
<p>Хотя уведомление о проверке электронной почты по умолчанию должно удовлетворять требованиям большинства приложений,
    Laravel позволяет вам настроить способ создания проверочного сообщения электронной почты.</p>
<p>Для начала передайте закрытие <code>toMailUsing</code> метода, предоставленного в <code>Illuminate\Auth\Notifications\VerifyEmail</code>
    уведомлении. Закрытие получит уведомляемый экземпляр модели, который получает уведомление, а также подписанный
    URL-адрес подтверждения электронной почты, который пользователь должен посетить, чтобы проверить свой адрес
    электронной почты. Замыкание должно возвращать экземпляр <code>Illuminate\Notifications\Messages\MailMessage</code>.
    Как правило, вы должны вызывать <code>toMailUsing</code> метод из <code>boot</code> метода класса вашего приложения
    <code>App\Providers\AuthServiceProvider</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Auth<span
                    class="token punctuation">\</span>Notifications<span
                    class="token punctuation">\</span>VerifyEmail</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Notifications<span
                    class="token punctuation">\</span>Messages<span class="token punctuation">\</span>MailMessage</span><span
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
    <span class="token comment">//...</span>
    
    VerifyEmail<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">toMailUsing</span><span class="token punctuation">(</span><span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token variable">$notifiable</span><span class="token punctuation">,</span> <span
                class="token variable">$url</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token punctuation">(</span><span
                class="token keyword">new</span> <span class="token class-name">MailMessage</span><span
                class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">subject</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Verify Email Address'</span><span
                class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">line</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Click the button below to verify your email address.'</span><span
                class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">action</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Verify Email Address'</span><span
                class="token punctuation">,</span> <span class="token variable">$url</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Чтобы узнать больше о почтовых уведомлениях, обратитесь к документации по <a
                    href="notifications#mail-notifications">почтовым уведомлениям</a>.</p></p></div>
</blockquote>
<p></p>
<h2 id="events"><a href="#events">События</a></h2>
<p>При использовании <a href="starter-kits">стартовых наборов приложений</a> Laravel Laravel отправляет <a
            href="events">события</a> в процессе проверки электронной почты. Если вы вручную обрабатываете проверку
    электронной почты для своего приложения, вы можете вручную отправлять эти события после завершения проверки. Вы
    можете прикрепить слушателей к этим событиям в своем приложении <code>EventServiceProvider</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * The event listener mappings for the application.
 *
 * @var array
 */</span>
<span class="token keyword">protected</span> <span class="token variable">$listen</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'Illuminate\Auth\Events\Verified'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'App\Listeners\LogVerifiedUser'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">;</span></code></pre> 
