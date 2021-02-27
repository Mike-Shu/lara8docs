<h1>Тестирование базы данных <sup>Database testing</sup></h1>
<ul>
    <li><a href="database-testing#introduction">Вступление</a>
        <ul>
            <li><a href="database-testing#resetting-the-database-after-each-test">Сброс базы данных после каждого
                    теста</a></li>
        </ul>
    </li>
    <li><a href="database-testing#defining-model-factories">Определение фабрик моделей</a>
        <ul>
            <li><a href="database-testing#concept-overview">Обзор концепции</a></li>
            <li><a href="database-testing#generating-factories">Производящие фабрики</a></li>
            <li><a href="database-testing#factory-states">Заводские состояния</a></li>
            <li><a href="database-testing#factory-callbacks">Заводские обратные вызовы</a></li>
        </ul>
    </li>
    <li><a href="database-testing#creating-models-using-factories">Создание моделей с использованием фабрик</a>
        <ul>
            <li><a href="database-testing#instantiating-models">Создание экземпляров моделей</a></li>
            <li><a href="database-testing#persisting-models">Сохраняющиеся модели</a></li>
            <li><a href="database-testing#sequences">Последовательности</a></li>
        </ul>
    </li>
    <li><a href="database-testing#factory-relationships">Заводские отношения</a>
        <ul>
            <li><a href="database-testing#has-many-relationships">Имеет много отношений</a></li>
            <li><a href="database-testing#belongs-to-relationships">Принадлежит к отношениям</a></li>
            <li><a href="database-testing#many-to-many-relationships">Отношения многие ко многим</a></li>
            <li><a href="database-testing#polymorphic-relationships">Полиморфные отношения</a></li>
            <li><a href="database-testing#defining-relationships-within-factories">Определение отношений внутри
                    фабрик</a></li>
        </ul>
    </li>
    <li><a href="database-testing#running-seeders">Запуск сеялки</a></li>
    <li><a href="database-testing#available-assertions">Доступные утверждения</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Laravel предоставляет множество полезных инструментов и утверждений, чтобы упростить тестирование приложений,
    управляемых базой данных. Кроме того, фабрики моделей и сидеры Laravel позволяют безболезненно создавать записи
    тестовой базы данных с использованием моделей и отношений Eloquent вашего приложения. Мы обсудим все эти мощные
    функции в следующей документации.</p>
<p></p>
<h3 id="resetting-the-database-after-each-test"><a href="#resetting-the-database-after-each-test">Сброс базы данных
        после каждого теста</a></h3>
