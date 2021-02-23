<h1>Почта <sup>Mail</sup></h1>
<ul>
    <li><a href="mail#introduction">Вступление <sup>Introduction</sup></a>
        <ul>
            <li><a href="mail#configuration">Конфигурация <sup>Configuration</sup></a></li>
            <li><a href="mail#driver-prerequisites">Требования к драйверам <sup>Driver prerequisites</sup></a></li>
        </ul>
    </li>
    <li><a href="mail#generating-mailables">Создание почтовых сообщений <sup>Generating mailables</sup></a></li>
    <li><a href="mail#writing-mailables">Написание почтовых отправлений <sup>Writing mailables</sup></a>
        <ul>
            <li><a href="mail#configuring-the-sender">Настройка отправителя <sup>Configuring the sender</sup></a></li>
            <li><a href="mail#configuring-the-view">Настройка представления <sup>Configuring the view</sup></a></li>
            <li><a href="mail#view-data">Просмотр данных <sup>View data</sup></a></li>
            <li><a href="mail#attachments">Вложения <sup>Attachments</sup></a></li>
            <li><a href="mail#inline-attachments">Встроенные вложения <sup>Inline attachments</sup></a></li>
            <li><a href="mail#customizing-the-swiftmailer-message">Настройка сообщения SwiftMailer <sup>Customizing the SwiftMailer message</sup></a></li>
        </ul>
    </li>
    <li><a href="mail#markdown-mailables">Почтовые сообщения Markdown <sup>Markdown mailables</sup></a>
        <ul>
            <li><a href="mail#generating-markdown-mailables">Создание почтовых сообщений Markdown <sup>Generating Markdown mailables</sup></a></li>
            <li><a href="mail#writing-markdown-messages">Написание сообщений Markdown <sup>Writing Markdown messages</sup></a></li>
            <li><a href="mail#customizing-the-components">Настройка компонентов <sup>Customizing the components</sup></a></li>
        </ul>
    </li>
    <li><a href="mail#sending-mail">Отправка почты <sup>Sending mail</sup></a>
        <ul>
            <li><a href="mail#queueing-mail">Очередь почты <sup>Queueing mail</sup></a></li>
        </ul>
    </li>
    <li><a href="mail#rendering-mailables">Обработка почтовых сообщений <sup>Rendering mailables</sup></a>
        <ul>
            <li><a href="mail#previewing-mailables-in-the-browser">Предварительный просмотр почтовых сообщений в
                    браузере <sup>Previewing mailables in the browser</sup></a></li>
        </ul>
    </li>
    <li><a href="mail#localizing-mailables">Локализация почтовых отправлений <sup>Localizing mailables</sup></a></li>
    <li><a href="mail#testing-mailables">Проверка почтовых сообщений <sup>Testing Mailables</sup></a></li>
    <li><a href="mail#mail-and-local-development">Почта и локальная разработка <sup>Mail & Local Development</sup></a></li>
    <li><a href="mail#events">События <sup>Events</sup></a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление <sup>Introduction</sup></a></h2>
<p>Отправка электронной почты не должна быть сложной. Laravel предоставляет чистый и простой почтовый API на базе
    популярной библиотеки <a href="https://swiftmailer.symfony.com/">SwiftMailer</a>. Laravel и SwiftMailer
    предоставляют драйверы для отправки электронной почты через SMTP, Mailgun, Postmark, Amazon SES и
    <code>sendmail</code> позволяют быстро начать отправку почты через локальную или облачную службу по вашему выбору.
</p>
<p></p>
<h3 id="configuration"><a href="#configuration">Конфигурация <sup>Configuration</sup></a></h3>
<p>Почтовые службы Laravel можно настроить через файл конфигурации вашего приложения <code>config/mail.php</code>.
    Каждая почтовая программа, настроенная в этом файле, может иметь свою собственную уникальную конфигурацию и даже
    свой собственный уникальный «транспорт», что позволяет вашему приложению использовать различные почтовые службы для
    отправки определенных сообщений электронной почты. Например, ваше приложение может использовать Postmark для
    отправки транзакционных писем, а Amazon SES - для массовых рассылок.</p>
<p>В вашем <code>mail</code> файле конфигурации вы найдете <code>mailers</code> массив конфигурации. Этот массив
    содержит образец записи конфигурации для каждого из основных почтовых драйверов / транспортов, поддерживаемых
    Laravel, в то время как <code>default</code> значение конфигурации определяет, какая почтовая программа будет
    использоваться по умолчанию, когда ваше приложение должно отправить сообщение электронной почты.</p>
<p></p>
<h3 id="driver-prerequisites"><a href="#driver-prerequisites">Требования к драйверу/транспорту <sup>Driver/transport prerequisites</sup></a></h3>
<p>Драйверы на основе API, такие как Mailgun и Postmark, часто проще и быстрее, чем отправка почты через SMTP-серверы.
    По возможности мы рекомендуем использовать один из этих драйверов. Для всех драйверов на основе API требуется
    HTTP-библиотека Guzzle, которую можно установить через диспетчер пакетов Composer:</p>
<pre class=" language-php"><code class=" language-php">composer <span
                class="token keyword">require</span> guzzlehttp<span class="token operator">/</span>guzzle</code></pre>
<p></p>
<h4 id="mailgun-driver"><a href="#mailgun-driver">Драйвер Mailgun</a></h4>
<p>Чтобы использовать драйвер Mailgun, сначала установите HTTP-библиотеку Guzzle. Затем установите для
    <code>default</code> параметра в <code>config/mail.php</code> файле конфигурации значение <code>mailgun</code>.
    Затем убедитесь, что ваш <code>config/services.php</code> файл конфигурации содержит следующие параметры:</p>
<pre class=" language-php"><code class=" language-php"><span class="token single-quoted-string string">'mailgun'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'domain'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'MAILGUN_DOMAIN'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'secret'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'MAILGUN_SECRET'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p>Если вы не используете регион <a href="https://documentation.mailgun.com/en/latest/api-intro.html%23mailgun-regions">Mailgun
        в</a> США, вы можете указать конечную точку своего региона в <code>services</code> файле конфигурации:</p>
