<h1>Коллекции</h1>
<ul>
    <li><a href="collections#introduction">Вступление</a>
        <ul>
            <li><a href="collections#creating-collections">Создание коллекций</a></li>
            <li><a href="collections#extending-collections">Расширение коллекций</a></li>
        </ul>
    </li>
    <li><a href="collections#available-methods">Доступные методы</a></li>
    <li><a href="collections#higher-order-messages">Сообщения высшего порядка</a></li>
    <li><a href="collections#lazy-collections">Ленивые коллекции</a>
        <ul>
            <li><a href="collections#lazy-collection-introduction">Вступление</a></li>
            <li><a href="collections#creating-lazy-collections">Создание ленивых коллекций</a></li>
            <li><a href="collections#the-enumerable-contract">Перечислимый договор</a></li>
            <li><a href="collections#lazy-collection-methods">Ленивые методы сбора</a></li>
        </ul>
    </li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p><code>Illuminate\Support\Collection</code> Класс обеспечивает свободно, удобную оболочку для работы с массивами
    данных. Например, посмотрите следующий код. Мы воспользуемся <code>collect</code> помощником, чтобы создать новый
    экземпляр коллекции из массива, запустить <code>strtoupper</code> функцию для каждого элемента, а затем удалить все
    пустые элементы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'taylor'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'abigail'</span><span class="token punctuation">,</span> <span
                class="token constant">null</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">map</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$name</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token function">strtoupper</span><span class="token punctuation">(</span><span class="token variable">$name</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">reject</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$name</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token keyword">empty</span><span class="token punctuation">(</span><span class="token variable">$name</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Как видите, <code>Collection</code> класс позволяет объединить свои методы в цепочку для выполнения плавного
    сопоставления и сокращения базового массива. Как правило, коллекции неизменяемы, то есть каждый
    <code>Collection</code> метод возвращает совершенно новый <code>Collection</code> экземпляр.</p>
<p></p>
<h3 id="creating-collections"><a href="#creating-collections">Создание коллекций</a></h3>
<p>Как упоминалось выше, <code>collect</code> помощник возвращает новый <code>Illuminate\Support\Collection</code>
    экземпляр для данного массива. Итак, создать коллекцию очень просто:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Результаты запросов <a href="eloquent">Eloquent</a> всегда возвращаются как <code>Collection</code>
            экземпляры.</p></p></div>
</blockquote>
<p></p>
<h3 id="extending-collections"><a href="#extending-collections">Расширение коллекций</a></h3>
<p>Коллекции являются «макросами», что позволяет добавлять в <code>Collection</code> класс дополнительные методы во
    время выполнения. Метод <code>Illuminate\Support\Collection</code> класса <code>macro</code> принимает закрытие,
    которое будет выполнено при вызове вашего макроса. Замыкание макроса может обращаться к другим методам коллекции
    через <code>$this</code>, как если бы это был реальный метод класса коллекции. Например, следующий код добавляет
    <code>toUpper</code> в <code>Collection</code> класс метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Collection</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

Collection<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">macro</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'toUpper'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">map</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token variable">$value</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> Str<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">upper</span><span class="token punctuation">(</span><span class="token variable">$value</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$collection</span> <span class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'first'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'second'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$upper</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">toUpper</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['FIRST', 'SECOND']</span></code></pre>
<p>Обычно макросы сбора следует объявлять в <code>boot</code> методе <a href="providers">поставщика услуг</a>.</p>
<p></p>
<h4 id="macro-arguments"><a href="#macro-arguments">Макро аргументы</a></h4>
<p>При необходимости вы можете определить макросы, которые принимают дополнительные аргументы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Collection</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Lang</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

Collection<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">macro</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'toLocale'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$locale</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">map</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token variable">$value</span><span class="token punctuation">)</span> <span class="token keyword">use</span> <span class="token punctuation">(</span><span class="token variable">$locale</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> Lang<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token variable">$value</span><span class="token punctuation">,</span> <span class="token punctuation">[</span><span class="token punctuation">]</span><span class="token punctuation">,</span> <span class="token variable">$locale</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$collection</span> <span class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'first'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'second'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$translated</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">toLocale</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'es'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="available-methods"><a href="#available-methods">Доступные методы</a></h2>
<p>Для большей части оставшейся документации по коллекции мы обсудим каждый метод, доступный в <code>Collection</code>
    классе. Помните, что все эти методы можно объединить в цепочку для беспрепятственного управления базовым массивом.
    Более того, почти каждый метод возвращает новый <code>Collection</code> экземпляр, что позволяет при необходимости
    сохранить исходную копию коллекции:</p>
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
    <p><a href="#method-all">all</a>
        <a href="#method-average">average</a>
        <a href="#method-avg">avg</a>
        <a href="#method-chunk">chunk</a>
        <a href="#method-chunkwhile">chunkWhile</a>
        <a href="#method-collapse">collapse</a>
        <a href="#method-collect">collect</a>
        <a href="#method-combine">combine</a>
        <a href="#method-concat">concat</a>
        <a href="#method-contains">contains</a>
        <a href="#method-containsstrict">containsStrict</a>
        <a href="#method-count">count</a>
        <a href="#method-countBy">countBy</a>
        <a href="#method-crossjoin">crossJoin</a>
        <a href="#method-dd">dd</a>
        <a href="#method-diff">diff</a>
        <a href="#method-diffassoc">diffAssoc</a>
        <a href="#method-diffkeys">diffKeys</a>
        <a href="#method-dump">dump</a>
        <a href="#method-duplicates">duplicates</a>
        <a href="#method-duplicatesstrict">duplicatesStrict</a>
        <a href="#method-each">each</a>
        <a href="#method-eachspread">eachSpread</a>
        <a href="#method-every">every</a>
        <a href="#method-except">except</a>
        <a href="#method-filter">filter</a>
        <a href="#method-first">first</a>
        <a href="#method-first-where">firstWhere</a>
        <a href="#method-flatmap">flatMap</a>
        <a href="#method-flatten">flatten</a>
        <a href="#method-flip">flip</a>
        <a href="#method-forget">forget</a>
        <a href="#method-forpage">forPage</a>
        <a href="#method-get">get</a>
        <a href="#method-groupby">groupBy</a>
        <a href="#method-has">has</a>
        <a href="#method-implode">implode</a>
        <a href="#method-intersect">intersect</a>
        <a href="#method-intersectbykeys">intersectByKeys</a>
        <a href="#method-isempty">isEmpty</a>
        <a href="#method-isnotempty">isNotEmpty</a>
        <a href="#method-join">join</a>
        <a href="#method-keyby">keyBy</a>
        <a href="#method-keys">keys</a>
        <a href="#method-last">last</a>
        <a href="#method-macro">macro</a>
        <a href="#method-make">make</a>
        <a href="#method-map">map</a>
        <a href="#method-mapinto">mapInto</a>
        <a href="#method-mapspread">mapSpread</a>
        <a href="#method-maptogroups">mapToGroups</a>
        <a href="#method-mapwithkeys">mapWithKeys</a>
        <a href="#method-max">max</a>
        <a href="#method-median">median</a>
        <a href="#method-merge">merge</a>
        <a href="#method-mergerecursive">mergeRecursive</a>
        <a href="#method-min">min</a>
        <a href="#method-mode">mode</a>
        <a href="#method-nth">nth</a>
        <a href="#method-only">only</a>
        <a href="#method-pad">pad</a>
        <a href="#method-partition">partition</a>
        <a href="#method-pipe">pipe</a>
        <a href="#method-pipeinto">pipeInto</a>
        <a href="#method-pluck">pluck</a>
        <a href="#method-pop">pop</a>
        <a href="#method-prepend">prepend</a>
        <a href="#method-pull">pull</a>
        <a href="#method-push">push</a>
        <a href="#method-put">put</a>
        <a href="#method-random">random</a>
        <a href="#method-reduce">reduce</a>
        <a href="#method-reject">reject</a>
        <a href="#method-replace">replace</a>
        <a href="#method-replacerecursive">replaceRecursive</a>
        <a href="#method-reverse">reverse</a>
        <a href="#method-search">search</a>
        <a href="#method-shift">shift</a>
        <a href="#method-shuffle">shuffle</a>
        <a href="#method-skip">skip</a>
        <a href="#method-skipuntil">skipUntil</a>
        <a href="#method-skipwhile">skipWhile</a>
        <a href="#method-slice">slice</a>
        <a href="#method-some">some</a>
        <a href="#method-sort">sort</a>
        <a href="#method-sortby">sortBy</a>
        <a href="#method-sortbydesc">sortByDesc</a>
        <a href="#method-sortdesc">sortDesc</a>
        <a href="#method-sortkeys">sortKeys</a>
        <a href="#method-sortkeysdesc">sortKeysDesc</a>
        <a href="#method-splice">splice</a>
        <a href="#method-split">split</a>
        <a href="#method-splitin">splitIn</a>
        <a href="#method-sum">sum</a>
        <a href="#method-take">take</a>
        <a href="#method-takeuntil">takeUntil</a>
        <a href="#method-takewhile">takeWhile</a>
        <a href="#method-tap">tap</a>
        <a href="#method-times">times</a>
        <a href="#method-toarray">toArray</a>
        <a href="#method-tojson">toJson</a>
        <a href="#method-transform">transform</a>
        <a href="#method-union">union</a>
        <a href="#method-unique">unique</a>
        <a href="#method-uniquestrict">uniqueStrict</a>
        <a href="#method-unless">unless</a>
        <a href="#method-unlessempty">unlessEmpty</a>
        <a href="#method-unlessnotempty">unlessNotEmpty</a>
        <a href="#method-unwrap">unwrap</a>
        <a href="#method-values">values</a>
        <a href="#method-when">when</a>
        <a href="#method-whenempty">whenEmpty</a>
        <a href="#method-whennotempty">whenNotEmpty</a>
        <a href="#method-where">where</a>
        <a href="#method-wherestrict">whereStrict</a>
        <a href="#method-wherebetween">whereBetween</a>
        <a href="#method-wherein">whereIn</a>
        <a href="#method-whereinstrict">whereInStrict</a>
        <a href="#method-whereinstanceof">whereInstanceOf</a>
        <a href="#method-wherenotbetween">whereNotBetween</a>
        <a href="#method-wherenotin">whereNotIn</a>
        <a href="#method-wherenotinstrict">whereNotInStrict</a>
        <a href="#method-wherenotnull">whereNotNull</a>
        <a href="#method-wherenull">whereNull</a>
        <a href="#method-wrap">wrap</a>
        <a href="#method-zip">zip</a></p>
</div>
<p></p>
<h2 id="method-listing"><a href="#method-listing">Список методов</a></h2>
<style>
    #collection-method code {
        font-size: 14px;
    }

    #collection-method:not(.first-collection-method) {
        margin-top: 50px;
    }
</style>
<p></p>
<h4 id="method-all" class="first-collection-method"><a href="#method-all"><code>all()</code></a></h4>
<p><code>all</code> Метод возвращает базовый массив, представленные коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [1, 2, 3]</span></code></pre>
<p></p>
<h4 id="method-average"><a href="#method-average"><code>average()</code></a></h4>
<p>Псевдоним <a href="collections#method-avg"><code>avg</code></a>метода.</p>
<p></p>
<h4 id="method-avg"><a href="#method-avg"><code>avg()</code></a></h4>
<p><code>avg</code> Метод возвращает <a href="https://en.wikipedia.org/wiki/Average">среднее значение</a> данного ключа:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$average</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'foo'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">10</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'foo'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">10</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'foo'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">20</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'foo'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">40</span><span class="token punctuation">]</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">avg</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'foo'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// 20</span>

<span class="token variable">$average</span> <span class="token operator">=</span> <span
                class="token function">collect</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token number">1</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">,</span> <span class="token number">2</span><span
                class="token punctuation">,</span> <span class="token number">4</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">avg</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 2</span></code></pre>
<p></p>
<h4 id="method-chunk"><a href="#method-chunk"><code>chunk()</code></a></h4>
<p><code>chunk</code> Метод разбивает коллекцию в нескольких меньших коллекции определенного размера:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">,</span> <span
                class="token number">5</span><span class="token punctuation">,</span> <span
                class="token number">6</span><span class="token punctuation">,</span> <span
                class="token number">7</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$chunks</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">chunk</span><span
                class="token punctuation">(</span><span class="token number">4</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$chunks</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// [[1, 2, 3, 4], [5, 6, 7]]</span></code></pre>
<p>Этот метод особенно полезен в <a href="views">представлениях</a> при работе с сеткой, такой как <a
            href="https://getbootstrap.com/docs/4.1/layout/grid/">Bootstrap</a>. Например, представьте, что у вас есть
    набор моделей <a href="eloquent">Eloquent,</a> которые вы хотите отобразить в сетке:</p>
<pre class=" language-php"><code class=" language-php">@<span class="token keyword">foreach</span> <span
                class="token punctuation">(</span><span class="token variable">$products</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">chunk</span><span
                class="token punctuation">(</span><span class="token number">3</span><span
                class="token punctuation">)</span> <span class="token keyword">as</span> <span class="token variable">$chunk</span><span
                class="token punctuation">)</span>
    <span class="token operator">&lt;</span>div <span class="token keyword">class</span><span
                class="token operator">=</span><span class="token double-quoted-string string">"row"</span><span
                class="token operator">&gt;</span>
        @<span class="token keyword">foreach</span> <span class="token punctuation">(</span><span
                class="token variable">$chunk</span> <span class="token keyword">as</span> <span class="token variable">$product</span><span
                class="token punctuation">)</span>
            <span class="token operator">&lt;</span>div <span class="token keyword">class</span><span
                class="token operator">=</span><span class="token double-quoted-string string">"col-xs-4"</span><span
                class="token operator">&gt;</span><span
                class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">{literal}{{/literal}</span> <span class="token variable">$product</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">name</span> <span class="token punctuation">}</span><span class="token punctuation">}</span><span
                class="token operator">&lt;</span><span class="token operator">/</span>div<span class="token operator">&gt;</span>
        @<span class="token keyword">endforeach</span>
    <span class="token operator">&lt;</span><span class="token operator">/</span>div<span
                class="token operator">&gt;</span>
@<span class="token keyword">endforeach</span></code></pre>
<p></p>
<h4 id="method-chunkWhile"><a href="#method-chunkWhile"><code>chunkWhile()</code></a></h4>
<p>Этот <code>chunkWhile</code> метод разбивает коллекцию на несколько меньших по размеру коллекций на основе оценки
    данного обратного вызова. <code>$chunk</code> Переменная передается закрытия может быть использована для проверки
    предыдущего элемента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token function">str_split</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'AABBCCCD'</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$chunks</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">chunkWhile</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$value</span><span
                class="token punctuation">,</span> <span class="token variable">$key</span><span
                class="token punctuation">,</span> <span class="token variable">$chunk</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$value</span> <span class="token operator">===</span> <span class="token variable">$chunk</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">last</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$chunks</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// [['A', 'A'], ['B', 'B'], ['C', 'C', 'C'], ['D']]</span></code></pre>
<p></p>
<h4 id="method-collapse"><a href="#method-collapse"><code>collapse()</code></a></h4>
<p><code>collapse</code> Метод разрушается коллекцию массивов в единую плоскую коллекцию:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token number">4</span><span class="token punctuation">,</span> <span
                class="token number">5</span><span class="token punctuation">,</span> <span
                class="token number">6</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token number">7</span><span class="token punctuation">,</span> <span
                class="token number">8</span><span class="token punctuation">,</span> <span
                class="token number">9</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collapsed</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">collapse</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$collapsed</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [1, 2, 3, 4, 5, 6, 7, 8, 9]</span></code></pre>
<p></p>
<h4 id="method-combine"><a href="#method-combine"><code>combine()</code></a></h4>
<p><code>combine</code> Метод сочетает значения коллекции, в качестве ключей, со значениями другого массива или
    коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'name'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'age'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$combined</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">combine</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'George'</span><span class="token punctuation">,</span> <span
                class="token number">29</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$combined</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['name' =&gt; 'George', 'age' =&gt; 29]</span></code></pre>