<p>Прежде чем продолжить, давайте обсудим, как сбрасывать вашу базу данных после каждого из ваших тестов, чтобы данные
    из предыдущего теста не мешали последующим тестам. Включенная
    <code>Illuminate\Foundation\Testing\RefreshDatabase</code> черта Laravel позаботится об этом за вас. Просто
    используйте трейт в своем тестовом классе:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">Tests<span class="token punctuation">\</span>Feature</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Testing<span class="token punctuation">\</span>RefreshDatabase</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Testing<span class="token punctuation">\</span>WithoutMiddleware</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Tests<span class="token punctuation">\</span>TestCase</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ExampleTest</span> <span class="token keyword">extends</span> <span
                    class="token class-name">TestCase</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">use</span> <span class="token package">RefreshDatabase</span><span
                    class="token punctuation">;</span>

    <span class="token comment">/**
     * A basic functional test example.
     *
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">test_basic_example</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$response</span> <span class="token operator">=</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">get</span><span
                    class="token punctuation">(</span><span class="token single-quoted-string string">'/'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token comment">//...</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h2 id="defining-model-factories"><a href="#defining-model-factories">Определение фабрик моделей</a></h2>
<p></p>
<h3 id="concept-overview"><a href="#concept-overview">Обзор концепции</a></h3>
<p>Сначала поговорим о фабриках моделей Eloquent. При тестировании вам может потребоваться вставить несколько записей в
    вашу базу данных перед выполнением теста. Вместо того, чтобы вручную указывать значение каждого столбца при создании
    этих тестовых данных, Laravel позволяет вам определять набор атрибутов по умолчанию для каждой из ваших <a
            href="eloquent">моделей Eloquent,</a> используя фабрики моделей.</p>
<p>Чтобы увидеть пример написания фабрики, взгляните на <code>database/factories/UserFactory.php</code> файл в вашем
    приложении. Эта фабрика включена во все новые приложения Laravel и содержит следующее определение фабрики:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">namespace</span> <span
                class="token package">Database<span class="token punctuation">\</span>Factories</span><span
                class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                    class="token punctuation">\</span>Eloquent<span class="token punctuation">\</span>Factories<span
                    class="token punctuation">\</span>Factory</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">UserFactory</span> <span class="token keyword">extends</span> <span
                class="token class-name">Factory</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * The name of the factory's corresponding model.
     *
     * @var string
     */</span>
    <span class="token keyword">protected</span> <span class="token variable">$model</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">;</span>

    <span class="token comment">/**
     * Define the model's default state.
     *
     * @return array
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">definition</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token punctuation">[</span>
            <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">faker</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">name</span><span class="token punctuation">,</span>
            <span class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">faker</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">unique</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">safeEmail</span><span
                class="token punctuation">,</span>
            <span class="token single-quoted-string string">'email_verified_at'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token function">now</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
            <span class="token single-quoted-string string">'password'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi'</span><span
                class="token punctuation">,</span> <span class="token comment">// password</span>
            <span class="token single-quoted-string string">'remember_token'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> Str<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">random</span><span
                class="token punctuation">(</span><span class="token number">10</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
        <span class="token punctuation">]</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></code></pre>
<p>Как видите, в своей основной форме фабрики - это классы, которые расширяют базовый фабричный класс Laravel и
    определяют <code>model</code> свойство и <code>definition</code> метод. <code>definition</code> Метод возвращает
    набор параметров по умолчанию значений атрибутов, которые должны быть применены при создании модели с использованием
    фабрики.</p>
<p>Через <code>faker</code> свойство фабрики получают доступ к библиотеке <a href="https://github.com/FakerPHP/Faker">Faker</a>
    PHP, которая позволяет вам удобно генерировать различные виды случайных данных для тестирования.</p>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Вы можете установить языковой стандарт Faker для своего приложения, добавив <code>faker_locale</code>
            параметр в <code>config/app.php</code> файл конфигурации.</p></p></div>
</blockquote>
<p></p>
<h3 id="generating-factories"><a href="#generating-factories">Производящие фабрики</a></h3>
<p>Чтобы создать фабрику, выполните <code>make:factory</code> <a href="artisan">Artisan-команду</a>:</p>
<pre class=" language-php"><code class=" language-php">php artisan make<span class="token punctuation">:</span>factory PostFactory</code></pre>
<p>Новый фабричный класс будет помещен в ваш <code>database/factories</code> каталог.</p>
<p><code>--model</code> Вариант может быть использован, чтобы указать название модели, созданной на заводе -
    изготовителе. Эта опция предварительно заполнит сгенерированный заводской файл данной моделью:</p>
<pre class=" language-php"><code class=" language-php">php artisan make<span class="token punctuation">:</span>factory PostFactory <span
                class="token operator">--</span>model<span class="token operator">=</span>Post</code></pre>
<p></p>
<h3 id="factory-states"><a href="#factory-states">Заводские состояния</a></h3>
<p>Методы управления состоянием позволяют вам определять дискретные модификации, которые могут быть применены к вашим
    модельным фабрикам в любой комбинации. Например, ваша <code>Database\Factories\UserFactory</code> фабрика может
    содержать <code>suspended</code> метод состояния, который изменяет одно из значений атрибута по умолчанию.</p>
<p>Методы преобразования состояния обычно вызывают <code>state</code> метод, предоставленный базовым классом фабрики
    Laravel. <code>state</code> Метод принимает замыкание, которое будет получать массив исходных атрибутов,
    определенные для завода и возвращает массив атрибутов для изменения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Indicate that the user is suspended.
 *
 * @return \Illuminate\Database\Eloquent\Factories\Factory
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">suspended</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">state</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token keyword">array</span> <span class="token variable">$attributes</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token punctuation">[</span>
            <span class="token single-quoted-string string">'account_status'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'suspended'</span><span class="token punctuation">,</span>
        <span class="token punctuation">]</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="factory-callbacks"><a href="#factory-callbacks">Заводские обратные вызовы</a></h3>
<p>Заводские обратные вызовы регистрируются с помощью <code>afterMaking</code> и <code>afterCreating</code> метод и
    позволяют выполнять дополнительные задачи после изготовления или создания модели. Вы должны зарегистрировать эти
    обратные вызовы, определив <code>configure</code> метод в своем фабричном классе. Этот метод будет автоматически
    вызываться Laravel при создании экземпляра фабрики:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">namespace</span> <span
                class="token package">Database<span class="token punctuation">\</span>Factories</span><span
                class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                    class="token punctuation">\</span>Eloquent<span class="token punctuation">\</span>Factories<span
                    class="token punctuation">\</span>Factory</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">UserFactory</span> <span class="token keyword">extends</span> <span
                class="token class-name">Factory</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * The name of the factory's corresponding model.
     *
     * @var string
     */</span>
    <span class="token keyword">protected</span> <span class="token variable">$model</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">;</span>

    <span class="token comment">/**
     * Configure the model factory.
     *
     * @return $this
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">configure</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">afterMaking</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span>User <span class="token variable">$user</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">//</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">afterCreating</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span>User <span class="token variable">$user</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">//</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>

    <span class="token comment">//...</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h2 id="creating-models-using-factories"><a href="#creating-models-using-factories">Создание моделей с использованием
        фабрик</a></h2>
<p></p>
<h3 id="instantiating-models"><a href="#instantiating-models">Создание экземпляров моделей</a></h3>
<p>После того, как вы определили свои фабрики, вы можете использовать статический <code>factory</code> метод,
    предоставленный вашим моделям с помощью <code>Illuminate\Database\Eloquent\Factories\HasFactory</code> трейта, чтобы
    создать экземпляр фабрики для этой модели. Давайте посмотрим на несколько примеров создания моделей. Во-первых, мы
    будем использовать этот <code>make</code> метод для создания моделей, не сохраняя их в базе данных:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">test_models_can_be_instantiated</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$user</span> <span class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">make</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

    <span class="token comment">// Use model in tests...</span>
<span class="token punctuation">}</span></code></pre>
<p>Вы можете создать коллекцию из множества моделей, используя <code>count</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">count</span><span
                class="token punctuation">(</span><span class="token number">3</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">make</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="applying-states"><a href="#applying-states">Применение состояний</a></h4>
<p>Вы также можете применить к моделям любое из ваших <a href="database-testing#factory-states">состояний</a>. Если вы
    хотите применить к моделям несколько преобразований состояния, вы можете просто вызвать методы преобразования
    состояния напрямую:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">count</span><span
                class="token punctuation">(</span><span class="token number">5</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">suspended</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">make</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="overriding-attributes"><a href="#overriding-attributes">Переопределение атрибутов</a></h4>
<p>Если вы хотите переопределить некоторые значения по умолчанию ваших моделей, вы можете передать массив значений в
    <code>make</code> метод. Будут заменены только указанные атрибуты, в то время как для остальных атрибутов будут
    установлены значения по умолчанию, указанные на заводе:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">make</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span>
    <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Abigail Otwell'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>В качестве альтернативы <code>state</code> метод может быть вызван непосредственно в экземпляре фабрики для
    выполнения встроенного преобразования состояния:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">state</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Abigail Otwell'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">make</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p><a href="eloquent#mass-assignment">Защита массового назначения</a> автоматически отключается при создании
            моделей с использованием фабрик.</p></p></div>
</blockquote>
<p></p>
<h4 id="connecting-factories-and-models"><a href="#connecting-factories-and-models">Соединение фабрик и моделей</a></h4>
<p>Метод <code>HasFactory</code> признака <code>factory</code> будет использовать соглашения для определения подходящей
    фабрики для модели. В частности, метод будет искать фабрику в <code>Database\Factories</code> пространстве имен, имя
    класса которой совпадает с именем модели и имеет суффикс <code>Factory</code>. Если эти соглашения не применимы к
    вашему конкретному приложению или фабрике, вы можете перезаписать <code>newFactory</code> метод в своей модели,
    чтобы напрямую возвращать экземпляр соответствующей фабрики модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Database<span class="token punctuation">\</span>Factories<span
                    class="token punctuation">\</span>Administration<span class="token punctuation">\</span>FlightFactory</span><span
                class="token punctuation">;</span>

<span class="token comment">/**
 * Create a new factory instance for the model.
 *
 * @return \Illuminate\Database\Eloquent\Factories\Factory
 */</span>
