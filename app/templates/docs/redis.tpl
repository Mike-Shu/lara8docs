<h1>Redis</h1>
<ul>
    <li><a href="redis#introduction">Вступление</a></li>
    <li><a href="redis#configuration">Конфигурация</a>
        <ul>
            <li><a href="redis#clusters">Кластеры</a></li>
            <li><a href="redis#predis">Predis</a></li>
            <li><a href="redis#phpredis">phpredis</a></li>
        </ul>
    </li>
    <li><a href="redis#interacting-with-redis">Взаимодействие с Redis</a>
        <ul>
            <li><a href="redis#transactions">Транзакции <sup>Transactions</sup></a></li>
            <li><a href="redis#pipelining-commands">Команды конвейерной обработки</a></li>
        </ul>
    </li>
    <li><a href="redis#pubsub">Pub / Sub</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p><a href="https://redis.io">Redis</a> - это расширенное хранилище ключей и значений с открытым исходным кодом. Его
    часто называют сервером структуры данных, поскольку ключи могут содержать <a
            href="https://redis.io/topics/data-types%23strings">строки</a>, <a
            href="https://redis.io/topics/data-types%23hashes">хэши</a>, <a
            href="https://redis.io/topics/data-types%23lists">списки</a>, <a
            href="https://redis.io/topics/data-types%23sets">наборы</a> и <a
            href="https://redis.io/topics/data-types%23sorted-sets">отсортированные наборы</a>.</p>
<p>Перед использованием Redis с Laravel мы рекомендуем вам установить и использовать PHP-расширение <a
            href="https://github.com/phpredis/phpredis">phpredis</a> через PECL. Расширение сложнее установить по
    сравнению с пакетами PHP, предназначенными для пользователя, но может обеспечить лучшую производительность для
    приложений, интенсивно использующих Redis. Если вы используете <a href="sail">Laravel Sail</a>, это расширение уже
    установлено в контейнере Docker вашего приложения.</p>
<p>Если вы не можете установить расширение phpredis, вы можете установить <code>predis/predis</code> пакет через
    Composer. Predis - это клиент Redis, полностью написанный на PHP и не требующий дополнительных расширений:</p>
<pre class=" language-bash"><code class=" language-bash"><span class="token function">composer</span> require predis/predis</code></pre>
<p></p>
<h2 id="configuration"><a href="#configuration">Конфигурация</a></h2>
<p>Вы можете настроить параметры Redis для своего приложения через <code>config/database.php</code> файл конфигурации. В
    этом файле вы увидите <code>redis</code> массив, содержащий серверы Redis, используемые вашим приложением:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'redis'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>

    <span class="token single-quoted-string string">'client'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'REDIS_CLIENT'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'phpredis'</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span>

    <span class="token single-quoted-string string">'default'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'host'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'REDIS_HOST'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'127.0.0.1'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'password'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'REDIS_PASSWORD'</span><span
                class="token punctuation">,</span> <span class="token constant">null</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'port'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'REDIS_PORT'</span><span
                class="token punctuation">,</span> <span class="token number">6379</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'database'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'REDIS_DB'</span><span
                class="token punctuation">,</span> <span class="token number">0</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>

    <span class="token single-quoted-string string">'cache'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'host'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'REDIS_HOST'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'127.0.0.1'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'password'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'REDIS_PASSWORD'</span><span
                class="token punctuation">,</span> <span class="token constant">null</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'port'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'REDIS_PORT'</span><span
                class="token punctuation">,</span> <span class="token number">6379</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'database'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'REDIS_CACHE_DB'</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>

<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p>Каждый сервер Redis, определенный в вашем файле конфигурации, должен иметь имя, хост и порт, если вы не определите
    единственный URL-адрес для представления соединения Redis:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'redis'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>

    <span class="token single-quoted-string string">'client'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'REDIS_CLIENT'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'phpredis'</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span>

    <span class="token single-quoted-string string">'default'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'url'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'tcp://127.0.0.1:6379?database=0'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>

    <span class="token single-quoted-string string">'cache'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'url'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'tls://user:password@127.0.0.1:6380?database=1'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>