<p></p>
<h4 id="method-collect"><a href="#method-collect"><code>collect()</code></a></h4>
<p><code>collect</code> Метод возвращает новый <code>Collection</code> экземпляр с деталями в настоящее время в
    коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collectionA</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collectionB</span> <span class="token operator">=</span> <span class="token variable">$collectionA</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$collectionB</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [1, 2, 3]</span></code></pre>
<p>Этот <code>collect</code> метод в первую очередь полезен для преобразования <a href="collections#lazy-collections">ленивых
        коллекций</a> в стандартные <code>Collection</code> экземпляры:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$lazyCollection</span> <span
                class="token operator">=</span> LazyCollection<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">make</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">yield</span> <span class="token number">1</span><span class="token punctuation">;</span>
    <span class="token keyword">yield</span> <span class="token number">2</span><span class="token punctuation">;</span>
    <span class="token keyword">yield</span> <span class="token number">3</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$collection</span> <span class="token operator">=</span> <span class="token variable">$lazyCollection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token function">get_class</span><span class="token punctuation">(</span><span class="token variable">$collection</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 'Illuminate\Support\Collection'</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [1, 2, 3]</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Этот <code>collect</code> метод особенно полезен, когда у вас есть экземпляр <code>Enumerable</code> и вам
            нужен неленивый экземпляр коллекции. Поскольку <code>collect()</code> это часть <code>Enumerable</code>
            контракта, вы можете безопасно использовать его для получения <code>Collection</code> экземпляра.</p></p>
    </div>
</blockquote>
<p></p>
<h4 id="method-concat"><a href="#method-concat"><code>concat()</code></a></h4>
<p><code>concat</code> Метод добавляет данные <code>array</code> или коллекции значения на конец другой коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'John Doe'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$concatenated</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">concat</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'Jane Doe'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">concat</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Johnny Doe'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$concatenated</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['John Doe', 'Jane Doe', 'Johnny Doe']</span></code></pre>
<p></p>
<h4 id="method-contains"><a href="#method-contains"><code>contains()</code></a></h4>
<p>Вы также можете передать закрытие, чтобы <code>contains</code> определить, существует ли в коллекции элемент,
    соответствующий заданному тесту истинности:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">,</span> <span
                class="token number">5</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">contains</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$value</span><span
                class="token punctuation">,</span> <span class="token variable">$key</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$value</span> <span class="token operator">&gt;</span> <span class="token number">5</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// false</span></code></pre>
<p>В качестве альтернативы вы можете передать строку в <code>contains</code> метод, чтобы определить, содержит ли
    коллекция заданное значение элемента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Desk'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'price'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">100</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">contains</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Desk'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// true</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">contains</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'New York'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// false</span></code></pre>
<p>Вы также можете передать пару ключ / значение <code>contains</code> методу, который определит, существует ли данная
    пара в коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'product'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Desk'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">200</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'product'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Chair'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">100</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">contains</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'product'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Bookcase'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// false</span></code></pre>
<p>Этот <code>contains</code> метод использует "свободные" сравнения при проверке значений элементов, что означает, что
    строка с целым значением будет считаться равной целому числу того же значения. Используйте этот <a
            href="collections#method-containsstrict"><code>containsStrict</code></a>метод для фильтрации с
    использованием «строгих» сравнений.</p>
<p></p>
<h4 id="method-containsStrict"><a href="#method-containsStrict"><code>containsStrict()</code></a></h4>
<p>Этот метод имеет ту же сигнатуру, что и <a href="collections#method-contains"><code>contains</code></a>метод; однако
    все значения сравниваются с использованием «строгих» сравнений.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Поведение этого метода изменяется при использовании <a href="eloquent-collections#method-contains">Eloquent
                Collections</a>.</p></p></div>
</blockquote>
<p></p>
<h4 id="method-count"><a href="#method-count"><code>count()</code></a></h4>
<p><code>count</code> Метод возвращает общее количество элементов в коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">count</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// 4</span></code></pre>
<p></p>
<h4 id="method-countBy"><a href="#method-countBy"><code>countBy()</code></a></h4>
<p><code>countBy</code> Метод подсчитывает число вхождений значений в коллекции. По умолчанию метод подсчитывает
    вхождения каждого элемента, что позволяет подсчитать определенные «типы» элементов в коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$counted</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">countBy</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$counted</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [1 =&gt; 1, 2 =&gt; 3, 3 =&gt; 1]</span></code></pre>
<p>Вы передаете закрытие <code>countBy</code> методу для подсчета всех элементов по настраиваемому значению:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'alice@gmail.com'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'bob@yahoo.com'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'carlos@gmail.com'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$counted</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">countBy</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$email</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token function">substr</span><span class="token punctuation">(</span><span class="token function">strrchr</span><span class="token punctuation">(</span><span class="token variable">$email</span><span class="token punctuation">,</span> <span class="token double-quoted-string string">"@"</span><span class="token punctuation">)</span><span class="token punctuation">,</span> <span class="token number">1</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$counted</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['gmail.com' =&gt; 2, 'yahoo.com' =&gt; 1]</span></code></pre>
<p></p>
<h4 id="method-crossJoin"><a href="#method-crossJoin"><code>crossJoin()</code></a></h4>
<p><code>crossJoin</code> Крест метода соединяет ценность коллекции среди указанных массивов или коллекций, возвращая
    декартово произведение всех возможных перестановок:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$matrix</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">crossJoin</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'a'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'b'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$matrix</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">/*
    [
        [1, 'a'],
        [1, 'b'],
        [2, 'a'],
        [2, 'b'],
    ]
*/</span>

<span class="token variable">$collection</span> <span class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$matrix</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">crossJoin</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'a'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'b'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'I'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'II'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$matrix</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">/*
    [
        [1, 'a', 'I'],
        [1, 'a', 'II'],
        [1, 'b', 'I'],
        [1, 'b', 'II'],
        [2, 'a', 'I'],
        [2, 'a', 'II'],
        [2, 'b', 'I'],
        [2, 'b', 'II'],
    ]
*/</span></code></pre>
<p></p>
<h4 id="method-dd"><a href="#method-dd"><code>dd()</code></a></h4>
<p><code>dd</code> Метод отвалы пунктов и заканчивается выполнение этой коллекции, сценарий:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'John Doe'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Jane Doe'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">dd</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">/*
    Collection {
        #items: array:2 [
            0 =&gt; "John Doe"
            1 =&gt; "Jane Doe"
        ]
    }
*/</span></code></pre>
<p>Если вы не хотите прекращать выполнение сценария, используйте <a href="collections#method-dump"><code>dump</code></a>вместо
    этого метод.</p>
<p></p>
<h4 id="method-diff"><a href="#method-diff"><code>diff()</code></a></h4>
<p><code>diff</code> Метод сравнивает коллекцию с другой коллекцией или простого PHP <code>array</code> на основе его
    значения. Этот метод вернет значения в исходной коллекции, которых нет в данной коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">,</span> <span
                class="token number">5</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$diff</span> <span class="token operator">=</span> <span
                class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">diff</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">,</span> <span
                class="token number">6</span><span class="token punctuation">,</span> <span
                class="token number">8</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$diff</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [1, 3, 5]</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Поведение этого метода изменяется при использовании <a href="eloquent-collections#method-diff">Eloquent
                Collections</a>.</p></p></div>
</blockquote>
<p></p>
<h4 id="method-diffAssoc"><a href="#method-diffAssoc"><code>diffAssoc()</code></a></h4>
<p><code>diffAssoc</code> Метод сравнивает коллекцию с другой коллекции или простой PHP <code>array</code> на основе его
    ключей и значений. Этот метод вернет пары ключ / значение в исходной коллекции, которых нет в данной коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'color'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'orange'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'type'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'fruit'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'remain'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">6</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$diff</span> <span class="token operator">=</span> <span
                class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">diffAssoc</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'color'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'yellow'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'type'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'fruit'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'remain'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">3</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'used'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">6</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$diff</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['color' =&gt; 'orange', 'remain' =&gt; 6]</span></code></pre>
<p></p>
<h4 id="method-diffKeys"><a href="#method-diffKeys"><code>diffKeys()</code></a></h4>
<p><code>diffKeys</code> Метод сравнивает коллекцию с другой коллекцией или простого PHP <code>array</code> на основе
    его ключи. Этот метод вернет пары ключ / значение в исходной коллекции, которых нет в данной коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'one'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">10</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'two'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">20</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'three'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">30</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'four'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">40</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'five'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">50</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$diff</span> <span class="token operator">=</span> <span
                class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">diffKeys</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'two'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">2</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'four'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">4</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'six'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">6</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'eight'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">8</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$diff</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['one' =&gt; 10, 'three' =&gt; 30, 'five' =&gt; 50]</span></code></pre>
<p></p>
<h4 id="method-dump"><a href="#method-dump"><code>dump()</code></a></h4>
<p><code>dump</code> Метод свалки предметов в коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'John Doe'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Jane Doe'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">dump</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">/*
    Collection {
        #items: array:2 [
            0 =&gt; "John Doe"
            1 =&gt; "Jane Doe"
        ]
    }
*/</span></code></pre>
<p>Если вы хотите остановить выполнение сценария после сброса коллекции, используйте <a
            href="collections#method-dd"><code>dd</code></a>вместо этого метод.</p>
<p></p>
<h4 id="method-duplicates"><a href="#method-duplicates"><code>duplicates()</code></a></h4>
<p>В <code>duplicates</code> методе извлекает и возвращает дублируют значения из коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'a'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'b'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'a'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'c'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'b'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">duplicates</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [2 =&gt; 'a', 4 =&gt; 'b']</span></code></pre>
<p>Если коллекция содержит массивы или объекты, вы можете передать ключ атрибутов, которые вы хотите проверить на
    наличие повторяющихся значений:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$employees</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'email'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'abigail@example.com'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'position'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Developer'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'email'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'james@example.com'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'position'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Designer'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'email'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'victoria@example.com'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'position'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Developer'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span>

<span class="token variable">$employees</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">duplicates</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'position'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// [2 =&gt; 'Developer']</span></code></pre>
<p></p>
<h4 id="method-duplicatesStrict"><a href="#method-duplicatesStrict"><code>duplicatesStrict()</code></a></h4>
<p>Этот метод имеет ту же сигнатуру, что и <a href="collections#method-duplicates"><code>duplicates</code></a>метод;
    однако все значения сравниваются с использованием «строгих» сравнений.</p>
<p></p>
<h4 id="method-each"><a href="#method-each"><code>each()</code></a></h4>
<p><code>each</code> Метод перебирает элементы в коллекции и передает каждый элемент для закрытия:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">each</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$item</span><span
                class="token punctuation">,</span> <span class="token variable">$key</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Если вы хотите прекратить итерацию по элементам, вы можете вернуться <code>false</code> из закрытия:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">each</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$item</span><span
                class="token punctuation">,</span> <span class="token variable">$key</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token comment">/* condition */</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token boolean constant">false</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-eachSpread"><a href="#method-eachSpread"><code>eachSpread()</code></a></h4>
<p><code>eachSpread</code> Метод перебирает элементы в коллекции, передавая каждое вложенное значение элемента в данной
    функции обратного вызова:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'John Doe'</span><span
                class="token punctuation">,</span> <span class="token number">35</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span><span class="token single-quoted-string string">'Jane Doe'</span><span
                class="token punctuation">,</span> <span class="token number">33</span><span
                class="token punctuation">]</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">eachSpread</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$name</span><span
                class="token punctuation">,</span> <span class="token variable">$age</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы можете остановить итерацию по элементам, вернувшись <code>false</code> из обратного вызова:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">eachSpread</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$name</span><span
                class="token punctuation">,</span> <span class="token variable">$age</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token boolean constant">false</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-every"><a href="#method-every"><code>every()</code></a></h4>
<p>Этот <code>every</code> метод может использоваться для проверки того, что все элементы коллекции проходят заданный
    тест истинности:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">every</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$value</span><span
                class="token punctuation">,</span> <span class="token variable">$key</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$value</span> <span class="token operator">&gt;</span> <span class="token number">2</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// false</span></code></pre>
<p>Если коллекция пуста, <code>every</code> метод вернет true:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">every</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$value</span><span
                class="token punctuation">,</span> <span class="token variable">$key</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$value</span> <span class="token operator">&gt;</span> <span class="token number">2</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// true</span></code></pre>
<p></p>
<h4 id="method-except"><a href="#method-except"><code>except()</code></a></h4>
<p><code>except</code> Метод возвращает все элементы коллекции для тех, с заданными ключами, за исключением:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'product_id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">1</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'price'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">100</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'discount'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token boolean constant">false</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$filtered</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">except</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'price'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'discount'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$filtered</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['product_id' =&gt; 1]</span></code></pre>
<p>Для обратного <code>except</code> см. <a href="collections#method-only">Единственный</a> метод.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Поведение этого метода изменяется при использовании <a href="eloquent-collections#method-except">Eloquent
                Collections</a>.</p></p></div>
</blockquote>
<p></p>
<h4 id="method-filter"><a href="#method-filter"><code>filter()</code></a></h4>
<p><code>filter</code> Метод фильтрует коллекцию, используя данную функцию обратного вызова, сохраняя только те
    элементы, которые проходят тест данной истины:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$filtered</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">filter</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$value</span><span
                class="token punctuation">,</span> <span class="token variable">$key</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$value</span> <span class="token operator">&gt;</span> <span class="token number">2</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$filtered</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [3, 4]</span></code></pre>
<p>Если обратный вызов не предоставлен, все записи коллекции, которые эквивалентны, <code>false</code> будут удалены:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token constant">null</span><span class="token punctuation">,</span> <span
                class="token boolean constant">false</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">''</span><span class="token punctuation">,</span> <span
                class="token number">0</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span><span class="token punctuation">]</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">filter</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// [1, 2, 3]</span></code></pre>
<p>Чтобы <code>filter</code> узнать обратное, см. Метод <a href="collections#method-reject">отклонения</a>.</p>
<p></p>
<h4 id="method-first"><a href="#method-first"><code>first()</code></a></h4>
<p><code>first</code> Метод возвращает первый элемент в сборе, который проходит тест на данную истину:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">first</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$value</span><span
                class="token punctuation">,</span> <span class="token variable">$key</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$value</span> <span class="token operator">&gt;</span> <span class="token number">2</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// 3</span></code></pre>
<p>Вы также можете вызвать <code>first</code> метод без аргументов, чтобы получить первый элемент в коллекции. Если
    коллекция пуста, <code>null</code> возвращается:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">first</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// 1</span></code></pre>
<p></p>
<h4 id="method-firstWhere"><a href="#method-firstWhere"><code>firstWhere()</code></a></h4>
<p><code>firstWhere</code> Метод возвращает первый элемент в сборе с парой заданной ключ / значение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Regena'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'age'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token constant">null</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Linda'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'age'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">14</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Diego'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'age'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">23</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Linda'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'age'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">84</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">firstWhere</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'Linda'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// ['name' =&gt; 'Linda', 'age' =&gt; 14]</span></code></pre>
<p>Вы также можете вызвать <code>firstWhere</code> метод с помощью оператора сравнения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">firstWhere</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'age'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'&gt;='</span><span
                class="token punctuation">,</span> <span class="token number">18</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// ['name' =&gt; 'Diego', 'age' =&gt; 23]</span></code></pre>
<p>Как и в <a href="collections#method-where">случае с</a> методом <a href="collections#method-where">where</a>, вы
    можете передать <code>firstWhere</code> методу один аргумент. В этом сценарии <code>firstWhere</code> метод вернет
    первый элемент, для которого значение ключа данного элемента является «истинным»:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">firstWhere</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'age'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// ['name' =&gt; 'Linda', 'age' =&gt; 14]</span></code></pre>
