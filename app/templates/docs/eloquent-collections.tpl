<h1>Eloquent: коллекции <sup>Collections</sup></h1>
<ul>
    <li><a href="eloquent-collections#introduction">Вступление</a></li>
    <li><a href="eloquent-collections#available-methods">Доступные методы</a></li>
    <li><a href="eloquent-collections#custom-collections">Собственные коллекции</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Все методы Eloquent, которые возвращают более одного результата модели, будут возвращать экземпляры <code>Illuminate\Database\Eloquent\Collection</code>
    класса, включая результаты, полученные с помощью <code>get</code> метода или доступные через отношения. Объект
    коллекции Eloquent расширяет <a href="collections">базовую коллекцию</a> Laravel, поэтому он естественным образом
    наследует десятки методов, используемых для плавной работы с базовым массивом моделей Eloquent. Обязательно
    ознакомьтесь с документацией по коллекции Laravel, чтобы узнать все об этих полезных методах!</p>
<p>Все коллекции также служат итераторами, что позволяет вам перебирать их, как если бы они были простыми массивами
    PHP:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

<span class="token variable">$users</span> <span class="token operator">=</span> User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'active'</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token keyword">foreach</span> <span class="token punctuation">(</span><span
                class="token variable">$users</span> <span class="token keyword">as</span> <span class="token variable">$user</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">echo</span> <span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">name</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Однако, как упоминалось ранее, коллекции намного мощнее массивов и предоставляют множество операций сопоставления /
    сокращения, которые могут быть связаны с помощью интуитивно понятного интерфейса. Например, мы можем удалить все
    неактивные модели, а затем собрать имя для каждого оставшегося пользователя:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$names</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">reject</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">active</span> <span
                class="token operator">===</span> <span class="token boolean constant">false</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">map</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">name</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="eloquent-collection-conversion"><a href="#eloquent-collection-conversion">Красноречивое преобразование
        коллекции</a></h4>
<p>В то время как большинство методов сбора Красноречивых возвращают новый экземпляр из коллекции красноречива, тем
    <code>collapse</code>, <code>flatten</code>, <code>flip</code>, <code>keys</code>, <code>pluck</code>, и
    <code>zip</code> методы возвращают <a href="collections">базовый сбор</a> экземпляр. Точно так же, если
    <code>map</code> операция возвращает коллекцию, не содержащую никаких моделей Eloquent, она будет преобразована в
    базовый экземпляр коллекции.</p>
<p></p>
<h2 id="available-methods"><a href="#available-methods">Доступные методы</a></h2>
<p>Все коллекции Eloquent расширяют базовый объект <a href="collections#available-methods">коллекции Laravel</a> ;
    поэтому они наследуют все мощные методы, предоставляемые классом базовой коллекции.</p>
<p>Кроме того, <code>Illuminate\Database\Eloquent\Collection</code> класс предоставляет расширенный набор методов,
    помогающих управлять коллекциями моделей. Большинство методов возвращают <code>Illuminate\Database\Eloquent\Collection</code>
    экземпляры; однако некоторые методы, например <code>modelKeys</code>, возвращают
    <code>Illuminate\Support\Collection</code> экземпляр.</p>
<style>
    #collection-method-list > p {
        column-count: 1;
        -moz-column-count: 1;
        -webkit-column-count: 1;
        column-gap: 2em;
        -moz-column-gap: 2em;
        -webkit-column-gap: 2em;
    }

    #collection-method-list a {
        display: block;
    }
</style>
<div id="collection-method-list">
    <p><a href="#method-contains">contains</a>
        <a href="#method-diff">diff</a>
        <a href="#method-except">except</a>
        <a href="#method-find">find</a>
        <a href="#method-fresh">fresh</a>
        <a href="#method-intersect">intersect</a>
        <a href="#method-load">load</a>
        <a href="#method-loadMissing">loadMissing</a>
        <a href="#method-modelKeys">modelKeys</a>
        <a href="#method-makeVisible">makeVisible</a>
        <a href="#method-makeHidden">makeHidden</a>
        <a href="#method-only">only</a>
        <a href="#method-toquery">toQuery</a>
        <a href="#method-unique">unique</a></p>
