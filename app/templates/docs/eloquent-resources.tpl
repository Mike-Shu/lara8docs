<h1>Eloquent: ресурсы API <sup>API resources</sup></h1>
<ul>
    <li><a href="eloquent-resources#introduction">Вступление</a></li>
    <li><a href="eloquent-resources#generating-resources">Создание ресурсов</a></li>
    <li><a href="eloquent-resources#concept-overview">Обзор концепции</a>
        <ul>
            <li><a href="eloquent-resources#resource-collections">Коллекции ресурсов</a></li>
        </ul>
    </li>
    <li><a href="eloquent-resources#writing-resources">Написание ресурсов</a>
        <ul>
            <li><a href="eloquent-resources#data-wrapping">Упаковка данных</a></li>
            <li><a href="eloquent-resources#pagination">Пагинация</a></li>
            <li><a href="eloquent-resources#conditional-attributes">Условные атрибуты</a></li>
            <li><a href="eloquent-resources#conditional-relationships">Условные отношения</a></li>
            <li><a href="eloquent-resources#adding-meta-data">Добавление метаданных</a></li>
        </ul>
    </li>
    <li><a href="eloquent-resources#resource-responses">Ответы ресурсов</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>При создании API вам может потребоваться уровень преобразования, который находится между вашими моделями Eloquent и
    ответами JSON, которые фактически возвращаются пользователям вашего приложения. Например, вы можете захотеть
    отобразить определенные атрибуты для подмножества пользователей, а не для других, или вы можете всегда включать
    определенные отношения в представление JSON ваших моделей. Классы ресурсов Eloquent позволяют легко и выразительно
    преобразовывать модели и коллекции моделей в JSON.</p>
<p>Конечно, вы всегда можете преобразовать модели или коллекции Eloquent в JSON, используя их <code>toJson</code>
    методы; однако ресурсы Eloquent обеспечивают более детальный и надежный контроль над сериализацией JSON ваших
    моделей и их взаимосвязями.</p>
<p></p>
<h2 id="generating-resources"><a href="#generating-resources">Создание ресурсов</a></h2>
<p>Для создания класса ресурсов вы можете использовать команду <code>make:resource</code> Artisan. По умолчанию ресурсы
    будут помещены в <code>app/Http/Resources</code> каталог вашего приложения. Ресурсы расширяют <code>Illuminate\Http\Resources\Json\JsonResource</code>
    класс:</p>
<pre class=" language-php"><code class=" language-php">php artisan make<span class="token punctuation">:</span>resource UserResource</code></pre>
<p></p>
<h4 id="generating-resource-collections"><a href="#generating-resource-collections">Коллекции ресурсов</a></h4>
<p>Помимо создания ресурсов, преобразующих отдельные модели, вы можете создавать ресурсы, отвечающие за преобразование
    коллекций моделей. Это позволяет вашим ответам JSON включать ссылки и другую метаинформацию, имеющую отношение ко
    всей коллекции данного ресурса.</p>
<p>Чтобы создать коллекцию ресурсов, вы должны использовать <code>--collection</code> флаг при создании ресурса. Или
    включение слова <code>Collection</code> в имя ресурса укажет Laravel, что он должен создать ресурс коллекции.
    Ресурсы коллекции расширяют <code>Illuminate\Http\Resources\Json\ResourceCollection</code> класс:</p>
<pre class=" language-php"><code class=" language-php">php artisan make<span class="token punctuation">:</span>resource User <span
                class="token operator">--</span>collection

php artisan make<span class="token punctuation">:</span>resource UserCollection</code></pre>
<p></p>
<h2 id="concept-overview"><a href="#concept-overview">Обзор концепции</a></h2>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Это общий обзор ресурсов и коллекций ресурсов. Мы настоятельно рекомендуем вам прочитать другие разделы этой
            документации, чтобы лучше понять возможности настройки и возможности, предлагаемые вам ресурсами.</p></p>
    </div>
</blockquote>
<p>Прежде чем погрузиться во все варианты, доступные вам при написании ресурсов, давайте сначала рассмотрим, как ресурсы
    используются в Laravel. Класс ресурсов представляет собой единую модель, которую необходимо преобразовать в
    структуру JSON. Например, вот простой <code>UserResource</code> класс ресурса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Resources</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Resources<span class="token punctuation">\</span>Json<span
                        class="token punctuation">\</span>JsonResource</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">UserResource</span> <span class="token keyword">extends</span> <span
                    class="token class-name">JsonResource</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toArray</span><span
                    class="token punctuation">(</span><span class="token variable">$request</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token punctuation">[</span>
            <span class="token single-quoted-string string">'id'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">id</span><span
                    class="token punctuation">,</span>
            <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">name</span><span
                    class="token punctuation">,</span>
            <span class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">email</span><span
                    class="token punctuation">,</span>
            <span class="token single-quoted-string string">'created_at'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">created_at</span><span
                    class="token punctuation">,</span>
            <span class="token single-quoted-string string">'updated_at'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">updated_at</span><span
                    class="token punctuation">,</span>
        <span class="token punctuation">]</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Каждый класс ресурсов определяет <code>toArray</code> метод, который возвращает массив атрибутов, которые должны быть
    преобразованы в JSON, когда ресурс возвращается в качестве ответа от метода маршрута или контроллера.</p>