<span class="token keyword">protected</span> <span class="token keyword">static</span> <span class="token keyword">function</span> <span
                class="token function">newFactory</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> FlightFactory<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">new</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="persisting-models"><a href="#persisting-models">Сохраняющиеся модели</a></h3>
<p><code>create</code> Метод инициализирует экземпляр модели и сохраняется их в базу данных с помощью красноречивых по
    <code>save</code> методу:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">test_models_can_be_persisted</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// Create a single App\Models\User instance...</span>
    <span class="token variable">$user</span> <span class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

    <span class="token comment">// Create three App\Models\User instances...</span>
    <span class="token variable">$users</span> <span class="token operator">=</span> User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">count</span><span
                class="token punctuation">(</span><span class="token number">3</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

    <span class="token comment">// Use model in tests...</span>
<span class="token punctuation">}</span></code></pre>
<p>Вы можете переопределить атрибуты модели фабрики по умолчанию, передав массив атрибутов <code>create</code> методу:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Abigail'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="sequences"><a href="#sequences">Последовательности</a></h3>
<p>Иногда вы можете захотеть изменить значение данного атрибута модели для каждой созданной модели. Вы можете добиться
    этого, определив преобразование состояния как последовательность. Например, вы можете захотеть изменить значение
    <code>admin</code> столбца между <code>Y</code> и <code>N</code> для каждого созданного пользователя:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                    class="token punctuation">\</span>Eloquent<span class="token punctuation">\</span>Factories<span
                    class="token punctuation">\</span>Sequence</span><span class="token punctuation">;</span>