<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p></p>
<h4 id="configuring-the-connection-scheme"><a href="#configuring-the-connection-scheme">Настройка схемы подключения</a>
</h4>
<p>По умолчанию клиенты Redis будут использовать эту <code>tcp</code> схему при подключении к вашим серверам Redis;
    однако вы можете использовать шифрование TLS / SSL, указав <code>scheme</code> параметр конфигурации в массиве
    конфигурации вашего сервера Redis:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'redis'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>

    <span class="token single-quoted-string string">'client'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'REDIS_CLIENT'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'phpredis'</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span>

    <span class="token single-quoted-string string">'default'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'scheme'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'tls'</span><span
                class="token punctuation">,</span>
        <span class="token single-quoted-string string">'host'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'REDIS_HOST'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'127.0.0.1'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'password'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'REDIS_PASSWORD'</span><span
                class="token punctuation">,</span> <span class="token constant">null</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'port'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'REDIS_PORT'</span><span
                class="token punctuation">,</span> <span class="token number">6379</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'database'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'REDIS_DB'</span><span
                class="token punctuation">,</span> <span class="token number">0</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>

<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p></p>
<h3 id="clusters"><a href="#clusters">Кластеры</a></h3>
<p>Если ваше приложение использует кластер серверов Redis, вы должны определить эти кластеры в пределах
    <code>clusters</code> ключа вашей конфигурации Redis. Этот ключ конфигурации не существует по умолчанию, поэтому вам
    нужно будет создать его в <code>config/database.php</code> файле конфигурации вашего приложения:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'redis'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>

    <span class="token single-quoted-string string">'client'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'REDIS_CLIENT'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'phpredis'</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span>

    <span class="token single-quoted-string string">'clusters'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'default'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
            <span class="token punctuation">[</span>
                <span class="token single-quoted-string string">'host'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'REDIS_HOST'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'localhost'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
                <span class="token single-quoted-string string">'password'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token function">env</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'REDIS_PASSWORD'</span><span
                class="token punctuation">,</span> <span class="token constant">null</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
                <span class="token single-quoted-string string">'port'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'REDIS_PORT'</span><span
                class="token punctuation">,</span> <span class="token number">6379</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
                <span class="token single-quoted-string string">'database'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">0</span><span class="token punctuation">,</span>
            <span class="token punctuation">]</span><span class="token punctuation">,</span>
        <span class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>

<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p>По умолчанию кластеры будут выполнять сегментирование ваших узлов на стороне клиента, что позволяет объединять узлы в
    пул и создавать большой объем доступной оперативной памяти. Однако сегментирование на стороне клиента не
    обрабатывает отработку отказа; поэтому он в первую очередь подходит для временных кэшированных данных, доступных из
    другого первичного хранилища данных.</p>
<p>Если вы хотите использовать собственную кластеризацию Redis вместо сегментирования на стороне клиента, вы можете
    указать это, установив <code>options.cluster</code> значение конфигурации в файле конфигурации <code>redis</code>
    вашего приложения <code>config/database.php</code>:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'redis'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>

    <span class="token single-quoted-string string">'client'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'REDIS_CLIENT'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'phpredis'</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span>

    <span class="token single-quoted-string string">'options'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'cluster'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'REDIS_CLUSTER'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'redis'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>

    <span class="token single-quoted-string string">'clusters'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token comment">//...</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>

<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p></p>
<h3 id="predis"><a href="#predis">Predis</a></h3>
<p>Если вы хотите, чтобы ваше приложение взаимодействовало с Redis через пакет Predis, убедитесь, что
    значение переменной среды <code>REDIS_CLIENT</code> равно <code>predis</code>:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'redis'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>

    <span class="token single-quoted-string string">'client'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'REDIS_CLIENT'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'predis'</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span>

    <span class="token comment">// Rest of Redis configuration...</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p>В дополнение к по умолчанию на <code>host</code>, <code>port</code>, <code>database</code> и <code>password</code>
    параметры конфигурации сервера, Predis поддерживает дополнительные <a
            href="https://github.com/nrk/predis/wiki/Connection-Parameters">параметры соединения</a>, которые могут быть
    определены для каждого из ваших серверов Redis. Чтобы использовать эти дополнительные параметры конфигурации,
    добавьте их в конфигурацию сервера Redis в файле конфигурации вашего приложения <code>config/database.php</code>:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token single-quoted-string string">'default'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'host'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'REDIS_HOST'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'localhost'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'password'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'REDIS_PASSWORD'</span><span
                class="token punctuation">,</span> <span class="token constant">null</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'port'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'REDIS_PORT'</span><span
                class="token punctuation">,</span> <span class="token number">6379</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'database'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">0</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'read_write_timeout'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">60</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p></p>