<pre class=" language-php"><code class=" language-php"><span class="token single-quoted-string string">'mailgun'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'domain'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'MAILGUN_DOMAIN'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'secret'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'MAILGUN_SECRET'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'endpoint'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'MAILGUN_ENDPOINT'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'api.eu.mailgun.net'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p></p>
<h4 id="postmark-driver"><a href="#postmark-driver">Драйвер Postmark</a></h4>
<p>Чтобы использовать драйвер Postmark, установите транспорт Postmark SwiftMailer через Composer:</p>
<pre class=" language-php"><code class=" language-php">composer <span class="token keyword">require</span> wildbit<span
                class="token operator">/</span>swiftmailer<span class="token operator">-</span>postmark</code></pre>
<p>Затем установите HTTP-библиотеку Guzzle и установите для <code>default</code> параметра в
    <code>config/mail.php</code> файле конфигурации значение <code>postmark</code>. Наконец, убедитесь, что ваш <code>config/services.php</code>
    файл конфигурации содержит следующие параметры:</p>
<pre class=" language-php"><code class=" language-php"><span class="token single-quoted-string string">'postmark'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'token'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'POSTMARK_TOKEN'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p>Если вы хотите указать поток сообщений Postmark, который должен использоваться данной почтовой программой, вы можете
    добавить <code>message_stream_id</code> параметр конфигурации в массив конфигурации почтовой программы. Этот массив
    конфигурации можно найти в <code>config/mail.php</code> файле конфигурации вашего приложения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token single-quoted-string string">'postmark'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'transport'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'postmark'</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'message_stream_id'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token function">env</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'POSTMARK_MESSAGE_STREAM_ID'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p>Таким образом, вы также можете настроить несколько почтовых программ Postmark с разными потоками сообщений.</p>
<p></p>
<h4 id="ses-driver"><a href="#ses-driver">Драйвер SES</a></h4>
<p>Чтобы использовать драйвер Amazon SES, сначала необходимо установить Amazon AWS SDK для PHP. Вы можете установить эту
    библиотеку через менеджер пакетов Composer:</p>
