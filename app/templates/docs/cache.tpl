<h1>Кеш</h1>
<ul>
    <li><a href="cache#introduction">Вступление</a></li>
    <li><a href="cache#configuration">Конфигурация</a>
        <ul>
            <li><a href="cache#driver-prerequisites">Требования к драйверам</a></li>
        </ul>
    </li>
    <li><a href="cache#cache-usage">Использование кеша</a>
        <ul>
            <li><a href="cache#obtaining-a-cache-instance">Получение экземпляра кеша</a></li>
            <li><a href="cache#retrieving-items-from-the-cache">Получение элементов из кеша</a></li>
            <li><a href="cache#storing-items-in-the-cache">Хранение предметов в кэше</a></li>
            <li><a href="cache#removing-items-from-the-cache">Удаление элементов из кеша</a></li>
            <li><a href="cache#the-cache-helper">Помощник кеша</a></li>
        </ul>
    </li>
    <li><a href="cache#cache-tags">Теги кеша</a>
        <ul>
            <li><a href="cache#storing-tagged-cache-items">Хранение отмеченных элементов кэша</a></li>
            <li><a href="cache#accessing-tagged-cache-items">Доступ к помеченным элементам кэша</a></li>
            <li><a href="cache#removing-tagged-cache-items">Удаление отмеченных элементов кеша</a></li>
        </ul>
    </li>
    <li><a href="cache#atomic-locks">Атомные замки</a>
        <ul>
            <li><a href="cache#lock-driver-prerequisites">Требования к драйверам</a></li>
            <li><a href="cache#managing-locks">Управление замками</a></li>
            <li><a href="cache#managing-locks-across-processes">Управление блокировками между процессами</a></li>
        </ul>
    </li>
    <li><a href="cache#adding-custom-cache-drivers">Добавление собственных драйверов кэша</a>
        <ul>
            <li><a href="cache#writing-the-driver">Написание драйвера</a></li>
            <li><a href="cache#registering-the-driver">Регистрация драйвера</a></li>
        </ul>
    </li>
    <li><a href="cache#events">События</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Некоторые задачи по извлечению или обработке данных, выполняемые вашим приложением, могут потребовать больших
    ресурсов ЦП или занять несколько секунд. В этом случае извлеченные данные обычно кэшируют на некоторое время, чтобы
    их можно было быстро извлечь при последующих запросах тех же данных. Кэшированные данные обычно хранятся в очень
    быстром хранилище данных, таком как <a href="https://memcached.org">Memcached</a> или <a href="https://redis.io">Redis</a>.
</p>
<p>К счастью, Laravel предоставляет выразительный унифицированный API для различных механизмов кеширования, что
    позволяет вам воспользоваться их невероятно быстрым извлечением данных и ускорить работу вашего веб-приложения.</p>
<p></p>
<h2 id="configuration"><a href="#configuration">Конфигурация</a></h2>
<p>Файл конфигурации кеша вашего приложения находится по адресу <code>config/cache.php</code> . В этом файле вы можете
    указать, какой драйвер кеша вы хотите использовать по умолчанию во всем приложении. Laravel " из коробки"
    поддерживает популярные бэкенды кеширования, такие как <a href="https://memcached.org">Memcached</a>, <a
            href="https://redis.io">Redis</a>, <a href="https://aws.amazon.com/dynamodb">DynamoDB</a> и реляционные базы
    данных. Кроме того, доступен драйвер кеширования на основе файлов, а <code>array</code> драйверы «нулевого» кеша
    предоставляют удобные механизмы кеширования для ваших автоматических тестов.</p>
<p>Файл конфигурации кеша также содержит различные другие параметры, которые задокументированы в файле, поэтому
    обязательно прочтите эти параметры. По умолчанию Laravel настроен на использование <code>file</code> драйвера кэша,
    который хранит сериализованные кэшированные объекты в файловой системе сервера. Для более крупных приложений
    рекомендуется использовать более надежный драйвер, например Memcached или Redis. Вы даже можете настроить несколько
    конфигураций кеша для одного и того же драйвера.</p>
