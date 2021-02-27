<h1>Eloquent: начало работы <sup>Getting started</sup></h1>
<ul>
    <li><a href="eloquent#introduction">Вступление</a></li>
    <li><a href="eloquent#generating-model-classes">Создание классов модели</a></li>
    <li><a href="eloquent#eloquent-model-conventions">Красноречивые модельные соглашения</a>
        <ul>
            <li><a href="eloquent#table-names">Имена таблиц</a></li>
            <li><a href="eloquent#primary-keys">Основные ключи</a></li>
            <li><a href="eloquent#timestamps">Отметки времени</a></li>
            <li><a href="eloquent#database-connections">Подключения к базе данных</a></li>
            <li><a href="eloquent#default-attribute-values">Значения атрибутов по умолчанию</a></li>
        </ul>
    </li>
    <li><a href="eloquent#retrieving-models">Получение моделей</a>
        <ul>
            <li><a href="eloquent#collections">Коллекции</a></li>
            <li><a href="eloquent#chunking-results">Разделение результатов</a></li>
            <li><a href="eloquent#cursors">Курсоры</a></li>
            <li><a href="eloquent#advanced-subqueries">Расширенные подзапросы</a></li>
        </ul>
    </li>
    <li><a href="eloquent#retrieving-single-models">Получение отдельных моделей / агрегатов</a>
        <ul>
            <li><a href="eloquent#retrieving-or-creating-models">Получение или создание моделей</a></li>
            <li><a href="eloquent#retrieving-aggregates">Получение агрегатов</a></li>
        </ul>
    </li>
    <li><a href="eloquent#inserting-and-updating-models">Вставка и обновление моделей</a>
        <ul>
            <li><a href="eloquent#inserts">Вставки</a></li>
            <li><a href="eloquent#updates">Обновления</a></li>
            <li><a href="eloquent#mass-assignment">Массовое присвоение</a></li>
            <li><a href="eloquent#upserts">Upserts</a></li>
        </ul>
    </li>
    <li><a href="eloquent#deleting-models">Удаление моделей</a>
        <ul>
            <li><a href="eloquent#soft-deleting">Мягкое удаление</a></li>
            <li><a href="eloquent#querying-soft-deleted-models">Запрос мягко удаленных моделей</a></li>
        </ul>
    </li>
    <li><a href="eloquent#replicating-models">Репликация моделей</a></li>
    <li><a href="eloquent#query-scopes">Области запросов</a>
        <ul>
            <li><a href="eloquent#global-scopes">Глобальные области</a></li>
            <li><a href="eloquent#local-scopes">Локальные области</a></li>
        </ul>
    </li>
    <li><a href="eloquent#comparing-models">Сравнение моделей</a></li>
    <li><a href="eloquent#events">События</a>
        <ul>
            <li><a href="eloquent#events-using-closures">Использование замыканий</a></li>
            <li><a href="eloquent#observers">Наблюдатели</a></li>
            <li><a href="eloquent#muting-events">Отключение событий</a></li>
        </ul>
    </li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Laravel включает Eloquent, объектно-реляционный преобразователь (ORM), который позволяет с удовольствием
    взаимодействовать с вашей базой данных. При использовании Eloquent каждая таблица базы данных имеет соответствующую
    «Модель», которая используется для взаимодействия с этой таблицей. Помимо получения записей из таблицы базы данных,
    модели Eloquent позволяют также вставлять, обновлять и удалять записи из таблицы.</p>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Перед началом работы обязательно настройте соединение с базой данных в файле
            конфигурации <code>config/database.php</code>. Для получения дополнительных сведений о настройке базы данных ознакомьтесь
            с <a href="database#configuration">документацией по настройке базы данных</a>.
        </p></p></div>
</blockquote>
<p></p>
<h2 id="generating-model-classes"><a href="#generating-model-classes">Создание классов модели</a></h2>
<p>Для начала создадим модель Eloquent. Модели обычно находятся в <code>app\Models</code> каталоге и расширяют <code>Illuminate\Database\Eloquent\Model</code>
    класс. Вы можете использовать команду <code>make:model</code> <a href="artisan">Artisan</a> для создания новой
    модели:</p>
<pre class=" language-php"><code class=" language-php">php artisan make<span class="token punctuation">:</span>model Flight</code></pre>
<p>Если вы хотите сгенерировать <a href="migrations">миграцию базы данных</a> при создании модели, вы можете
    использовать параметр <code>--migration</code> или <code>-m</code>:</p>
<pre class=" language-php"><code class=" language-php">php artisan make<span class="token punctuation">:</span>model Flight <span
                class="token operator">--</span>migration</code></pre>
<p>При создании модели вы можете создавать различные другие типы классов, такие как фабрики, сеялки и контроллеры. Кроме
    того, эти параметры можно комбинировать для создания сразу нескольких классов:</p>
<pre class=" language-bash"><code class=" language-bash"><span class="token comment"># Generate a model and a FlightFactory class...</span>
php artisan make:model Flight --factory
php artisan make:model Flight -f

<span class="token comment"># Generate a model and a FlightSeeder class...</span>
php artisan make:model Flight --seed
php artisan make:model Flight -s

<span class="token comment"># Generate a model and a FlightController class...</span>
php artisan make:model Flight --controller
php artisan make:model Flight -c

<span class="token comment"># Generate a model and a migration, factory, seeder, and controller...</span>
php artisan make:model Flight -mfsc</code></pre>
<p></p>
<h2 id="eloquent-model-conventions"><a href="#eloquent-model-conventions">Красноречивые модельные соглашения</a></h2>
<p>Созданные командой модели <code>make:model</code> будут помещены в <code>app/Models</code> каталог. Давайте
    рассмотрим базовый класс модели и обсудим некоторые ключевые соглашения Eloquent:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Model</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">Flight</span> <span class="token keyword">extends</span> <span
                    class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h3 id="table-names"><a href="#table-names">Имена таблиц</a></h3>
<p>Взглянув на приведенный выше пример, вы могли заметить, что мы не указали Eloquent, какая таблица базы данных
    соответствует нашей <code>Flight</code> модели. По соглашению, имя класса во множественном числе будет
    использоваться в качестве имени таблицы, если другое имя не указано явно. Итак, в этом случае Eloquent будет
    предполагать, что <code>Flight</code> модель хранит записи в <code>flights</code> таблице, а <code>AirTrafficController</code>
    модель будет хранить записи в <code>air_traffic_controllers</code> таблице.</p>
<p>Если соответствующая таблица базы данных вашей модели не соответствует этому соглашению, вы можете вручную указать
    имя таблицы модели, определив <code>table</code> свойство в модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Model</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">Flight</span> <span class="token keyword">extends</span> <span
                    class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * The table associated with the model.
     *
     * @var string
     */</span>
    <span class="token keyword">protected</span> <span class="token variable">$table</span> <span
                    class="token operator">=</span> <span
                    class="token single-quoted-string string">'my_flights'</span><span
                    class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h3 id="primary-keys"><a href="#primary-keys">Основные ключи</a></h3>
<p>Eloquent также предполагает, что в соответствующей таблице базы данных каждой модели есть столбец с первичным ключом
    <code>id</code>. При необходимости вы можете определить защищенное <code>$primaryKey</code> свойство в своей модели,
    чтобы указать другой столбец, который служит первичным ключом вашей модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Model</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">Flight</span> <span class="token keyword">extends</span> <span
                    class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * The primary key associated with the table.
     *
     * @var string
     */</span>
    <span class="token keyword">protected</span> <span class="token variable">$primaryKey</span> <span
                    class="token operator">=</span> <span
                    class="token single-quoted-string string">'flight_id'</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Кроме того, Eloquent предполагает, что первичный ключ - это увеличивающееся целочисленное значение, что означает, что
    Eloquent автоматически преобразует первичный ключ в целое число. Если вы хотите использовать неинкрементный или
    нечисловой первичный ключ, вы должны определить общедоступное <code>$incrementing</code> свойство в вашей модели,
    для которого установлено <code>false</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">class</span> <span class="token class-name">Flight</span> <span class="token keyword">extends</span> <span
                    class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Indicates if the model's ID is auto-incrementing.
     *
     * @var bool
     */</span>
    <span class="token keyword">public</span> <span class="token variable">$incrementing</span> <span
                    class="token operator">=</span> <span class="token boolean constant">false</span><span
                    class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Если первичный ключ вашей модели не является целым числом, вы должны определить защищенное <code>$keyType</code>
    свойство в своей модели. Это свойство должно иметь значение <code>string</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">class</span> <span class="token class-name">Flight</span> <span class="token keyword">extends</span> <span
                    class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * The data type of the auto-incrementing ID.
     *
     * @var string
     */</span>
    <span class="token keyword">protected</span> <span class="token variable">$keyType</span> <span
                    class="token operator">=</span> <span class="token single-quoted-string string">'string'</span><span
                    class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h4 id="composite-primary-keys"><a href="#composite-primary-keys">«Составные» первичные ключи</a></h4>
