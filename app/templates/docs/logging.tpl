<h1>Логирование</h1>
<ul>
    <li><a href="logging#introduction">Вступление</a></li>
    <li><a href="logging#configuration">Конфигурация</a>
        <ul>
            <li><a href="logging#available-channel-drivers">Доступные драйверы каналов</a></li>
            <li><a href="logging#channel-prerequisites">Требования к каналу</a></li>
        </ul>
    </li>
    <li><a href="logging#building-log-stacks">Строительство штабелей бревен</a></li>
    <li><a href="logging#writing-log-messages">Запись сообщений журнала</a>
        <ul>
            <li><a href="logging#writing-to-specific-channels">Запись в определенные каналы</a></li>
        </ul>
    </li>
    <li><a href="logging#monolog-channel-customization">Настройка канала Monolog</a>
        <ul>
            <li><a href="logging#customizing-monolog-for-channels">Настройка Monolog для каналов</a></li>
            <li><a href="logging#creating-monolog-handler-channels">Создание каналов обработчика Monolog</a></li>
            <li><a href="logging#creating-custom-channels-via-factories">Создание клиентских каналов через фабрики</a>
            </li>
        </ul>
    </li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Чтобы помочь вам узнать больше о том, что происходит в вашем приложении, Laravel предоставляет надежные службы
    ведения журнала, которые позволяют записывать сообщения в файлы, журнал системных ошибок и даже в Slack, чтобы
    уведомить всю вашу команду.</p>
<p>Ведение журнала Laravel основано на «каналах». Каждый канал представляет собой определенный способ записи информации
    журнала. Например, <code>single</code> канал записывает файлы журнала в один файл журнала, а <code>slack</code> канал
    отправляет сообщения журнала в Slack. Сообщения журнала могут быть записаны в несколько каналов в зависимости от их
    серьезности.</p>
<p>Под капотом Laravel использует библиотеку <a href="https://github.com/Seldaek/monolog">Monolog</a>, которая
    обеспечивает поддержку множества мощных обработчиков журналов. Laravel упрощает настройку этих обработчиков,
    позволяя вам смешивать и сопоставлять их для настройки обработки журналов вашего приложения.</p>
<p></p>
<h2 id="configuration"><a href="#configuration">Конфигурация</a></h2>
<p>Все параметры конфигурации для ведения журнала вашего приложения размещены в <code>config/logging.php</code> файле
    конфигурации. Этот файл позволяет вам настраивать каналы журнала вашего приложения, поэтому обязательно просмотрите
    каждый из доступных каналов и их параметры. Ниже мы рассмотрим несколько распространенных вариантов.</p>
<p>По умолчанию Laravel будет использовать этот <code>stack</code> канал при регистрации сообщений. <code>stack</code> Канал
    используется для агрегирования нескольких каналов журнала в один канал. Для получения дополнительной информации о
    создании стеков ознакомьтесь с <a href="logging#building-log-stacks">документацией ниже</a>.</p>
<p></p>
<h4 id="configuring-the-channel-name"><a href="#configuring-the-channel-name">Настройка имени канала</a></h4>
<p>По умолчанию Monolog создается с «именем канала», которое соответствует текущей среде, например,
    <code>production</code> или <code>local</code>. Чтобы изменить это значение, добавьте <code>name</code> параметр в
    конфигурацию вашего канала:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'stack'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'driver'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'stack'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'channel-name'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'channels'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'single'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'slack'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p></p>
<h3 id="available-channel-drivers"><a href="#available-channel-drivers">Доступные драйверы каналов</a></h3>
<p>Каждый канал журнала работает от «драйвера». Драйвер определяет, как и где фактически записывается сообщение журнала.
    Следующие драйверы канала журнала доступны в каждом приложении Laravel. Запись для большинства этих драйверов уже
    присутствует в <code>config/logging.php</code> файле конфигурации вашего приложения, поэтому обязательно просмотрите
    этот файл, чтобы ознакомиться с его содержимым:</p>
