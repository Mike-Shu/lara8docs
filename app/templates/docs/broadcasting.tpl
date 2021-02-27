<h1>Вещание (broadcasting)</h1>
<ul>
    <li><a href="broadcasting#introduction">Вступление</a></li>
    <li><a href="broadcasting#server-side-installation">Установка на стороне сервера</a>
        <ul>
            <li><a href="broadcasting#configuration">Конфигурация</a></li>
            <li><a href="broadcasting#pusher-channels">Каналы толкателя</a></li>
            <li><a href="broadcasting#ably">Умело</a></li>
            <li><a href="broadcasting#open-source-alternatives">Альтернативы с открытым исходным кодом</a></li>
        </ul>
    </li>
    <li><a href="broadcasting#client-side-installation">Установка на стороне клиента</a>
        <ul>
            <li><a href="broadcasting#client-pusher-channels">Каналы Pusher</a></li>
            <li><a href="broadcasting#client-ably">Ably</a></li>
        </ul>
    </li>
    <li><a href="broadcasting#concept-overview">Обзор концепции</a>
        <ul>
            <li><a href="broadcasting#using-example-application">Использование примера приложения</a></li>
        </ul>
    </li>
    <li><a href="broadcasting#defining-broadcast-events">Определение широковещательных событий</a>
        <ul>
            <li><a href="broadcasting#broadcast-name">Название трансляции</a></li>
            <li><a href="broadcasting#broadcast-data">Широковещательные данные</a></li>
            <li><a href="broadcasting#broadcast-queue">Очередь трансляции</a></li>
            <li><a href="broadcasting#broadcast-conditions">Условия трансляции</a></li>
            <li><a href="broadcasting#broadcasting-and-database-transactions">Трансляция и транзакции с базой данных</a>
            </li>
        </ul>
    </li>
    <li><a href="broadcasting#authorizing-channels">Авторизация каналов</a>
        <ul>
            <li><a href="broadcasting#defining-authorization-routes">Определение маршрутов авторизации</a></li>
            <li><a href="broadcasting#defining-authorization-callbacks">Определение обратных вызовов авторизации</a>
            </li>
            <li><a href="broadcasting#defining-channel-classes">Определение классов каналов</a></li>
        </ul>
    </li>
    <li><a href="broadcasting#broadcasting-events">Трансляция событий</a>
        <ul>
            <li><a href="broadcasting#only-to-others">Только другим</a></li>
        </ul>
    </li>
    <li><a href="broadcasting#receiving-broadcasts">Прием трансляций</a>
        <ul>
            <li><a href="broadcasting#listening-for-events">Прослушивание событий</a></li>
            <li><a href="broadcasting#leaving-a-channel">Покидая канал</a></li>
            <li><a href="broadcasting#namespaces">Пространства имён</a></li>
        </ul>
    </li>
    <li><a href="broadcasting#presence-channels">Каналы присутствия</a>
        <ul>
            <li><a href="broadcasting#authorizing-presence-channels">Авторизация каналов присутствия</a></li>
            <li><a href="broadcasting#joining-presence-channels">Присоединение к каналам присутствия</a></li>
            <li><a href="broadcasting#broadcasting-to-presence-channels">Вещание на каналы присутствия</a></li>
        </ul>
    </li>
    <li><a href="broadcasting#client-events">Клиентские события</a></li>
    <li><a href="broadcasting#notifications">Уведомления</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Во многих современных веб-приложениях WebSockets используются для реализации пользовательских интерфейсов,
    обновляемых в реальном времени. Когда некоторые данные обновляются на сервере, сообщение обычно отправляется через
    соединение WebSocket для обработки клиентом. WebSockets предоставляют более эффективную альтернативу постоянному
    опросу сервера вашего приложения на предмет изменений данных, которые должны быть отражены в вашем пользовательском
    интерфейсе.</p>
<p>Например, представьте, что ваше приложение может экспортировать данные пользователя в файл CSV и отправлять его им по
    электронной почте. Однако создание этого CSV-файла занимает несколько минут, поэтому вы можете создать и отправить
    CSV-файл по почте в рамках <a href="queues">задания</a> в <a href="queues">очереди</a>. Когда CSV-файл создан и
    отправлен пользователю, мы можем использовать широковещательную рассылку <code>App\Events\UserDataExported</code>
    событий для отправки события, полученного JavaScript нашего приложения. Как только событие получено, мы можем
    отобразить сообщение пользователю о том, что его CSV был отправлен ему по электронной почте, без необходимости
    обновлять страницу.</p>
<p>Чтобы помочь вам в создании таких функций, Laravel упрощает «трансляцию» серверных <a href="events">событий</a>
    Laravel через соединение WebSocket. Трансляция ваших событий Laravel позволяет вам использовать одни и те же имена
    событий и данные между серверным приложением Laravel и клиентским приложением JavaScript.</p>
<p></p>
<h4 id="supported-drivers"><a href="#supported-drivers">Поддерживаемые драйверы</a></h4>
<p>По умолчанию Laravel включает в себя два драйвера вещания на стороне сервера, из которых вы можете выбирать: <a
            href="https://pusher.com/channels">Pusher Channels</a> и <a href="https://ably.io">Ably</a>. Однако пакеты,
    управляемые сообществом, такие как <a
            href="https://beyondco.de/docs/laravel-websockets/getting-started/introduction">laravel-websockets,</a>
    предоставляют дополнительные драйверы вещания, которые не требуют наличия коммерческих поставщиков вещания.</p>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Прежде чем погрузиться в трансляцию событий, убедитесь, что вы прочитали документацию Laravel по <a
                    href="events">событиям и слушателям</a>.</p></p></div>
</blockquote>
<p></p>
<h2 id="server-side-installation"><a href="#server-side-installation">Установка на стороне сервера</a></h2>
<p>Чтобы начать использовать трансляцию событий Laravel, нам нужно выполнить некоторую настройку в приложении Laravel, а
    также установить несколько пакетов.</p>
<p>Трансляция событий выполняется серверным драйвером вещания, который транслирует ваши события Laravel, чтобы Laravel
    Echo (библиотека JavaScript) мог получать их в клиенте браузера. Не волнуйтесь - мы рассмотрим каждую часть процесса
    установки шаг за шагом.</p>
<p></p>
<h3 id="configuration"><a href="#configuration">Конфигурация</a></h3>
<p>Вся конфигурация трансляции событий вашего приложения хранится в <code>config/broadcasting.php</code> файле
    конфигурации. Laravel "из коробки" поддерживает несколько драйверов вещания: <a href="https://pusher.com/channels">Pusher
        Channels</a>, <a href="redis">Redis</a> и <code>log</code> драйвер для локальной разработки и отладки. Кроме
    того, в <code>null</code> комплект входит драйвер, который позволяет полностью отключить трансляцию во время
    тестирования. Пример конфигурации включен для каждого из этих драйверов в <code>config/broadcasting.php</code> файл
    конфигурации.</p>
<p></p>
<h4 id="broadcast-service-provider"><a href="#broadcast-service-provider">Поставщик вещательных услуг</a></h4>
<p>Перед трансляцией каких-либо событий вам необходимо сначала зарегистрировать домен <code>App\Providers\BroadcastServiceProvider</code>
    . В новых приложениях Laravel вам нужно только раскомментировать этого провайдера в <code>providers</code> массиве
    вашего <code>config/app.php</code> файла конфигурации. Он <code>BroadcastServiceProvider</code> содержит код,
    необходимый для регистрации маршрутов авторизации широковещательной передачи и обратных вызовов.</p>
<p></p>
<h4 id="queue-configuration"><a href="#queue-configuration">Конфигурация очереди</a></h4>
<p>Вам также потребуется настроить и запустить <a href="queues">обработчик очереди</a>. Все трансляции событий
    выполняются с помощью заданий в очереди, так что время отклика вашего приложения не сильно зависит от транслируемых
    событий.</p>
<p></p>
<h3 id="pusher-channels"><a href="#pusher-channels">Pusher Channels</a></h3>
<p>Если вы планируете транслировать свои события с помощью <a href="https://pusher.com/channels">Pusher Channels</a>,
    вам следует установить PHP SDK Pusher Channels с помощью диспетчера пакетов Composer:</p>