<p></p>
<h3 id="driver-prerequisites"><a href="#driver-prerequisites">Требования к драйверам</a></h3>
<p></p>
<h4 id="prerequisites-database"><a href="#prerequisites-database">База данных</a></h4>
<p>При использовании <code>database</code> драйвера кеша вам нужно будет настроить таблицу для хранения элементов кеша.
    Вы найдете пример <code>Schema</code> объявления в таблице ниже:</p>
<pre class=" language-php"><code class=" language-php">Schema<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'cache'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$table</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">string</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'key'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">unique</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">text</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'value'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">integer</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'expiration'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Вы также можете использовать команду <code>php artisan cache:table</code> Artisan для создания миграции с
            правильной схемой.</p></p></div>
</blockquote>
<p></p>
<h4 id="memcached"><a href="#memcached">Memcached</a></h4>
<p>Для использования драйвера Memcached необходимо установить <a href="https://pecl.php.net/package/memcached">пакет
        Memcached PECL</a>. Вы можете указать все ваши серверы Memcached в <code>config/cache.php</code> файле
    конфигурации. Этот файл уже содержит <code>memcached.servers</code> запись, с которой можно начать:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'memcached'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'servers'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token punctuation">[</span>
            <span class="token single-quoted-string string">'host'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'MEMCACHED_HOST'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'127.0.0.1'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
            <span class="token single-quoted-string string">'port'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'MEMCACHED_PORT'</span><span
                class="token punctuation">,</span> <span class="token number">11211</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
            <span class="token single-quoted-string string">'weight'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">100</span><span class="token punctuation">,</span>
        <span class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p>При необходимости вы можете указать <code>host</code> путь к сокету UNIX. Если вы это сделаете, <code>port</code>
    параметр должен быть установлен на <code>0</code>:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'memcached'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'host'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'/var/run/memcached/memcached.sock'</span><span
                class="token punctuation">,</span>
        <span class="token single-quoted-string string">'port'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">0</span><span
                class="token punctuation">,</span>
        <span class="token single-quoted-string string">'weight'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">100</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p></p>
<h4 id="redis"><a href="#redis">Redis</a></h4>
<p>Перед использованием кеша Redis с Laravel вам нужно будет либо установить расширение PHP PhpRedis через PECL, либо
    установить <code>predis/predis</code> пакет (~ 1.0) через Composer. <a href="sail">Laravel Sail</a> уже включает это
    расширение. Кроме того, на официальных платформах развертывания Laravel, таких как <a
            href="https://forge.laravel.com">Laravel Forge</a> и <a href="https://vapor.laravel.com">Laravel Vapor</a>,
    по умолчанию установлено расширение PhpRedis.</p>
<p>Для получения дополнительной информации о настройке Redis обратитесь к его <a href="redis#configuration">странице
        документации Laravel</a>.</p>
<p></p>
<h2 id="cache-usage"><a href="#cache-usage">Использование кеша</a></h2>
<p></p>
<h3 id="obtaining-a-cache-instance"><a href="#obtaining-a-cache-instance">Получение экземпляра кеша</a></h3>
<p>Чтобы получить экземпляр хранилища кеша, вы можете использовать <code>Cache</code> фасад, который мы будем
    использовать в этой документации. <code>Cache</code> Фасад обеспечивает удобный, лаконичный доступ к базовым
    реализациям контрактов кэша Laravel:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Cache</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">UserController</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Show a list of all users of the application.
    *
    * @return Response
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">index</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$value</span> <span class="token operator">=</span> Cache<span
                    class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">get</span><span class="token punctuation">(</span><span
                    class="token single-quoted-string string">'key'</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>

        <span class="token comment">//</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h4 id="accessing-multiple-cache-stores"><a href="#accessing-multiple-cache-stores">Доступ к нескольким
        кеш-хранилищам</a></h4>
<p>Используя <code>Cache</code> фасад, вы можете получить доступ к различным хранилищам кеша с помощью
    <code>store</code> метода. Ключ, переданный <code>store</code> методу, должен соответствовать одному из хранилищ,
    перечисленных в <code>stores</code> массиве конфигурации в вашем <code>cache</code> файле конфигурации:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$value</span> <span
                class="token operator">=</span> Cache<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">store</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'file'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'foo'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

