<h1>HTTP-сессия</h1>
<ul>
    <li><a href="session#introduction">Вступление</a>
        <ul>
            <li><a href="session#configuration">Конфигурация</a></li>
            <li><a href="session#driver-prerequisites">Требования к драйверам</a></li>
        </ul>
    </li>
    <li><a href="session#interacting-with-the-session">Взаимодействие с сеансом</a>
        <ul>
            <li><a href="session#retrieving-data">Получение данных</a></li>
            <li><a href="session#storing-data">Хранение данных</a></li>
            <li><a href="session#flash-data">Флэш-данные</a></li>
            <li><a href="session#deleting-data">Удаление данных</a></li>
            <li><a href="session#regenerating-the-session-id">Восстановление идентификатора сеанса</a></li>
        </ul>
    </li>
    <li><a href="session#session-blocking">Блокировка сеанса</a></li>
    <li><a href="session#adding-custom-session-drivers">Добавление собственных драйверов сеанса</a>
        <ul>
            <li><a href="session#implementing-the-driver">Реализация драйвера</a></li>
            <li><a href="session#registering-the-driver">Регистрация драйвера</a></li>
        </ul>
    </li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Поскольку приложения, управляемые HTTP, не имеют состояния, сеансы предоставляют способ хранения информации о
    пользователе в нескольких запросах. Эта пользовательская информация обычно помещается в постоянное хранилище /
    бэкэнд, к которому можно получить доступ из последующих запросов.</p>
<p>Laravel поставляется с множеством бэкэндов сеансов, доступ к которым осуществляется через выразительный
    унифицированный API. Включена поддержка популярных серверных программ, таких как <a
            href="hhttps://memcached.org">Memcached</a>,
    <a href="hhttps://redis.io">Redis</a> и
    баз данных.</p>
<p></p>
<h3 id="configuration"><a href="#configuration">Конфигурация</a></h3>
<p>Файл конфигурации сеанса вашего приложения хранится по адресу <code>config/session.php</code>. Обязательно
    просмотрите варианты, доступные вам в этом файле. По умолчанию Laravel настроен на использование <code>file</code>
    драйвера сеанса, который хорошо работает для многих приложений. Если ваше приложение будет балансировать нагрузку на
    нескольких веб-серверах, вам следует выбрать централизованное хранилище, к которому могут получить доступ все
    серверы, например Redis или база данных.</p>
<p>Параметр <code>driver</code> конфигурации сеанса определяет, где будут храниться данные сеанса для каждого запроса.
    Laravel поставляется с несколькими отличными драйверами из коробки:</p>
<div class="content-list">
    <ul>
        <li><code>file</code> - сеансы хранятся в <code>storage/framework/sessions</code>.</li>
        <li><code>cookie</code> - сеансы хранятся в безопасных зашифрованных файлах cookie.</li>
        <li><code>database</code> - сеансы хранятся в реляционной базе данных.</li>
        <li><code>memcached</code> / <code>redis</code> - сеансы хранятся в одном из этих быстрых хранилищ на основе
            кеша.
        </li>
        <li><code>dynamodb</code> - сеансы хранятся в AWS DynamoDB.</li>
        <li><code>array</code> - сеансы хранятся в массиве PHP и не сохраняются.</li>
    </ul>
</div>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Драйвер массива в основном используется во время <a href="testing">тестирования</a> и предотвращает
            сохранение данных, хранящихся в сеансе.</p></p></div>
</blockquote>
<p></p>
<h3 id="driver-prerequisites"><a href="#driver-prerequisites">Требования к драйверам</a></h3>
<p></p>
<h4 id="database"><a href="#database">База данных</a></h4>
<p>При использовании <code>database</code> драйвера сеанса вам нужно будет создать таблицу, содержащую записи сеанса.
    Пример <code>Schema</code> объявления для таблицы можно найти ниже:</p>
<pre class=" language-php"><code class=" language-php">Schema<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'sessions'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$table</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">string</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'id'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">primary</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">foreignId</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'user_id'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">nullable</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">index</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">string</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'ip_address'</span><span
                class="token punctuation">,</span> <span class="token number">45</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">nullable</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">text</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'user_agent'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">nullable</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">text</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'payload'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">integer</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'last_activity'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">index</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы можете использовать команду <code>session:table</code> Artisan для создания этой миграции. Чтобы узнать больше о
    миграции базы данных, вы можете обратиться к полной <a href="migrations">документации по миграции</a> :</p>