<p>Eloquent требует, чтобы каждая модель имела по крайней мере один однозначно идентифицирующий «ID», который может
    служить ее первичным ключом. «Составные» первичные ключи не поддерживаются моделями Eloquent. Однако вы можете
    добавить дополнительные многоколоночные уникальные индексы к таблицам базы данных в дополнение к однозначно
    определяющему первичному ключу таблицы.</p>
<p></p>
<h3 id="timestamps"><a href="#timestamps">Отметки времени</a></h3>
<p>По умолчанию, красноречивый ожидает <code>created_at</code> и <code>updated_at</code> столбцы существуют на
    соответствующей таблице базы данных вашей модели. Eloquent автоматически устанавливает значения этих столбцов при
    создании или обновлении моделей. Если вы не хотите, чтобы эти столбцы автоматически управлялись Eloquent, вам
    следует определить <code>$timestamps</code> свойство в своей модели со значением <code>false</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Model</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">Flight</span> <span class="token keyword">extends</span> <span
                    class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Indicates if the model should be timestamped.
     *
     * @var bool
     */</span>
    <span class="token keyword">public</span> <span class="token variable">$timestamps</span> <span
                    class="token operator">=</span> <span class="token boolean constant">false</span><span
                    class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Если вам нужно настроить формат временных меток вашей модели, установите <code>$dateFormat</code> свойство для вашей
    модели. Это свойство определяет, как атрибуты даты хранятся в базе данных, а также их формат при сериализации модели
    в массив или JSON:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Model</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">Flight</span> <span class="token keyword">extends</span> <span
                    class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * The storage format of the model's date columns.
     *
     * @var string
     */</span>
    <span class="token keyword">protected</span> <span class="token variable">$dateFormat</span> <span
                    class="token operator">=</span> <span class="token single-quoted-string string">'U'</span><span
                    class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Если вам необходимо настроить имена столбцов, используемых для хранения временных меток, то можно определить <code>CREATED_AT</code>
    и <code>UPDATED_AT</code> константы на модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">class</span> <span class="token class-name">Flight</span> <span class="token keyword">extends</span> <span
                    class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">const</span> <span class="token constant">CREATED_AT</span> <span
                    class="token operator">=</span> <span
                    class="token single-quoted-string string">'creation_date'</span><span
                    class="token punctuation">;</span>
    <span class="token keyword">const</span> <span class="token constant">UPDATED_AT</span> <span
                    class="token operator">=</span> <span
                    class="token single-quoted-string string">'updated_date'</span><span
                    class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h3 id="database-connections"><a href="#database-connections">Подключения к базе данных</a></h3>
<p>По умолчанию все модели Eloquent будут использовать соединение с базой данных по умолчанию, настроенное для вашего
    приложения. Если вы хотите указать другое соединение, которое следует использовать при взаимодействии с определенной
    моделью, вы должны определить <code>$connection</code> свойство модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Model</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">Flight</span> <span class="token keyword">extends</span> <span
                    class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * The database connection that should be used by the model.
     *
     * @var string
     */</span>
    <span class="token keyword">protected</span> <span class="token variable">$connection</span> <span
                    class="token operator">=</span> <span class="token single-quoted-string string">'sqlite'</span><span
                    class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h3 id="default-attribute-values"><a href="#default-attribute-values">Значения атрибутов по умолчанию</a></h3>
<p>По умолчанию вновь созданный экземпляр модели не будет содержать никаких значений атрибутов. Если вы хотите
    определить значения по умолчанию для некоторых атрибутов вашей модели, вы можете определить <code>$attributes</code>
    свойство в своей модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Model</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">Flight</span> <span class="token keyword">extends</span> <span
                    class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * The model's default values for attributes.
     *
     * @var array
     */</span>
    <span class="token keyword">protected</span> <span class="token variable">$attributes</span> <span
                    class="token operator">=</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'delayed'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token boolean constant">false</span><span
                    class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h2 id="retrieving-models"><a href="#retrieving-models">Получение моделей</a></h2>
<p>После того, как вы создали модель и <a href="migrations#writing-migrations">связанную с ней таблицу базы данных</a>,
    вы готовы начать извлечение данных из своей базы данных. Вы можете думать о каждой модели Eloquent как о мощном <a
            href="queries">построителе запросов,</a> позволяющем плавно запрашивать таблицу базы данных, связанную с
    моделью. Метод модели <code>all</code> получит все записи из связанной с моделью таблицы базы данных:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Flight</span><span class="token punctuation">;</span>

<span class="token keyword">foreach</span> <span class="token punctuation">(</span>Flight<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token keyword">as</span> <span
                class="token variable">$flight</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">echo</span> <span class="token variable">$flight</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">name</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="building-queries"><a href="#building-queries">Создание запросов</a></h4>
<p>Метод Eloquent <code>all</code> вернет все результаты в таблице модели. Однако, поскольку каждая модель Eloquent
    служит <a href="queries">построителем запросов</a>, вы можете добавить дополнительные ограничения к запросам, а
    затем вызвать <code>get</code> метод для получения результатов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$flights</span> <span
                class="token operator">=</span> Flight<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'active'</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">)</span>
               <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">orderBy</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'name'</span><span class="token punctuation">)</span>
               <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">take</span><span class="token punctuation">(</span><span
                class="token number">10</span><span class="token punctuation">)</span>
               <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Поскольку модели Eloquent - это построители запросов, вам следует просмотреть все методы, предоставляемые <a
                    href="queries">построителем запросов</a> Laravel. Вы можете использовать любой из этих методов при
            написании ваших запросов Eloquent.</p></p></div>
</blockquote>
<p></p>
<h4 id="refreshing-models"><a href="#refreshing-models">Обновление моделей</a></h4>
<p>Если у вас уже есть экземпляр модели красноречив, которая извлекается из базы данных, вы можете «обновить» модель,
    используя <code>fresh</code> и <code>refresh</code> методы. <code>fresh</code> Метод будет повторно извлечь модель
    из базы данных. Существующий экземпляр модели не будет затронут:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$flight</span> <span
                class="token operator">=</span> Flight<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'number'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'FR 900'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">first</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$freshFlight</span> <span class="token operator">=</span> <span class="token variable">$flight</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">fresh</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p><code>refresh</code> Метод будет повторно гидратом существующей модели с использованием свежих данных из базы данных.
    Кроме того, все его загруженные отношения также будут обновлены:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$flight</span> <span
                class="token operator">=</span> Flight<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'number'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'FR 900'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">first</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$flight</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">number</span> <span class="token operator">=</span> <span
                class="token single-quoted-string string">'FR 456'</span><span class="token punctuation">;</span>

<span class="token variable">$flight</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">refresh</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$flight</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">number</span><span class="token punctuation">;</span> <span
                class="token comment">// "FR 900"</span></code></pre>
<p></p>
<h3 id="collections"><a href="#collections">Коллекции</a></h3>
<p>Как мы видели, методы Eloquent любят <code>all</code> и получают <code>get</code> несколько записей из базы данных.
    Однако эти методы не возвращают простой массив PHP. Вместо этого
    <code>Illuminate\Database\Eloquent\Collection</code> возвращается экземпляр.</p>
<p>Класс Eloquent <code>Collection</code> расширяет базовый <code>Illuminate\Support\Collection</code> класс Laravel,
    который предоставляет <a href="collections#available-methods">множество полезных методов</a> для взаимодействия с
    коллекциями данных. Например, <code>reject</code> метод может использоваться для удаления моделей из коллекции на
    основе результатов вызванного закрытия:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$flights</span> <span
                class="token operator">=</span> Flight<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">where</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'destination'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'Paris'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$flights</span> <span class="token operator">=</span> <span
                class="token variable">$flights</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">reject</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$flight</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$flight</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">cancelled</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>В дополнение к методам, предоставляемым классом базовой коллекции Laravel, класс коллекции Eloquent предоставляет <a
            href="eloquent-collections#available-methods">несколько дополнительных методов</a>, которые специально
    предназначены для взаимодействия с коллекциями моделей Eloquent.</p>