Cache<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">store</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'redis'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">put</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'bar'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'baz'</span><span class="token punctuation">,</span> <span
                class="token number">600</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span> <span class="token comment">// 10 Minutes</span></code></pre>
<p></p>
<h3 id="retrieving-items-from-the-cache"><a href="#retrieving-items-from-the-cache">Получение элементов из кеша</a></h3>
<p>Метод <code>Cache</code> фасада <code>get</code> используется для извлечения элементов из кеша. Если элемент не
    существует в кеше, <code>null</code> будет возвращен. При желании вы можете передать второй аргумент
    <code>get</code> методу, указав значение по умолчанию, которое вы хотите вернуть, если элемент не существует:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$value</span> <span
                class="token operator">=</span> Cache<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'key'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$value</span> <span class="token operator">=</span> Cache<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'key'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'default'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы даже можете передать закрытие в качестве значения по умолчанию. Результат закрытия будет возвращен, если указанный
    элемент не существует в кеше. Передача закрытия позволяет отложить получение значений по умолчанию из базы данных
    или другой внешней службы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$value</span> <span
                class="token operator">=</span> Cache<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'key'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token punctuation">.</span><span
                class="token punctuation">.</span><span class="token punctuation">.</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="checking-for-item-existence"><a href="#checking-for-item-existence">Проверка наличия товара</a></h4>