<pre class=" language-php"><code class=" language-php">composer <span class="token keyword">require</span> pusher<span
                class="token operator">/</span>pusher<span class="token operator">-</span>php<span
                class="token operator">-</span>server <span
                class="token double-quoted-string string">"~4.0"</span></code></pre>
<p>Затем вы должны настроить свои учетные данные Pusher Channels в <code>config/broadcasting.php</code> файле
    конфигурации. Пример конфигурации Pusher Channels уже включен в этот файл, что позволяет быстро указать ключ, секрет
    и идентификатор приложения. Как правило, эти значения должны быть установлены с помощью <code>PUSHER_APP_KEY</code>
    , <code>PUSHER_APP_SECRET</code> и <code>PUSHER_APP_ID</code> <a href="configuration#environment-configuration">переменных
        окружения</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token constant">PUSHER_APP_ID</span><span
                class="token operator">=</span>your<span class="token operator">-</span>pusher<span
                class="token operator">-</span>app<span class="token operator">-</span>id
<span class="token constant">PUSHER_APP_KEY</span><span class="token operator">=</span>your<span class="token operator">-</span>pusher<span
                class="token operator">-</span>key
<span class="token constant">PUSHER_APP_SECRET</span><span class="token operator">=</span>your<span
                class="token operator">-</span>pusher<span class="token operator">-</span>secret
<span class="token constant">PUSHER_APP_CLUSTER</span><span class="token operator">=</span>mt1</code></pre>
<p>В <code>config/broadcasting.php</code> файла <code>pusher</code> конфигурации также позволяет указать дополнительные
    <code>options</code> , которые поддерживаются каналы, такие как кластер.</p>
<p>Затем вам нужно будет изменить драйвер трансляции <code>pusher</code> в вашем <code>.env</code> файле:</p>
<pre class=" language-php"><code class=" language-php"><span class="token constant">BROADCAST_DRIVER</span><span
                class="token operator">=</span>pusher</code></pre>
<p>Наконец, вы готовы установить и настроить <a href="broadcasting#client-side-installation">Laravel Echo</a>, который
    будет получать широковещательные события на стороне клиента.</p>
<p></p>
<h4 id="pusher-compatible-laravel-websockets"><a href="#pusher-compatible-laravel-websockets">Веб-сокеты Laravel,
        совместимые с Pusher</a></h4>
<p>Пакет <a href="https://github.com/beyondcode/laravel-websockets">laravel-websockets</a> - это чистый PHP,
    Pusher-совместимый пакет WebSocket для Laravel. Этот пакет позволяет вам использовать всю мощь вещания Laravel без
    использования коммерческого поставщика WebSocket. Для получения дополнительной информации об установке и
    использовании этого пакета обратитесь к его <a href="https://beyondco.de/docs/laravel-websockets">официальной
        документации</a>.</p>
<p></p>
<h3 id="ably"><a href="#ably">Ably</a></h3>
<p>Если вы планируете транслировать свои события с помощью <a href="https://ably.io">Ably</a>, вам следует установить
    Ably PHP SDK с помощью диспетчера пакетов Composer:</p>
<pre class=" language-php"><code class=" language-php">composer <span class="token keyword">require</span> ably<span
                class="token operator">/</span>ably<span class="token operator">-</span>php</code></pre>
<p>Затем вы должны настроить свои учетные данные Ably в <code>config/broadcasting.php</code> файле конфигурации. Пример
    конфигурации Ably уже включен в этот файл, что позволяет быстро указать ключ. Обычно это значение должно быть
    установлено через <code>ABLY_KEY</code> <a href="configuration#environment-configuration">переменную окружения</a>:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token constant">ABLY_KEY</span><span
                class="token operator">=</span>your<span class="token operator">-</span>ably<span
                class="token operator">-</span>key</code></pre>
<p>Затем вам нужно будет изменить драйвер трансляции <code>ably</code> в вашем <code>.env</code> файле:</p>
<pre class=" language-php"><code class=" language-php"><span class="token constant">BROADCAST_DRIVER</span><span
                class="token operator">=</span>ably</code></pre>
<p>Наконец, вы готовы установить и настроить <a href="broadcasting#client-side-installation">Laravel Echo</a>, который
    будет получать широковещательные события на стороне клиента.</p>
<p></p>
<h3 id="open-source-alternatives"><a href="#open-source-alternatives">Альтернативы с открытым исходным кодом</a></h3>
<p>Пакет <a href="https://github.com/beyondcode/laravel-websockets">laravel-websockets</a> - это чистый PHP,
    Pusher-совместимый пакет WebSocket для Laravel. Этот пакет позволяет вам использовать всю мощь вещания Laravel без
    использования коммерческого поставщика WebSocket. Для получения дополнительной информации об установке и
    использовании этого пакета обратитесь к его <a href="https://beyondco.de/docs/laravel-websockets">официальной
        документации</a>.</p>
<p></p>
<h2 id="client-side-installation"><a href="#client-side-installation">Установка на стороне клиента</a></h2>
<p></p>
<h3 id="client-pusher-channels"><a href="#client-pusher-channels">Pusher Channels</a></h3>
<p>Laravel Echo - это библиотека JavaScript, которая позволяет безболезненно подписаться на каналы и прослушивать
    события, транслируемые вашим драйвером вещания на стороне сервера. Вы можете установить Echo через менеджер пакетов
    NPM. В этом примере мы также установим <code>pusher-js</code> пакет, поскольку будем использовать вещатель Pusher
    Channels:</p>
<pre class=" language-bash"><code class=" language-bash"><span class="token function">npm</span> <span
                class="token function">install</span> --save-dev laravel-echo pusher-js</code></pre>
<p>После установки Echo вы готовы создать новый экземпляр Echo в JavaScript вашего приложения. Отличное место для этого
    - внизу <code>resources/js/bootstrap.js</code> файла, который включен в структуру Laravel. По умолчанию пример
    конфигурации Echo уже включен в этот файл - вам просто нужно раскомментировать его:</p>
<pre class=" language-js"><code class=" language-js"><span class="token keyword">import</span> Echo <span
                class="token keyword">from</span> <span class="token string">'laravel-echo'</span><span
                class="token punctuation">;</span>

