<h1>Eloquent: мутаторы и кастинг <sup>Mutators & casting</sup></h1>
<ul>
    <li><a href="eloquent-mutators#introduction">Вступление</a></li>
    <li><a href="eloquent-mutators#accessors-and-mutators">Аксессоры и мутаторы</a>
        <ul>
            <li><a href="eloquent-mutators#defining-an-accessor">Определение Аксессора</a></li>
            <li><a href="eloquent-mutators#defining-a-mutator">Определение мутатора</a></li>
        </ul>
    </li>
    <li><a href="eloquent-mutators#attribute-casting">Приведение атрибутов</a>
        <ul>
            <li><a href="eloquent-mutators#array-and-json-casting">Приведение массивов и JSON</a></li>
            <li><a href="eloquent-mutators#date-casting">Дата кастинг</a></li>
            <li><a href="eloquent-mutators#query-time-casting">Приведение во время запроса</a></li>
        </ul>
    </li>
    <li><a href="eloquent-mutators#custom-casts">Пользовательские приведения</a>
        <ul>
            <li><a href="eloquent-mutators#value-object-casting">Приведение объекта значения</a></li>
            <li><a href="eloquent-mutators#array-json-serialization">Сериализация массивов / JSON</a></li>
            <li><a href="eloquent-mutators#inbound-casting">Входящий кастинг</a></li>
            <li><a href="eloquent-mutators#cast-parameters">Параметры трансляции</a></li>
            <li><a href="eloquent-mutators#castables">Отливки</a></li>
        </ul>
    </li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Аксессоры, мутаторы и приведение атрибутов позволяют преобразовывать значения атрибутов Eloquent, когда вы извлекаете
    или устанавливаете их в экземплярах модели. Например, вы можете использовать <a href="encryption">шифровальщик
        Laravel</a> для шифрования значения, пока оно хранится в базе данных, а затем автоматически дешифровать атрибут
    при доступе к нему в модели Eloquent. Или вы можете захотеть преобразовать строку JSON, которая хранится в вашей
    базе данных, в массив при доступе к ней через вашу модель Eloquent.</p>
<p></p>
<h2 id="accessors-and-mutators"><a href="#accessors-and-mutators">Аксессоры и мутаторы</a></h2>
<p></p>
<h3 id="defining-an-accessor"><a href="#defining-an-accessor">Определение Аксессора</a></h3>
<p>Средство доступа преобразует значение атрибута Eloquent при обращении к нему. Чтобы определить средство доступа,
    создайте <code>get{literal}{Attribute}{/literal}Attribute</code> метод в своей модели, где
    <code>{literal}{Attribute}{/literal}</code> будет указано имя столбца, к которому вы хотите получить доступ, в
    строгом регистре.</p>
