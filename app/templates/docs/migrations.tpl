<h1>База данных: миграции</h1>
<ul>
    <li><a href="migrations#introduction">Вступление</a></li>
    <li><a href="migrations#generating-migrations">Генерация миграций</a>
        <ul>
            <li><a href="migrations#squashing-migrations">Подавление миграции</a></li>
        </ul>
    </li>
    <li><a href="migrations#migration-structure">Структура миграции</a></li>
    <li><a href="migrations#running-migrations">Запуск миграции</a>
        <ul>
            <li><a href="migrations#rolling-back-migrations">Откат миграции</a></li>
        </ul>
    </li>
    <li><a href="migrations#tables">Столы</a>
        <ul>
            <li><a href="migrations#creating-tables">Создание таблиц</a></li>
            <li><a href="migrations#updating-tables">Обновление таблиц</a></li>
            <li><a href="migrations#renaming-and-dropping-tables">Переименование / удаление таблиц</a></li>
        </ul>
    </li>
    <li><a href="migrations#columns">Столбцы</a>
        <ul>
            <li><a href="migrations#creating-columns">Создание столбцов</a></li>
            <li><a href="migrations#available-column-types">Доступные типы столбцов</a></li>
            <li><a href="migrations#column-modifiers">Модификаторы столбца</a></li>
            <li><a href="migrations#modifying-columns">Изменение столбцов</a></li>
            <li><a href="migrations#dropping-columns">Удаление столбцов</a></li>
        </ul>
    </li>
    <li><a href="migrations#indexes">Индексы</a>
        <ul>
            <li><a href="migrations#creating-indexes">Создание индексов</a></li>
            <li><a href="migrations#renaming-indexes">Переименование индексов</a></li>
            <li><a href="migrations#dropping-indexes">Отбрасывание индексов</a></li>
            <li><a href="migrations#foreign-key-constraints">Ограничения внешнего ключа</a></li>
        </ul>
    </li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Миграции похожи на контроль версий для вашей базы данных, позволяя вашей команде определять и совместно использовать
    определение схемы базы данных приложения. Если вам когда-либо приходилось указывать товарищу по команде вручную
    добавить столбец в свою схему локальной базы данных после получения изменений из системы управления версиями, вы
    столкнулись с проблемой, которую решает миграция базы данных.</p>
<p><code>Schema</code> <a href="facades">Фасад</a> Laravel обеспечивает независимую от базы данных поддержку для
    создания и управления таблицами во всех поддерживаемых Laravel системах баз данных. Обычно при миграции этот фасад
    используется для создания и изменения таблиц и столбцов базы данных.</p>
<p></p>
<h2 id="generating-migrations"><a href="#generating-migrations">Генерация миграций</a></h2>
<p>Вы можете использовать команду <code>make:migration</code> <a href="artisan">Artisan</a> для создания миграции базы
    данных. Новая миграция будет помещена в ваш <code>database/migrations</code> каталог. Каждое имя файла миграции
    содержит метку времени, которая позволяет Laravel определять порядок миграций:</p>
<pre class=" language-php"><code class=" language-php">php artisan make<span class="token punctuation">:</span>migration create_flights_table</code></pre>
<p>Laravel будет использовать имя миграции, чтобы попытаться угадать имя таблицы и будет ли миграция создавать новую
    таблицу. Если Laravel может определить имя таблицы по имени миграции, Laravel предварительно заполнит
    сгенерированный файл миграции указанной таблицей. В противном случае вы можете просто указать таблицу в файле
    миграции вручную.</p>
<p>Если вы хотите указать собственный путь для сгенерированной миграции, вы можете использовать эту <code>--path</code>
    опцию при выполнении <code>make:migration</code> команды. Указанный путь должен быть относительно базового пути
    вашего приложения.</p>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Заготовки миграции можно настроить с помощью <a href="artisan#stub-customization">публикации заглушек.</a>
        </p></p></div>
</blockquote>
<p></p>
<h3 id="squashing-migrations"><a href="#squashing-migrations">Подавление миграции</a></h3>
<p>По мере создания приложения вы можете со временем накапливать все больше и больше миграций. Это может привести к
    тому, что ваш <code>database/migrations</code> каталог станет раздутым из-за потенциально сотен миграций. Если
    хотите, можете «сжать» свои миграции в один файл SQL. Для начала выполните <code>schema:dump</code> команду:</p>
<pre class=" language-php"><code class=" language-php">php artisan schema<span class="token punctuation">:</span>dump

<span class="token comment">// Dump the current database schema and prune all existing migrations...</span>
php artisan schema<span class="token punctuation">:</span>dump <span class="token operator">--</span>prune</code></pre>
<p>Когда вы выполняете эту команду, Laravel запишет файл «схемы» в каталог вашего приложения
    <code>database/schema</code>. Теперь, когда вы пытаетесь перенести свою базу данных, и никакие другие миграции не
    выполнялись, Laravel сначала выполнит SQL-операторы файла схемы. После выполнения операторов файла схемы Laravel
    выполнит все оставшиеся миграции, которые не были частью дампа схемы.</p>
<p>Вы должны передать файл схемы базы данных в систему управления версиями, чтобы другие новые разработчики в вашей
    команде могли быстро создать исходную структуру базы данных вашего приложения.</p>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Сжатие миграции доступно только для баз данных MySQL, PostgreSQL и SQLite и использует клиент командной
            строки базы данных. Дампы схемы не могут быть восстановлены в базах данных SQLite в памяти.</p></p></div>
</blockquote>
<p></p>
<h2 id="migration-structure"><a href="#migration-structure">Структура миграции</a></h2>
<p>Класс миграции содержит два метода: <code>up</code> и <code>down</code>. <code>up</code> Метод используется для
    добавления новых таблиц, столбцов и индексов в базе данных, в то время как <code>down</code> метод должен поменять
    местами операции, выполняемые <code>up</code> методом.</p>
