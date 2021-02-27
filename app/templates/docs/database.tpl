<h1>БД: начало работы <sup>Getting started</sup></h1>
<ul>
    <li><a href="database#introduction">Вступление</a>
        <ul>
            <li><a href="database#configuration">Конфигурация</a></li>
            <li><a href="database#read-and-write-connections">Чтение и запись соединений</a></li>
        </ul>
    </li>
    <li><a href="database#running-queries">Выполнение SQL-запросов</a>
        <ul>
            <li><a href="database#using-multiple-database-connections">Использование нескольких подключений к базе
                    данных</a></li>
            <li><a href="database#listening-for-query-events">Прослушивание событий запроса</a></li>
        </ul>
    </li>
    <li><a href="database#database-transactions">Транзакции базы данных</a></li>
    <li><a href="database#connecting-to-the-database-cli">Подключение к интерфейсу командной строки базы данных</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Почти каждое современное веб-приложение взаимодействует с базой данных. Laravel делает взаимодействие с базами данных
    чрезвычайно простым через множество поддерживаемых баз данных, используя необработанный SQL, <a href="queries">свободный
        конструктор запросов</a> и <a href="eloquent">Eloquent ORM</a>. В настоящее время Laravel обеспечивает поддержку
    четырех баз данных:</p>
<div class="content-list">
    <ul>
        <li>MySQL 5.7+ ( <a href="https://en.wikipedia.org/wiki/MySQL%23Release_history">Политика версий</a> )</li>
        <li>PostgreSQL 9.6+ ( <a href="https://www.postgresql.org/support/versioning/">Политика версий</a> )</li>
        <li>SQLite 3.8.8+</li>
        <li>SQL Server 2017+ ( <a href="https://support.microsoft.com/en-us/lifecycle/search">политика версий</a> )</li>
    </ul>
</div>
<p></p>
<h3 id="configuration"><a href="#configuration">Конфигурация</a></h3>
<p>Конфигурация служб базы данных Laravel находится в <code>config/database.php</code> файле конфигурации вашего
    приложения. В этом файле вы можете определить все соединения с базой данных, а также указать, какое соединение
    должно использоваться по умолчанию. Большинство параметров конфигурации в этом файле определяется значениями
    переменных среды вашего приложения. В этом файле представлены примеры для большинства поддерживаемых Laravel систем
    баз данных.</p>
<p>По умолчанию образец <a href="configuration#environment-configuration">конфигурации среды</a> Laravel готов к
    использованию с <a href="sail">Laravel Sail</a>, который представляет собой конфигурацию Docker для разработки
    приложений Laravel на вашем локальном компьютере. Однако вы можете изменить конфигурацию своей базы данных по мере
    необходимости для своей локальной базы данных.</p>
<p></p>
<h4 id="sqlite-configuration"><a href="#sqlite-configuration">Конфигурация SQLite</a></h4>
<p>Базы данных SQLite содержатся в одном файле в вашей файловой системе. Вы можете создать новую базу данных SQLite,
    используя <code>touch</code> команду в терминале: <code>touch database/database.sqlite</code>. После создания базы
    данных вы можете легко настроить переменные среды так, чтобы они указывали на эту базу данных, указав абсолютный
    путь к базе данных в <code>DB_DATABASE</code> переменной среды:</p>
<pre class=" language-php"><code class=" language-php"><span class="token constant">DB_CONNECTION</span><span
                class="token operator">=</span>sqlite
<span class="token constant">DB_DATABASE</span><span class="token operator">=</span><span
                class="token operator">/</span>absolute<span class="token operator">/</span>path<span
                class="token operator">/</span>to<span class="token operator">/</span>database<span
                class="token punctuation">.</span>sqlite</code></pre>
<p>Чтобы включить ограничения внешнего ключа для соединений SQLite, вы должны установить для
    <code>DB_FOREIGN_KEYS</code> переменной среды значение <code>true</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token constant">DB_FOREIGN_KEYS</span><span
                class="token operator">=</span><span class="token boolean constant">true</span></code></pre>