<pre class=" language-bash"><code class=" language-bash"><span class="token function">composer</span> require aws/aws-sdk-php</code></pre>
<p>Затем установите для <code>default</code> параметра в <code>config/mail.php</code> файле конфигурации значение <code>ses</code>
    и убедитесь, что файл <code>config/services.php</code> конфигурации содержит следующие параметры:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'ses'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'key'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'AWS_ACCESS_KEY_ID'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'secret'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'AWS_SECRET_ACCESS_KEY'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'region'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'AWS_DEFAULT_REGION'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'us-east-1'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p>Если вы хотите определить <a
            href="https://docs.aws.amazon.com/aws-sdk-php/v3/api/api-email-2010-12-01.html%23sendrawemail">дополнительные
        параметры,</a> которые Laravel должен передавать <code>SendRawEmail</code> методу AWS SDK при отправке
    электронного письма, вы можете определить <code>options</code> массив в своей <code>ses</code> конфигурации:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'ses'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'key'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'AWS_ACCESS_KEY_ID'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'secret'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'AWS_SECRET_ACCESS_KEY'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'region'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'AWS_DEFAULT_REGION'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'us-east-1'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'options'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'ConfigurationSetName'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'MyConfigurationSet'</span><span
                class="token punctuation">,</span>
        <span class="token single-quoted-string string">'Tags'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
            <span class="token punctuation">[</span><span class="token single-quoted-string string">'Name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'foo'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Value'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'bar'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
        <span class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p></p>
<h2 id="generating-mailables"><a href="#generating-mailables">Создание почтовых сообщений <sup>Generating mailables</sup></a></h2>
<p>При создании приложений Laravel каждый тип электронной почты, отправляемой вашим приложением, представляется как
    «почтовый» класс. Эти классы хранятся в <code>app/Mail</code> каталоге. Не беспокойтесь, если вы не видите этот
    каталог в своем приложении, поскольку он будет создан для вас, когда вы создадите свой первый почтовый класс с
    помощью команды <code>make:mail</code> Artisan:</p>
<pre class=" language-php"><code class=" language-php">php artisan make<span class="token punctuation">:</span>mail OrderShipped</code></pre>
<p></p>
<h2 id="writing-mailables"><a href="#writing-mailables">Написание почтовых отправлений <sup>Writing mailables</sup></a></h2>
<p>После того, как вы создали почтовый класс, откройте его, чтобы мы могли изучить его содержимое. Во-первых, обратите
    внимание, что вся конфигурация почтового класса выполняется в <code>build</code> методе. В рамках этого метода, вы
    можете вызвать различные методы, такие как <code>from</code>, <code>subject</code>, <code>view</code> и, <code>attach</code>
    чтобы настроить представления и доставки сообщения электронной почты в.</p>
<p></p>
<h3 id="configuring-the-sender"><a href="#configuring-the-sender">Настройка отправителя <sup>Configuring the sender</sup></a></h3>
<p></p>
<h4 id="using-the-from-method"><a href="#using-the-from-method">Использование <code>from</code> метода</a></h4>
<p>Во-первых, давайте рассмотрим настройку отправителя электронного письма. Или, другими словами, от кого будет
    электронное письмо. Настроить отправителя можно двумя способами. Во-первых, вы можете использовать <code>from</code>
    метод в методе вашего почтового класса <code>build</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Build the message.
 *
 * @return $this
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">build</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">from</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'example@example.com'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">view</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'emails.orders.shipped'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="using-a-global-from-address"><a href="#using-a-global-from-address">Использование глобального <code>from</code>
        адреса</a></h4>
<p>Однако, если ваше приложение использует один и тот же адрес «отправителя» для всех своих электронных писем, вызов
    <code>from</code> метода в каждом создаваемом вами почтовом классе может стать громоздким. Вместо этого вы можете
    указать глобальный адрес «от» в вашем <code>config/mail.php</code> файле конфигурации. Этот адрес будет
    использоваться, если в почтовом классе не указан другой адрес "от":</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'from'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'address'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'example@example.com'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'App Name'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span></code></pre>
<p>Кроме того, вы можете определить глобальный адрес «reply_to» в своем <code>config/mail.php</code> файле конфигурации:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token single-quoted-string string">'reply_to'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'address'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'example@example.com'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'App Name'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span></code></pre>
<p></p>
<h3 id="configuring-the-view"><a href="#configuring-the-view">Настройка представления <sup>Configuring the view</sup></a></h3>
<p>В методе почтового класса <code>build</code> вы можете использовать этот <code>view</code> метод, чтобы указать,
    какой шаблон следует использовать при рендеринге содержимого электронного письма. Поскольку каждое электронное
    письмо обычно использует <a href="blade">шаблон Blade</a> для визуализации своего содержимого, вы получаете всю мощь
    и удобство механизма шаблонов Blade при создании HTML-кода электронной почты:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Build the message.
 *
 * @return $this
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">build</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">view</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'emails.orders.shipped'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Вы можете создать <code>resources/views/emails</code> каталог для всех ваших шаблонов электронной почты;
            однако вы можете разместить их где угодно в вашем <code>resources/views</code> каталоге.</p></p></div>
</blockquote>
<p></p>
<h4 id="plain-text-emails"><a href="#plain-text-emails">Письма с обычным текстом</a></h4>
<p>Если вы хотите определить текстовую версию своего электронного письма, вы можете использовать этот <code>text</code>
    метод. Как и <code>view</code> метод, <code>text</code> метод принимает имя шаблона, которое будет использоваться
    для визуализации содержимого электронного письма. Вы можете определить как HTML, так и текстовую версию вашего
    сообщения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Build the message.
 *
 * @return $this
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">build</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">view</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'emails.orders.shipped'</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">text</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'emails.orders.shipped_plain'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="view-data"><a href="#view-data">Просмотр данных <sup>View data</sup></a></h3>
<p></p>
<h4 id="via-public-properties"><a href="#via-public-properties">Через общедоступные объекты</a></h4>
<p>Как правило, вам нужно передать в представление некоторые данные, которые можно использовать при рендеринге HTML-кода
    электронного письма. Есть два способа сделать данные доступными для вашего представления. Во-первых, любое
    общедоступное свойство, определенное в вашем почтовом классе, будет автоматически доступно для представления. Так,
    например, вы можете передать данные в конструктор вашего почтового класса и установить эти данные в общедоступные
    свойства, определенные в классе:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Mail</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span
                        class="token punctuation">\</span>Order</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Bus<span
                        class="token punctuation">\</span>Queueable</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Mail<span
                        class="token punctuation">\</span>Mailable</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>SerializesModels</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">OrderShipped</span> <span class="token keyword">extends</span> <span
                    class="token class-name">Mailable</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">use</span> <span class="token package">Queueable</span><span
                    class="token punctuation">,</span> SerializesModels<span class="token punctuation">;</span>

    <span class="token comment">/**
    * The order instance.
    *
    * @var \App\Models\Order
    */</span>
    <span class="token keyword">public</span> <span class="token variable">$order</span><span class="token punctuation">;</span>

    <span class="token comment">/**
    * Create a new message instance.
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

    <span class="token comment">/**
    * Build the message.
    *
    * @return $this
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">build</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">view</span><span
                    class="token punctuation">(</span><span class="token single-quoted-string string">'emails.orders.shipped'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>После того, как данные были установлены в общедоступное свойство, они будут автоматически доступны в вашем
    представлении, поэтому вы можете получить к ним доступ, как и любые другие данные в ваших шаблонах Blade:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>div<span
                class="token operator">&gt;</span>
    Price<span class="token punctuation">:</span> <span class="token punctuation">{literal}{{/literal}</span><span
                class="token punctuation">{literal}{{/literal}</span> <span class="token variable">$order</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">price</span> <span
                class="token punctuation">}</span><span class="token punctuation">}</span>
<span class="token operator">&lt;</span><span class="token operator">/</span>div<span class="token operator">&gt;</span></code></pre>
<p></p>
<h4 id="via-the-with-method"><a href="#via-the-with-method">С помощью <code>with</code> метода:</a></h4>
<p>Если вы хотите настроить формат данных электронной почты до их отправки в шаблон, вы можете вручную передать свои
    данные в представление с помощью <code>with</code> метода. Как правило, вы по-прежнему будете передавать данные
    через конструктор почтового класса; однако вы должны установить для этих данных значение <code>protected</code> или
    <code>private</code> свойства, чтобы данные не были автоматически доступны для шаблона. Затем при вызове
    <code>with</code> метода передайте массив данных, которые вы хотите сделать доступными для шаблона:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Mail</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span
                        class="token punctuation">\</span>Order</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Bus<span
                        class="token punctuation">\</span>Queueable</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Mail<span
                        class="token punctuation">\</span>Mailable</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>SerializesModels</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">OrderShipped</span> <span class="token keyword">extends</span> <span
                    class="token class-name">Mailable</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">use</span> <span class="token package">Queueable</span><span
                    class="token punctuation">,</span> SerializesModels<span class="token punctuation">;</span>

    <span class="token comment">/**
    * The order instance.
    *
    * @var \App\Models\Order
    */</span>
    <span class="token keyword">protected</span> <span class="token variable">$order</span><span
                    class="token punctuation">;</span>

    <span class="token comment">/**
    * Create a new message instance.
    *
    * @param  \App\Models\Order $order
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

    <span class="token comment">/**
    * Build the message.
    *
    * @return $this
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">build</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">view</span><span
                    class="token punctuation">(</span><span class="token single-quoted-string string">'emails.orders.shipped'</span><span
                    class="token punctuation">)</span>
                    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">with</span><span class="token punctuation">(</span><span
                    class="token punctuation">[</span>
                        <span class="token single-quoted-string string">'orderName'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">order</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">name</span><span
                    class="token punctuation">,</span>
                        <span class="token single-quoted-string string">'orderPrice'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">order</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">price</span><span
                    class="token punctuation">,</span>
                    <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>После того, как данные были переданы в <code>with</code> метод, они будут автоматически доступны в вашем
    представлении, поэтому вы можете получить к ним доступ, как и любые другие данные в ваших шаблонах Blade:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>div<span
                class="token operator">&gt;</span>
    Price<span class="token punctuation">:</span> <span class="token punctuation">{literal}{{/literal}</span><span
                class="token punctuation">{literal}{{/literal}</span> <span
                class="token variable">$orderPrice</span> <span class="token punctuation">}</span><span
                class="token punctuation">}</span>
<span class="token operator">&lt;</span><span class="token operator">/</span>div<span class="token operator">&gt;</span></code></pre>
<p></p>
<h3 id="attachments"><a href="#attachments">Вложения <sup>Attachments</sup></a></h3>
<p>Чтобы добавить вложения к электронному письму, используйте <code>attach</code> метод внутри класса mailable <code>build</code>.
    <code>attach</code> Метод принимает полный путь к файлу в качестве первого аргумента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Build the message.
 *
 * @return $this
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">build</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">view</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'emails.orders.shipped'</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">attach</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/path/to/file'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>При прикреплении файлов к сообщению вы также можете указать отображаемое имя и / или MIME-тип, передав методу в
    <code>array</code> качестве второго аргумента <code>attach</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Build the message.
 *
 * @return $this
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">build</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">view</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'emails.orders.shipped'</span><span class="token punctuation">)</span>
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
<p></p>
<h4 id="attaching-files-from-disk"><a href="#attaching-files-from-disk">Прикрепление файлов с диска</a></h4>
<p>Если вы сохранили файл на одном из <a href="filesystem">дисков файловой системы</a>, вы можете прикрепить его к
    электронному письму следующим <code>attachFromStorage</code> образом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Build the message.
 *
 * @return $this
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">build</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">view</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'emails.orders.shipped'</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">attachFromStorage</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/path/to/file'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>При необходимости вы можете указать имя вложения файла и дополнительные параметры, используя второй и третий
    аргументы <code>attachFromStorage</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Build the message.
 *
 * @return $this
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">build</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">view</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'emails.orders.shipped'</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">attachFromStorage</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/path/to/file'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'name.pdf'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
                    <span class="token single-quoted-string string">'mime'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'application/pdf'</span>
                <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Этот <code>attachFromStorageDisk</code> метод можно использовать, если вам нужно указать диск хранения, отличный от
    диска по умолчанию:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Build the message.
 *
 * @return $this
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">build</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">view</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'emails.orders.shipped'</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">attachFromStorageDisk</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'s3'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'/path/to/file'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="raw-data-attachments"><a href="#raw-data-attachments">Вложения сырых данных</a></h4>
<p><code>attachData</code> Метод может быть использован, чтобы прикрепить сырую строку байт в качестве вложения.
    Например, вы можете использовать этот метод, если вы создали PDF-файл в памяти и хотите прикрепить его к
    электронному письму, не записывая его на диск. <code>attachData</code> Метод принимает исходные данные байт в
    качестве первого аргумента, имени файла в качестве второго аргумента, и массива значений в качестве третьего
    аргумента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Build the message.
 *
 * @return $this
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">build</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">view</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'emails.orders.shipped'</span><span class="token punctuation">)</span>
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
<h3 id="inline-attachments"><a href="#inline-attachments">Встроенные вложения <sup>Inline attachments</sup></a></h3>
<p>Встраивание встроенных изображений в ваши электронные письма, как правило, обременительно; однако Laravel
    предоставляет удобный способ прикреплять изображения к вашим письмам. Чтобы встроить встроенное изображение,
    используйте <code>embed</code> метод <code>$message</code> переменной в шаблоне электронной почты. Laravel
    автоматически делает <code>$message</code> переменную доступной для всех ваших шаблонов электронной почты, поэтому
    вам не нужно беспокоиться о ее передаче вручную:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>body<span
                class="token operator">&gt;</span>
    Here is an image<span class="token punctuation">:</span>

    <span class="token operator">&lt;</span>img src<span class="token operator">=</span><span
                class="token double-quoted-string string">"{literal}{{{/literal} <span class="token interpolation"><span
                        class="token variable">$message</span><span class="token operator">-</span><span
                        class="token operator">&gt;</span><span class="token property">embed</span></span>(<span
                    class="token interpolation"><span class="token variable">$pathToImage</span></span>) }}"</span><span
                class="token operator">&gt;</span>
<span class="token operator">&lt;</span><span class="token operator">/</span>body<span
                class="token operator">&gt;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p><code>$message</code> Переменная не доступна в шаблонах сообщений с открытым текстом, так как обычные
            текстовые сообщения не использовать встроенные приложения.</p></p></div>
</blockquote>
<p></p>
<h4 id="embedding-raw-data-attachments"><a href="#embedding-raw-data-attachments">Встраивание вложений необработанных
        данных</a></h4>
<p>Если у вас уже есть строка необработанных данных изображения, которую вы хотите встроить в шаблон электронной почты,
    вы можете вызвать <code>embedData</code> метод для <code>$message</code> переменной. При вызове
    <code>embedData</code> метода вам нужно будет указать имя файла, которое должно быть присвоено встроенному
    изображению:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>body<span
                class="token operator">&gt;</span>
    Here is an image from raw data<span class="token punctuation">:</span>

    <span class="token operator">&lt;</span>img src<span class="token operator">=</span><span
                class="token double-quoted-string string">"{literal}{{{/literal} <span class="token interpolation"><span
                        class="token variable">$message</span><span class="token operator">-</span><span
                        class="token operator">&gt;</span><span class="token property">embedData</span></span>(<span
                    class="token interpolation"><span class="token variable">$data</span></span>, 'example-image.jpg') }}"</span><span
                class="token operator">&gt;</span>
<span class="token operator">&lt;</span><span class="token operator">/</span>body<span
                class="token operator">&gt;</span></code></pre>
<p></p>
<h3 id="customizing-the-swiftmailer-message"><a href="#customizing-the-swiftmailer-message">Настройка сообщения
        SwiftMailer <sup>Customizing the SwiftMailer message</sup></a></h3>
<p><code>withSwiftMessage</code> Метод <code>Mailable</code> базового класса позволяет зарегистрировать замыкание,
    которое будет вызываться с экземпляром сообщения SwiftMailer перед отправкой сообщения. Это дает вам возможность
    глубоко настроить сообщение перед его доставкой:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Build the message.
 *
 * @return $this
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">build</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">view</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'emails.orders.shipped'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
    
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">withSwiftMessage</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$message</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$message</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">getHeaders</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">addTextHeader</span><span
                class="token punctuation">(</span>
            <span class="token single-quoted-string string">'Custom-Header'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Header Value'</span>
        <span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h2 id="markdown-mailables"><a href="#markdown-mailables">Почтовые сообщения Markdown <sup>Markdown mailables</sup></a></h2>
<p>Почтовые сообщения Markdown позволяют вам воспользоваться преимуществами предварительно созданных шаблонов и
    компонентов <a href="notifications#mail-notifications">почтовых уведомлений</a> в ваших почтовых сообщениях.
    Поскольку сообщения написаны в Markdown, Laravel может отображать красивые, отзывчивые HTML-шаблоны для сообщений, а
    также автоматически генерировать аналог в виде простого текста.</p>
<p></p>
<h3 id="generating-markdown-mailables"><a href="#generating-markdown-mailables">Создание почтовых сообщений Markdown <sup>Generating Markdown mailables</sup></a></h3>
<p>Чтобы создать почтовое сообщение с соответствующим шаблоном Markdown, вы можете использовать <code>--markdown</code>
    опцию <code>make:mail</code> Artisan-команды:</p>
<pre class=" language-php"><code class=" language-php">php artisan make<span class="token punctuation">:</span>mail OrderShipped <span
                class="token operator">--</span>markdown<span class="token operator">=</span>emails<span
                class="token punctuation">.</span>orders<span class="token punctuation">.</span>shipped</code></pre>
<p>Затем при настройке почтового сообщения в его <code>build</code> методе вызовите <code>markdown</code> метод вместо
    <code>view</code> метода. <code>markdown</code> Метод принимает имя шаблона Markdown и дополнительный массив данных,
    чтобы сделать доступными в шаблоне:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Build the message.
 *
 * @return $this
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">build</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">from</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'example@example.com'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">markdown</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'emails.orders.shipped'</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span>
                    <span class="token single-quoted-string string">'url'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">orderUrl</span><span
                class="token punctuation">,</span>
                <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="writing-markdown-messages"><a href="#writing-markdown-messages">Написание сообщений Markdown <sup>Writing Markdown messages</sup></a></h3>
<p>В почтовых сообщениях Markdown используется комбинация компонентов Blade и синтаксиса Markdown, которые позволяют
    легко создавать почтовые сообщения, используя предварительно созданные компоненты пользовательского интерфейса
    электронной почты Laravel:</p>
<pre class=" language-php"><code class=" language-php">@<span class="token function">component</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'mail::message'</span><span
                class="token punctuation">)</span>
<span class="token shell-comment comment"># Order Shipped</span>

Your order has been shipped<span class="token operator">!</span>

@<span class="token function">component</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'mail::button'</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span><span class="token single-quoted-string string">'url'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token variable">$url</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span>
View Order
@endcomponent

Thanks<span class="token punctuation">,</span><span class="token operator">&lt;</span>br<span class="token operator">&gt;</span>
<span class="token punctuation">{literal}{{/literal}</span><span
                class="token punctuation">{literal}{{/literal}</span> <span class="token function">config</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'app.name'</span><span
                class="token punctuation">)</span> <span class="token punctuation">}</span><span
                class="token punctuation">}</span>
@endcomponent</code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Не используйте лишние отступы при написании писем Markdown. По стандартам Markdown парсеры Markdown будут
            отображать контент с отступом в виде блоков кода.</p></p></div>
</blockquote>
<p></p>
<h4 id="button-component"><a href="#button-component">Компонент кнопки</a></h4>
<p>Компонент кнопки отображает ссылку на кнопку по центру. Компонент принимает два аргумента: a <code>url</code> и
    необязательный <code>color</code>. Поддерживаемые цвета <code>primary</code>, <code>success</code> и
    <code>error</code>. Вы можете добавить к сообщению столько компонентов кнопки, сколько захотите:</p>
<pre class=" language-php"><code class=" language-php">@<span class="token function">component</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'mail::button'</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span><span class="token single-quoted-string string">'url'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token variable">$url</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'color'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'success'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span>
View Order
@endcomponent</code></pre>
<p></p>
<h4 id="panel-component"><a href="#panel-component">Компонент панели</a></h4>
<p>Компонент панели отображает указанный блок текста на панели, цвет фона которой немного отличается от цвета остальной
    части сообщения. Это позволяет привлечь внимание к заданному блоку текста:</p>
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
<h3 id="customizing-the-components"><a href="#customizing-the-components">Настройка компонентов <sup>Customizing the components</sup></a></h3>
<p>Вы можете экспортировать все почтовые компоненты Markdown в собственное приложение для настройки. Чтобы
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
    <code>default.css</code> файл. Вы можете настроить CSS в этом файле, и ваши стили будут автоматически преобразованы
    во встроенные стили CSS в HTML-представлениях ваших почтовых сообщений Markdown.</p>
<p>Если вы хотите создать совершенно новую тему для компонентов Laravel Markdown, вы можете поместить файл CSS в <code>html/themes</code>
    каталог. После присвоения имени и сохранения файла CSS обновите <code>theme</code> параметр
    <code>config/mail.php</code> файла конфигурации приложения, чтобы он соответствовал имени вашей новой темы.</p>
<p>Чтобы настроить тему для отдельного почтового сообщения, вы можете установить <code>$theme</code> свойство класса
    mailable на имя темы, которое следует использовать при отправке этого почтового сообщения.</p>
<p></p>
<h2 id="sending-mail"><a href="#sending-mail">Отправка почты <sup>Sending mail</sup></a></h2>
<p>Чтобы отправить сообщение, используйте <code>to</code> метод на <code>Mail</code> <a href="facades">фасаде</a>.
    <code>to</code> Метод принимает адрес электронной почты, пользовательский экземпляр, или набор пользователей. Если
    передать объект или коллекцию объектов, почтовая программа будет автоматически использовать их <code>email</code> и
    <code>name</code> свойства при определении получателей сообщения электронной почты, так что убедитесь, что эти
    атрибуты доступны на ваших объектах. После того, как вы указали своих получателей, вы можете передать в
    <code>send</code> метод экземпляр вашего почтового класса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>Controller</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Mail<span
                        class="token punctuation">\</span>OrderShipped</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span
                        class="token punctuation">\</span>Order</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Mail</span><span class="token punctuation">;</span>

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

        <span class="token comment">// Ship the order...</span>

        Mail<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">to</span><span class="token punctuation">(</span><span
                    class="token variable">$request</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">user</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">send</span><span class="token punctuation">(</span><span
                    class="token keyword">new</span> <span class="token class-name">OrderShipped</span><span
                    class="token punctuation">(</span><span class="token variable">$order</span><span
                    class="token punctuation">)</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Вы не ограничены простым указанием получателей при отправке сообщения. Вы можете указать получателей "to", "cc" и
    "bcc", связав их соответствующие методы вместе:</p>
<pre class=" language-php"><code class=" language-php">Mail<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">to</span><span class="token punctuation">(</span><span
                class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">user</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">cc</span><span class="token punctuation">(</span><span class="token variable">$moreUsers</span><span
                class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">bcc</span><span
                class="token punctuation">(</span><span class="token variable">$evenMoreUsers</span><span
                class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">send</span><span class="token punctuation">(</span><span class="token keyword">new</span> <span
                class="token class-name">OrderShipped</span><span class="token punctuation">(</span><span
                class="token variable">$order</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="looping-over-recipients"><a href="#looping-over-recipients">Цикл по получателям</a></h4>
<p>Иногда вам может потребоваться отправить почтовое сообщение списку получателей, перебирая массив получателей /
    адресов электронной почты. Однако, поскольку <code>to</code> метод добавляет адреса электронной почты к списку
    получателей почтового сообщения, каждая итерация цикла будет отправлять новое электронное письмо каждому предыдущему
    получателю. Следовательно, вы всегда должны повторно создавать почтовый экземпляр для каждого получателя:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">foreach</span> <span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'taylor@example.com'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'dries@example.com'</span><span
                class="token punctuation">]</span> <span class="token keyword">as</span> <span class="token variable">$recipient</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    Mail<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">to</span><span class="token punctuation">(</span><span class="token variable">$recipient</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">send</span><span
                class="token punctuation">(</span><span class="token keyword">new</span> <span class="token class-name">OrderShipped</span><span
                class="token punctuation">(</span><span class="token variable">$order</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="sending-mail-via-a-specific-mailer"><a href="#sending-mail-via-a-specific-mailer">Отправка почты через
        определенный почтовый ящик</a></h4>
<p>По умолчанию Laravel отправляет электронную почту, используя почтовую программу, настроенную как <code>default</code>
    почтовую программу в <code>mail</code> файле конфигурации вашего приложения. Однако вы можете использовать этот
    <code>mailer</code> метод для отправки сообщения с использованием определенной конфигурации почтовой программы:</p>
<pre class=" language-php"><code class=" language-php">Mail<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">mailer</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'postmark'</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">to</span><span class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">user</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">send</span><span class="token punctuation">(</span><span class="token keyword">new</span> <span
                class="token class-name">OrderShipped</span><span class="token punctuation">(</span><span
                class="token variable">$order</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="queueing-mail"><a href="#queueing-mail">Очередь почты <sup>Queueing mail</sup></a></h3>
<p></p>
<h4 id="queueing-a-mail-message"><a href="#queueing-a-mail-message">Постановка почтового сообщения в очередь</a></h4>
<p>Поскольку отправка сообщений электронной почты может негативно повлиять на время отклика вашего приложения, многие
    разработчики ставят сообщения электронной почты в очередь для фоновой отправки. Laravel упрощает это с помощью
    встроенного <a href="queues">API унифицированной очереди</a>. Чтобы поставить почтовое сообщение в очередь,
    используйте <code>queue</code> метод на <code>Mail</code> фасаде после указания получателей сообщения:</p>
<pre class=" language-php"><code class=" language-php">Mail<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">to</span><span class="token punctuation">(</span><span
                class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">user</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">cc</span><span class="token punctuation">(</span><span class="token variable">$moreUsers</span><span
                class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">bcc</span><span
                class="token punctuation">(</span><span class="token variable">$evenMoreUsers</span><span
                class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">queue</span><span class="token punctuation">(</span><span class="token keyword">new</span> <span
                class="token class-name">OrderShipped</span><span class="token punctuation">(</span><span
                class="token variable">$order</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Этот метод автоматически помещает задание в очередь, чтобы сообщение отправлялось в фоновом режиме. Перед
    использованием этой функции вам необходимо <a href="queues">настроить очереди</a>.</p>
<p></p>
<h4 id="delayed-message-queueing"><a href="#delayed-message-queueing">Очередь отложенных сообщений</a></h4>
<p>Если вы хотите отложить доставку электронного сообщения в очереди, вы можете использовать этот <code>later</code>
    метод. В качестве первого аргумента <code>later</code> метод принимает <code>DateTime</code> экземпляр, указывающий,
    когда следует отправить сообщение:</p>
<pre class=" language-php"><code class=" language-php">Mail<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">to</span><span class="token punctuation">(</span><span
                class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">user</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">cc</span><span class="token punctuation">(</span><span class="token variable">$moreUsers</span><span
                class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">bcc</span><span
                class="token punctuation">(</span><span class="token variable">$evenMoreUsers</span><span
                class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">later</span><span class="token punctuation">(</span><span class="token function">now</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">addMinutes</span><span
                class="token punctuation">(</span><span class="token number">10</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span> <span class="token keyword">new</span> <span
                class="token class-name">OrderShipped</span><span class="token punctuation">(</span><span
                class="token variable">$order</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="pushing-to-specific-queues"><a href="#pushing-to-specific-queues">Отправка в определенные очереди</a></h4>
<p>Так как все классы генерируются разрешенные к пересылке по почте, используя <code>make:mail</code> грим использовать
    команду из <code>Illuminate\Bus\Queueable</code> признака, вы можете вызвать <code>onQueue</code> и <code>onConnection</code>
    методу любого экземпляра класса разрешенного к пересылке по почте, что позволяешь указать соединение и имя очереди
    для сообщения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$message</span> <span
                class="token operator">=</span> <span class="token punctuation">(</span><span
                class="token keyword">new</span> <span class="token class-name">OrderShipped</span><span
                class="token punctuation">(</span><span class="token variable">$order</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">onConnection</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'sqs'</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">onQueue</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'emails'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

Mail<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">to</span><span class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">user</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">cc</span><span class="token punctuation">(</span><span class="token variable">$moreUsers</span><span
                class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">bcc</span><span
                class="token punctuation">(</span><span class="token variable">$evenMoreUsers</span><span
                class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">queue</span><span class="token punctuation">(</span><span class="token variable">$message</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="queueing-by-default"><a href="#queueing-by-default">Очередь по умолчанию</a></h4>
<p>Если у вас есть классы для рассылки, которые вы хотите всегда ставить в очередь, вы можете реализовать <code>ShouldQueue</code>
    контракт для класса. Теперь, даже если вы <code>send</code> вызовете метод при отправке по почте, почтовый ящик все
    равно будет стоять в очереди, поскольку он реализует контракт:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                    class="token punctuation">\</span>Queue<span
                    class="token punctuation">\</span>ShouldQueue</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">OrderShipped</span> <span class="token keyword">extends</span> <span
                class="token class-name">Mailable</span> <span class="token keyword">implements</span> <span
                class="token class-name">ShouldQueue</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="queued-mailables-and-database-transactions"><a href="#queued-mailables-and-database-transactions">Почтовые
        сообщения в очереди и транзакции в базе данных</a></h4>
<p>Когда помещенные в очередь почтовые сообщения отправляются в рамках транзакций базы данных, они могут быть обработаны
    очередью до того, как транзакция базы данных будет зафиксирована. Когда это происходит, любые обновления, внесенные
    вами в модели или записи базы данных во время транзакции базы данных, могут еще не быть отражены в базе данных.
    Кроме того, любые модели или записи базы данных, созданные в рамках транзакции, могут не существовать в базе данных.
    Если ваше почтовое сообщение зависит от этих моделей, при обработке задания, отправляющего почтовое сообщение в
    очереди, могут возникнуть непредвиденные ошибки.</p>
<p>Если <code>after_commit</code> для параметра конфигурации вашего подключения к очереди задано значение
    <code>false</code>, вы все равно можете указать, что конкретное почтовое сообщение в очереди должно быть отправлено
    после того, как все открытые транзакции базы данных были зафиксированы, путем определения <code>$afterCommit</code>
    свойства в классе mailable:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                    class="token punctuation">\</span>Queue<span
                    class="token punctuation">\</span>ShouldQueue</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">OrderShipped</span> <span class="token keyword">extends</span> <span
                class="token class-name">Mailable</span> <span class="token keyword">implements</span> <span
                class="token class-name">ShouldQueue</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">public</span> <span class="token variable">$afterCommit</span> <span
                class="token operator">=</span> <span class="token boolean constant">true</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Чтобы узнать больше об устранении этих проблем, ознакомьтесь с документацией, касающейся <a
                    href="queues#jobs-and-database-transactions">заданий в очереди и транзакций базы данных</a>.</p></p>
    </div>
</blockquote>
<p></p>
<h2 id="rendering-mailables"><a href="#rendering-mailables">Обработка почтовых сообщений <sup>Rendering mailables</sup></a></h2>
<p>Иногда вам может потребоваться захватить HTML-содержимое почтового сообщения, не отправляя его. Для этого вы можете
    вызвать <code>render</code> метод mailable. Этот метод вернет оцененное HTML-содержимое почтового сообщения в виде
    строки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Mail<span
                    class="token punctuation">\</span>InvoicePaid</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Models<span class="token punctuation">\</span>Invoice</span><span
                class="token punctuation">;</span>

<span class="token variable">$invoice</span> <span class="token operator">=</span> Invoice<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">return</span> <span class="token punctuation">(</span><span class="token keyword">new</span> <span
                class="token class-name">InvoicePaid</span><span class="token punctuation">(</span><span
                class="token variable">$invoice</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">render</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="previewing-mailables-in-the-browser"><a href="#previewing-mailables-in-the-browser">Предварительный просмотр
        почтовых сообщений в браузере <sup>Previewing mailables in the browser</sup></a></h3>
<p>При разработке шаблона почтового сообщения удобно быстро просмотреть визуализированное почтовое сообщение в браузере,
    как типичный шаблон Blade. По этой причине Laravel позволяет вам возвращать любое почтовое сообщение непосредственно
    из закрытия маршрута или контроллера. Когда почтовое сообщение возвращается, оно будет обработано и отображено в
    браузере, что позволит вам быстро просмотреть его дизайн без необходимости отправлять его на реальный адрес
    электронной почты:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'/mailable'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$invoice</span> <span class="token operator">=</span> App\<span
                class="token package">Models<span class="token punctuation">\</span>Invoice</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
            
    <span class="token keyword">return</span> <span class="token keyword">new</span> <span
                class="token class-name">App<span class="token punctuation">\</span>Mail<span class="token punctuation">\</span>InvoicePaid</span><span
                class="token punctuation">(</span><span class="token variable">$invoice</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p><a href="mail#inline-attachments">Встроенные вложения</a> не будут отображаться при предварительном просмотре
            почтового сообщения в вашем браузере. Чтобы просмотреть эти почтовые сообщения, вы должны отправить их в
            приложение для тестирования электронной почты, такое как <a href="https://github.com/mailhog/MailHog">MailHog</a>
            или <a href="https://usehelo.com">HELO</a>.</p></p></div>
</blockquote>
<p></p>
<h2 id="localizing-mailables"><a href="#localizing-mailables">Локализация почтовых отправлений <sup>Localizing mailables</sup></a></h2>
<p>Laravel позволяет вам отправлять почтовые сообщения в языковом стандарте, отличном от текущего языкового стандарта
    запроса, и даже будет помнить этот языковой стандарт, если почта находится в очереди.</p>
<p>Для этого <code>Mail</code> фасад предлагает <code>locale</code> метод установки желаемого языка. Приложение
    изменится на этот языковой стандарт при оценке шаблона почтового сообщения, а затем вернется к предыдущему языку,
    когда оценка будет завершена:</p>
<pre class=" language-php"><code class=" language-php">Mail<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">to</span><span class="token punctuation">(</span><span
                class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">user</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">locale</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'es'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">send</span><span
                class="token punctuation">(</span>
    <span class="token keyword">new</span> <span class="token class-name">OrderShipped</span><span
                class="token punctuation">(</span><span class="token variable">$order</span><span
                class="token punctuation">)</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="user-preferred-locales"><a href="#user-preferred-locales">Предпочитаемые пользователем регионы</a></h3>
<p>Иногда приложения хранят предпочтительный языковой стандарт каждого пользователя. Реализуя
    <code>HasLocalePreference</code> контракт на одной или нескольких ваших моделях, вы можете указать Laravel
    использовать этот сохраненный языковой стандарт при отправке почты:</p>
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
<p>После того, как вы внедрили интерфейс, Laravel будет автоматически использовать предпочтительный языковой стандарт
    при отправке почтовых сообщений и уведомлений в модель. Следовательно, <code>locale</code> при использовании этого
    интерфейса нет необходимости вызывать метод:</p>
<pre class=" language-php"><code class=" language-php">Mail<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">to</span><span class="token punctuation">(</span><span
                class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">user</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">send</span><span class="token punctuation">(</span><span class="token keyword">new</span> <span
                class="token class-name">OrderShipped</span><span class="token punctuation">(</span><span
                class="token variable">$order</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="testing-mailables"><a href="#testing-mailables">Проверка почтовых сообщений <sup>Testing Mailables</sup></a></h2>
<p>Laravel предоставляет несколько удобных методов для проверки того, что ваши почтовые сообщения содержат ожидаемый
    контент. Эти методы являются: <code>assertSeeInHtml</code>, <code>assertDontSeeInHtml</code>,
    <code>assertSeeInText</code>, и <code>assertDontSeeInText</code>.</p>
<p>Как и следовало ожидать, утверждения «HTML» утверждают, что HTML-версия вашего почтового сообщения содержит заданную
    строку, в то время как утверждения «текст» утверждают, что текстовая версия вашего почтового сообщения содержит
    данную строку:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Mail<span
                    class="token punctuation">\</span>InvoicePaid</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                class="token punctuation">;</span>

<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">test_mailable_content</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$user</span> <span class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

    <span class="token variable">$mailable</span> <span class="token operator">=</span> <span
                class="token keyword">new</span> <span class="token class-name">InvoicePaid</span><span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

    <span class="token variable">$mailable</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">assertSeeInHtml</span><span
                class="token punctuation">(</span><span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">email</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token variable">$mailable</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">assertSeeInHtml</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'Invoice Paid'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

    <span class="token variable">$mailable</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">assertSeeInText</span><span
                class="token punctuation">(</span><span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">email</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token variable">$mailable</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">assertSeeInText</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'Invoice Paid'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="testing-mailable-sending"><a href="#testing-mailable-sending">Проверка отправки по почте</a></h4>
<p>Мы предлагаем тестировать содержимое ваших почтовых сообщений отдельно от тестов, которые подтверждают, что данное
    почтовое сообщение было «отправлено» определенному пользователю. Чтобы узнать, как проверить, что почтовые
    отправления были отправлены, ознакомьтесь с нашей документацией по фейку <a href="mocking#mail-fake">Mail</a>.</p>
<p></p>
<h2 id="mail-and-local-development"><a href="#mail-and-local-development">Почта и локальная разработка <sup>Mail & Local Development</sup></a></h2>
<p>При разработке приложения, которое отправляет электронную почту, вы, вероятно, не захотите отправлять электронные
    письма на действующие адреса электронной почты. Laravel предоставляет несколько способов «отключить» фактическую
    отправку электронных писем во время локальной разработки.</p>
<p></p>
<h4 id="log-driver"><a href="#log-driver">Драйвер журнала</a></h4>
<p>Вместо того, чтобы отправлять ваши электронные письма, <code>log</code> почтовый драйвер будет записывать все
    сообщения электронной почты в ваши файлы журнала для проверки. Обычно этот драйвер используется только во время
    локальной разработки. Для получения дополнительных сведений о настройке приложения для каждой среды ознакомьтесь с
    <a href="configuration#environment-configuration">документацией</a> по <a
            href="configuration#environment-configuration">настройке</a>.</p>
<p></p>
<h4 id="mailtrap"><a href="#mailtrap">HELO / Mailtrap / MailHog</a></h4>
<p>Наконец, вы можете использовать такую ​​службу, как <a href="https://usehelo.com">HELO</a> или <a
            href="https://mailtrap.io">Mailtrap,</a> и <code>smtp</code> драйвер, чтобы отправлять свои сообщения
    электронной почты в «фиктивный» почтовый ящик, где вы можете просматривать их в настоящем почтовом клиенте. Этот
    подход имеет то преимущество, что позволяет вам фактически проверять окончательные электронные письма в средстве
    просмотра сообщений Mailtrap.</p>
<p>Если вы используете <a href="sail">Laravel Sail</a>, вы можете предварительно просмотреть свои сообщения с помощью <a
            href="https://github.com/mailhog/MailHog">MailHog</a>. Когда парус работает, вы можете получить доступ к
    интерфейсу MailHog по адресу: <code>http://localhost:8025</code>.</p>
<p></p>
<h2 id="events"><a href="#events">События <sup>Events</sup></a></h2>
<p>Laravel запускает два события в процессе отправки почтовых сообщений. <code>MessageSending</code> Событие вызывается
    перед сообщением отправляется, в то время как <code>MessageSent</code> событие вызывается после того, как сообщение
    было отправлено. Помните, что эти события запускаются, когда почта <em>отправляется</em>, а не когда она стоит в
    очереди. Вы можете зарегистрировать прослушиватели событий для этого события у своего <code>App\Providers\EventServiceProvider</code>
    поставщика услуг:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * The event listener mappings for the application.
 *
 * @var array
 */</span>
<span class="token keyword">protected</span> <span class="token variable">$listen</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'Illuminate\Mail\Events\MessageSending'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'App\Listeners\LogSendingMessage'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'Illuminate\Mail\Events\MessageSent'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'App\Listeners\LogSentMessage'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">;</span></code></pre> 