<pre class=" language-php"><code class=" language-php">php artisan session<span class="token punctuation">:</span>table

php artisan migrate</code></pre>
<p></p>
<h4 id="redis"><a href="#redis">Redis</a></h4>
<p>Перед использованием сеансов Redis с Laravel вам нужно будет либо установить расширение PHP PhpRedis через PECL, либо
    установить <code>predis/predis</code> пакет (~ 1.0) через Composer. Для получения дополнительной информации о
    настройке Redis обратитесь к <a href="redis#configuration">документации Redis</a> Laravel.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>В <code>session</code> файле конфигурации этот <code>connection</code> параметр может использоваться, чтобы
            указать, какое соединение Redis используется сеансом.</p></p></div>
</blockquote>
<p></p>
<h2 id="interacting-with-the-session"><a href="#interacting-with-the-session">Взаимодействие с сеансом</a></h2>
<p></p>
<h3 id="retrieving-data"><a href="#retrieving-data">Получение данных</a></h3>
<p>В Laravel есть два основных способа работы с данными сеанса: глобальный <code>session</code> помощник и через <code>Request</code>
    экземпляр. Во-первых, давайте посмотрим на доступ к сеансу через <code>Request</code> экземпляр, который может иметь
    типовые подсказки для закрытия маршрута или метода контроллера. Помните, что зависимости методов контроллера
    автоматически вводятся через <a href="container">сервисный контейнер</a> Laravel :</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>Controller</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">UserController</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Show the profile for the given user.
    *
    * @param  Request  $request
    * @param  int  $id
    * @return Response
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">show</span><span
                    class="token punctuation">(</span>Request <span class="token variable">$request</span><span
                    class="token punctuation">,</span> <span class="token variable">$id</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$value</span> <span class="token operator">=</span> <span class="token variable">$request</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">session</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">get</span><span
                    class="token punctuation">(</span><span class="token single-quoted-string string">'key'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token comment">//</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Когда вы извлекаете элемент из сеанса, вы также можете передать значение по умолчанию в качестве второго аргумента
    <code>get</code> метода. Это значение по умолчанию будет возвращено, если указанный ключ не существует в сеансе.
    Если вы передаете закрытие в качестве значения по умолчанию для <code>get</code> метода, а запрошенный ключ не
    существует, закрытие будет выполнено, и его результат будет возвращен:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$value</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">session</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'key'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'default'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$value</span> <span class="token operator">=</span> <span
                class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">session</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'key'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span
                class="token single-quoted-string string">'default'</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="the-global-session-helper"><a href="#the-global-session-helper">Помощник глобальной сессии</a></h4>
<p>Вы также можете использовать глобальную <code>session</code> функцию PHP для получения и сохранения данных в сеансе.
    Когда <code>session</code> помощник вызывается с одним строковым аргументом, он возвращает значение этого сеансового
    ключа. Когда помощник вызывается с массивом пар ключ / значение, эти значения будут сохранены в сеансе:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/home'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// Retrieve a piece of data from the session...</span>
    <span class="token variable">$value</span> <span class="token operator">=</span> <span
                class="token function">session</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'key'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
            
    <span class="token comment">// Specifying a default value...</span>
    <span class="token variable">$value</span> <span class="token operator">=</span> <span
                class="token function">session</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'key'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'default'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
            
    <span class="token comment">// Store a piece of data in the session...</span>
    <span class="token function">session</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'key'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'value'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Практическая разница между использованием сеанса через экземпляр HTTP-запроса и использованием глобального
            <code>session</code> помощника невелика. Оба метода можно <a href="testing">протестировать с</a> помощью
            <code>assertSessionHas</code> метода, который доступен во всех ваших тестовых примерах.</p></p></div>
</blockquote>
<p></p>
<h4 id="retrieving-all-session-data"><a href="#retrieving-all-session-data">Получение всех данных сеанса</a></h4>
<p>Если вы хотите получить все данные в сеансе, вы можете использовать <code>all</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$data</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">session</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="determining-if-an-item-exists-in-the-session"><a href="#determining-if-an-item-exists-in-the-session">Определение
        наличия элемента в сеансе</a></h4>
<p>Чтобы определить, присутствует ли элемент в сеансе, вы можете использовать этот <code>has</code> метод.
    <code>has</code> Метод возвращает, <code>true</code> если элемент присутствует и не <code>null</code> :</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">if</span> <span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">session</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">has</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'users'</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p>Чтобы определить, присутствует ли элемент в сеансе, даже если его значение есть <code>null</code>, вы можете
    использовать <code>exists</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">if</span> <span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">session</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">exists</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="storing-data"><a href="#storing-data">Хранение данных</a></h3>
<p>Для хранения данных в сеансе вы обычно будете использовать метод экземпляра запроса <code>put</code> или <code>session</code>
    помощник:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">// Via a request instance...</span>
<span class="token variable">$request</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">session</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">put</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'key'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'value'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// Via the global "session" helper...</span>
<span class="token function">session</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'key'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'value'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="pushing-to-array-session-values"><a href="#pushing-to-array-session-values">Отправка значений сеанса в
        массив</a></h4>
<p>Этот <code>push</code> метод может использоваться для вставки нового значения в значение сеанса, которое является
    массивом. Например, если <code>user.teams</code> ключ содержит массив названий команд, вы можете поместить новое
    значение в массив следующим образом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">session</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">push</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'user.teams'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'developers'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="retrieving-deleting-an-item"><a href="#retrieving-deleting-an-item">Получение и удаление элемента</a></h4>
<p><code>pull</code> Метод извлечения и удаления элемента из сессии в одном заявлении:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$value</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">session</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">pull</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'key'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'default'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="#incrementing-and-decrementing-session-values"><a href="##incrementing-and-decrementing-session-values">Увеличение
        и уменьшение значений сеанса</a></h4>
<p>Если данные сеанса содержит целое число вы хотите увеличения или уменьшения значения, вы можете использовать <code>increment</code>
    и <code>decrement</code> методы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">session</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">increment</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'count'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$request</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">session</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">increment</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'count'</span><span
                class="token punctuation">,</span> <span class="token variable">$incrementBy</span> <span
                class="token operator">=</span> <span class="token number">2</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$request</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">session</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">decrement</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'count'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$request</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">session</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">decrement</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'count'</span><span
                class="token punctuation">,</span> <span class="token variable">$decrementBy</span> <span
                class="token operator">=</span> <span class="token number">2</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="flash-data"><a href="#flash-data">Флэш-данные</a></h3>
<p>Иногда вы можете захотеть сохранить элементы в сеансе для следующего запроса. Вы можете сделать это с помощью <code>flash</code>
    метода. Данные, хранящиеся в сеансе с использованием этого метода, будут доступны немедленно и во время последующего
    HTTP-запроса. После последующего HTTP-запроса данные будут удалены. Flash-данные в первую очередь полезны для
    краткосрочных статусных сообщений:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">session</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">flash</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'status'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'Task was successful!'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если вам нужно сохранить флэш-данные для нескольких запросов, вы можете использовать <code>reflash</code> метод,
    который сохранит все флэш-данные для дополнительного запроса. Если вам нужно сохранить только определенные
    флэш-данные, вы можете использовать <code>keep</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">session</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">reflash</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$request</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">session</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">keep</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'username'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'email'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Чтобы сохранить флэш-данные только для текущего запроса, вы можете использовать <code>now</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">session</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">now</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'status'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Task was successful!'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="deleting-data"><a href="#deleting-data">Удаление данных</a></h3>
<p><code>forget</code> Метод будет удалить часть данных из сеанса. Если вы хотите удалить все данные из сеанса, вы
    можете использовать <code>flush</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">// Forget a single key...</span>
<span class="token variable">$request</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">session</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">forget</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// Forget multiple keys...</span>
<span class="token variable">$request</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">session</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">forget</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'name'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'status'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$request</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">session</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">flush</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="regenerating-the-session-id"><a href="#regenerating-the-session-id">Восстановление идентификатора сеанса</a>
</h3>
<p>Регенерация идентификатора сеанса часто выполняется для предотвращения использования злоумышленниками атаки <a
            href="hhttps://owasp.org/www-community/attacks/Session_fixation">фиксации
        сеанса</a> на ваше приложение.</p>
<p>Laravel автоматически восстанавливает идентификатор сеанса во время аутентификации, если вы используете один из <a
            href="starter-kits">стартовых наборов приложений </a><a href="fortify">Laravel</a> или <a href="fortify">Laravel
        Fortify</a> ; однако, если вам нужно вручную повторно создать идентификатор сеанса, вы можете использовать
    <code>regenerate</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">session</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">regenerate</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Если вам нужно повторно сгенерировать идентификатор сеанса и удалить все данные из сеанса одним оператором, вы можете
    использовать <code>invalidate</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">session</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">invalidate</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="session-blocking"><a href="#session-blocking">Блокировка сеанса</a></h2>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Чтобы использовать блокировку сеанса, ваше приложение должно использовать драйвер кеша, поддерживающий <a
                    href="cache#atomic-locks">атомарные блокировки</a>. В настоящее время эти драйверы кэш включают
            <code>memcached</code>, <code>dynamodb</code>, <code>redis</code> и <code>database</code> водителей. Кроме
            того, вы не можете использовать <code>cookie</code> драйвер сеанса.</p></p></div>
</blockquote>
<p>По умолчанию Laravel позволяет запросам, использующим один и тот же сеанс, выполняться одновременно. Так, например,
    если вы используете HTTP-библиотеку JavaScript для выполнения двух HTTP-запросов к вашему приложению, они оба будут
    выполняться одновременно. Для многих приложений это не проблема; однако потеря данных сеанса может произойти в
    небольшом подмножестве приложений, которые выполняют одновременные запросы к двум разным конечным точкам приложений,
    которые записывают данные в сеанс.</p>
<p>Чтобы смягчить это, Laravel предоставляет функциональность, которая позволяет ограничивать количество одновременных
    запросов для данного сеанса. Для начала вы можете просто привязать <code>block</code> метод к определению маршрута.
    В этом примере входящий запрос к <code>/profile</code> конечной точке получит блокировку сеанса. Пока эта блокировка
    удерживается, любые входящие запросы к конечным точкам <code>/profile</code> или, <code>/order</code> которые
    используют один и тот же идентификатор сеанса, будут ждать завершения выполнения первого запроса, прежде чем
    продолжить свое выполнение:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">post</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/profile'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">block</span><span
                class="token punctuation">(</span><span class="token variable">$lockSeconds</span> <span
                class="token operator">=</span> <span class="token number">10</span><span
                class="token punctuation">,</span> <span class="token variable">$waitSeconds</span> <span
                class="token operator">=</span> <span class="token number">10</span><span
                class="token punctuation">)</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">post</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/order'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">block</span><span
                class="token punctuation">(</span><span class="token variable">$lockSeconds</span> <span
                class="token operator">=</span> <span class="token number">10</span><span
                class="token punctuation">,</span> <span class="token variable">$waitSeconds</span> <span
                class="token operator">=</span> <span class="token number">10</span><span
                class="token punctuation">)</span></code></pre>
<p><code>block</code> Метод принимает два необязательных аргумента. Первый аргумент, принимаемый <code>block</code>
    методом, - это максимальное количество секунд, в течение которых блокировка сеанса должна удерживаться, прежде чем
    она будет снята. Конечно, если выполнение запроса завершится до этого времени, блокировка будет снята раньше.</p>
<p>Второй аргумент, принимаемый <code>block</code> методом, - это количество секунд, в течение которых запрос должен
    ждать при попытке получить блокировку сеанса. <code>Illuminate\Contracts\Cache\LockTimeoutException</code> Будет
    сгенерировано, если запрос не может получить блокировку сеанса в течение заданного количества секунд.</p>
<p>Если ни один из этих аргументов не передан, блокировка будет получена максимум на 10 секунд, а запросы будут ждать
    максимум 10 секунд при попытке получить блокировку:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">post</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/profile'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">block</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span></code></pre>
<p></p>
<h2 id="adding-custom-session-drivers"><a href="#adding-custom-session-drivers">Добавление собственных драйверов
        сеанса</a></h2>
<p></p>
<h4 id="implementing-the-driver"><a href="#implementing-the-driver">Реализация драйвера</a></h4>
<p>Если ни один из существующих драйверов сеанса не соответствует потребностям вашего приложения, Laravel позволяет
    написать собственный обработчик сеанса. Ваш настраиваемый драйвер сеанса должен реализовывать встроенный PHP <code>SessionHandlerInterface</code>.
    Этот интерфейс содержит всего несколько простых методов. Замешанная реализация MongoDB выглядит следующим образом:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Extensions</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">MongoSessionHandler</span> <span
                    class="token keyword">implements</span> <span class="token class-name"><span
                        class="token punctuation">\</span>SessionHandlerInterface</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">open</span><span
                    class="token punctuation">(</span><span class="token variable">$savePath</span><span
                    class="token punctuation">,</span> <span class="token variable">$sessionName</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span><span
                    class="token punctuation">}</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">close</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span> <span
                    class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">}</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">read</span><span
                    class="token punctuation">(</span><span class="token variable">$sessionId</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span><span
                    class="token punctuation">}</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">write</span><span
                    class="token punctuation">(</span><span class="token variable">$sessionId</span><span
                    class="token punctuation">,</span> <span class="token variable">$data</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span><span
                    class="token punctuation">}</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">destroy</span><span
                    class="token punctuation">(</span><span class="token variable">$sessionId</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span><span
                    class="token punctuation">}</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">gc</span><span
                    class="token punctuation">(</span><span class="token variable">$lifetime</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span><span
                    class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Laravel не поставляется с каталогом для хранения ваших расширений. Вы можете разместить их где угодно. В этом
            примере мы создали <code>Extensions</code> каталог для размещения <code>MongoSessionHandler</code>.</p></p>
    </div>
</blockquote>
<p>Поскольку цель этих методов не совсем понятна, давайте быстро рассмотрим, что делает каждый из методов:</p>
<div class="content-list">
    <ul>
        <li>Этот <code>open</code> метод обычно используется в файловых системах хранения сеансов. Поскольку Laravel
            поставляется с <code>file</code> драйвером сеанса, вам редко понадобится что-либо помещать в этот метод. Вы
            можете просто оставить этот метод пустым.
        </li>
        <li><code>close</code> Метод, как <code>open</code> метод, можно также, как правило, можно пренебречь. Для
            большинства драйверов в этом нет необходимости.
        </li>
        <li><code>read</code> Метод должен возвращать версию строки данных сеанса, связанные с данными
            <code>$sessionId</code>. Нет необходимости выполнять сериализацию или другое кодирование при извлечении или
            сохранении данных сеанса в вашем драйвере, поскольку Laravel выполнит сериализацию за вас.
        </li>
        <li><code>write</code> Метод должен написать данную <code>$data</code> строку, связанную с
            <code>$sessionId</code> какой - то постоянной системы хранения, такие как MongoDB или другую систему
            хранения вашего выбора. Опять же, вам не следует выполнять сериализацию - Laravel уже сделает это за вас.
        </li>
        <li><code>destroy</code> Метод должен удалить данные, связанные с <code>$sessionId</code> от постоянного
            хранения.
        </li>
        <li>Этот <code>gc</code> метод должен уничтожить все данные сеанса, которые старше, чем заданная
            <code>$lifetime</code> временная метка UNIX. Для самоуничтожающихся систем, таких как Memcached и Redis,
            этот метод можно оставить пустым.
        </li>
    </ul>
</div>
<p></p>
<h4 id="registering-the-driver"><a href="#registering-the-driver">Регистрация драйвера</a></h4>
<p>Как только ваш драйвер будет реализован, вы готовы зарегистрировать его в Laravel. Чтобы добавить дополнительные
    драйверы в серверную часть сеанса Laravel, вы можете использовать <code>extend</code> метод, предоставляемый <code>Session</code>
    <a href="facades">фасадом</a>. Вы должны вызвать <code>extend</code> метод из <code>boot</code> метода <a
            href="providers">поставщика услуг</a>. Вы можете сделать это из существующего <code>App\Providers\AppServiceProvider</code>
    или создать совершенно нового провайдера:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Providers</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Extensions<span
                        class="token punctuation">\</span>MongoSessionHandler</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Session</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>ServiceProvider</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">SessionServiceProvider</span> <span
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
        <span class="token comment">//</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
    * Bootstrap any application services.
    *
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">boot</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        Session<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">extend</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'mongo'</span><span
                    class="token punctuation">,</span> <span class="token keyword">function</span> <span
                    class="token punctuation">(</span><span class="token variable">$app</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">// Return an implementation of SessionHandlerInterface...</span>
            <span class="token keyword">return</span> <span class="token keyword">new</span> <span class="token class-name">MongoSessionHandler</span><span
                    class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>После регистрации драйвера сеанса вы можете использовать его <code>mongo</code> в <code>config/session.php</code>
    файле конфигурации.</p>