<p></p>
<h4 id="method-flatMap"><a href="#method-flatMap"><code>flatMap()</code></a></h4>
<p><code>flatMap</code> Метод перебирает сбор и передает каждое значение для данного закрытия. Замыкание может изменить
    элемент и вернуть его, таким образом формируя новую коллекцию измененных элементов. Затем массив выравнивается на
    один уровень:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Sally'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'school'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Arkansas'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'age'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">28</span><span class="token punctuation">]</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$flattened</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">flatMap</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$values</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token function">array_map</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'strtoupper'</span><span class="token punctuation">,</span> <span class="token variable">$values</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$flattened</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['name' =&gt; 'SALLY', 'school' =&gt; 'ARKANSAS', 'age' =&gt; '28'];</span></code></pre>
<p></p>
<h4 id="method-flatten"><a href="#method-flatten"><code>flatten()</code></a></h4>
<p><code>flatten</code> Метод сглаживает многомерный коллекцию в одном измерении:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'taylor'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'languages'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'php'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'javascript'</span>
    <span class="token punctuation">]</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$flattened</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">flatten</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$flattened</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['taylor', 'php', 'javascript'];</span></code></pre>
<p>При необходимости вы можете передать <code>flatten</code> методу аргумент «глубины»:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'Apple'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token punctuation">[</span>
            <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'iPhone 6S'</span><span class="token punctuation">,</span>
            <span class="token single-quoted-string string">'brand'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Apple'</span>
        <span class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'Samsung'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token punctuation">[</span>
            <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Galaxy S7'</span><span class="token punctuation">,</span>
            <span class="token single-quoted-string string">'brand'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Samsung'</span>
        <span class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$products</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">flatten</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$products</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">values</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">/*
    [
        ['name' =&gt; 'iPhone 6S', 'brand' =&gt; 'Apple'],
        ['name' =&gt; 'Galaxy S7', 'brand' =&gt; 'Samsung'],
    ]
*/</span></code></pre>
<p>В этом примере вызов <code>flatten</code> без предоставления глубины также сгладил бы вложенные массивы, что привело
    бы к <code>['iPhone 6S', 'Apple', 'Galaxy S7', 'Samsung']</code>. Предоставление глубины позволяет указать
    количество уровней, на которые будут сглажены вложенные массивы.</p>
<p></p>
<h4 id="method-flip"><a href="#method-flip"><code>flip()</code></a></h4>
<p><code>flip</code> Метод обменивает ключей в коллекции с их соответствующими значениями:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'taylor'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'framework'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'laravel'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$flipped</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">flip</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$flipped</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['taylor' =&gt; 'name', 'laravel' =&gt; 'framework']</span></code></pre>
<p></p>
<h4 id="method-forget"><a href="#method-forget"><code>forget()</code></a></h4>
<p><code>forget</code> Метод удаляет элемент из коллекции по ключу:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'taylor'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'framework'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'laravel'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">forget</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['framework' =&gt; 'laravel']</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>В отличие от большинства других методов сбора, <code>forget</code> не возвращает новую измененную коллекцию;
            он изменяет вызываемую коллекцию.</p></p></div>
</blockquote>
<p></p>
<h4 id="method-forPage"><a href="#method-forPage"><code>forPage()</code></a></h4>
<p><code>forPage</code> Метод возвращает новую коллекцию, содержащие элементы, которые будут присутствовать на данный
    номере страницы. Метод принимает номер страницы в качестве первого аргумента и количество элементов, отображаемых на
    странице, в качестве второго аргумента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">,</span> <span
                class="token number">5</span><span class="token punctuation">,</span> <span
                class="token number">6</span><span class="token punctuation">,</span> <span
                class="token number">7</span><span class="token punctuation">,</span> <span
                class="token number">8</span><span class="token punctuation">,</span> <span
                class="token number">9</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$chunk</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">forPage</span><span
                class="token punctuation">(</span><span class="token number">2</span><span
                class="token punctuation">,</span> <span class="token number">3</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$chunk</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [4, 5, 6]</span></code></pre>
<p></p>
<h4 id="method-get"><a href="#method-get"><code>get()</code></a></h4>
<p><code>get</code> Метод возвращает элемент данного ключа. Если ключ не существует, <code>null</code> возвращается:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'taylor'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'framework'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'laravel'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$value</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'name'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// taylor</span></code></pre>
<p>При желании вы можете передать значение по умолчанию в качестве второго аргумента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'taylor'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'framework'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'laravel'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$value</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'age'</span><span class="token punctuation">,</span> <span
                class="token number">34</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// 34</span></code></pre>
<p>Вы даже можете передать обратный вызов как значение метода по умолчанию. Результат обратного вызова будет возвращен,
    если указанный ключ не существует:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'email'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token single-quoted-string string">'taylor@example.com'</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// taylor@example.com</span></code></pre>
<p></p>
<h4 id="method-groupBy"><a href="#method-groupBy"><code>groupBy()</code></a></h4>
<p>В <code>groupBy</code> методе группа предметов в коллекции от данного ключа:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'account_id'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'account-x10'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'product'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Chair'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'account_id'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'account-x10'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'product'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Bookcase'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'account_id'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'account-x11'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'product'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Desk'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$grouped</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">groupBy</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'account_id'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$grouped</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">/*
    [
        'account-x10' =&gt; [
            ['account_id' =&gt; 'account-x10', 'product' =&gt; 'Chair'],
            ['account_id' =&gt; 'account-x10', 'product' =&gt; 'Bookcase'],
        ],
        'account-x11' =&gt; [
            ['account_id' =&gt; 'account-x11', 'product' =&gt; 'Desk'],
        ],
    ]
*/</span></code></pre>
<p>Вместо передачи строки <code>key</code> вы можете передать обратный вызов. Обратный вызов должен вернуть значение,
    которое вы хотите задать для группы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$grouped</span> <span
                class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">groupBy</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$item</span><span
                class="token punctuation">,</span> <span class="token variable">$key</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token function">substr</span><span class="token punctuation">(</span><span class="token variable">$item</span><span class="token punctuation">[</span><span class="token single-quoted-string string">'account_id'</span><span class="token punctuation">]</span><span class="token punctuation">,</span> <span class="token operator">-</span><span class="token number">3</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$grouped</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">/*
    [
        'x10' =&gt; [
            ['account_id' =&gt; 'account-x10', 'product' =&gt; 'Chair'],
            ['account_id' =&gt; 'account-x10', 'product' =&gt; 'Bookcase'],
        ],
        'x11' =&gt; [
            ['account_id' =&gt; 'account-x11', 'product' =&gt; 'Desk'],
        ],
    ]
*/</span></code></pre>
<p>Несколько критериев группировки могут быть переданы в виде массива. Каждый элемент массива будет применен к
    соответствующему уровню в многомерном массиве:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$data</span> <span
                class="token operator">=</span> <span class="token keyword">new</span> <span class="token class-name">Collection</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token number">10</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'user'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">1</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'skill'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'roles'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'Role_1'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Role_3'</span><span class="token punctuation">]</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token number">20</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'user'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">2</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'skill'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'roles'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'Role_1'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Role_2'</span><span class="token punctuation">]</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token number">30</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'user'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">3</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'skill'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'roles'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'Role_1'</span><span class="token punctuation">]</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token number">40</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'user'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">4</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'skill'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'roles'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'Role_2'</span><span class="token punctuation">]</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$result</span> <span class="token operator">=</span> <span
                class="token variable">$data</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">groupBy</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'skill'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$item</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$item</span><span class="token punctuation">[</span><span class="token single-quoted-string string">'roles'</span><span class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span> <span class="token variable">$preserveKeys</span> <span
                class="token operator">=</span> <span class="token boolean constant">true</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">/*
[
    1 =&gt; [
        'Role_1' =&gt; [
            10 =&gt; ['user' =&gt; 1, 'skill' =&gt; 1, 'roles' =&gt; ['Role_1', 'Role_3']],
            20 =&gt; ['user' =&gt; 2, 'skill' =&gt; 1, 'roles' =&gt; ['Role_1', 'Role_2']],
        ],
        'Role_2' =&gt; [
            20 =&gt; ['user' =&gt; 2, 'skill' =&gt; 1, 'roles' =&gt; ['Role_1', 'Role_2']],
        ],
        'Role_3' =&gt; [
            10 =&gt; ['user' =&gt; 1, 'skill' =&gt; 1, 'roles' =&gt; ['Role_1', 'Role_3']],
        ],
    ],
    2 =&gt; [
        'Role_1' =&gt; [
            30 =&gt; ['user' =&gt; 3, 'skill' =&gt; 2, 'roles' =&gt; ['Role_1']],
        ],
        'Role_2' =&gt; [
            40 =&gt; ['user' =&gt; 4, 'skill' =&gt; 2, 'roles' =&gt; ['Role_2']],
        ],
    ],
];
*/</span></code></pre>
<p></p>
<h4 id="method-has"><a href="#method-has"><code>has()</code></a></h4>
<p><code>has</code> Метод определяет, является ли данный ключ присутствует в коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'account_id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">1</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'product'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Desk'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'amount'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">5</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">has</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'product'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// true</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">has</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'product'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'amount'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// true</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">has</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'amount'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'price'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// false</span></code></pre>
<p></p>
<h4 id="method-implode"><a href="#method-implode"><code>implode()</code></a></h4>
<p><code>implode</code> Метод объединяет элементы в коллекции. Его аргументы зависят от типа элементов в коллекции. Если
    коллекция содержит массивы или объекты, вы должны передать ключ атрибутов, которые вы хотите объединить, и
    «связующую» строку, которую вы хотите разместить между значениями:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'account_id'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'product'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Desk'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'account_id'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'product'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Chair'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">implode</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'product'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">', '</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// Desk, Chair</span></code></pre>
<p>Если коллекция содержит простые строки или числовые значения, вы должны передать «клей» как единственный аргумент
    методу:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">,</span> <span
                class="token number">5</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">implode</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'-'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// '1-2-3-4-5'</span></code></pre>
<p></p>
<h4 id="method-intersect"><a href="#method-intersect"><code>intersect()</code></a></h4>
<p><code>intersect</code> Метод удаляет любые значения из исходной коллекции, которые не присутствуют в данной <code>array</code>
    или коллекции. Полученная коллекция сохранит ключи исходной коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'Desk'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Sofa'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Chair'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$intersect</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">intersect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'Desk'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Chair'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Bookcase'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$intersect</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [0 =&gt; 'Desk', 2 =&gt; 'Chair']</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Поведение этого метода изменяется при использовании <a href="eloquent-collections#method-intersect">Eloquent
                Collections</a>.</p></p></div>
</blockquote>
<p></p>
<h4 id="method-intersectByKeys"><a href="#method-intersectByKeys"><code>intersectByKeys()</code></a></h4>
<p><code>intersectByKeys</code> Метод удаляет любые ключи и соответствующие им значения из исходной коллекции, которые
    не присутствуют в данной <code>array</code> или коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'serial'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'UX301'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'type'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'screen'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'year'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">2009</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$intersect</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">intersectByKeys</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'reference'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'UX404'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'type'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'tab'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'year'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">2011</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$intersect</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['type' =&gt; 'screen', 'year' =&gt; 2009]</span></code></pre>
<p></p>
<h4 id="method-isEmpty"><a href="#method-isEmpty"><code>isEmpty()</code></a></h4>
<p><code>isEmpty</code> Метод возвращает, <code>true</code> если коллекция пуста; в противном случае <code>false</code>
    возвращается:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">isEmpty</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// true</span></code></pre>
<p></p>
<h4 id="method-isNotEmpty"><a href="#method-isNotEmpty"><code>isNotEmpty()</code></a></h4>
<p>В <code>isNotEmpty</code> метод возвращает, <code>true</code> если коллекция не является пустым; в противном случае
    <code>false</code> возвращается:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">isNotEmpty</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// false</span></code></pre>
<p></p>
<h4 id="method-join"><a href="#method-join"><code>join()</code></a></h4>
<p><code>join</code> Метод соединяет ценность коллекции со строкой. Используя второй аргумент этого метода, вы также
    можете указать, как последний элемент должен быть добавлен к строке:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'a'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'b'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'c'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">join</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">', '</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span> <span class="token comment">// 'a, b, c'</span>