<p>Поскольку все коллекции Laravel реализуют итерируемые интерфейсы PHP, вы можете перебирать коллекции, как если бы они
    были массивом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">foreach</span> <span
                class="token punctuation">(</span><span class="token variable">$flights</span> <span
                class="token keyword">as</span> <span class="token variable">$flight</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">echo</span> <span class="token variable">$flight</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">name</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="chunking-results"><a href="#chunking-results">Разделение результатов</a></h3>
<p>Вашему приложению может не хватить памяти, если вы попытаетесь загрузить десятки тысяч записей Eloquent с помощью
    методов <code>all</code> или <code>get</code>. Вместо использования этих методов этот <code>chunk</code> метод можно
    использовать для более эффективной обработки большого количества моделей.</p>
<p><code>chunk</code> Метод извлечения подмножества моделей красноречив, передавая их закрытия для обработки. Поскольку
    одновременно извлекается только текущий фрагмент моделей Eloquent, этот <code>chunk</code> метод обеспечит
    значительно меньшее использование памяти при работе с большим количеством моделей:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Flight</span><span class="token punctuation">;</span>

Flight<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">chunk</span><span class="token punctuation">(</span><span class="token number">200</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$flights</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">foreach</span> <span class="token punctuation">(</span><span class="token variable">$flights</span> <span
                class="token keyword">as</span> <span class="token variable">$flight</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Первым аргументом, передаваемым <code>chunk</code> методу, является количество записей, которые вы хотите получить на
    «кусок». Замыкание, переданное вторым аргументом, будет вызываться для каждого фрагмента, полученного из базы
    данных. Будет выполнен запрос к базе данных для получения каждого фрагмента записей, переданных в закрытие.</p>
<p>Если вы фильтруете результаты <code>chunk</code> метода на основе столбца, который вы также будете обновлять во время
    итерации результатов, вам следует использовать этот <code>chunkById</code> метод. Использование <code>chunk</code>
    метода в этих сценариях может привести к неожиданным и противоречивым результатам. Внутренне <code>chunkById</code>
    метод всегда будет получать модели со <code>id</code> столбцом, большим, чем последняя модель в предыдущем
    фрагменте:</p>
<pre class=" language-php"><code class=" language-php">Flight<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'departed'</span><span
                class="token punctuation">,</span> <span class="token boolean constant">true</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">chunkById</span><span
                class="token punctuation">(</span><span class="token number">200</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$flights</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token variable">$flights</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">each</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">update</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'departed'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token boolean constant">false</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">,</span> <span class="token variable">$column</span> <span
                class="token operator">=</span> <span class="token single-quoted-string string">'id'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="cursors"><a href="#cursors">Курсоры</a></h3>
<p>Подобно <code>chunk</code> методу, <code>cursor</code> метод может использоваться для значительного сокращения
    потребления памяти вашим приложением при итерации десятков тысяч записей модели Eloquent.</p>
<p><code>cursor</code> Метод будет выполнять только один запрос к базе данных; однако отдельные модели Eloquent не будут
    гидратироваться, пока они не будут фактически повторены. Следовательно, только одна модель Eloquent хранится в
    памяти в любой момент времени при итерации по курсору. Внутри <code>cursor</code> метод использует <a
            href="https://www.php.net/manual/en/language.generators.overview.php">генераторы</a> PHP для реализации этой
    функции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Flight</span><span class="token punctuation">;</span>

<span class="token keyword">foreach</span> <span class="token punctuation">(</span>Flight<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">where</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'destination'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'Zurich'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">cursor</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token keyword">as</span> <span
                class="token variable">$flight</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p><code>cursor</code> Возвращает <code>Illuminate\Support\LazyCollection</code> экземпляр. <a
            href="collections#lazy-collections">Ленивые коллекции</a> позволяют использовать многие методы сбора,
    доступные в типичных коллекциях Laravel, при одновременной загрузке в память только одной модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

<span class="token variable">$users</span> <span class="token operator">=</span> User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">cursor</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">filter</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span> <span class="token operator">&gt;</span> <span
                class="token number">500</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">foreach</span> <span class="token punctuation">(</span><span
                class="token variable">$users</span> <span class="token keyword">as</span> <span class="token variable">$user</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">echo</span> <span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="advanced-subqueries"><a href="#advanced-subqueries">Расширенные подзапросы</a></h3>
<p></p>
<h4 id="subquery-selects"><a href="#subquery-selects">Подзапрос выбирает</a></h4>
<p>Eloquent также предлагает расширенную поддержку подзапросов, которая позволяет извлекать информацию из связанных
    таблиц в одном запросе. Например, представим, что у нас есть таблица рейсов <code>destinations</code> и таблица
    пунктов <code>flights</code> назначения. В <code>flights</code> таблице есть <code>arrived_at</code> столбец, в
    котором указано, когда рейс прибыл в пункт назначения.</p>
<p>Используя функциональность подзапросов, доступную для построителя запросов <code>select</code> и
    <code>addSelect</code> методов, мы можем выбрать все <code>destinations</code> и имя рейса, который самым последним
    прибыл в этот пункт назначения, с помощью одного запроса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Destination</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Models<span class="token punctuation">\</span>Flight</span><span
                class="token punctuation">;</span>

<span class="token keyword">return</span> Destination<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">addSelect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'last_flight'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> Flight<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">select</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">whereColumn</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'destination_id'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'destinations.id'</span><span
                class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">orderByDesc</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'arrived_at'</span><span class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">limit</span><span class="token punctuation">(</span><span
                class="token number">1</span><span class="token punctuation">)</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="subquery-ordering"><a href="#subquery-ordering">Порядок подзапросов</a></h4>
<p>Кроме того, <code>orderBy</code> функция построителя запросов поддерживает подзапросы. Продолжая использовать наш
    пример полета, мы можем использовать эту функцию для сортировки всех пунктов назначения в зависимости от того, когда
    последний рейс прибыл в этот пункт назначения. Опять же, это можно сделать при выполнении одного запроса к базе
    данных:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> Destination<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">orderByDesc</span><span
                class="token punctuation">(</span>
    Flight<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">select</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'arrived_at'</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">whereColumn</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'destination_id'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'destinations.id'</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">orderByDesc</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'arrived_at'</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">limit</span><span class="token punctuation">(</span><span
                class="token number">1</span><span class="token punctuation">)</span>
<span class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="retrieving-single-models"><a href="#retrieving-single-models">Получение отдельных моделей / агрегатов</a></h2>
<p>Помимо получения всех записей, соответствующих данного запроса, вы также можете получить отдельные записи, используя
    <code>find</code>, <code>first</code> или <code>firstWhere</code> методы. Вместо того, чтобы возвращать коллекцию
    моделей, эти методы возвращают единственный экземпляр модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Flight</span><span class="token punctuation">;</span>

<span class="token comment">// Retrieve a model by its primary key...</span>
<span class="token variable">$flight</span> <span class="token operator">=</span> Flight<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// Retrieve the first model matching the query constraints...</span>
<span class="token variable">$flight</span> <span class="token operator">=</span> Flight<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'active'</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">first</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// Alternative to retrieving the first model matching the query constraints...</span>
<span class="token variable">$flight</span> <span class="token operator">=</span> Flight<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">firstWhere</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'active'</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Иногда вам может потребоваться получить первый результат запроса или выполнить какое-либо другое действие, если
    результаты не найдены. <code>firstOr</code> Метод возвращает первый найденный результат запроса или, если не будут
    найдены никаких результатов, выполнить данное замыкание. Значение, возвращаемое закрытием, будет считаться
    результатом <code>firstOr</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$model</span> <span
                class="token operator">=</span> Flight<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'legs'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'&gt;'</span><span
                class="token punctuation">,</span> <span class="token number">3</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">firstOr</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="not-found-exceptions"><a href="#not-found-exceptions">Не найдено исключений</a></h4>
<p>Иногда вы можете создать исключение, если модель не найдена. Это особенно полезно для маршрутов или контроллеров. Эти
    <code>findOrFail</code> и <code>firstOrFail</code> методы будут извлекать первый результат запроса; однако, если
    результат не будет найден, <code>Illuminate\Database\Eloquent\ModelNotFoundException</code> будет брошено:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$flight</span> <span
                class="token operator">=</span> Flight<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">findOrFail</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$flight</span> <span class="token operator">=</span> Flight<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'legs'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'&gt;'</span><span
                class="token punctuation">,</span> <span class="token number">3</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">firstOrFail</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Если <code>ModelNotFoundException</code> не обнаружен, клиенту автоматически отправляется HTTP-ответ 404:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Flight</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/api/flights/{literal}{id}{/literal}'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$id</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> Flight<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">findOrFail</span><span
                class="token punctuation">(</span><span class="token variable">$id</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="retrieving-or-creating-models"><a href="#retrieving-or-creating-models">Получение или создание моделей</a></h3>
<p><code>firstOrCreate</code> Метод попытается найти запись в базе данных, используя данные пары столбец / значение.
    Если модель не может быть найдена в базе данных, будет вставлена ​​запись с атрибутами, полученными в результате
    объединения первого аргумента массива с необязательным вторым аргументом массива:</p>
<p><code>firstOrNew</code> Метод, как <code>firstOrCreate</code>, будет пытаться найти запись в базе данных,
    соответствующую заданные атрибуты. Однако, если модель не найдена, будет возвращен новый экземпляр модели. Обратите
    внимание, что модель, возвращенная пользователем <code>firstOrNew</code>, еще не сохранена в базе данных. Вам нужно
    будет вручную вызвать <code>save</code> метод, чтобы сохранить его:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Flight</span><span class="token punctuation">;</span>

<span class="token comment">// Retrieve flight by name or create it if it doesn't exist...</span>
<span class="token variable">$flight</span> <span class="token operator">=</span> Flight<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">firstOrCreate</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'London to Paris'</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// Retrieve flight by name or create it with the name, delayed, and arrival_time attributes...</span>
<span class="token variable">$flight</span> <span class="token operator">=</span> Flight<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">firstOrCreate</span><span
                class="token punctuation">(</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'London to Paris'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'delayed'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'arrival_time'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'11:30'</span><span class="token punctuation">]</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// Retrieve flight by name or instantiate a new Flight instance...</span>
<span class="token variable">$flight</span> <span class="token operator">=</span> Flight<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">firstOrNew</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'London to Paris'</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// Retrieve flight by name or instantiate with the name, delayed, and arrival_time attributes...</span>
<span class="token variable">$flight</span> <span class="token operator">=</span> Flight<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">firstOrNew</span><span
                class="token punctuation">(</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Tokyo to Sydney'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'delayed'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'arrival_time'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'11:30'</span><span class="token punctuation">]</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="retrieving-aggregates"><a href="#retrieving-aggregates">Получение агрегатов</a></h3>
<p>При взаимодействии с моделями красноречивы, вы можете также использовать <code>count</code>, <code>sum</code>, <code>max</code>
    и другие <a href="queries#aggregates">агрегатные методы</a>, предоставляемые Laravel <a href="queries">построитель
        запросов</a>. Как и следовало ожидать, эти методы возвращают скалярное значение вместо экземпляра модели
    Eloquent:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$count</span> <span
                class="token operator">=</span> Flight<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'active'</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">count</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$max</span> <span class="token operator">=</span> Flight<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'active'</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">max</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'price'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="inserting-and-updating-models"><a href="#inserting-and-updating-models">Вставка и обновление моделей</a></h2>
<p></p>
<h3 id="inserts"><a href="#inserts">Вставки</a></h3>
<p>Конечно, при использовании Eloquent нам нужно не только извлекать модели из базы данных. Также нам нужно вставить
    новые записи. К счастью, Eloquent делает это просто. Чтобы вставить новую запись в базу данных, вы должны создать
    экземпляр новой модели и установить атрибуты модели. Затем вызовите <code>save</code> метод экземпляра модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>Controller</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span
                        class="token punctuation">\</span>Flight</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">FlightController</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Store a new flight in the database.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span
                    class="token function">store</span><span class="token punctuation">(</span>Request <span
                    class="token variable">$request</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">// Validate the request...</span>

        <span class="token variable">$flight</span> <span class="token operator">=</span> <span class="token keyword">new</span> <span
                    class="token class-name">Flight</span><span class="token punctuation">;</span>

        <span class="token variable">$flight</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token property">name</span> <span class="token operator">=</span> <span
                    class="token variable">$request</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token property">name</span><span
                    class="token punctuation">;</span>

        <span class="token variable">$flight</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">save</span><span class="token punctuation">(</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>В этом примере мы назначаем <code>name</code> поле из входящего HTTP-запроса <code>name</code> атрибуту <code>App\Models\Flight</code>
    экземпляра модели. Когда мы вызываем <code>save</code> метод, запись будет вставлена ​​в базу данных. Модель <code>created_at</code>
    и <code>updated_at</code> временные метки будут автоматически установлены при <code>save</code> вызове метода,
    поэтому нет необходимости устанавливать их вручную.</p>
<p>В качестве альтернативы вы можете использовать этот <code>create</code> метод для «сохранения» новой модели с помощью
    одного оператора PHP. Вставленный экземпляр модели будет возвращен вам <code>create</code> методом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Flight</span><span class="token punctuation">;</span>

<span class="token variable">$flight</span> <span class="token operator">=</span> Flight<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'London to Paris'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Однако перед использованием <code>create</code> метода вам необходимо указать свойство <code>fillable</code> или
    <code>guarded</code> в классе модели. Эти свойства необходимы, потому что все модели Eloquent по умолчанию защищены
    от уязвимостей массового назначения. Чтобы узнать больше о массовом назначении, обратитесь к документации по <a
            href="eloquent#mass-assignment">массовому назначению</a>.</p>
<p></p>
<h3 id="updates"><a href="#updates">Обновления</a></h3>
<p>Этот <code>save</code> метод также можно использовать для обновления моделей, которые уже существуют в базе данных.
    Чтобы обновить модель, вы должны получить ее и установить любые атрибуты, которые вы хотите обновить. Затем вы
    должны вызвать метод модели <code>save</code>. Опять же, <code>updated_at</code> метка времени будет обновлена
    ​​автоматически, поэтому нет необходимости вручную устанавливать ее значение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Flight</span><span class="token punctuation">;</span>

<span class="token variable">$flight</span> <span class="token operator">=</span> Flight<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$flight</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">name</span> <span class="token operator">=</span> <span
                class="token single-quoted-string string">'Paris to London'</span><span
                class="token punctuation">;</span>

<span class="token variable">$flight</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">save</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="mass-updates"><a href="#mass-updates">Массовые обновления</a></h4>
<p>Обновления также могут выполняться для моделей, соответствующих заданному запросу. В этом примере все рейсы, которые
    есть <code>active</code> и имеют <code>destination</code> из, <code>San Diego</code> будут помечены как задержанные:
</p>
<pre class=" language-php"><code class=" language-php">Flight<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'active'</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">where</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'destination'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'San Diego'</span><span class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">update</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'delayed'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">1</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p><code>update</code> Метод ожидает массив столбцов и пар значений, представляющих столбцы, которые должны быть
    обновлены.</p>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>При выпуске обновления массы через красноречивый, тем <code>saving</code>, <code>saved</code>,
            <code>updating</code>, и <code>updated</code> модель события не уволят для обновленных моделей. Это потому,
            что модели никогда не извлекаются при массовом обновлении.</p></p></div>
</blockquote>
<p></p>
<h4 id="examining-attribute-changes"><a href="#examining-attribute-changes">Изучение изменений атрибутов</a></h4>
<p>Красноречивым предоставляет <code>isDirty</code>, <code>isClean</code> и <code>wasChanged</code> методы для изучения
    внутреннего состояния модели и определить, как его атрибуты изменились с момента, когда модель была первоначально
    восстановлена.</p>
<p><code>isDirty</code> Метод определяет, будет ли какое - либо из атрибутов модели было изменено, так как модель была
    извлечена. Вы можете передать конкретное имя атрибута <code>isDirty</code> методу, чтобы определить, является ли
    конкретный атрибут грязным. Он <code>isClean</code> определит, остался ли атрибут неизменным с момента получения
    модели. Этот метод также принимает необязательный аргумент атрибута:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

<span class="token variable">$user</span> <span class="token operator">=</span> User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'first_name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Taylor'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'last_name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Otwell'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'title'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Developer'</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">title</span> <span
                class="token operator">=</span> <span class="token single-quoted-string string">'Painter'</span><span
                class="token punctuation">;</span>

<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">isDirty</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span> <span class="token comment">// true</span>
<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">isDirty</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'title'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span> <span class="token comment">// true</span>
<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">isDirty</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'first_name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span> <span class="token comment">// false</span>

<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">isClean</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span> <span class="token comment">// false</span>
<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">isClean</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'title'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span> <span class="token comment">// false</span>
<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">isClean</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'first_name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span> <span class="token comment">// true</span>

<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">save</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">isDirty</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span> <span class="token comment">// false</span>
<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">isClean</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span> <span class="token comment">// true</span></code></pre>
<p><code>wasChanged</code> Метод определяет, какие атрибуты были изменены, когда модель была последней сохраненными в
    пределах текущего цикла обработки запроса. При необходимости вы можете передать имя атрибута, чтобы увидеть, был ли
    изменен конкретный атрибут:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'first_name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Taylor'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'last_name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Otwell'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'title'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Developer'</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">title</span> <span
                class="token operator">=</span> <span class="token single-quoted-string string">'Painter'</span><span
                class="token punctuation">;</span>

<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">save</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">wasChanged</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span> <span class="token comment">// true</span>
<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">wasChanged</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'title'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span> <span class="token comment">// true</span>
<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">wasChanged</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'first_name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span> <span class="token comment">// false</span></code></pre>
<p><code>getOriginal</code> Метод возвращает массив, содержащий исходные атрибуты модели независимо от каких - либо
    изменений в модель, так как он был получен. При необходимости вы можете передать конкретное имя атрибута, чтобы
    получить исходное значение определенного атрибута:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">name</span><span
                class="token punctuation">;</span> <span class="token comment">// John</span>
<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">email</span><span
                class="token punctuation">;</span> <span class="token comment">// john@example.com</span>

<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">name</span> <span class="token operator">=</span> <span
                class="token double-quoted-string string">"Jack"</span><span class="token punctuation">;</span>
<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">name</span><span
                class="token punctuation">;</span> <span class="token comment">// Jack</span>

<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">getOriginal</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span> <span class="token comment">// John</span>
<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">getOriginal</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span> <span class="token comment">// Array of original attributes...</span></code></pre>
<p></p>
<h3 id="mass-assignment"><a href="#mass-assignment">Массовое присвоение</a></h3>
<p>Вы можете использовать этот <code>create</code> метод для «сохранения» новой модели с помощью одного оператора PHP.
    Вставленный экземпляр модели будет возвращен вам методом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Flight</span><span class="token punctuation">;</span>

<span class="token variable">$flight</span> <span class="token operator">=</span> Flight<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'London to Paris'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Однако перед использованием <code>create</code> метода вам необходимо указать свойство <code>fillable</code> или
    <code>guarded</code> в классе модели. Эти свойства необходимы, потому что все модели Eloquent по умолчанию защищены
    от уязвимостей массового назначения.</p>
<p>Уязвимость массового назначения возникает, когда пользователь передает неожиданное поле HTTP-запроса, и это поле
    изменяет столбец в вашей базе данных, чего вы не ожидали. Например, злоумышленник может отправить
    <code>is_admin</code> параметр через HTTP-запрос, который затем передается в <code>create</code> метод вашей модели,
    позволяя пользователю перейти на уровень администратора.</p>
<p>Итак, для начала вы должны определить, какие атрибуты модели вы хотите сделать массово назначаемыми. Вы можете
    сделать это, используя <code>$fillable</code> свойство модели. Например, давайте сделаем <code>name</code> атрибут
    нашей <code>Flight</code> модели массовым:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Model</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">Flight</span> <span class="token keyword">extends</span> <span
                    class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * The attributes that are mass assignable.
     *
     * @var array
     */</span>
    <span class="token keyword">protected</span> <span class="token variable">$fillable</span> <span class="token operator">=</span> <span
                    class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span><span
                    class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
<p>После того, как вы указали, какие атрибуты могут быть назначены массово, вы можете использовать этот
    <code>create</code> метод для вставки новой записи в базу данных. <code>create</code> Метод возвращает вновь
    созданный экземпляр модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$flight</span> <span
                class="token operator">=</span> Flight<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'London to Paris'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Если у вас уже есть экземпляр модели, вы можете использовать этот <code>fill</code> метод, чтобы заполнить его
    массивом атрибутов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$flight</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">fill</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Amsterdam to Frankfurt'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="mass-assignment-json-columns"><a href="#mass-assignment-json-columns">Массовое присвоение и столбцы JSON</a>
</h4>
<p>При назначении столбцов JSON необходимо указать массово назначаемый ключ каждого столбца в массиве вашей модели
    <code>$fillable</code>. В целях безопасности Laravel не поддерживает обновление вложенных атрибутов JSON при
    использовании <code>guarded</code> свойства:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
* The attributes that are mass assignable.
*
* @var array
*/</span>
<span class="token keyword">protected</span> <span class="token variable">$fillable</span> <span class="token operator">=</span> <span
                class="token punctuation">[</span>
    <span class="token single-quoted-string string">'options-&gt;enabled'</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="allowing-mass-assignment"><a href="#allowing-mass-assignment">Разрешение массового назначения</a></h4>
<p>Если вы хотите, чтобы все ваши атрибуты были массово назначаемыми, вы можете определить <code>$guarded</code>
    свойство вашей модели как пустой массив. Если вы unguard вашей модели, вы должны проявлять особую осторожность,
    чтобы всегда ручной ремеслу массивов, переданные Eloquent - х <code>fill</code>, <code>create</code> и
    <code>update</code> методы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
* The attributes that aren't mass assignable.
 *
 * @var array
 */</span>
<span class="token keyword">protected</span> <span class="token variable">$guarded</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span><span class="token punctuation">]</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="upserts"><a href="#upserts">Upserts</a></h3>
<p>Иногда вам может потребоваться обновить существующую модель или создать новую, если подходящей модели не существует.
    Как и <code>firstOrCreate</code> метод, <code>updateOrCreate</code> метод сохраняет модель, поэтому нет
    необходимости вызывать <code>save</code> метод вручную.</p>
<p>В приведенном ниже пример, если существует полет с <code>departure</code> расположением <code>Oakland</code> и <code>destination</code>
    расположением <code>San Diego</code>, его <code>price</code> и <code>discounted</code> столбцы будут обновлены. Если
    такой рейс не существует, будет создан новый рейс с атрибутами, полученными в результате слияния первого массива
    аргументов со вторым массивом аргументов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$flight</span> <span
                class="token operator">=</span> Flight<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">updateOrCreate</span><span
                class="token punctuation">(</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'departure'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Oakland'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'destination'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'San Diego'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'price'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">99</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'discounted'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">1</span><span
                class="token punctuation">]</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если вы хотите выполнить несколько «upserts» в одном запросе, вам следует <code>upsert</code> вместо этого
    использовать этот метод. Первый аргумент метода состоит из значений для вставки или обновления, а второй аргумент
    перечисляет столбцы, которые однозначно идентифицируют записи в связанной таблице. Третий и последний аргумент
    метода - это массив столбцов, который следует обновить, если соответствующая запись уже существует в базе данных.
    <code>upsert</code> Метод будет автоматически устанавливать <code>created_at</code> и <code>updated_at</code>
    временные метки, если временные метки включены на модели:</p>
<pre class=" language-php"><code class=" language-php">Flight<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">upsert</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'departure'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Oakland'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'destination'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'San Diego'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'price'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">99</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'departure'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Chicago'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'destination'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'New York'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'price'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">150</span><span class="token punctuation">]</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span><span
                class="token single-quoted-string string">'departure'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'destination'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span><span class="token single-quoted-string string">'price'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Все системы баз данных, кроме SQL Server, требуют, чтобы столбцы во втором аргументе, передаваемом <code>upsert</code>
            методу, имели «первичный» или «уникальный» индекс.</p></p></div>
</blockquote>
<p></p>
<h2 id="deleting-models"><a href="#deleting-models">Удаление моделей</a></h2>
<p>Чтобы удалить модель, вы можете вызвать <code>delete</code> метод экземпляра модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Flight</span><span class="token punctuation">;</span>

<span class="token variable">$flight</span> <span class="token operator">=</span> Flight<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$flight</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">delete</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="deleting-an-existing-model-by-its-primary-key"><a href="#deleting-an-existing-model-by-its-primary-key">Удаление
        существующей модели по ее первичному ключу</a></h4>
<p>В приведенном выше примере мы получаем модель из базы данных перед вызовом <code>delete</code> метода. Однако, если
    вы знаете первичный ключ модели, вы можете удалить модель, не извлекая ее явно, вызвав <code>destroy</code> метод.
    Помимо приема одного первичного ключа, <code>destroy</code> метод будет принимать несколько первичных ключей, массив
    первичных ключей или <a href="collections">коллекцию</a> первичных ключей:</p>
<pre class=" language-php"><code class=" language-php">Flight<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">destroy</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

Flight<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">destroy</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">,</span> <span class="token number">2</span><span
                class="token punctuation">,</span> <span class="token number">3</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

Flight<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">destroy</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

Flight<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">destroy</span><span
                class="token punctuation">(</span><span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>В <code>destroy</code> методе нагрузка для каждой модели в отдельности и вызывает <code>delete</code> метод
            так, что <code>deleting</code> и <code>deleted</code> событие должным образом послано для каждой модели.
        </p></p></div>
</blockquote>
<p></p>
<h4 id="deleting-models-using-queries"><a href="#deleting-models-using-queries">Удаление моделей с помощью запросов</a>
</h4>
<p>Конечно, вы можете создать запрос Eloquent для удаления всех моделей, соответствующих критериям вашего запроса. В
    этом примере мы удалим все рейсы, отмеченные как неактивные. Как и массовые обновления, массовые удаления не будут
    отправлять события модели для удаляемых моделей:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$deletedRows</span> <span
                class="token operator">=</span> Flight<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'active'</span><span
                class="token punctuation">,</span> <span class="token number">0</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">delete</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>При выполнении оператора массового удаления через Eloquent события <code>deleting</code> и
            <code>deleted</code> модели не будут отправляться для удаленных моделей. Это связано с тем, что модели
            никогда не извлекаются при выполнении оператора удаления.</p></p></div>
</blockquote>
<p></p>
<h3 id="soft-deleting"><a href="#soft-deleting">Мягкое удаление</a></h3>
<p>Помимо фактического удаления записей из вашей базы данных, Eloquent может также выполнять «мягкое удаление» моделей.
    Когда модели мягко удаляются, они фактически не удаляются из вашей базы данных. Вместо этого <code>deleted_at</code>
    в модели устанавливается атрибут, указывающий дату и время, когда модель была «удалена». Чтобы включить мягкое
    удаление для модели, добавьте <code>Illuminate\Database\Eloquent\SoftDeletes</code> признак в модель:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Model</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>SoftDeletes</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">Flight</span> <span class="token keyword">extends</span> <span
                    class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">use</span> <span class="token package">SoftDeletes</span><span
                    class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p><code>SoftDeletes</code> Черта будет автоматически бросить <code>deleted_at</code> атрибут к
            <code>DateTime</code> / <code>Carbon</code> например, для вас.</p></p></div>
</blockquote>
<p>Вы также должны добавить <code>deleted_at</code> столбец в таблицу базы данных. Построитель <a href="migrations">схемы</a>
    Laravel содержит вспомогательный метод для создания этого столбца:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                    class="token punctuation">\</span>Schema<span
                    class="token punctuation">\</span>Blueprint</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Facades<span
                    class="token punctuation">\</span>Schema</span><span class="token punctuation">;</span>

Schema<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">table</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'flights'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span>Blueprint <span
                class="token variable">$table</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">softDeletes</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

Schema<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">table</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'flights'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span>Blueprint <span
                class="token variable">$table</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">dropSoftDeletes</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Теперь, когда вы вызываете <code>delete</code> метод модели, в <code>deleted_at</code> столбце будут установлены
    текущие дата и время. Однако запись в базе данных модели останется в таблице. При запросе модели, которая использует
    мягкое удаление, мягко удаленные модели будут автоматически исключены из всех результатов запроса.</p>
<p>Чтобы определить, был ли данный экземпляр модели удален, вы можете использовать <code>trashed</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">if</span> <span
                class="token punctuation">(</span><span class="token variable">$flight</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">trashed</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="restoring-soft-deleted-models"><a href="#restoring-soft-deleted-models">Восстановление мягко удаленных
        моделей</a></h4>
<p>Иногда вы можете захотеть «отменить удаление» модели с обратимым удалением. Чтобы восстановить мягко удаленную
    модель, вы можете вызвать <code>restore</code> метод для экземпляра модели. <code>restore</code> Метод будет
    установлен в модели <code>deleted_at</code> столбца <code>null</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$flight</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">restore</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы также можете использовать этот <code>restore</code> метод в запросе для восстановления нескольких моделей. Опять
    же, как и другие «массовые» операции, при этом не будут отправляться какие-либо события модели для восстанавливаемых
    моделей:</p>
<pre class=" language-php"><code class=" language-php">Flight<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">withTrashed</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">where</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'airline_id'</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">restore</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Этот <code>restore</code> метод также можно использовать при построении запросов <a href="eloquent-relationships">отношений</a>:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$flight</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">history</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">restore</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="permanently-deleting-models"><a href="#permanently-deleting-models">Окончательное удаление моделей</a></h4>
<p>Иногда вам может потребоваться действительно удалить модель из вашей базы данных. Вы можете использовать этот <code>forceDelete</code>
    метод для безвозвратного удаления модели с обратимым удалением из таблицы базы данных:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$flight</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">forceDelete</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы также можете использовать этот <code>forceDelete</code> метод при построении запросов на отношения Eloquent:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$flight</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">history</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">forceDelete</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="querying-soft-deleted-models"><a href="#querying-soft-deleted-models">Запрос мягко удаленных моделей</a></h3>
<p></p>
<h4 id="including-soft-deleted-models"><a href="#including-soft-deleted-models">Включение мягко удаленных моделей</a>
</h4>
<p>Как отмечалось выше, мягко удаленные модели автоматически исключаются из результатов запроса. Однако вы можете
    принудительно включить мягко удаленные модели в результаты запроса, вызвав <code>withTrashed</code> метод запроса:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Flight</span><span class="token punctuation">;</span>

<span class="token variable">$flights</span> <span class="token operator">=</span> Flight<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">withTrashed</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">where</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'account_id'</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p><code>withTrashed</code> Метод также может быть вызван при построении <a href="eloquent-relationships">отношений</a>
    запроса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$flight</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">history</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">withTrashed</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="retrieving-only-soft-deleted-models"><a href="#retrieving-only-soft-deleted-models">Получение только мягко
        удаленных моделей</a></h4>
<p><code>onlyTrashed</code> Метод будет получать <strong>только</strong> мягкие удаленные модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$flights</span> <span
                class="token operator">=</span> Flight<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">onlyTrashed</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">where</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'airline_id'</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="replicating-models"><a href="#replicating-models">Репликация моделей</a></h2>
<p>Вы можете создать несохраненную копию существующего экземпляра модели, используя этот <code>replicate</code> метод.
    Этот метод особенно полезен, когда у вас есть экземпляры модели, которые имеют много одинаковых атрибутов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Address</span><span class="token punctuation">;</span>

<span class="token variable">$shipping</span> <span class="token operator">=</span> Address<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'type'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'shipping'</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'line_1'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'123 Example Street'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'city'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Victorville'</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'state'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'CA'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'postcode'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'90001'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$billing</span> <span class="token operator">=</span> <span class="token variable">$shipping</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">replicate</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">fill</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span>
    <span class="token single-quoted-string string">'type'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'billing'</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$billing</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">save</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="query-scopes"><a href="#query-scopes">Области запросов</a></h2>
<p></p>
<h3 id="global-scopes"><a href="#global-scopes">Глобальные области</a></h3>
<p>Глобальные области позволяют добавлять ограничения ко всем запросам для данной модели. Собственная функция <a
            href="eloquent#soft-deleting">мягкого удаления</a> Laravel использует глобальные области для извлечения
    только «не удаленных» моделей из базы данных. Написание собственных глобальных областей действия может предоставить
    удобный и простой способ убедиться, что каждый запрос для данной модели имеет определенные ограничения.</p>
<p></p>
<h4 id="writing-global-scopes"><a href="#writing-global-scopes">Написание глобальных областей видимости</a></h4>
<p>Написать глобальную область видимости просто. Сначала определите класс, реализующий <code>Illuminate\Database\Eloquent\Scope</code>
    интерфейс. В Laravel нет обычного места для размещения классов области видимости, поэтому вы можете разместить этот
    класс в любом каталоге, который хотите.</p>
<p><code>Scope</code> Интерфейс требует, чтобы реализовать один метод: <code>apply</code>. При необходимости
    <code>apply</code> метод может добавлять <code>where</code> в запрос ограничения или другие типы предложений:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Scopes</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span class="token punctuation">\</span>Builder</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Model</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Scope</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">AncientScope</span> <span class="token keyword">implements</span> <span
                    class="token class-name">Scope</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Apply the scope to a given Eloquent query builder.
     *
     * @param  \Illuminate\Database\Eloquent\Builder  $builder
     * @param  \Illuminate\Database\Eloquent\Model  $model
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">apply</span><span
                    class="token punctuation">(</span>Builder <span class="token variable">$builder</span><span
                    class="token punctuation">,</span> Model <span class="token variable">$model</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$builder</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">where</span><span class="token punctuation">(</span><span
                    class="token single-quoted-string string">'created_at'</span><span
                    class="token punctuation">,</span> <span
                    class="token single-quoted-string string">'&lt;'</span><span
                    class="token punctuation">,</span> <span class="token function">now</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">subYears</span><span
                    class="token punctuation">(</span><span class="token number">2000</span><span
                    class="token punctuation">)</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Если ваша глобальная область действия добавляет столбцы в предложение select запроса, вы должны использовать
            <code>addSelect</code> метод вместо <code>select</code>. Это предотвратит непреднамеренную замену
            существующего предложения select запроса.</p></p></div>
</blockquote>
<p></p>
<h4 id="applying-global-scopes"><a href="#applying-global-scopes">Применение глобальных областей видимости</a></h4>
<p>Чтобы присвоить модели глобальную область видимости, вы должны переопределить метод модели <code>booted</code> и
    вызвать метод модели <code>addGlobalScope</code>. <code>addGlobalScope</code> Метод принимает экземпляр вашей сферы
    в качестве единственного аргумента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Scopes<span
                        class="token punctuation">\</span>AncientScope</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Model</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">User</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * The "booted" method of the model.
     *
     * @return void
     */</span>
    <span class="token keyword">protected</span> <span class="token keyword">static</span> <span class="token keyword">function</span> <span
                    class="token function">booted</span><span class="token punctuation">(</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">static</span><span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token function">addGlobalScope</span><span
                    class="token punctuation">(</span><span class="token keyword">new</span> <span
                    class="token class-name">AncientScope</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>После добавления в модель области в приведенном выше примере <code>App\Models\User</code> вызов
    <code>User::all()</code> метода выполнит следующий SQL-запрос:</p>
<pre class=" language-sql"><code class=" language-sql"><span class="token keyword">select</span> <span
                class="token operator">*</span> <span class="token keyword">from</span> <span class="token punctuation">`</span>users<span
                class="token punctuation">`</span> <span class="token keyword">where</span> <span
                class="token punctuation">`</span>created_at<span class="token punctuation">`</span> <span
                class="token operator">&lt;</span> <span class="token number">0021</span><span
                class="token operator">-</span><span class="token number">02</span><span class="token operator">-</span><span
                class="token number">18</span> <span class="token number">00</span>:<span class="token number">00</span>:<span
                class="token number">00</span></code></pre>
<p></p>
<h4 id="anonymous-global-scopes"><a href="#anonymous-global-scopes">Анонимные глобальные области</a></h4>
<p>Eloquent также позволяет вам определять глобальные области действия с помощью замыканий, что особенно полезно для
    простых областей действия, для которых не требуется отдельный класс. При определении глобальной области с помощью
    замыкания вы должны указать имя области по вашему выбору в качестве первого аргумента <code>addGlobalScope</code>
    метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span class="token punctuation">\</span>Builder</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Model</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">User</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * The "booted" method of the model.
     *
     * @return void
     */</span>
    <span class="token keyword">protected</span> <span class="token keyword">static</span> <span class="token keyword">function</span> <span
                    class="token function">booted</span><span class="token punctuation">(</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">static</span><span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token function">addGlobalScope</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'ancient'</span><span
                    class="token punctuation">,</span> <span class="token keyword">function</span> <span
                    class="token punctuation">(</span>Builder <span class="token variable">$builder</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token variable">$builder</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">where</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'created_at'</span><span
                    class="token punctuation">,</span> <span
                    class="token single-quoted-string string">'&lt;'</span><span
                    class="token punctuation">,</span> <span class="token function">now</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">subYears</span><span
                    class="token punctuation">(</span><span class="token number">2000</span><span
                    class="token punctuation">)</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h4 id="removing-global-scopes"><a href="#removing-global-scopes">Удаление глобальных областей видимости</a></h4>
<p>Если вы хотите удалить глобальную область видимости для данного запроса, вы можете использовать этот <code>withoutGlobalScope</code>
    метод. Этот метод принимает имя класса глобальной области как единственный аргумент:</p>
<pre class=" language-php"><code class=" language-php">User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">withoutGlobalScope</span><span
                class="token punctuation">(</span>AncientScope<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Или, если вы определили глобальную область с помощью замыкания, вы должны передать имя строки, которое вы присвоили
    глобальной области:</p>
<pre class=" language-php"><code class=" language-php">User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">withoutGlobalScope</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'ancient'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Если вы хотите удалить несколько или даже все глобальные области запроса, вы можете использовать <code>withoutGlobalScopes</code>
    метод:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token comment">// Remove all of the global scopes...</span>
User<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">withoutGlobalScopes</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// Remove some of the global scopes...</span>
User<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">withoutGlobalScopes</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    FirstScope<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span><span class="token punctuation">,</span> SecondScope<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="local-scopes"><a href="#local-scopes">Локальные области</a></h3>
<p>Локальные области позволяют определять общие наборы ограничений запроса, которые можно легко повторно использовать в
    своем приложении. Например, вам может потребоваться часто получать всех пользователей, которые считаются
    «популярными». Чтобы определить область действия, добавьте к методу модели Eloquent префикс <code>scope</code>.</p>
<p>Области действия всегда должны возвращать экземпляр построителя запросов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Model</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">User</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Scope a query to only include popular users.
     *
     * @param  \Illuminate\Database\Eloquent\Builder  $query
     * @return \Illuminate\Database\Eloquent\Builder
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">scopePopular</span><span
                    class="token punctuation">(</span><span class="token variable">$query</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$query</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">where</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'votes'</span><span
                    class="token punctuation">,</span> <span
                    class="token single-quoted-string string">'&gt;'</span><span
                    class="token punctuation">,</span> <span class="token number">100</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
     * Scope a query to only include active users.
     *
     * @param  \Illuminate\Database\Eloquent\Builder  $query
     * @return \Illuminate\Database\Eloquent\Builder
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">scopeActive</span><span
                    class="token punctuation">(</span><span class="token variable">$query</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$query</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">where</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'active'</span><span
                    class="token punctuation">,</span> <span class="token number">1</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h4 id="utilizing-a-local-scope"><a href="#utilizing-a-local-scope">Использование локальной области видимости</a></h4>
<p>После определения области действия вы можете вызывать методы области при запросе модели. Однако не следует включать
    <code>scope</code> префикс при вызове метода. Вы даже можете связывать вызовы с различными областями:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

<span class="token variable">$users</span> <span class="token operator">=</span> User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">popular</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">active</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">orderBy</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'created_at'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Объединение нескольких областей модели Eloquent с помощью <code>or</code> оператора запроса может потребовать
    использования замыканий для достижения правильной <a href="queries#logical-grouping">логической группировки</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">popular</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">orWhere</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span>Builder <span class="token variable">$query</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$query</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">active</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Однако, поскольку это может быть обременительно, Laravel предоставляет <code>orWhere</code> метод «более высокого
    порядка», который позволяет вам плавно связывать области действия без использования замыканий:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> App\<span class="token package">Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">popular</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">orWhere</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">active</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="dynamic-scopes"><a href="#dynamic-scopes">Динамические области</a></h4>
<p>Иногда вы можете захотеть определить область, которая принимает параметры. Для начала просто добавьте дополнительные
    параметры в подпись метода области видимости. Параметры области действия должны быть определены после
    <code>$query</code> параметра:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Model</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">User</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Scope a query to only include users of a given type.
     *
     * @param  \Illuminate\Database\Eloquent\Builder  $query
     * @param  mixed  $type
     * @return \Illuminate\Database\Eloquent\Builder
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">scopeOfType</span><span
                    class="token punctuation">(</span><span class="token variable">$query</span><span
                    class="token punctuation">,</span> <span class="token variable">$type</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$query</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">where</span><span
                    class="token punctuation">(</span><span class="token single-quoted-string string">'type'</span><span
                    class="token punctuation">,</span> <span class="token variable">$type</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>После того, как ожидаемые аргументы были добавлены в подпись вашего метода области видимости, вы можете передать
    аргументы при вызове области:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">ofType</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'admin'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="comparing-models"><a href="#comparing-models">Сравнение моделей</a></h2>
<p>Иногда может потребоваться определить, являются ли две модели «одинаковыми» или нет. <code>is</code> И
    <code>isNot</code> методы могут быть использованы для быстрой проверки две модели имеют один и тот же ключ, таблица,
    и подключение к основной базе данных или нет:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">if</span> <span
                class="token punctuation">(</span><span class="token variable">$post</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">is</span><span class="token punctuation">(</span><span
                class="token variable">$anotherPost</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span>

<span class="token keyword">if</span> <span class="token punctuation">(</span><span
                class="token variable">$post</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">isNot</span><span class="token punctuation">(</span><span class="token variable">$anotherPost</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p><code>is</code> И <code>isNot</code> методы также доступны при использовании <code>belongsTo</code>,
    <code>hasOne</code>, <code>morphTo</code> и <code>morphOne</code> <a href="eloquent-relationships">отношений</a>.
    Этот метод особенно полезен, если вы хотите сравнить связанную модель без запроса на получение этой модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">if</span> <span
                class="token punctuation">(</span><span class="token variable">$post</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">author</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">is</span><span class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h2 id="events"><a href="#events">События</a></h2>
<p>Красноречивые модели отправка несколько событий, что позволяет подключить в следующие моменты жизненного цикла
    модели: <code>retrieved</code>, <code>creating</code>, <code>created</code>, <code>updating</code>,
    <code>updated</code>, <code>saving</code>, <code>saved</code>, <code>deleting</code>, <code>deleted</code>, <code>restoring</code>,
    <code>restored</code>, и <code>replicating</code>.</p>
<p><code>retrieved</code> Событие отправки, когда существующая модель извлекается из базы данных. Когда новая модель
    сохраняется в первый раз, <code>creating</code> и <code>created</code> события будут рассылать. События <code>updating</code>
    / <code>updated</code> будут отправляться при изменении существующей модели и <code>save</code> вызове метода.
    События <code>saving</code> / <code>saved</code> отправляются при создании или обновлении модели, даже если атрибуты
    модели не были изменены.</p>
<p>Чтобы начать прислушиваться к событиям модели, определите <code>$dispatchesEvents</code> свойство в вашей модели
    Eloquent. Это свойство отображает различные точки жизненного цикла модели Eloquent на ваши собственные <a
            href="events">классы событий</a>. Каждый класс событий модели должен ожидать получения экземпляра затронутой
    модели через свой конструктор:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Events<span
                        class="token punctuation">\</span>UserDeleted</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Events<span class="token punctuation">\</span>UserSaved</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Auth<span class="token punctuation">\</span>User</span> <span
                    class="token keyword">as</span> Authenticatable<span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">User</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Authenticatable</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">use</span> <span class="token package">Notifiable</span><span class="token punctuation">;</span>

    <span class="token comment">/**
     * The event map for the model.
     *
     * @var array
     */</span>
    <span class="token keyword">protected</span> <span class="token variable">$dispatchesEvents</span> <span
                    class="token operator">=</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'saved'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> UserSaved<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">,</span>
        <span class="token single-quoted-string string">'deleted'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> UserDeleted<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
<p>После определения и сопоставления событий Eloquent вы можете использовать <a href="events#defining-listeners">прослушиватели
        событий</a> для обработки событий.</p>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>При выдаче обновления массы или запрос на удаление с помощью красноречивых, тем <code>saved</code>, <code>updated</code>,
            <code>deleting</code>, и <code>deleted</code> модели события не будут отосланы для пострадавших моделей. Это
            связано с тем, что модели никогда не извлекаются при массовом обновлении или удалении.</p></p></div>
</blockquote>
<p></p>
<h3 id="events-using-closures"><a href="#events-using-closures">Использование замыканий</a></h3>
<p>Вместо использования настраиваемых классов событий вы можете зарегистрировать закрытия, которые выполняются при
    отправке различных событий модели. Обычно вы должны зарегистрировать эти замыкания в <code>booted</code> методе
    вашей модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Model</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">User</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * The "booted" method of the model.
     *
     * @return void
     */</span>
    <span class="token keyword">protected</span> <span class="token keyword">static</span> <span class="token keyword">function</span> <span
                    class="token function">booted</span><span class="token punctuation">(</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">static</span><span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token function">created</span><span
                    class="token punctuation">(</span><span class="token keyword">function</span> <span
                    class="token punctuation">(</span><span class="token variable">$user</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">//</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>При необходимости вы можете использовать <a href="events#queuable-anonymous-event-listeners">очереди анонимных
        прослушивателей событий</a> при регистрации событий модели. Это будет инструктировать Laravel выполнить
    слушатель модели событий в фоновом режиме с помощью вашего приложения <a href="queues">очереди</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">function</span> Illuminate\<span class="token package">Events<span
                    class="token punctuation">\</span>queueable</span><span class="token punctuation">;</span>

<span class="token keyword">static</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">created</span><span
                class="token punctuation">(</span><span class="token function">queueable</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="observers"><a href="#observers">Наблюдатели</a></h3>
<p></p>
<h4 id="defining-observers"><a href="#defining-observers">Определение наблюдателей</a></h4>
<p>Если вы отслеживаете множество событий в данной модели, вы можете использовать наблюдателей, чтобы сгруппировать всех
    ваших слушателей в один класс. У классов-наблюдателей есть имена методов, которые отражают события Eloquent, которые
    вы хотите прослушивать. Каждый из этих методов получает затронутую модель в качестве единственного аргумента.
    Команда <code>make:observer</code> Artisan - самый простой способ создать новый класс наблюдателя:</p>
<pre class=" language-php"><code class=" language-php">php artisan make<span class="token punctuation">:</span>observer UserObserver <span
                class="token operator">--</span>model<span class="token operator">=</span>User</code></pre>
<p>Эта команда поместит нового наблюдателя в ваш <code>App/Observers</code> каталог. Если этот каталог не существует,
    Artisan создаст его для вас. Ваш свежий наблюдатель будет выглядеть следующим образом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Observers</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">UserObserver</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Handle the User "created" event.
     *
     * @param  \App\Models\User  $user
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">created</span><span
                    class="token punctuation">(</span>User <span class="token variable">$user</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
     * Handle the User "updated" event.
     *
     * @param  \App\Models\User  $user
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">updated</span><span
                    class="token punctuation">(</span>User <span class="token variable">$user</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
     * Handle the User "deleted" event.
     *
     * @param  \App\Models\User  $user
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">deleted</span><span
                    class="token punctuation">(</span>User <span class="token variable">$user</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
     * Handle the User "forceDeleted" event.
     *
     * @param  \App\Models\User  $user
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">forceDeleted</span><span
                    class="token punctuation">(</span>User <span class="token variable">$user</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Чтобы зарегистрировать наблюдателя, вам необходимо вызвать <code>observe</code> метод модели, которую вы хотите
    наблюдать. Вы можете зарегистрировать наблюдателей в <code>boot</code> методе <code>App\Providers\EventServiceProvider</code>
    поставщика услуг вашего приложения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Observers<span
                    class="token punctuation">\</span>UserObserver</span><span class="token punctuation">;</span>

<span class="token comment">/**
 * Register any events for your application.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">boot</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    User<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">observe</span><span
                class="token punctuation">(</span>UserObserver<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="muting-events"><a href="#muting-events">Отключение событий</a></h3>
<p>Иногда вам может потребоваться временно «заглушить» все события, запускаемые моделью. Вы можете добиться этого с
    помощью <code>withoutEvents</code> метода. <code>withoutEvents</code> Метод принимает замыкание в качестве
    единственного аргумента. Любой код, выполняемый в рамках этого закрытия, не будет отправлять события модели.
    Например, в следующем примере выполняется выборка и удаление <code>App\Models\User</code> экземпляра без отправки
    каких-либо событий модели. Любое значение, возвращаемое закрытием, будет возвращено <code>withoutEvents</code>
    методом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

<span class="token variable">$user</span> <span class="token operator">=</span> User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">withoutEvents</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token keyword">use</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    User<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">findOrFail</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">delete</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

    <span class="token keyword">return</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">2</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="saving-a-single-model-without-events"><a href="#saving-a-single-model-without-events">Сохранение одной модели
        без событий</a></h4>
<p>Иногда вы можете захотеть «сохранить» данную модель без отправки каких-либо событий. Вы можете сделать это с помощью
    <code>saveQuietly</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">findOrFail</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">name</span> <span class="token operator">=</span> <span
                class="token single-quoted-string string">'Victoria Faith'</span><span
                class="token punctuation">;</span>

<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">saveQuietly</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