<h4 id="the-redis-facade-alias"><a href="#the-redis-facade-alias">Псевдоним Redis Facade</a></h4>
<p><code>config/app.php</code> Файл конфигурации Laravel содержит <code>aliases</code> массив, который определяет все
    псевдонимы классов, которые будут зарегистрированы фреймворком. Для удобства для каждого <a
            href="facades">фасада,</a> предлагаемого Laravel, включен псевдоним ; однако <code>Redis</code> псевдоним
    отключен, поскольку он конфликтует с <code>Redis</code> именем класса, предоставленным расширением phpredis. Если вы
    используете клиент Predis и хотите включить этот псевдоним, вы можете не комментировать псевдоним в <code>config/app.php</code>
    файле конфигурации вашего приложения.</p>
<p></p>
<h3 id="phpredis"><a href="#phpredis">phpredis</a></h3>
<p>По умолчанию Laravel будет использовать расширение phpredis для связи с Redis. Клиент, который Laravel будет
    использовать для связи с Redis, определяется значением параметра <code>redis.client</code> конфигурации, который
    обычно отражает значение <code>REDIS_CLIENT</code> переменной среды:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'redis'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>

    <span class="token single-quoted-string string">'client'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'REDIS_CLIENT'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'phpredis'</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span>

    <span class="token comment">// Rest of Redis configuration...</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p>В дополнение к по умолчанию <code>host</code>, <code>port</code>, <code>database</code>, и <code>password</code>
    параметры конфигурации сервера, phpredis поддерживает следующие дополнительные параметры соединения:
    <code>name</code>, <code>persistent</code>, <code>prefix</code>, <code>read_timeout</code>,
    <code>retry_interval</code>, <code>timeout</code>, и <code>context</code>. Вы можете добавить любой из этих
    параметров в конфигурацию вашего сервера Redis в <code>config/database.php</code> файле конфигурации:</p>
<pre class=" language-php"><code class=" language-php"><span class="token single-quoted-string string">'default'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'host'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'REDIS_HOST'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'localhost'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'password'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'REDIS_PASSWORD'</span><span
                class="token punctuation">,</span> <span class="token constant">null</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'port'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'REDIS_PORT'</span><span
                class="token punctuation">,</span> <span class="token number">6379</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'database'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">0</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'read_timeout'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">60</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'context'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token comment">// 'auth' =&gt; ['username', 'secret'],</span>
        <span class="token comment">// 'stream' =&gt; ['verify_peer' =&gt; false],</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p></p>
<h2 id="interacting-with-redis"><a href="#interacting-with-redis">Взаимодействие с Redis</a></h2>
<p>Вы можете взаимодействовать с Redis, вызывая различные методы <code>Redis</code><a href="facades">фасада</a>. <code>Redis</code>
    Фасад поддерживает динамические методы, то есть вы можете вызвать любую <a href="https://redis.io/commands">команду
        Redis</a> на фасаде, и команда будет передана непосредственно Redis. В этом примере мы вызовем команду Redis
    <code>GET</code>, вызвав <code>get</code> метод <code>Redis</code> фасада:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>Controller</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Redis</span><span class="token punctuation">;</span>

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
        <span class="token keyword">return</span> <span class="token function">view</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'user.profile'</span><span
                    class="token punctuation">,</span> <span class="token punctuation">[</span>
            <span class="token single-quoted-string string">'user'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> Redis<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token function">get</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'user:profile:'</span><span
                    class="token punctuation">.</span><span class="token variable">$id</span><span
                    class="token punctuation">)</span>
        <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Как упоминалось выше, вы можете вызывать любую команду Redis на <code>Redis</code> фасаде. Laravel использует
    магические методы для передачи команд на сервер Redis. Если команда Redis ожидает аргументов, вы должны передать их
    соответствующему методу фасада:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Redis</span><span
                class="token punctuation">;</span>

Redis<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">set</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'name'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Taylor'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$values</span> <span class="token operator">=</span> Redis<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">lrange</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'names'</span><span
                class="token punctuation">,</span> <span class="token number">5</span><span
                class="token punctuation">,</span> <span class="token number">10</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>В качестве альтернативы вы можете передавать команды на сервер, используя метод <code>Redis</code> фасада <code>command</code>,
    который принимает имя команды в качестве первого аргумента и массив значений в качестве второго аргумента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$values</span> <span
                class="token operator">=</span> Redis<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">command</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'lrange'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'name'</span><span class="token punctuation">,</span> <span
                class="token number">5</span><span class="token punctuation">,</span> <span
                class="token number">10</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="using-multiple-redis-connections"><a href="#using-multiple-redis-connections">Использование нескольких
        подключений Redis</a></h4>