<table>
    <thead>
    <tr>
        <th>Имя</th>
        <th>Описание</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td><code>custom</code></td>
        <td>Драйвер, который вызывает указанную фабрику для создания канала</td>
    </tr>
    <tr>
        <td><code>daily</code></td>
        <td><code>RotatingFileHandler</code> Драйвер на основе Монолог, который вращается ежедневно</td>
    </tr>
    <tr>
        <td><code>errorlog</code></td>
        <td><code>ErrorLogHandler</code> Драйвер Монолог на основе</td>
    </tr>
    <tr>
        <td><code>monolog</code></td>
        <td>Заводской драйвер Monolog, который может использовать любой поддерживаемый обработчик Monolog</td>
    </tr>
    <tr>
        <td><code>null</code></td>
        <td>Драйвер, который отбрасывает все сообщения журнала</td>
    </tr>
    <tr>
        <td><code>papertrail</code></td>
        <td><code>SyslogUdpHandler</code> Драйвер Монолог на основе</td>
    </tr>
    <tr>
        <td><code>single</code></td>
        <td>Канал регистратора на основе одного файла или пути ( <code>StreamHandler</code> )</td>
    </tr>
    <tr>
        <td><code>slack</code></td>
        <td><code>SlackWebhookHandler</code> Драйвер Монолог на основе</td>
    </tr>
    <tr>
        <td><code>stack</code></td>
        <td>Обертка для облегчения создания «многоканальных» каналов</td>
    </tr>
    <tr>
        <td><code>syslog</code></td>
        <td><code>SyslogHandler</code> Драйвер Монолог на основе</td>
    </tr>
    </tbody>
</table>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Проверьте документацию по <a href="logging#monolog-channel-customization">расширенному каналу настройки</a>,
            чтобы узнать больше о <code>monolog</code> и <code>custom</code> водителях.</p></p></div>
</blockquote>
<p></p>
<h3 id="channel-prerequisites"><a href="#channel-prerequisites">Требования к каналу</a></h3>
<p></p>
<h4 id="configuring-the-single-and-daily-channels"><a href="#configuring-the-single-and-daily-channels">Настройка
        одиночного и дневного каналов</a></h4>
<p><code>single</code> И <code>daily</code> каналы имеют три дополнительных опций конфигурации: <code>bubble</code>,
    <code>permission</code> и <code>locking</code>.</p>
<table>
    <thead>
    <tr>
        <th>Имя</th>
        <th>Описание</th>
        <th>Дефолт</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td><code>bubble</code></td>
        <td>Указывает, должны ли сообщения переходить в другие каналы после обработки</td>
        <td><code>true</code></td>
    </tr>
    <tr>
        <td><code>locking</code></td>
        <td>Попытка заблокировать файл журнала перед записью в него</td>
        <td><code>false</code></td>
    </tr>
    <tr>
        <td><code>permission</code></td>
        <td>Разрешения файла журнала</td>
        <td><code>0644</code></td>
    </tr>
    </tbody>
</table>
<p></p>
<h4 id="configuring-the-papertrail-channel"><a href="#configuring-the-papertrail-channel">Настройка канала
        Papertrail</a></h4>
<p>Для <code>papertrail</code> канала требуются параметры конфигурации <code>host</code> и <code>port</code>. Вы можете
    получить эти значения в <a
            href="https://help.papertrailapp.com/kb/configuration/configuring-centralized-logging-from-php-apps/%23send-events-from-php-app">Papertrail</a>
   .</p>
<p></p>
<h4 id="configuring-the-slack-channel"><a href="#configuring-the-slack-channel">Настройка Slack Channel</a></h4>
<p>Для <code>slack</code> канала требуется <code>url</code> опция конфигурации. Этот URL-адрес должен соответствовать
    URL-адресу <a href="https://slack.com/apps/A0F7XDUAZ-incoming-webhooks">входящего веб-перехватчика,</a> который вы
    настроили для своей команды Slack.</p>
<p>По умолчанию Slack будет получать логи только на <code>critical</code> уровне и выше; однако вы можете настроить это в
    своем <code>config/logging.php</code> файле конфигурации, изменив <code>level</code> параметр конфигурации в массиве
    конфигурации вашего канала журнала Slack.</p>
<p></p>
<h2 id="building-log-stacks"><a href="#building-log-stacks">Строительство штабелей бревен</a></h2>
<p>Как упоминалось ранее, <code>stack</code> драйвер позволяет для удобства объединить несколько каналов в один канал
    журнала. Чтобы проиллюстрировать, как использовать стеки журналов, давайте взглянем на пример конфигурации, которую
    вы можете увидеть в производственном приложении:</p>
