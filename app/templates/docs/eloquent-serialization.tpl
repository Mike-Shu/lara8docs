<h1>Eloquent: сериализация <sup>Serialization</sup></h1>
<ul>
    <li><a href="eloquent-serialization#introduction">Вступление</a></li>
    <li><a href="eloquent-serialization#serializing-models-and-collections">Сериализация моделей и коллекций</a>
        <ul>
            <li><a href="eloquent-serialization#serializing-to-arrays">Сериализация в массивы</a></li>
            <li><a href="eloquent-serialization#serializing-to-json">Сериализация в JSON</a></li>
        </ul>
    </li>
    <li><a href="eloquent-serialization#hiding-attributes-from-json">Скрытие атрибутов из JSON</a></li>
    <li><a href="eloquent-serialization#appending-values-to-json">Добавление значений в JSON</a></li>
    <li><a href="eloquent-serialization#date-serialization">Сериализация даты</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>При создании API-интерфейсов с использованием Laravel вам часто нужно преобразовывать свои модели и отношения в
    массивы или JSON. Eloquent включает удобные методы для выполнения этих преобразований, а также для управления тем,
    какие атрибуты включаются в сериализованное представление ваших моделей.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Чтобы узнать о еще более надежном способе обработки JSON-сериализации модели Eloquent и коллекции,
            ознакомьтесь с документацией по <a href="eloquent-resources">ресурсам Eloquent API</a>.</p></p></div>
</blockquote>
<p></p>
<h2 id="serializing-models-and-collections"><a href="#serializing-models-and-collections">Сериализация моделей и
        коллекций</a></h2>
<p></p>
<h3 id="serializing-to-arrays"><a href="#serializing-to-arrays">Сериализация в массивы</a></h3>
<p>Чтобы преобразовать модель и ее загруженные <a href="eloquent-relationships">отношения</a> в массив, вы должны
    использовать этот <code>toArray</code> метод. Этот метод является рекурсивным, поэтому все атрибуты и все отношения
    (включая отношения отношений) будут преобразованы в массивы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

<span class="token variable">$user</span> <span class="token operator">=</span> User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">with</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'roles'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">first</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token keyword">return</span> <span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">toArray</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p><code>attributesToArray</code> Метод может быть использован для преобразования атрибутов модели, чтобы массив, но не
    его отношения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">first</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token keyword">return</span> <span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">attributesToArray</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы также можете преобразовать целые <a href="eloquent-collections">коллекции</a> моделей в массивы, вызвав <code>toArray</code>
    метод экземпляра коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token keyword">return</span> <span class="token variable">$users</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">toArray</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="serializing-to-json"><a href="#serializing-to-json">Сериализация в JSON</a></h3>
<p>Чтобы преобразовать модель в JSON, следует использовать <code>toJson</code> метод. Мол <code>toArray</code>, <code>toJson</code>
    метод рекурсивный, поэтому все атрибуты и отношения будут преобразованы в JSON. Вы также можете указать любые
    параметры кодировки JSON, которые <a href="https://secure.php.net/manual/en/function.json-encode.php">поддерживаются
        PHP</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