<p></p>
<h4 id="mssql-configuration"><a href="#mssql-configuration">Конфигурация Microsoft SQL Server</a></h4>
<p>Чтобы использовать базу данных Microsoft SQL Server, вы должны убедиться, что у вас установлены расширения <code>sqlsrv</code>
    и <code>pdo_sqlsrv</code> PHP, а также все зависимости, которые могут потребоваться, такие как драйвер Microsoft SQL
    ODBC.</p>
<p></p>
<h4 id="configuration-using-urls"><a href="#configuration-using-urls">Конфигурация с использованием URL-адресов</a></h4>
<p>Как правило, соединение с базой данных сконфигурированы с использованием нескольких значений конфигурации, такие как
    <code>host</code>, <code>database</code>, <code>username</code>, <code>password</code> и т.д. Каждый из этих
    значений конфигурации имеет свои собственные соответствующие переменные среды. Это означает, что при настройке
    информации о подключении к базе данных на производственном сервере вам необходимо управлять несколькими переменными
    среды.</p>
<p>Некоторые поставщики управляемых баз данных, такие как AWS и Heroku, предоставляют единый «URL» базы данных, который
    содержит всю информацию о подключении к базе данных в одной строке. Пример URL-адреса базы данных может выглядеть
    примерно так:</p>
<pre class=" language-html"><code
            class=" language-html">mysql://root:password@127.0.0.1/forge?charset=UTF-8</code></pre>
<p>Эти URL-адреса обычно следуют стандартному соглашению о схеме:</p>
<pre class=" language-html"><code
            class=" language-html">driver://username:password@host:port/database?options</code></pre>
<p>Для удобства Laravel поддерживает эти URL-адреса в качестве альтернативы настройке базы данных с несколькими
    параметрами конфигурации. Если присутствует параметр конфигурации <code>url</code> (или соответствующая <code>DATABASE_URL</code>
    переменная среды), он будет использоваться для извлечения информации о подключении к базе данных и учетных данных.
</p>
<p></p>
<h3 id="read-and-write-connections"><a href="#read-and-write-connections">Чтение и запись соединений</a></h3>
<p>Иногда вы можете использовать одно соединение с базой данных для операторов SELECT, а другое - для операторов INSERT,
    UPDATE и DELETE. Laravel упрощает эту задачу, и всегда будут использоваться правильные соединения, независимо от
    того, используете ли вы необработанные запросы, конструктор запросов или Eloquent ORM.</p>
<p>Чтобы увидеть, как должны быть настроены соединения для чтения / записи, давайте посмотрим на этот пример:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'mysql'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'read'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'host'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
            <span class="token single-quoted-string string">'192.168.1.1'</span><span class="token punctuation">,</span>
            <span class="token single-quoted-string string">'196.168.1.2'</span><span class="token punctuation">,</span>
        <span class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'write'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'host'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
            <span class="token single-quoted-string string">'196.168.1.3'</span><span class="token punctuation">,</span>
        <span class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'sticky'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token boolean constant">true</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'driver'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'mysql'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'database'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'database'</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'username'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'root'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'password'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">''</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'charset'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'utf8mb4'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'collation'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'utf8mb4_unicode_ci'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'prefix'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">''</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p>Обратите внимание, что три ключа, которые были добавлены в массив конфигурации: <code>read</code>, <code>write</code>
    и <code>sticky</code>. <code>read</code> И <code>write</code> ключи имеют значение массива, содержащее один ключ:
    <code>host</code>. Остальные параметры базы данных для <code>read</code> и <code>write</code> соединений будут
    объединены с основной <code>mysql</code> массив конфигурации.</p>
<p>Вам нужно всего лишь разместить элементы в <code>read</code> и <code>write</code> массивы, если вы хотите, чтобы
    переопределить значения из основного <code>mysql</code> массива. Таким образом, в этом случае
    <code>192.168.1.1</code> он будет использоваться в качестве хоста для соединения «чтение», тогда как <code>192.168.1.3</code>
    будет использоваться для соединения «запись». Учетные данные базы данных, префикс, набор символов и все другие
    параметры в основном <code>mysql</code> массиве будут общими для обоих подключений. Если в <code>host</code> массиве
    конфигурации существует несколько значений, для каждого запроса случайным образом выбирается хост базы данных.</p>