<span class="token variable">$users</span> <span class="token operator">=</span> User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">count</span><span class="token punctuation">(</span><span
                class="token number">10</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">state</span><span class="token punctuation">(</span><span class="token keyword">new</span> <span
                class="token class-name">Sequence</span><span class="token punctuation">(</span>
                    <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'admin'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Y'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
                    <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'admin'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'N'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
                <span class="token punctuation">)</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">create</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>В этом примере пять пользователей будут созданы со <code>admin</code> значением <code>Y</code> и пять пользователей
    будут созданы со <code>admin</code> значением <code>N</code>.</p>
<p>При необходимости вы можете включить замыкание в качестве значения последовательности. Замыкание будет вызываться
    каждый раз, когда последовательности потребуется новое значение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">count</span><span class="token punctuation">(</span><span
                class="token number">10</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">state</span><span class="token punctuation">(</span><span class="token keyword">new</span> <span
                class="token class-name">Sequence</span><span class="token punctuation">(</span>
                    fn <span class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'role'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> UserRoles<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">random</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
                <span class="token punctuation">)</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">create</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="factory-relationships"><a href="#factory-relationships">Заводские отношения</a></h2>
<p></p>
<h3 id="has-many-relationships"><a href="#has-many-relationships">Имеет много отношений</a></h3>
<p>Затем давайте исследуем построение отношений модели Eloquent с использованием свободно используемых фабричных методов
    Laravel. Сначала предположим, что у нашего приложения есть <code>App\Models\User</code> модель и <code>App\Models\Post</code>
    модель. Также предположим, что <code>User</code> модель определяет <code>hasMany</code> отношения с
    <code>Post</code>. Мы можем создать пользователя с тремя сообщениями, используя <code>has</code> метод,
    предоставляемый фабриками Laravel. <code>has</code> Метод принимает экземпляр фабрики:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Post</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                class="token punctuation">;</span>