<p><code>config/database.php</code> Файл конфигурации вашего приложения позволяет вам определять несколько соединений /
    серверов Redis. Вы можете получить соединение с конкретным соединением Redis, используя метод <code>Redis</code>
    фасада <code>connection</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$redis</span> <span
                class="token operator">=</span> Redis<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">connection</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'connection-name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Чтобы получить экземпляр соединения Redis по умолчанию, вы можете вызвать <code>connection</code> метод без
    каких-либо дополнительных аргументов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$redis</span> <span
                class="token operator">=</span> Redis<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">connection</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="transactions"><a href="#transactions">Транзакции <sup>Transactions</sup></a></h3>
<p>Метод <code>Redis</code> фасада <code>transaction</code> предоставляет удобную оболочку для собственных команд <code>MULTI</code>
    и <code>EXEC</code> команд Redis. <code>transaction</code> Метод принимает замыкание в качестве единственного
    аргумента. Это закрытие получит экземпляр подключения Redis и может выдавать любые команды, которые ему нужны. Все
    команды Redis, выдаваемые при закрытии, будут выполняться в одной атомарной транзакции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Redis</span><span
                class="token punctuation">;</span>

Redis<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">transaction</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$redis</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$redis</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">incr</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'user_visits'</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token variable">$redis</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">incr</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'total_visits'</span><span class="token punctuation">,</span> <span
                class="token number">1</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>При определении транзакции Redis вы не можете получать какие-либо значения из соединения Redis. Помните, ваша
            транзакция выполняется как одна атомарная операция, и эта операция не выполняется, пока все ваше закрытие не
            завершит выполнение своих команд.</p></p></div>
</blockquote>
<h4>Скрипты Lua</h4>
<p>Этот <code>eval</code> метод предоставляет еще один метод выполнения нескольких команд Redis за одну атомарную
    операцию. Однако <code>eval</code> преимущество этого метода состоит в том, что он может взаимодействовать со
    значениями ключей Redis и проверять их во время этой операции. Скрипты Redis написаны на <a
            href="https://www.lua.org">языке программирования Lua</a>.</p>
<p><code>eval</code> Сначала этот метод может показаться немного пугающим, но мы рассмотрим базовый пример, чтобы
    сломать лед. <code>eval</code> Метод ожидает несколько аргументов. Во-первых, вы должны передать в метод скрипт Lua
    (в виде строки). Во-вторых, вы должны передать количество ключей (в виде целого числа), с которыми скрипт
    взаимодействует. В-третьих, вы должны передать имена этих ключей. Наконец, вы можете передать любые другие
    дополнительные аргументы, которые вам понадобятся в вашем скрипте.</p>