<pre class=" language-php"><code class=" language-php"><span class="token single-quoted-string string">'channels'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'stack'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'driver'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'stack'</span><span
                class="token punctuation">,</span>
        <span class="token single-quoted-string string">'channels'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'syslog'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'slack'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>

    <span class="token single-quoted-string string">'syslog'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'driver'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'syslog'</span><span
                class="token punctuation">,</span>
        <span class="token single-quoted-string string">'level'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'debug'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>

    <span class="token single-quoted-string string">'slack'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'driver'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'slack'</span><span
                class="token punctuation">,</span>
        <span class="token single-quoted-string string">'url'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'LOG_SLACK_WEBHOOK_URL'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'username'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Laravel Log'</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'emoji'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">':boom:'</span><span
                class="token punctuation">,</span>
        <span class="token single-quoted-string string">'level'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'critical'</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p>Давайте разберем эту конфигурацию. Во-первых, обратите внимание, что наш <code>stack</code> канал объединяет два
    других канала с помощью своей <code>channels</code> опции: <code>syslog</code> и <code>slack</code>. Таким образом,
    при регистрации сообщений оба этих канала будут иметь возможность регистрировать сообщение. Однако, как мы увидим
    ниже, то, действительно ли эти каналы регистрируют сообщение, может определяться серьезностью / «уровнем» сообщения.
</p>
<p></p>
<h4 id="log-levels"><a href="#log-levels">Уровни журнала</a></h4>
<p>Обратите внимание на <code>level</code> параметр конфигурации, присутствующий в конфигурациях каналов
    <code>syslog</code> и <code>slack</code> в приведенном выше примере. Эта опция определяет минимальный «уровень»
    сообщения, которое должно быть зарегистрировано каналом. Monolog, на котором работают службы ведения журналов
    Laravel, предлагает все уровни журналов, определенные в <a href="https://tools.ietf.org/html/rfc5424">спецификации
        RFC 5424</a>: <strong>emergency</strong>, <strong>alert</strong>, <strong>critical</strong>, <strong>error</strong>,
    <strong>warning</strong>, <strong>notice</strong>, <strong>info</strong>, и <strong>debug</strong>.</p>
<p>Итак, представьте, что мы регистрируем сообщение, используя <code>debug</code> метод:</p>
<pre class=" language-php"><code class=" language-php">Log<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">debug</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'An informational message.'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Учитывая нашу конфигурацию, <code>syslog</code> канал запишет сообщение в системный журнал; однако, поскольку
    сообщение об ошибке не <code>critical</code> указано выше или выше, оно не будет отправлено в Slack. Однако, если мы
    регистрируем <code>emergency</code> сообщение, оно будет отправлено как в системный журнал, так и в Slack, поскольку
    <code>emergency</code> уровень выше нашего минимального порогового значения для обоих каналов:</p>
<pre class=" language-php"><code class=" language-php">Log<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">emergency</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'The system is down!'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="writing-log-messages"><a href="#writing-log-messages">Запись сообщений журнала</a></h2>
<p>Вы можете записывать информацию в журналы с помощью <code>Log</code>  <a href="facades">фасада</a>. Как упоминалось
    ранее, средство ведения журнала обеспечивает восемь уровней ведения журнала, определенных в <a
            href="https://tools.ietf.org/html/rfc5424">спецификации RFC 5424</a>: <strong>emergency</strong>,
    <strong>alert</strong>, <strong>critical</strong>, <strong>error</strong>, <strong>warning</strong>,
    <strong>notice</strong>, <strong>info</strong> и <strong>debug</strong>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Log</span><span
                class="token punctuation">;</span>