</div>
<p></p>
<h4 id="method-contains"><a href="#method-contains"><code>contains($key, $operator = null, $value = null)</code></a>
</h4>
<p><code>contains</code> Метод может быть использован, чтобы определить, является ли данный экземпляр модели содержится
    в коллекции. Этот метод принимает первичный ключ или экземпляр модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">contains</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$users</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">contains</span><span
                class="token punctuation">(</span>User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-diff"><a href="#method-diff"><code>diff($items)</code></a></h4>
<p><code>diff</code> Метод возвращает все модели, которые не присутствуют в данной коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

<span class="token variable">$users</span> <span class="token operator">=</span> <span
                class="token variable">$users</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">diff</span><span class="token punctuation">(</span>User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">whereIn</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'id'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-except"><a href="#method-except"><code>except($keys)</code></a></h4>
<p><code>except</code> Метод возвращает все модели, которые не имеют данных первичных ключей:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token variable">$users</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">except</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="collection-method" class="first-collection-method"><a href="#collection-method"><code>find($key)</code></a></h4>
<p><code>find</code> Метод возвращает модель, которая имеет первичный ключ, соответствующий указанный ключ. Если <code>$key</code>
    это экземпляр модели, <code>find</code> попытается вернуть модель, соответствующую первичному ключу. Если
    <code>$key</code> это массив ключей, <code>find</code> вернет все модели, у которых есть первичный ключ в данном
    массиве:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$user</span> <span class="token operator">=</span> <span
                class="token variable">$users</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">find</span><span class="token punctuation">(</span><span
                class="token number">1</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-fresh"><a href="#method-fresh"><code>fresh($with = [])</code></a></h4>
<p><code>fresh</code> Метод возвращает свежий экземпляр каждой модели в коллекции из базы данных. Кроме того, будут
    загружены любые указанные отношения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token variable">$users</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">fresh</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$users</span> <span class="token operator">=</span> <span
                class="token variable">$users</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">fresh</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'comments'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-intersect"><a href="#method-intersect"><code>intersect($items)</code></a></h4>
<p><code>intersect</code> Метод возвращает все модели, которые также присутствуют в данной коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

<span class="token variable">$users</span> <span class="token operator">=</span> <span
                class="token variable">$users</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">intersect</span><span class="token punctuation">(</span>User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">whereIn</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'id'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-load"><a href="#method-load"><code>load($relations)</code></a></h4>
<p>В <code>load</code> методе рвется загружает данные отношения для всех моделей в коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">load</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'comments'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'posts'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$users</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">load</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'comments.author'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-loadMissing"><a href="#method-loadMissing"><code>loadMissing($relations)</code></a></h4>
<p>В <code>loadMissing</code> методе рвется загружает данные отношения для всех моделей в коллекции, если еще не
    загружены отношения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">loadMissing</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'comments'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'posts'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$users</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">loadMissing</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'comments.author'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-modelKeys"><a href="#method-modelKeys"><code>modelKeys()</code></a></h4>
<p><code>modelKeys</code> Метод возвращает первичные ключи для всех моделей в коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">modelKeys</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [1, 2, 3, 4, 5]</span></code></pre>
<p></p>
<h4 id="method-makeVisible"><a href="#method-makeVisible"><code>makeVisible($attributes)</code></a></h4>
<p>В <code>makeVisible</code> метод <a href="eloquent-serialization#hiding-attributes-from-json">атрибутов видимой
        марки</a>, которые, как правило, «скрытый» на каждой модели в коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token variable">$users</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">makeVisible</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'address'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'phone_number'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-makeHidden"><a href="#method-makeHidden"><code>makeHidden($attributes)</code></a></h4>
<p>В <code>makeHidden</code> метод <a href="eloquent-serialization#hiding-attributes-from-json">скрывает атрибуты</a>,
    которые обычно «видны» на каждой модели в коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token variable">$users</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">makeHidden</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'address'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'phone_number'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-only"><a href="#method-only"><code>only($keys)</code></a></h4>
<p><code>only</code> Метод возвращает все модели, которые данные первичных ключей:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token variable">$users</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">only</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token number">1</span><span
                class="token punctuation">,</span> <span class="token number">2</span><span
                class="token punctuation">,</span> <span class="token number">3</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-toquery"><a href="#method-toquery"><code>toQuery()</code></a></h4>
<p><code>toQuery</code> Метод возвращает конструктор запросов экземпляр Красноречивый, содержащий <code>whereIn</code>
    ограничение на первичных ключей от модели коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

<span class="token variable">$users</span> <span class="token operator">=</span> User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'status'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'VIP'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$users</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">toQuery</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">update</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'status'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Administrator'</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-unique"><a href="#method-unique"><code>unique($key = null, $strict = false)</code></a></h4>
<p><code>unique</code> Метод возвращает все уникальные модели в коллекции. Все модели того же типа с тем же первичным
    ключом, что и другая модель в коллекции, удаляются:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token variable">$users</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">unique</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="custom-collections"><a href="#custom-collections">Собственные коллекции</a></h2>
<p>Если вы хотите использовать настраиваемый <code>Collection</code> объект при взаимодействии с данной моделью, вы
    можете определить <code>newCollection</code> метод для своей модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Support<span class="token punctuation">\</span>UserCollection</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Model</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">User</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Create a new Eloquent Collection instance.
     *
     * @param  array  $models
     * @return \Illuminate\Database\Eloquent\Collection
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">newCollection</span><span
                    class="token punctuation">(</span><span class="token keyword">array</span> <span
                    class="token variable">$models</span> <span class="token operator">=</span> <span
                    class="token punctuation">[</span><span class="token punctuation">]</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token keyword">new</span> <span class="token class-name">UserCollection</span><span
                    class="token punctuation">(</span><span class="token variable">$models</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>После того, как вы определили <code>newCollection</code> метод, вы будете получать экземпляр своей пользовательской
    коллекции в любое время, когда Eloquent обычно возвращает <code>Illuminate\Database\Eloquent\Collection</code>
    экземпляр. Если вы хотите использовать настраиваемую коллекцию для каждой модели в вашем приложении, вы должны
    определить <code>newCollection</code> метод в классе базовой модели, который расширяется всеми моделями вашего
    приложения.</p>