<p></p>
<h4 id="the-sticky-option"><a href="#the-sticky-option"><code>sticky</code> Вариант</a></h4>
<p>Параметр <code>sticky</code> - это <em>необязательное</em> значение, которое можно использовать для разрешения
    немедленного чтения записей, которые были записаны в базу данных во время текущего цикла запроса. Если
    <code>sticky</code> опция включена и в текущем цикле запроса к базе данных была выполнена операция «запись», любые
    дальнейшие операции «чтения» будут использовать соединение «запись». Это гарантирует, что любые данные, записанные
    во время цикла запроса, могут быть немедленно прочитаны из базы данных во время того же запроса. Вам решать,
    является ли это желаемым поведением для вашего приложения.</p>
<p></p>
<h2 id="running-queries"><a href="#running-queries">Выполнение SQL-запросов</a></h2>
<p>После того, как вы настроили соединение с базой данных, вы можете запускать запросы, используя <code>DB</code> фасад.
    <code>DB</code> Фасад предоставляет методы для каждого типа запроса: <code>select</code>, <code>update</code>,
    <code>insert</code>, <code>delete</code>, и <code>statement</code>.</p>
<p></p>
<h4 id="running-a-select-query"><a href="#running-a-select-query">Выполнение выбранного запроса</a></h4>
<p>Чтобы выполнить базовый запрос SELECT, вы можете использовать <code>select</code> метод <code>DB</code> фасада:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>Controller</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span class="token punctuation">\</span>DB</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">UserController</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
<span class="token comment">/**
* Show a list of all of the application's users.
     *
     * @return \Illuminate\Http\Response
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">index</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$users</span> <span class="token operator">=</span> <span
                    class="token constant">DB</span><span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token function">select</span><span
                    class="token punctuation">(</span><span class="token single-quoted-string string">'select * from users where active = ?'</span><span
                    class="token punctuation">,</span> <span class="token punctuation">[</span><span
                    class="token number">1</span><span class="token punctuation">]</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token keyword">return</span> <span class="token function">view</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'user.index'</span><span
                    class="token punctuation">,</span> <span class="token punctuation">[</span><span
                    class="token single-quoted-string string">'users'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token variable">$users</span><span
                    class="token punctuation">]</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Первым аргументом, переданным <code>select</code> методу, является запрос SQL, а вторым аргументом - любые привязки
    параметров, которые необходимо связать с запросом. Обычно это значения <code>where</code> ограничений предложения.
    Привязка параметров обеспечивает защиту от внедрения SQL.</p>
<p><code>select</code> Метод всегда будет возвращать <code>array</code> результаты. Каждый результат в массиве будет
    PHP- <code>stdClass</code> объектом, представляющим запись из базы данных:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>DB</span><span
                class="token punctuation">;</span>

<span class="token variable">$users</span> <span class="token operator">=</span> <span
                class="token constant">DB</span><span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">select</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'select * from users'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">foreach</span> <span class="token punctuation">(</span><span
                class="token variable">$users</span> <span class="token keyword">as</span> <span class="token variable">$user</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">echo</span> <span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">name</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="using-named-bindings"><a href="#using-named-bindings">Использование именованных привязок</a></h4>
<p>Вместо использования <code>?</code> для представления привязок параметров вы можете выполнить запрос, используя
    именованные привязки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$results</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">select</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'select * from users where id = :id'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">1</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="running-an-insert-statement"><a href="#running-an-insert-statement">Выполнение инструкции Insert</a></h4>
<p>Чтобы выполнить <code>insert</code> оператор, вы можете использовать <code>insert</code> метод <code>DB</code>
    фасада. Например <code>select</code>, этот метод принимает запрос SQL в качестве первого аргумента и привязки в
    качестве второго аргумента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>DB</span><span
                class="token punctuation">;</span>

<span class="token constant">DB</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">insert</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'insert into users (id, name) values (?, ?)'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Marc'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="running-an-update-statement"><a href="#running-an-update-statement">Запуск оператора обновления</a></h4>
<p>Этот <code>update</code> метод следует использовать для обновления существующих записей в базе данных. Количество
    строк, затронутых оператором, возвращается методом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>DB</span><span
                class="token punctuation">;</span>

<span class="token variable">$affected</span> <span class="token operator">=</span> <span
                class="token constant">DB</span><span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">update</span><span class="token punctuation">(</span>
    <span class="token single-quoted-string string">'update users set votes = 100 where name = ?'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'Anita'</span><span
                class="token punctuation">]</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="running-a-delete-statement"><a href="#running-a-delete-statement">Запуск оператора удаления</a></h4>
<p>Этот <code>delete</code> метод следует использовать для удаления записей из базы данных. Например <code>update</code>,
    количество затронутых строк будет возвращено методом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>DB</span><span
                class="token punctuation">;</span>

<span class="token variable">$deleted</span> <span class="token operator">=</span> <span
                class="token constant">DB</span><span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">delete</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'delete from users'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="running-a-general-statement"><a href="#running-a-general-statement">Выполнение общего заявления</a></h4>
<p>Некоторые операторы базы данных не возвращают никакого значения. Для этих типов операций вы можете использовать
    <code>statement</code> метод на <code>DB</code> фасаде:</p>
<pre class=" language-php"><code class=" language-php"><span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">statement</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'drop table users'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="running-an-unprepared-statement"><a href="#running-an-unprepared-statement">Запуск неподготовленного
        заявления</a></h4>
<p>Иногда вам может потребоваться выполнить инструкцию SQL без привязки каких-либо значений. Для этого вы можете
    использовать метод <code>DB</code> фасада <code>unprepared</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">unprepared</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'update users set votes = 100 where name = "Dries"'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Поскольку неподготовленные операторы не связывают параметры, они могут быть уязвимы для SQL-инъекции. Никогда
            не разрешайте значения, контролируемые пользователем, в неподготовленном операторе.</p></p></div>
</blockquote>
<p></p>
<h4 id="implicit-commits-in-transactions"><a href="#implicit-commits-in-transactions">Неявные коммиты</a></h4>
<p>При использовании методов и <code>DB</code> фасада в транзакциях вы должны быть осторожны, чтобы избегать операторов,
    вызывающих <a href="https://dev.mysql.com/doc/refman/8.0/en/implicit-commit.html">неявные коммиты</a>. Эти операторы
    заставят ядро ​​базы данных косвенно зафиксировать всю транзакцию, в результате чего Laravel не будет знать об
    уровне транзакции базы данных. Примером такого оператора является создание таблицы базы
    данных:<code>statement</code><code>unprepared</code><a
            href="https://dev.mysql.com/doc/refman/8.0/en/implicit-commit.html"></a></p>
<pre class=" language-php"><code class=" language-php"><span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">unprepared</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'create table a (col varchar(1) null)'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Пожалуйста, обратитесь к руководству MySQL за <a href="https://dev.mysql.com/doc/refman/8.0/en/implicit-commit.html">списком
        всех операторов,</a> которые запускают неявные коммиты.</p>
<p></p>
<h3 id="using-multiple-database-connections"><a href="#using-multiple-database-connections">Использование нескольких
        подключений к базе данных</a></h3>
<p>Если ваше приложение определяет несколько соединений в вашем <code>config/database.php</code> файле конфигурации, вы
    можете получить доступ к каждому соединению с помощью <code>connection</code> метода, предоставляемого
    <code>DB</code> фасадом. Имя соединения, переданное <code>connection</code> методу, должно соответствовать одному из
    соединений, перечисленных в вашем <code>config/database.php</code> файле конфигурации или настроенных во время
    выполнения с помощью <code>config</code> помощника:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>DB</span><span
                class="token punctuation">;</span>

<span class="token variable">$users</span> <span class="token operator">=</span> <span
                class="token constant">DB</span><span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">connection</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'sqlite'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">select</span><span
                class="token punctuation">(</span><span class="token punctuation">.</span><span
                class="token punctuation">.</span><span class="token punctuation">.</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете получить доступ к необработанному, базовому экземпляру PDO соединения, используя <code>getPdo</code> метод
    для экземпляра соединения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$pdo</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">connection</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">getPdo</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="listening-for-query-events"><a href="#listening-for-query-events">Прослушивание событий запроса</a></h3>
<p>Если вы хотите указать закрытие, которое вызывается для каждого SQL-запроса, выполняемого вашим приложением, вы
    можете использовать метод <code>DB</code> фасада <code>listen</code>. Этот метод может быть полезен для регистрации
    запросов или отладки. Вы можете зарегистрировать закрытие прослушивателя запросов в <code>boot</code> методе <a
            href="providers">поставщика услуг</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Providers</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span class="token punctuation">\</span>DB</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>ServiceProvider</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">AppServiceProvider</span> <span
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
        <span class="token constant">DB</span><span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token function">listen</span><span
                    class="token punctuation">(</span><span class="token keyword">function</span> <span
                    class="token punctuation">(</span><span class="token variable">$query</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">// $query-&gt;sql</span>
            <span class="token comment">// $query-&gt;bindings</span>
            <span class="token comment">// $query-&gt;time</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h2 id="database-transactions"><a href="#database-transactions">Транзакции базы данных</a></h2>
<p>Вы можете использовать <code>transaction</code> метод, предоставляемый <code>DB</code> фасадом, для выполнения набора
    операций в транзакции базы данных. Если при закрытии транзакции возникает исключение, транзакция автоматически
    откатывается. Если закрытие выполнено успешно, транзакция будет автоматически зафиксирована. Вам не нужно
    беспокоиться о ручном откате или фиксации при использовании <code>transaction</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>DB</span><span
                class="token punctuation">;</span>

<span class="token constant">DB</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">transaction</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token constant">DB</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">update</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'update users set votes = 1'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

    <span class="token constant">DB</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">delete</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'delete from posts'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="handling-deadlocks"><a href="#handling-deadlocks">Обработка взаимоблокировок</a></h4>
<p><code>transaction</code> Метод принимает необязательный второй аргумент, который определяет, сколько раз транзакция
    должна быть повторена при возникновении взаимоблокировки. Как только эти попытки будут исчерпаны, будет выброшено
    исключение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>DB</span><span
                class="token punctuation">;</span>

<span class="token constant">DB</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">transaction</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token constant">DB</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">update</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'update users set votes = 1'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

    <span class="token constant">DB</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">delete</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'delete from posts'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">,</span> <span
                class="token number">5</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="manually-using-transactions"><a href="#manually-using-transactions">Использование транзакций вручную</a></h4>
<p>Если вы хотите начать транзакцию вручную и иметь полный контроль над откатами и фиксацией, вы можете использовать
    <code>beginTransaction</code> метод, предоставляемый <code>DB</code> фасадом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>DB</span><span
                class="token punctuation">;</span>

<span class="token constant">DB</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">beginTransaction</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы можете откатить транзакцию с помощью <code>rollBack</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">rollBack</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Наконец, вы можете совершить транзакцию с помощью <code>commit</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">commit</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>В <code>DB</code> методах транзакционных фасадных контролируют сделки как для <a href="queries">конструктора
                запросов</a> и <a href="eloquent">красноречивого ОРМ</a>.</p></p></div>
</blockquote>
<p></p>
<h2 id="connecting-to-the-database-cli"><a href="#connecting-to-the-database-cli">Подключение к интерфейсу командной
        строки базы данных</a></h2>
<p>Если вы хотите подключиться к CLI вашей базы данных, вы можете использовать <code>db</code> Artisan-команду:</p>
<pre class=" language-php"><code class=" language-php">php artisan db</code></pre>
<p>При необходимости вы можете указать имя подключения к базе данных, чтобы подключиться к подключению к базе данных,
    которое не является подключением по умолчанию:</p>
<pre class=" language-php"><code class=" language-php">php artisan db mysql</code></pre>