<p>В этом примере мы определим метод доступа для <code>first_name</code> атрибута. Аксессор будет автоматически вызван
    Eloquent при попытке получить значение <code>first_name</code> атрибута:</p>
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
     * Get the user's first name.
     *
     * @param  string  $value
     * @return string
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">getFirstNameAttribute</span><span
                    class="token punctuation">(</span><span class="token variable">$value</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token function">ucfirst</span><span
                    class="token punctuation">(</span><span class="token variable">$value</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Как видите, исходное значение столбца передается методу доступа, что позволяет вам манипулировать и возвращать
    значение. Чтобы получить доступ к значению метода доступа, вы можете просто получить доступ к
    <code>first_name</code> атрибуту в экземпляре модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

<span class="token variable">$user</span> <span class="token operator">=</span> User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$firstName</span> <span class="token operator">=</span> <span
                class="token variable">$user</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">first_name</span><span class="token punctuation">;</span></code></pre>
<p>Вы не ограничены взаимодействием с одним атрибутом в вашем аксессуаре. Вы также можете использовать методы доступа
    для возврата новых вычисленных значений из существующих атрибутов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the user's full name.
 *
 * @return string
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">getFullNameAttribute</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token double-quoted-string string">"<span
                    class="token interpolation"><span class="token punctuation">{literal}{{/literal}</span><span
                        class="token variable">$this</span><span class="token operator">-</span><span
                        class="token operator">&gt;</span><span class="token property">first_name</span><span
                        class="token punctuation">}</span></span> <span class="token interpolation"><span
                        class="token punctuation">{literal}{{/literal}</span><span
                        class="token variable">$this</span><span class="token operator">-</span><span
                        class="token operator">&gt;</span><span class="token property">last_name</span><span
                        class="token punctuation">}</span></span>"</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Если вы хотите, чтобы эти вычисленные значения были добавлены к представлениям массива / JSON вашей модели,
            <a href="eloquent-serialization#appending-values-to-json">вам нужно будет добавить их</a>.</p></p></div>
</blockquote>
<p></p>
<h3 id="defining-a-mutator"><a href="#defining-a-mutator">Определение мутатора</a></h3>
<p>Мутатор преобразует значение атрибута Eloquent, когда оно установлено. Чтобы определить мутатор, определите
    <code>set{literal}{Attribute}{/literal}Attribute</code> метод в вашей модели, где
    <code>{literal}{Attribute}{/literal}</code> это имя столбца, к которому вы хотите получить доступ, в строгом
    регистре.</p>
<p>Определим мутатор для <code>first_name</code> атрибута. Этот мутатор будет автоматически вызван, когда мы попытаемся
    установить значение <code>first_name</code> атрибута в модели:</p>
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
     * Set the user's first name.
     *
     * @param  string  $value
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">setFirstNameAttribute</span><span
                    class="token punctuation">(</span><span class="token variable">$value</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token property">attributes</span><span
                    class="token punctuation">[</span><span
                    class="token single-quoted-string string">'first_name'</span><span
                    class="token punctuation">]</span> <span class="token operator">=</span> <span
                    class="token function">strtolower</span><span class="token punctuation">(</span><span
                    class="token variable">$value</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Мутатор получит значение, установленное для атрибута, что позволит вам управлять этим значением и устанавливать
    управляемое значение во внутреннем <code>$attributes</code> свойстве модели Eloquent. Чтобы использовать наш
    мутатор, нам нужно только установить <code>first_name</code> атрибут в модели Eloquent:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

<span class="token variable">$user</span> <span class="token operator">=</span> User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">first_name</span> <span
                class="token operator">=</span> <span class="token single-quoted-string string">'Sally'</span><span
                class="token punctuation">;</span></code></pre>
<p>В этом примере <code>setFirstNameAttribute</code> функция будет вызываться со значением <code>Sally</code>. Затем
    мутатор применит <code>strtolower</code> функцию к имени и установит полученное значение во внутреннем <code>$attributes</code>
    массиве.</p>
<p></p>
<h2 id="attribute-casting"><a href="#attribute-casting">Приведение атрибутов</a></h2>
<p>Приведение атрибутов обеспечивает функциональность, аналогичную средствам доступа и мутаторам, не требуя от вас
    определения каких-либо дополнительных методов в вашей модели. Вместо этого <code>$casts</code> свойство вашей модели
    предоставляет удобный метод преобразования атрибутов в общие типы данных.</p>
<p><code>$casts</code> Свойство должно быть массивом, где ключ это имя атрибута быть брошенным и значение типа вы хотите
    бросить столбец. Поддерживаемые типы приведения:</p>
<div class="content-list">
    <ul>
        <li><code>array</code></li>
        <li><code>boolean</code></li>
        <li><code>collection</code></li>
        <li><code>date</code></li>
        <li><code>datetime</code></li>
        <li><code>decimal:&lt;digits&gt;</code></li>
        <li><code>double</code></li>
        <li><code>encrypted</code></li>
        <li><code>encrypted:array</code></li>
        <li><code>encrypted:collection</code></li>
        <li><code>encrypted:object</code></li>
        <li><code>float</code></li>
        <li><code>integer</code></li>
        <li><code>object</code></li>
        <li><code>real</code></li>
        <li><code>string</code></li>
        <li><code>timestamp</code></li>
    </ul>
</div>
<p>Чтобы продемонстрировать приведение атрибутов, давайте приведем <code>is_admin</code> атрибут, который хранится в
    нашей базе данных как целое число ( <code>0</code> или <code>1</code> ), к логическому значению:</p>
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
     * The attributes that should be cast.
     *
     * @var array
     */</span>
    <span class="token keyword">protected</span> <span class="token variable">$casts</span> <span
                    class="token operator">=</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'is_admin'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span
                    class="token single-quoted-string string">'boolean'</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
<p>После определения приведения <code>is_admin</code> атрибут всегда будет преобразован в логическое значение при
    доступе к нему, даже если базовое значение хранится в базе данных как целое число:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span> <span
                class="token operator">=</span> App\<span class="token package">Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">if</span> <span class="token punctuation">(</span><span
                class="token variable">$user</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">is_admin</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Атрибуты, которые <code>null</code> не будут использоваться. Кроме того, вы никогда не должны определять
            приведение (или атрибут), имя которого совпадает с именем отношения.</p></p></div>
</blockquote>
<p></p>
<h3 id="array-and-json-casting"><a href="#array-and-json-casting">Приведение массивов и JSON</a></h3>
<p>Приведение <code>array</code> особенно полезно при работе со столбцами, которые хранятся в виде сериализованного
    JSON. Например, если ваша база данных имеет тип поля <code>JSON</code> или, <code>TEXT</code> который содержит
    сериализованный JSON, добавление <code>array</code> преобразования к этому атрибуту автоматически десериализует
    атрибут в массив PHP, когда вы обращаетесь к нему в своей модели Eloquent:</p>
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
     * The attributes that should be cast.
     *
     * @var array
     */</span>
    <span class="token keyword">protected</span> <span class="token variable">$casts</span> <span
                    class="token operator">=</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'options'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span
                    class="token single-quoted-string string">'array'</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
<p>После определения приведения вы можете получить доступ к <code>options</code> атрибуту, и он будет автоматически
    десериализован из JSON в массив PHP. Когда вы устанавливаете значение <code>options</code> атрибута, данный массив
    будет автоматически сериализован обратно в JSON для хранения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

<span class="token variable">$user</span> <span class="token operator">=</span> User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$options</span> <span class="token operator">=</span> <span
                class="token variable">$user</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">options</span><span class="token punctuation">;</span>

<span class="token variable">$options</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'key'</span><span class="token punctuation">]</span> <span
                class="token operator">=</span> <span class="token single-quoted-string string">'value'</span><span
                class="token punctuation">;</span>

<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">options</span> <span
                class="token operator">=</span> <span class="token variable">$options</span><span
                class="token punctuation">;</span>

<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">save</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Чтобы обновить одно поле атрибута JSON с более кратким синтаксисом, вы можете использовать <code>-&gt;</code>
    оператор при вызове <code>update</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">update</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'options-&gt;key'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'value'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="array-object-and-collection-casting"><a href="#array-object-and-collection-casting">Приведение объектов массива
        и коллекций</a></h4>
<p>Хотя стандартного <code>array</code> приведения достаточно для многих приложений, у него есть некоторые недостатки.
    Поскольку <code>array</code> приведение возвращает примитивный тип, напрямую изменить смещение массива невозможно.
    Например, следующий код вызовет ошибку PHP:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">options</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'key'</span><span
                class="token punctuation">]</span> <span class="token operator">=</span> <span class="token variable">$value</span><span
                class="token punctuation">;</span></code></pre>
<p>Чтобы решить эту проблему, Laravel предлагает <code>AsArrayObject</code> приведение вашего атрибута JSON к классу <a
            href="https://www.php.net/manual/en/class.arrayobject.php">ArrayObject</a>. Эта функция реализуется с
    помощью Laravel в <a href="eloquent-mutators#custom-casts">пользовательских литой</a> реализации, что позволяет
    Laravel разумно кэш и трансформировать мутантный объект таким образом, что отдельные смещения могут быть изменены
    без запуска ошибки PHP. Чтобы использовать <code>AsArrayObject</code> приведение, просто назначьте его атрибуту:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                    class="token punctuation">\</span>Eloquent<span class="token punctuation">\</span>Casts<span
                    class="token punctuation">\</span>AsArrayObject</span><span class="token punctuation">;</span>

<span class="token comment">/**
 * The attributes that should be cast.
 *
 * @var array
 */</span>
<span class="token keyword">protected</span> <span class="token variable">$casts</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'options'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> AsArrayObject<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">;</span></code></pre>
<p>Точно так же Laravel предлагает <code>AsCollection</code> приведение, которое приводит ваш атрибут JSON к экземпляру
    Laravel <a href="collections">Collection</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                    class="token punctuation">\</span>Eloquent<span class="token punctuation">\</span>Casts<span
                    class="token punctuation">\</span>AsCollection</span><span class="token punctuation">;</span>

<span class="token comment">/**
 * The attributes that should be cast.
 *
 * @var array
 */</span>
<span class="token keyword">protected</span> <span class="token variable">$casts</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'options'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> AsCollection<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="date-casting"><a href="#date-casting">Дата кастинг</a></h3>
<p>По умолчанию Eloquent будет кастовало <code>created_at</code> и <code>updated_at</code> столбцы экземпляров <a
            href="https://github.com/briannesbitt/Carbon">углерода</a>, который расширяет PHP <code>DateTime</code>
    класс и обеспечивает ассортимент полезных методов. Вы можете привести дополнительные атрибуты даты, определив
    дополнительные преобразования даты в <code>$cast</code> массиве свойств вашей модели. Обычно даты следует приводить
    с помощью <code>datetime</code> приведения.</p>
<p>При определении <code>date</code> или <code>datetime</code> приведении вы также можете указать формат даты. Этот
    формат будет использоваться при <a href="eloquent-serialization">сериализации модели в массив или JSON</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * The attributes that should be cast.
 *
 * @var array
 */</span>
<span class="token keyword">protected</span> <span class="token variable">$casts</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'created_at'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'datetime:Y-m-d'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">;</span></code></pre>
<p>Когда столбец приводится как дата, вы можете установить его значение в виде отметки времени UNIX, строки даты (
    <code>Y-m-d</code> ), строки даты и времени или экземпляра <code>DateTime</code> / <code>Carbon</code>. Значение
    даты будет правильно преобразовано и сохранено в вашей базе данных:</p>
<p>Вы можете настроить формат сериализации по умолчанию для всех дат вашей модели, определив <code>serializeDate</code>
    метод в вашей модели. Этот метод не влияет на форматирование дат для хранения в базе данных:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Prepare a date for array / JSON serialization.
 *
 * @param  \DateTimeInterface  $date
 * @return string
 */</span>
<span class="token keyword">protected</span> <span class="token keyword">function</span> <span class="token function">serializeDate</span><span
                class="token punctuation">(</span>DateTimeInterface <span class="token variable">$date</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$date</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">format</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Y-m-d'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Чтобы указать формат, который следует использовать при фактическом хранении дат модели в вашей базе данных, вы должны
    определить <code>$dateFormat</code> свойство в своей модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * The storage format of the model's date columns.
 *
 * @var string
 */</span>
<span class="token keyword">protected</span> <span class="token variable">$dateFormat</span> <span
                class="token operator">=</span> <span class="token single-quoted-string string">'U'</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="query-time-casting"><a href="#query-time-casting">Приведение во время запроса</a></h3>
<p>Иногда может потребоваться применить приведение типов при выполнении запроса, например, при выборе необработанного
    значения из таблицы. Например, рассмотрим следующий запрос:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Post</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                class="token punctuation">;</span>

<span class="token variable">$users</span> <span class="token operator">=</span> User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">select</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'users.*'</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'last_posted_at'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> Post<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">selectRaw</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'MAX(created_at)'</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">whereColumn</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'user_id'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'users.id'</span><span class="token punctuation">)</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p><code>last_posted_at</code> Атрибут по результатам этого запроса будет простой строкой. Было бы замечательно, если бы
    мы могли применить <code>datetime</code> приведение к этому атрибуту при выполнении запроса. К счастью, мы можем
    добиться этого с помощью <code>withCasts</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">select</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'users.*'</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'last_posted_at'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> Post<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">selectRaw</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'MAX(created_at)'</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">whereColumn</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'user_id'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'users.id'</span><span class="token punctuation">)</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">withCasts</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'last_posted_at'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'datetime'</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="custom-casts"><a href="#custom-casts">Пользовательские приведения</a></h2>
<p>Laravel имеет множество встроенных полезных типов приведения; однако иногда вам может потребоваться определить свои
    собственные типы приведения. Вы можете добиться этого, определив класс, реализующий <code>CastsAttributes</code>
    интерфейс.</p>
<p>Классы, которые реализуют этот интерфейс, необходимо определить <code>get</code> и <code>set</code> метод.
    <code>get</code> Метод отвечает за превращение исходного значения из базы данных в значение литой, в то время как
    <code>set</code> метод должен преобразовать значение литой в сырьевое значение, которое может быть сохранено в базе
    данных. В качестве примера мы повторно реализуем встроенный <code>json</code> тип приведения как настраиваемый тип
    приведения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Casts</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Database<span class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>CastsAttributes</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">Json</span> <span class="token keyword">implements</span> <span
                    class="token class-name">CastsAttributes</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Cast the given value.
     *
     * @param  \Illuminate\Database\Eloquent\Model  $model
     * @param  string  $key
     * @param  mixed  $value
     * @param  array  $attributes
     * @return array
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span
                    class="token function">get</span><span class="token punctuation">(</span><span
                    class="token variable">$model</span><span class="token punctuation">,</span> <span
                    class="token variable">$key</span><span class="token punctuation">,</span> <span
                    class="token variable">$value</span><span class="token punctuation">,</span> <span
                    class="token variable">$attributes</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token function">json_decode</span><span
                    class="token punctuation">(</span><span class="token variable">$value</span><span
                    class="token punctuation">,</span> <span class="token boolean constant">true</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
     * Prepare the given value for storage.
     *
     * @param  \Illuminate\Database\Eloquent\Model  $model
     * @param  string  $key
     * @param  array  $value
     * @param  array  $attributes
     * @return string
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span
                    class="token function">set</span><span class="token punctuation">(</span><span
                    class="token variable">$model</span><span class="token punctuation">,</span> <span
                    class="token variable">$key</span><span class="token punctuation">,</span> <span
                    class="token variable">$value</span><span class="token punctuation">,</span> <span
                    class="token variable">$attributes</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token function">json_encode</span><span
                    class="token punctuation">(</span><span class="token variable">$value</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>После того, как вы определили собственный тип приведения, вы можете присоединить его к атрибуту модели, используя его
    имя класса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Casts<span
                        class="token punctuation">\</span>Json</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Model</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">User</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * The attributes that should be cast.
     *
     * @var array
     */</span>
    <span class="token keyword">protected</span> <span class="token variable">$casts</span> <span
                    class="token operator">=</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'options'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> Json<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h3 id="value-object-casting"><a href="#value-object-casting">Приведение объекта значения</a></h3>
<p>Вы не ограничены приведением значений к примитивным типам. Вы также можете приводить значения к объектам. Определение
    кастомных приведений, которые приводят значения к объектам, очень похоже на приведение к примитивным типам; однако
    <code>set</code> метод должен возвращать массив пар ключ / значение, который будет использоваться для установки
    необработанных сохраняемых значений в модели.</p>
<p>В качестве примера мы определим настраиваемый класс приведения, который преобразует несколько значений модели в один
    <code>Address</code> объект значения. Предположим, что <code>Address</code> значение имеет два общедоступных
    свойства: <code>lineOne</code> и <code>lineTwo</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Casts</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span
                        class="token punctuation">\</span>Address</span> <span class="token keyword">as</span> AddressModel<span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Database<span class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>CastsAttributes</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">InvalidArgumentException</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">Address</span> <span class="token keyword">implements</span> <span
                    class="token class-name">CastsAttributes</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Cast the given value.
     *
     * @param  \Illuminate\Database\Eloquent\Model  $model
     * @param  string  $key
     * @param  mixed  $value
     * @param  array  $attributes
     * @return \App\Models\Address
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span
                    class="token function">get</span><span class="token punctuation">(</span><span
                    class="token variable">$model</span><span class="token punctuation">,</span> <span
                    class="token variable">$key</span><span class="token punctuation">,</span> <span
                    class="token variable">$value</span><span class="token punctuation">,</span> <span
                    class="token variable">$attributes</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token keyword">new</span> <span class="token class-name">AddressModel</span><span
                    class="token punctuation">(</span>
            <span class="token variable">$attributes</span><span class="token punctuation">[</span><span
                    class="token single-quoted-string string">'address_line_one'</span><span
                    class="token punctuation">]</span><span class="token punctuation">,</span>
            <span class="token variable">$attributes</span><span class="token punctuation">[</span><span
                    class="token single-quoted-string string">'address_line_two'</span><span
                    class="token punctuation">]</span>
        <span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
     * Prepare the given value for storage.
     *
     * @param  \Illuminate\Database\Eloquent\Model  $model
     * @param  string  $key
     * @param  \App\Models\Address  $value
     * @param  array  $attributes
     * @return array
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span
                    class="token function">set</span><span class="token punctuation">(</span><span
                    class="token variable">$model</span><span class="token punctuation">,</span> <span
                    class="token variable">$key</span><span class="token punctuation">,</span> <span
                    class="token variable">$value</span><span class="token punctuation">,</span> <span
                    class="token variable">$attributes</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">if</span> <span class="token punctuation">(</span><span
                    class="token operator">!</span> <span class="token variable">$value</span> <span
                    class="token keyword">instanceof</span> <span class="token class-name">AddressModel</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">throw</span> <span class="token keyword">new</span> <span class="token class-name">InvalidArgumentException</span><span
                    class="token punctuation">(</span><span class="token single-quoted-string string">'The given value is not an Address instance.'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span>

        <span class="token keyword">return</span> <span class="token punctuation">[</span>
            <span class="token single-quoted-string string">'address_line_one'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token variable">$value</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">lineOne</span><span
                    class="token punctuation">,</span>
            <span class="token single-quoted-string string">'address_line_two'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token variable">$value</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">lineTwo</span><span
                    class="token punctuation">,</span>
        <span class="token punctuation">]</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>При приведении к объектам-значениям любые изменения, внесенные в объект-значение, будут автоматически
    синхронизированы с моделью перед сохранением модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

<span class="token variable">$user</span> <span class="token operator">=</span> User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">address</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">lineOne</span> <span
                class="token operator">=</span> <span
                class="token single-quoted-string string">'Updated Address Value'</span><span class="token punctuation">;</span>

<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">save</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Если вы планируете сериализации ваши моделей Красноречивой, содержащие объекты значений для JSON или
            массивов, вы должны реализовать <code>Illuminate\Contracts\Support\Arrayable</code> и
            <code>JsonSerializable</code> интерфейсы объекта значения.</p></p></div>
</blockquote>
<p></p>
<h3 id="array-json-serialization"><a href="#array-json-serialization">Сериализация массивов / JSON</a></h3>
<p>Когда модель Eloquent преобразуется в массив или JSON, используя <code>toArray</code> и <code>toJson</code> методы,
    ваши объекты значений пользовательских литые обычно будет сериализовать, а до тех пор, как они реализуют <code>Illuminate\Contracts\Support\Arrayable</code>
    и <code>JsonSerializable</code> интерфейсы. Однако при использовании объектов значений, предоставляемых сторонними
    библиотеками, у вас может не быть возможности добавить эти интерфейсы к объекту.</p>
<p>Поэтому вы можете указать, что ваш собственный класс приведения будет отвечать за сериализацию объекта значения. Для
    этого ваше кастомное приведение класса должно реализовывать <code>Illuminate\Contracts\Database\Eloquent\SerializesCastableAttributes</code>
    интерфейс. В этом интерфейсе указано, что ваш класс должен содержать <code>serialize</code> метод, который должен
    возвращать сериализованную форму вашего объекта значения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
* Get the serialized representation of the value.
*
* @param  \Illuminate\Database\Eloquent\Model  $model
* @param  string  $key
* @param  mixed  $value
* @param  array  $attributes
* @return mixed
*/</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">serialize</span><span
                class="token punctuation">(</span><span class="token variable">$model</span><span
                class="token punctuation">,</span> string <span class="token variable">$key</span><span
                class="token punctuation">,</span> <span class="token variable">$value</span><span
                class="token punctuation">,</span> <span class="token keyword">array</span> <span
                class="token variable">$attributes</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">(</span>string<span class="token punctuation">)</span> <span
                class="token variable">$value</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="inbound-casting"><a href="#inbound-casting">Входящий кастинг</a></h3>
<p>Иногда вам может потребоваться написать настраиваемое приведение, которое преобразует только значения, заданные в
    модели, и не выполняет никаких операций, когда атрибуты извлекаются из модели. Классическим примером приведения типа
    "только входящее" является "хеширование". Пользовательские преобразования только для входящих событий должны
    реализовывать <code>CastsInboundAttributes</code> интерфейс, для которого требуется только определение
    <code>set</code> метода.</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Casts</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Database<span class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>CastsInboundAttributes</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">Hash</span> <span class="token keyword">implements</span> <span
                    class="token class-name">CastsInboundAttributes</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * The hashing algorithm.
     *
     * @var string
     */</span>
    <span class="token keyword">protected</span> <span class="token variable">$algorithm</span><span
                    class="token punctuation">;</span>

    <span class="token comment">/**
     * Create a new cast class instance.
     *
     * @param  string|null  $algorithm
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">__construct</span><span
                    class="token punctuation">(</span><span class="token variable">$algorithm</span> <span
                    class="token operator">=</span> <span class="token constant">null</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token property">algorithm</span> <span
                    class="token operator">=</span> <span class="token variable">$algorithm</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
     * Prepare the given value for storage.
     *
     * @param  \Illuminate\Database\Eloquent\Model  $model
     * @param  string  $key
     * @param  array  $value
     * @param  array  $attributes
     * @return string
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span
                    class="token function">set</span><span class="token punctuation">(</span><span
                    class="token variable">$model</span><span class="token punctuation">,</span> <span
                    class="token variable">$key</span><span class="token punctuation">,</span> <span
                    class="token variable">$value</span><span class="token punctuation">,</span> <span
                    class="token variable">$attributes</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token function">is_null</span><span
                    class="token punctuation">(</span><span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">algorithm</span><span
                    class="token punctuation">)</span>
        <span class="token operator">?</span> <span class="token function">bcrypt</span><span class="token punctuation">(</span><span
                    class="token variable">$value</span><span class="token punctuation">)</span>
        <span class="token punctuation">:</span> <span class="token function">hash</span><span
                    class="token punctuation">(</span><span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">algorithm</span><span
                    class="token punctuation">,</span> <span class="token variable">$value</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h3 id="cast-parameters"><a href="#cast-parameters">Параметры трансляции</a></h3>
<p>При присоединении пользовательского приведения к модели параметры приведения можно указать, отделив их от имени
    класса с помощью <code>:</code> символа и нескольких параметров, разделенных запятыми. Параметры будут переданы в
    конструктор класса приведения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * The attributes that should be cast.
 *
 * @var array
 */</span>
<span class="token keyword">protected</span> <span class="token variable">$casts</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'secret'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> Hash<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">.</span><span class="token single-quoted-string string">':sha256'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="castables"><a href="#castables">Отливки</a></h3>
<p>Вы можете разрешить объектам значений вашего приложения определять свои собственные классы приведения. Вместо того,
    чтобы прикреплять пользовательский класс приведения к вашей модели, вы также можете присоединить класс объекта
    значения, который реализует <code>Illuminate\Contracts\Database\Eloquent\Castable</code> интерфейс:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Address</span><span class="token punctuation">;</span>

<span class="token keyword">protected</span> <span class="token variable">$casts</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'address'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> Address<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">;</span></code></pre>
<p>Объекты, реализующие <code>Castable</code> интерфейс, должны определять <code>castUsing</code> метод, который
    возвращает имя класса настраиваемого класса caster, который отвечает за приведение к <code>Castable</code> классу и
    из него:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Database<span class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Castable</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Casts<span
                        class="token punctuation">\</span>Address</span> <span class="token keyword">as</span> AddressCast<span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">Address</span> <span class="token keyword">implements</span> <span
                    class="token class-name">Castable</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Get the name of the caster class to use when casting from / to this cast target.
     *
     * @param  array  $arguments
     * @return string
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">static</span> <span
                    class="token keyword">function</span> <span class="token function">castUsing</span><span
                    class="token punctuation">(</span><span class="token keyword">array</span> <span
                    class="token variable">$arguments</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> AddressCast<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>При использовании <code>Castable</code> классов вы все равно можете указывать аргументы в <code>$casts</code>
    определении. Аргументы будут переданы <code>castUsing</code> методу:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Address</span><span class="token punctuation">;</span>

<span class="token keyword">protected</span> <span class="token variable">$casts</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'address'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> Address<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">.</span><span
                class="token single-quoted-string string">':argument'</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="anonymous-cast-classes"><a href="#anonymous-cast-classes">Castables и анонимные классы актеров</a></h4>
<p>Комбинируя «приведенные объекты» с <a href="https://www.php.net/manual/en/language.oop5.anonymous.php">анонимными
        классами</a> PHP, вы можете определить объект значения и его логику приведения как один объект, допускающий
    приведение. Для этого верните анонимный класс из <code>castUsing</code> метода вашего объекта значения. Анонимный
    класс должен реализовывать <code>CastsAttributes</code> интерфейс:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span class="token punctuation">\</span>Database<span class="token punctuation">\</span>Eloquent<span class="token punctuation">\</span>Castable</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span class="token punctuation">\</span>Database<span class="token punctuation">\</span>Eloquent<span class="token punctuation">\</span>CastsAttributes</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">Address</span> <span class="token keyword">implements</span> <span class="token class-name">Castable</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// ...</span>

    <span class="token comment">/**
     * Get the caster class to use when casting from / to this cast target.
     *
     * @param  array  $arguments
     * @return object|string
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">static</span> <span class="token keyword">function</span> <span class="token function">castUsing</span><span class="token punctuation">(</span><span class="token keyword">array</span> <span class="token variable">$arguments</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token keyword">new</span> <span class="token class-name">class</span> <span class="token keyword">implements</span> <span class="token class-name">CastsAttributes</span>
        <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">get</span><span class="token punctuation">(</span><span class="token variable">$model</span><span class="token punctuation">,</span> <span class="token variable">$key</span><span class="token punctuation">,</span> <span class="token variable">$value</span><span class="token punctuation">,</span> <span class="token variable">$attributes</span><span class="token punctuation">)</span>
            <span class="token punctuation">{literal}{{/literal}</span>
                <span class="token keyword">return</span> <span class="token keyword">new</span> <span class="token class-name">Address</span><span class="token punctuation">(</span>
                    <span class="token variable">$attributes</span><span class="token punctuation">[</span><span class="token single-quoted-string string">'address_line_one'</span><span class="token punctuation">]</span><span class="token punctuation">,</span>
                    <span class="token variable">$attributes</span><span class="token punctuation">[</span><span class="token single-quoted-string string">'address_line_two'</span><span class="token punctuation">]</span>
                <span class="token punctuation">)</span><span class="token punctuation">;</span>
            <span class="token punctuation">}</span>

            <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">set</span><span class="token punctuation">(</span><span class="token variable">$model</span><span class="token punctuation">,</span> <span class="token variable">$key</span><span class="token punctuation">,</span> <span class="token variable">$value</span><span class="token punctuation">,</span> <span class="token variable">$attributes</span><span class="token punctuation">)</span>
            <span class="token punctuation">{literal}{{/literal}</span>
                <span class="token keyword">return</span> <span class="token punctuation">[</span>
                    <span class="token single-quoted-string string">'address_line_one'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token variable">$value</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">lineOne</span><span class="token punctuation">,</span>
                    <span class="token single-quoted-string string">'address_line_two'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token variable">$value</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">lineTwo</span><span class="token punctuation">,</span>
                <span class="token punctuation">]</span><span class="token punctuation">;</span>
            <span class="token punctuation">}</span>
        <span class="token punctuation">}</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