<span class="token variable">$user</span> <span class="token operator">=</span> User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">has</span><span
                class="token punctuation">(</span>Post<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">count</span><span
                class="token punctuation">(</span><span class="token number">3</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>По соглашению, при передаче <code>Post</code> модели <code>has</code> методу Laravel предполагает, что
    <code>User</code> модель должна иметь <code>posts</code> метод, определяющий отношения. При необходимости вы можете
    явно указать имя отношения, которым вы хотите управлять:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">has</span><span
                class="token punctuation">(</span>Post<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">count</span><span
                class="token punctuation">(</span><span class="token number">3</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'posts'</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Конечно, вы можете выполнять манипуляции с состоянием связанных моделей. Кроме того, вы можете передать
    преобразование состояния на основе замыкания, если для изменения вашего состояния требуется доступ к родительской
    модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">has</span><span
                class="token punctuation">(</span>
                Post<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">factory</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
                        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">count</span><span class="token punctuation">(</span><span
                class="token number">3</span><span class="token punctuation">)</span>
                        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">state</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token keyword">array</span> <span class="token variable">$attributes</span><span
                class="token punctuation">,</span> User <span class="token variable">$user</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
                            <span class="token keyword">return</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'user_type'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">type</span><span class="token punctuation">]</span><span
                class="token punctuation">;</span>
                        <span class="token punctuation">}</span><span class="token punctuation">)</span>
            <span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="has-many-relationships-using-magic-methods"><a href="#has-many-relationships-using-magic-methods">Использование
        магических методов</a></h4>
<p>Для удобства вы можете использовать магические методы отношений фабрики Laravel для построения отношений. Например, в
    следующем примере будет использоваться соглашение, чтобы определить, что связанные модели должны быть созданы с
    помощью <code>posts</code> метода отношений в <code>User</code> модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">hasPosts</span><span
                class="token punctuation">(</span><span class="token number">3</span><span
                class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>При использовании магических методов для создания фабричных отношений вы можете передать массив атрибутов для
    переопределения в связанных моделях:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">hasPosts</span><span
                class="token punctuation">(</span><span class="token number">3</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
                <span class="token single-quoted-string string">'published'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token boolean constant">false</span><span
                class="token punctuation">,</span>
            <span class="token punctuation">]</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы можете предоставить преобразование состояния на основе замыкания, если для изменения состояния требуется доступ к
    родительской модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">hasPosts</span><span
                class="token punctuation">(</span><span class="token number">3</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token keyword">array</span> <span class="token variable">$attributes</span><span
                class="token punctuation">,</span> User <span class="token variable">$user</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
                <span class="token keyword">return</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'user_type'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">type</span><span class="token punctuation">]</span><span
                class="token punctuation">;</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="belongs-to-relationships"><a href="#belongs-to-relationships">Принадлежит к отношениям</a></h3>
<p>Теперь, когда мы изучили, как построить отношения «имеет много» с помощью фабрик, давайте исследуем обратное
    отношение. Этот <code>for</code> метод может использоваться для определения родительской модели, которой принадлежат
    модели, созданные на заводе. Например, мы можем создать три <code>App\Models\Post</code> экземпляра модели,
    принадлежащие одному пользователю:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Post</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                class="token punctuation">;</span>

<span class="token variable">$posts</span> <span class="token operator">=</span> Post<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">count</span><span
                class="token punctuation">(</span><span class="token number">3</span><span
                class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token keyword">for</span><span class="token punctuation">(</span>User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">state</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
                <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Jessica Archer'</span><span
                class="token punctuation">,</span>
            <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Если у вас уже есть экземпляр родительской модели, который должен быть связан с моделями, которые вы создаете, вы
    можете передать экземпляр модели в <code>for</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$posts</span> <span class="token operator">=</span> Post<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">count</span><span
                class="token punctuation">(</span><span class="token number">3</span><span
                class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token keyword">for</span><span class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="belongs-to-relationships-using-magic-methods"><a href="#belongs-to-relationships-using-magic-methods">Использование
        магических методов</a></h4>
<p>Для удобства вы можете использовать магические фабричные методы отношений Laravel для определения отношений
    «принадлежит». Например, в следующем примере будет использоваться соглашение для определения того, что три сообщения
    должны принадлежать <code>user</code> отношениям в <code>Post</code> модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$posts</span> <span
                class="token operator">=</span> Post<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">count</span><span
                class="token punctuation">(</span><span class="token number">3</span><span
                class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">forUser</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
                <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Jessica Archer'</span><span
                class="token punctuation">,</span>
            <span class="token punctuation">]</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="many-to-many-relationships"><a href="#many-to-many-relationships">Отношения многие ко многим</a></h3>
<p>Как и в случае <a href="database-testing#has-many-relationships">со многими отношениями</a>, <a
            href="database-testing#has-many-relationships">отношения</a> «многие ко многим» могут быть созданы с помощью
    <code>has</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Role</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                class="token punctuation">;</span>

<span class="token variable">$user</span> <span class="token operator">=</span> User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">has</span><span
                class="token punctuation">(</span>Role<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">count</span><span
                class="token punctuation">(</span><span class="token number">3</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="pivot-table-attributes"><a href="#pivot-table-attributes">Атрибуты сводной таблицы</a></h4>
<p>Если вам нужно определить атрибуты, которые должны быть установлены в сводной / промежуточной таблице, связывающей
    модели, вы можете использовать этот <code>hasAttached</code> метод. Этот метод принимает в качестве второго
    аргумента массив имен и значений атрибутов сводной таблицы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Role</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                class="token punctuation">;</span>

<span class="token variable">$user</span> <span class="token operator">=</span> User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">hasAttached</span><span
                class="token punctuation">(</span>
                Role<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">factory</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">count</span><span
                class="token punctuation">(</span><span class="token number">3</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
                <span class="token punctuation">[</span><span class="token single-quoted-string string">'active'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token boolean constant">true</span><span class="token punctuation">]</span>
            <span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы можете предоставить преобразование состояния на основе замыкания, если для изменения состояния требуется доступ к
    связанной модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">hasAttached</span><span
                class="token punctuation">(</span>
                Role<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">factory</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
                    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">count</span><span class="token punctuation">(</span><span
                class="token number">3</span><span class="token punctuation">)</span>
                    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">state</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token keyword">array</span> <span class="token variable">$attributes</span><span
                class="token punctuation">,</span> User <span class="token variable">$user</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
                        <span class="token keyword">return</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">name</span><span class="token punctuation">.</span><span
                class="token single-quoted-string string">' Role'</span><span class="token punctuation">]</span><span
                class="token punctuation">;</span>
                    <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span>
                <span class="token punctuation">[</span><span class="token single-quoted-string string">'active'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token boolean constant">true</span><span class="token punctuation">]</span>
            <span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Если у вас уже есть экземпляры модели, которые вы хотите прикрепить к создаваемым моделям, вы можете передать
    экземпляры модели в <code>hasAttached</code> метод. В этом примере всем трем пользователям будут назначены одни и те
    же три роли:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$roles</span> <span
                class="token operator">=</span> Role<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">count</span><span
                class="token punctuation">(</span><span class="token number">3</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$user</span> <span class="token operator">=</span> User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">count</span><span
                class="token punctuation">(</span><span class="token number">3</span><span
                class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">hasAttached</span><span
                class="token punctuation">(</span><span class="token variable">$roles</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'active'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token boolean constant">true</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="many-to-many-relationships-using-magic-methods"><a href="#many-to-many-relationships-using-magic-methods">Использование
        магических методов</a></h4>
<p>Для удобства вы можете использовать магические фабричные методы отношений Laravel для определения отношений многие ко
    многим. Например, в следующем примере будет использоваться соглашение, чтобы определить, что связанные модели должны
    быть созданы с помощью <code>roles</code> метода отношений в <code>User</code> модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">hasRoles</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
                <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Editor'</span>
            <span class="token punctuation">]</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="polymorphic-relationships"><a href="#polymorphic-relationships">Полиморфные отношения</a></h3>
<p><a href="eloquent-relationships#polymorphic-relationships">Полиморфные отношения</a> также могут быть созданы с
    использованием фабрик. Полиморфные отношения "морфировать многие" создаются так же, как типичные отношения "имеет
    много". Например, если <code>App\Models\Post</code> модель <code>morphMany</code> связана с
    <code>App\Models\Comment</code> моделью:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Post</span><span class="token punctuation">;</span>

<span class="token variable">$post</span> <span class="token operator">=</span> Post<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">hasComments</span><span
                class="token punctuation">(</span><span class="token number">3</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="morph-to-relationships"><a href="#morph-to-relationships">Превращение в отношения</a></h4>
<p>Магические методы нельзя использовать для создания <code>morphTo</code> отношений. Вместо этого <code>for</code>
    метод должен использоваться напрямую, а имя отношения должно быть явно указано. Например, представьте, что у <code>Comment</code>
    модели есть <code>commentable</code> метод, определяющий <code>morphTo</code> отношения. В этой ситуации мы можем
    создать три комментария, относящиеся к одному сообщению, <code>for</code> напрямую используя метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$comments</span> <span
                class="token operator">=</span> Comment<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">count</span><span
                class="token punctuation">(</span><span class="token number">3</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token keyword">for</span><span class="token punctuation">(</span>
    Post<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'commentable'</span>
<span class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="polymorphic-many-to-many-relationships"><a href="#polymorphic-many-to-many-relationships">Полиморфные отношения
        "многие ко многим"</a></h4>
<p>Полиморфные отношения «многие ко многим» ( <code>morphToMany</code> / <code>morphedByMany</code> ) могут быть созданы
    точно так же, как неполиморфные отношения «многие ко многим»:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Tag</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Models<span class="token punctuation">\</span>Video</span><span
                class="token punctuation">;</span>

<span class="token variable">$videos</span> <span class="token operator">=</span> Video<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">hasAttached</span><span
                class="token punctuation">(</span>
                Tag<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">factory</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">count</span><span
                class="token punctuation">(</span><span class="token number">3</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
                <span class="token punctuation">[</span><span class="token single-quoted-string string">'public'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token boolean constant">true</span><span class="token punctuation">]</span>
            <span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Конечно, магический <code>has</code> метод также можно использовать для создания полиморфных отношений «многие ко
    многим»:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$videos</span> <span
                class="token operator">=</span> Video<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">hasTags</span><span
                class="token punctuation">(</span><span class="token number">3</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'public'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token boolean constant">true</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="defining-relationships-within-factories"><a href="#defining-relationships-within-factories">Определение
        отношений внутри фабрик</a></h3>
<p>Чтобы определить отношение в пределах вашей фабрики модели, вы обычно назначаете новый экземпляр фабрики внешнему
    ключу отношения. Обычно это делается для «обратных» отношений, таких как <code>belongsTo</code> и
    <code>morphTo</code>. Например, если вы хотите создать нового пользователя при создании публикации, вы можете
    сделать следующее:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

<span class="token comment">/**
 * Define the model's default state.
 *
 * @return array
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">definition</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'user_id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span>
        <span class="token single-quoted-string string">'title'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">faker</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">title</span><span
                class="token punctuation">,</span>
        <span class="token single-quoted-string string">'content'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">faker</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">paragraph</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Если столбцы отношения зависят от фабрики, которая его определяет, вы можете назначить закрытие для атрибута.
    Замыкание получит массив оцененных атрибутов фабрики:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Define the model's default state.
 *
 * @return array
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">definition</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'user_id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span>
        <span class="token single-quoted-string string">'user_type'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token keyword">array</span> <span class="token variable">$attributes</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token variable">$attributes</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'user_id'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">type</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'title'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">faker</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">title</span><span
                class="token punctuation">,</span>
        <span class="token single-quoted-string string">'content'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">faker</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">paragraph</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h2 id="running-seeders"><a href="#running-seeders">Запуск сеялки</a></h2>
<p>Если вы хотите использовать <a href="seeding">сеялки базы данных</a> для заполнения вашей базы данных во время
    тестирования функций, вы можете вызвать этот <code>seed</code> метод. По умолчанию этот <code>seed</code> метод
    выполнит <code>DatabaseSeeder</code>, который должен выполнить все остальные ваши сидеры. В качестве альтернативы вы
    передаете <code>seed</code> методу конкретное имя класса сидера:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">Tests<span class="token punctuation">\</span>Feature</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Database<span class="token punctuation">\</span>Seeders<span
                        class="token punctuation">\</span>OrderStatusSeeder</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Testing<span class="token punctuation">\</span>RefreshDatabase</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Testing<span class="token punctuation">\</span>WithoutMiddleware</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Tests<span class="token punctuation">\</span>TestCase</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ExampleTest</span> <span class="token keyword">extends</span> <span
                    class="token class-name">TestCase</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">use</span> <span class="token package">RefreshDatabase</span><span
                    class="token punctuation">;</span>

    <span class="token comment">/**
     * Test creating a new order.
     *
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">test_orders_can_be_created</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">// Run the DatabaseSeeder...</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">seed</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>

        <span class="token comment">// Run a specific seeder...</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">seed</span><span
                    class="token punctuation">(</span>OrderStatusSeeder<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token comment">//...</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Кроме того, вы можете указать <code>RefreshDatabase</code> признаку автоматически заполнять базу данных перед каждым
    тестом. Вы можете добиться этого, определив <code>$seed</code> свойство в своем тестовом классе:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">Tests<span class="token punctuation">\</span>Feature</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Testing<span class="token punctuation">\</span>RefreshDatabase</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Tests<span class="token punctuation">\</span>TestCase</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ExampleTest</span> <span class="token keyword">extends</span> <span
                    class="token class-name">TestCase</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Indicates whether the default seeder should run before each test.
     *
     * @var bool
     */</span>
    <span class="token keyword">protected</span> <span class="token variable">$seed</span> <span class="token operator">=</span> <span
                    class="token boolean constant">true</span><span class="token punctuation">;</span>

    <span class="token comment">//...</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Если <code>$seed</code> свойство равно <code>true</code>, тест будет запускать
    <code>Database\Seeders\DatabaseSeeder</code> класс перед каждым тестом. Однако вы можете указать конкретный сидер,
    который должен выполняться, определив <code>$seeder</code> свойство в вашем тестовом классе:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Database<span class="token punctuation">\</span>Seeders<span
                    class="token punctuation">\</span>OrderStatusSeeder</span><span class="token punctuation">;</span>

<span class="token comment">/**
 * Run a specific seeder before each test.
 *
 * @var string
 */</span>
<span class="token keyword">protected</span> <span class="token variable">$seeder</span> <span
                class="token operator">=</span> OrderStatusSeeder<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="available-assertions"><a href="#available-assertions">Доступные утверждения</a></h2>
<p>Laravel предоставляет несколько утверждений базы данных для ваших тестов функций <a href="https://phpunit.de/">PHPUnit</a>.
    Мы обсудим каждое из этих утверждений ниже.</p>
<p></p>
<h4 id="assert-database-count"><a href="#assert-database-count">assertDatabaseCount</a></h4>
<p>Утверждают, что таблица в базе данных содержит заданное количество записей:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertDatabaseCount</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">,</span> <span class="token number">5</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-database-has"><a href="#assert-database-has">assertDatabaseHas</a></h4>
<p>Утверждают, что таблица в базе данных содержит записи, соответствующие заданным ограничениям запроса ключ /
    значение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertDatabaseHas</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'sally@example.com'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-database-missing"><a href="#assert-database-missing">assertDatabaseMissing</a></h4>
<p>Утверждение, что таблица в базе данных не содержит записей, соответствующих заданным ограничениям запроса ключ /
    значение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertDatabaseMissing</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'sally@example.com'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="assert-deleted"><a href="#assert-deleted">assertDeleted</a></h4>
<p><code>assertDeleted</code> Утверждает, что данная модель Eloquent была удалена из базы данных:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

<span class="token variable">$user</span> <span class="token operator">=</span> User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">delete</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">assertDeleted</span><span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Этот <code>assertSoftDeleted</code> метод может использоваться для подтверждения того, что данная модель Eloquent
    была "мягко удалена":</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertSoftDeleted</span><span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