<p>В обоих этих методах вы можете использовать построитель схем Laravel для выразительного создания и изменения таблиц.
    Чтобы узнать обо всех методах, доступных в <code>Schema</code> конструкторе, <a href="migrations#creating-tables">ознакомьтесь
        с его документацией</a>. Например, следующая миграция создает <code>flights</code> таблицу:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Migrations<span
                        class="token punctuation">\</span>Migration</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Schema<span class="token punctuation">\</span>Blueprint</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Schema</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">CreateFlightsTable</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Migration</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Run the migrations.
    *
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">up</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        Schema<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">create</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'flights'</span><span
                    class="token punctuation">,</span> <span class="token keyword">function</span> <span
                    class="token punctuation">(</span>Blueprint <span class="token variable">$table</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token variable">$table</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">id</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
            <span class="token variable">$table</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">string</span><span
                    class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
            <span class="token variable">$table</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">string</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'airline'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
            <span class="token variable">$table</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">timestamps</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
    * Reverse the migrations.
    *
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">down</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        Schema<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">drop</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'flights'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h2 id="running-migrations"><a href="#running-migrations">Запуск миграции</a></h2>
<p>Чтобы запустить все незавершенные миграции, выполните <code>migrate</code> Artisan-команду:</p>
<pre class=" language-php"><code class=" language-php">php artisan migrate</code></pre>
<p>Если вы хотите узнать, какие миграции уже выполнены, вы можете использовать <code>migrate:status</code>
    Artisan-команду:</p>
<pre class=" language-php"><code class=" language-php">php artisan migrate<span class="token punctuation">:</span>status</code></pre>
<p></p>
<h4 id="forcing-migrations-to-run-in-production"><a href="#forcing-migrations-to-run-in-production">Принудительный
        запуск миграции в рабочей среде</a></h4>
<p>Некоторые операции миграции являются деструктивными, что означает, что они могут привести к потере данных. Чтобы
    защитить вас от запуска этих команд в производственной базе данных, перед выполнением команд вам будет предложено
    подтвердить. Чтобы команды запускались без подсказки, используйте <code>--force</code> флаг:</p>
<pre class=" language-php"><code class=" language-php">php artisan migrate <span
                class="token operator">--</span>force</code></pre>
<p></p>
<h3 id="rolling-back-migrations"><a href="#rolling-back-migrations">Откат миграции</a></h3>
<p>Чтобы откатить последнюю операцию миграции, вы можете использовать команду <code>rollback</code> Artisan. Эта команда
    откатывает последний «пакет» миграций, который может включать несколько файлов миграции:</p>
<pre class=" language-php"><code class=" language-php">php artisan migrate<span class="token punctuation">:</span>rollback</code></pre>
<p>Вы можете откатить ограниченное количество миграций, указав <code>step</code> параметр для <code>rollback</code>
    команды. Например, следующая команда откатит последние пять миграций:</p>
<pre class=" language-php"><code class=" language-php">php artisan migrate<span class="token punctuation">:</span>rollback <span
                class="token operator">--</span>step<span class="token operator">=</span><span
                class="token number">5</span></code></pre>
<p>Команда <code>migrate:reset</code> откатит все миграции вашего приложения:</p>
<pre class=" language-php"><code class=" language-php">php artisan migrate<span class="token punctuation">:</span>reset</code></pre>
<p></p>
<h4 id="roll-back-migrate-using-a-single-command"><a href="#roll-back-migrate-using-a-single-command">Откат и миграция с
        помощью одной команды</a></h4>
<p>Команда <code>migrate:refresh</code> откатит все ваши миграции, а затем выполнит <code>migrate</code> команду. Эта
    команда эффективно воссоздает всю вашу базу данных:</p>
<pre class=" language-php"><code class=" language-php">php artisan migrate<span class="token punctuation">:</span>refresh

<span class="token comment">// Refresh the database and run all database seeds...</span>
php artisan migrate<span class="token punctuation">:</span>refresh <span
                class="token operator">--</span>seed</code></pre>
<p>Вы можете откатить и повторно перенести ограниченное количество миграций, указав <code>step</code> параметр для
    <code>refresh</code> команды. Например, следующая команда откатит и повторно перенесет последние пять миграций:</p>
<pre class=" language-php"><code class=" language-php">php artisan migrate<span class="token punctuation">:</span>refresh <span
                class="token operator">--</span>step<span class="token operator">=</span><span
                class="token number">5</span></code></pre>
<p></p>
<h4 id="drop-all-tables-migrate"><a href="#drop-all-tables-migrate">Удалить все таблицы и выполнить миграцию</a></h4>
<p>Команда <code>migrate:fresh</code> удалит все таблицы из базы данных, а затем выполнит <code>migrate</code> команду:
</p>
<pre class=" language-php"><code class=" language-php">php artisan migrate<span class="token punctuation">:</span>fresh

php artisan migrate<span class="token punctuation">:</span>fresh <span class="token operator">--</span>seed</code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Команда <code>migrate:fresh</code> отбросит все таблицы базы данных независимо от их префикса. Эту команду
            следует использовать с осторожностью при разработке в базе данных, которая используется совместно с другими
            приложениями.</p></p></div>
</blockquote>
<p></p>
<h2 id="tables"><a href="#tables">Столы</a></h2>
<p></p>
<h3 id="creating-tables"><a href="#creating-tables">Создание таблиц</a></h3>
<p>Чтобы создать новую таблицу базы данных, используйте <code>create</code> метод <code>Schema</code> фасада. <code>create</code>
    Метод принимает два аргумента: во - первых, имя таблицы, в то время как второй является замыкание, которое получает
    <code>Blueprint</code> объект, который может быть использован, чтобы определить новую таблицу:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                    class="token punctuation">\</span>Schema<span
                    class="token punctuation">\</span>Blueprint</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Schema</span><span
                class="token punctuation">;</span>

Schema<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>Blueprint <span class="token variable">$table</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">id</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">string</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'name'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">string</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'email'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">timestamps</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>При создании таблицы вы можете использовать любой из <a href="migrations#creating-columns">методов столбца</a>
    построителя схемы для определения столбцов таблицы.</p>
<p></p>
<h4 id="checking-for-table-column-existence"><a href="#checking-for-table-column-existence">Проверка существования
        таблицы / столбца</a></h4>
<p>Вы можете проверить наличие таблицы или столбца, используя <code>hasTable</code> и <code>hasColumn</code> методы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">if</span> <span
                class="token punctuation">(</span>Schema<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">hasTable</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// The "users" table exists...</span>
<span class="token punctuation">}</span>

<span class="token keyword">if</span> <span class="token punctuation">(</span>Schema<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">hasColumn</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'email'</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// The "users" table exists and has an "email" column...</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="database-connection-table-options"><a href="#database-connection-table-options">Подключение к базе данных и
        параметры таблицы</a></h4>
<p>Если вы хотите выполнить операцию схемы с подключением к базе данных, которое не является подключением по умолчанию
    для вашего приложения, используйте <code>connection</code> метод:</p>
<pre class=" language-php"><code class=" language-php">Schema<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">connection</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'sqlite'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>Blueprint <span class="token variable">$table</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">id</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Кроме того, некоторые другие свойства и методы могут использоваться для определения других аспектов создания таблицы.
    <code>engine</code> Свойство может быть использовано для определения механизма хранения стола при использовании
    MySQL:</p>
<pre class=" language-php"><code class=" language-php">Schema<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>Blueprint <span class="token variable">$table</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">engine</span> <span class="token operator">=</span> <span
                class="token single-quoted-string string">'InnoDB'</span><span class="token punctuation">;</span>
            
    <span class="token comment">//...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Эти <code>charset</code> и <code>collation</code> свойства могут быть использованы для указания набора символов и
    параметров сортировки для созданной таблицы при использовании MySQL:</p>
<pre class=" language-php"><code class=" language-php">Schema<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>Blueprint <span class="token variable">$table</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">charset</span> <span class="token operator">=</span> <span
                class="token single-quoted-string string">'utf8mb4'</span><span class="token punctuation">;</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">collation</span> <span class="token operator">=</span> <span
                class="token single-quoted-string string">'utf8mb4_unicode_ci'</span><span
                class="token punctuation">;</span>
            
    <span class="token comment">//...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Этот <code>temporary</code> метод может использоваться, чтобы указать, что таблица должна быть «временной». Временные
    таблицы видны только текущему сеансу базы данных соединения и автоматически удаляются при закрытии соединения:</p>
<pre class=" language-php"><code class=" language-php">Schema<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">create</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'calculations'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span>Blueprint <span
                class="token variable">$table</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">temporary</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
            
    <span class="token comment">//...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="updating-tables"><a href="#updating-tables">Обновление таблиц</a></h3>
<p><code>table</code> Метод на <code>Schema</code> фасаде может быть использован для обновления существующих таблиц. Как
    и <code>create</code> метод, <code>table</code> метод принимает два аргумента: имя таблицы и замыкание, которое
    получает <code>Blueprint</code> экземпляр, который вы можете использовать для добавления столбцов или индексов в
    таблицу:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                    class="token punctuation">\</span>Schema<span
                    class="token punctuation">\</span>Blueprint</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Schema</span><span
                class="token punctuation">;</span>

Schema<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">table</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'users'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span>Blueprint <span
                class="token variable">$table</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">integer</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'votes'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="renaming-and-dropping-tables"><a href="#renaming-and-dropping-tables">Переименование / удаление таблиц</a></h3>
<p>Чтобы переименовать существующую таблицу базы данных, используйте <code>rename</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Schema</span><span
                class="token punctuation">;</span>

Schema<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">rename</span><span
                class="token punctuation">(</span><span class="token variable">$from</span><span
                class="token punctuation">,</span> <span class="token variable">$to</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Чтобы удалить существующую таблицу, вы можете использовать методы <code>drop</code> или <code>dropIfExists</code>:
</p>
<pre class=" language-php"><code class=" language-php">Schema<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">drop</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

Schema<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">dropIfExists</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="renaming-tables-with-foreign-keys"><a href="#renaming-tables-with-foreign-keys">Переименование таблиц с помощью
        внешних ключей</a></h4>
<p>Перед переименованием таблицы вы должны убедиться, что любые ограничения внешнего ключа в таблице имеют явное имя в
    ваших файлах миграции, вместо того, чтобы позволять Laravel назначать имя на основе соглашения. В противном случае
    имя ограничения внешнего ключа будет относиться к имени старой таблицы.</p>
<p></p>
<h2 id="columns"><a href="#columns">Столбцы</a></h2>
<p></p>
<h3 id="creating-columns"><a href="#creating-columns">Создание столбцов</a></h3>
<p><code>table</code> Метод на <code>Schema</code> фасаде может быть использован для обновления существующих таблиц. Как
    и <code>create</code> метод, <code>table</code> метод принимает два аргумента: имя таблицы и закрытие, которое
    получает <code>Illuminate\Database\Schema\Blueprint</code> экземпляр, который вы можете использовать для добавления
    столбцов в таблицу:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                    class="token punctuation">\</span>Schema<span
                    class="token punctuation">\</span>Blueprint</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Schema</span><span
                class="token punctuation">;</span>

Schema<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">table</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'users'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span>Blueprint <span
                class="token variable">$table</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">integer</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'votes'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="available-column-types"><a href="#available-column-types">Доступные типы столбцов</a></h3>
<p>Схема построителя схемы предлагает множество методов, соответствующих различным типам столбцов, которые вы можете
    добавить в таблицы базы данных. Все доступные методы перечислены в таблице ниже:</p>
<style>
    #collection-method-list > p {
        column-count: 3;
        -moz-column-count: 3;
        -webkit-column-count: 3;
        column-gap: 2em;
        -moz-column-gap: 2em;
        -webkit-column-gap: 2em;
    }

    #collection-method-list a {
        display: block;
    }
</style>
<div id="collection-method-list">
    <p><a href="#column-method-bigIncrements">bigIncrements</a>
        <a href="#column-method-bigInteger">bigInteger</a>
        <a href="#column-method-binary">binary</a>
        <a href="#column-method-boolean">boolean</a>
        <a href="#column-method-char">char</a>
        <a href="#column-method-dateTimeTz">dateTimeTz</a>
        <a href="#column-method-dateTime">dateTime</a>
        <a href="#column-method-date">date</a>
        <a href="#column-method-decimal">decimal</a>
        <a href="#column-method-double">double</a>
        <a href="#column-method-enum">enum</a>
        <a href="#column-method-float">float</a>
        <a href="#column-method-foreignId">foreignId</a>
        <a href="#column-method-geometryCollection">geometryCollection</a>
        <a href="#column-method-geometry">geometry</a>
        <a href="#column-method-id">id</a>
        <a href="#column-method-increments">increments</a>
        <a href="#column-method-integer">integer</a>
        <a href="#column-method-ipAddress">ipAddress</a>
        <a href="#column-method-json">json</a>
        <a href="#column-method-jsonb">jsonb</a>
        <a href="#column-method-lineString">lineString</a>
        <a href="#column-method-longText">longText</a>
        <a href="#column-method-macAddress">macAddress</a>
        <a href="#column-method-mediumIncrements">mediumIncrements</a>
        <a href="#column-method-mediumInteger">mediumInteger</a>
        <a href="#column-method-mediumText">mediumText</a>
        <a href="#column-method-morphs">morphs</a>
        <a href="#column-method-multiLineString">multiLineString</a>
        <a href="#column-method-multiPoint">multiPoint</a>
        <a href="#column-method-multiPolygon">multiPolygon</a>
        <a href="#column-method-nullableMorphs">nullableMorphs</a>
        <a href="#column-method-nullableTimestamps">nullableTimestamps</a>
        <a href="#column-method-nullableUuidMorphs">nullableUuidMorphs</a>
        <a href="#column-method-point">point</a>
        <a href="#column-method-polygon">polygon</a>
        <a href="#column-method-rememberToken">rememberToken</a>
        <a href="#column-method-set">set</a>
        <a href="#column-method-smallIncrements">smallIncrements</a>
        <a href="#column-method-smallInteger">smallInteger</a>
        <a href="#column-method-softDeletesTz">softDeletesTz</a>
        <a href="#column-method-softDeletes">softDeletes</a>
        <a href="#column-method-string">string</a>
        <a href="#column-method-text">text</a>
        <a href="#column-method-timeTz">timeTz</a>
        <a href="#column-method-time">time</a>
        <a href="#column-method-timestampTz">timestampTz</a>
        <a href="#column-method-timestamp">timestamp</a>
        <a href="#column-method-timestampsTz">timestampsTz</a>
        <a href="#column-method-timestamps">timestamps</a>
        <a href="#column-method-tinyIncrements">tinyIncrements</a>
        <a href="#column-method-tinyInteger">tinyInteger</a>
        <a href="#column-method-unsignedBigInteger">unsignedBigInteger</a>
        <a href="#column-method-unsignedDecimal">unsignedDecimal</a>
        <a href="#column-method-unsignedInteger">unsignedInteger</a>
        <a href="#column-method-unsignedMediumInteger">unsignedMediumInteger</a>
        <a href="#column-method-unsignedSmallInteger">unsignedSmallInteger</a>
        <a href="#column-method-unsignedTinyInteger">unsignedTinyInteger</a>
        <a href="#column-method-uuidMorphs">uuidMorphs</a>
        <a href="#column-method-uuid">uuid</a>
        <a href="#column-method-year">year</a></p>
</div>
<p></p>
<h4 id="column-method-bigIncrements"><a href="#column-method-bigIncrements"><code>bigIncrements()</code></a></h4>
<p><code>bigIncrements</code> Метод создает автоинкрементный <code>UNSIGNED BIGINT</code> эквивалентный столбец
    (первичный ключ):</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">bigIncrements</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'id'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-bigInteger"><a href="#column-method-bigInteger"><code>bigInteger()</code></a></h4>
<p><code>bigInteger</code> Метод создает <code>BIGINT</code> эквивалентный столбец:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">bigInteger</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'votes'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-binary"><a href="#column-method-binary"><code>binary()</code></a></h4>
<p><code>binary</code> Метод создает <code>BLOB</code> эквивалентный столбец:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">binary</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'photo'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-boolean"><a href="#column-method-boolean"><code>boolean()</code></a></h4>
<p><code>boolean</code> Метод создает <code>BOOLEAN</code> эквивалентный столбец:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">boolean</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'confirmed'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-char"><a href="#column-method-char"><code>char()</code></a></h4>
<p><code>char</code> Метод создает <code>CHAR</code> эквивалентный столбец с заданной длиной:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">char</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'name'</span><span class="token punctuation">,</span> <span
                class="token number">100</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-dateTimeTz"><a href="#column-method-dateTimeTz"><code>dateTimeTz()</code></a></h4>
<p><code>dateTimeTz</code> Метод создает <code>DATETIME</code> (с часовым поясом) эквивалентная колонку с дополнительной
    точностью (всего цифра):</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">dateTimeTz</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'created_at'</span><span
                class="token punctuation">,</span> <span class="token variable">$precision</span> <span
                class="token operator">=</span> <span class="token number">0</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-dateTime"><a href="#column-method-dateTime"><code>dateTime()</code></a></h4>
<p><code>dateTime</code> Метод создает <code>DATETIME</code> эквивалентную колонку с дополнительной точностью (всего
    цифры):</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">dateTime</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'created_at'</span><span
                class="token punctuation">,</span> <span class="token variable">$precision</span> <span
                class="token operator">=</span> <span class="token number">0</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-date"><a href="#column-method-date"><code>date()</code></a></h4>
<p><code>date</code> Метод создает <code>DATE</code> эквивалентный столбец:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">date</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'created_at'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-decimal"><a href="#column-method-decimal"><code>decimal()</code></a></h4>
<p><code>decimal</code> Метод создает <code>DECIMAL</code> эквивалентный столбец с заданной точностью (всего цифр) и
    шкалы (десятичных цифр):</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">decimal</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'amount'</span><span
                class="token punctuation">,</span> <span class="token variable">$precision</span> <span
                class="token operator">=</span> <span class="token number">8</span><span
                class="token punctuation">,</span> <span class="token variable">$scale</span> <span
                class="token operator">=</span> <span class="token number">2</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-double"><a href="#column-method-double"><code>double()</code></a></h4>
<p><code>double</code> Метод создает <code>DOUBLE</code> эквивалентный столбец с заданной точностью (всего цифр) и шкалы
    (десятичных цифр):</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">double</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'amount'</span><span
                class="token punctuation">,</span> <span class="token number">8</span><span
                class="token punctuation">,</span> <span class="token number">2</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-enum"><a href="#column-method-enum"><code>enum()</code></a></h4>
<p><code>enum</code> Метод создает <code>ENUM</code> эквивалентный столбец с заданными допустимыми значениями:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">enum</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'difficulty'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'easy'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'hard'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-float"><a href="#column-method-float"><code>float()</code></a></h4>
<p><code>float</code> Метод создает <code>FLOAT</code> эквивалентный столбец с заданной точностью (всего цифр) и шкалы
    (десятичных цифр):</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">float</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'amount'</span><span
                class="token punctuation">,</span> <span class="token number">8</span><span
                class="token punctuation">,</span> <span class="token number">2</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-foreignId"><a href="#column-method-foreignId"><code>foreignId()</code></a></h4>
<p><code>foreignId</code> Метод является псевдонимом для <code>unsignedBigInteger</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">foreignId</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'user_id'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-geometryCollection"><a href="#column-method-geometryCollection"><code>geometryCollection()</code></a></h4>
<p><code>geometryCollection</code> Метод создает <code>GEOMETRYCOLLECTION</code> эквивалентный столбец:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">geometryCollection</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'positions'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-geometry"><a href="#method"><code>column-method-geometry()</code></a></h4>
<p><code>geometry</code> Метод создает <code>GEOMETRY</code> эквивалентный столбец:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">geometry</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'positions'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-id"><a href="#column-method-id"><code>id()</code></a></h4>
<p><code>id</code> Метод является псевдонимом <code>bigIncrements</code> метода. По умолчанию метод создает
    <code>id</code> столбец; однако вы можете передать имя столбца, если хотите присвоить столбцу другое имя:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">id</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-increments"><a href="#column-method-increments"><code>increments()</code></a></h4>
<p><code>increments</code> Метод создает автоинкрементный <code>UNSIGNED INTEGER</code> эквивалентный столбец в качестве
    первичного ключа:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">increments</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'id'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-integer"><a href="#column-method-integer"><code>integer()</code></a></h4>
<p><code>integer</code> Метод создает <code>INTEGER</code> эквивалентный столбец:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">integer</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'votes'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-ipAddress"><a href="#column-method-ipAddress"><code>ipAddress()</code></a></h4>
<p><code>ipAddress</code> Метод создает <code>INTEGER</code> эквивалентный столбец:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">ipAddress</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'visitor'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-json"><a href="#column-method-json"><code>json()</code></a></h4>
<p><code>json</code> Метод создает <code>JSON</code> эквивалентный столбец:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">json</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'options'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-jsonb"><a href="#column-method-jsonb"><code>jsonb()</code></a></h4>
<p><code>jsonb</code> Метод создает <code>JSONB</code> эквивалентный столбец:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">jsonb</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'options'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-lineString"><a href="#column-method-lineString"><code>lineString()</code></a></h4>
<p><code>lineString</code> Метод создает <code>LINESTRING</code> эквивалентный столбец:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">lineString</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'positions'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-longText"><a href="#column-method-longText"><code>longText()</code></a></h4>
<p><code>longText</code> Метод создает <code>LONGTEXT</code> эквивалентный столбец:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">longText</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'description'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-macAddress"><a href="#column-method-macAddress"><code>macAddress()</code></a></h4>
<p><code>macAddress</code> Метод создает столбец, который предназначен для хранения МАС - адреса. Некоторые системы баз
    данных, такие как PostgreSQL, имеют специальный тип столбца для этого типа данных. Другие системы баз данных будут
    использовать столбец строкового эквивалента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">macAddress</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'device'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-mediumIncrements"><a href="#column-method-mediumIncrements"><code>mediumIncrements()</code></a></h4>
<p><code>mediumIncrements</code> Метод создает автоинкрементный <code>UNSIGNED MEDIUMINT</code> эквивалентный столбец в
    качестве первичного ключа:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">mediumIncrements</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'id'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-mediumInteger"><a href="#column-method-mediumInteger"><code>mediumInteger()</code></a></h4>
<p><code>mediumInteger</code> Метод создает <code>MEDIUMINT</code> эквивалентный столбец:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">mediumInteger</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'votes'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-mediumText"><a href="#column-method-mediumText"><code>mediumText()</code></a></h4>
<p><code>mediumText</code> Метод создает <code>MEDIUMTEXT</code> эквивалентный столбец:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">mediumText</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'description'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-morphs"><a href="#column-method-morphs"><code>morphs()</code></a></h4>
<p><code>morphs</code> Метод является удобным методом, который добавляет <code>{literal}{column}{/literal}_id</code> <code>UNSIGNED
        BIGINT</code> эквивалентную колонку и <code>{literal}{column}{/literal}_type</code> <code>VARCHAR</code> эквивалентную колонку.</p>
<p>Этот метод предназначен для использования при определении столбцов, необходимых для полиморфного <a
            href="eloquent-relationships">отношения Eloquent</a>. В следующем примере, <code>taggable_id</code> и <code>taggable_type</code>
    столбцы будут созданы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">morphs</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'taggable'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-multiLineString"><a href="#column-method-multiLineString"><code>multiLineString()</code></a></h4>
<p><code>multiLineString</code> Метод создает <code>MULTILINESTRING</code> эквивалентный столбец:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">multiLineString</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'positions'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-multiPoint"><a href="#column-method-multiPoint"><code>multiPoint()</code></a></h4>
<p><code>multiPoint</code> Метод создает <code>MULTIPOINT</code> эквивалентный столбец:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">multiPoint</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'positions'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-multiPolygon"><a href="#column-method-multiPolygon"><code>multiPolygon()</code></a></h4>
<p><code>multiPolygon</code> Метод создает <code>MULTIPOLYGON</code> эквивалентный столбец:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">multiPolygon</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'positions'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-nullableTimestamp"><a href="#column-method-nullableTimestamp"><code>nullableTimestamps()</code></a></h4>
<p>Метод аналогичен методу <a href="migrations#column-method-timestamps">временных меток</a> ; однако созданный столбец
    будет иметь значение NULL:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">nullableTimestamps</span><span
                class="token punctuation">(</span><span class="token number">0</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-nullableMorphs"><a href="#column-method-nullableMorphs"><code>nullableMorphs()</code></a></h4>
<p>Метод аналогичен методу <a href="migrations#column-method-morphs">морфов</a> ; однако создаваемые столбцы будут
    "допускать значение NULL":</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">nullableMorphs</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'taggable'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-nullableUuidMorphs"><a href="#column-method-nullableUuidMorphs"><code>nullableUuidMorphs()</code></a></h4>
<p>Метод аналогичен методу <a href="migrations#column-method-uuidMorphs">uuidMorphs</a> ; однако создаваемые столбцы
    будут "допускать значение NULL":</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">nullableUuidMorphs</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'taggable'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-point"><a href="#column-method-point"><code>point()</code></a></h4>
<p><code>point</code> Метод создает <code>POINT</code> эквивалентный столбец:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">point</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'position'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-polygon"><a href="#column-method-polygon"><code>polygon()</code></a></h4>
<p><code>polygon</code> Метод создает <code>POLYGON</code> эквивалентный столбец:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">polygon</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'position'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-rememberToken"><a href="#column-method-rememberToken"><code>rememberToken()</code></a></h4>
<p><code>rememberToken</code> Метод создает обнуляемый, <code>VARCHAR(100)</code> эквивалентный столбец, который
    предназначен для хранения текущей «запомнить меня» <a href="authentication#remembering-users">аутентификацию
        токенов</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">rememberToken</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-set"><a href="#column-method-set"><code>set()</code></a></h4>
<p><code>set</code> Метод создает <code>SET</code> эквивалентный столбец с заданным списком допустимых значений:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">set</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'flavors'</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span><span
                class="token single-quoted-string string">'strawberry'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'vanilla'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-smallIncrements"><a href="#column-method-smallIncrements"><code>smallIncrements()</code></a></h4>
<p><code>smallIncrements</code> Метод создает автоинкрементный <code>UNSIGNED SMALLINT</code> эквивалентный столбец в
    качестве первичного ключа:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">smallIncrements</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'id'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-smallInteger"><a href="#column-method-smallInteger"><code>smallInteger()</code></a></h4>
<p><code>smallInteger</code> Метод создает <code>SMALLINT</code> эквивалентный столбец:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">smallInteger</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'votes'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-softDeletesTz"><a href="#column-method-softDeletesTz"><code>softDeletesTz()</code></a></h4>
<p><code>softDeletesTz</code> Метод добавляет обнуляемый <code>deleted_at</code> <code>TIMESTAMP</code> (с временной
    зоной) эквивалентная колонку с дополнительной точностью (всего цифрами). Этот столбец предназначен для хранения
    <code>deleted_at</code> метки времени, необходимой для функции «мягкого удаления» Eloquent:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">softDeletesTz</span><span
                class="token punctuation">(</span><span class="token variable">$column</span> <span
                class="token operator">=</span> <span class="token single-quoted-string string">'deleted_at'</span><span
                class="token punctuation">,</span> <span class="token variable">$precision</span> <span
                class="token operator">=</span> <span class="token number">0</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-softDeletes"><a href="#column-method-softDeletes"><code>softDeletes()</code></a></h4>
<p><code>softDeletes</code> Метод добавляет обнуляемую <code>deleted_at</code> <code>TIMESTAMP</code> эквивалентную
    колонку с дополнительной точностью (всего цифрами). Этот столбец предназначен для хранения <code>deleted_at</code>
    метки времени, необходимой для функции «мягкого удаления» Eloquent:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">softDeletes</span><span
                class="token punctuation">(</span><span class="token variable">$column</span> <span
                class="token operator">=</span> <span class="token single-quoted-string string">'deleted_at'</span><span
                class="token punctuation">,</span> <span class="token variable">$precision</span> <span
                class="token operator">=</span> <span class="token number">0</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-string"><a href="#column-method-string"><code>string()</code></a></h4>
<p><code>string</code> Метод создает <code>VARCHAR</code> эквивалентный столбец заданной длины:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">string</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">,</span> <span class="token number">100</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-text"><a href="#column-method-text"><code>text()</code></a></h4>
<p><code>text</code> Метод создает <code>TEXT</code> эквивалентный столбец:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">text</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'description'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-timeTz"><a href="#column-method-timeTz"><code>timeTz()</code></a></h4>
<p><code>timeTz</code> Метод создает <code>TIME</code> (с часовым поясом) эквивалентная колонку с дополнительной
    точностью (всего цифра):</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">timeTz</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'sunrise'</span><span
                class="token punctuation">,</span> <span class="token variable">$precision</span> <span
                class="token operator">=</span> <span class="token number">0</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-time"><a href="#column-method-time"><code>time()</code></a></h4>
<p><code>time</code> Метод создает <code>TIME</code> эквивалентную колонку с дополнительной точностью (всего цифры):</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">time</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'sunrise'</span><span class="token punctuation">,</span> <span
                class="token variable">$precision</span> <span class="token operator">=</span> <span
                class="token number">0</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-timestampTz"><a href="#column-method-timestampTz"><code>timestampTz()</code></a></h4>
<p><code>timestampTz</code> Метод создает <code>TIMESTAMP</code> (с часовым поясом) эквивалентная колонку с
    дополнительной точностью (всего цифра):</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">timestampTz</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'added_at'</span><span
                class="token punctuation">,</span> <span class="token variable">$precision</span> <span
                class="token operator">=</span> <span class="token number">0</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-timestamp"><a href="#column-method-timestamp"><code>timestamp()</code></a></h4>
<p><code>timestamp</code> Метод создает <code>TIMESTAMP</code> эквивалентную колонку с дополнительной точностью (всего
    цифры):</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">timestamp</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'added_at'</span><span
                class="token punctuation">,</span> <span class="token variable">$precision</span> <span
                class="token operator">=</span> <span class="token number">0</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-timestampsTz"><a href="#column-method-timestampsTz"><code>timestampsTz()</code></a></h4>
<p><code>timestampsTz</code> Метод создает <code>created_at</code> и <code>updated_at</code> <code>TIMESTAMP</code> (с
    часовым поясом) эквивалентными столбцами с опциональной точностью (всего цифрами):</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">timestampsTz</span><span
                class="token punctuation">(</span><span class="token variable">$precision</span> <span
                class="token operator">=</span> <span class="token number">0</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-timestamps"><a href="#column-method-timestamps"><code>timestamps()</code></a></h4>
<p><code>timestamps</code> Метод создает <code>created_at</code> и <code>updated_at</code> <code>TIMESTAMP</code>
    эквивалентные столбцы с опциональной точностью (всего цифры):</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">timestamps</span><span
                class="token punctuation">(</span><span class="token variable">$precision</span> <span
                class="token operator">=</span> <span class="token number">0</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-tinyIncrements"><a href="#column-method-tinyIncrements"><code>tinyIncrements()</code></a></h4>
<p><code>tinyIncrements</code> Метод создает автоинкрементный <code>UNSIGNED TINYINT</code> эквивалентный столбец в
    качестве первичного ключа:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">tinyIncrements</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'id'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-tinyInteger"><a href="#column-method-tinyInteger"><code>tinyInteger()</code></a></h4>
<p><code>tinyInteger</code> Метод создает <code>TINYINT</code> эквивалентный столбец:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">tinyInteger</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'votes'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-unsignedBigInteger"><a href="#column-method-unsignedBigInteger"><code>unsignedBigInteger()</code></a></h4>
<p><code>unsignedBigInteger</code> Метод создает <code>UNSIGNED BIGINT</code> эквивалентный столбец:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">unsignedBigInteger</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'votes'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-unsignedDecimal"><a href="#column-method-unsignedDecimal"><code>unsignedDecimal()</code></a></h4>
<p><code>unsignedDecimal</code> Метод создает <code>UNSIGNED DECIMAL</code> эквивалентную колонку с дополнительной
    точностью (всего цифр) и шкалы (десятичных цифр):</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">unsignedDecimal</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'amount'</span><span
                class="token punctuation">,</span> <span class="token variable">$precision</span> <span
                class="token operator">=</span> <span class="token number">8</span><span
                class="token punctuation">,</span> <span class="token variable">$scale</span> <span
                class="token operator">=</span> <span class="token number">2</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-unsignedInteger"><a href="#column-method-unsignedInteger"><code>unsignedInteger()</code></a></h4>
<p><code>unsignedInteger</code> Метод создает <code>UNSIGNED INTEGER</code> эквивалентный столбец:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">unsignedInteger</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'votes'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-unsignedMediumInteger"><a href="#column-method-unsignedMediumInteger"><code>unsignedMediumInteger()</code></a></h4>
<p><code>unsignedMediumInteger</code> Метод создает <code>UNSIGNED MEDIUMINT</code> эквивалентный столбец:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">unsignedMediumInteger</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'votes'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-unsignedSmallInteger"><a href="#column-method-unsignedSmallInteger"><code>unsignedSmallInteger()</code></a></h4>
<p><code>unsignedSmallInteger</code> Метод создает <code>UNSIGNED SMALLINT</code> эквивалентный столбец:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">unsignedSmallInteger</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'votes'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-unsignedTinyInteger"><a href="#column-method-unsignedTinyInteger"><code>unsignedTinyInteger()</code></a></h4>
<p><code>unsignedTinyInteger</code> Метод создает <code>UNSIGNED TINYINT</code> эквивалентный столбец:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">unsignedTinyInteger</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'votes'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-uuidMorphs"><a href="#column-method-uuidMorphs"><code>uuidMorphs()</code></a></h4>
<p><code>uuidMorphs</code> Метод является удобным методом, который добавляет <code>{literal}{column}{/literal}_id</code>
    <code>CHAR(36)</code> эквивалентную колонку и <code>{literal}{column}{/literal}_type</code> <code>VARCHAR</code> эквивалентную колонку.
</p>
<p>Этот метод предназначен для использования при определении столбцов, необходимых для полиморфного <a
            href="eloquent-relationships">отношения Eloquent</a>, использующего идентификаторы UUID. В следующем
    примере, <code>taggable_id</code> и <code>taggable_type</code> столбцы будут созданы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">uuidMorphs</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'taggable'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-uuid"><a href="#column-method-uuid"><code>uuid()</code></a></h4>
<p><code>uuid</code> Метод создает <code>UUID</code> эквивалентный столбец:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">uuid</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'id'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="column-method-year"><a href="#column-method-year"><code>year()</code></a></h4>
<p><code>year</code> Метод создает <code>YEAR</code> эквивалентный столбец:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">year</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'birth_year'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="column-modifiers"><a href="#column-modifiers">Модификаторы столбца</a></h3>
<p>В дополнение к типам столбцов, перечисленным выше, существует несколько «модификаторов» столбцов, которые вы можете
    использовать при добавлении столбца в таблицу базы данных. Например, чтобы сделать столбец «допускающим значение
    NULL», вы можете использовать <code>nullable</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                    class="token punctuation">\</span>Schema<span
                    class="token punctuation">\</span>Blueprint</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Schema</span><span
                class="token punctuation">;</span>

Schema<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">table</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'users'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span>Blueprint <span
                class="token variable">$table</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">string</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'email'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">nullable</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>В следующей таблице представлены все доступные модификаторы столбцов. В этот список не входят <a
            href="migrations#creating-indexes">модификаторы индекса</a>:</p>
<table>
    <thead>
    <tr>
        <th>Модификатор</th>
        <th>Описание</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td><code>-&gt;after('column')</code></td>
        <td>Поместите столбец «после» другого столбца (MySQL).</td>
    </tr>
    <tr>
        <td><code>-&gt;autoIncrement()</code></td>
        <td>Установите столбцы INTEGER как автоматически увеличивающиеся (первичный ключ).</td>
    </tr>
    <tr>
        <td><code>-&gt;charset('utf8mb4')</code></td>
        <td>Укажите набор символов для столбца (MySQL).</td>
    </tr>
    <tr>
        <td><code>-&gt;collation('utf8mb4_unicode_ci')</code></td>
        <td>Укажите параметры сортировки для столбца (MySQL / PostgreSQL / SQL Server).</td>
    </tr>
    <tr>
        <td><code>-&gt;comment('my comment')</code></td>
        <td>Добавить комментарий в столбец (MySQL / PostgreSQL).</td>
    </tr>
    <tr>
        <td><code>-&gt;default($value)</code></td>
        <td>Задайте для столбца значение «по умолчанию».</td>
    </tr>
    <tr>
        <td><code>-&gt;first()</code></td>
        <td>Поместите в таблицу столбец «первый» (MySQL).</td>
    </tr>
    <tr>
        <td><code>-&gt;from($integer)</code></td>
        <td>Установите начальное значение автоматически увеличивающегося поля (MySQL / PostgreSQL).</td>
    </tr>
    <tr>
        <td><code>-&gt;nullable($value = true)</code></td>
        <td>Разрешить вставку в столбец значений NULL.</td>
    </tr>
    <tr>
        <td><code>-&gt;storedAs($expression)</code></td>
        <td>Создайте сохраненный сгенерированный столбец (MySQL).</td>
    </tr>
    <tr>
        <td><code>-&gt;unsigned()</code></td>
        <td>Задайте столбцы INTEGER как UNSIGNED (MySQL).</td>
    </tr>
    <tr>
        <td><code>-&gt;useCurrent()</code></td>
        <td>Установите столбцы TIMESTAMP, чтобы использовать CURRENT_TIMESTAMP в качестве значения по умолчанию.</td>
    </tr>
    <tr>
        <td><code>-&gt;useCurrentOnUpdate()</code></td>
        <td>Установите столбцы TIMESTAMP для использования CURRENT_TIMESTAMP при обновлении записи.</td>
    </tr>
    <tr>
        <td><code>-&gt;virtualAs($expression)</code></td>
        <td>Создайте виртуальный сгенерированный столбец (MySQL).</td>
    </tr>
    <tr>
        <td><code>-&gt;generatedAs($expression)</code></td>
        <td>Создайте столбец идентификаторов с указанными параметрами последовательности (PostgreSQL).</td>
    </tr>
    <tr>
        <td><code>-&gt;always()</code></td>
        <td>Определяет приоритет значений последовательности над вводом для столбца идентификаторов (PostgreSQL).</td>
    </tr>
    </tbody>
</table>
<p></p>
<h4 id="default-expressions"><a href="#default-expressions">Выражения по умолчанию</a></h4>
<p><code>default</code> Модификатор принимает значение или <code>Illuminate\Database\Query\Expression</code> экземпляр.
    Использование <code>Expression</code> экземпляра не позволит Laravel заключить значение в кавычки и позволит вам
    использовать функции, специфичные для базы данных. Одна из ситуаций, когда это особенно полезно, - это когда вам
    нужно присвоить значения по умолчанию столбцам JSON:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Schema</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Schema<span class="token punctuation">\</span>Blueprint</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Query<span class="token punctuation">\</span>Expression</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Migrations<span
                        class="token punctuation">\</span>Migration</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">CreateFlightsTable</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Migration</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Run the migrations.
    *
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">up</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        Schema<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">create</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'flights'</span><span
                    class="token punctuation">,</span> <span class="token keyword">function</span> <span
                    class="token punctuation">(</span>Blueprint <span class="token variable">$table</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token variable">$table</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">id</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
            <span class="token variable">$table</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">json</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'movies'</span><span
                    class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token keyword">default</span><span class="token punctuation">(</span><span
                    class="token keyword">new</span> <span class="token class-name">Expression</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'(JSON_ARRAY())'</span><span
                    class="token punctuation">)</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
            <span class="token variable">$table</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">timestamps</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Поддержка выражений по умолчанию зависит от вашего драйвера базы данных, версии базы данных и типа поля. См.
            Документацию к вашей базе данных.</p></p></div>
</blockquote>
<p></p>
<h4 id="column-order"><a href="#column-order">Порядок столбцов</a></h4>
<p>При использовании базы данных MySQL этот <code>after</code> метод может использоваться для добавления столбцов после
    существующего столбца в схеме:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">after</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'password'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$table</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">string</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'address_line1'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">string</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'address_line2'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">string</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'city'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="modifying-columns"><a href="#modifying-columns">Изменение столбцов</a></h3>
<p></p>
<h4 id="prerequisites"><a href="#prerequisites">Предпосылки</a></h4>
<p>Перед изменением столбца необходимо установить <code>doctrine/dbal</code> пакет с помощью диспетчера пакетов
    Composer. Библиотека Doctrine DBAL используется для определения текущего состояния столбца и создания запросов SQL,
    необходимых для внесения запрошенных изменений в столбец:</p>
<pre class=" language-php"><code class=" language-php">composer <span class="token keyword">require</span> doctrine<span
                class="token operator">/</span>dbal</code></pre>
<p>Если вы планируете изменять столбцы, созданные с помощью этого <code>timestamp</code> метода, вы также должны
    добавить следующую конфигурацию в файл конфигурации вашего приложения <code>config/database.php</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                    class="token punctuation">\</span>DBAL<span
                    class="token punctuation">\</span>TimestampType</span><span class="token punctuation">;</span>

<span class="token single-quoted-string string">'dbal'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'types'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'timestamp'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> TimestampType<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Если ваше приложение использует Microsoft SQL Server, убедитесь, что вы установили
            <code>doctrine/dbal:^3.0</code>.</p></p></div>
</blockquote>
<p></p>
<h4 id="updating-column-attributes"><a href="#updating-column-attributes">Обновление атрибутов столбца</a></h4>
<p><code>change</code> Метод позволяет изменять тип и атрибуты существующих столбцов. Например, вы можете увеличить
    размер <code>string</code> столбца. Чтобы увидеть <code>change</code> метод в действии, давайте увеличим размер
    <code>name</code> столбца с 25 до 50. Для этого мы просто определяем новое состояние столбца, а затем вызываем
    <code>change</code> метод:</p>
<pre class=" language-php"><code class=" language-php">Schema<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>Blueprint <span class="token variable">$table</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">string</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'name'</span><span class="token punctuation">,</span> <span
                class="token number">50</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">change</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Мы также можем изменить столбец, чтобы он допускал значение NULL:</p>
<pre class=" language-php"><code class=" language-php">Schema<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>Blueprint <span class="token variable">$table</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">string</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'name'</span><span class="token punctuation">,</span> <span
                class="token number">50</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">nullable</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">change</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Следующие типы столбцов могут быть изменены: <code>bigInteger</code>, <code>binary</code>,
            <code>boolean</code>, <code>date</code>, <code>dateTime</code>, <code>dateTimeTz</code>,
            <code>decimal</code>, <code>integer</code>, <code>json</code>, <code>longText</code>,
            <code>mediumText</code>, <code>smallInteger</code>, <code>string</code>, <code>text</code>,
            <code>time</code>, <code>unsignedBigInteger</code>, <code>unsignedInteger</code>,
            <code>unsignedSmallInteger</code>, и <code>uuid</code>. Чтобы изменить <code>timestamp</code> тип столбца,
            <a href="migrations#prerequisites">необходимо зарегистрировать</a> тип <a href="migrations#prerequisites">Doctrine</a>.
        </p></p></div>
</blockquote>
<p></p>
<h4 id="renaming-columns"><a href="#renaming-columns">Переименование столбцов</a></h4>
<p>Чтобы переименовать столбец, вы можете использовать <code>renameColumn</code> метод, предоставляемый схемой
    построителя схемы. Перед переименованием столбца убедитесь, что вы установили <code>doctrine/dbal</code> библиотеку
    через диспетчер пакетов Composer:</p>
<pre class=" language-php"><code class=" language-php">Schema<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>Blueprint <span class="token variable">$table</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">renameColumn</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'from'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'to'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Переименование <code>enum</code> столбца в настоящее время не поддерживается.</p></p></div>
</blockquote>
<p></p>
<h3 id="dropping-columns"><a href="#dropping-columns">Удаление столбцов</a></h3>
<p>Чтобы удалить столбец, вы можете использовать <code>dropColumn</code> метод на чертеже построителя схемы. Если ваше
    приложение использует базу данных SQLite, вы должны установить <code>doctrine/dbal</code> пакет через диспетчер
    пакетов Composer, прежде чем <code>dropColumn</code> метод может быть использован:</p>
<pre class=" language-php"><code class=" language-php">Schema<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>Blueprint <span class="token variable">$table</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">dropColumn</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'votes'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы можете удалить несколько столбцов из таблицы, передав в <code>dropColumn</code> метод массив имен столбцов:</p>
<pre class=" language-php"><code class=" language-php">Schema<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>Blueprint <span class="token variable">$table</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">dropColumn</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'votes'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'avatar'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'location'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p> Удаление или изменение нескольких столбцов в рамках одной миграции при использовании базы данных SQLite не
            поддерживается.</p></p></div>
</blockquote>
<p></p>
<h4 id="available-command-aliases"><a href="#available-command-aliases">Доступные псевдонимы команд</a></h4>
<p>Laravel предоставляет несколько удобных методов, связанных с удалением общих типов столбцов. Каждый из этих методов
    описан в таблице ниже:</p>
<table>
    <thead>
    <tr>
        <th>Команда</th>
        <th>Описание</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td><code>$table-&gt;dropMorphs('morphable');</code></td>
        <td>Отбросьте <code>morphable_id</code> и <code>morphable_type</code> столбцы.</td>
    </tr>
    <tr>
        <td><code>$table-&gt;dropRememberToken();</code></td>
        <td>Отбросьте <code>remember_token</code> столбец.</td>
    </tr>
    <tr>
        <td><code>$table-&gt;dropSoftDeletes();</code></td>
        <td>Отбросьте <code>deleted_at</code> столбец.</td>
    </tr>
    <tr>
        <td><code>$table-&gt;dropSoftDeletesTz();</code></td>
        <td>Псевдоним <code>dropSoftDeletes()</code> метода.</td>
    </tr>
    <tr>
        <td><code>$table-&gt;dropTimestamps();</code></td>
        <td>Отбросьте <code>created_at</code> и <code>updated_at</code> столбцы.</td>
    </tr>
    <tr>
        <td><code>$table-&gt;dropTimestampsTz();</code></td>
        <td>Псевдоним <code>dropTimestamps()</code> метода.</td>
    </tr>
    </tbody>
</table>
<p></p>
<h2 id="indexes"><a href="#indexes">Индексы</a></h2>
<p></p>
<h3 id="creating-indexes"><a href="#creating-indexes">Создание индексов</a></h3>
<p>Конструктор схем Laravel поддерживает несколько типов индексов. В следующем примере создается новый
    <code>email</code> столбец и указывается, что его значения должны быть уникальными. Чтобы создать индекс, мы можем
    связать <code>unique</code> метод с определением столбца:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                    class="token punctuation">\</span>Schema<span
                    class="token punctuation">\</span>Blueprint</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Schema</span><span
                class="token punctuation">;</span>

Schema<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">table</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'users'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span>Blueprint <span
                class="token variable">$table</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">string</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'email'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">unique</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>В качестве альтернативы вы можете создать индекс после определения столбца. Для этого вы должны вызвать
    <code>unique</code> метод на чертеже построителя схемы. Этот метод принимает имя столбца, который должен получить
    уникальный индекс:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">unique</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'email'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы даже можете передать массив столбцов методу индекса для создания составного (или составного) индекса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">index</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'account_id'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'created_at'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>При создании индекса Laravel автоматически сгенерирует имя индекса на основе таблицы, имен столбцов и типа индекса,
    но вы можете передать второй аргумент методу, чтобы указать имя индекса самостоятельно:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">unique</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'email'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'unique_email'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="available-index-types"><a href="#available-index-types">Доступные типы индексов</a></h4>
<p>Класс схемы построения схемы Laravel предоставляет методы для создания каждого типа индекса, поддерживаемого Laravel.
    Каждый метод индекса принимает необязательный второй аргумент для указания имени индекса. Если опущено, имя будет
    производным от имен таблицы и столбцов, используемых для индекса, а также типа индекса. Каждый из доступных методов
    индекса описан в таблице ниже:</p>
<table>
    <thead>
    <tr>
        <th>Команда</th>
        <th>Описание</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td><code>$table-&gt;primary('id');</code></td>
        <td>Добавляет первичный ключ.</td>
    </tr>
    <tr>
        <td><code>$table-&gt;primary(['id', 'parent_id']);</code></td>
        <td>Добавляет составные ключи.</td>
    </tr>
    <tr>
        <td><code>$table-&gt;unique('email');</code></td>
        <td>Добавляет уникальный индекс.</td>
    </tr>
    <tr>
        <td><code>$table-&gt;index('state');</code></td>
        <td>Добавляет индекс.</td>
    </tr>
    <tr>
        <td><code>$table-&gt;spatialIndex('location');</code></td>
        <td>Добавляет пространственный индекс (кроме SQLite).</td>
    </tr>
    </tbody>
</table>
<p></p>
<h4 id="index-lengths-mysql-mariadb"><a href="#index-lengths-mysql-mariadb">Длина индекса и MySQL / MariaDB</a></h4>
<p>По умолчанию Laravel использует <code>utf8mb4</code> набор символов. Если вы используете версию MySQL старше версии
    5.7.7 или MariaDB старше версии 10.2.2, вам может потребоваться вручную настроить длину строки по умолчанию,
    генерируемую миграциями, чтобы MySQL мог создавать для них индексы. Вы можете настроить длину строки по умолчанию,
    вызвав <code>Schema::defaultStringLength</code> метод внутри <code>boot</code> метода вашего <code>App\Providers\AppServiceProvider</code>
    класса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Schema</span><span
                class="token punctuation">;</span>

<span class="token comment">/**
 * Bootstrap any application services.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">boot</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    Schema<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">defaultStringLength</span><span
                class="token punctuation">(</span><span class="token number">191</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span></code></pre>
<p>Кроме того, вы можете включить эту <code>innodb_large_prefix</code> опцию для своей базы данных. Обратитесь к
    документации к вашей базе данных, чтобы узнать, как правильно включить эту опцию.</p>
<p></p>
<h3 id="renaming-indexes"><a href="#renaming-indexes">Переименование индексов</a></h3>
<p>Чтобы переименовать индекс, вы можете использовать <code>renameIndex</code> метод, предоставленный планом построителя
    схемы. Этот метод принимает текущее имя индекса в качестве первого аргумента и желаемое имя в качестве второго
    аргумента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">renameIndex</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'from'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'to'</span><span
                class="token punctuation">)</span></code></pre>
<p></p>
<h3 id="dropping-indexes"><a href="#dropping-indexes">Отбрасывание индексов</a></h3>
<p>Чтобы удалить индекс, вы должны указать имя индекса. По умолчанию Laravel автоматически назначает имя индекса на
    основе имени таблицы, имени индексированного столбца и типа индекса. Вот некоторые примеры:</p>
<table>
    <thead>
    <tr>
        <th>Команда</th>
        <th>Описание</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td><code>$table-&gt;dropPrimary('users_id_primary');</code></td>
        <td>Удалите первичный ключ из таблицы «пользователи».</td>
    </tr>
    <tr>
        <td><code>$table-&gt;dropUnique('users_email_unique');</code></td>
        <td>Удалите уникальный индекс из таблицы «пользователи».</td>
    </tr>
    <tr>
        <td><code>$table-&gt;dropIndex('geo_state_index');</code></td>
        <td>Удалите базовый индекс из таблицы "geo".</td>
    </tr>
    <tr>
        <td><code>$table-&gt;dropSpatialIndex('geo_location_spatialindex');</code></td>
        <td>Удалите пространственный индекс из таблицы "geo" (кроме SQLite).</td>
    </tr>
    </tbody>
</table>
<p>Если вы передадите массив столбцов в метод, который отбрасывает индексы, обычное имя индекса будет сгенерировано на
    основе имени таблицы, столбцов и типа индекса:</p>
<pre class=" language-php"><code class=" language-php">Schema<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'geo'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>Blueprint <span class="token variable">$table</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">dropIndex</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'state'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span> <span class="token comment">// Drops index 'geo_state_index'</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="foreign-key-constraints"><a href="#foreign-key-constraints">Ограничения внешнего ключа</a></h3>
<p>Laravel также поддерживает создание ограничений внешнего ключа, которые используются для обеспечения ссылочной
    целостности на уровне базы данных. Например, давайте определим <code>user_id</code> столбец в <code>posts</code>
    таблице, который ссылается на <code>id</code> столбец в <code>users</code> таблице:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                    class="token punctuation">\</span>Schema<span
                    class="token punctuation">\</span>Blueprint</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Schema</span><span
                class="token punctuation">;</span>

Schema<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">table</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'posts'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span>Blueprint <span
                class="token variable">$table</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">unsignedBigInteger</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'user_id'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
            
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">foreign</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'user_id'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">references</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'id'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">on</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'users'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Поскольку этот синтаксис довольно подробный, Laravel предоставляет дополнительные, более сжатые методы, которые
    используют соглашения, чтобы обеспечить лучший опыт разработчика. Пример выше можно переписать так:</p>
<pre class=" language-php"><code class=" language-php">Schema<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'posts'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>Blueprint <span class="token variable">$table</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">foreignId</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'user_id'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">constrained</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p><code>foreignId</code> Метод является псевдонимом в <code>unsignedBigInteger</code> то время как
    <code>constrained</code> метод будет использовать соглашения для определения таблицы и имя столбца которые
    ссылаются. Если имя вашей таблицы не соответствует соглашениям Laravel, вы можете указать имя таблицы, передав его в
    качестве аргумента <code>constrained</code> методу:</p>
<pre class=" language-php"><code class=" language-php">Schema<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'posts'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>Blueprint <span class="token variable">$table</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">foreignId</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'user_id'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">constrained</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы также можете указать желаемое действие для свойств ограничения «при удалении» и «при обновлении»:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">foreignId</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'user_id'</span><span
                class="token punctuation">)</span>
      <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">constrained</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
      <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">onUpdate</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'cascade'</span><span class="token punctuation">)</span>
      <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">onDelete</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'cascade'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Любые дополнительные <a href="migrations#column-modifiers">модификаторы столбца</a> должны быть вызваны перед <code>constrained</code>
    методом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">foreignId</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'user_id'</span><span
                class="token punctuation">)</span>
      <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">nullable</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
      <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">constrained</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="dropping-foreign-keys"><a href="#dropping-foreign-keys">Удаление внешних ключей</a></h4>
<p>Чтобы удалить внешний ключ, вы можете использовать этот <code>dropForeign</code> метод, передав имя удаляемого
    ограничения внешнего ключа в качестве аргумента. Ограничения внешнего ключа используют то же соглашение об именах,
    что и индексы. Другими словами, имя ограничения внешнего ключа основано на имени таблицы и столбцов в ограничении,
    за которыми следует суффикс «_foreign»:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">dropForeign</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'posts_user_id_foreign'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>В качестве альтернативы вы можете передать в <code>dropForeign</code> метод массив, содержащий имя столбца,
    содержащего внешний ключ. Массив будет преобразован в имя ограничения внешнего ключа с использованием соглашений об
    именах ограничений Laravel:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$table</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">dropForeign</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'user_id'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="toggling-foreign-key-constraints"><a href="#toggling-foreign-key-constraints">Переключение ограничений внешнего
        ключа</a></h4>
<p>Вы можете включить или отключить ограничения внешнего ключа в своих миграциях, используя следующие методы:</p>
<pre class=" language-php"><code class=" language-php">Schema<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">enableForeignKeyConstraints</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

Schema<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">disableForeignKeyConstraints</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>SQLite по умолчанию отключает ограничения внешнего ключа. При использовании SQLite обязательно <a
                    href="database#configuration">включите поддержку внешних ключей</a> в конфигурации вашей базы
            данных, прежде чем пытаться создать их в своих миграциях. Кроме того, SQLite поддерживает внешние ключи
            только при создании таблицы, а <a href="https://www.sqlite.org/omitted.html">не при изменении таблиц</a>.
        </p></p></div>
</blockquote> 