<p>В этом примере мы увеличим счетчик, проверим его новое значение и увеличим второй счетчик, если значение первого
    счетчика больше пяти. Наконец, мы вернем значение первого счетчика:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$value</span> <span
                class="token operator">=</span> Redis<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">eval</span><span
                class="token punctuation">(</span><span class="token operator">&lt;</span><span class="token operator">&lt;</span><span
                class="token operator">&lt;</span><span class="token single-quoted-string string">'LUA'</span>
    local counter <span class="token operator">=</span> redis<span class="token punctuation">.</span><span
                class="token function">call</span><span class="token punctuation">(</span><span
                class="token double-quoted-string string">"incr"</span><span class="token punctuation">,</span> <span
                class="token constant">KEYS</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span>

    <span class="token keyword">if</span> counter <span class="token operator">&gt;</span> <span
                class="token number">5</span> then
        redis<span class="token punctuation">.</span><span class="token function">call</span><span
                class="token punctuation">(</span><span class="token double-quoted-string string">"incr"</span><span
                class="token punctuation">,</span> <span class="token constant">KEYS</span><span
                class="token punctuation">[</span><span class="token number">2</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span>
    end

    <span class="token keyword">return</span> counter
<span class="token constant">LUA</span><span class="token punctuation">,</span> <span class="token number">2</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'first-counter'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'second-counter'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Пожалуйста, обратитесь к <a href="https://redis.io/commands/eval">документации Redis</a> для получения
            дополнительной информации о сценариях Redis.</p></p></div>
</blockquote>
<p></p>
<h3 id="pipelining-commands"><a href="#pipelining-commands">Команды конвейерной обработки</a></h3>
<p>Иногда вам может потребоваться выполнить десятки команд Redis. Вместо того, чтобы совершать сетевое обращение к
    вашему серверу Redis для каждой команды, вы можете использовать этот <code>pipeline</code> метод.
    <code>pipeline</code> Метод принимает один аргумент: замыкание, которое принимает экземпляр Redis. Вы можете
    передать все свои команды этому экземпляру Redis, и все они будут отправлены на сервер Redis одновременно, чтобы
    сократить сетевые обращения к серверу. Команды по-прежнему будут выполняться в том порядке, в котором они были
    отправлены:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Redis</span><span
                class="token punctuation">;</span>

Redis<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">pipeline</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$pipe</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">for</span> <span class="token punctuation">(</span><span class="token variable">$i</span> <span
                class="token operator">=</span> <span class="token number">0</span><span
                class="token punctuation">;</span> <span class="token variable">$i</span> <span class="token operator">&lt;</span> <span
                class="token number">1000</span><span class="token punctuation">;</span> <span
                class="token variable">$i</span><span class="token operator">++</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$pipe</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">set</span><span class="token punctuation">(</span><span
                class="token double-quoted-string string">"key:<span class="token interpolation"><span
                        class="token variable">$i</span></span>"</span><span class="token punctuation">,</span> <span
                class="token variable">$i</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="pubsub"><a href="#pubsub">Pub / Sub</a></h2>
<p>Laravel предоставляет удобный интерфейс для Redis <code>publish</code> и <code>subscribe</code> команд. Эти команды
    Redis позволяют вам прослушивать сообщения на заданном «канале». Вы можете публиковать сообщения в канале из другого
    приложения или даже с использованием другого языка программирования, что упрощает обмен данными между приложениями и
    процессами.</p>
<p>Во-первых, давайте настроим прослушиватель каналов, используя <code>subscribe</code> метод. Мы поместим этот вызов
    метода в команду <a href="artisan">Artisan,</a> поскольку вызов <code>subscribe</code> метода запускает длительный
    процесс:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Console<span
                        class="token punctuation">\</span>Commands</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Console<span
                        class="token punctuation">\</span>Command</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Redis</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">RedisSubscribe</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Command</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * The name and signature of the console command.
    *
    * @var string
    */</span>
    <span class="token keyword">protected</span> <span class="token variable">$signature</span> <span
                    class="token operator">=</span> <span
                    class="token single-quoted-string string">'redis:subscribe'</span><span
                    class="token punctuation">;</span>

    <span class="token comment">/**
    * The console command description.
    *
    * @var string
    */</span>
    <span class="token keyword">protected</span> <span class="token variable">$description</span> <span
                    class="token operator">=</span> <span class="token single-quoted-string string">'Subscribe to a Redis channel'</span><span
                    class="token punctuation">;</span>

    <span class="token comment">/**
    * Execute the console command.
    *
    * @return mixed
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">handle</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        Redis<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">subscribe</span><span
                    class="token punctuation">(</span><span class="token punctuation">[</span><span
                    class="token single-quoted-string string">'test-channel'</span><span
                    class="token punctuation">]</span><span class="token punctuation">,</span> <span
                    class="token keyword">function</span> <span class="token punctuation">(</span><span
                    class="token variable">$message</span><span class="token punctuation">)</span> <span
                    class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">echo</span> <span class="token variable">$message</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Теперь мы можем публиковать сообщения в канале, используя <code>publish</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Redis</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/publish'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//...</span>
            
    Redis<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">publish</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'test-channel'</span><span class="token punctuation">,</span> <span
                class="token function">json_encode</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span>
        <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Adam Wathan'</span>
    <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="wildcard-subscriptions"><a href="#wildcard-subscriptions">Подписки с подстановочными знаками</a></h4>
<p>Используя этот <code>psubscribe</code> метод, вы можете подписаться на канал с подстановочными знаками, который может
    быть полезен для перехвата всех сообщений на всех каналах. Имя канала будет передано вторым аргументом в указанное
    закрытие:</p>
<pre class=" language-php"><code class=" language-php">Redis<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">psubscribe</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'*'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$message</span><span
                class="token punctuation">,</span> <span class="token variable">$channel</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">echo</span> <span class="token variable">$message</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

Redis<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">psubscribe</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'users.*'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$message</span><span
                class="token punctuation">,</span> <span class="token variable">$channel</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">echo</span> <span class="token variable">$message</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