<span class="token function">collect</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'a'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'b'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'c'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">join</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">', '</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">', and '</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span> <span class="token comment">// 'a, b, and c'</span>
<span class="token function">collect</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'a'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'b'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">join</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">', '</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">' and '</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span> <span class="token comment">// 'a and b'</span>
<span class="token function">collect</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'a'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">join</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">', '</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">' and '</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span> <span class="token comment">// 'a'</span>
<span class="token function">collect</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">join</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">', '</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">' and '</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span> <span class="token comment">// ''</span></code></pre>
<p></p>
<h4 id="method-keyBy"><a href="#method-keyBy"><code>keyBy()</code></a></h4>
<p>В <code>keyBy</code> методе ключи сборника по данному ключу. Если у нескольких элементов один и тот же ключ, в новой
    коллекции появится только последний:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'product_id'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'prod-100'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Desk'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'product_id'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'prod-200'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Chair'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$keyed</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">keyBy</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'product_id'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$keyed</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">/*
    [
        'prod-100' =&gt; ['product_id' =&gt; 'prod-100', 'name' =&gt; 'Desk'],
        'prod-200' =&gt; ['product_id' =&gt; 'prod-200', 'name' =&gt; 'Chair'],
    ]
*/</span></code></pre>
<p>Вы также можете передать методу обратный вызов. Обратный вызов должен возвращать значение для ключа коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$keyed</span> <span
                class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">keyBy</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$item</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token function">strtoupper</span><span class="token punctuation">(</span><span class="token variable">$item</span><span class="token punctuation">[</span><span class="token single-quoted-string string">'product_id'</span><span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$keyed</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">/*
    [
        'PROD-100' =&gt; ['product_id' =&gt; 'prod-100', 'name' =&gt; 'Desk'],
        'PROD-200' =&gt; ['product_id' =&gt; 'prod-200', 'name' =&gt; 'Chair'],
    ]
*/</span></code></pre>
<p></p>
<h4 id="method-keys"><a href="#method-keys"><code>keys()</code></a></h4>
<p><code>keys</code> Метод возвращает все ключи в коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'prod-100'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'product_id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'prod-100'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Desk'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'prod-200'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'product_id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'prod-200'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Chair'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$keys</span> <span class="token operator">=</span> <span
                class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">keys</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$keys</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['prod-100', 'prod-200']</span></code></pre>
<p></p>
<h4 id="method-last"><a href="#method-last"><code>last()</code></a></h4>
<p><code>last</code> Метод возвращает последний элемент в коллекции, которая проходит тест данной истины:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">last</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$value</span><span
                class="token punctuation">,</span> <span class="token variable">$key</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$value</span> <span class="token operator">&lt;</span> <span class="token number">3</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// 2</span></code></pre>
<p>Вы также можете вызвать <code>last</code> метод без аргументов, чтобы получить последний элемент в коллекции. Если
    коллекция пуста, <code>null</code> возвращается:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">last</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// 4</span></code></pre>
<p></p>
<h4 id="method-macro"><a href="#method-macro"><code>macro()</code></a></h4>
<p>Статический <code>macro</code> метод позволяет добавлять методы в <code>Collection</code> класс во время выполнения.
    Обратитесь к документации по <a href="collections#extending-collections">расширению коллекций</a> для получения
    дополнительной информации.</p>
<p></p>
<h4 id="method-make"><a href="#method-make"><code>make()</code></a></h4>
<p>Статический <code>make</code> метод создает новый экземпляр коллекции. См. Раздел <a
            href="collections#creating-collections">Создание коллекций</a>.</p>
<p></p>
<h4 id="method-map"><a href="#method-map"><code>map()</code></a></h4>
<p><code>map</code> Метод перебирает сбор и передает каждое значение для данного обратного вызова. Обратный вызов может
    изменить элемент и вернуть его, образуя новую коллекцию измененных элементов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">,</span> <span
                class="token number">5</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$multiplied</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">map</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$item</span><span
                class="token punctuation">,</span> <span class="token variable">$key</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$item</span> <span class="token operator">*</span> <span class="token number">2</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$multiplied</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [2, 4, 6, 8, 10]</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Как и большинство других методов коллекции, <code>map</code> возвращает новый экземпляр коллекции; он не
            изменяет вызываемую коллекцию. Если вы хотите преобразовать исходную коллекцию, используйте <a
                    href="collections#method-transform"><code>transform</code></a>метод.</p></p></div>
</blockquote>
<p></p>
<h4 id="method-mapInto"><a href="#method-mapInto"><code>mapInto()</code></a></h4>
<p><code>mapInto()</code> Метод перебирает коллекцию, создавая новый экземпляр данного класса, передавая значение в
    конструктор:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">class</span> <span
                class="token class-name">Currency</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Create a new currency instance.
    *
    * @param  string  $code
    * @return void
    */</span>
    <span class="token keyword">function</span> <span class="token function">__construct</span><span class="token punctuation">(</span>string <span class="token variable">$code</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">code</span> <span class="token operator">=</span> <span class="token variable">$code</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span>

<span class="token variable">$collection</span> <span class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'USD'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'EUR'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'GBP'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$currencies</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">mapInto</span><span
                class="token punctuation">(</span>Currency<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$currencies</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [Currency('USD'), Currency('EUR'), Currency('GBP')]</span></code></pre>
<p></p>
<h4 id="method-mapSpread"><a href="#method-mapSpread"><code>mapSpread()</code></a></h4>
<p><code>mapSpread</code> Метод перебирает элементы в коллекции, передавая каждое вложенное значение элемента в данном
    закрытие. Замыкание может изменить элемент и вернуть его, образуя новую коллекцию измененных элементов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">0</span><span class="token punctuation">,</span> <span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">,</span> <span
                class="token number">5</span><span class="token punctuation">,</span> <span
                class="token number">6</span><span class="token punctuation">,</span> <span
                class="token number">7</span><span class="token punctuation">,</span> <span
                class="token number">8</span><span class="token punctuation">,</span> <span
                class="token number">9</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$chunks</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">chunk</span><span
                class="token punctuation">(</span><span class="token number">2</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$sequence</span> <span class="token operator">=</span> <span
                class="token variable">$chunks</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">mapSpread</span><span class="token punctuation">(</span><span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token variable">$even</span><span class="token punctuation">,</span> <span
                class="token variable">$odd</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$even</span> <span class="token operator">+</span> <span class="token variable">$odd</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$sequence</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [1, 5, 9, 13, 17]</span></code></pre>
<p></p>
<h4 id="method-mapToGroups"><a href="#method-mapToGroups"><code>mapToGroups()</code></a></h4>
<p>В <code>mapToGroups</code> группах метода элементов в коллекции по данному закрытию. Замыкание должно возвращать
    ассоциативный массив, содержащий одну пару ключ / значение, таким образом формируя новую коллекцию сгруппированных
    значений:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'John Doe'</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'department'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Sales'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Jane Doe'</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'department'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Sales'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Johnny Doe'</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'department'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Marketing'</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$grouped</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">mapToGroups</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$item</span><span
                class="token punctuation">,</span> <span class="token variable">$key</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">[</span><span class="token variable">$item</span><span class="token punctuation">[</span><span class="token single-quoted-string string">'department'</span><span class="token punctuation">]</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token variable">$item</span><span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span><span class="token punctuation">]</span><span class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$grouped</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">/*
    [
        'Sales' =&gt; ['John Doe', 'Jane Doe'],
        'Marketing' =&gt; ['Johnny Doe'],
    ]
*/</span>

<span class="token variable">$grouped</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Sales'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['John Doe', 'Jane Doe']</span></code></pre>
<p></p>
<h4 id="method-mapWithKeys"><a href="#method-mapWithKeys"><code>mapWithKeys()</code></a></h4>
<p><code>mapWithKeys</code> Метод перебирает сбор и передает каждое значение для данного обратного вызова. Обратный
    вызов должен возвращать ассоциативный массив, содержащий одну пару ключ / значение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'John'</span><span
                class="token punctuation">,</span>
        <span class="token single-quoted-string string">'department'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Sales'</span><span
                class="token punctuation">,</span>
        <span class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'john@example.com'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Jane'</span><span
                class="token punctuation">,</span>
        <span class="token single-quoted-string string">'department'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Marketing'</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'jane@example.com'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$keyed</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">mapWithKeys</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$item</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">[</span><span class="token variable">$item</span><span class="token punctuation">[</span><span class="token single-quoted-string string">'email'</span><span class="token punctuation">]</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token variable">$item</span><span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span><span class="token punctuation">]</span><span class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$keyed</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">/*
    [
        'john@example.com' =&gt; 'John',
        'jane@example.com' =&gt; 'Jane',
    ]
*/</span></code></pre>
<p></p>
<h4 id="method-max"><a href="#method-max"><code>max()</code></a></h4>
<p><code>max</code> Метод возвращает максимальное значение данного ключа:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$max</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'foo'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">10</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'foo'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">20</span><span class="token punctuation">]</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">max</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'foo'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// 20</span>

<span class="token variable">$max</span> <span class="token operator">=</span> <span
                class="token function">collect</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token number">1</span><span
                class="token punctuation">,</span> <span class="token number">2</span><span
                class="token punctuation">,</span> <span class="token number">3</span><span
                class="token punctuation">,</span> <span class="token number">4</span><span
                class="token punctuation">,</span> <span class="token number">5</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">max</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 5</span></code></pre>
<p></p>
<h4 id="method-median"><a href="#method-median"><code>median()</code></a></h4>
<p><code>median</code> Метод возвращает <a href="https://en.wikipedia.org/wiki/Median">среднее значение</a> данного
    ключа:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$median</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'foo'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">10</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'foo'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">10</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'foo'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">20</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'foo'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">40</span><span class="token punctuation">]</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">median</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'foo'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 15</span>

<span class="token variable">$median</span> <span class="token operator">=</span> <span
                class="token function">collect</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token number">1</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">,</span> <span class="token number">2</span><span
                class="token punctuation">,</span> <span class="token number">4</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">median</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// 1.5</span></code></pre>
<p></p>
<h4 id="method-merge"><a href="#method-merge"><code>merge()</code></a></h4>
<p><code>merge</code> Метод объединяет данный массив или коллекцию оригинальной коллекции. Если строковый ключ в данных
    элементах соответствует строковому ключу в исходной коллекции, значение данного элемента перезапишет значение в
    исходной коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'product_id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">1</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'price'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">100</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$merged</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">merge</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">200</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'discount'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token boolean constant">false</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$merged</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// ['product_id' =&gt; 1, 'price' =&gt; 200, 'discount' =&gt; false]</span></code></pre>
<p>Если ключи данных элементов являются числовыми, значения будут добавлены в конец коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'Desk'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Chair'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$merged</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">merge</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'Bookcase'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'Door'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$merged</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// ['Desk', 'Chair', 'Bookcase', 'Door']</span></code></pre>
<p></p>
<h4 id="method-mergeRecursive"><a href="#method-mergeRecursive"><code>mergeRecursive()</code></a></h4>
<p><code>mergeRecursive</code> Метод объединяет данный массив или коллекцию рекурсивен с оригинальной коллекцией. Если
    строковый ключ в данных элементах совпадает со строковым ключом в исходной коллекции, то значения этих ключей
    объединяются в массив, и это делается рекурсивно:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'product_id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">1</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'price'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">100</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$merged</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">mergeRecursive</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'product_id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">2</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">200</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'discount'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token boolean constant">false</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$merged</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// ['product_id' =&gt; [1, 2], 'price' =&gt; [100, 200], 'discount' =&gt; false]</span></code></pre>
<p></p>
<h4 id="method-min"><a href="#method-min"><code>min()</code></a></h4>
<p><code>min</code> Метод возвращает минимальное значение данного ключа:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$min</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'foo'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">10</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'foo'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">20</span><span
                class="token punctuation">]</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">min</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'foo'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 10</span>

<span class="token variable">$min</span> <span class="token operator">=</span> <span
                class="token function">collect</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token number">1</span><span
                class="token punctuation">,</span> <span class="token number">2</span><span
                class="token punctuation">,</span> <span class="token number">3</span><span
                class="token punctuation">,</span> <span class="token number">4</span><span
                class="token punctuation">,</span> <span class="token number">5</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">min</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 1</span></code></pre>
<p></p>
<h4 id="method-mode"><a href="#method-mode"><code>mode()</code></a></h4>
<p><code>mode</code> Метод возвращает <a href="https://en.wikipedia.org/wiki/Mode_(statistics)">значение режима</a>
    данного ключа:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$mode</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'foo'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">10</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'foo'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">10</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'foo'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">20</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'foo'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">40</span><span class="token punctuation">]</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">mode</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'foo'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [10]</span>

<span class="token variable">$mode</span> <span class="token operator">=</span> <span
                class="token function">collect</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token number">1</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">,</span> <span class="token number">2</span><span
                class="token punctuation">,</span> <span class="token number">4</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">mode</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// [1]</span></code></pre>
<p></p>
<h4 id="method-nth"><a href="#method-nth"><code>nth()</code></a></h4>
<p><code>nth</code> Метод создает новую коллекцию, состоящую из каждого п-го элемента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'a'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'b'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'c'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'d'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'e'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'f'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">nth</span><span
                class="token punctuation">(</span><span class="token number">4</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// ['a', 'e']</span></code></pre>
<p>При желании вы можете передать начальное смещение в качестве второго аргумента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">nth</span><span class="token punctuation">(</span><span
                class="token number">4</span><span class="token punctuation">,</span> <span
                class="token number">1</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['b', 'f']</span></code></pre>
<p></p>
<h4 id="method-only"><a href="#method-only"><code>only()</code></a></h4>
<p><code>only</code> Метод возвращает элементы коллекции с заданными ключами:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'product_id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">1</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Desk'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">100</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'discount'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token boolean constant">false</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$filtered</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">only</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span
                class="token single-quoted-string string">'product_id'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$filtered</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['product_id' =&gt; 1, 'name' =&gt; 'Desk']</span></code></pre>
<p>Чтобы <code>only</code> узнать обратное, см. Метод <a href="collections#method-except">except</a>.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Поведение этого метода изменяется при использовании <a href="eloquent-collections#method-only">Eloquent
                Collections</a>.</p></p></div>
</blockquote>
<p></p>
<h4 id="method-pad"><a href="#method-pad"><code>pad()</code></a></h4>
<p><code>pad</code> Метод заполняет массив с заданным значением до тех пор, пока массив не достигнет заданного размера.
    Этот метод ведет себя как <a href="https://secure.php.net/manual/en/function.array-pad.php">функция</a> PHP <a
            href="https://secure.php.net/manual/en/function.array-pad.php">array_pad</a>.</p>
<p>Для прокладки влево следует указать отрицательный размер. Если абсолютное значение заданного размера меньше или равно
    длине массива, заполнение не произойдет:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'A'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'B'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'C'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$filtered</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">pad</span><span class="token punctuation">(</span><span
                class="token number">5</span><span class="token punctuation">,</span> <span
                class="token number">0</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$filtered</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['A', 'B', 'C', 0, 0]</span>

<span class="token variable">$filtered</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">pad</span><span class="token punctuation">(</span><span
                class="token operator">-</span><span class="token number">5</span><span
                class="token punctuation">,</span> <span class="token number">0</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$filtered</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [0, 0, 'A', 'B', 'C']</span></code></pre>
<p></p>
<h4 id="method-partition"><a href="#method-partition"><code>partition()</code></a></h4>
<p>Этот <code>partition</code> метод можно комбинировать с <code>list</code> функцией PHP, чтобы отделить элементы,
    прошедшие заданный тест на истинность, от элементов, не прошедших:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">,</span> <span
                class="token number">5</span><span class="token punctuation">,</span> <span
                class="token number">6</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">list</span><span class="token punctuation">(</span><span
                class="token variable">$underThree</span><span class="token punctuation">,</span> <span
                class="token variable">$equalOrAboveThree</span><span class="token punctuation">)</span> <span
                class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">partition</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$i</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$i</span> <span class="token operator">&lt;</span> <span class="token number">3</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$underThree</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [1, 2]</span>