<p>Обратите внимание, что мы можем получить доступ к свойствам модели непосредственно из <code>$this</code> переменной.
    Это связано с тем, что класс ресурсов будет автоматически передавать свойства и методы доступа к базовой модели для
    удобного доступа. Как только ресурс определен, он может быть возвращен из маршрута или контроллера. Ресурс принимает
    базовый экземпляр модели через свой конструктор:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Resources<span
                    class="token punctuation">\</span>UserResource</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/user/{literal}{id}{/literal}'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$id</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token keyword">new</span> <span
                class="token class-name">UserResource</span><span class="token punctuation">(</span>User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">findOrFail</span><span
                class="token punctuation">(</span><span class="token variable">$id</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="resource-collections"><a href="#resource-collections">Коллекции ресурсов</a></h3>
<p>Если вы возвращаете коллекцию ресурсов или ответ с <code>collection</code> разбивкой на страницы, вы должны
    использовать метод, предоставленный вашим классом ресурсов, при создании экземпляра ресурса в вашем маршруте или
    контроллере:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Resources<span
                    class="token punctuation">\</span>UserResource</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/users'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> UserResource<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">collection</span><span
                class="token punctuation">(</span>User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Обратите внимание, что это не позволяет добавлять пользовательские метаданные, которые могут потребоваться возвращать
    с вашей коллекцией. Если вы хотите настроить ответ коллекции ресурсов, вы можете создать выделенный ресурс для
    представления коллекции:</p>
<pre class=" language-php"><code class=" language-php">php artisan make<span class="token punctuation">:</span>resource UserCollection</code></pre>
<p>После создания класса коллекции ресурсов вы можете легко определить любые метаданные, которые должны быть включены в
    ответ:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Resources</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Resources<span class="token punctuation">\</span>Json<span
                        class="token punctuation">\</span>ResourceCollection</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">UserCollection</span> <span
                    class="token keyword">extends</span> <span class="token class-name">ResourceCollection</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Transform the resource collection into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toArray</span><span
                    class="token punctuation">(</span><span class="token variable">$request</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token punctuation">[</span>
            <span class="token single-quoted-string string">'data'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">collection</span><span
                    class="token punctuation">,</span>
            <span class="token single-quoted-string string">'links'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token punctuation">[</span>
                <span class="token single-quoted-string string">'self'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span
                    class="token single-quoted-string string">'link-value'</span><span
                    class="token punctuation">,</span>
            <span class="token punctuation">]</span><span class="token punctuation">,</span>
        <span class="token punctuation">]</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>После определения вашей коллекции ресурсов ее можно вернуть из маршрута или контроллера:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Resources<span
                    class="token punctuation">\</span>UserCollection</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/users'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token keyword">new</span> <span
                class="token class-name">UserCollection</span><span class="token punctuation">(</span>User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="preserving-collection-keys"><a href="#preserving-collection-keys">Сохранение ключей коллекции</a></h4>
<p>При возврате коллекции ресурсов из маршрута Laravel сбрасывает ключи коллекции, чтобы они располагались в числовом
    порядке. Однако вы можете добавить <code>preserveKeys</code> свойство в свой класс ресурсов, указывающее, должны ли
    сохраняться исходные ключи коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Resources</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Resources<span class="token punctuation">\</span>Json<span
                        class="token punctuation">\</span>JsonResource</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">UserResource</span> <span class="token keyword">extends</span> <span
                    class="token class-name">JsonResource</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Indicates if the resource's collection keys should be preserved.
     *
     * @var bool
     */</span>
    <span class="token keyword">public</span> <span class="token variable">$preserveKeys</span> <span
                    class="token operator">=</span> <span class="token boolean constant">true</span><span
                    class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Если для <code>preserveKeys</code> свойства установлено значение <code>true</code>, ключи коллекции будут сохранены
    при возврате коллекции из маршрута или контроллера:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Resources<span
                    class="token punctuation">\</span>UserResource</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/users'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> UserResource<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">collection</span><span
                class="token punctuation">(</span>User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">keyBy</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="customizing-the-underlying-resource-class"><a href="#customizing-the-underlying-resource-class">Настройка
        базового класса ресурсов</a></h4>
<p>Обычно <code>$this-&gt;collection</code> свойство коллекции ресурсов автоматически заполняется результатом
    сопоставления каждого элемента коллекции с его единственным классом ресурсов. Предполагается, что единственным
    классом ресурсов является имя класса коллекции без завершающей <code>Collection</code> части имени класса. Кроме
    того, в зависимости от ваших личных предпочтений, отдельный класс ресурсов может иметь суффикс <code>Resource</code>.
</p>
<p>Например, <code>UserCollection</code> будет пытаться сопоставить указанные пользовательские экземпляры с <code>UserResource</code>
    ресурсом. Чтобы настроить это поведение, вы можете переопределить <code>$collects</code> свойство своей коллекции
    ресурсов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Resources</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Resources<span class="token punctuation">\</span>Json<span
                        class="token punctuation">\</span>ResourceCollection</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">UserCollection</span> <span
                    class="token keyword">extends</span> <span class="token class-name">ResourceCollection</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * The resource that this resource collects.
     *
     * @var string
     */</span>
    <span class="token keyword">public</span> <span class="token variable">$collects</span> <span
                    class="token operator">=</span> Member<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h2 id="writing-resources"><a href="#writing-resources">Написание ресурсов</a></h2>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Если вы не читали <a href="eloquent-resources#concept-overview">обзор концепции</a>, настоятельно
            рекомендуется сделать это перед тем, как приступить к работе с этой документацией.</p></p></div>
</blockquote>
<p>По сути, ресурсы просты. Им нужно только преобразовать данную модель в массив. Итак, каждый ресурс содержит <code>toArray</code>
    метод, который переводит атрибуты вашей модели в удобный для API массив, который может быть возвращен из маршрутов
    или контроллеров вашего приложения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Resources</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Resources<span class="token punctuation">\</span>Json<span
                        class="token punctuation">\</span>JsonResource</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">UserResource</span> <span class="token keyword">extends</span> <span
                    class="token class-name">JsonResource</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toArray</span><span
                    class="token punctuation">(</span><span class="token variable">$request</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token punctuation">[</span>
            <span class="token single-quoted-string string">'id'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">id</span><span
                    class="token punctuation">,</span>
            <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">name</span><span
                    class="token punctuation">,</span>
            <span class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">email</span><span
                    class="token punctuation">,</span>
            <span class="token single-quoted-string string">'created_at'</span> <span
                    class="token operator">=</span><span class="token operator">&gt;</span> <span
                    class="token variable">$this</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token property">created_at</span><span
                    class="token punctuation">,</span>
            <span class="token single-quoted-string string">'updated_at'</span> <span
                    class="token operator">=</span><span class="token operator">&gt;</span> <span
                    class="token variable">$this</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token property">updated_at</span><span
                    class="token punctuation">,</span>
        <span class="token punctuation">]</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Как только ресурс определен, он может быть возвращен непосредственно из маршрута или контроллера:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Resources<span
                    class="token punctuation">\</span>UserResource</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/user/{literal}{id}{/literal}'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$id</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token keyword">new</span> <span class="token class-name">UserResource</span><span
                class="token punctuation">(</span>User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">findOrFail</span><span
                class="token punctuation">(</span><span class="token variable">$id</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="relationships"><a href="#relationships">Отношения</a></h4>
<p>Если вы хотите включить связанные ресурсы в свой ответ, вы можете добавить их в массив, возвращаемый методом вашего
    ресурса <code>toArray</code>. В этом примере мы будем использовать метод <code>PostResource</code> ресурса, <code>collection</code>
    чтобы добавить сообщения блога пользователя в ответ ресурса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Resources<span
                    class="token punctuation">\</span>PostResource</span><span class="token punctuation">;</span>

<span class="token comment">/**
 * Transform the resource into an array.
 *
 * @param  \Illuminate\Http\Request  $request
 * @return array
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toArray</span><span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">name</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">email</span><span
                class="token punctuation">,</span>
        <span class="token single-quoted-string string">'posts'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> PostResource<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">collection</span><span
                class="token punctuation">(</span><span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">posts</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'created_at'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">created_at</span><span
                class="token punctuation">,</span>
        <span class="token single-quoted-string string">'updated_at'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">updated_at</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Если вы хотите включить отношения только тогда, когда они уже загружены, ознакомьтесь с документацией по <a
                    href="eloquent-resources#conditional-relationships">условным отношениям</a>.</p></p></div>
</blockquote>
<p></p>
<h4 id="writing-resource-collections"><a href="#writing-resource-collections">Коллекции ресурсов</a></h4>
<p>В то время как ресурсы преобразуют одну модель в массив, коллекции ресурсов преобразуют коллекцию моделей в массив.
    Однако необязательно определять класс коллекции ресурсов для каждой из ваших моделей, поскольку все ресурсы
    предоставляют <code>collection</code> метод для генерации специальной коллекции ресурсов на лету:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Resources<span
                    class="token punctuation">\</span>UserResource</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/users'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> UserResource<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">collection</span><span
                class="token punctuation">(</span>User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Однако, если вам нужно настроить метаданные, возвращаемые с коллекцией, необходимо определить собственную коллекцию
    ресурсов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Resources</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Resources<span class="token punctuation">\</span>Json<span
                        class="token punctuation">\</span>ResourceCollection</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">UserCollection</span> <span
                    class="token keyword">extends</span> <span class="token class-name">ResourceCollection</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Transform the resource collection into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toArray</span><span
                    class="token punctuation">(</span><span class="token variable">$request</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token punctuation">[</span>
            <span class="token single-quoted-string string">'data'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">collection</span><span
                    class="token punctuation">,</span>
            <span class="token single-quoted-string string">'links'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token punctuation">[</span>
                <span class="token single-quoted-string string">'self'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span
                    class="token single-quoted-string string">'link-value'</span><span
                    class="token punctuation">,</span>
            <span class="token punctuation">]</span><span class="token punctuation">,</span>
        <span class="token punctuation">]</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Как и отдельные ресурсы, коллекции ресурсов могут быть возвращены непосредственно из маршрутов или контроллеров:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Resources<span
                    class="token punctuation">\</span>UserCollection</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/users'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token keyword">new</span> <span class="token class-name">UserCollection</span><span
                class="token punctuation">(</span>User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="data-wrapping"><a href="#data-wrapping">Упаковка данных</a></h3>
<p>По умолчанию ваш внешний ресурс заключен в <code>data</code> ключ, когда ответ ресурса преобразуется в JSON. Так,
    например, типичный ответ на сбор ресурсов выглядит следующим образом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token punctuation">{literal}{{/literal}</span>
    <span class="token double-quoted-string string">"data"</span><span class="token punctuation">:</span> <span
                class="token punctuation">[</span>
        <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token double-quoted-string string">"id"</span><span class="token punctuation">:</span> <span
                class="token number">1</span><span class="token punctuation">,</span>
            <span class="token double-quoted-string string">"name"</span><span class="token punctuation">:</span> <span
                class="token double-quoted-string string">"Eladio Schroeder Sr."</span><span
                class="token punctuation">,</span>
            <span class="token double-quoted-string string">"email"</span><span class="token punctuation">:</span> <span
                class="token double-quoted-string string">"therese28@example.com"</span><span class="token punctuation">,</span>
        <span class="token punctuation">}</span><span class="token punctuation">,</span>
        <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token double-quoted-string string">"id"</span><span class="token punctuation">:</span> <span
                class="token number">2</span><span class="token punctuation">,</span>
            <span class="token double-quoted-string string">"name"</span><span class="token punctuation">:</span> <span
                class="token double-quoted-string string">"Liliana Mayert"</span><span
                class="token punctuation">,</span>
            <span class="token double-quoted-string string">"email"</span><span class="token punctuation">:</span> <span
                class="token double-quoted-string string">"evandervort@example.com"</span><span
                class="token punctuation">,</span>
        <span class="token punctuation">}</span>
    <span class="token punctuation">]</span>
<span class="token punctuation">}</span></code></pre>
<p>Если вы хотите использовать собственный ключ вместо <code>data</code>, вы можете определить <code>$wrap</code>
    атрибут в классе ресурсов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Resources</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Resources<span class="token punctuation">\</span>Json<span
                        class="token punctuation">\</span>JsonResource</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">UserResource</span> <span class="token keyword">extends</span> <span
                    class="token class-name">JsonResource</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * The "data" wrapper that should be applied.
     *
     * @var string
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">static</span> <span class="token variable">$wrap</span> <span
                    class="token operator">=</span> <span class="token single-quoted-string string">'user'</span><span
                    class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Если вы хотите отключить упаковку самого внешнего ресурса, вы должны вызвать <code>withoutWrapping</code> метод в
    базовом <code>Illuminate\Http\Resources\Json\JsonResource</code> классе. Как правило, вы должны вызывать этот метод
    у вашего <code>AppServiceProvider</code> или другого <a href="providers">поставщика услуг,</a> который загружается
    при каждом запросе вашего приложения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Providers</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Resources<span class="token punctuation">\</span>Json<span
                        class="token punctuation">\</span>JsonResource</span><span class="token punctuation">;</span>
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
        JsonResource<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">withoutWrapping</span><span class="token punctuation">(</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Этот <code>withoutWrapping</code> метод влияет только на самый внешний ответ и не удаляет <code>data</code>
            ключи, которые вы вручную добавляете в свои собственные коллекции ресурсов.</p></p></div>
</blockquote>
<p></p>
<h4 id="wrapping-nested-resources"><a href="#wrapping-nested-resources">Обертывание вложенных ресурсов</a></h4>
<p>У вас есть полная свобода определять, как обернуты отношения между вашими ресурсами. Если вы хотите, чтобы все
    коллекции ресурсов были заключены в <code>data</code> ключ, независимо от их вложенности, вы должны определить класс
    коллекции ресурсов для каждого ресурса и вернуть коллекцию в пределах <code>data</code> ключа.</p>
<p>Вам может быть интересно, приведет ли это к тому, что ваш внешний ресурс будет заключен в два <code>data</code>
    ключа. Не волнуйтесь, Laravel никогда не позволит вашим ресурсам случайно обернуться двойной оболочкой, поэтому вам
    не нужно беспокоиться об уровне вложенности коллекции ресурсов, которую вы трансформируете:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Resources</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Resources<span class="token punctuation">\</span>Json<span
                        class="token punctuation">\</span>ResourceCollection</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">CommentsCollection</span> <span
                    class="token keyword">extends</span> <span class="token class-name">ResourceCollection</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Transform the resource collection into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toArray</span><span
                    class="token punctuation">(</span><span class="token variable">$request</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token punctuation">[</span><span
                    class="token single-quoted-string string">'data'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">collection</span><span
                    class="token punctuation">]</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h4 id="data-wrapping-and-pagination"><a href="#data-wrapping-and-pagination">Перенос данных и разбивка на страницы</a>
</h4>
<p>При возврате разбитых на страницы коллекций через ответ ресурса Laravel обернет данные ваших ресурсов в
    <code>data</code> ключ, даже если <code>withoutWrapping</code> метод был вызван. Это происходит потому, что ответы
    всегда разбивается на страницы содержат <code>meta</code> и <code>links</code> ключи с информацией о состоянии
    постраничной навигации по:</p>
<pre class=" language-php"><code class=" language-php"><span class="token punctuation">{literal}{{/literal}</span>
    <span class="token double-quoted-string string">"data"</span><span class="token punctuation">:</span> <span
                class="token punctuation">[</span>
        <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token double-quoted-string string">"id"</span><span class="token punctuation">:</span> <span
                class="token number">1</span><span class="token punctuation">,</span>
            <span class="token double-quoted-string string">"name"</span><span class="token punctuation">:</span> <span
                class="token double-quoted-string string">"Eladio Schroeder Sr."</span><span
                class="token punctuation">,</span>
            <span class="token double-quoted-string string">"email"</span><span class="token punctuation">:</span> <span
                class="token double-quoted-string string">"therese28@example.com"</span><span class="token punctuation">,</span>
        <span class="token punctuation">}</span><span class="token punctuation">,</span>
        <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token double-quoted-string string">"id"</span><span class="token punctuation">:</span> <span
                class="token number">2</span><span class="token punctuation">,</span>
            <span class="token double-quoted-string string">"name"</span><span class="token punctuation">:</span> <span
                class="token double-quoted-string string">"Liliana Mayert"</span><span
                class="token punctuation">,</span>
            <span class="token double-quoted-string string">"email"</span><span class="token punctuation">:</span> <span
                class="token double-quoted-string string">"evandervort@example.com"</span><span
                class="token punctuation">,</span>
        <span class="token punctuation">}</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token double-quoted-string string">"links"</span><span class="token punctuation">:</span><span
                class="token punctuation">{literal}{{/literal}</span>
        <span class="token double-quoted-string string">"first"</span><span class="token punctuation">:</span> <span
                class="token double-quoted-string string">"http://example.com/pagination?page=1"</span><span
                class="token punctuation">,</span>
        <span class="token double-quoted-string string">"last"</span><span class="token punctuation">:</span> <span
                class="token double-quoted-string string">"http://example.com/pagination?page=1"</span><span
                class="token punctuation">,</span>
        <span class="token double-quoted-string string">"prev"</span><span class="token punctuation">:</span> <span
                class="token constant">null</span><span class="token punctuation">,</span>
        <span class="token double-quoted-string string">"next"</span><span class="token punctuation">:</span> <span
                class="token constant">null</span>
    <span class="token punctuation">}</span><span class="token punctuation">,</span>
    <span class="token double-quoted-string string">"meta"</span><span class="token punctuation">:</span><span
                class="token punctuation">{literal}{{/literal}</span>
        <span class="token double-quoted-string string">"current_page"</span><span
                class="token punctuation">:</span> <span class="token number">1</span><span
                class="token punctuation">,</span>
        <span class="token double-quoted-string string">"from"</span><span class="token punctuation">:</span> <span
                class="token number">1</span><span class="token punctuation">,</span>
        <span class="token double-quoted-string string">"last_page"</span><span class="token punctuation">:</span> <span
                class="token number">1</span><span class="token punctuation">,</span>
        <span class="token double-quoted-string string">"path"</span><span class="token punctuation">:</span> <span
                class="token double-quoted-string string">"http://example.com/pagination"</span><span
                class="token punctuation">,</span>
        <span class="token double-quoted-string string">"per_page"</span><span class="token punctuation">:</span> <span
                class="token number">15</span><span class="token punctuation">,</span>
        <span class="token double-quoted-string string">"to"</span><span class="token punctuation">:</span> <span
                class="token number">10</span><span class="token punctuation">,</span>
        <span class="token double-quoted-string string">"total"</span><span class="token punctuation">:</span> <span
                class="token number">10</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="pagination"><a href="#pagination">Пагинация</a></h3>
<p>Вы можете передать экземпляр Paginator Laravel <code>collection</code> методу ресурса или пользовательской коллекции
    ресурсов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Resources<span
                    class="token punctuation">\</span>UserCollection</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/users'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token keyword">new</span> <span class="token class-name">UserCollection</span><span
                class="token punctuation">(</span>User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">paginate</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Ответы с разбивкой на страницы всегда содержат <code>meta</code> и <code>links</code> ключи с информацией о состоянии
    пагинатора:</p>
<pre class=" language-php"><code class=" language-php"><span class="token punctuation">{literal}{{/literal}</span>
    <span class="token double-quoted-string string">"data"</span><span class="token punctuation">:</span> <span
                class="token punctuation">[</span>
        <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token double-quoted-string string">"id"</span><span class="token punctuation">:</span> <span
                class="token number">1</span><span class="token punctuation">,</span>
            <span class="token double-quoted-string string">"name"</span><span class="token punctuation">:</span> <span
                class="token double-quoted-string string">"Eladio Schroeder Sr."</span><span
                class="token punctuation">,</span>
            <span class="token double-quoted-string string">"email"</span><span class="token punctuation">:</span> <span
                class="token double-quoted-string string">"therese28@example.com"</span><span class="token punctuation">,</span>
        <span class="token punctuation">}</span><span class="token punctuation">,</span>
        <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token double-quoted-string string">"id"</span><span class="token punctuation">:</span> <span
                class="token number">2</span><span class="token punctuation">,</span>
            <span class="token double-quoted-string string">"name"</span><span class="token punctuation">:</span> <span
                class="token double-quoted-string string">"Liliana Mayert"</span><span
                class="token punctuation">,</span>
            <span class="token double-quoted-string string">"email"</span><span class="token punctuation">:</span> <span
                class="token double-quoted-string string">"evandervort@example.com"</span><span
                class="token punctuation">,</span>
        <span class="token punctuation">}</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token double-quoted-string string">"links"</span><span class="token punctuation">:</span><span
                class="token punctuation">{literal}{{/literal}</span>
        <span class="token double-quoted-string string">"first"</span><span class="token punctuation">:</span> <span
                class="token double-quoted-string string">"http://example.com/pagination?page=1"</span><span
                class="token punctuation">,</span>
        <span class="token double-quoted-string string">"last"</span><span class="token punctuation">:</span> <span
                class="token double-quoted-string string">"http://example.com/pagination?page=1"</span><span
                class="token punctuation">,</span>
        <span class="token double-quoted-string string">"prev"</span><span class="token punctuation">:</span> <span
                class="token constant">null</span><span class="token punctuation">,</span>
        <span class="token double-quoted-string string">"next"</span><span class="token punctuation">:</span> <span
                class="token constant">null</span>
    <span class="token punctuation">}</span><span class="token punctuation">,</span>
    <span class="token double-quoted-string string">"meta"</span><span class="token punctuation">:</span><span
                class="token punctuation">{literal}{{/literal}</span>
        <span class="token double-quoted-string string">"current_page"</span><span
                class="token punctuation">:</span> <span class="token number">1</span><span
                class="token punctuation">,</span>
        <span class="token double-quoted-string string">"from"</span><span class="token punctuation">:</span> <span
                class="token number">1</span><span class="token punctuation">,</span>
        <span class="token double-quoted-string string">"last_page"</span><span class="token punctuation">:</span> <span
                class="token number">1</span><span class="token punctuation">,</span>
        <span class="token double-quoted-string string">"path"</span><span class="token punctuation">:</span> <span
                class="token double-quoted-string string">"http://example.com/pagination"</span><span
                class="token punctuation">,</span>
        <span class="token double-quoted-string string">"per_page"</span><span class="token punctuation">:</span> <span
                class="token number">15</span><span class="token punctuation">,</span>
        <span class="token double-quoted-string string">"to"</span><span class="token punctuation">:</span> <span
                class="token number">10</span><span class="token punctuation">,</span>
        <span class="token double-quoted-string string">"total"</span><span class="token punctuation">:</span> <span
                class="token number">10</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="conditional-attributes"><a href="#conditional-attributes">Условные атрибуты</a></h3>
<p>Иногда вы можете захотеть включить атрибут в ответ ресурса, только если данное условие выполнено. Например, вы можете
    захотеть включить значение, только если текущий пользователь является «администратором». Laravel предоставляет
    множество вспомогательных методов, которые помогут вам в этой ситуации. Этот <code>when</code> метод может
    использоваться для условного добавления атрибута к ответу ресурса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Auth</span><span
                class="token punctuation">;</span>

<span class="token comment">/**
 * Transform the resource into an array.
 *
 * @param  \Illuminate\Http\Request  $request
 * @return array
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toArray</span><span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">name</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">email</span><span
                class="token punctuation">,</span>
        <span class="token single-quoted-string string">'secret'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">when</span><span class="token punctuation">(</span>Auth<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">user</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">isAdmin</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'secret-value'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'created_at'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">created_at</span><span
                class="token punctuation">,</span>
        <span class="token single-quoted-string string">'updated_at'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">updated_at</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>В этом примере <code>secret</code> ключ будет возвращен в окончательном ответе ресурса только в том случае, если
    <code>isAdmin</code> возвращается метод аутентифицированного пользователя <code>true</code>. Если метод вернется
    <code>false</code>, <code>secret</code> ключ будет удален из ответа ресурса перед его отправкой клиенту. Этот <code>when</code>
    метод позволяет выразительно определять ресурсы, не прибегая к условным операторам при построении массива.</p>
<p><code>when</code> Метод также принимает замыкание в качестве второго аргумента, что позволяет рассчитать итоговое
    значение, только если данное условие <code>true</code>:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'secret'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">when</span><span class="token punctuation">(</span>Auth<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">user</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">isAdmin</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token single-quoted-string string">'secret-value'</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">,</span></code></pre>
<p></p>
<h4 id="merging-conditional-attributes"><a href="#merging-conditional-attributes">Слияние условных атрибутов</a></h4>
<p>Иногда у вас может быть несколько атрибутов, которые следует включать в ответ ресурса только при одном и том же
    условии. В этом случае вы можете использовать этот <code>mergeWhen</code> метод для включения атрибутов в ответ,
    только если заданное условие <code>true</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Transform the resource into an array.
 *
 * @param  \Illuminate\Http\Request  $request
 * @return array
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toArray</span><span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">name</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">email</span><span
                class="token punctuation">,</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">mergeWhen</span><span
                class="token punctuation">(</span>Auth<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">user</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">isAdmin</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
            <span class="token single-quoted-string string">'first-secret'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'value'</span><span class="token punctuation">,</span>
            <span class="token single-quoted-string string">'second-secret'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'value'</span><span
                class="token punctuation">,</span>
        <span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'created_at'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">created_at</span><span
                class="token punctuation">,</span>
        <span class="token single-quoted-string string">'updated_at'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">updated_at</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Опять же, если задано условие <code>false</code>, эти атрибуты будут удалены из ответа ресурса перед его отправкой
    клиенту.</p>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Этот <code>mergeWhen</code> метод не следует использовать в массивах, в которых используются строковые и
            числовые ключи. Кроме того, его не следует использовать в массивах с цифровыми клавишами, которые не
            упорядочены последовательно.</p></p></div>
</blockquote>
<p></p>
<h3 id="conditional-relationships"><a href="#conditional-relationships">Условные отношения</a></h3>
<p>В дополнение к условной загрузке атрибутов вы можете условно включать отношения в свои ответы на ресурсы в
    зависимости от того, было ли отношение уже загружено в модель. Это позволяет вашему контроллеру решать, какие
    отношения должны быть загружены в модель, и ваш ресурс может легко включить их, только когда они действительно были
    загружены. В конечном итоге это позволяет избежать проблем с запросом "N + 1" в ваших ресурсах.</p>
<p>Этот <code>whenLoaded</code> метод может использоваться для условной загрузки отношения. Чтобы избежать ненужной
    загрузки отношений, этот метод принимает имя отношения вместо самого отношения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Resources<span
                    class="token punctuation">\</span>PostResource</span><span class="token punctuation">;</span>

<span class="token comment">/**
 * Transform the resource into an array.
 *
 * @param  \Illuminate\Http\Request  $request
 * @return array
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toArray</span><span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">name</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">email</span><span
                class="token punctuation">,</span>
        <span class="token single-quoted-string string">'posts'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> PostResource<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">collection</span><span
                class="token punctuation">(</span><span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">whenLoaded</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'posts'</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span>
        <span class="token single-quoted-string string">'created_at'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">created_at</span><span
                class="token punctuation">,</span>
        <span class="token single-quoted-string string">'updated_at'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">updated_at</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>В этом примере, если отношение не было загружено, <code>posts</code> ключ будет удален из ответа ресурса перед его
    отправкой клиенту.</p>
<p></p>
<h4 id="conditional-pivot-information"><a href="#conditional-pivot-information">Условная сводная информация</a></h4>
<p>В дополнение к условному включению информации о взаимосвязях в ответы на ресурсы, вы можете условно включить данные
    из промежуточных таблиц отношений «многие ко многим» с помощью этого <code>whenPivotLoaded</code> метода. <code>whenPivotLoaded</code>
    Метод принимает имя сводной таблицы в качестве первого аргумента. Второй аргумент должен быть закрытием, которое
    возвращает значение, которое должно быть возвращено, если в модели доступна сводная информация:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Transform the resource into an array.
 *
 * @param  \Illuminate\Http\Request  $request
 * @return array
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toArray</span><span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">name</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'expires_at'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">whenPivotLoaded</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'role_user'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">pivot</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">expires_at</span><span
                class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Если ваши отношения используют <a href="eloquent-relationships#defining-custom-intermediate-table-models">пользовательскую
        модель промежуточной таблицы</a>, вы можете передать экземпляр модели промежуточной таблицы в качестве первого
    аргумента <code>whenPivotLoaded</code> методу:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'expires_at'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">whenPivotLoaded</span><span
                class="token punctuation">(</span><span class="token keyword">new</span> <span class="token class-name">Membership</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">pivot</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">expires_at</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">,</span></code></pre>
<p>Если ваша промежуточная таблица использует другой метод доступа, кроме <code>pivot</code>, вы можете использовать
    <code>whenPivotLoadedAs</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Transform the resource into an array.
 *
 * @param  \Illuminate\Http\Request  $request
 * @return array
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toArray</span><span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">name</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'expires_at'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">whenPivotLoadedAs</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'subscription'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'role_user'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">subscription</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">expires_at</span><span
                class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="adding-meta-data"><a href="#adding-meta-data">Добавление метаданных</a></h3>
<p>Некоторые стандарты API JSON требуют добавления метаданных в ответы на ваши ресурсы и коллекции ресурсов. Это часто
    включает такие вещи, как <code>links</code> ресурс или связанные ресурсы, или метаданные о самом ресурсе. Если вам
    нужно вернуть дополнительные метаданные о ресурсе, включите их в свой <code>toArray</code> метод. Например, вы
    можете включить <code>link</code> информацию при преобразовании коллекции ресурсов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Transform the resource into an array.
 *
 * @param  \Illuminate\Http\Request  $request
 * @return array
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toArray</span><span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'data'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">collection</span><span
                class="token punctuation">,</span>
        <span class="token single-quoted-string string">'links'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
            <span class="token single-quoted-string string">'self'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'link-value'</span><span class="token punctuation">,</span>
        <span class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>При возврате дополнительных метаданных из ваших ресурсов вам никогда не придется беспокоиться о случайном
    переопределении ключей <code>links</code> или <code>meta</code>, которые автоматически добавляются Laravel при
    возврате ответов с разбивкой на страницы. Любые дополнительные, которые <code>links</code> вы определите, будут
    объединены со ссылками, предоставленными пагинатором.</p>
<p></p>
<h4 id="top-level-meta-data"><a href="#top-level-meta-data">Метаданные верхнего уровня</a></h4>
<p>Иногда вы можете захотеть включить в ответ ресурса только определенные метаданные, если ресурс является самым внешним
    из возвращаемых ресурсов. Обычно это метаинформация об ответе в целом. Чтобы определить эти метаданные, добавьте
    <code>with</code> метод в свой класс ресурсов. Этот метод должен возвращать массив метаданных, которые будут
    включены в ответ ресурса, только если ресурс является самым внешним ресурсом, который трансформируется:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Resources</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Resources<span class="token punctuation">\</span>Json<span
                        class="token punctuation">\</span>ResourceCollection</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">UserCollection</span> <span
                    class="token keyword">extends</span> <span class="token class-name">ResourceCollection</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Transform the resource collection into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toArray</span><span
                    class="token punctuation">(</span><span class="token variable">$request</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token keyword">parent</span><span
                    class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">toArray</span><span class="token punctuation">(</span><span
                    class="token variable">$request</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
     * Get additional data that should be returned with the resource array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">with</span><span
                    class="token punctuation">(</span><span class="token variable">$request</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token punctuation">[</span>
            <span class="token single-quoted-string string">'meta'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token punctuation">[</span>
                <span class="token single-quoted-string string">'key'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span
                    class="token single-quoted-string string">'value'</span><span class="token punctuation">,</span>
            <span class="token punctuation">]</span><span class="token punctuation">,</span>
        <span class="token punctuation">]</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h4 id="adding-meta-data-when-constructing-resources"><a href="#adding-meta-data-when-constructing-resources">Добавление
        метаданных при создании ресурсов</a></h4>
<p>Вы также можете добавить данные верхнего уровня при создании экземпляров ресурсов в своем маршруте или контроллере.
    <code>additional</code> Метод, который доступен на все ресурсы, принимает массив данных, которые должны быть
    добавлены в ответ ресурсов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token punctuation">(</span><span class="token keyword">new</span> <span class="token class-name">UserCollection</span><span
                class="token punctuation">(</span>User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">load</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'roles'</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">additional</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'meta'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span>
                    <span class="token single-quoted-string string">'key'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'value'</span><span class="token punctuation">,</span>
                <span class="token punctuation">]</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="resource-responses"><a href="#resource-responses">Ответы ресурсов</a></h2>
<p>Как вы уже читали, ресурсы могут быть возвращены напрямую из маршрутов и контроллеров:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Resources<span
                    class="token punctuation">\</span>UserResource</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/user/{literal}{id}{/literal}'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$id</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token keyword">new</span> <span class="token class-name">UserResource</span><span
                class="token punctuation">(</span>User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">findOrFail</span><span
                class="token punctuation">(</span><span class="token variable">$id</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Однако иногда вам может потребоваться настроить исходящий HTTP-ответ перед его отправкой клиенту. Это можно сделать
    двумя способами. Во-первых, вы можете привязать <code>response</code> метод к ресурсу. Этот метод вернет <code>Illuminate\Http\JsonResponse</code>
    экземпляр, что даст вам полный контроль над заголовками ответа:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Resources<span
                    class="token punctuation">\</span>UserResource</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/user'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">(</span><span
                class="token keyword">new</span> <span class="token class-name">UserResource</span><span
                class="token punctuation">(</span>User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">response</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">header</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'X-Value'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'True'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>В качестве альтернативы вы можете определить <code>withResponse</code> метод внутри самого ресурса. Этот метод будет
    вызываться, когда ресурс будет возвращен как самый внешний ресурс в ответе:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Resources</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Resources<span class="token punctuation">\</span>Json<span
                        class="token punctuation">\</span>JsonResource</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">UserResource</span> <span class="token keyword">extends</span> <span
                    class="token class-name">JsonResource</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">toArray</span><span
                    class="token punctuation">(</span><span class="token variable">$request</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token punctuation">[</span>
            <span class="token single-quoted-string string">'id'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">id</span><span
                    class="token punctuation">,</span>
        <span class="token punctuation">]</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
     * Customize the outgoing response for the resource.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Illuminate\Http\Response  $response
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">withResponse</span><span
                    class="token punctuation">(</span><span class="token variable">$request</span><span
                    class="token punctuation">,</span> <span class="token variable">$response</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$response</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">header</span><span class="token punctuation">(</span><span
                    class="token single-quoted-string string">'X-Value'</span><span
                    class="token punctuation">,</span> <span
                    class="token single-quoted-string string">'True'</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre> 