window<span class="token punctuation">.</span>Pusher <span class="token operator">=</span> <span class="token function">require</span><span
                class="token punctuation">(</span><span class="token string">'pusher-js'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

window<span class="token punctuation">.</span>Echo <span class="token operator">=</span> <span
                class="token keyword">new</span> <span class="token class-name">Echo</span><span
                class="token punctuation">(</span><span class="token punctuation">{literal}{{/literal}</span>
    broadcaster<span class="token operator">:</span> <span class="token string">'pusher'</span><span
                class="token punctuation">,</span>
    key<span class="token operator">:</span> process<span class="token punctuation">.</span>env<span
                class="token punctuation">.</span><span class="token constant">MIX_PUSHER_APP_KEY</span><span
                class="token punctuation">,</span>
    cluster<span class="token operator">:</span> process<span class="token punctuation">.</span>env<span
                class="token punctuation">.</span><span class="token constant">MIX_PUSHER_APP_CLUSTER</span><span
                class="token punctuation">,</span>
    forceTLS<span class="token operator">:</span> <span class="token boolean">true</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>После того, как вы раскомментировали и настроили конфигурацию Echo в соответствии с вашими потребностями, вы можете
    скомпилировать активы вашего приложения:</p>
<pre class=" language-php"><code class=" language-php">npm run dev</code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Чтобы узнать больше о компиляции ресурсов JavaScript вашего приложения, обратитесь к документации по <a
                    href="mix">Laravel Mix</a>.</p></p></div>
</blockquote>
<p></p>
<h4 id="using-an-existing-client-instance"><a href="#using-an-existing-client-instance">Использование существующего
        экземпляра клиента</a></h4>
<p>Если у вас уже есть предварительно настроенный экземпляр клиента Pusher Channels, который вы хотели бы использовать в
    Echo, вы можете передать его Echo с помощью параметра <code>client</code> конфигурации:</p>
<pre class=" language-js"><code class=" language-js"><span class="token keyword">import</span> Echo <span
                class="token keyword">from</span> <span class="token string">'laravel-echo'</span><span
                class="token punctuation">;</span>

<span class="token keyword">const</span> client <span class="token operator">=</span> <span class="token function">require</span><span
                class="token punctuation">(</span><span class="token string">'pusher-js'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

window<span class="token punctuation">.</span>Echo <span class="token operator">=</span> <span
                class="token keyword">new</span> <span class="token class-name">Echo</span><span
                class="token punctuation">(</span><span class="token punctuation">{literal}{{/literal}</span>
    broadcaster<span class="token operator">:</span> <span class="token string">'pusher'</span><span
                class="token punctuation">,</span>
    key<span class="token operator">:</span> <span class="token string">'your-pusher-channels-key'</span><span
                class="token punctuation">,</span>
    client<span class="token operator">:</span> client
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="client-ably"><a href="#client-ably">Ably</a></h3>
<p>Laravel Echo - это библиотека JavaScript, которая позволяет безболезненно подписаться на каналы и прослушивать
    события, транслируемые вашим драйвером вещания на стороне сервера. Вы можете установить Echo через менеджер пакетов
    NPM. В этом примере мы также установим <code>pusher-js</code> пакет.</p>
<p>Вы можете задаться вопросом, зачем нам устанавливать <code>pusher-js</code> библиотеку JavaScript, даже если мы
    используем Ably для трансляции наших событий. К счастью, Ably включает режим совместимости Pusher, который позволяет
    нам использовать протокол Pusher при прослушивании событий в нашем клиентском приложении:</p>
<pre class=" language-bash"><code class=" language-bash"><span class="token function">npm</span> <span
                class="token function">install</span> --save-dev laravel-echo pusher-js</code></pre>
<p><strong>Прежде чем продолжить, вы должны включить поддержку протокола Pusher в настройках вашего приложения Ably. Вы
        можете включить эту функцию в разделе «Настройки адаптера протокола» на панели настроек вашего приложения
        Ably.</strong></p>
<p>После установки Echo вы готовы создать новый экземпляр Echo в JavaScript вашего приложения. Отличное место для этого
    - внизу <code>resources/js/bootstrap.js</code> файла, который включен в структуру Laravel. По умолчанию в этот файл
    уже включен пример конфигурации Echo; однако конфигурация по умолчанию в <code>bootstrap.js</code> файле
    предназначена для Pusher. Вы можете скопировать конфигурацию ниже, чтобы перенести вашу конфигурацию на Ably:</p>
<pre class=" language-js"><code class=" language-js"><span class="token keyword">import</span> Echo <span
                class="token keyword">from</span> <span class="token string">'laravel-echo'</span><span
                class="token punctuation">;</span>

window<span class="token punctuation">.</span>Pusher <span class="token operator">=</span> <span class="token function">require</span><span
                class="token punctuation">(</span><span class="token string">'pusher-js'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

window<span class="token punctuation">.</span>Echo <span class="token operator">=</span> <span
                class="token keyword">new</span> <span class="token class-name">Echo</span><span
                class="token punctuation">(</span><span class="token punctuation">{literal}{{/literal}</span>
    broadcaster<span class="token operator">:</span> <span class="token string">'pusher'</span><span
                class="token punctuation">,</span>
    key<span class="token operator">:</span> process<span class="token punctuation">.</span>env<span
                class="token punctuation">.</span><span class="token constant">MIX_ABLY_PUBLIC_KEY</span><span
                class="token punctuation">,</span>
    wsHost<span class="token operator">:</span> <span class="token string">'realtime-pusher.ably.io'</span><span
                class="token punctuation">,</span>
    wsPort<span class="token operator">:</span> <span class="token number">443</span><span
                class="token punctuation">,</span>
    disableStats<span class="token operator">:</span> <span class="token boolean">true</span><span
                class="token punctuation">,</span>
    encrypted<span class="token operator">:</span> <span class="token boolean">true</span><span
                class="token punctuation">,</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Обратите внимание, что наша конфигурация Ably Echo ссылается на <code>MIX_ABLY_PUBLIC_KEY</code> переменную среды.
    Значение этой переменной должно быть вашим открытым ключом Ably. Ваш открытый ключ - это часть ключа умений, которая
    стоит перед <code>:</code> персонажем.</p>
<p>После того, как вы раскомментировали и настроили конфигурацию Echo в соответствии с вашими потребностями, вы можете
    скомпилировать активы вашего приложения:</p>
<pre class=" language-php"><code class=" language-php">npm run dev</code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Чтобы узнать больше о компиляции ресурсов JavaScript вашего приложения, обратитесь к документации по <a
                    href="mix">Laravel Mix</a>.</p></p></div>
</blockquote>
<p></p>
<h2 id="concept-overview"><a href="#concept-overview">Обзор концепции</a></h2>
<p>Трансляция событий Laravel позволяет транслировать события Laravel на стороне сервера в приложение JavaScript на
    стороне клиента, используя подход к WebSockets на основе драйверов. В настоящее время Laravel поставляется с <a
            href="https://pusher.com/channels">Pusher Channels</a> и <a href="https://ably.io">Ably-</a> драйверами.
    События могут быть легко обработаны на стороне клиента с помощью пакета <a
            href="broadcasting#client-side-installation">Laravel Echo</a> JavaScript.</p>
<p>События транслируются по «каналам», которые могут быть общедоступными или частными. Любой посетитель вашего
    приложения может подписаться на общедоступный канал без какой-либо аутентификации или авторизации; однако, чтобы
    подписаться на частный канал, пользователь должен быть аутентифицирован и авторизован для прослушивания на этом
    канале.</p>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Если вы хотите использовать PHP-альтернативу Pusher с открытым исходным кодом, ознакомьтесь с <a
                    href="https://github.com/beyondcode/laravel-websockets">пакетом laravel-websockets</a>.</p></p>
    </div>
</blockquote>
<p></p>
<h3 id="using-example-application"><a href="#using-example-application">Использование примера приложения</a></h3>
<p>Прежде чем углубляться в каждый компонент трансляции событий, давайте сделаем общий обзор на примере магазина
    электронной коммерции.</p>
<p>В нашем приложении предположим, что у нас есть страница, которая позволяет пользователям просматривать статус
    доставки своих заказов. Предположим также, что <code>OrderShipmentStatusUpdated</code> событие запускается, когда
    приложение обрабатывает обновление статуса доставки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Events<span
                    class="token punctuation">\</span>OrderShipmentStatusUpdated</span><span
                class="token punctuation">;</span>

OrderShipmentStatusUpdated<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">dispatch</span><span class="token punctuation">(</span><span
                class="token variable">$order</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="the-shouldbroadcast-interface"><a href="#the-shouldbroadcast-interface"><code>ShouldBroadcast</code>
        Интерфейс</a></h4>
<p>Когда пользователь просматривает один из своих заказов, мы не хотим, чтобы ему приходилось обновлять страницу для
    просмотра обновлений статуса. Вместо этого мы хотим транслировать обновления в приложение по мере их создания. Итак,
    нам нужно отметить <code>OrderShipmentStatusUpdated</code> событие <code>ShouldBroadcast</code> интерфейсом. Это
    проинструктирует Laravel транслировать событие при его запуске:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Events</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Order</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Broadcasting<span
                        class="token punctuation">\</span>Channel</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Broadcasting<span
                        class="token punctuation">\</span>InteractsWithSockets</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Broadcasting<span
                        class="token punctuation">\</span>PresenceChannel</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Broadcasting<span
                        class="token punctuation">\</span>PrivateChannel</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Broadcasting<span class="token punctuation">\</span>ShouldBroadcast</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>SerializesModels</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">OrderShipmentStatusUpdated</span> <span
                    class="token keyword">implements</span> <span class="token class-name">ShouldBroadcast</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * The order instance.
    *
    * @var \App\Order
    */</span>
    <span class="token keyword">public</span> <span class="token variable">$order</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
<p><code>ShouldBroadcast</code> Интерфейс требует нашего мероприятия, чтобы определить <code>broadcastOn</code> метод.
    Этот метод отвечает за возврат каналов, по которым должно транслироваться событие. Пустая заглушка этого метода уже
    определена в сгенерированных классах событий, поэтому нам нужно только заполнить ее детали. Нам нужно только, чтобы
    создатель заказа мог просматривать обновления статуса, поэтому мы будем транслировать событие на частном канале,
    привязанном к заказу:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the channels the event should broadcast on.
 *
 * @return \Illuminate\Broadcasting\PrivateChannel
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">broadcastOn</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token keyword">new</span> <span class="token class-name">PrivateChannel</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'orders.'</span><span
                class="token punctuation">.</span><span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">order</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">id</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="example-application-authorizing-channels"><a href="#example-application-authorizing-channels">Авторизация
        каналов</a></h4>
<p>Помните, что пользователи должны иметь разрешение на прослушивание частных каналов. Мы можем определить наши правила
    авторизации канала в <code>routes/channels.php</code> файле нашего приложения. В этом примере нам нужно убедиться,
    что любой пользователь, пытающийся прослушивать частный <code>order.1</code> канал, на самом деле является
    создателем заказа:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Order</span><span class="token punctuation">;</span>

Broadcast<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">channel</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'orders.{literal}{orderId}{/literal}'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">,</span> <span class="token variable">$orderId</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span> <span class="token operator">===</span> Order<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">findOrNew</span><span
                class="token punctuation">(</span><span class="token variable">$orderId</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">user_id</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p><code>channel</code> Метод принимает два аргумента: имя канала и обратный вызов, который возвращает <code>true</code>
    или <code>false</code> указывающий авторизован ли пользователь слушать на канале.</p>
<p>Все обратные вызовы авторизации получают текущего аутентифицированного пользователя в качестве своего первого
    аргумента и любые дополнительные параметры подстановки в качестве своих последующих аргументов. В этом примере мы
    используем <code>{literal}{orderId}{/literal}</code> заполнитель, чтобы указать, что часть «ID» имени канала является подстановочным
    знаком.</p>
<p></p>
<h4 id="listening-for-event-broadcasts"><a href="#listening-for-event-broadcasts">Прослушивание трансляций событий</a>
</h4>
<p>Далее все, что остается, - это прослушивать событие в нашем приложении JavaScript. Мы можем сделать это с помощью
    Laravel Echo. Во-первых, мы воспользуемся этим <code>private</code> методом для подписки на частный канал. Затем мы
    можем использовать этот <code>listen</code> метод для прослушивания <code>OrderShipmentStatusUpdated</code> события.
    По умолчанию все общедоступные свойства события будут включены в событие трансляции:</p>
<pre class=" language-js"><code class=" language-js">Echo<span class="token punctuation">.</span><span
                class="token function">private</span><span class="token punctuation">(</span><span
                class="token template-string"><span class="token template-punctuation string">`</span><span
                    class="token string">orders.</span><span class="token interpolation"><span
                        class="token interpolation-punctuation punctuation">{literal}${{/literal}</span>orderId<span class="token interpolation-punctuation punctuation">}</span></span><span
                    class="token template-punctuation string">`</span></span><span class="token punctuation">)</span>
    <span class="token punctuation">.</span><span class="token function">listen</span><span
                class="token punctuation">(</span><span class="token string">'OrderShipmentStatusUpdated'</span><span
                class="token punctuation">,</span> <span class="token punctuation">(</span><span
                class="token parameter">e</span><span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span
                class="token punctuation">{literal}{{/literal}</span>
        console<span class="token punctuation">.</span><span class="token function">log</span><span
                class="token punctuation">(</span>e<span class="token punctuation">.</span>order<span
                class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="defining-broadcast-events"><a href="#defining-broadcast-events">Определение широковещательных событий</a></h2>
<p>Чтобы сообщить Laravel о том, что данное событие должно транслироваться, вы должны реализовать <code>Illuminate\Contracts\Broadcasting\ShouldBroadcast</code>
    интерфейс в классе событий. Этот интерфейс уже импортирован во все классы событий, сгенерированные фреймворком,
    поэтому вы можете легко добавить его к любому из ваших событий.</p>
<p><code>ShouldBroadcast</code> Интерфейс требует, чтобы реализовать один метод: <code>broadcastOn</code> . <code>broadcastOn</code>
    Метод должен возвращать канал или массив каналов, что событие должно транслироваться на. Каналы должны быть
    экземплярами <code>Channel</code> , <code>PrivateChannel</code> , или <code>PresenceChannel</code> . Экземпляры
    <code>Channel</code> представляют собой общедоступные каналы, на которые может подписаться любой пользователь,
    <code>PrivateChannels</code> а также <code>PresenceChannels</code> представляют собой частные каналы, требующие <a
            href="broadcasting#authorizing-channels">авторизации канала</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Events</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Broadcasting<span
                        class="token punctuation">\</span>Channel</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Broadcasting<span
                        class="token punctuation">\</span>InteractsWithSockets</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Broadcasting<span
                        class="token punctuation">\</span>PresenceChannel</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Broadcasting<span
                        class="token punctuation">\</span>PrivateChannel</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Broadcasting<span class="token punctuation">\</span>ShouldBroadcast</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>SerializesModels</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ServerCreated</span> <span
                    class="token keyword">implements</span> <span class="token class-name">ShouldBroadcast</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">use</span> <span class="token package">SerializesModels</span><span
                    class="token punctuation">;</span>

    <span class="token comment">/**
    * The user that created the server.
    *
    * @var \App\Models\User
    */</span>
    <span class="token keyword">public</span> <span class="token variable">$user</span><span
                    class="token punctuation">;</span>

    <span class="token comment">/**
    * Create a new event instance.
    *
    * @param  \App\Models\User  $user
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">__construct</span><span
                    class="token punctuation">(</span>User <span class="token variable">$user</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token property">user</span> <span
                    class="token operator">=</span> <span class="token variable">$user</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
    * Get the channels the event should broadcast on.
    *
    * @return Channel|array
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">broadcastOn</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token keyword">new</span> <span class="token class-name">PrivateChannel</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'user.'</span><span
                    class="token punctuation">.</span><span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">user</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">id</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>После реализации <code>ShouldBroadcast</code> интерфейса вам нужно только <a href="events">запустить событие,</a> как
    обычно. После запуска события <a href="queues">задание</a> в <a href="queues">очереди</a> будет автоматически
    транслировать событие, используя указанный вами драйвер вещания.</p>
<p></p>
<h3 id="broadcast-name"><a href="#broadcast-name">Название трансляции</a></h3>
<p>По умолчанию Laravel будет транслировать событие, используя имя класса события. Однако вы можете настроить имя
    трансляции, определив <code>broadcastAs</code> метод для события:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * The event's broadcast name.
 *
 * @return string
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">broadcastAs</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span
                class="token single-quoted-string string">'server.created'</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Если вы настраиваете имя трансляции с помощью этого <code>broadcastAs</code> метода, вы должны убедиться, что
    зарегистрировали слушателя с ведущим <code>.</code> символом. Это проинструктирует Echo не добавлять пространство
    имен приложения к событию:</p>
<pre class=" language-php"><code class=" language-php"><span class="token punctuation">.</span><span
                class="token function">listen</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'.server.created'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>e<span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token punctuation">.</span><span class="token punctuation">.</span><span
                class="token punctuation">.</span><span class="token punctuation">.</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="broadcast-data"><a href="#broadcast-data">Широковещательные данные</a></h3>
<p>Когда событие транслируется, все его <code>public</code> свойства автоматически сериализуются и транслируются как
    полезная нагрузка события, позволяя вам получить доступ к любым его общедоступным данным из вашего приложения
    JavaScript. Так, например, если ваше событие имеет одно общедоступное <code>$user</code> свойство, содержащее модель
    Eloquent, полезная нагрузка трансляции события будет:</p>
<pre class=" language-php"><code class=" language-php"><span class="token punctuation">{literal}{{/literal}</span>
    <span class="token double-quoted-string string">"user"</span><span class="token punctuation">:</span> <span
                class="token punctuation">{literal}{{/literal}</span>
        <span class="token double-quoted-string string">"id"</span><span class="token punctuation">:</span> <span
                class="token number">1</span><span class="token punctuation">,</span>
        <span class="token double-quoted-string string">"name"</span><span class="token punctuation">:</span> <span
                class="token double-quoted-string string">"Patrick Stewart"</span>
        <span class="token punctuation">.</span><span class="token punctuation">.</span><span
                class="token punctuation">.</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></code></pre>
<p>Однако, если вы хотите иметь более точный контроль над полезной нагрузкой широковещательной передачи, вы можете
    добавить <code>broadcastWith</code> метод к своему событию. Этот метод должен возвращать массив данных, которые вы
    хотите транслировать в качестве полезной нагрузки события:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the data to broadcast.
 *
 * @return array
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">broadcastWith</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">id</span><span class="token punctuation">]</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="broadcast-queue"><a href="#broadcast-queue">Очередь трансляции</a></h3>
<p>По умолчанию каждое широковещательное событие помещается в очередь по умолчанию для соединения очереди по умолчанию,
    указанного в вашем <code>queue.php</code> файле конфигурации. Вы можете настроить подключение и имя очереди,
    используемое вещательный путем определения <code>connection</code> и <code>queue</code> свойствами на классе
    событий:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * The name of the queue connection to use when broadcasting the event.
 *
 * @var string
 */</span>
<span class="token keyword">public</span> <span class="token variable">$connection</span> <span
                class="token operator">=</span> <span class="token single-quoted-string string">'redis'</span><span
                class="token punctuation">;</span>

<span class="token comment">/**
 * The name of the queue on which to place the broadcasting job.
 *
 * @var string
 */</span>
<span class="token keyword">public</span> <span class="token variable">$queue</span> <span
                class="token operator">=</span> <span class="token single-quoted-string string">'default'</span><span
                class="token punctuation">;</span></code></pre>
<p>Если вы хотите транслировать свое событие с использованием <code>sync</code> очереди вместо драйвера очереди по
    умолчанию, вы можете реализовать <code>ShouldBroadcastNow</code> интерфейс вместо <code>ShouldBroadcast</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Broadcasting<span class="token punctuation">\</span>ShouldBroadcastNow</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">OrderShipmentStatusUpdated</span> <span
                    class="token keyword">implements</span> <span class="token class-name">ShouldBroadcastNow</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h3 id="broadcast-conditions"><a href="#broadcast-conditions">Условия трансляции</a></h3>
<p>Иногда вы хотите транслировать свое мероприятие только в том случае, если выполняется определенное условие. Вы можете
    определить эти условия, добавив <code>broadcastWhen</code> метод в свой класс события:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Determine if this event should broadcast.
 *
 * @return bool
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">broadcastWhen</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">order</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">value</span> <span
                class="token operator">&gt;</span> <span class="token number">100</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="broadcasting-and-database-transactions"><a href="#broadcasting-and-database-transactions">Трансляция и
        транзакции с базой данных</a></h4>
<p>Когда широковещательные события отправляются в транзакциях базы данных, они могут быть обработаны очередью до того,
    как транзакция базы данных будет зафиксирована. Когда это происходит, любые обновления, внесенные вами в модели или
    записи базы данных во время транзакции базы данных, могут еще не быть отражены в базе данных. Кроме того, любые
    модели или записи базы данных, созданные в рамках транзакции, могут не существовать в базе данных. Если ваше событие
    зависит от этих моделей, при обработке задания, транслирующего событие, могут возникнуть непредвиденные ошибки.</p>
<p>Если <code>after_commit</code> для параметра конфигурации подключения к очереди задано значение <code>false</code> ,
    вы все равно можете указать, что конкретное широковещательное событие должно быть отправлено после того, как все
    транзакции открытой базы данных были зафиксированы, путем определения <code>$afterCommit</code> свойства в классе
    событий:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Events</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Broadcasting<span class="token punctuation">\</span>ShouldBroadcast</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>SerializesModels</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ServerCreated</span> <span
                    class="token keyword">implements</span> <span class="token class-name">ShouldBroadcast</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">use</span> <span class="token package">SerializesModels</span><span
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
<h2 id="authorizing-channels"><a href="#authorizing-channels">Авторизация каналов</a></h2>
<p>Частные каналы требуют, чтобы вы авторизовали, чтобы текущий аутентифицированный пользователь действительно мог
    прослушивать канал. Это достигается путем отправки HTTP-запроса вашему приложению Laravel с именем канала и
    разрешения вашему приложению определять, может ли пользователь прослушивать этот канал. При использовании <a
            href="broadcasting#client-side-installation">Laravel Echo</a> HTTP-запрос на авторизацию подписок на частные
    каналы будет выполнен автоматически; однако вам необходимо определить правильные маршруты для ответа на эти запросы.
</p>
<p></p>
<h3 id="defining-authorization-routes"><a href="#defining-authorization-routes">Определение маршрутов авторизации</a>
</h3>
<p>К счастью, Laravel упрощает определение маршрутов для ответа на запросы авторизации канала. В <code>App\Providers\BroadcastServiceProvider</code>
    прилагаемом к вашему Laravel приложении вы увидите вызов <code>Broadcast::routes</code> метода. Этот метод
    зарегистрирует <code>/broadcasting/auth</code> маршрут для обработки запросов авторизации:</p>
<pre class=" language-php"><code class=" language-php">Broadcast<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">routes</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p><code>Broadcast::routes</code> Метод будет автоматически помещать свои маршруты в <code>web</code> промежуточной
    программном обеспечении группы; однако вы можете передать в метод массив атрибутов маршрута, если хотите настроить
    назначенные атрибуты:</p>
<pre class=" language-php"><code class=" language-php">Broadcast<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">routes</span><span
                class="token punctuation">(</span><span class="token variable">$attributes</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="customizing-the-authorization-endpoint"><a href="#customizing-the-authorization-endpoint">Настройка конечной
        точки авторизации</a></h4>
<p>По умолчанию Echo будет использовать <code>/broadcasting/auth</code> конечную точку для авторизации доступа к каналу.
    Однако вы можете указать собственную конечную точку авторизации, передав параметр <code>authEndpoint</code>
    конфигурации вашему экземпляру Echo:</p>
<pre class=" language-php"><code class=" language-php">window<span class="token punctuation">.</span><span
                class="token keyword">Echo</span> <span class="token operator">=</span> <span
                class="token keyword">new</span> <span class="token class-name">Echo</span><span
                class="token punctuation">(</span><span class="token punctuation">{literal}{{/literal}</span>
    broadcaster<span class="token punctuation">:</span> <span
                class="token single-quoted-string string">'pusher'</span><span class="token punctuation">,</span>
    <span class="token comment">//...</span>
    authEndpoint<span class="token punctuation">:</span> <span class="token single-quoted-string string">'/custom/endpoint/auth'</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="defining-authorization-callbacks"><a href="#defining-authorization-callbacks">Определение обратных вызовов
        авторизации</a></h3>
<p>Затем нам нужно определить логику, которая фактически определит, может ли текущий аутентифицированный пользователь
    прослушивать данный канал. Это делается в <code>routes/channels.php</code> файле, который включен в ваше приложение.
    В этом файле вы можете использовать <code>Broadcast::channel</code> метод для регистрации обратных вызовов
    авторизации канала:</p>
<pre class=" language-php"><code class=" language-php">Broadcast<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">channel</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'orders.{literal}{orderId}{/literal}'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">,</span> <span class="token variable">$orderId</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span> <span class="token operator">===</span> Order<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">findOrNew</span><span
                class="token punctuation">(</span><span class="token variable">$orderId</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">user_id</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p><code>channel</code> Метод принимает два аргумента: имя канала и обратный вызов, который возвращает <code>true</code>
    или <code>false</code> указывающий авторизован ли пользователь слушать на канале.</p>
<p>Все обратные вызовы авторизации получают текущего аутентифицированного пользователя в качестве своего первого
    аргумента и любые дополнительные параметры подстановки в качестве своих последующих аргументов. В этом примере мы
    используем <code>{literal}{orderId}{/literal}</code> заполнитель, чтобы указать, что часть «ID» имени канала является подстановочным
    знаком.</p>
<p></p>
<h4 id="authorization-callback-model-binding"><a href="#authorization-callback-model-binding">Привязка модели обратного
        вызова авторизации</a></h4>
<p>Как и маршруты HTTP, маршруты каналов могут также использовать преимущества неявной и явной <a
            href="routing#route-model-binding">привязки модели маршрута</a>. Например, вместо получения строкового или
    числового идентификатора заказа вы можете запросить фактический <code>Order</code> экземпляр модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Order</span><span class="token punctuation">;</span>

Broadcast<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">channel</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'orders.{literal}{order}{/literal}'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">,</span> Order <span class="token variable">$order</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span> <span class="token operator">===</span> <span class="token variable">$order</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">user_id</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>В отличие от привязки модели маршрута HTTP, привязка модели канала не поддерживает автоматическое <a
                    href="routing#implicit-model-binding-scoping">неявное определение области привязки модели</a>.
            Однако это редко представляет собой проблему, потому что большинство каналов можно ограничить на основе
            уникального первичного ключа одной модели.</p></p></div>
</blockquote>
<p></p>
<h4 id="authorization-callback-authentication"><a href="#authorization-callback-authentication">Авторизация Callback
        Authentication</a></h4>
<p>Частные каналы и широковещательные каналы присутствия аутентифицируют текущего пользователя через стандартную защиту
    аутентификации вашего приложения. Если пользователь не аутентифицирован, авторизация канала автоматически
    отклоняется, и обратный вызов авторизации никогда не выполняется. Однако вы можете назначить несколько настраиваемых
    средств защиты, которые должны при необходимости аутентифицировать входящий запрос:</p>
<pre class=" language-php"><code class=" language-php">Broadcast<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">channel</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'channel'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//...</span>
<span class="token punctuation">}</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span><span class="token single-quoted-string string">'guards'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'web'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'admin'</span><span class="token punctuation">]</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="defining-channel-classes"><a href="#defining-channel-classes">Определение классов каналов</a></h3>
<p>Если ваше приложение использует много разных каналов, ваш <code>routes/channels.php</code> файл может стать
    громоздким. Таким образом, вместо использования замыканий для авторизации каналов вы можете использовать классы
    каналов. Чтобы создать класс канала, используйте команду <code>make:channel</code> Artisan. Эта команда поместит в
    <code>App/Broadcasting</code> каталог новый класс канала.</p>
<pre class=" language-php"><code class=" language-php">php artisan make<span class="token punctuation">:</span>channel OrderChannel</code></pre>
<p>Затем зарегистрируйте свой канал в своем <code>routes/channels.php</code> файле:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Broadcasting<span
                    class="token punctuation">\</span>OrderChannel</span><span class="token punctuation">;</span>

Broadcast<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">channel</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'orders.{literal}{order}{/literal}'</span><span
                class="token punctuation">,</span> OrderChannel<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Наконец, вы можете поместить логику авторизации для вашего канала в метод класса канала <code>join</code> . В этом
    <code>join</code> методе будет та же логика, которую вы обычно использовали при закрытии авторизации канала. Вы
    также можете воспользоваться преимуществами привязки модели канала:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Broadcasting</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span
                        class="token punctuation">\</span>Order</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">OrderChannel</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Create a new channel instance.
    *
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">__construct</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
    * Authenticate the user's access to the channel.
    *
    * @param  \App\Models\User  $user
    * @param  \App\Models\Order  $order
    * @return array|bool
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">join</span><span
                    class="token punctuation">(</span>User <span class="token variable">$user</span><span
                    class="token punctuation">,</span> Order <span class="token variable">$order</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$user</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token property">id</span> <span
                    class="token operator">===</span> <span class="token variable">$order</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">user_id</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Как и многие другие классы в Laravel, классы каналов автоматически разрешаются <a href="container">контейнером
                службы</a>. Итак, вы можете указать любые зависимости, необходимые для вашего канала, в его
            конструкторе.</p></p></div>
</blockquote>
<p></p>
<h2 id="broadcasting-events"><a href="#broadcasting-events">Трансляция событий</a></h2>
<p>После того как вы определили событие и отметили его <code>ShouldBroadcast</code> интерфейсом, вам нужно только
    запустить событие, используя метод отправки события. Диспетчер событий заметит, что событие помечено <code>ShouldBroadcast</code>
    интерфейсом, и поставит событие в очередь для трансляции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Events<span
                    class="token punctuation">\</span>OrderShipmentStatusUpdated</span><span
                class="token punctuation">;</span>

OrderShipmentStatusUpdated<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">dispatch</span><span class="token punctuation">(</span><span
                class="token variable">$order</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="only-to-others"><a href="#only-to-others">Только другим</a></h3>
<p>При создании приложения, использующего широковещательную рассылку событий, иногда может потребоваться
    широковещательная передача события всем подписчикам данного канала, кроме текущего пользователя. Вы можете сделать
    это с помощью <code>broadcast</code> помощника и <code>toOthers</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Events<span
                    class="token punctuation">\</span>OrderShipmentStatusUpdated</span><span
                class="token punctuation">;</span>

<span class="token function">broadcast</span><span class="token punctuation">(</span><span
                class="token keyword">new</span> <span class="token class-name">OrderShipmentStatusUpdated</span><span
                class="token punctuation">(</span><span class="token variable">$update</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">toOthers</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Чтобы лучше понять, когда вы можете захотеть использовать этот <code>toOthers</code> метод, давайте представим
    приложение со списком задач, в котором пользователь может создать новую задачу, введя имя задачи. Чтобы создать
    задачу, ваше приложение может сделать запрос к <code>/task</code> URL-адресу, который транслирует создание задачи и
    возвращает JSON-представление новой задачи. Когда ваше приложение JavaScript получает ответ от конечной точки, оно
    может напрямую вставить новую задачу в свой список задач следующим образом:</p>
<pre class=" language-php"><code class=" language-php">axios<span class="token punctuation">.</span><span
                class="token function">post</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/task'</span><span
                class="token punctuation">,</span> task<span class="token punctuation">)</span>
     <span class="token punctuation">.</span><span class="token function">then</span><span
                class="token punctuation">(</span><span class="token punctuation">(</span>response<span
                class="token punctuation">)</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token punctuation">{literal}{{/literal}</span>
        this<span class="token punctuation">.</span>tasks<span class="token punctuation">.</span><span
                class="token function">push</span><span class="token punctuation">(</span>response<span
                class="token punctuation">.</span>data<span class="token punctuation">)</span><span
                class="token punctuation">;</span>
     <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Однако помните, что мы также транслируем создание задачи. Если ваше приложение JavaScript также прослушивает это
    событие, чтобы добавить задачи в список задач, у вас будут дублирующиеся задачи в вашем списке: одна из конечной
    точки и одна из трансляции. Вы можете решить эту проблему, используя <code>toOthers</code> метод, чтобы указать
    вещательной компании не транслировать событие текущему пользователю.</p>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Ваше событие должно использовать <code>Illuminate\Broadcasting\InteractsWithSockets</code> трейт для вызова
            <code>toOthers</code> метода.</p></p></div>
</blockquote>
<p></p>
<h4 id="only-to-others-configuration"><a href="#only-to-others-configuration">Конфигурация</a></h4>
<p>Когда вы инициализируете экземпляр Laravel Echo, соединению назначается идентификатор сокета. Если вы используете
    глобальный экземпляр <a href="https://github.com/mzabriskie/axios">Axios</a> для выполнения HTTP-запросов из своего
    JavaScript-приложения, идентификатор сокета будет автоматически прикрепляться к каждому исходящему запросу в виде
    <code>X-Socket-ID</code> заголовка. Затем, когда вы вызываете <code>toOthers</code> метод, Laravel извлечет
    идентификатор сокета из заголовка и проинструктирует вещателя не транслировать никакие соединения с этим
    идентификатором сокета.</p>
<p>Если вы не используете глобальный экземпляр Axios, вам необходимо вручную настроить приложение JavaScript для
    отправки <code>X-Socket-ID</code> заголовка со всеми исходящими запросами. Вы можете получить идентификатор сокета,
    используя <code>Echo.socketId</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">var</span> socketId <span
                class="token operator">=</span> <span class="token keyword">Echo</span><span
                class="token punctuation">.</span><span class="token function">socketId</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="receiving-broadcasts"><a href="#receiving-broadcasts">Прием трансляций</a></h2>
<p></p>
<h3 id="listening-for-events"><a href="#listening-for-events">Прослушивание событий</a></h3>
<p>После того, как вы <a href="broadcasting#client-side-installation">установили и</a> создали <a
            href="broadcasting#client-side-installation">экземпляр Laravel Echo</a>, вы готовы начать прослушивание
    событий, которые транслируются из вашего приложения Laravel. Сначала используйте <code>channel</code> метод для
    получения экземпляра канала, затем вызовите <code>listen</code> метод для прослушивания указанного события:</p>
<pre class=" language-js"><code class=" language-js">Echo<span class="token punctuation">.</span><span
                class="token function">channel</span><span class="token punctuation">(</span><span
                class="token template-string"><span class="token template-punctuation string">`</span><span
                    class="token string">orders.</span><span class="token interpolation"><span
                        class="token interpolation-punctuation punctuation">{literal}${{/literal}</span><span class="token keyword">this</span><span class="token punctuation">.</span>order<span class="token punctuation">.</span>id<span class="token interpolation-punctuation punctuation">}</span></span><span
                    class="token template-punctuation string">`</span></span><span class="token punctuation">)</span>
    <span class="token punctuation">.</span><span class="token function">listen</span><span
                class="token punctuation">(</span><span class="token string">'OrderShipmentStatusUpdated'</span><span
                class="token punctuation">,</span> <span class="token punctuation">(</span><span
                class="token parameter">e</span><span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span
                class="token punctuation">{literal}{{/literal}</span>
        console<span class="token punctuation">.</span><span class="token function">log</span><span
                class="token punctuation">(</span>e<span class="token punctuation">.</span>order<span
                class="token punctuation">.</span>name<span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Если вы хотите прослушивать события на частном канале, используйте <code>private</code> вместо этого метод. Вы можете
    продолжить цепочку вызовов <code>listen</code> метода для прослушивания нескольких событий на одном канале:</p>
<pre class=" language-js"><code class=" language-js">Echo<span class="token punctuation">.</span><span
                class="token function">private</span><span class="token punctuation">(</span><span
                class="token template-string"><span class="token template-punctuation string">`</span><span
                    class="token string">orders.</span><span class="token interpolation"><span
                        class="token interpolation-punctuation punctuation">{literal}${{/literal}</span><span class="token keyword">this</span><span class="token punctuation">.</span>order<span class="token punctuation">.</span>id<span class="token interpolation-punctuation punctuation">}</span></span><span
                    class="token template-punctuation string">`</span></span><span class="token punctuation">)</span>
    <span class="token punctuation">.</span><span class="token function">listen</span><span
                class="token punctuation">(</span><span class="token operator">...</span><span
                class="token punctuation">)</span>
    <span class="token punctuation">.</span><span class="token function">listen</span><span
                class="token punctuation">(</span><span class="token operator">...</span><span
                class="token punctuation">)</span>
    <span class="token punctuation">.</span><span class="token function">listen</span><span
                class="token punctuation">(</span><span class="token operator">...</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="leaving-a-channel"><a href="#leaving-a-channel">Покидая канал</a></h3>
<p>Чтобы покинуть канал, вы можете вызвать <code>leaveChannel</code> метод своего экземпляра Echo:</p>
<pre class=" language-js"><code class=" language-js">Echo<span class="token punctuation">.</span><span
                class="token function">leaveChannel</span><span class="token punctuation">(</span><span
                class="token template-string"><span class="token template-punctuation string">`</span><span
                    class="token string">orders.</span><span class="token interpolation"><span
                        class="token interpolation-punctuation punctuation">{literal}${{/literal}</span><span class="token keyword">this</span><span class="token punctuation">.</span>order<span class="token punctuation">.</span>id<span class="token interpolation-punctuation punctuation">}</span></span><span
                    class="token template-punctuation string">`</span></span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если вы хотите покинуть канал, а также связанные с ним частные каналы и каналы присутствия, вы можете вызвать <code>leave</code>
    метод:</p>
<pre class=" language-js"><code class=" language-js">Echo<span class="token punctuation">.</span><span
                class="token function">leave</span><span class="token punctuation">(</span><span
                class="token template-string"><span class="token template-punctuation string">`</span><span
                    class="token string">orders.</span><span class="token interpolation"><span
                        class="token interpolation-punctuation punctuation">{literal}${{/literal}</span><span class="token keyword">this</span><span class="token punctuation">.</span>order<span class="token punctuation">.</span>id<span class="token interpolation-punctuation punctuation">}</span></span><span
                    class="token template-punctuation string">`</span></span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="namespaces"><a href="#namespaces">Пространства имён</a></h3>
<p>В приведенных выше примерах вы могли заметить, что мы не указали полное <code>App\Events</code> пространство имен для
    классов событий. Это потому, что Echo автоматически предполагает, что события находятся в <code>App\Events</code>
    пространстве имен. Однако вы можете настроить корневое пространство имен при создании экземпляра Echo, передав
    <code>namespace</code> параметр конфигурации:</p>
<pre class=" language-js"><code class=" language-js">window<span class="token punctuation">.</span>Echo <span
                class="token operator">=</span> <span class="token keyword">new</span> <span class="token class-name">Echo</span><span
                class="token punctuation">(</span><span class="token punctuation">{literal}{{/literal}</span>
    broadcaster<span class="token operator">:</span> <span class="token string">'pusher'</span><span
                class="token punctuation">,</span>
    <span class="token comment">//...</span>
    namespace<span class="token operator">:</span> <span class="token string">'App.Other.Namespace'</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>В качестве альтернативы вы можете префикс классов событий с помощью <code>.</code> при подписке на них с помощью
    Echo. Это позволит вам всегда указывать полное имя класса:</p>
<pre class=" language-js"><code class=" language-js">Echo<span class="token punctuation">.</span><span
                class="token function">channel</span><span class="token punctuation">(</span><span class="token string">'orders'</span><span
                class="token punctuation">)</span>
    <span class="token punctuation">.</span><span class="token function">listen</span><span
                class="token punctuation">(</span><span class="token string">'.Namespace\\Event\\Class'</span><span
                class="token punctuation">,</span> <span class="token punctuation">(</span><span
                class="token parameter">e</span><span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span
                class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="presence-channels"><a href="#presence-channels">Каналы присутствия</a></h2>
<p>Каналы присутствия основаны на безопасности частных каналов, в то же время раскрывая дополнительную функцию
    осведомленности о том, кто подписан на канал. Это упрощает создание мощных функций приложения для совместной работы,
    таких как уведомление пользователей, когда другой пользователь просматривает ту же страницу, или перечисление
    жителей комнаты чата.</p>
<p></p>
<h3 id="authorizing-presence-channels"><a href="#authorizing-presence-channels">Авторизация каналов присутствия</a></h3>
<p>Все каналы присутствия также являются частными; поэтому пользователи должны быть <a
            href="broadcasting#authorizing-channels">авторизованы для доступа к ним</a>. Однако при определении обратных
    вызовов авторизации для каналов присутствия вы не вернетесь, <code>true</code> если пользователь авторизован для
    присоединения к каналу. Вместо этого вы должны вернуть массив данных о пользователе.</p>
<p>Данные, возвращаемые обратным вызовом авторизации, будут доступны для прослушивателей событий канала присутствия в
    вашем приложении JavaScript. Если пользователь не авторизован для присоединения к каналу присутствия, вы должны
    вернуться <code>false</code> или <code>null</code>:</p>
<pre class=" language-php"><code class=" language-php">Broadcast<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">channel</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'chat.{literal}{roomId}{/literal}'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">,</span> <span class="token variable">$roomId</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">if</span> <span class="token punctuation">(</span><span
                class="token variable">$user</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">canJoinRoom</span><span class="token punctuation">(</span><span
                class="token variable">$roomId</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">name</span><span class="token punctuation">]</span><span
                class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="joining-presence-channels"><a href="#joining-presence-channels">Присоединение к каналам присутствия</a></h3>
<p>Чтобы присоединиться к каналу присутствия, вы можете использовать <code>join</code> метод Echo. <code>join</code>
    Метод возвращает <code>PresenceChannel</code> реализацию, которая, наряду с обнажая <code>listen</code> метод,
    позволяет подписаться на <code>here</code> , <code>joining</code> и <code>leaving</code> события.</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">Echo</span><span
                class="token punctuation">.</span><span class="token function">join</span><span
                class="token punctuation">(</span>`chat<span class="token punctuation">.</span><span
                class="token variable">$</span><span class="token punctuation">{literal}{{/literal}</span>roomId<span
                class="token punctuation">}</span>`<span class="token punctuation">)</span>
    <span class="token punctuation">.</span><span class="token function">here</span><span
                class="token punctuation">(</span><span class="token punctuation">(</span>users<span
                class="token punctuation">)</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span>
    <span class="token punctuation">.</span><span class="token function">joining</span><span
                class="token punctuation">(</span><span class="token punctuation">(</span>user<span
                class="token punctuation">)</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token punctuation">{literal}{{/literal}</span>
        console<span class="token punctuation">.</span><span class="token function">log</span><span
                class="token punctuation">(</span>user<span class="token punctuation">.</span>name<span
                class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span>
    <span class="token punctuation">.</span><span class="token function">leaving</span><span
                class="token punctuation">(</span><span class="token punctuation">(</span>user<span
                class="token punctuation">)</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token punctuation">{literal}{{/literal}</span>
        console<span class="token punctuation">.</span><span class="token function">log</span><span
                class="token punctuation">(</span>user<span class="token punctuation">.</span>name<span
                class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p><code>here</code> Обратного вызова будет выполняться сразу же после того, как канал успешно присоединился и получит
    массив, содержащий информацию о пользователе для всех других пользователей, в настоящее время подписался на канал.
    <code>joining</code> Метод будет выполняться, когда новый пользователь присоединяется к каналу, в то время как
    <code>leaving</code> метод будет выполняться, когда пользователь покидает канал.</p>
<p></p>
<h3 id="broadcasting-to-presence-channels"><a href="#broadcasting-to-presence-channels">Вещание на каналы
        присутствия</a></h3>
<p>Каналы присутствия могут получать события так же, как общедоступные или частные каналы. Используя пример чата, мы
    можем захотеть транслировать <code>NewMessage</code> события на канал присутствия комнаты. Для этого мы вернем
    экземпляр из метода <code>PresenceChannel</code> события <code>broadcastOn</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the channels the event should broadcast on.
 *
 * @return Channel|array
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">broadcastOn</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token keyword">new</span> <span class="token class-name">PresenceChannel</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'room.'</span><span
                class="token punctuation">.</span><span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">message</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">room_id</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Как и в случае с другими событиями, вы можете использовать <code>broadcast</code> помощник и <code>toOthers</code>
    метод, чтобы исключить текущего пользователя из приема трансляции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">broadcast</span><span
                class="token punctuation">(</span><span class="token keyword">new</span> <span class="token class-name">NewMessage</span><span
                class="token punctuation">(</span><span class="token variable">$message</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token function">broadcast</span><span class="token punctuation">(</span><span
                class="token keyword">new</span> <span class="token class-name">NewMessage</span><span
                class="token punctuation">(</span><span class="token variable">$message</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">toOthers</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Как типично для других типов событий, вы можете прослушивать события, отправленные в каналы присутствия, используя
    <code>listen</code> метод Echo:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">Echo</span><span
                class="token punctuation">.</span><span class="token function">join</span><span
                class="token punctuation">(</span>`chat<span class="token punctuation">.</span><span
                class="token variable">$</span><span class="token punctuation">{literal}{{/literal}</span>roomId<span
                class="token punctuation">}</span>`<span class="token punctuation">)</span>
    <span class="token punctuation">.</span><span class="token function">here</span><span
                class="token punctuation">(</span><span class="token punctuation">.</span><span
                class="token punctuation">.</span><span class="token punctuation">.</span><span
                class="token punctuation">)</span>
    <span class="token punctuation">.</span><span class="token function">joining</span><span
                class="token punctuation">(</span><span class="token punctuation">.</span><span
                class="token punctuation">.</span><span class="token punctuation">.</span><span
                class="token punctuation">)</span>
    <span class="token punctuation">.</span><span class="token function">leaving</span><span
                class="token punctuation">(</span><span class="token punctuation">.</span><span
                class="token punctuation">.</span><span class="token punctuation">.</span><span
                class="token punctuation">)</span>
    <span class="token punctuation">.</span><span class="token function">listen</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'NewMessage'</span><span
                class="token punctuation">,</span> <span class="token punctuation">(</span>e<span
                class="token punctuation">)</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="client-events"><a href="#client-events">Клиентские события</a></h2>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>При использовании <a href="https://pusher.com/channels">каналов толкателя</a> необходимо включить параметр
            «События клиента» в разделе «Настройки <a href="https://dashboard.pusher.com/">приложения» на панели
                инструментов приложения</a>, чтобы отправлять события клиента.</p></p></div>
</blockquote>
<p>Иногда вы можете захотеть транслировать событие другим подключенным клиентам, вообще не затрагивая ваше приложение
    Laravel. Это может быть особенно полезно для таких вещей, как «ввод» уведомлений, когда вы хотите предупредить
    пользователей вашего приложения о том, что другой пользователь печатает сообщение на заданном экране.</p>
<p>Для трансляции клиентских событий вы можете использовать <code>whisper</code> метод Echo:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">Echo</span><span
                class="token punctuation">.</span><span class="token keyword">private</span><span
                class="token punctuation">(</span>`chat<span class="token punctuation">.</span><span
                class="token variable">$</span><span class="token punctuation">{literal}{{/literal}</span>roomId<span
                class="token punctuation">}</span>`<span class="token punctuation">)</span>
    <span class="token punctuation">.</span><span class="token function">whisper</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'typing'</span><span
                class="token punctuation">,</span> <span class="token punctuation">{literal}{{/literal}</span>
        name<span class="token punctuation">:</span> this<span class="token punctuation">.</span>user<span
                class="token punctuation">.</span>name
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Чтобы прослушивать клиентские события, вы можете использовать <code>listenForWhisper</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">Echo</span><span
                class="token punctuation">.</span><span class="token keyword">private</span><span
                class="token punctuation">(</span>`chat<span class="token punctuation">.</span><span
                class="token variable">$</span><span class="token punctuation">{literal}{{/literal}</span>roomId<span
                class="token punctuation">}</span>`<span class="token punctuation">)</span>
    <span class="token punctuation">.</span><span class="token function">listenForWhisper</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'typing'</span><span
                class="token punctuation">,</span> <span class="token punctuation">(</span>e<span
                class="token punctuation">)</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token punctuation">{literal}{{/literal}</span>
        console<span class="token punctuation">.</span><span class="token function">log</span><span
                class="token punctuation">(</span>e<span class="token punctuation">.</span>name<span
                class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="notifications"><a href="#notifications">Уведомления</a></h2>
<p>Если связать трансляцию событий с <a href="notifications">уведомлениями</a>, ваше приложение JavaScript может
    получать новые уведомления по мере их появления без необходимости обновлять страницу. Перед началом работы
    обязательно прочтите документацию по использованию <a href="notifications#broadcast-notifications">канала
        широковещательных уведомлений</a>.</p>
<p>После того, как вы настроили уведомление для использования широковещательного канала, вы можете прослушивать
    широковещательные события, используя <code>notification</code> метод Echo. Помните, что имя канала должно
    соответствовать имени класса объекта, получающего уведомления:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">Echo</span><span
                class="token punctuation">.</span><span class="token keyword">private</span><span
                class="token punctuation">(</span>`App<span class="token punctuation">.</span>Models<span
                class="token punctuation">.</span>User<span class="token punctuation">.</span><span
                class="token variable">$</span><span class="token punctuation">{literal}{{/literal}</span>userId<span
                class="token punctuation">}</span>`<span class="token punctuation">)</span>
    <span class="token punctuation">.</span><span class="token function">notification</span><span
                class="token punctuation">(</span><span class="token punctuation">(</span>notification<span
                class="token punctuation">)</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token punctuation">{literal}{{/literal}</span>
        console<span class="token punctuation">.</span><span class="token function">log</span><span
                class="token punctuation">(</span>notification<span class="token punctuation">.</span>type<span
                class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>В этом примере все уведомления, отправленные <code>App\Models\User</code> экземплярам через <code>broadcast</code>
    канал, будут получены обратным вызовом. Обратный вызов авторизации канала для <code>App.Models.User.{literal}{id}{/literal}</code>
    канала включен по умолчанию, <code>BroadcastServiceProvider</code> который поставляется с платформой Laravel.</p>