<span class="token variable">$equalOrAboveThree</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// [3, 4, 5, 6]</span></code></pre>
<p></p>
<h4 id="method-pipe"><a href="#method-pipe"><code>pipe()</code></a></h4>
<p><code>pipe</code> Метод проходит сбор к данному закрытию и возвращает результат выполненного закрытия:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$piped</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">pipe</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$collection</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$collection</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">sum</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// 6</span></code></pre>
<p></p>
<h4 id="method-pipeInto"><a href="#method-pipeInto"><code>pipeInto()</code></a></h4>
<p><code>pipeInto</code> Метод создает новый экземпляр данного класса и передает коллекцию в конструктор:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">class</span> <span
                class="token class-name">ResourceCollection</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * The Collection instance.
    */</span>
    <span class="token keyword">public</span> <span class="token variable">$collection</span><span class="token punctuation">;</span>

    <span class="token comment">/**
    * Create a new ResourceCollection instance.
    *
    * @param  Collection  $resource
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">__construct</span><span class="token punctuation">(</span>Collection <span class="token variable">$collection</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">collection</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span>

<span class="token variable">$collection</span> <span class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$resource</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">pipeInto</span><span
                class="token punctuation">(</span>ResourceCollection<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$resource</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// [1, 2, 3]</span></code></pre>
<p></p>
<h4 id="method-pluck"><a href="#method-pluck"><code>pluck()</code></a></h4>
<p><code>pluck</code> Метод извлекает все значения для данного ключа:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'product_id'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'prod-100'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Desk'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'product_id'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'prod-200'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Chair'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$plucked</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">pluck</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$plucked</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['Desk', 'Chair']</span></code></pre>
<p>Вы также можете указать, как вы хотите, чтобы результирующая коллекция была привязана:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$plucked</span> <span
                class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">pluck</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'product_id'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$plucked</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['prod-100' =&gt; 'Desk', 'prod-200' =&gt; 'Chair']</span></code></pre>
<p>Этот <code>pluck</code> метод также поддерживает получение вложенных значений с использованием "точечной" нотации:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'speakers'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
            <span class="token single-quoted-string string">'first_day'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'Rosa'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Judith'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
            <span class="token single-quoted-string string">'second_day'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'Angela'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Kathleen'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
        <span class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$plucked</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">pluck</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'speakers.first_day'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$plucked</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['Rosa', 'Judith']</span></code></pre>
<p>Если существуют повторяющиеся ключи, последний соответствующий элемент будет вставлен в извлеченную коллекцию:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'brand'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Tesla'</span><span class="token punctuation">,</span>  <span
                class="token single-quoted-string string">'color'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'red'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'brand'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Pagani'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'color'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'white'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'brand'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Tesla'</span><span class="token punctuation">,</span>  <span
                class="token single-quoted-string string">'color'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'black'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'brand'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Pagani'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'color'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'orange'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$plucked</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">pluck</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'color'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'brand'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$plucked</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['Tesla' =&gt; 'black', 'Pagani' =&gt; 'orange']</span></code></pre>
<p></p>
<h4 id="method-pop"><a href="#method-pop"><code>pop()</code></a></h4>
<p>В <code>pop</code> метод удаляет и возвращает последний элемент из коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">,</span> <span
                class="token number">5</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">pop</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// 5</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [1, 2, 3, 4]</span></code></pre>
<p></p>
<h4 id="method-prepend"><a href="#method-prepend"><code>prepend()</code></a></h4>
<p><code>prepend</code> Метод добавляет элемент в начало коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">,</span> <span
                class="token number">5</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">prepend</span><span
                class="token punctuation">(</span><span class="token number">0</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [0, 1, 2, 3, 4, 5]</span></code></pre>
<p>Вы также можете передать второй аргумент, чтобы указать ключ добавляемого элемента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'one'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">1</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'two'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">2</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">prepend</span><span
                class="token punctuation">(</span><span class="token number">0</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'zero'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['zero' =&gt; 0, 'one' =&gt; 1, 'two' =&gt; 2]</span></code></pre>
<p></p>
<h4 id="method-pull"><a href="#method-pull"><code>pull()</code></a></h4>
<p>В <code>pull</code> метод удаляет и возвращает элемент из коллекции по ключу:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'product_id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'prod-100'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Desk'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">pull</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 'Desk'</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['product_id' =&gt; 'prod-100']</span></code></pre>
<p></p>
<h4 id="method-push"><a href="#method-push"><code>push()</code></a></h4>
<p><code>push</code> Метод добавляет элемент в конец коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">push</span><span
                class="token punctuation">(</span><span class="token number">5</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [1, 2, 3, 4, 5]</span></code></pre>
<p></p>
<h4 id="method-put"><a href="#method-put"><code>put()</code></a></h4>
<p><code>put</code> Метод устанавливает заданный ключ и значение в коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'product_id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">1</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Desk'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">put</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'price'</span><span
                class="token punctuation">,</span> <span class="token number">100</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['product_id' =&gt; 1, 'name' =&gt; 'Desk', 'price' =&gt; 100]</span></code></pre>
<p></p>
<h4 id="method-random"><a href="#method-random"><code>random()</code></a></h4>
<p><code>random</code> Метод возвращает случайный элемент из коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">,</span> <span
                class="token number">5</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">random</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// 4 - (retrieved randomly)</span></code></pre>
<p>Вы можете передать целое число, чтобы <code>random</code> указать, сколько элементов вы хотите получить случайным
    образом. Коллекция элементов всегда возвращается при явной передаче количества элементов, которые вы хотите
    получить:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$random</span> <span
                class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">random</span><span
                class="token punctuation">(</span><span class="token number">3</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$random</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// [2, 4, 5] - (retrieved randomly)</span></code></pre>
<p>Если в экземпляре коллекции меньше элементов, чем запрошено, <code>random</code> метод выдаст файл <code>InvalidArgumentException</code>.
</p>
<p></p>
<h4 id="method-reduce"><a href="#method-reduce"><code>reduce()</code></a></h4>
<p><code>reduce</code> Метод уменьшает коллекцию к одному значению, передавая результат каждой итерации в последующей
    итерации:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$total</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">reduce</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$carry</span><span
                class="token punctuation">,</span> <span class="token variable">$item</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$carry</span> <span class="token operator">+</span> <span class="token variable">$item</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// 6</span></code></pre>
<p>Значение <code>$carry</code> на первой итерации <code>null</code> ; однако вы можете указать его начальное значение,
    передав второй аргумент в <code>reduce</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">reduce</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$carry</span><span
                class="token punctuation">,</span> <span class="token variable">$item</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$carry</span> <span class="token operator">+</span> <span class="token variable">$item</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">,</span> <span class="token number">4</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 10</span></code></pre>
<p><code>reduce</code> Метод также передает ключи массива в ассоциативных коллекциях к данной функции обратного вызова:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'usd'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">1400</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'gbp'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">1200</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'eur'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">1000</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$ratio</span> <span class="token operator">=</span> <span
                class="token punctuation">[</span>
    <span class="token single-quoted-string string">'usd'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">1</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'gbp'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">1.37</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'eur'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">1.22</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">reduceWithKeys</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$carry</span><span
                class="token punctuation">,</span> <span class="token variable">$value</span><span
                class="token punctuation">,</span> <span class="token variable">$key</span><span
                class="token punctuation">)</span> <span class="token keyword">use</span> <span
                class="token punctuation">(</span><span class="token variable">$ratio</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$carry</span> <span class="token operator">+</span> <span class="token punctuation">(</span><span class="token variable">$value</span> <span class="token operator">*</span> <span class="token variable">$ratio</span><span class="token punctuation">[</span><span class="token variable">$key</span><span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// 4264</span></code></pre>
<p></p>
<h4 id="method-reject"><a href="#method-reject"><code>reject()</code></a></h4>
<p><code>reject</code> Метод фильтрует коллекцию, используя данное замыкание. Закрытие должно вернуться,
    <code>true</code> если элемент должен быть удален из результирующей коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$filtered</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">reject</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$value</span><span
                class="token punctuation">,</span> <span class="token variable">$key</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$value</span> <span class="token operator">&gt;</span> <span class="token number">2</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$filtered</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [1, 2]</span></code></pre>
<p>Для обратного <code>reject</code> метода см. <a href="collections#method-filter"><code>filter</code></a>Метод.</p>
<p></p>
<h4 id="method-replace"><a href="#method-replace"><code>replace()</code></a></h4>
<p><code>replace</code> Метод ведет себя аналогично <code>merge</code> ; однако, помимо перезаписи совпадающих
    элементов, имеющих строковые ключи, <code>replace</code> метод также перезаписывает элементы в коллекции, у которых
    есть совпадающие числовые ключи:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'Taylor'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Abigail'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'James'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$replaced</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">replace</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Victoria'</span><span
                class="token punctuation">,</span> <span class="token number">3</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Finn'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$replaced</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['Taylor', 'Victoria', 'James', 'Finn']</span></code></pre>
<p></p>
<h4 id="method-replaceRecursive"><a href="#method-replaceRecursive"><code>replaceRecursive()</code></a></h4>
<p>Этот метод работает аналогично <code>replace</code>, но он будет повторяться в массивах и применять тот же процесс
    замены к внутренним значениям:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'Taylor'</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'Abigail'</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'James'</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'Victoria'</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'Finn'</span>
    <span class="token punctuation">]</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$replaced</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">replaceRecursive</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'Charlie'</span><span class="token punctuation">,</span>
    <span class="token number">2</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token number">1</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'King'</span><span
                class="token punctuation">]</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$replaced</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['Charlie', 'Abigail', ['James', 'King', 'Finn']]</span></code></pre>
<p></p>
<h4 id="method-reverse"><a href="#method-reverse"><code>reverse()</code></a></h4>
<p><code>reverse</code> Метод меняет порядок элементов в коллекции, сохраняя оригинальные ключи:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'a'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'b'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'c'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'d'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'e'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$reversed</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">reverse</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$reversed</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">/*
    [
        4 =&gt; 'e',
        3 =&gt; 'd',
        2 =&gt; 'c',
        1 =&gt; 'b',
        0 =&gt; 'a',
    ]
*/</span></code></pre>
<p></p>
<h4 id="method-search"><a href="#method-search"><code>search()</code></a></h4>
<p>В <code>search</code> поисках метод сбора для заданного значения и возвращает его ключ, если найдены. Если товар не
    найден, <code>false</code> возвращается:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">,</span> <span
                class="token number">6</span><span class="token punctuation">,</span> <span
                class="token number">8</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">search</span><span
                class="token punctuation">(</span><span class="token number">4</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 1</span></code></pre>
<p>Поиск выполняется с использованием "свободного" сравнения, то есть строка с целым значением будет считаться равной
    целому числу того же значения. Чтобы использовать «строгое» сравнение, передайте <code>true</code> методу в качестве
    второго аргумента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">,</span> <span
                class="token number">6</span><span class="token punctuation">,</span> <span
                class="token number">8</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">search</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'4'</span><span
                class="token punctuation">,</span> <span class="token variable">$strict</span> <span
                class="token operator">=</span> <span class="token boolean constant">true</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// false</span></code></pre>
<p>В качестве альтернативы вы можете предоставить собственное закрытие для поиска первого элемента, который проходит
    заданный тест на истинность:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">,</span> <span
                class="token number">6</span><span class="token punctuation">,</span> <span
                class="token number">8</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">search</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$item</span><span
                class="token punctuation">,</span> <span class="token variable">$key</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$item</span> <span class="token operator">&gt;</span> <span class="token number">5</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// 2</span></code></pre>
<p></p>
<h4 id="method-shift"><a href="#method-shift"><code>shift()</code></a></h4>
<p>В <code>shift</code> метод удаляет и возвращает первый элемент из коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">,</span> <span
                class="token number">5</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">shift</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// 1</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [2, 3, 4, 5]</span></code></pre>
<p></p>
<h4 id="method-shuffle"><a href="#method-shuffle"><code>shuffle()</code></a></h4>
<p><code>shuffle</code> Метод случайным образом перемешивает элементы в коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">,</span> <span
                class="token number">5</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$shuffled</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">shuffle</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$shuffled</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [3, 2, 5, 1, 4] - (generated randomly)</span></code></pre>
<p></p>
<h4 id="method-skip"><a href="#method-skip"><code>skip()</code></a></h4>
<p><code>skip</code> Метод возвращает новую коллекцию, с заданным количеством элементов, удаленных от начала сбора:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">,</span> <span
                class="token number">5</span><span class="token punctuation">,</span> <span
                class="token number">6</span><span class="token punctuation">,</span> <span
                class="token number">7</span><span class="token punctuation">,</span> <span
                class="token number">8</span><span class="token punctuation">,</span> <span
                class="token number">9</span><span class="token punctuation">,</span> <span
                class="token number">10</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">skip</span><span class="token punctuation">(</span><span
                class="token number">4</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [5, 6, 7, 8, 9, 10]</span></code></pre>
<p></p>
<h4 id="method-skipUntil"><a href="#method-skipUntil"><code>skipUntil()</code></a></h4>
<p><code>skipUntil</code> Метод пропускает элементы из коллекции до заданных возвращения обратного вызова,
    <code>true</code> а затем возвращает остальные элементы в коллекции как новый экземпляр коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$subset</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">skipUntil</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$item</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$item</span> <span class="token operator">&gt;=</span> <span class="token number">3</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$subset</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// [3, 4]</span></code></pre>
<p>Вы также можете передать <code>skipUntil</code> методу простое значение, чтобы пропустить все элементы, пока не будет
    найдено заданное значение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$subset</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">skipUntil</span><span
                class="token punctuation">(</span><span class="token number">3</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$subset</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// [3, 4]</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Если заданное значение не найдено или обратный вызов никогда не возвращается <code>true</code>, <code>skipUntil</code>
            метод вернет пустую коллекцию.</p></p></div>
</blockquote>
<p></p>
<h4 id="method-skipWhile"><a href="#method-skipWhile"><code>skipWhile()</code></a></h4>
<p><code>skipWhile</code> Метод пропускает элементы из коллекции в то время обратного вызова возвращает данные, <code>true</code>
    а затем возвращает остальные элементы в коллекции в качестве новой коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$subset</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">skipWhile</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$item</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$item</span> <span class="token operator">&lt;=</span> <span class="token number">3</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$subset</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// [4]</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Если обратный вызов никогда не возвращается <code>true</code>, <code>skipWhile</code> метод вернет пустую
            коллекцию.</p></p></div>
</blockquote>
<p></p>
<h4 id="method-slice"><a href="#method-slice"><code>slice()</code></a></h4>
<p><code>slice</code> Метод возвращает кусочек коллекции, начиная с заданным индексом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">,</span> <span
                class="token number">5</span><span class="token punctuation">,</span> <span
                class="token number">6</span><span class="token punctuation">,</span> <span
                class="token number">7</span><span class="token punctuation">,</span> <span
                class="token number">8</span><span class="token punctuation">,</span> <span
                class="token number">9</span><span class="token punctuation">,</span> <span
                class="token number">10</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$slice</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">slice</span><span
                class="token punctuation">(</span><span class="token number">4</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$slice</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [5, 6, 7, 8, 9, 10]</span></code></pre>
<p>Если вы хотите ограничить размер возвращаемого фрагмента, передайте желаемый размер в качестве второго аргумента
    метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$slice</span> <span
                class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">slice</span><span
                class="token punctuation">(</span><span class="token number">4</span><span
                class="token punctuation">,</span> <span class="token number">2</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$slice</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [5, 6]</span></code></pre>
<p>Возвращенный фрагмент по умолчанию сохранит ключи. Если вы не хотите сохранять исходные ключи, вы можете использовать
    этот <a href="collections#method-values"><code>values</code></a>метод для их переиндексации.</p>
<p></p>
<h4 id="method-some"><a href="#method-some"><code>some()</code></a></h4>
<p>Псевдоним <a href="collections#method-contains"><code>contains</code></a>метода.</p>
<p></p>
<h4 id="method-sort"><a href="#method-sort"><code>sort()</code></a></h4>
<p><code>sort</code> Метод сортирует коллекцию. Сортированная коллекция сохраняет исходные ключи массива, поэтому в
    следующем примере мы будем использовать этот <a href="collections#method-values"><code>values</code></a>метод для
    сброса ключей до последовательно пронумерованных индексов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">5</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$sorted</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">sort</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$sorted</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">values</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [1, 2, 3, 4, 5]</span></code></pre>
<p>Если ваши потребности в сортировке более сложные, вы можете передать обратный вызов с <code>sort</code> помощью
    своего собственного алгоритма. Обратитесь к документации PHP <a
            href="https://secure.php.net/manual/en/function.uasort.php%23refsect1-function.uasort-parameters"><code>uasort</code></a>,
    которая <code>sort</code> используется для внутренних вызовов методов коллекции.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Если вам нужно отсортировать коллекцию вложенных массивов или объектов, см <a
                    href="collections#method-sortby"><code>sortBy</code></a>и <a
                    href="collections#method-sortbydesc"><code>sortByDesc</code></a>методы.</p></p></div>
</blockquote>
<p></p>
<h4 id="method-sortBy"><a href="#method-sortBy"><code>sortBy()</code></a></h4>
<p><code>sortBy</code> Метод сортирует коллекцию с помощью данного ключа. Сортированная коллекция сохраняет исходные
    ключи массива, поэтому в следующем примере мы будем использовать этот <a href="collections#method-values"><code>values</code></a>метод
    для сброса ключей до последовательно пронумерованных индексов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Desk'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">200</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Chair'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">100</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Bookcase'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'price'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">150</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$sorted</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">sortBy</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'price'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$sorted</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">values</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">/*
    [
        ['name' =&gt; 'Chair', 'price' =&gt; 100],
        ['name' =&gt; 'Bookcase', 'price' =&gt; 150],
        ['name' =&gt; 'Desk', 'price' =&gt; 200],
    ]
*/</span></code></pre>
<p><code>sort</code> Метод принимает <a href="https://www.php.net/manual/en/function.sort.php">сортировки флаги</a> в
    качестве второго аргумента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'title'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Item 1'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'title'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Item 12'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'title'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Item 3'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$sorted</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">sortBy</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'title'</span><span
                class="token punctuation">,</span> <span class="token constant">SORT_NATURAL</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$sorted</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">values</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">/*
    [
        ['title' =&gt; 'Item 1'],
        ['title' =&gt; 'Item 3'],
        ['title' =&gt; 'Item 12'],
    ]
*/</span></code></pre>
<p>В качестве альтернативы вы можете передать собственное закрытие, чтобы определить, как сортировать значения
    коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Desk'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'colors'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'Black'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Mahogany'</span><span class="token punctuation">]</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Chair'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'colors'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'Black'</span><span class="token punctuation">]</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Bookcase'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'colors'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'Red'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Beige'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Brown'</span><span class="token punctuation">]</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$sorted</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">sortBy</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$product</span><span
                class="token punctuation">,</span> <span class="token variable">$key</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token function">count</span><span class="token punctuation">(</span><span class="token variable">$product</span><span class="token punctuation">[</span><span class="token single-quoted-string string">'colors'</span><span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$sorted</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">values</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">/*
    [
        ['name' =&gt; 'Chair', 'colors' =&gt; ['Black']],
        ['name' =&gt; 'Desk', 'colors' =&gt; ['Black', 'Mahogany']],
        ['name' =&gt; 'Bookcase', 'colors' =&gt; ['Red', 'Beige', 'Brown']],
    ]
*/</span></code></pre>
<p>Если вы хотите отсортировать свою коллекцию по нескольким атрибутам, вы можете передать в <code>sortBy</code> метод
    массив операций сортировки. Каждая операция сортировки должна быть массивом, состоящим из атрибута, по которому вы
    хотите сортировать, и направления желаемой сортировки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Taylor Otwell'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'age'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">34</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Abigail Otwell'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'age'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">30</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Taylor Otwell'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'age'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">36</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Abigail Otwell'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'age'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">32</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$sorted</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">sortBy</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'asc'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'age'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'desc'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$sorted</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">values</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">/*
    [
        ['name' =&gt; 'Abigail Otwell', 'age' =&gt; 32],
        ['name' =&gt; 'Abigail Otwell', 'age' =&gt; 30],
        ['name' =&gt; 'Taylor Otwell', 'age' =&gt; 36],
        ['name' =&gt; 'Taylor Otwell', 'age' =&gt; 34],
    ]
*/</span></code></pre>
<p>При сортировке коллекции по нескольким атрибутам вы также можете указать замыкания, определяющие каждую операцию
    сортировки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Taylor Otwell'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'age'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">34</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Abigail Otwell'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'age'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">30</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Taylor Otwell'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'age'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">36</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Abigail Otwell'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'age'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">32</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$sorted</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">sortBy</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    fn <span class="token punctuation">(</span><span class="token variable">$a</span><span
                class="token punctuation">,</span> <span class="token variable">$b</span><span
                class="token punctuation">)</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token variable">$a</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'name'</span><span class="token punctuation">]</span> <span
                class="token operator">&lt;=</span><span class="token operator">&gt;</span> <span
                class="token variable">$b</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'name'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    fn <span class="token punctuation">(</span><span class="token variable">$a</span><span
                class="token punctuation">,</span> <span class="token variable">$b</span><span
                class="token punctuation">)</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token variable">$b</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'age'</span><span class="token punctuation">]</span> <span
                class="token operator">&lt;=</span><span class="token operator">&gt;</span> <span
                class="token variable">$a</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'age'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$sorted</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">values</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">/*
    [
        ['name' =&gt; 'Abigail Otwell', 'age' =&gt; 32],
        ['name' =&gt; 'Abigail Otwell', 'age' =&gt; 30],
        ['name' =&gt; 'Taylor Otwell', 'age' =&gt; 36],
        ['name' =&gt; 'Taylor Otwell', 'age' =&gt; 34],
    ]
*/</span></code></pre>
<p></p>
<h4 id="method-sortByDesc"><a href="#method-sortByDesc"><code>sortByDesc()</code></a></h4>
<p>Этот метод имеет ту же сигнатуру, что и <a href="collections#method-sortby"><code>sortBy</code></a>метод, но
    сортирует коллекцию в обратном порядке.</p>
<p></p>
<h4 id="method-sortDesc"><a href="#method-sortDesc"><code>sortDesc()</code></a></h4>
<p>Этот метод сортирует коллекцию в порядке, обратном <a href="collections#method-sort"><code>sort</code></a>методу:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">5</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$sorted</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">sortDesc</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$sorted</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">values</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [5, 4, 3, 2, 1]</span></code></pre>
<p>В отличие от <code>sort</code>, вы не можете передать закрытие <code>sortDesc</code>. Вместо этого вы должны
    использовать этот <a href="collections#method-sort"><code>sort</code></a>метод и инвертировать сравнение.</p>
<p></p>
<h4 id="method-sortKeys"><a href="#method-sortKeys"><code>sortKeys()</code></a></h4>
<p><code>sortKeys</code> Метод сортирует коллекцию с помощью ключей от лежащего в основе ассоциативного массива:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">22345</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'first'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'John'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'last'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Doe'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$sorted</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">sortKeys</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$sorted</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">/*
    [
        'first' =&gt; 'John',
        'id' =&gt; 22345,
        'last' =&gt; 'Doe',
    ]
*/</span></code></pre>
<p></p>
<h4 id="method-sortKeysDesc"><a href="#method-sortKeysDesc"><code>sortKeysDesc()</code></a></h4>
<p>Этот метод имеет ту же сигнатуру, что и <a href="collections#method-sortkeys"><code>sortKeys</code></a>метод, но
    сортирует коллекцию в обратном порядке.</p>
<p></p>
<h4 id="method-splice"><a href="#method-splice"><code>splice()</code></a></h4>
<p>В <code>splice</code> метод удаляет и возвращает срез элементов, начиная с указанного индекса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">,</span> <span
                class="token number">5</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$chunk</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">splice</span><span
                class="token punctuation">(</span><span class="token number">2</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$chunk</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [3, 4, 5]</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [1, 2]</span></code></pre>
<p>Вы можете передать второй аргумент, чтобы ограничить размер результирующей коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">,</span> <span
                class="token number">5</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$chunk</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">splice</span><span
                class="token punctuation">(</span><span class="token number">2</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$chunk</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [3]</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [1, 2, 4, 5]</span></code></pre>
<p>Кроме того, вы можете передать третий аргумент, содержащий новые элементы, чтобы заменить элементы, удаленные из
    коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">,</span> <span
                class="token number">5</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$chunk</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">splice</span><span
                class="token punctuation">(</span><span class="token number">2</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token number">10</span><span class="token punctuation">,</span> <span
                class="token number">11</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$chunk</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [3]</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [1, 2, 10, 11, 4, 5]</span></code></pre>
<p></p>
<h4 id="method-split"><a href="#method-split"><code>split()</code></a></h4>
<p><code>split</code> Метод разбивает коллекцию в заданное число групп:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">,</span> <span
                class="token number">5</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$groups</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">split</span><span
                class="token punctuation">(</span><span class="token number">3</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$groups</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// [[1, 2], [3, 4], [5]]</span></code></pre>
<p></p>
<h4 id="method-splitIn"><a href="#method-splitIn"><code>splitIn()</code></a></h4>
<p><code>splitIn</code> Метод разбивает коллекцию в заданное число групп, полностью заполняя нетерминальные группы перед
    выделением остатка к последней группе:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">,</span> <span
                class="token number">5</span><span class="token punctuation">,</span> <span
                class="token number">6</span><span class="token punctuation">,</span> <span
                class="token number">7</span><span class="token punctuation">,</span> <span
                class="token number">8</span><span class="token punctuation">,</span> <span
                class="token number">9</span><span class="token punctuation">,</span> <span
                class="token number">10</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$groups</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">splitIn</span><span
                class="token punctuation">(</span><span class="token number">3</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$groups</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10]]</span></code></pre>
<p></p>
<h4 id="method-sum"><a href="#method-sum"><code>sum()</code></a></h4>
<p><code>sum</code> Метод возвращает сумму всех элементов в коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">,</span> <span
                class="token number">5</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">sum</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// 15</span></code></pre>
<p>Если коллекция содержит вложенные массивы или объекты, вы должны передать ключ, который будет использоваться для
    определения суммирования значений:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'JavaScript: The Good Parts'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'pages'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">176</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'JavaScript: The Definitive Guide'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'pages'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">1096</span><span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">sum</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'pages'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 1272</span></code></pre>
<p>Кроме того, вы можете передать собственное закрытие, чтобы определить, какие значения коллекции суммировать:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Chair'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'colors'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'Black'</span><span class="token punctuation">]</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Desk'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'colors'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'Black'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Mahogany'</span><span class="token punctuation">]</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Bookcase'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'colors'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'Red'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Beige'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Brown'</span><span class="token punctuation">]</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">sum</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$product</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token function">count</span><span class="token punctuation">(</span><span class="token variable">$product</span><span class="token punctuation">[</span><span class="token single-quoted-string string">'colors'</span><span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// 6</span></code></pre>
<p></p>
<h4 id="method-take"><a href="#method-take"><code>take()</code></a></h4>
<p><code>take</code> Метод возвращает новую коллекцию с заданным числом элементов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">0</span><span class="token punctuation">,</span> <span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">,</span> <span
                class="token number">5</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$chunk</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">take</span><span class="token punctuation">(</span><span
                class="token number">3</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$chunk</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [0, 1, 2]</span></code></pre>
<p>Вы также можете передать отрицательное целое число, чтобы взять указанное количество элементов из конца
    коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">0</span><span class="token punctuation">,</span> <span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">,</span> <span
                class="token number">5</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$chunk</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">take</span><span class="token punctuation">(</span><span
                class="token operator">-</span><span class="token number">2</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$chunk</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [4, 5]</span></code></pre>
<p></p>
<h4 id="method-takeUntil"><a href="#method-takeUntil"><code>takeUntil()</code></a></h4>
<p><code>takeUntil</code> Метод возвращает элементы в коллекции, пока данных возвращается обратного вызова
    <code>true</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$subset</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">takeUntil</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$item</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$item</span> <span class="token operator">&gt;=</span> <span class="token number">3</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$subset</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// [1, 2]</span></code></pre>
<p>Вы также можете передать простое значение <code>takeUntil</code> методу, чтобы получать элементы, пока не будет
    найдено заданное значение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$subset</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">takeUntil</span><span
                class="token punctuation">(</span><span class="token number">3</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$subset</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// [1, 2]</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Если данное значение не найдено или обратный вызов никогда не возвращается <code>true</code>,
            <code>takeUntil</code> метод вернет все элементы в коллекции.</p></p></div>
</blockquote>
<p></p>
<h4 id="method-takeWhile"><a href="#method-takeWhile"><code>takeWhile()</code></a></h4>
<p><code>takeWhile</code> Метод возвращает элементы в коллекции, пока данных возвращается обратного вызова
    <code>false</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$subset</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">takeWhile</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$item</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$item</span> <span class="token operator">&lt;</span> <span class="token number">3</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$subset</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// [1, 2]</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Если обратный вызов никогда не возвращается <code>false</code>, <code>takeWhile</code> метод вернет все
            элементы в коллекции.</p></p></div>
</blockquote>
<p></p>
<h4 id="method-tap"><a href="#method-tap"><code>tap()</code></a></h4>
<p><code>tap</code> Метод передает коллекцию данной функции обратного вызова, что позволяет «кран» в коллекции в
    определенной точке и сделать что - то с деталями, не затрагивая саму коллекцию. Затем коллекция возвращается <code>tap</code>
    методом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">5</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">sort</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">tap</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$collection</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        Log<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">debug</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'Values after sorting'</span><span class="token punctuation">,</span> <span class="token variable">$collection</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">values</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">all</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">shift</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 1</span></code></pre>
<p></p>
<h4 id="method-times"><a href="#method-times"><code>times()</code></a></h4>
<p>Статический <code>times</code> метод создает новую коллекцию, вызывая данное закрытие заданное количество раз:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> Collection<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">times</span><span
                class="token punctuation">(</span><span class="token number">10</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$number</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$number</span> <span class="token operator">*</span> <span class="token number">9</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [9, 18, 27, 36, 45, 54, 63, 72, 81, 90]</span></code></pre>
<p></p>
<h4 id="method-toArray"><a href="#method-toArray"><code>toArray()</code></a></h4>
<p><code>toArray</code> Метод преобразует коллекцию в обычный PHP <code>array</code>. Если значения коллекции являются
    моделями <a href="eloquent">Eloquent</a>, модели также будут преобразованы в массивы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Desk'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'price'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">200</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">toArray</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">/*
    [
        ['name' =&gt; 'Desk', 'price' =&gt; 200],
    ]
*/</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p><code>toArray</code> также преобразует все вложенные объекты коллекции, являющиеся экземпляром, <code>Arrayable</code>
            в массив. Если вы хотите получить необработанный массив, лежащий в основе коллекции, используйте <a
                    href="collections#method-all"><code>all</code></a>вместо этого метод.</p></p></div>
</blockquote>
<p></p>
<h4 id="method-toJson"><a href="#method-toJson"><code>toJson()</code></a></h4>
<p><code>toJson</code> Метод преобразует коллекцию в сериализованной строку JSON:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Desk'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'price'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">200</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">toJson</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// '{literal}{"name":"Desk", "price":200}{/literal}'</span></code></pre>
<p></p>
<h4 id="method-transform"><a href="#method-transform"><code>transform()</code></a></h4>
<p><code>transform</code> Метод перебирает коллекцию и вызывает данную функцию обратного вызова с каждым элементом
    коллекции. Элементы в коллекции будут заменены значениями, возвращаемыми обратным вызовом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">,</span> <span
                class="token number">5</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">transform</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$item</span><span
                class="token punctuation">,</span> <span class="token variable">$key</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$item</span> <span class="token operator">*</span> <span class="token number">2</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [2, 4, 6, 8, 10]</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>В отличие от большинства других методов сбора, <code>transform</code> изменяет саму коллекцию. Если вы хотите
            вместо этого создать новую коллекцию, используйте <a href="collections#method-map"><code>map</code></a>метод.
        </p></p></div>
</blockquote>
<p></p>
<h4 id="method-union"><a href="#method-union"><code>union()</code></a></h4>
<p><code>union</code> Метод добавляет указанный массив в коллекцию. Если данный массив содержит ключи, которые уже
    находятся в исходной коллекции, предпочтительнее будут значения исходной коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'a'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span> <span class="token number">2</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'b'</span><span class="token punctuation">]</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$union</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">union</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">3</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'c'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span> <span class="token number">1</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'b'</span><span class="token punctuation">]</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$union</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [1 =&gt; ['a'], 2 =&gt; ['b'], 3 =&gt; ['c']]</span></code></pre>
<p></p>
<h4 id="method-unique"><a href="#method-unique"><code>unique()</code></a></h4>
<p><code>unique</code> Метод возвращает все уникальные предметы в коллекции. Возвращенная коллекция сохраняет исходные
    ключи массива, поэтому в следующем примере мы будем использовать этот <a href="collections#method-values"><code>values</code></a>метод
    для сброса ключей на последовательно пронумерованные индексы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$unique</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">unique</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$unique</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">values</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [1, 2, 3, 4]</span></code></pre>
<p>При работе с вложенными массивами или объектами вы можете указать ключ, используемый для определения
    уникальности:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'iPhone 6'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'brand'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Apple'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'type'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'phone'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'iPhone 5'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'brand'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Apple'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'type'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'phone'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Apple Watch'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'brand'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Apple'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'type'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'watch'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Galaxy S6'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'brand'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Samsung'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'type'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'phone'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Galaxy Gear'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'brand'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Samsung'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'type'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'watch'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$unique</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">unique</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'brand'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$unique</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">values</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">/*
    [
        ['name' =&gt; 'iPhone 6', 'brand' =&gt; 'Apple', 'type' =&gt; 'phone'],
        ['name' =&gt; 'Galaxy S6', 'brand' =&gt; 'Samsung', 'type' =&gt; 'phone'],
    ]
*/</span></code></pre>
<p>Наконец, вы также можете передать собственное закрытие <code>unique</code> методу, чтобы указать, какое значение
    должно определять уникальность элемента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$unique</span> <span
                class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">unique</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$item</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$item</span><span class="token punctuation">[</span><span class="token single-quoted-string string">'brand'</span><span class="token punctuation">]</span><span class="token punctuation">.</span><span class="token variable">$item</span><span class="token punctuation">[</span><span class="token single-quoted-string string">'type'</span><span class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$unique</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">values</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">/*
    [
        ['name' =&gt; 'iPhone 6', 'brand' =&gt; 'Apple', 'type' =&gt; 'phone'],
        ['name' =&gt; 'Apple Watch', 'brand' =&gt; 'Apple', 'type' =&gt; 'watch'],
        ['name' =&gt; 'Galaxy S6', 'brand' =&gt; 'Samsung', 'type' =&gt; 'phone'],
        ['name' =&gt; 'Galaxy Gear', 'brand' =&gt; 'Samsung', 'type' =&gt; 'watch'],
    ]
*/</span></code></pre>
<p>Этот <code>unique</code> метод использует "свободные" сравнения при проверке значений элементов, что означает, что
    строка с целым значением будет считаться равной целому числу того же значения. Используйте этот <a
            href="collections#method-uniquestrict"><code>uniqueStrict</code></a>метод для фильтрации с использованием
    «строгих» сравнений.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Поведение этого метода изменяется при использовании <a href="eloquent-collections#method-unique">Eloquent
                Collections</a>.</p></p></div>
</blockquote>
<p></p>
<h4 id="method-uniqueStrict"><a href="#method-uniqueStrict"><code>uniqueStrict()</code></a></h4>
<p>Этот метод имеет ту же сигнатуру, что и <a href="collections#method-unique"><code>unique</code></a>метод; однако все
    значения сравниваются с использованием «строгих» сравнений.</p>
<p></p>
<h4 id="method-unless"><a href="#method-unless"><code>unless()</code></a></h4>
<p><code>unless</code> Метод будет выполнять данную функцию обратного вызова, если первый аргумент, который передается
    методу не имеет значение <code>true</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">unless</span><span
                class="token punctuation">(</span><span class="token boolean constant">true</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$collection</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$collection</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">push</span><span class="token punctuation">(</span><span class="token number">4</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">unless</span><span
                class="token punctuation">(</span><span class="token boolean constant">false</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$collection</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$collection</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">push</span><span class="token punctuation">(</span><span class="token number">5</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [1, 2, 3, 5]</span></code></pre>
<p>Для обратного <code>unless</code> см. <a href="collections#method-when"><code>when</code></a> метод.</p>
<p></p>
<h4 id="method-unlessEmpty"><a href="#method-unlessEmpty"><code>unlessEmpty()</code></a></h4>
<p>Псевдоним <a href="collections#method-whennotempty"><code>whenNotEmpty</code></a> метода.</p>
<p></p>
<h4 id="method-unlessNotEmpty"><a href="#method-unlessNotEmpty"><code>unlessNotEmpty()</code></a></h4>
<p>Псевдоним <a href="collections#method-whenempty"><code>whenEmpty</code></a> метода.</p>
<p></p>
<h4 id="method-unwrap"><a href="#method-unwrap"><code>unwrap()</code></a></h4>
<p>Статический <code>unwrap</code> метод возвращает базовые элементы коллекции из заданного значения, когда это
    применимо:</p>
<pre class=" language-php"><code class=" language-php">Collection<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">unwrap</span><span
                class="token punctuation">(</span><span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'John Doe'</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['John Doe']</span>

Collection<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">unwrap</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'John Doe'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// ['John Doe']</span>

Collection<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">unwrap</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'John Doe'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 'John Doe'</span></code></pre>
<p></p>
<h4 id="method-values"><a href="#method-values"><code>values()</code></a></h4>
<p><code>values</code> Метод возвращает новая коллекция с ключами, чтобы сбросить последовательные целые числа:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token number">10</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'product'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Desk'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'price'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">200</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token number">11</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'product'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Desk'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'price'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">200</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$values</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">values</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$values</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">/*
    [
        0 =&gt; ['product' =&gt; 'Desk', 'price' =&gt; 200],
        1 =&gt; ['product' =&gt; 'Desk', 'price' =&gt; 200],
    ]
*/</span></code></pre>
<p></p>
<h4 id="method-when"><a href="#method-when"><code>when()</code></a></h4>
<p><code>when</code> Метод будет выполнять данную функцию обратного вызова, когда первый аргумент, который передается
    методу оценивается как <code>true</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">when</span><span
                class="token punctuation">(</span><span class="token boolean constant">true</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$collection</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$collection</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">push</span><span class="token punctuation">(</span><span class="token number">4</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">when</span><span
                class="token punctuation">(</span><span class="token boolean constant">false</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$collection</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$collection</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">push</span><span class="token punctuation">(</span><span class="token number">5</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [1, 2, 3, 4]</span></code></pre>
<p>Для обратного <code>when</code> см. <a href="collections#method-unless"><code>unless</code></a>Метод.</p>
<p></p>
<h4 id="method-whenEmpty"><a href="#method-whenEmpty"><code>whenEmpty()</code></a></h4>
<p><code>whenEmpty</code> Метод будет выполнять данную функцию обратного вызова, когда коллекция пуста:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'Michael'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Tom'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">whenEmpty</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$collection</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$collection</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">push</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'Adam'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['Michael', 'Tom']</span>

<span class="token variable">$collection</span> <span class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">whenEmpty</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$collection</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$collection</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">push</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'Adam'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['Adam']</span></code></pre>
<p>Второе закрытие может быть передано <code>whenEmpty</code> методу, который будет выполняться, когда коллекция не
    пуста:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'Michael'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Tom'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">whenEmpty</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$collection</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$collection</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">push</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'Adam'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token variable">$collection</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$collection</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">push</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'Taylor'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['Michael', 'Tom', 'Taylor']</span></code></pre>
<p>Для обратного <code>whenEmpty</code> см. <a href="collections#method-whennotempty"><code>whenNotEmpty</code></a>Метод.
</p>
<p></p>
<h4 id="method-whenNotEmpty"><a href="#method-whenNotEmpty"><code>whenNotEmpty()</code></a></h4>
<p><code>whenNotEmpty</code> Метод будет выполнять данную функцию обратного вызова, когда коллекция не пуста:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'michael'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'tom'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">whenNotEmpty</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$collection</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$collection</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">push</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'adam'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['michael', 'tom', 'adam']</span>

<span class="token variable">$collection</span> <span class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">whenNotEmpty</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$collection</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$collection</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">push</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'adam'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// []</span></code></pre>
<p>Второе закрытие может быть передано <code>whenNotEmpty</code> методу, который будет выполняться, когда коллекция
    пуста:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">whenNotEmpty</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$collection</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$collection</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">push</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'adam'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token variable">$collection</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$collection</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">push</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'taylor'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['taylor']</span></code></pre>
<p>Для обратного <code>whenNotEmpty</code> см. <a href="collections#method-whenempty"><code>whenEmpty</code></a>Метод.
</p>
<p></p>
<h4 id="method-where"><a href="#method-where"><code>where()</code></a></h4>
<p><code>where</code> Метод фильтрует коллекцию с помощью данной пары ключей / значения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'product'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Desk'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">200</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'product'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Chair'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">100</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'product'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Bookcase'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'price'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">150</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'product'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Door'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">100</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$filtered</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'price'</span><span
                class="token punctuation">,</span> <span class="token number">100</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$filtered</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">/*
    [
        ['product' =&gt; 'Chair', 'price' =&gt; 100],
        ['product' =&gt; 'Door', 'price' =&gt; 100],
    ]
*/</span></code></pre>
<p>Этот <code>where</code> метод использует "свободные" сравнения при проверке значений элементов, что означает, что
    строка с целым значением будет считаться равной целому числу того же значения. Используйте этот <a
            href="collections#method-wherestrict"><code>whereStrict</code></a>метод для фильтрации с использованием
    «строгих» сравнений.</p>
<p>При желании вы можете передать оператор сравнения в качестве второго параметра.</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Jim'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'deleted_at'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'2019-01-01 00:00:00'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Sally'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'deleted_at'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'2019-01-02 00:00:00'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Sue'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'deleted_at'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token constant">null</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$filtered</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">where</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'deleted_at'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'!='</span><span
                class="token punctuation">,</span> <span class="token constant">null</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$filtered</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">/*
    [
        ['name' =&gt; 'Jim', 'deleted_at' =&gt; '2019-01-01 00:00:00'],
        ['name' =&gt; 'Sally', 'deleted_at' =&gt; '2019-01-02 00:00:00'],
    ]
*/</span></code></pre>
<p></p>
<h4 id="method-whereStrict"><a href="#method-whereStrict"><code>whereStrict()</code></a></h4>
<p>Этот метод имеет ту же сигнатуру, что и <a href="collections#method-where"><code>where</code></a>метод; однако все
    значения сравниваются с использованием «строгих» сравнений.</p>
<p></p>
<h4 id="method-whereBetween"><a href="#method-whereBetween"><code>whereBetween()</code></a></h4>
<p><code>whereBetween</code> Метод фильтры сбора путем определения, если указанное значение элемента находится в
    пределах заданного диапазона:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'product'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Desk'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">200</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'product'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Chair'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">80</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'product'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Bookcase'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'price'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">150</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'product'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Pencil'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">30</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'product'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Door'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">100</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$filtered</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">whereBetween</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'price'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span class="token number">100</span><span
                class="token punctuation">,</span> <span class="token number">200</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$filtered</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">/*
    [
        ['product' =&gt; 'Desk', 'price' =&gt; 200],
        ['product' =&gt; 'Bookcase', 'price' =&gt; 150],
        ['product' =&gt; 'Door', 'price' =&gt; 100],
    ]
*/</span></code></pre>
<p></p>
<h4 id="method-whereIn"><a href="#method-whereIn"><code>whereIn()</code></a></h4>
<p><code>whereIn</code> Метод удаляет элементы из коллекции, которые не имеют определенное значение элемента, который
    содержится в данном массиве:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'product'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Desk'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">200</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'product'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Chair'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">100</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'product'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Bookcase'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'price'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">150</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'product'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Door'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">100</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$filtered</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">whereIn</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'price'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span class="token number">150</span><span
                class="token punctuation">,</span> <span class="token number">200</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$filtered</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">/*
    [
        ['product' =&gt; 'Desk', 'price' =&gt; 200],
        ['product' =&gt; 'Bookcase', 'price' =&gt; 150],
    ]
*/</span></code></pre>
<p>Этот <code>whereIn</code> метод использует "свободные" сравнения при проверке значений элементов, что означает, что
    строка с целым значением будет считаться равной целому числу того же значения. Используйте этот <a
            href="collections#method-whereinstrict"><code>whereInStrict</code></a>метод для фильтрации с использованием
    «строгих» сравнений.</p>
<p></p>
<h4 id="method-whereInStrict"><a href="#method-whereInStrict"><code>whereInStrict()</code></a></h4>
<p>Этот метод имеет ту же сигнатуру, что и <a href="collections#method-wherein"><code>whereIn</code></a>метод; однако
    все значения сравниваются с использованием «строгих» сравнений.</p>
<p></p>
<h4 id="method-whereInstanceOf"><a href="#method-whereInstanceOf"><code>whereInstanceOf()</code></a></h4>
<p><code>whereInstanceOf</code> Метод фильтрует коллекцию с помощью данного типа класса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Models<span class="token punctuation">\</span>Post</span><span
                class="token punctuation">;</span>

<span class="token variable">$collection</span> <span class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token keyword">new</span> <span class="token class-name">User</span><span
                class="token punctuation">,</span>
    <span class="token keyword">new</span> <span class="token class-name">User</span><span
                class="token punctuation">,</span>
    <span class="token keyword">new</span> <span class="token class-name">Post</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$filtered</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">whereInstanceOf</span><span
                class="token punctuation">(</span>User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$filtered</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [App\Models\User, App\Models\User]</span></code></pre>
<p></p>
<h4 id="method-whereNotBetween"><a href="#method-whereNotBetween"><code>whereNotBetween()</code></a></h4>
<p><code>whereNotBetween</code> Метод фильтров сбора путем определения, если заданное значение элемента находится за
    пределами заданного диапазона:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'product'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Desk'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">200</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'product'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Chair'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">80</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'product'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Bookcase'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'price'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">150</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'product'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Pencil'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">30</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'product'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Door'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">100</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$filtered</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">whereNotBetween</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'price'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span class="token number">100</span><span
                class="token punctuation">,</span> <span class="token number">200</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$filtered</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">/*
    [
        ['product' =&gt; 'Chair', 'price' =&gt; 80],
        ['product' =&gt; 'Pencil', 'price' =&gt; 30],
    ]
*/</span></code></pre>
<p></p>
<h4 id="method-whereNotIn"><a href="#method-whereNotIn"><code>whereNotIn()</code></a></h4>
<p><code>whereNotIn</code> Метод удаляет элементы из коллекции, которые имеют заданное значение элемента, который не
    содержится в пределах данного массива:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'product'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Desk'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">200</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'product'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Chair'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">100</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'product'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Bookcase'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'price'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">150</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'product'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Door'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">100</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$filtered</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">whereNotIn</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'price'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span class="token number">150</span><span
                class="token punctuation">,</span> <span class="token number">200</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$filtered</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">/*
    [
        ['product' =&gt; 'Chair', 'price' =&gt; 100],
        ['product' =&gt; 'Door', 'price' =&gt; 100],
    ]
*/</span></code></pre>
<p>Этот <code>whereNotIn</code> метод использует "свободные" сравнения при проверке значений элементов, что означает,
    что строка с целым значением будет считаться равной целому числу того же значения. Используйте этот <a
            href="collections#method-wherenotinstrict"><code>whereNotInStrict</code></a>метод для фильтрации с
    использованием «строгих» сравнений.</p>
<p></p>
<h4 id="method-whereNotInStrict"><a href="#method-whereNotInStrict"><code>whereNotInStrict()</code></a></h4>
<p>Этот метод имеет ту же сигнатуру, что и <a href="collections#method-wherenotin"><code>whereNotIn</code></a>метод;
    однако все значения сравниваются с использованием «строгих» сравнений.</p>
<p></p>
<h4 id="method-whereNotNull"><a href="#method-whereNotNull"><code>whereNotNull()</code></a></h4>
<p><code>whereNotNull</code> Метод возвращает элементы из коллекции, где данный ключ не <code>null</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Desk'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token constant">null</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Bookcase'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$filtered</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">whereNotNull</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$filtered</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">/*
    [
        ['name' =&gt; 'Desk'],
        ['name' =&gt; 'Bookcase'],
    ]
*/</span></code></pre>
<p></p>
<h4 id="method-whereNull"><a href="#method-whereNull"><code>whereNull()</code></a></h4>
<p><code>whereNull</code> Метод возвращает элементы из коллекции, где данный ключ <code>null</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Desk'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token constant">null</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Bookcase'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$filtered</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">whereNull</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$filtered</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">/*
    [
        ['name' =&gt; null],
    ]
*/</span></code></pre>
<p></p>
<h4 id="method-wrap"><a href="#method-wrap"><code>wrap()</code></a></h4>
<p>Статический <code>wrap</code> метод оборачивает данное значение в коллекцию, когда это применимо:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Collection</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span> <span class="token operator">=</span> Collection<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">wrap</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'John Doe'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['John Doe']</span>

<span class="token variable">$collection</span> <span class="token operator">=</span> Collection<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">wrap</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'John Doe'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['John Doe']</span>

<span class="token variable">$collection</span> <span class="token operator">=</span> Collection<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">wrap</span><span
                class="token punctuation">(</span><span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'John Doe'</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$collection</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['John Doe']</span></code></pre>
<p></p>
<h4 id="method-zip"><a href="#collection-zip"><code>zip()</code></a></h4>
<p>В <code>zip</code> методе слияние вместе значения данного массива со значениями исходной коллекции при
    соответствующих их индексе:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'Chair'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Desk'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$zipped</span> <span class="token operator">=</span> <span class="token variable">$collection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">zip</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token number">100</span><span
                class="token punctuation">,</span> <span class="token number">200</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$zipped</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// [['Chair', 100], ['Desk', 200]]</span></code></pre>
<p></p>
<h2 id="higher-order-messages"><a href="#higher-order-messages">Сообщения высшего порядка</a></h2>
<p>Коллекции также обеспечивают поддержку «сообщений более высокого порядка», которые являются сокращениями для
    выполнения общих действий с коллекциями. Методы сбора, которые обеспечивают сообщения более высокого порядка
    являются: <a href="collections#method-average"><code>average</code></a>, <a
            href="collections#method-avg"><code>avg</code></a>, <a
            href="collections#method-contains"><code>contains</code></a>, <a
            href="collections#method-each"><code>each</code></a>, <a href="collections#method-every"><code>every</code></a>,
    <a href="collections#method-filter"><code>filter</code></a>, <a
            href="collections#method-first"><code>first</code></a>, <a
            href="collections#method-flatmap"><code>flatMap</code></a>, <a href="collections#method-groupby"><code>groupBy</code></a>,
    <a href="collections#method-keyby"><code>keyBy</code></a>, <a href="collections#method-map"><code>map</code></a>, <a
            href="collections#method-max"><code>max</code></a>, <a href="collections#method-min"><code>min</code></a>,
    <a href="collections#method-partition"><code>partition</code></a>, <a
            href="collections#method-reject"><code>reject</code></a>, <a href="collections#method-skipuntil"><code>skipUntil</code></a>,
    <a href="collections#method-skipwhile"><code>skipWhile</code></a>, <a
            href="collections#method-some"><code>some</code></a>, <a
            href="collections#method-sortby"><code>sortBy</code></a>, <a href="collections#method-sortbydesc"><code>sortByDesc</code></a>,
    <a href="collections#method-sum"><code>sum</code></a>, <a href="collections#method-takeuntil"><code>takeUntil</code></a>,
    <a href="collections#method-takewhile"><code>takeWhile</code></a>, и <a href="collections#method-unique"><code>unique</code></a>.
</p>
<p>К каждому сообщению более высокого порядка можно получить доступ как к динамическому свойству экземпляра коллекции.
    Например, давайте использовать <code>each</code> сообщение более высокого порядка для вызова метода для каждого
    объекта в коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

<span class="token variable">$users</span> <span class="token operator">=</span> User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'votes'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'&gt;'</span><span
                class="token punctuation">,</span> <span class="token number">500</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$users</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">each</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">markAsVip</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Точно так же мы можем использовать <code>sum</code> сообщение более высокого порядка для сбора общего количества
    «голосов» для набора пользователей:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'group'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Development'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token keyword">return</span> <span class="token variable">$users</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">sum</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">votes</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="lazy-collections"><a href="#lazy-collections">Ленивые коллекции</a></h2>
<p></p>
<h3 id="lazy-collection-introduction"><a href="#lazy-collection-introduction">Вступление</a></h3>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Прежде чем узнать больше о ленивых коллекциях Laravel, потратьте некоторое время на то, чтобы ознакомиться с
            <a href="https://www.php.net/manual/en/language.generators.overview.php">генераторами PHP</a>.</p></p></div>
</blockquote>
<p>Чтобы дополнить и без того мощный <code>Collection</code> класс, <code>LazyCollection</code> класс использует <a
            href="https://www.php.net/manual/en/language.generators.overview.php">генераторы</a> PHP, позволяющие вам
    работать с очень большими наборами данных, сохраняя при этом низкое использование памяти.</p>
<p>Например, представьте, что ваше приложение должно обрабатывать файл журнала размером в несколько гигабайт, используя
    при этом методы сбора данных Laravel для анализа журналов. Вместо того, чтобы читать весь файл в память сразу, можно
    использовать ленивые коллекции, чтобы сохранить в памяти только небольшую часть файла в данный момент:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>LogEntry</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>LazyCollection</span><span class="token punctuation">;</span>

LazyCollection<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">make</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$handle</span> <span class="token operator">=</span> <span class="token function">fopen</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'log.txt'</span><span class="token punctuation">,</span> <span class="token single-quoted-string string">'r'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

    <span class="token keyword">while</span> <span class="token punctuation">(</span><span class="token punctuation">(</span><span class="token variable">$line</span> <span class="token operator">=</span> <span class="token function">fgets</span><span class="token punctuation">(</span><span class="token variable">$handle</span><span class="token punctuation">)</span><span class="token punctuation">)</span> <span class="token operator">!==</span> <span class="token boolean constant">false</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">yield</span> <span class="token variable">$line</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">chunk</span><span
                class="token punctuation">(</span><span class="token number">4</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">map</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$lines</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> LogEntry<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">fromLines</span><span class="token punctuation">(</span><span class="token variable">$lines</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">each</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span>LogEntry <span class="token variable">$logEntry</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// Process the log entry...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Или представьте, что вам нужно перебрать 10 000 моделей Eloquent. При использовании традиционных коллекций Laravel
    все 10 000 моделей Eloquent должны быть загружены в память одновременно:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

<span class="token variable">$users</span> <span class="token operator">=</span> User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">filter</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$user</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">id</span> <span class="token operator">&gt;</span> <span class="token number">500</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Однако метод построителя запросов <code>cursor</code> возвращает <code>LazyCollection</code> экземпляр. Это позволяет
    вам по-прежнему выполнять только один запрос к базе данных, но при этом одновременно загружать в память только одну
    модель Eloquent. В этом примере <code>filter</code> обратный вызов не выполняется до тех пор, пока мы фактически не
    перебираем каждого пользователя индивидуально, что позволяет значительно сократить использование памяти:</p>
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
    <span class="token keyword">return</span> <span class="token variable">$user</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">id</span> <span class="token operator">&gt;</span> <span class="token number">500</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token keyword">foreach</span> <span class="token punctuation">(</span><span
                class="token variable">$users</span> <span class="token keyword">as</span> <span class="token variable">$user</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">echo</span> <span class="token variable">$user</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">id</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="creating-lazy-collections"><a href="#creating-lazy-collections">Создание ленивых коллекций</a></h3>
<p>Чтобы создать экземпляр ленивой коллекции, вы должны передать функцию генератора PHP <code>make</code> методу
    коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>LazyCollection</span><span class="token punctuation">;</span>

LazyCollection<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">make</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$handle</span> <span class="token operator">=</span> <span class="token function">fopen</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'log.txt'</span><span class="token punctuation">,</span> <span class="token single-quoted-string string">'r'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

    <span class="token keyword">while</span> <span class="token punctuation">(</span><span class="token punctuation">(</span><span class="token variable">$line</span> <span class="token operator">=</span> <span class="token function">fgets</span><span class="token punctuation">(</span><span class="token variable">$handle</span><span class="token punctuation">)</span><span class="token punctuation">)</span> <span class="token operator">!==</span> <span class="token boolean constant">false</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">yield</span> <span class="token variable">$line</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="the-enumerable-contract"><a href="#the-enumerable-contract">Перечислимый договор</a></h3>
<p>Почти все методы, доступные в <code>Collection</code> классе, также доступны в <code>LazyCollection</code> классе.
    Оба этих класса реализуют <code>Illuminate\Support\Enumerable</code> контракт, который определяет следующие методы:
</p>
<div id="collection-method-list">

    <p><a href="#method-all">all</a>
        <a href="#method-average">average</a>
        <a href="#method-avg">avg</a>
        <a href="#method-chunk">chunk</a>
        <a href="#method-chunkwhile">chunkWhile</a>
        <a href="#method-collapse">collapse</a>
        <a href="#method-collect">collect</a>
        <a href="#method-combine">combine</a>
        <a href="#method-concat">concat</a>
        <a href="#method-contains">contains</a>
        <a href="#method-containsstrict">containsStrict</a>
        <a href="#method-count">count</a>
        <a href="#method-countBy">countBy</a>
        <a href="#method-crossjoin">crossJoin</a>
        <a href="#method-dd">dd</a>
        <a href="#method-diff">diff</a>
        <a href="#method-diffassoc">diffAssoc</a>
        <a href="#method-diffkeys">diffKeys</a>
        <a href="#method-dump">dump</a>
        <a href="#method-duplicates">duplicates</a>
        <a href="#method-duplicatesstrict">duplicatesStrict</a>
        <a href="#method-each">each</a>
        <a href="#method-eachspread">eachSpread</a>
        <a href="#method-every">every</a>
        <a href="#method-except">except</a>
        <a href="#method-filter">filter</a>
        <a href="#method-first">first</a>
        <a href="#method-first-where">firstWhere</a>
        <a href="#method-flatmap">flatMap</a>
        <a href="#method-flatten">flatten</a>
        <a href="#method-flip">flip</a>
        <a href="#method-forpage">forPage</a>
        <a href="#method-get">get</a>
        <a href="#method-groupby">groupBy</a>
        <a href="#method-has">has</a>
        <a href="#method-implode">implode</a>
        <a href="#method-intersect">intersect</a>
        <a href="#method-intersectbykeys">intersectByKeys</a>
        <a href="#method-isempty">isEmpty</a>
        <a href="#method-isnotempty">isNotEmpty</a>
        <a href="#method-join">join</a>
        <a href="#method-keyby">keyBy</a>
        <a href="#method-keys">keys</a>
        <a href="#method-last">last</a>
        <a href="#method-macro">macro</a>
        <a href="#method-make">make</a>
        <a href="#method-map">map</a>
        <a href="#method-mapinto">mapInto</a>
        <a href="#method-mapspread">mapSpread</a>
        <a href="#method-maptogroups">mapToGroups</a>
        <a href="#method-mapwithkeys">mapWithKeys</a>
        <a href="#method-max">max</a>
        <a href="#method-median">median</a>
        <a href="#method-merge">merge</a>
        <a href="#method-mergerecursive">mergeRecursive</a>
        <a href="#method-min">min</a>
        <a href="#method-mode">mode</a>
        <a href="#method-nth">nth</a>
        <a href="#method-only">only</a>
        <a href="#method-pad">pad</a>
        <a href="#method-partition">partition</a>
        <a href="#method-pipe">pipe</a>
        <a href="#method-pluck">pluck</a>
        <a href="#method-random">random</a>
        <a href="#method-reduce">reduce</a>
        <a href="#method-reject">reject</a>
        <a href="#method-replace">replace</a>
        <a href="#method-replacerecursive">replaceRecursive</a>
        <a href="#method-reverse">reverse</a>
        <a href="#method-search">search</a>
        <a href="#method-shuffle">shuffle</a>
        <a href="#method-skip">skip</a>
        <a href="#method-slice">slice</a>
        <a href="#method-some">some</a>
        <a href="#method-sort">sort</a>
        <a href="#method-sortby">sortBy</a>
        <a href="#method-sortbydesc">sortByDesc</a>
        <a href="#method-sortkeys">sortKeys</a>
        <a href="#method-sortkeysdesc">sortKeysDesc</a>
        <a href="#method-split">split</a>
        <a href="#method-sum">sum</a>
        <a href="#method-take">take</a>
        <a href="#method-tap">tap</a>
        <a href="#method-times">times</a>
        <a href="#method-toarray">toArray</a>
        <a href="#method-tojson">toJson</a>
        <a href="#method-union">union</a>
        <a href="#method-unique">unique</a>
        <a href="#method-uniquestrict">uniqueStrict</a>
        <a href="#method-unless">unless</a>
        <a href="#method-unlessempty">unlessEmpty</a>
        <a href="#method-unlessnotempty">unlessNotEmpty</a>
        <a href="#method-unwrap">unwrap</a>
        <a href="#method-values">values</a>
        <a href="#method-when">when</a>
        <a href="#method-whenempty">whenEmpty</a>
        <a href="#method-whennotempty">whenNotEmpty</a>
        <a href="#method-where">where</a>
        <a href="#method-wherestrict">whereStrict</a>
        <a href="#method-wherebetween">whereBetween</a>
        <a href="#method-wherein">whereIn</a>
        <a href="#method-whereinstrict">whereInStrict</a>
        <a href="#method-whereinstanceof">whereInstanceOf</a>
        <a href="#method-wherenotbetween">whereNotBetween</a>
        <a href="#method-wherenotin">whereNotIn</a>
        <a href="#method-wherenotinstrict">whereNotInStrict</a>
        <a href="#method-wrap">wrap</a>
        <a href="#method-zip">zip</a></p>
</div>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Методы, которые мутировать коллекции (таких, как <code>shift</code>, <code>pop</code>, и <code>prepend</code>
            т.д.) <strong>не</strong> доступны на <code>LazyCollection</code> классе.</p></p></div>
</blockquote>
<p></p>
<h3 id="lazy-collection-methods"><a href="#lazy-method-names">Ленивые методы сбора</a></h3>
<p>Помимо методов, определенных в <code>Enumerable</code> контракте, <code>LazyCollection</code> класс содержит
    следующие методы:</p>
<p></p>
<h4 id="method-takeUntilTimeout"><a href="#method-takeUntilTimeout"><code>takeUntilTimeout()</code></a></h4>
<p><code>takeUntilTimeout</code> Метод возвращает новые ленивые коллекции, которая будет перечислять значения до
    указанного времени. По истечении этого времени коллекция перестанет перечислять:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$lazyCollection</span> <span
                class="token operator">=</span> LazyCollection<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">times</span><span
                class="token punctuation">(</span><span class="token constant">INF</span><span
                class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">takeUntilTimeout</span><span
                class="token punctuation">(</span><span class="token function">now</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">addMinute</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$lazyCollection</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">each</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$number</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token function">dump</span><span class="token punctuation">(</span><span class="token variable">$number</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

    <span class="token function">sleep</span><span class="token punctuation">(</span><span class="token number">1</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// 1</span>
<span class="token comment">// 2</span>
<span class="token comment">//...</span>
<span class="token comment">// 58</span>
<span class="token comment">// 59</span></code></pre>
<p>Чтобы проиллюстрировать использование этого метода, представьте приложение, которое отправляет счета-фактуры из базы
    данных с помощью курсора. Вы можете определить <a href="scheduling">запланированную задачу,</a> которая запускается
    каждые 15 минут и обрабатывает счета не более 14 минут:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Invoice</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Carbon</span><span class="token punctuation">;</span>

Invoice<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">pending</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">cursor</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">takeUntilTimeout</span><span
                class="token punctuation">(</span>
        Carbon<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">createFromTimestamp</span><span class="token punctuation">(</span><span
                class="token constant">LARAVEL_START</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">add</span><span class="token punctuation">(</span><span
                class="token number">14</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'minutes'</span><span class="token punctuation">)</span>
    <span class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">each</span><span class="token punctuation">(</span>fn <span
                class="token punctuation">(</span><span class="token variable">$invoice</span><span
                class="token punctuation">)</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token variable">$invoice</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">submit</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-tapEach"><a href="#method-tapEach"><code>tapEach()</code></a></h4>
<p>В то время как <code>each</code> метод вызывает данный обратный вызов для каждого элемента в коллекции сразу, <code>tapEach</code>
    метод вызывает только данный обратный вызов, поскольку элементы извлекаются из списка один за другим:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token comment">// Nothing has been dumped so far...</span>
<span class="token variable">$lazyCollection</span> <span class="token operator">=</span> LazyCollection<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">times</span><span
                class="token punctuation">(</span><span class="token constant">INF</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">tapEach</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$value</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token function">dump</span><span class="token punctuation">(</span><span class="token variable">$value</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// Three items are dumped...</span>
<span class="token variable">$array</span> <span class="token operator">=</span> <span class="token variable">$lazyCollection</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">take</span><span class="token punctuation">(</span><span
                class="token number">3</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 1</span>
<span class="token comment">// 2</span>
<span class="token comment">// 3</span></code></pre>
<p></p>
<h4 id="method-remember"><a href="#method-remember"><code>remember()</code></a></h4>
<p><code>remember</code> Метод возвращает новые ленивые коллекции, которая будет помнить все значения, которые уже были
    перечислены и не извлечем их снова на последующих перечислениях коллекции:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token comment">// No query has been executed yet...</span>
<span class="token variable">$users</span> <span class="token operator">=</span> User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">cursor</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">remember</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// The query is executed...</span>
<span class="token comment">// The first 5 users are hydrated from the database...</span>
<span class="token variable">$users</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">take</span><span
                class="token punctuation">(</span><span class="token number">5</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// First 5 users come from the collection's cache...</span>
<span class="token comment">// The rest are hydrated from the database...</span>
<span class="token variable">$users</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">take</span><span
                class="token punctuation">(</span><span class="token number">20</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
