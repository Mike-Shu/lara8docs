<h1>БД: Посев <sup>Seeding</sup></h1>
<ul>
    <li><a href="seeding#introduction">Вступление</a></li>
    <li><a href="seeding#writing-seeders">Написание сеялки</a>
        <ul>
            <li><a href="seeding#using-model-factories">Использование фабрик моделей</a></li>
            <li><a href="seeding#calling-additional-seeders">Вызов дополнительных сеялок</a></li>
        </ul>
    </li>
    <li><a href="seeding#running-seeders">Беговые сеялки</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Laravel включает в себя возможность наполнить вашу базу данных тестовыми данными с помощью начальных классов. Все
    начальные классы хранятся в <code>database/seeders</code> каталоге. По умолчанию <code>DatabaseSeeder</code> для вас
    определен класс. Из этого класса вы можете использовать <code>call</code> метод для запуска других начальных
    классов, что позволяет вам контролировать порядок заполнения.</p>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p><a href="eloquent#mass-assignment">Защита массового назначения</a> автоматически отключается во время
            заполнения базы данных.</p></p></div>
</blockquote>
<p></p>
<h2 id="writing-seeders"><a href="#writing-seeders">Написание сеялки</a></h2>
<p>Чтобы создать сеялку, выполните команду <code>make:seeder</code> <a href="artisan">Artisan</a>. Все сидеры,
    сгенерированные фреймворком, будут помещены в <code>database/seeders</code> каталог:</p>
<pre class=" language-php"><code class=" language-php">php artisan make<span class="token punctuation">:</span>seeder UserSeeder</code></pre>
<p>Класс сеялки содержит только один метод по умолчанию: <code>run</code>. Этот метод вызывается при выполнении <code>db:seed</code>
    <a href="artisan">Artisan-команды</a>. В рамках <code>run</code> метода вы можете вставлять данные в свою базу
    данных, как хотите. Вы можете использовать <a href="queries">построитель запросов</a> для ручной вставки данных или
    можете использовать <a href="database-testing#defining-model-factories">фабрики моделей Eloquent</a>.</p>
<p>В качестве примера давайте изменим <code>DatabaseSeeder</code> класс по умолчанию и добавим в <code>run</code> метод
    оператор вставки базы данных:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">Database<span
                        class="token punctuation">\</span>Seeders</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Seeder</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span class="token punctuation">\</span>DB</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Hash</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">DatabaseSeeder</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Seeder</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Run the database seeders.
    *
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">run</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token constant">DB</span><span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token function">table</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'users'</span><span
                    class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">insert</span><span class="token punctuation">(</span><span
                    class="token punctuation">[</span>
            <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> Str<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token function">random</span><span
                    class="token punctuation">(</span><span class="token number">10</span><span
                    class="token punctuation">)</span><span class="token punctuation">,</span>
            <span class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> Str<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token function">random</span><span
                    class="token punctuation">(</span><span class="token number">10</span><span
                    class="token punctuation">)</span><span class="token punctuation">.</span><span
                    class="token single-quoted-string string">'@gmail.com'</span><span
                    class="token punctuation">,</span>
            <span class="token single-quoted-string string">'password'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> Hash<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token function">make</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'password'</span><span
                    class="token punctuation">)</span><span class="token punctuation">,</span>
        <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Вы можете указать любые необходимые зависимости в <code>run</code> сигнатуре метода. Они будут автоматически
            разрешены через <a href="container">сервисный контейнер</a> Laravel.</p></p></div>
</blockquote>
<p></p>
<h3 id="using-model-factories"><a href="#using-model-factories">Использование фабрик моделей</a></h3>
<p>Конечно, вручную указывать атрибуты для каждого начального числа модели сложно. Вместо этого вы можете использовать
    <a href="database-testing#defining-model-factories">фабрики моделей</a> для удобного создания большого количества
    записей базы данных. Сначала просмотрите <a href="database-testing#defining-model-factories">документацию</a> по <a
            href="database-testing#defining-model-factories">модельной фабрике,</a> чтобы узнать, как определить свои
    фабрики.</p>
<p>Например, давайте создадим 50 пользователей, у каждого из которых будет одно связанное сообщение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

<span class="token comment">/**
 * Run the database seeders.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">run</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    User<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">count</span><span class="token punctuation">(</span><span
                class="token number">50</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">hasPosts</span><span class="token punctuation">(</span><span
                class="token number">1</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">create</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="calling-additional-seeders"><a href="#calling-additional-seeders">Вызов дополнительных сеялок</a></h3>
<p>Внутри <code>DatabaseSeeder</code> класса вы можете использовать этот <code>call</code> метод для выполнения
    дополнительных начальных классов. Использование этого <code>call</code> метода позволяет разбить заполнение базы
    данных на несколько файлов, чтобы ни один класс сидера не становился слишком большим. <code>call</code> Метод
    принимает массив классов, которые сеялки должны быть выполнены:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Run the database seeders.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">run</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">call</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
        UserSeeder<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span><span class="token punctuation">,</span>
        PostSeeder<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span><span class="token punctuation">,</span>
        CommentSeeder<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h2 id="running-seeders"><a href="#running-seeders">Запуск сеялки <sup>Running seeders</sup></a></h2>
<p>Вы можете выполнить команду <code>db:seed</code> Artisan для заполнения своей базы данных. По умолчанию
    <code>db:seed</code> команда запускает <code>Database\Seeders\DatabaseSeeder</code> класс, который, в свою очередь,
    может вызывать другие начальные классы. Однако вы можете использовать <code>--class</code> опцию, чтобы указать
    конкретный класс сидера для индивидуального запуска:</p>
<pre class=" language-php"><code class=" language-php">php artisan db<span class="token punctuation">:</span>seed

php artisan db<span class="token punctuation">:</span>seed <span class="token operator">--</span><span
                class="token keyword">class</span><span class="token operator">=</span>UserSeeder</code></pre>
<p>Вы также можете заполнить свою базу данных, используя <code>migrate:fresh</code> команду в сочетании с
    <code>--seed</code> опцией, которая удалит все таблицы и повторно запустит все ваши миграции. Эта команда полезна
    для полного перестроения вашей базы данных:</p>
<pre class=" language-php"><code class=" language-php">php artisan migrate<span class="token punctuation">:</span>fresh <span
                class="token operator">--</span>seed</code></pre>
<p></p>
<h4 id="forcing-seeding-production"><a href="#forcing-seeding-production">Запуск сеялки в производство</a></h4>
<p>Некоторые операции по заполнению могут привести к изменению или потере данных. Чтобы защитить вас от запуска команд
    заполнения для вашей производственной базы данных, вам будет предложено подтвердить, прежде чем сеялки будут
    выполнены в <code>production</code> среде. Чтобы заставить сеялки работать без приглашения, используйте <code>--force</code>
    флаг:</p>
<pre class=" language-php"><code class=" language-php">php artisan db<span class="token punctuation">:</span>seed <span
                class="token operator">--</span>force</code></pre>