<p><code>has</code> Метод может быть использован для определения, если элемент существует в кэше. Этот метод также
    вернет значение, <code>false</code> если элемент существует, но его значение <code>null</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">if</span> <span
                class="token punctuation">(</span>Cache<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">has</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'key'</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="incrementing-decrementing-values"><a href="#incrementing-decrementing-values">Увеличение / уменьшение
        значений</a></h4>
<p><code>increment</code> И <code>decrement</code> методы могут быть использованы для регулировки значения целых
    элементов в кэше. Оба эти метода принимают необязательный второй аргумент, указывающий величину увеличения или
    уменьшения значения элемента:</p>
<pre class=" language-php"><code class=" language-php">Cache<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">increment</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'key'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
Cache<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">increment</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'key'</span><span
                class="token punctuation">,</span> <span class="token variable">$amount</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
Cache<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">decrement</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'key'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
Cache<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">decrement</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'key'</span><span
                class="token punctuation">,</span> <span class="token variable">$amount</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="retrieve-store"><a href="#retrieve-store">Получить и сохранить</a></h4>
<p>Иногда вы можете захотеть получить элемент из кеша, но также сохранить значение по умолчанию, если запрошенный
    элемент не существует. Например, вы можете захотеть получить всех пользователей из кеша или, если они не существуют,
    получить их из базы данных и добавить их в кеш. Вы можете сделать это с помощью <code>Cache::remember</code> метода:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$value</span> <span
                class="token operator">=</span> Cache<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">remember</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">,</span> <span class="token variable">$seconds</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Если элемент не существует в кеше, закрытие, переданное <code>remember</code> методу, будет выполнено, а его
    результат будет помещен в кеш.</p>
<p>Вы можете использовать этот <code>rememberForever</code> метод, чтобы получить элемент из кеша или сохранить его
    навсегда, если он не существует:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$value</span> <span
                class="token operator">=</span> Cache<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">rememberForever</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="retrieve-delete"><a href="#retrieve-delete">Получить и удалить</a></h4>
<p>Если вам нужно получить элемент из кеша, а затем удалить элемент, вы можете использовать этот <code>pull</code>
    метод. Как и <code>get</code> метод, <code>null</code> будет возвращен, если элемент не существует в кеше:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$value</span> <span
                class="token operator">=</span> Cache<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">pull</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'key'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="storing-items-in-the-cache"><a href="#storing-items-in-the-cache">Хранение предметов в кэше</a></h3>
<p>Вы можете использовать <code>put</code> метод <code>Cache</code> фасада для хранения элементов в кеше:</p>
<pre class=" language-php"><code class=" language-php">Cache<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">put</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'key'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'value'</span><span
                class="token punctuation">,</span> <span class="token variable">$seconds</span> <span
                class="token operator">=</span> <span class="token number">10</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если время хранения не передано <code>put</code> методу, элемент будет храниться бесконечно:</p>
<pre class=" language-php"><code class=" language-php">Cache<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">put</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'key'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'value'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вместо того, чтобы передавать количество секунд как целое число, вы также можете передать <code>DateTime</code>
    экземпляр, представляющий желаемое время истечения кэшированного элемента:</p>
<pre class=" language-php"><code class=" language-php">Cache<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">put</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'key'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'value'</span><span
                class="token punctuation">,</span> <span class="token function">now</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">addMinutes</span><span
                class="token punctuation">(</span><span class="token number">10</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="store-if-not-present"><a href="#store-if-not-present">Хранить, если нет</a></h4>
<p><code>add</code> Метод будет только добавить элемент в кэш, если он уже не существует в хранилище кэша. Метод
    вернется, <code>true</code> если элемент действительно добавлен в кеш. В противном случае метод вернется
    <code>false</code> . <code>add</code> Метод является атомарной операцией:</p>
<pre class=" language-php"><code class=" language-php">Cache<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">add</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'key'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'value'</span><span
                class="token punctuation">,</span> <span class="token variable">$seconds</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="storing-items-forever"><a href="#storing-items-forever">Хранение вещей навсегда</a></h4>
<p>Этот <code>forever</code> метод может использоваться для постоянного хранения элемента в кэше. Поскольку срок
    действия этих элементов не истекает, их необходимо вручную удалить из кеша с помощью <code>forget</code> метода:</p>
<pre class=" language-php"><code class=" language-php">Cache<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">forever</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'key'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'value'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p> Если вы используете драйвер Memcached, элементы, которые хранятся «навсегда», могут быть удалены, когда кэш
            достигнет предельного размера.</p></p></div>
</blockquote>
<p></p>
<h3 id="removing-items-from-the-cache"><a href="#removing-items-from-the-cache">Удаление элементов из кеша</a></h3>
<p>Вы можете удалить элементы из кеша, используя <code>forget</code> метод:</p>
<pre class=" language-php"><code class=" language-php">Cache<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">forget</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'key'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы также можете удалить элементы, указав нулевое или отрицательное количество секунд истечения срока действия:</p>
<pre class=" language-php"><code class=" language-php">Cache<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">put</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'key'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'value'</span><span
                class="token punctuation">,</span> <span class="token number">0</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

Cache<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">put</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'key'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'value'</span><span class="token punctuation">,</span> <span
                class="token operator">-</span><span class="token number">5</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете очистить весь кеш, используя <code>flush</code> метод:</p>
<pre class=" language-php"><code class=" language-php">Cache<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">flush</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Очистка кеша не учитывает ваш настроенный «префикс» кеша и удаляет все записи из кеша. Внимательно учитывайте
            это при очистке кеша, который используется другими приложениями.</p></p></div>
</blockquote>
<p></p>
<h3 id="the-cache-helper"><a href="#the-cache-helper">Помощник кеша</a></h3>
<p>Помимо использования <code>Cache</code> фасада, вы также можете использовать глобальную <code>cache</code> функцию
    для извлечения и хранения данных через кеш. Когда <code>cache</code> функция вызывается с одним строковым
    аргументом, она возвращает значение данного ключа:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$value</span> <span
                class="token operator">=</span> <span class="token function">cache</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'key'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если вы предоставите массив пар ключ / значение и срок действия функции, она будет хранить значения в кеше в течение
    указанного времени:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">cache</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'key'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'value'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span> <span class="token variable">$seconds</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token function">cache</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'key'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'value'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span> <span class="token function">now</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">addMinutes</span><span
                class="token punctuation">(</span><span class="token number">10</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Когда <code>cache</code> функция вызывается без аргументов, она возвращает экземпляр <code>Illuminate\Contracts\Cache\Factory</code>
    реализации, позволяя вызывать другие методы кеширования:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">cache</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">remember</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">,</span> <span class="token variable">$seconds</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>При тестировании вызова глобальной <code>cache</code> функции вы можете использовать этот <code>Cache::shouldReceive</code>
            метод так же, как если бы вы <a href="mocking#mocking-facades">тестировали фасад</a>.</p></p></div>
</blockquote>
<p></p>
<h2 id="cache-tags"><a href="#cache-tags">Теги кеша</a></h2>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Теги кэша не поддерживаются при использовании <code>file</code> , <code>dynamodb</code> или
            <code>database</code> драйверы кэша. Кроме того, при использовании нескольких тегов с кешами, которые
            хранятся «навсегда», производительность будет лучше с драйвером, например <code>memcached</code> , который
            автоматически очищает устаревшие записи.</p></p></div>
</blockquote>
<p></p>
<h3 id="storing-tagged-cache-items"><a href="#storing-tagged-cache-items">Хранение отмеченных элементов кэша</a></h3>
<p>Теги кэша позволяют помечать связанные элементы в кеше, а затем сбрасывать все кэшированные значения, которым был
    назначен данный тег. Вы можете получить доступ к тегированному кешу, передав упорядоченный массив имен тегов.
    Например, давайте обратимся к тегированному кешу и <code>put</code> значению в кеше:</p>
<pre class=" language-php"><code class=" language-php">Cache<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">tags</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'people'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'artists'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">put</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'John'</span><span
                class="token punctuation">,</span> <span class="token variable">$john</span><span
                class="token punctuation">,</span> <span class="token variable">$seconds</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

Cache<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">tags</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'people'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'authors'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">put</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Anne'</span><span class="token punctuation">,</span> <span
                class="token variable">$anne</span><span class="token punctuation">,</span> <span
                class="token variable">$seconds</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="accessing-tagged-cache-items"><a href="#accessing-tagged-cache-items">Доступ к помеченным элементам кэша</a>
</h3>
<p>Чтобы получить помеченный элемент кеша, передайте в метод тот же упорядоченный список тегов, <code>tags</code> а
    затем вызовите <code>get</code> метод с ключом, который вы хотите получить:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$john</span> <span
                class="token operator">=</span> Cache<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">tags</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'people'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'artists'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'John'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$anne</span> <span class="token operator">=</span> Cache<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">tags</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'people'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'authors'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Anne'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="removing-tagged-cache-items"><a href="#removing-tagged-cache-items">Удаление отмеченных элементов кеша</a></h3>
<p>Вы можете удалить все элементы, которым назначен тег или список тегов. Например, это утверждение было бы удалить все
    кэша с меткой либо <code>people</code> , <code>authors</code> или оба. Итак, оба <code>Anne</code> и
    <code>John</code> будут удалены из кеша:</p>
<pre class=" language-php"><code class=" language-php">Cache<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">tags</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'people'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'authors'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">flush</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Напротив, этот оператор удалит только кешированные значения, отмеченные тегами <code>authors</code> , поэтому <code>Anne</code>
    будут удалены, но не <code>John</code>:</p>
<pre class=" language-php"><code class=" language-php">Cache<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">tags</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'authors'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">flush</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="atomic-locks"><a href="#atomic-locks">Атомные замки</a></h2>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Для того, чтобы использовать эту функцию, приложение должно быть с помощью <code>memcached</code> , <code>redis</code>
            , <code>dynamodb</code> , <code>database</code> , <code>file</code> , или <code>array</code> драйвер кэша в
            качестве драйвера по умолчанию кэша приложения. Кроме того, все серверы должны взаимодействовать с одним и
            тем же центральным сервером кэширования.</p></p></div>
</blockquote>
<p></p>
<h3 id="lock-driver-prerequisites"><a href="#lock-driver-prerequisites">Требования к драйверам</a></h3>
<p></p>
<h4 id="atomic-locks-prerequisites-database"><a href="#atomic-locks-prerequisites-database">База данных</a></h4>
<p>При использовании <code>database</code> драйвера кеша вам необходимо настроить таблицу, в которой будут храниться
    блокировки кеша вашего приложения. Вы найдете пример <code>Schema</code> объявления в таблице ниже:</p>
<pre class=" language-php"><code class=" language-php">Schema<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">create</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'cache_locks'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$table</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">string</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'key'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">primary</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">string</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'owner'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">integer</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'expiration'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="managing-locks"><a href="#managing-locks">Управление замками</a></h3>
<p>Атомарные блокировки позволяют управлять распределенными блокировками, не беспокоясь об условиях гонки. Например, <a
            href="https://forge.laravel.com">Laravel Forge</a> использует атомарные блокировки, чтобы гарантировать, что
    на сервере одновременно выполняется только одна удаленная задача. Вы можете создавать и управлять блокировками,
    используя <code>Cache::lock</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Cache</span><span
                class="token punctuation">;</span>

<span class="token variable">$lock</span> <span class="token operator">=</span> Cache<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">lock</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'foo'</span><span
                class="token punctuation">,</span> <span class="token number">10</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">if</span> <span class="token punctuation">(</span><span
                class="token variable">$lock</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// Lock acquired for 10 seconds...</span>
            
    <span class="token variable">$lock</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">release</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p><code>get</code> Метод также принимает замыкание. После выполнения закрытия Laravel автоматически снимет блокировку:
</p>
<pre class=" language-php"><code class=" language-php">Cache<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">lock</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'foo'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// Lock acquired indefinitely and automatically released...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Если блокировка недоступна в тот момент, когда вы ее запрашиваете, вы можете указать Laravel подождать определенное
    количество секунд. Если блокировка не может быть получена в течение указанного срока, <code>Illuminate\Contracts\Cache\LockTimeoutException</code>
    будет выдан:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                    class="token punctuation">\</span>Cache<span class="token punctuation">\</span>LockTimeoutException</span><span
                class="token punctuation">;</span>

<span class="token variable">$lock</span> <span class="token operator">=</span> Cache<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">lock</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'foo'</span><span
                class="token punctuation">,</span> <span class="token number">10</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">try</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$lock</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">block</span><span class="token punctuation">(</span><span
                class="token number">5</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
            
    <span class="token comment">// Lock acquired after waiting a maximum of 5 seconds...</span>
<span class="token punctuation">}</span> <span class="token keyword">catch</span> <span
                class="token punctuation">(</span>LockTimeoutException <span class="token variable">$e</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// Unable to acquire lock...</span>
<span class="token punctuation">}</span> <span class="token keyword">finally</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token function">optional</span><span class="token punctuation">(</span><span
                class="token variable">$lock</span><span class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">release</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Приведенный выше пример можно упростить, передав закрытие <code>block</code> метода. Когда закрытие передается этому
    методу, Laravel будет пытаться получить блокировку на указанное количество секунд и автоматически снимет блокировку,
    как только закрытие будет выполнено:</p>
<pre class=" language-php"><code class=" language-php">Cache<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">lock</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'foo'</span><span
                class="token punctuation">,</span> <span class="token number">10</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">block</span><span
                class="token punctuation">(</span><span class="token number">5</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// Lock acquired after waiting a maximum of 5 seconds...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="managing-locks-across-processes"><a href="#managing-locks-across-processes">Управление блокировками между
        процессами</a></h3>
<p>Иногда может потребоваться установить блокировку в одном процессе и снять ее в другом процессе. Например, вы можете
    установить блокировку во время веб-запроса и захотеть снять блокировку в конце задания в очереди, которое
    запускается этим запросом. В этом сценарии вы должны передать «токен владельца» с областью действия блокировки в
    задание в очереди, чтобы задание могло повторно создать экземпляр блокировки с использованием данного токена.</p>
<p>В приведенном ниже примере мы отправим задание в очередь, если блокировка будет успешно получена. Кроме того, мы
    передадим токен владельца блокировки заданию в очереди с помощью <code>owner</code> метода блокировки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$podcast</span> <span
                class="token operator">=</span> Podcast<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token variable">$id</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$lock</span> <span class="token operator">=</span> Cache<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">lock</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'processing'</span><span
                class="token punctuation">,</span> <span class="token number">120</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token keyword">if</span> <span class="token punctuation">(</span><span
                class="token variable">$result</span> <span class="token operator">=</span> <span
                class="token variable">$lock</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    ProcessPodcast<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">dispatch</span><span class="token punctuation">(</span><span
                class="token variable">$podcast</span><span class="token punctuation">,</span> <span
                class="token variable">$lock</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">owner</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>В рамках работы нашего приложения <code>ProcessPodcast</code> мы можем восстановить и снять блокировку с помощью
    токена владельца:</p>
<pre class=" language-php"><code class=" language-php">Cache<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">restoreLock</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'processing'</span><span
                class="token punctuation">,</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">owner</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">release</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Если вы хотите снять блокировку, не уважая ее текущего владельца, вы можете использовать <code>forceRelease</code>
    метод:</p>
<pre class=" language-php"><code class=" language-php">Cache<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">lock</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'processing'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">forceRelease</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="adding-custom-cache-drivers"><a href="#adding-custom-cache-drivers">Добавление собственных драйверов кэша</a>
</h2>
<p></p>
<h3 id="writing-the-driver"><a href="#writing-the-driver">Написание драйвера</a></h3>
<p>Чтобы создать наш собственный драйвер кеша, нам сначала нужно реализовать
    <code>Illuminate\Contracts\Cache\Store</code> <a href="contracts">контракт</a>. Итак, реализация кеша MongoDB может
    выглядеть примерно так:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Extensions</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Cache<span class="token punctuation">\</span>Store</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">MongoStore</span> <span class="token keyword">implements</span> <span
                    class="token class-name">Store</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">get</span><span
                    class="token punctuation">(</span><span class="token variable">$key</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span><span
                    class="token punctuation">}</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">many</span><span
                    class="token punctuation">(</span><span class="token keyword">array</span> <span
                    class="token variable">$keys</span><span class="token punctuation">)</span> <span
                    class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">}</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">put</span><span
                    class="token punctuation">(</span><span class="token variable">$key</span><span
                    class="token punctuation">,</span> <span class="token variable">$value</span><span
                    class="token punctuation">,</span> <span class="token variable">$seconds</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span><span
                    class="token punctuation">}</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">putMany</span><span
                    class="token punctuation">(</span><span class="token keyword">array</span> <span
                    class="token variable">$values</span><span class="token punctuation">,</span> <span
                    class="token variable">$seconds</span><span class="token punctuation">)</span> <span
                    class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">}</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">increment</span><span
                    class="token punctuation">(</span><span class="token variable">$key</span><span
                    class="token punctuation">,</span> <span class="token variable">$value</span> <span
                    class="token operator">=</span> <span class="token number">1</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span><span
                    class="token punctuation">}</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">decrement</span><span
                    class="token punctuation">(</span><span class="token variable">$key</span><span
                    class="token punctuation">,</span> <span class="token variable">$value</span> <span
                    class="token operator">=</span> <span class="token number">1</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span><span
                    class="token punctuation">}</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">forever</span><span
                    class="token punctuation">(</span><span class="token variable">$key</span><span
                    class="token punctuation">,</span> <span class="token variable">$value</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span><span
                    class="token punctuation">}</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">forget</span><span
                    class="token punctuation">(</span><span class="token variable">$key</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span><span
                    class="token punctuation">}</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">flush</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span> <span
                    class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">}</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">getPrefix</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span> <span
                    class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Нам просто нужно реализовать каждый из этих методов, используя соединение MongoDB. Для примера того, как реализовать
    каждый из этих методов, возьмите взгляд на <code>Illuminate\Cache\MemcachedStore</code> в <a
            href="https://github.com/laravel/framework">рамках исходного кода Laravel</a>. Как только наша реализация
    будет завершена, мы можем завершить регистрацию настраиваемого драйвера, вызвав метод <code>Cache</code> фасада
    <code>extend</code>:</p>
<pre class=" language-php"><code class=" language-php">Cache<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">extend</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'mongo'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$app</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> Cache<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">repository</span><span
                class="token punctuation">(</span><span class="token keyword">new</span> <span class="token class-name">MongoStore</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Если вам интересно, где разместить собственный код драйвера кеша, вы можете создать <code>Extensions</code>
            пространство имен в своем <code>app</code> каталоге. Однако имейте в виду, что Laravel не имеет жесткой
            структуры приложения, и вы можете организовать свое приложение в соответствии со своими предпочтениями.
        </p></p></div>
</blockquote>
<p></p>
<h3 id="registering-the-driver"><a href="#registering-the-driver">Регистрация драйвера</a></h3>
<p>Чтобы зарегистрировать собственный драйвер кеша в Laravel, мы будем использовать <code>extend</code> метод <code>Cache</code>
    фасада. Поскольку другие поставщики услуг могут попытаться прочитать кешированные значения в своем <code>boot</code>
    методе, мы зарегистрируем наш настраиваемый драйвер в <code>booting</code> обратном вызове. Используя
    <code>booting</code> обратный вызов, мы можем гарантировать, что настраиваемый драйвер зарегистрирован
    непосредственно перед вызовом <code>boot</code> метода поставщиками услуг нашего приложения, но после того, как
    <code>register</code> метод вызывается всеми поставщиками услуг. Мы зарегистрируем наш <code>booting</code> обратный
    вызов в <code>register</code> методе класса нашего приложения <code>App\Providers\AppServiceProvider</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Providers</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Extensions<span
                        class="token punctuation">\</span>MongoStore</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Cache</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>ServiceProvider</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">CacheServiceProvider</span> <span
                    class="token keyword">extends</span> <span class="token class-name">ServiceProvider</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Register any application services.
    *
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">register</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token property">app</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">booting</span><span
                    class="token punctuation">(</span><span class="token keyword">function</span> <span
                    class="token punctuation">(</span><span class="token punctuation">)</span> <span
                    class="token punctuation">{literal}{{/literal}</span>
            Cache<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">extend</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'mongo'</span><span
                    class="token punctuation">,</span> <span class="token keyword">function</span> <span
                    class="token punctuation">(</span><span class="token variable">$app</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
                <span class="token keyword">return</span> Cache<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token function">repository</span><span
                    class="token punctuation">(</span><span class="token keyword">new</span> <span
                    class="token class-name">MongoStore</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
    * Bootstrap any application services.
    *
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">boot</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Первым аргументом, передаваемым <code>extend</code> методу, является имя драйвера. Это будет соответствовать вашей
    <code>driver</code> опции в <code>config/cache.php</code> файле конфигурации. Второй аргумент - это замыкание,
    которое должно возвращать <code>Illuminate\Cache\Repository</code> экземпляр. Замыканию будет передан
    <code>$app</code> экземпляр, который является экземпляром <a href="container">контейнера службы</a>.</p>
<p>После регистрации расширения обновите <code>config/cache.php</code> параметр файла конфигурации, <code>driver</code>
    указав имя своего расширения.</p>
<p></p>
<h2 id="events"><a href="#events">События</a></h2>
<p>Чтобы выполнить код для каждой операции с кешем, вы можете прослушивать <a href="events">события,</a> запускаемые
    кешем. Как правило, вы должны поместить эти прослушиватели событий в <code>App\Providers\EventServiceProvider</code>
    класс вашего приложения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * The event listener mappings for the application.
 *
 * @var array
 */</span>
<span class="token keyword">protected</span> <span class="token variable">$listen</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'Illuminate\Cache\Events\CacheHit'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'App\Listeners\LogCacheHit'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>

    <span class="token single-quoted-string string">'Illuminate\Cache\Events\CacheMissed'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'App\Listeners\LogCacheMissed'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>

    <span class="token single-quoted-string string">'Illuminate\Cache\Events\KeyForgotten'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'App\Listeners\LogKeyForgotten'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>

    <span class="token single-quoted-string string">'Illuminate\Cache\Events\KeyWritten'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'App\Listeners\LogKeyWritten'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">;</span></code></pre> 