Log<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">emergency</span><span
                class="token punctuation">(</span><span class="token variable">$message</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
Log<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">alert</span><span class="token punctuation">(</span><span class="token variable">$message</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
Log<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">critical</span><span class="token punctuation">(</span><span
                class="token variable">$message</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
Log<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">error</span><span class="token punctuation">(</span><span class="token variable">$message</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
Log<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">warning</span><span class="token punctuation">(</span><span
                class="token variable">$message</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
Log<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">notice</span><span class="token punctuation">(</span><span
                class="token variable">$message</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
Log<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">info</span><span class="token punctuation">(</span><span class="token variable">$message</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
Log<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">debug</span><span class="token punctuation">(</span><span class="token variable">$message</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете вызвать любой из этих методов, чтобы записать сообщение для соответствующего уровня. По умолчанию сообщение
    будет записано в канал журнала по умолчанию, как указано в файле <code>logging</code> конфигурации:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>Controller</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Log</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">UserController</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Show the profile for the given user.
    *
    * @param  int  $id
    * @return \Illuminate\Http\Response
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">show</span><span
                    class="token punctuation">(</span><span class="token variable">$id</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        Log<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">info</span><span class="token punctuation">(</span><span
                    class="token single-quoted-string string">'Showing the user profile for user: '</span><span
                    class="token punctuation">.</span><span class="token variable">$id</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token keyword">return</span> <span class="token function">view</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'user.profile'</span><span
                    class="token punctuation">,</span> <span class="token punctuation">[</span>
            <span class="token single-quoted-string string">'user'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> User<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token function">findOrFail</span><span
                    class="token punctuation">(</span><span class="token variable">$id</span><span
                    class="token punctuation">)</span>
        <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h4 id="contextual-information"><a href="#contextual-information">Контекстная информация</a></h4>
<p>Массив контекстных данных также может быть передан методам журнала. Эти контекстные данные будут отформатированы и
    отображены с сообщением журнала:</p>
<pre class=" language-php"><code class=" language-php">Log<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">info</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'User failed to login.'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span><span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="writing-to-specific-channels"><a href="#writing-to-specific-channels">Запись в определенные каналы</a></h3>
<p>Иногда вы можете захотеть записать сообщение в канал, отличный от канала по умолчанию вашего приложения. Вы можете
    использовать <code>channel</code> метод <code>Log</code> фасада для получения и регистрации любого канала,
    определенного в вашем файле конфигурации:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Log</span><span
                class="token punctuation">;</span>

Log<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">channel</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'slack'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">info</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Something happened!'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если вы хотите создать стек журналов по требованию, состоящий из нескольких каналов, вы можете использовать <code>stack</code> метод:
</p>
<pre class=" language-php"><code class=" language-php">Log<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">stack</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'single'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'slack'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">info</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'Something happened!'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="monolog-channel-customization"><a href="#monolog-channel-customization">Настройка канала Monolog</a></h2>
<p></p>
<h3 id="customizing-monolog-for-channels"><a href="#customizing-monolog-for-channels">Настройка Monolog для каналов</a>
</h3>
<p>Иногда вам может потребоваться полный контроль над настройкой Monolog для существующего канала. Например, вы можете
    настроить собственную <code>FormatterInterface</code> реализацию Monolog для встроенного <code>single</code> канала
    Laravel.</p>
<p>Для начала определите <code>tap</code> массив в конфигурации канала. <code>tap</code> Массив должен содержать список
    классов, которые должны иметь возможность настроить (или «кран» в) экземпляр Монолог после ее создания. Не
    существует обычного места для размещения этих классов, поэтому вы можете создать каталог в своем приложении, чтобы
    содержать эти классы:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'single'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'driver'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'single'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'tap'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>App\<span
                class="token package">Logging<span class="token punctuation">\</span>CustomizeFormatter</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'path'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">storage_path</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'logs/laravel.log'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'level'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'debug'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p>После того как вы настроили <code>tap</code> опцию на своем канале, вы готовы определить класс, который будет
    настраивать ваш экземпляр Monolog. Этому классу нужен только один метод:, <code>__invoke</code> который получает
    <code>Illuminate\Log\Logger</code> экземпляр. <code>Illuminate\Log\Logger</code> Экземпляр все предоставляет интерфейс
    вызовов методов базового экземпляра Monolog:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Logging</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Monolog<span class="token punctuation">\</span>Formatter<span
                        class="token punctuation">\</span>LineFormatter</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">CustomizeFormatter</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Customize the given logger instance.
    *
    * @param  \Illuminate\Log\Logger  $logger
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">__invoke</span><span
                    class="token punctuation">(</span><span class="token variable">$logger</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">foreach</span> <span class="token punctuation">(</span><span class="token variable">$logger</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">getHandlers</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span> <span
                    class="token keyword">as</span> <span class="token variable">$handler</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token variable">$handler</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">setFormatter</span><span
                    class="token punctuation">(</span><span class="token keyword">new</span> <span
                    class="token class-name">LineFormatter</span><span class="token punctuation">(</span>
                <span class="token single-quoted-string string">'[%datetime%] %channel%.%level_name%: %message% %context% %extra%'</span>
            <span class="token punctuation">)</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
        <span class="token punctuation">}</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Все ваши классы-ответчики разрешаются <a href="container">контейнером службы</a>, поэтому любые зависимости
            конструктора, которые им требуются, будут автоматически внедрены.</p></p></div>
</blockquote>
<p></p>
<h3 id="creating-monolog-handler-channels"><a href="#creating-monolog-handler-channels">Создание каналов обработчика
        Monolog</a></h3>
<p>В Monolog есть множество <a href="https://github.com/Seldaek/monolog/tree/master/src/Monolog/Handler">доступных
        обработчиков,</a> и Laravel не включает встроенный канал для каждого из них. В некоторых случаях вам может
    потребоваться создать собственный канал, который является просто экземпляром определенного обработчика Monolog, у
    которого нет соответствующего драйвера журнала Laravel. Эти каналы можно легко создать с помощью
    <code>monolog</code> драйвера.</p>
<p>При использовании <code>monolog</code> драйвера параметр <code>handler</code> конфигурации используется для указания
    того, какой обработчик будет создан. При желании любые параметры конструктора, необходимые обработчику, могут быть
    указаны с <code>with</code> помощью параметра конфигурации:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'logentries'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'driver'</span>  <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'monolog'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'handler'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> Monolog\<span class="token package">Handler<span
                    class="token punctuation">\</span>SyslogUdpHandler</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'with'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'host'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'my.logentries.internal.datahubhost.company.com'</span><span
                class="token punctuation">,</span>
        <span class="token single-quoted-string string">'port'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'10000'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p></p>
<h4 id="monolog-formatters"><a href="#monolog-formatters">Форматеры монологов</a></h4>
<p>При использовании <code>monolog</code> драйвера Monolog <code>LineFormatter</code> будет использоваться как средство
    форматирования по умолчанию. Однако вы можете настроить тип средства форматирования, передаваемого обработчику,
    используя параметры конфигурации <code>formatter</code> и <code>formatter_with</code> :</p>
<pre class=" language-php"><code class=" language-php"><span class="token single-quoted-string string">'browser'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'driver'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'monolog'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'handler'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> Monolog\<span class="token package">Handler<span
                    class="token punctuation">\</span>BrowserConsoleHandler</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'formatter'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> Monolog\<span class="token package">Formatter<span
                    class="token punctuation">\</span>HtmlFormatter</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'formatter_with'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'dateFormat'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Y-m-d'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p>Если вы используете обработчик Monolog, который может предоставлять свой собственный форматер, вы можете установить
    значение параметра <code>formatter</code> конфигурации следующим образом <code>default</code> :</p>
<pre class=" language-php"><code class=" language-php"><span class="token single-quoted-string string">'newrelic'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'driver'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'monolog'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'handler'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> Monolog\<span class="token package">Handler<span
                    class="token punctuation">\</span>NewRelicHandler</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'formatter'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'default'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p></p>
<h3 id="creating-custom-channels-via-factories"><a href="#creating-custom-channels-via-factories">Создание клиентских
        каналов через фабрики</a></h3>
<p>Если вы хотите определить полностью настраиваемый канал, в котором у вас есть полный контроль над созданием и
    конфигурацией Monolog, вы можете указать <code>custom</code> тип драйвера в своем <code>config/logging.php</code> файле
    конфигурации. Ваша конфигурация должна включать <code>via</code> параметр, содержащий имя фабричного класса, который
    будет вызываться для создания экземпляра Monolog:</p>
<pre class=" language-php"><code class=" language-php"><span class="token single-quoted-string string">'channels'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'example-custom-channel'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'driver'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'custom'</span><span
                class="token punctuation">,</span>
        <span class="token single-quoted-string string">'via'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> App\<span class="token package">Logging<span
                    class="token punctuation">\</span>CreateCustomLogger</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p>После того, как вы настроили <code>custom</code> канал драйвера, вы готовы определить класс, который будет создавать
    ваш экземпляр Monolog. Этому классу нужен только один <code>__invoke</code> метод, который должен возвращать
    экземпляр регистратора Monolog. Метод получит массив конфигурации каналов в качестве единственного аргумента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Logging</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Monolog<span class="token punctuation">\</span>Logger</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">CreateCustomLogger</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Create a custom Monolog instance.
    *
    * @param  array  $config
    * @return \Monolog\Logger
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">__invoke</span><span
                    class="token punctuation">(</span><span class="token keyword">array</span> <span
                    class="token variable">$config</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token keyword">new</span> <span class="token class-name">Logger</span><span
                    class="token punctuation">(</span><span class="token punctuation">.</span><span
                    class="token punctuation">.</span><span class="token punctuation">.</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