<span class="token variable">$user</span> <span class="token operator">=</span> User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">return</span> <span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">toJson</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token keyword">return</span> <span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">toJson</span><span
                class="token punctuation">(</span><span class="token constant">JSON_PRETTY_PRINT</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>В качестве альтернативы вы можете преобразовать модель или коллекцию в строку, которая автоматически вызовет <code>toJson</code>
    метод модели или коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token punctuation">(</span>string<span class="token punctuation">)</span> User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Поскольку модели и коллекции преобразуются в JSON при преобразовании в строку, вы можете возвращать объекты Eloquent
    непосредственно из маршрутов или контроллеров вашего приложения. Laravel автоматически сериализует ваши модели и
    коллекции Eloquent в JSON, когда они возвращаются из маршрутов или контроллеров:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="relationships"><a href="#relationships">Отношения</a></h4>
<p>Когда модель Eloquent преобразуется в JSON, ее загруженные отношения автоматически включаются в качестве атрибутов в
    объект JSON. Кроме того, хотя методы отношения Eloquent определены с использованием имен методов «верблюжьего»,
    атрибут JSON отношения будет «змеиный».</p>
<p></p>
<h2 id="hiding-attributes-from-json"><a href="#hiding-attributes-from-json">Скрытие атрибутов из JSON</a></h2>
<p>Иногда вы можете захотеть ограничить атрибуты, такие как пароли, которые включены в массив вашей модели или
    представление JSON. Для этого добавьте <code>$hidden</code> свойство к вашей модели. Атрибуты, перечисленные в
    <code>$hidden</code> массиве свойств, не будут включены в сериализованное представление вашей модели:</p>
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
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */</span>
    <span class="token keyword">protected</span> <span class="token variable">$hidden</span> <span
                    class="token operator">=</span> <span class="token punctuation">[</span><span
                    class="token single-quoted-string string">'password'</span><span
                    class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Чтобы скрыть отношения, добавьте имя метода отношения к <code>$hidden</code> свойству модели Eloquent.
        </p></p></div>
</blockquote>
<p>В качестве альтернативы вы можете использовать <code>visible</code> свойство для определения «разрешенного списка»
    атрибутов, которые должны быть включены в массив вашей модели и представление JSON. Все атрибуты, которых нет в
    <code>$visible</code> массиве, будут скрыты при преобразовании модели в массив или JSON:</p>
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
     * The attributes that should be visible in arrays.
     *
     * @var array
     */</span>
    <span class="token keyword">protected</span> <span class="token variable">$visible</span> <span
                    class="token operator">=</span> <span class="token punctuation">[</span><span
                    class="token single-quoted-string string">'first_name'</span><span
                    class="token punctuation">,</span> <span
                    class="token single-quoted-string string">'last_name'</span><span class="token punctuation">]</span><span
                    class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h4 id="temporarily-modifying-attribute-visibility"><a href="#temporarily-modifying-attribute-visibility">Временное
        изменение видимости атрибута</a></h4>
<p>Если вы хотите сделать некоторые обычно скрытые атрибуты видимыми в данном экземпляре модели, вы можете использовать
    этот <code>makeVisible</code> метод. <code>makeVisible</code> Метод возвращает экземпляр модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token variable">$user</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">makeVisible</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'attribute'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">toArray</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Аналогичным образом, если вы хотите скрыть некоторые атрибуты, которые обычно видны, вы можете использовать этот
    <code>makeHidden</code> метод.</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token variable">$user</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">makeHidden</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'attribute'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">toArray</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="appending-values-to-json"><a href="#appending-values-to-json">Добавление значений в JSON</a></h2>
<p>Иногда при преобразовании моделей в массивы или JSON вы можете захотеть добавить атрибуты, для которых нет
    соответствующего столбца в вашей базе данных. Для этого сначала определите метод <a
            href="eloquent-mutators">доступа</a> для значения:</p>
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
     * Determine if the user is an administrator.
     *
     * @return bool
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">getIsAdminAttribute</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">attributes</span><span
                    class="token punctuation">[</span><span
                    class="token single-quoted-string string">'admin'</span><span
                    class="token punctuation">]</span> <span class="token operator">===</span> <span
                    class="token single-quoted-string string">'yes'</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>После создания средства доступа добавьте имя атрибута к <code>appends</code> свойству вашей модели. Обратите
    внимание, что на имена атрибутов обычно ссылаются с использованием их сериализованного представления "snake case",
    даже несмотря на то, что метод PHP средства доступа определен с использованием "camel case":</p>
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
     * The accessors to append to the model's array form.
     *
     * @var array
     */</span>
    <span class="token keyword">protected</span> <span class="token variable">$appends</span> <span
                    class="token operator">=</span> <span class="token punctuation">[</span><span
                    class="token single-quoted-string string">'is_admin'</span><span
                    class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
<p>После добавления атрибута в <code>appends</code> список он будет включен как в массив модели, так и в представления
    JSON. Атрибуты в <code>appends</code> массиве также будут учитывать настройки <code>visible</code> и
    <code>hidden</code>, настроенные для модели.</p>
<p></p>
<h4 id="appending-at-run-time"><a href="#appending-at-run-time">Добавление во время выполнения</a></h4>
<p>Во время выполнения вы можете указать экземпляру модели добавить дополнительные атрибуты с помощью
    <code>append</code> метода. Или вы можете использовать этот <code>setAppends</code> метод для переопределения всего
    массива добавленных свойств для данного экземпляра модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token variable">$user</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">append</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'is_admin'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">toArray</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token keyword">return</span> <span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">setAppends</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'is_admin'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">toArray</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="date-serialization"><a href="#date-serialization">Сериализация даты</a></h2>
<p></p>
<h4 id="customizing-the-default-date-format"><a href="#customizing-the-default-date-format">Настройка формата даты по
        умолчанию</a></h4>
<p>Вы можете настроить формат сериализации по умолчанию, переопределив <code>serializeDate</code> метод. Этот метод не
    влияет на форматирование дат для хранения в базе данных:</p>
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
<p></p>
<h4 id="customizing-the-date-format-per-attribute"><a href="#customizing-the-date-format-per-attribute">Настройка
        формата даты для каждого атрибута</a></h4>
<p>Вы можете настроить формат сериализации отдельных атрибутов даты красноречив, указав формат даты в модели <a
            href="eloquent-mutators#attribute-casting">декларациях актеров</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">protected</span> <span
                class="token variable">$casts</span> <span class="token operator">=</span> <span
                class="token punctuation">[</span>
    <span class="token single-quoted-string string">'birthday'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'date:Y-m-d'</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'joined_at'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'datetime:Y-m-d H:00'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">;</span></code></pre> 
