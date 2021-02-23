<h1>Помощники <sup>helpers</sup></h1>
<h2 id="introduction"><a href="#introduction">Вступление <sup>Introduction</sup></a></h2>
<p>Laravel включает множество глобальных «вспомогательных» функций PHP. Многие из этих функций используются самим
    фреймворком; однако вы можете использовать их в своих собственных приложениях, если сочтете их удобными.</p>
<p></p>
<h2 id="available-methods"><a href="#available-methods">Доступные методы <sup>Available Methods</sup></a></h2>
<style>
    .collection-method-list > p {
        column-count: 3;
        -moz-column-count: 3;
        -webkit-column-count: 3;
        column-gap: 2em;
        -moz-column-gap: 2em;
        -webkit-column-gap: 2em;
    }

    .collection-method-list a {
        display: block;
    }
</style>
<p></p>
<h3 id="arrays-and-objects-method-list"><a href="#arrays-and-objects-method-list">Массивы и объекты <sup>arrays &
            objects</sup></a></h3>
<div class="collection-method-list">
    <p><a href="#method-array-accessible">Arr::accessible</a>
        <a href="#method-array-add">Arr::add</a>
        <a href="#method-array-collapse">Arr::collapse</a>
        <a href="#method-array-crossjoin">Arr::crossJoin</a>
        <a href="#method-array-divide">Arr::divide</a>
        <a href="#method-array-dot">Arr::dot</a>
        <a href="#method-array-except">Arr::except</a>
        <a href="#method-array-exists">Arr::exists</a>
        <a href="#method-array-first">Arr::first</a>
        <a href="#method-array-flatten">Arr::flatten</a>
        <a href="#method-array-forget">Arr::forget</a>
        <a href="#method-array-get">Arr::get</a>
        <a href="#method-array-has">Arr::has</a>
        <a href="#method-array-hasany">Arr::hasAny</a>
        <a href="#method-array-isassoc">Arr::isAssoc</a>
        <a href="#method-array-last">Arr::last</a>
        <a href="#method-array-only">Arr::only</a>
        <a href="#method-array-pluck">Arr::pluck</a>
        <a href="#method-array-prepend">Arr::prepend</a>
        <a href="#method-array-pull">Arr::pull</a>
        <a href="#method-array-query">Arr::query</a>
        <a href="#method-array-random">Arr::random</a>
        <a href="#method-array-set">Arr::set</a>
        <a href="#method-array-shuffle">Arr::shuffle</a>
        <a href="#method-array-sort">Arr::sort</a>
        <a href="#method-array-sort-recursive">Arr::sortRecursive</a>
        <a href="#method-array-where">Arr::where</a>
        <a href="#method-array-wrap">Arr::wrap</a>
        <a href="#method-data-fill">data_fill</a>
        <a href="#method-data-get">data_get</a>
        <a href="#method-data-set">data_set</a>
        <a href="#method-head">head</a>
        <a href="#method-last">last</a></p>
</div>
<p></p>
<h3 id="paths-method-list"><a href="#paths-method-list">Пути <sup>paths</sup></a></h3>
<div class="collection-method-list">
    <p><a href="#method-app-path">app_path</a>
        <a href="#method-base-path">base_path</a>
        <a href="#method-config-path">config_path</a>
        <a href="#method-database-path">database_path</a>
        <a href="#method-mix">mix</a>
        <a href="#method-public-path">public_path</a>
        <a href="#method-resource-path">resource_path</a>
        <a href="#method-storage-path">storage_path</a></p>
</div>
<p></p>
<h3 id="strings-method-list"><a href="#strings-method-list">Строки <sup>strings</sup></a></h3>
<div class="collection-method-list">
    <p><a href="#method-__">__</a>
        <a href="#method-class-basename">class_basename</a>
        <a href="#method-e">e</a>
        <a href="#method-preg-replace-array">preg_replace_array</a>
        <a href="#method-str-after">Str::after</a>
        <a href="#method-str-after-last">Str::afterLast</a>
        <a href="#method-str-ascii">Str::ascii</a>
        <a href="#method-str-before">Str::before</a>
        <a href="#method-str-before-last">Str::beforeLast</a>
        <a href="#method-str-between">Str::between</a>
        <a href="#method-camel-case">Str::camel</a>
        <a href="#method-str-contains">Str::contains</a>
        <a href="#method-str-contains-all">Str::containsAll</a>
        <a href="#method-ends-with">Str::endsWith</a>
        <a href="#method-str-finish">Str::finish</a>
        <a href="#method-str-is">Str::is</a>
        <a href="#method-str-is-ascii">Str::isAscii</a>
        <a href="#method-str-is-uuid">Str::isUuid</a>
        <a href="#method-kebab-case">Str::kebab</a>
        <a href="#method-str-length">Str::length</a>
        <a href="#method-str-limit">Str::limit</a>
        <a href="#method-str-lower">Str::lower</a>
        <a href="#method-str-markdown">Str::markdown</a>
        <a href="#method-str-ordered-uuid">Str::orderedUuid</a>
        <a href="#method-str-padboth">Str::padBoth</a>
        <a href="#method-str-padleft">Str::padLeft</a>
        <a href="#method-str-padright">Str::padRight</a>
        <a href="#method-str-plural">Str::plural</a>
        <a href="#method-str-plural-studly">Str::pluralStudly</a>
        <a href="#method-str-random">Str::random</a>
        <a href="#method-str-replace-array">Str::replaceArray</a>
        <a href="#method-str-replace-first">Str::replaceFirst</a>
        <a href="#method-str-replace-last">Str::replaceLast</a>
        <a href="#method-str-singular">Str::singular</a>
        <a href="#method-str-slug">Str::slug</a>
        <a href="#method-snake-case">Str::snake</a>
        <a href="#method-str-start">Str::start</a>
        <a href="#method-starts-with">Str::startsWith</a>
        <a href="#method-studly-case">Str::studly</a>
        <a href="#method-str-substr">Str::substr</a>
        <a href="#method-str-substrcount">Str::substrCount</a>
        <a href="#method-title-case">Str::title</a>
        <a href="#method-str-ucfirst">Str::ucfirst</a>
        <a href="#method-str-upper">Str::upper</a>
        <a href="#method-str-uuid">Str::uuid</a>
        <a href="#method-str-words">Str::words</a>
        <a href="#method-trans">trans</a>
        <a href="#method-trans-choice">trans_choice</a></p>
</div>
<p></p>
<h3 id="fluent-strings-method-list"><a href="#fluent-strings-method-list">Свободные строки <sup>fluent strings</sup></a>
</h3>
<div class="collection-method-list">
    <p><a href="#method-fluent-str-after">after</a>
        <a href="#method-fluent-str-after-last">afterLast</a>
        <a href="#method-fluent-str-append">append</a>
        <a href="#method-fluent-str-ascii">ascii</a>
        <a href="#method-fluent-str-basename">basename</a>
        <a href="#method-fluent-str-before">before</a>
        <a href="#method-fluent-str-before-last">beforeLast</a>
        <a href="#method-fluent-str-camel">camel</a>
        <a href="#method-fluent-str-contains">contains</a>
        <a href="#method-fluent-str-contains-all">containsAll</a>
        <a href="#method-fluent-str-dirname">dirname</a>
        <a href="#method-fluent-str-ends-with">endsWith</a>
        <a href="#method-fluent-str-exactly">exactly</a>
        <a href="#method-fluent-str-explode">explode</a>
        <a href="#method-fluent-str-finish">finish</a>
        <a href="#method-fluent-str-is">is</a>
        <a href="#method-fluent-str-is-ascii">isAscii</a>
        <a href="#method-fluent-str-is-empty">isEmpty</a>
        <a href="#method-fluent-str-is-not-empty">isNotEmpty</a>
        <a href="#method-fluent-str-kebab">kebab</a>
        <a href="#method-fluent-str-length">length</a>
        <a href="#method-fluent-str-limit">limit</a>
        <a href="#method-fluent-str-lower">lower</a>
        <a href="#method-fluent-str-ltrim">ltrim</a>
        <a href="#method-fluent-str-markdown">markdown</a>
        <a href="#method-fluent-str-match">match</a>
        <a href="#method-fluent-str-match-all">matchAll</a>
        <a href="#method-fluent-str-padboth">padBoth</a>
        <a href="#method-fluent-str-padleft">padLeft</a>
        <a href="#method-fluent-str-padright">padRight</a>
        <a href="#method-fluent-str-pipe">pipe</a>
        <a href="#method-fluent-str-plural">plural</a>
        <a href="#method-fluent-str-prepend">prepend</a>
        <a href="#method-fluent-str-replace">replace</a>
        <a href="#method-fluent-str-replace-array">replaceArray</a>
        <a href="#method-fluent-str-replace-first">replaceFirst</a>
        <a href="#method-fluent-str-replace-last">replaceLast</a>
        <a href="#method-fluent-str-replace-matches">replaceMatches</a>
        <a href="#method-fluent-str-rtrim">rtrim</a>
        <a href="#method-fluent-str-singular">singular</a>
        <a href="#method-fluent-str-slug">slug</a>
        <a href="#method-fluent-str-snake">snake</a>
        <a href="#method-fluent-str-split">split</a>
        <a href="#method-fluent-str-start">start</a>
        <a href="#method-fluent-str-starts-with">startsWith</a>
        <a href="#method-fluent-str-studly">studly</a>
        <a href="#method-fluent-str-substr">substr</a>
        <a href="#method-fluent-str-tap">tap</a>
        <a href="#method-fluent-str-title">title</a>
        <a href="#method-fluent-str-trim">trim</a>
        <a href="#method-fluent-str-ucfirst">ucfirst</a>
        <a href="#method-fluent-str-upper">upper</a>
        <a href="#method-fluent-str-when">when</a>
        <a href="#method-fluent-str-when-empty">whenEmpty</a>
        <a href="#method-fluent-str-words">words</a></p>
</div>
<p></p>
<h3 id="urls-method-list"><a href="#urls-method-list">URL-адреса <sup>urls</sup></a></h3>
<div class="collection-method-list">
    <p><a href="#method-action">action</a>
        <a href="#method-asset">asset</a>
        <a href="#method-route">route</a>
        <a href="#method-secure-asset">secure_asset</a>
        <a href="#method-secure-url">secure_url</a>
        <a href="#method-url">url</a></p>
</div>
<p></p>
<h3 id="miscellaneous-method-list"><a href="#miscellaneous-method-list">Разное <sup>miscellaneous</sup></a></h3>
<div class="collection-method-list">

    <p><a href="#method-abort">abort</a>
        <a href="#method-abort-if">abort_if</a>
        <a href="#method-abort-unless">abort_unless</a>
        <a href="#method-app">app</a>
        <a href="#method-auth">auth</a>
        <a href="#method-back">back</a>
        <a href="#method-bcrypt">bcrypt</a>
        <a href="#method-blank">blank</a>
        <a href="#method-broadcast">broadcast</a>
        <a href="#method-cache">cache</a>
        <a href="#method-class-uses-recursive">class_uses_recursive</a>
        <a href="#method-collect">collect</a>
        <a href="#method-config">config</a>
        <a href="#method-cookie">cookie</a>
        <a href="#method-csrf-field">csrf_field</a>
        <a href="#method-csrf-token">csrf_token</a>
        <a href="#method-dd">dd</a>
        <a href="#method-dispatch">dispatch</a>
        <a href="#method-dispatch-now">dispatch_now</a>
        <a href="#method-dump">dump</a>
        <a href="#method-env">env</a>
        <a href="#method-event">event</a>
        <a href="#method-filled">filled</a>
        <a href="#method-info">info</a>
        <a href="#method-logger">logger</a>
        <a href="#method-method-field">method_field</a>
        <a href="#method-now">now</a>
        <a href="#method-old">old</a>
        <a href="#method-optional">optional</a>
        <a href="#method-policy">policy</a>
        <a href="#method-redirect">redirect</a>
        <a href="#method-report">report</a>
        <a href="#method-request">request</a>
        <a href="#method-rescue">rescue</a>
        <a href="#method-resolve">resolve</a>
        <a href="#method-response">response</a>
        <a href="#method-retry">retry</a>
        <a href="#method-session">session</a>
        <a href="#method-tap">tap</a>
        <a href="#method-throw-if">throw_if</a>
        <a href="#method-throw-unless">throw_unless</a>
        <a href="#method-today">today</a>
        <a href="#method-trait-uses-recursive">trait_uses_recursive</a>
        <a href="#method-transform">transform</a>
        <a href="#method-validator">validator</a>
        <a href="#method-value">value</a>
        <a href="#method-view">view</a>
        <a href="#method-with">with</a></p>
</div>
<p></p>
<h2 id="method-listing"><a href="#method-listing">Список методов <sup>Method listing</sup></a></h2>
<style>
    #collection-method code {
        font-size: 14px;
    }

    #collection-method:not(.first-collection-method) {
        margin-top: 50px;
    }
</style>
<p></p>
<h2 id="arrays"><a href="#arrays">Массивы и объекты <sup>Arrays & Objects</sup></a></h2>
<p></p>
<h4 id="method-array-accessible" class="first-collection-method"><a href="#method-array-accessible"><code>Arr::accessible()</code></a></h4>
<p><code>Arr::accessible</code> Метод определяет, является ли данное значение массива доступны:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Collection</span><span class="token punctuation">;</span>

<span class="token variable">$isAccessible</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">accessible</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'a'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">1</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'b'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">2</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// true</span>

<span class="token variable">$isAccessible</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">accessible</span><span
                class="token punctuation">(</span><span class="token keyword">new</span> <span class="token class-name">Collection</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// true</span>

<span class="token variable">$isAccessible</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">accessible</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'abc'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// false</span>

<span class="token variable">$isAccessible</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">accessible</span><span
                class="token punctuation">(</span><span class="token keyword">new</span> <span class="token class-name">stdClass</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// false</span></code></pre>
<p></p>
<h4 id="method-array-add"><a href="#method-array-add"><code>Arr::add()</code></a></h4>
<p><code>Arr::add</code> Метод добавляет заданный ключ / значение пары в массив, если данный ключ не существует в
    массиве или установлен в <code>null</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token variable">$array</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">add</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Desk'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'price'</span><span class="token punctuation">,</span> <span
                class="token number">100</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['name' =&gt; 'Desk', 'price' =&gt; 100]</span>

<span class="token variable">$array</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">add</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Desk'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'price'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token constant">null</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'price'</span><span class="token punctuation">,</span> <span
                class="token number">100</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['name' =&gt; 'Desk', 'price' =&gt; 100]</span></code></pre>
<p></p>
<h4 id="method-array-collapse"><a href="#method-array-collapse"><code>Arr::collapse()</code></a></h4>
<p><code>Arr::collapse</code> Метод разрушается массив массивов в один массив:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token variable">$array</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">collapse</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token punctuation">[</span><span class="token number">1</span><span
                class="token punctuation">,</span> <span class="token number">2</span><span
                class="token punctuation">,</span> <span class="token number">3</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span><span class="token number">4</span><span
                class="token punctuation">,</span> <span class="token number">5</span><span
                class="token punctuation">,</span> <span class="token number">6</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span><span class="token number">7</span><span
                class="token punctuation">,</span> <span class="token number">8</span><span
                class="token punctuation">,</span> <span class="token number">9</span><span
                class="token punctuation">]</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// [1, 2, 3, 4, 5, 6, 7, 8, 9]</span></code></pre>
<p></p>
<h4 id="method-array-crossjoin"><a href="#method-array-crossjoin"><code>Arr::crossJoin()</code></a></h4>
<p><code>Arr::crossJoin</code> Крест метод соединяет данные массивы, возвращая декартово произведение всех возможных
    перестановок:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token variable">$matrix</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">crossJoin</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'a'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'b'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">/*
    [
        [1, 'a'],
        [1, 'b'],
        [2, 'a'],
        [2, 'b'],
    ]
*/</span>

<span class="token variable">$matrix</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">crossJoin</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'a'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'b'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'I'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'II'</span><span class="token punctuation">]</span><span
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
<h4 id="method-array-divide"><a href="#method-array-divide"><code>Arr::divide()</code></a></h4>
<p><code>Arr::divide</code> Метод возвращает два массива: один, содержащие ключи и другие, содержащее значение данного
    массива:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token punctuation">[</span><span class="token variable">$keys</span><span
                class="token punctuation">,</span> <span class="token variable">$values</span><span
                class="token punctuation">]</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">divide</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Desk'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// $keys: ['name']</span>

<span class="token comment">// $values: ['Desk']</span></code></pre>
<p></p>
<h4 id="method-array-dot"><a href="#method-array-dot"><code>Arr::dot()</code></a></h4>
<p><code>Arr::dot</code> Метод сглаживает многомерный массив в массив одного уровня, который использует «точку»
    обозначения для указания глубины:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token variable">$array</span> <span class="token operator">=</span> <span
                class="token punctuation">[</span><span
                class="token single-quoted-string string">'products'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'desk'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">100</span><span class="token punctuation">]</span><span
                class="token punctuation">]</span><span class="token punctuation">]</span><span
                class="token punctuation">;</span>

<span class="token variable">$flattened</span> <span class="token operator">=</span> Arr<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">dot</span><span
                class="token punctuation">(</span><span class="token variable">$array</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// ['products.desk.price' =&gt; 100]</span></code></pre>
<p></p>
<h4 id="method-array-except"><a href="#method-array-except"><code>Arr::except()</code></a></h4>
<p><code>Arr::except</code> Метод удаляет заданные пары ключ / значение из массива:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token variable">$array</span> <span class="token operator">=</span> <span
                class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Desk'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">100</span><span class="token punctuation">]</span><span
                class="token punctuation">;</span>

<span class="token variable">$filtered</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">except</span><span
                class="token punctuation">(</span><span class="token variable">$array</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'price'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// ['name' =&gt; 'Desk']</span></code></pre>
<p></p>
<h4 id="method-array-exists"><a href="#method-array-exists"><code>Arr::exists()</code></a></h4>
<p>В <code>Arr::exists</code> методе проверяет, что данный ключ существует в предоставленном массиве:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token variable">$array</span> <span class="token operator">=</span> <span
                class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'John Doe'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'age'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">17</span><span class="token punctuation">]</span><span
                class="token punctuation">;</span>

<span class="token variable">$exists</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">exists</span><span
                class="token punctuation">(</span><span class="token variable">$array</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// true</span>

<span class="token variable">$exists</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">exists</span><span
                class="token punctuation">(</span><span class="token variable">$array</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'salary'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// false</span></code></pre>
<p></p>
<h4 id="method-array-first"><a href="#method-array-first"><code>Arr::first()</code></a></h4>
<p><code>Arr::first</code> Метод возвращает первый элемент массива прохождения испытания данной истины:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token variable">$array</span> <span class="token operator">=</span> <span
                class="token punctuation">[</span><span class="token number">100</span><span
                class="token punctuation">,</span> <span class="token number">200</span><span class="token punctuation">,</span> <span
                class="token number">300</span><span class="token punctuation">]</span><span
                class="token punctuation">;</span>

<span class="token variable">$first</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">first</span><span
                class="token punctuation">(</span><span class="token variable">$array</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$value</span><span
                class="token punctuation">,</span> <span class="token variable">$key</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> <span class="token variable">$value</span> <span
                class="token operator">&gt;=</span> <span class="token number">150</span><span
                class="token punctuation">;</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// 200</span></code></pre>
<p>Значение по умолчанию также может быть передано в метод в качестве третьего параметра. Это значение будет возвращено,
    если ни одно значение не прошло проверку истинности:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token variable">$first</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">first</span><span
                class="token punctuation">(</span><span class="token variable">$array</span><span
                class="token punctuation">,</span> <span class="token variable">$callback</span><span
                class="token punctuation">,</span> <span class="token variable">$default</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-array-flatten"><a href="#method-array-flatten"><code>Arr::flatten()</code></a></h4>
<p><code>Arr::flatten</code> Метод сглаживает многомерный массив в массив одного уровня:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token variable">$array</span> <span class="token operator">=</span> <span
                class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Joe'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'languages'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'PHP'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Ruby'</span><span class="token punctuation">]</span><span
                class="token punctuation">]</span><span class="token punctuation">;</span>

<span class="token variable">$flattened</span> <span class="token operator">=</span> Arr<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">flatten</span><span
                class="token punctuation">(</span><span class="token variable">$array</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// ['Joe', 'PHP', 'Ruby']</span></code></pre>
<p></p>
<h4 id="method-array-forget"><a href="#method-array-forget"><code>Arr::forget()</code></a></h4>
<p><code>Arr::forget</code> Метод удаляет пару заданный ключ / значение из глубоко вложенного массива с помощью «точка»
    обозначения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token variable">$array</span> <span class="token operator">=</span> <span
                class="token punctuation">[</span><span
                class="token single-quoted-string string">'products'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'desk'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">100</span><span class="token punctuation">]</span><span
                class="token punctuation">]</span><span class="token punctuation">]</span><span
                class="token punctuation">;</span>

Arr<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">forget</span><span class="token punctuation">(</span><span
                class="token variable">$array</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'products.desk'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['products' =&gt; []]</span></code></pre>
<p></p>
<h4 id="method-array-get"><a href="#method-array-get"><code>Arr::get()</code></a></h4>
<p><code>Arr::get</code> Метод извлекает значение из глубоко вложенного массива с помощью «точки» обозначений:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token variable">$array</span> <span class="token operator">=</span> <span
                class="token punctuation">[</span><span
                class="token single-quoted-string string">'products'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'desk'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">100</span><span class="token punctuation">]</span><span
                class="token punctuation">]</span><span class="token punctuation">]</span><span
                class="token punctuation">;</span>

<span class="token variable">$price</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token variable">$array</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'products.desk.price'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 100</span></code></pre>
<p><code>Arr::get</code> Метод также принимает значение по умолчанию, который будет возвращен, если указанный ключ не
    присутствует в массиве:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token variable">$discount</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token variable">$array</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'products.desk.discount'</span><span
                class="token punctuation">,</span> <span class="token number">0</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 0</span></code></pre>
<p></p>
<h4 id="method-array-has"><a href="#method-array-has"><code>Arr::has()</code></a></h4>
<p>В <code>Arr::has</code> методе проверяет, существует ли заданный элемент или элементы в массиве с использованием
    «точка» обозначения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token variable">$array</span> <span class="token operator">=</span> <span
                class="token punctuation">[</span><span class="token single-quoted-string string">'product'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Desk'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'price'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">100</span><span class="token punctuation">]</span><span
                class="token punctuation">]</span><span class="token punctuation">;</span>

<span class="token variable">$contains</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">has</span><span
                class="token punctuation">(</span><span class="token variable">$array</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'product.name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// true</span>

<span class="token variable">$contains</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">has</span><span
                class="token punctuation">(</span><span class="token variable">$array</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'product.price'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'product.discount'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// false</span></code></pre>
<p></p>
<h4 id="method-array-hasany"><a href="#method-array-hasany"><code>Arr::hasAny()</code></a></h4>
<p>В <code>Arr::hasAny</code> методе проверяет, существует ли какой - либо элемент в заданном наборе в массиве с
    использованием «точка» обозначения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token variable">$array</span> <span class="token operator">=</span> <span
                class="token punctuation">[</span><span class="token single-quoted-string string">'product'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Desk'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'price'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">100</span><span class="token punctuation">]</span><span
                class="token punctuation">]</span><span class="token punctuation">;</span>

<span class="token variable">$contains</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">hasAny</span><span
                class="token punctuation">(</span><span class="token variable">$array</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'product.name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// true</span>

<span class="token variable">$contains</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">hasAny</span><span
                class="token punctuation">(</span><span class="token variable">$array</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'product.name'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'product.discount'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// true</span>

<span class="token variable">$contains</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">hasAny</span><span
                class="token punctuation">(</span><span class="token variable">$array</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'category'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'product.discount'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// false</span></code></pre>
<p></p>
<h4 id="method-array-isassoc"><a href="#method-array-isassoc"><code>Arr::isAssoc()</code></a></h4>
<p>В <code>Arr::isAssoc</code> возвращается, <code>true</code> если данный массив является ассоциативным массивом.
    Массив считается ассоциативным, если в нем нет последовательных цифровых ключей, начинающихся с нуля:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token variable">$isAssoc</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">isAssoc</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'product'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Desk'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'price'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">100</span><span class="token punctuation">]</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// true</span>

<span class="token variable">$isAssoc</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">isAssoc</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// false</span></code></pre>
<p></p>
<h4 id="method-array-last"><a href="#method-array-last"><code>Arr::last()</code></a></h4>
<p><code>Arr::last</code> Метод возвращает последний элемент массива, проходящего тест данной истины:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token variable">$array</span> <span class="token operator">=</span> <span
                class="token punctuation">[</span><span class="token number">100</span><span
                class="token punctuation">,</span> <span class="token number">200</span><span class="token punctuation">,</span> <span
                class="token number">300</span><span class="token punctuation">,</span> <span
                class="token number">110</span><span class="token punctuation">]</span><span
                class="token punctuation">;</span>

<span class="token variable">$last</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">last</span><span
                class="token punctuation">(</span><span class="token variable">$array</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$value</span><span
                class="token punctuation">,</span> <span class="token variable">$key</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> <span class="token variable">$value</span> <span
                class="token operator">&gt;=</span> <span class="token number">150</span><span
                class="token punctuation">;</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// 300</span></code></pre>
<p>В качестве третьего аргумента метода может быть передано значение по умолчанию. Это значение будет возвращено, если
    ни одно значение не прошло проверку истинности:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token variable">$last</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">last</span><span
                class="token punctuation">(</span><span class="token variable">$array</span><span
                class="token punctuation">,</span> <span class="token variable">$callback</span><span
                class="token punctuation">,</span> <span class="token variable">$default</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-array-only"><a href="#method-array-only"><code>Arr::only()</code></a></h4>
<p>В <code>Arr::only</code> метод возвращает только указанные пары ключ / значение из заданного массива:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token variable">$array</span> <span class="token operator">=</span> <span
                class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Desk'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">100</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'orders'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">10</span><span
                class="token punctuation">]</span><span class="token punctuation">;</span>

<span class="token variable">$slice</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">only</span><span
                class="token punctuation">(</span><span class="token variable">$array</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'name'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'price'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// ['name' =&gt; 'Desk', 'price' =&gt; 100]</span></code></pre>
<p></p>
<h4 id="method-array-pluck"><a href="#method-array-pluck"><code>Arr::pluck()</code></a></h4>
<p><code>Arr::pluck</code> Метод извлекает все значения для данного ключа из массива:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token variable">$array</span> <span class="token operator">=</span> <span
                class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'developer'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">1</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Taylor'</span><span class="token punctuation">]</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'developer'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">2</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Abigail'</span><span class="token punctuation">]</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">;</span>

<span class="token variable">$names</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">pluck</span><span
                class="token punctuation">(</span><span class="token variable">$array</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'developer.name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// ['Taylor', 'Abigail']</span></code></pre>
<p>Вы также можете указать, как вы хотите, чтобы результирующий список был привязан:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token variable">$names</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">pluck</span><span
                class="token punctuation">(</span><span class="token variable">$array</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'developer.name'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'developer.id'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// [1 =&gt; 'Taylor', 2 =&gt; 'Abigail']</span></code></pre>
<p></p>
<h4 id="method-array-prepend"><a href="#method-array-prepend"><code>Arr::prepend()</code></a></h4>
<p><code>Arr::prepend</code> Метод будет толкать элемент на начало массива:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token variable">$array</span> <span class="token operator">=</span> <span
                class="token punctuation">[</span><span class="token single-quoted-string string">'one'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'two'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'three'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'four'</span><span
                class="token punctuation">]</span><span class="token punctuation">;</span>

<span class="token variable">$array</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">prepend</span><span
                class="token punctuation">(</span><span class="token variable">$array</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'zero'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// ['zero', 'one', 'two', 'three', 'four']</span></code></pre>
<p>При необходимости вы можете указать ключ, который следует использовать для значения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token variable">$array</span> <span class="token operator">=</span> <span
                class="token punctuation">[</span><span class="token single-quoted-string string">'price'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">100</span><span class="token punctuation">]</span><span
                class="token punctuation">;</span>

<span class="token variable">$array</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">prepend</span><span
                class="token punctuation">(</span><span class="token variable">$array</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'Desk'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// ['name' =&gt; 'Desk', 'price' =&gt; 100]</span></code></pre>
<p></p>
<h4 id="method-array-pull"><a href="#method-array-pull"><code>Arr::pull()</code></a></h4>
<p>В <code>Arr::pull</code> метод возвращает и удаляет пару ключ / значение из массива:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token variable">$array</span> <span class="token operator">=</span> <span
                class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Desk'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">100</span><span class="token punctuation">]</span><span
                class="token punctuation">;</span>

<span class="token variable">$name</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">pull</span><span
                class="token punctuation">(</span><span class="token variable">$array</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// $name: Desk</span>

<span class="token comment">// $array: ['price' =&gt; 100]</span></code></pre>
<p>В качестве третьего аргумента метода может быть передано значение по умолчанию. Это значение будет возвращено, если
    ключ не существует:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token variable">$value</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">pull</span><span
                class="token punctuation">(</span><span class="token variable">$array</span><span
                class="token punctuation">,</span> <span class="token variable">$key</span><span
                class="token punctuation">,</span> <span class="token variable">$default</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-array-query"><a href="#method-array-query"><code>Arr::query()</code></a></h4>
<p><code>Arr::query</code> Метод преобразует массив в строку запроса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token variable">$array</span> <span class="token operator">=</span> <span
                class="token punctuation">[</span>
    <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Taylor'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'order'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'column'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'created_at'</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'direction'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'desc'</span>
    <span class="token punctuation">]</span>
<span class="token punctuation">]</span><span class="token punctuation">;</span>

Arr<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">query</span><span class="token punctuation">(</span><span class="token variable">$array</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// name=Taylor&amp;order[column]=created_at&amp;order[direction]=desc</span></code></pre>
<p></p>
<h4 id="method-array-random"><a href="#method-array-random"><code>Arr::random()</code></a></h4>
<p><code>Arr::random</code> Метод возвращает случайное значение из массива:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token variable">$array</span> <span class="token operator">=</span> <span
                class="token punctuation">[</span><span class="token number">1</span><span
                class="token punctuation">,</span> <span class="token number">2</span><span
                class="token punctuation">,</span> <span class="token number">3</span><span
                class="token punctuation">,</span> <span class="token number">4</span><span
                class="token punctuation">,</span> <span class="token number">5</span><span
                class="token punctuation">]</span><span class="token punctuation">;</span>

<span class="token variable">$random</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">random</span><span
                class="token punctuation">(</span><span class="token variable">$array</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 4 - (retrieved randomly)</span></code></pre>
<p>Вы также можете указать количество возвращаемых элементов в качестве необязательного второго аргумента. Обратите
    внимание, что предоставление этого аргумента вернет массив, даже если требуется только один элемент:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token variable">$items</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">random</span><span
                class="token punctuation">(</span><span class="token variable">$array</span><span
                class="token punctuation">,</span> <span class="token number">2</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// [2, 5] - (retrieved randomly)</span></code></pre>
<p></p>
<h4 id="method-array-set"><a href="#method-array-set"><code>Arr::set()</code></a></h4>
<p><code>Arr::set</code> Метод устанавливает значение в пределах глубоко вложенный массива с помощью «точки»
    обозначений:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token variable">$array</span> <span class="token operator">=</span> <span
                class="token punctuation">[</span><span
                class="token single-quoted-string string">'products'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'desk'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">100</span><span class="token punctuation">]</span><span
                class="token punctuation">]</span><span class="token punctuation">]</span><span
                class="token punctuation">;</span>

Arr<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">set</span><span class="token punctuation">(</span><span class="token variable">$array</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'products.desk.price'</span><span
                class="token punctuation">,</span> <span class="token number">200</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['products' =&gt; ['desk' =&gt; ['price' =&gt; 200]]]</span></code></pre>
<p></p>
<h4 id="method-array-shuffle"><a href="#method-array-shuffle"><code>Arr::shuffle()</code></a></h4>
<p><code>Arr::shuffle</code> Метод случайным образом перемешивает элементы в массиве:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token variable">$array</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">shuffle</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">,</span> <span
                class="token number">4</span><span class="token punctuation">,</span> <span
                class="token number">5</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// [3, 2, 5, 1, 4] - (generated randomly)</span></code></pre>
<p></p>
<h4 id="method-array-sort"><a href="#method-array-sort"><code>Arr::sort()</code></a></h4>
<p><code>Arr::sort</code> Метод сортирует массив по его значению:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token variable">$array</span> <span class="token operator">=</span> <span
                class="token punctuation">[</span><span class="token single-quoted-string string">'Desk'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'Table'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'Chair'</span><span
                class="token punctuation">]</span><span class="token punctuation">;</span>

<span class="token variable">$sorted</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">sort</span><span
                class="token punctuation">(</span><span class="token variable">$array</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// ['Chair', 'Desk', 'Table']</span></code></pre>
<p>Вы также можете отсортировать массив по результатам данного закрытия:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token variable">$array</span> <span class="token operator">=</span> <span
                class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Desk'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Table'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Chair'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">;</span>

<span class="token variable">$sorted</span> <span class="token operator">=</span> <span class="token function">array_values</span><span
                class="token punctuation">(</span>Arr<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">sort</span><span
                class="token punctuation">(</span><span class="token variable">$array</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$value</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> <span class="token variable">$value</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">]</span><span class="token punctuation">;</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">/*
    [
        ['name' =&gt; 'Chair'],
        ['name' =&gt; 'Desk'],
        ['name' =&gt; 'Table'],
    ]
*/</span></code></pre>
<p></p>
<h4 id="method-array-sort-recursive"><a href="#method-array-sort-recursive"><code>Arr::sortRecursive()</code></a></h4>
<p><code>Arr::sortRecursive</code> Метод рекурсивно сортирует массив, используя <code>sort</code> функцию численно
    индексированных подмассивов и <code>ksort</code> функцию ассоциативных подмассивов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token variable">$array</span> <span class="token operator">=</span> <span
                class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'Roman'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'Taylor'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'Li'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'PHP'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'Ruby'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'JavaScript'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'one'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'two'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">2</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'three'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">3</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">;</span>

<span class="token variable">$sorted</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">sortRecursive</span><span
                class="token punctuation">(</span><span class="token variable">$array</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">/*
    [
        ['JavaScript', 'PHP', 'Ruby'],
        ['one' =&gt; 1, 'three' =&gt; 3, 'two' =&gt; 2],
        ['Li', 'Roman', 'Taylor'],
    ]
*/</span></code></pre>
<p></p>
<h4 id="method-array-where"><a href="#method-array-where"><code>Arr::where()</code></a></h4>
<p><code>Arr::where</code> Метод фильтрует массив, используя данное окончание:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token variable">$array</span> <span class="token operator">=</span> <span
                class="token punctuation">[</span><span class="token number">100</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'200'</span><span
                class="token punctuation">,</span> <span class="token number">300</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'400'</span><span class="token punctuation">,</span> <span
                class="token number">500</span><span class="token punctuation">]</span><span
                class="token punctuation">;</span>

<span class="token variable">$filtered</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token variable">$array</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$value</span><span
                class="token punctuation">,</span> <span class="token variable">$key</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> <span class="token function">is_string</span><span
                class="token punctuation">(</span><span class="token variable">$value</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// [1 =&gt; '200', 3 =&gt; '400']</span></code></pre>
<p></p>
<h4 id="method-array-wrap"><a href="#method-array-wrap"><code>Arr::wrap()</code></a></h4>
<p><code>Arr::wrap</code> Метод обертывания заданного значения в массиве. Если данное значение уже является массивом,
    оно будет возвращено без изменений:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token variable">$string</span> <span class="token operator">=</span> <span
                class="token single-quoted-string string">'Laravel'</span><span class="token punctuation">;</span>

<span class="token variable">$array</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">wrap</span><span
                class="token punctuation">(</span><span class="token variable">$string</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// ['Laravel']</span></code></pre>
<p>Если заданное значение равно <code>null</code>, будет возвращен пустой массив:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Arr</span><span class="token punctuation">;</span>

<span class="token variable">$array</span> <span class="token operator">=</span> Arr<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">wrap</span><span
                class="token punctuation">(</span><span class="token constant">null</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// []</span></code></pre>
<p></p>
<h4 id="method-data-fill"><a href="#method-data-fill"><code>data_fill()</code></a></h4>
<p>В <code>data_fill</code> функции устанавливает отсутствующее значение в пределах вложенного массива или объекта с
    помощью «точки» обозначений:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$data</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'products'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'desk'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">100</span><span class="token punctuation">]</span><span
                class="token punctuation">]</span><span class="token punctuation">]</span><span
                class="token punctuation">;</span>

<span class="token function">data_fill</span><span class="token punctuation">(</span><span
                class="token variable">$data</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'products.desk.price'</span><span
                class="token punctuation">,</span> <span class="token number">200</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['products' =&gt; ['desk' =&gt; ['price' =&gt; 100]]]</span>

<span class="token function">data_fill</span><span class="token punctuation">(</span><span
                class="token variable">$data</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'products.desk.discount'</span><span
                class="token punctuation">,</span> <span class="token number">10</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// ['products' =&gt; ['desk' =&gt; ['price' =&gt; 100, 'discount' =&gt; 10]]]</span></code></pre>
<p>Эта функция также принимает звездочки в качестве подстановочных знаков и соответствующим образом заполняет цель:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$data</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'products'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Desk 1'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">100</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
        <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Desk 2'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">;</span>

<span class="token function">data_fill</span><span class="token punctuation">(</span><span
                class="token variable">$data</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'products.*.price'</span><span
                class="token punctuation">,</span> <span class="token number">200</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">/*
    [
        'products' =&gt; [
            ['name' =&gt; 'Desk 1', 'price' =&gt; 100],
            ['name' =&gt; 'Desk 2', 'price' =&gt; 200],
        ],
    ]
*/</span></code></pre>
<p></p>
<h4 id="method-data-get"><a href="#method-data-get"><code>data_get()</code></a></h4>
<p><code>data_get</code> Функция извлекает значение из вложенного массива или объекта с помощью «точки» обозначений:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$data</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'products'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'desk'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">100</span><span class="token punctuation">]</span><span
                class="token punctuation">]</span><span class="token punctuation">]</span><span
                class="token punctuation">;</span>

<span class="token variable">$price</span> <span class="token operator">=</span> <span
                class="token function">data_get</span><span class="token punctuation">(</span><span
                class="token variable">$data</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'products.desk.price'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 100</span></code></pre>
<p><code>data_get</code> Функция также принимает значение по умолчанию, который будет возвращен, если указанный ключ не
    найден:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$discount</span> <span
                class="token operator">=</span> <span class="token function">data_get</span><span
                class="token punctuation">(</span><span class="token variable">$data</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'products.desk.discount'</span><span
                class="token punctuation">,</span> <span class="token number">0</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 0</span></code></pre>
<p>Функция также принимает подстановочные знаки с использованием звездочек, которые могут указывать на любой ключ
    массива или объекта:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$data</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'product-one'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Desk 1'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'price'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">100</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'product-two'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Desk 2'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'price'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">150</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">;</span>

<span class="token function">data_get</span><span class="token punctuation">(</span><span
                class="token variable">$data</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'*.name'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['Desk 1', 'Desk 2'];</span></code></pre>
<p></p>
<h4 id="method-data-set"><a href="#method-data-set"><code>data_set()</code></a></h4>
<p><code>data_set</code> Функция устанавливает значение в пределах вложенного массива или объекта с помощью «точки»
    обозначений:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$data</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'products'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'desk'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">100</span><span class="token punctuation">]</span><span
                class="token punctuation">]</span><span class="token punctuation">]</span><span
                class="token punctuation">;</span>

<span class="token function">data_set</span><span class="token punctuation">(</span><span
                class="token variable">$data</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'products.desk.price'</span><span
                class="token punctuation">,</span> <span class="token number">200</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['products' =&gt; ['desk' =&gt; ['price' =&gt; 200]]]</span></code></pre>
<p>Эта функция также принимает подстановочные знаки, использующие звездочки, и соответственно устанавливает значения для
    цели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$data</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'products'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Desk 1'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">100</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
        <span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Desk 2'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">150</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">;</span>

<span class="token function">data_set</span><span class="token punctuation">(</span><span
                class="token variable">$data</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'products.*.price'</span><span
                class="token punctuation">,</span> <span class="token number">200</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">/*
    [
        'products' =&gt; [
            ['name' =&gt; 'Desk 1', 'price' =&gt; 200],
            ['name' =&gt; 'Desk 2', 'price' =&gt; 200],
        ],
    ]
*/</span></code></pre>
<p>По умолчанию все существующие значения перезаписываются. Если вы хотите установить значение только в том случае, если
    оно не существует, вы можете передать <code>false</code> в качестве четвертого аргумента функции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$data</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'products'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'desk'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'price'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">100</span><span class="token punctuation">]</span><span
                class="token punctuation">]</span><span class="token punctuation">]</span><span
                class="token punctuation">;</span>

<span class="token function">data_set</span><span class="token punctuation">(</span><span
                class="token variable">$data</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'products.desk.price'</span><span
                class="token punctuation">,</span> <span class="token number">200</span><span class="token punctuation">,</span> <span
                class="token variable">$overwrite</span> <span class="token operator">=</span> <span
                class="token boolean constant">false</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// ['products' =&gt; ['desk' =&gt; ['price' =&gt; 100]]]</span></code></pre>
<p></p>
<h4 id="method-head"><a href="#method-head"><code>head()</code></a></h4>
<p><code>head</code> Функция возвращает первый элемент данного массива:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$array</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span><span
                class="token number">100</span><span class="token punctuation">,</span> <span
                class="token number">200</span><span class="token punctuation">,</span> <span
                class="token number">300</span><span class="token punctuation">]</span><span
                class="token punctuation">;</span>

<span class="token variable">$first</span> <span class="token operator">=</span> <span
                class="token function">head</span><span class="token punctuation">(</span><span class="token variable">$array</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 100</span></code></pre>
<p></p>
<h4 id="method-last"><a href="#method-last"><code>last()</code></a></h4>
<p><code>last</code> Функция возвращает последний элемент в данном массиве:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$array</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span><span
                class="token number">100</span><span class="token punctuation">,</span> <span
                class="token number">200</span><span class="token punctuation">,</span> <span
                class="token number">300</span><span class="token punctuation">]</span><span
                class="token punctuation">;</span>

<span class="token variable">$last</span> <span class="token operator">=</span> <span class="token function">last</span><span
                class="token punctuation">(</span><span class="token variable">$array</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 300</span></code></pre>
<p></p>
<h2 id="paths"><a href="#paths">Пути <sup>Paths</sup></a></h2>
<p></p>
<h4 id="method-app-path"><a href="#method-app-path"><code>app_path()</code></a></h4>
<p><code>app_path</code> Функция возвращает полный путь к приложению в <code>app</code> каталоге. Вы также можете
    использовать эту <code>app_path</code> функцию для создания полного пути к файлу относительно каталога приложения:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$path</span> <span
                class="token operator">=</span> <span class="token function">app_path</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$path</span> <span class="token operator">=</span> <span
                class="token function">app_path</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Http/Controllers/Controller.php'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-base-path"><a href="#method-base-path"><code>base_path()</code></a></h4>
<p><code>base_path</code> Функция возвращает полный путь к корневой директории вашего приложения. Вы также можете
    использовать эту <code>base_path</code> функцию для создания полного пути к заданному файлу относительно корневого
    каталога проекта:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$path</span> <span
                class="token operator">=</span> <span class="token function">base_path</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$path</span> <span class="token operator">=</span> <span
                class="token function">base_path</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'vendor/bin'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-config-path"><a href="#method-config-path"><code>config_path()</code></a></h4>
<p><code>config_path</code> Функция возвращает полный путь к приложению в <code>config</code> каталоге. Вы также можете
    использовать эту <code>config_path</code> функцию для создания полного пути к заданному файлу в каталоге
    конфигурации приложения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$path</span> <span
                class="token operator">=</span> <span class="token function">config_path</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$path</span> <span class="token operator">=</span> <span
                class="token function">config_path</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'app.php'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-database-path"><a href="#method-database-path"><code>database_path()</code></a></h4>
<p><code>database_path</code> Функция возвращает полный путь к приложению в <code>database</code> каталоге. Вы также
    можете использовать эту <code>database_path</code> функцию для создания полного пути к заданному файлу в каталоге
    базы данных:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$path</span> <span
                class="token operator">=</span> <span class="token function">database_path</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$path</span> <span class="token operator">=</span> <span class="token function">database_path</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'factories/UserFactory.php'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-mix"><a href="#method-mix"><code>mix()</code></a></h4>
<p><code>mix</code> Функция возвращает путь к <a href="mix">версированному файлу Mix</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$path</span> <span
                class="token operator">=</span> <span class="token function">mix</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'css/app.css'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-public-path"><a href="#method-public-path"><code>public_path()</code></a></h4>
<p><code>public_path</code> Функция возвращает полный путь к приложению в <code>public</code> каталоге. Вы также можете
    использовать эту <code>public_path</code> функцию для создания полного пути к данному файлу в общедоступном
    каталоге:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$path</span> <span
                class="token operator">=</span> <span class="token function">public_path</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$path</span> <span class="token operator">=</span> <span
                class="token function">public_path</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'css/app.css'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-resource-path"><a href="#method-resource-path"><code>resource_path()</code></a></h4>
<p><code>resource_path</code> Функция возвращает полный путь к приложению в <code>resources</code> каталоге. Вы также
    можете использовать эту <code>resource_path</code> функцию для создания полного пути к заданному файлу в каталоге
    ресурсов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$path</span> <span
                class="token operator">=</span> <span class="token function">resource_path</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$path</span> <span class="token operator">=</span> <span class="token function">resource_path</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'sass/app.scss'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-storage-path"><a href="#method-storage-path"><code>storage_path()</code></a></h4>
<p><code>storage_path</code> Функция возвращает полный путь к приложению в <code>storage</code> каталоге. Вы также
    можете использовать эту <code>storage_path</code> функцию для создания полного пути к заданному файлу в каталоге
    хранилища:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$path</span> <span
                class="token operator">=</span> <span class="token function">storage_path</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$path</span> <span class="token operator">=</span> <span class="token function">storage_path</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'app/file.txt'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="strings"><a href="#strings">Строки <sup>Strings</sup></a></h2>
<p></p>
<h4 id="method-__"><a href="#method-__"><code>__()</code></a></h4>
<p><code>__</code> Функция переводит данную строку перевода или клавишу перевода, используя ваши <a href="localization">файлы
        локализации</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">echo</span> <span
                class="token function">__</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Welcome to our application'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">echo</span> <span class="token function">__</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'messages.welcome'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если указанная строка перевода или ключ не существует, <code>__</code> функция вернет заданное значение. Итак,
    используя приведенный выше пример, <code>__</code> функция вернется, <code>messages.welcome</code> если этот ключ
    перевода не существует.</p>
<p></p>
<h4 id="method-class-basename"><a href="#method-class-basename"><code>class_basename()</code></a></h4>
<p><code>class_basename</code> Функция возвращает имя класса данного класса с пространством имен класса удалены:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$class</span> <span
                class="token operator">=</span> <span class="token function">class_basename</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'Foo\Bar\Baz'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// Baz</span></code></pre>
<p></p>
<h4 id="method-e"><a href="#method-e"><code>e()</code></a></h4>
<p><code>e</code> Функция работает в PHP <code>htmlspecialchars</code> функцию с <code>double_encode</code> параметром,
    установленным на <code>true</code> по умолчанию:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">echo</span> <span
                class="token function">e</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'&lt;html&gt;foo&lt;/html&gt;'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// &amp;lt;html&amp;gt;foo&amp;lt;/html&amp;gt;</span></code></pre>
<p></p>
<h4 id="method-preg-replace-array"><a href="#method-preg-replace-array"><code>preg_replace_array()</code></a></h4>
<p><code>preg_replace_array</code> Функция заменяет заданный шаблон в строке последовательно используя массив:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$string</span> <span
                class="token operator">=</span> <span class="token single-quoted-string string">'The event will take place between:start and:end'</span><span
                class="token punctuation">;</span>

<span class="token variable">$replaced</span> <span class="token operator">=</span> <span class="token function">preg_replace_array</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'/:[a-z_]+/'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'8:30'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'9:00'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span> <span class="token variable">$string</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// The event will take place between 8:30 and 9:00</span></code></pre>
<p></p>
<h4 id="method-str-after"><a href="#method-str-after"><code>Str::after()</code></a></h4>
<p><code>Str::after</code> Метод возвращает все после заданного значения в строке. Вся строка будет возвращена, если
    значение не существует в строке:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$slice</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">after</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'This is my name'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'This is'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// ' my name'</span></code></pre>
<p></p>
<h4 id="method-str-after-last"><a href="#method-str-after-last"><code>Str::afterLast()</code></a></h4>
<p><code>Str::afterLast</code> Метод возвращает все после последнего вхождения заданного значения в строке. Вся строка
    будет возвращена, если значение не существует в строке:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$slice</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">afterLast</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'App\Http\Controllers\Controller'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'\\'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 'Controller'</span></code></pre>
<p></p>
<h4 id="method-str-ascii"><a href="#method-str-ascii"><code>Str::ascii()</code></a></h4>
<p><code>Str::ascii</code> Метод будет пытаться транслитерировать строку в значение ASCII:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$slice</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">ascii</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'û'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 'u'</span></code></pre>
<p></p>
<h4 id="method-str-before"><a href="#method-str-before"><code>Str::before()</code></a></h4>
<p><code>Str::before</code> Метод возвращает все до заданного значения в строке:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$slice</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">before</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'This is my name'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'my name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 'This is '</span></code></pre>
<p></p>
<h4 id="method-str-before-last"><a href="#method-str-before-last"><code>Str::beforeLast()</code></a></h4>
<p><code>Str::beforeLast</code> Метод возвращает все до последнего вхождения заданного значения в строке:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$slice</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">beforeLast</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'This is my name'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'is'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 'This '</span></code></pre>
<p></p>
<h4 id="method-str-between"><a href="#method-str-between"><code>Str::between()</code></a></h4>
<p><code>Str::between</code> Метод возвращает часть строки между двумя значениями:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$slice</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">between</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'This is my name'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'This'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// ' is my '</span></code></pre>
<p></p>
<h4 id="method-camel-case"><a href="#method-camel-case"><code>Str::camel()</code></a></h4>
<p><code>Str::camel</code> Метод преобразует заданную строку <code>camelCase</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$converted</span> <span class="token operator">=</span> Str<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">camel</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'foo_bar'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// fooBar</span></code></pre>
<p></p>
<h4 id="method-str-contains"><a href="#method-str-contains"><code>Str::contains()</code></a></h4>
<p><code>Str::contains</code> Метод определяет, является ли данная строка содержит заданное значение. Этот метод
    чувствителен к регистру:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$contains</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">contains</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'This is my name'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'my'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// true</span></code></pre>
<p>Вы также можете передать массив значений, чтобы определить, содержит ли данная строка какое-либо из значений в
    массиве:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$contains</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">contains</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'This is my name'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'my'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'foo'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// true</span></code></pre>
<p></p>
<h4 id="method-str-contains-all"><a href="#method-str-contains-all"><code>Str::containsAll()</code></a></h4>
<p><code>Str::containsAll</code> Метод определяет, является ли данная строка содержит все значения в заданном массиве:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$containsAll</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">containsAll</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'This is my name'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'my'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'name'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// true</span></code></pre>
<p></p>
<h4 id="#method-ends-with"><a href="##method-ends-with"><code>Str::endsWith()</code></a></h4>
<p><code>Str::endsWith</code> Метод определяет, является ли данная строка концов с заданным значением:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$result</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">endsWith</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'This is my name'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// true</span></code></pre>
<p>Вы также можете передать массив значений, чтобы определить, заканчивается ли данная строка любым из значений в
    массиве:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$result</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">endsWith</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'This is my name'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'name'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'foo'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// true</span>

<span class="token variable">$result</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">endsWith</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'This is my name'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'this'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'foo'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// false</span></code></pre>
<p></p>
<h4 id="method-str-finish"><a href="#method-str-finish"><code>Str::finish()</code></a></h4>
<p><code>Str::finish</code> Метод добавляет один экземпляр данного значения в строку, если он уже не закончится с этим
    значением:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$adjusted</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">finish</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'this/string'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'/'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// this/string/</span>

<span class="token variable">$adjusted</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">finish</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'this/string/'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'/'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// this/string/</span></code></pre>
<p></p>
<h4 id="method-str-is"><a href="#method-str-is"><code>Str::is()</code></a></h4>
<p><code>Str::is</code> Метод определяет, является ли данная строка соответствует заданному шаблону. Звездочки могут
    использоваться в качестве значений подстановочных знаков:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$matches</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">is</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'foo*'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'foobar'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// true</span>

<span class="token variable">$matches</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">is</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'baz*'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'foobar'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// false</span></code></pre>
<p></p>
<h4 id="method-str-is-ascii"><a href="#method-str-is-ascii"><code>Str::isAscii()</code></a></h4>
<p><code>Str::isAscii</code> Метод определяет, является ли данная строка 7 бит ASCII:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$isAscii</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">isAscii</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Taylor'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// true</span>

<span class="token variable">$isAscii</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">isAscii</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'ü'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// false</span></code></pre>
<p></p>
<h4 id="method-str-is-uuid"><a href="#method-str-is-uuid"><code>Str::isUuid()</code></a></h4>
<p><code>Str::isUuid</code> Метод определяет, является ли данная строка является допустимым UUID:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$isUuid</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">isUuid</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'a0a2a2d2-0b87-4a18-83f2-2529882be2de'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// true</span>

<span class="token variable">$isUuid</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">isUuid</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'laravel'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// false</span></code></pre>
<p></p>
<h4 id="method-kebab-case"><a href="#method-kebab-case"><code>Str::kebab()</code></a></h4>
<p><code>Str::kebab</code> Метод преобразует заданную строку <code>kebab-case</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$converted</span> <span class="token operator">=</span> Str<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">kebab</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'fooBar'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// foo-bar</span></code></pre>
<p></p>
<h4 id="method-str-length"><a href="#method-str-length"><code>Str::length()</code></a></h4>
<p><code>Str::length</code> Метод возвращает длину заданной строки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$length</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">length</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Laravel'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 7</span></code></pre>
<p></p>
<h4 id="method-str-limit"><a href="#method-str-limit"><code>Str::limit()</code></a></h4>
<p><code>Str::limit</code> Метод обрезает данную строку заданной длины:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$truncated</span> <span class="token operator">=</span> Str<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">limit</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'The quick brown fox jumps over the lazy dog'</span><span
                class="token punctuation">,</span> <span class="token number">20</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// The quick brown fox...</span></code></pre>
<p>Вы можете передать третий аргумент методу, чтобы изменить строку, которая будет добавлена ​​в конец усеченной
    строки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$truncated</span> <span class="token operator">=</span> Str<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">limit</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'The quick brown fox jumps over the lazy dog'</span><span
                class="token punctuation">,</span> <span class="token number">20</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">' (...)'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// The quick brown fox (...)</span></code></pre>
<p></p>
<h4 id="method-str-lower"><a href="#method-str-lower"><code>Str::lower()</code></a></h4>
<p><code>Str::lower</code> Метод преобразует заданную строку в нижний регистр:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$converted</span> <span class="token operator">=</span> Str<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">lower</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'LARAVEL'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// laravel</span></code></pre>
<p></p>
<h4 id="method-str-markdown"><a href="#method-str-markdown"><code>Str::markdown()</code></a></h4>
<p>В этом <code>Str::markdown</code> методе преобразует GitHub приправленной Markdown в HTML:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$html</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">markdown</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'# Laravel'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// &lt;h1&gt;Laravel&lt;/h1&gt;</span>

<span class="token variable">$html</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">markdown</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'# Taylor &lt;b&gt;Otwell&lt;/b&gt;'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'html_input'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'strip'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// &lt;h1&gt;Taylor Otwell&lt;/h1&gt;</span></code></pre>
<p></p>
<h4 id="method-str-ordered-uuid"><a href="#method-str-ordered-uuid"><code>Str::orderedUuid()</code></a></h4>
<p>Этот <code>Str::orderedUuid</code> метод генерирует UUID «первая метка времени», который может эффективно храниться в
    индексированном столбце базы данных. Каждый UUID, созданный с помощью этого метода, будет отсортирован после UUID,
    ранее созданных с помощью этого метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token keyword">return</span> <span class="token punctuation">(</span>string<span class="token punctuation">)</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">orderedUuid</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-str-padboth"><a href="#method-str-padboth"><code>Str::padBoth()</code></a></h4>
<p><code>Str::padBoth</code> Метод обертывания в PHP <code>str_pad</code> функцию, дополняя обе стороны строки с другой
    строкой до конечной строки достигает желаемой длины:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$padded</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">padBoth</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'James'</span><span
                class="token punctuation">,</span> <span class="token number">10</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'_'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// '__James___'</span>

<span class="token variable">$padded</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">padBoth</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'James'</span><span
                class="token punctuation">,</span> <span class="token number">10</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// '  James   '</span></code></pre>
<p></p>
<h4 id="method-str-padleft"><a href="#method-str-padleft"><code>Str::padLeft()</code></a></h4>
<p><code>Str::padLeft</code> Метод обертывания РНР <code>str_pad</code> функцию, дополняя левую сторону строки с другой
    строкой до конечной строки достигает желаемой длины:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$padded</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">padLeft</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'James'</span><span
                class="token punctuation">,</span> <span class="token number">10</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'-='</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// '-=-=-James'</span>

<span class="token variable">$padded</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">padLeft</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'James'</span><span
                class="token punctuation">,</span> <span class="token number">10</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// '     James'</span></code></pre>
<p></p>
<h4 id="method-str-padright"><a href="#method-str-padright"><code>Str::padRight()</code></a></h4>
<p><code>Str::padRight</code> Метод обертывания в PHP <code>str_pad</code> функцию, дополняя правую сторону строки с
    другой строкой до конечной строки достигает желаемой длины:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$padded</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">padRight</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'James'</span><span
                class="token punctuation">,</span> <span class="token number">10</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'-'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 'James-----'</span>

<span class="token variable">$padded</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">padRight</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'James'</span><span
                class="token punctuation">,</span> <span class="token number">10</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 'James     '</span></code></pre>
<p></p>
<h4 id="method-str-plural"><a href="#method-str-plural"><code>Str::plural()</code></a></h4>
<p><code>Str::plural</code> Метод преобразует сингулярное слово строку в форме множественного числа. Эта функция в
    настоящее время поддерживает только английский язык:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$plural</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">plural</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'car'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// cars</span>

<span class="token variable">$plural</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">plural</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'child'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// children</span></code></pre>
<p>Вы можете указать целое число в качестве второго аргумента функции для получения единственного или множественного
    числа строки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$plural</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">plural</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'child'</span><span
                class="token punctuation">,</span> <span class="token number">2</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// children</span>

<span class="token variable">$singular</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">plural</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'child'</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// child</span></code></pre>
<p></p>
<h4 id="method-str-plural-studly"><a href="#method-str-plural-studly"><code>Str::pluralStudly()</code></a></h4>
<p>Этот <code>Str::pluralStudly</code> метод преобразует строку единственного числа, отформатированную заглавными
    буквами, в форму множественного числа. Эта функция в настоящее время поддерживает только английский язык:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$plural</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">pluralStudly</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'VerifiedHuman'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// VerifiedHumans</span>

<span class="token variable">$plural</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">pluralStudly</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'UserFeedback'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// UserFeedback</span></code></pre>
<p>Вы можете указать целое число в качестве второго аргумента функции для получения единственного или множественного
    числа строки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$plural</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">pluralStudly</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'VerifiedHuman'</span><span
                class="token punctuation">,</span> <span class="token number">2</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// VerifiedHumans</span>

<span class="token variable">$singular</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">pluralStudly</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'VerifiedHuman'</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// VerifiedHuman</span></code></pre>
<p></p>
<h4 id="method-str-random"><a href="#method-str-random"><code>Str::random()</code></a></h4>
<p><code>Str::random</code> Метод генерирует случайную строку заданной длины. Эта функция использует функцию PHP <code>random_bytes</code>:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$random</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">random</span><span
                class="token punctuation">(</span><span class="token number">40</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-str-replace-array"><a href="#method-str-replace-array"><code>Str::replaceArray()</code></a></h4>
<p><code>Str::replaceArray</code> Метод заменяет заданное значение в строке последовательно используя массив:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$string</span> <span class="token operator">=</span> <span
                class="token single-quoted-string string">'The event will take place between ? and ?'</span><span
                class="token punctuation">;</span>

<span class="token variable">$replaced</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">replaceArray</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'?'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'8:30'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'9:00'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span> <span class="token variable">$string</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// The event will take place between 8:30 and 9:00</span></code></pre>
<p></p>
<h4 id="method-str-replace-first"><a href="#method-str-replace-first"><code>Str::replaceFirst()</code></a></h4>
<p><code>Str::replaceFirst</code> Метод заменяет первое вхождение заданного значения в строке:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$replaced</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">replaceFirst</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'the'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'a'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'the quick brown fox jumps over the lazy dog'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// a quick brown fox jumps over the lazy dog</span></code></pre>
<p></p>
<h4 id="method-str-replace-last"><a href="#method-str-replace-last"><code>Str::replaceLast()</code></a></h4>
<p><code>Str::replaceLast</code> Метод заменяет последнее вхождение заданного значения в строке:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$replaced</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">replaceLast</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'the'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'a'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'the quick brown fox jumps over the lazy dog'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// the quick brown fox jumps over a lazy dog</span></code></pre>
<p></p>
<h4 id="method-str-singular"><a href="#method-str-singular"><code>Str::singular()</code></a></h4>
<p><code>Str::singular</code> Метод преобразует строку в своей особой форме. Эта функция в настоящее время поддерживает
    только английский язык:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$singular</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">singular</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'cars'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// car</span>

<span class="token variable">$singular</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">singular</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'children'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// child</span></code></pre>
<p></p>
<h4 id="method-str-slug"><a href="#method-str-slug"><code>Str::slug()</code></a></h4>
<p><code>Str::slug</code> Метод генерирует URL дружественного «пулю» из заданной строки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$slug</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">slug</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'Laravel 5 Framework'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'-'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// laravel-5-framework</span></code></pre>
<p></p>
<h4 id="method-snake-case"><a href="#method-snake-case"><code>Str::snake()</code></a></h4>
<p><code>Str::snake</code> Метод преобразует заданную строку <code>snake_case</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$converted</span> <span class="token operator">=</span> Str<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">snake</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'fooBar'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// foo_bar</span></code></pre>
<p></p>
<h4 id="method-str-start"><a href="#method-str-start"><code>Str::start()</code></a></h4>
<p><code>Str::start</code> Метод добавляет один экземпляр данного значения в строку, если она уже не начать с этим
    значением:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$adjusted</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">start</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'this/string'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'/'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// /this/string</span>

<span class="token variable">$adjusted</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">start</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'/this/string'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'/'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// /this/string</span></code></pre>
<p></p>
<h4 id="method-starts-with"><a href="#method-starts-with"><code>Str::startsWith()</code></a></h4>
<p><code>Str::startsWith</code> Метод определяет, является ли данная строка начинается с заданным значением:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$result</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">startsWith</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'This is my name'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'This'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// true</span></code></pre>
<p></p>
<h4 id="method-studly-case"><a href="#method-studly-case"><code>Str::studly()</code></a></h4>
<p><code>Str::studly</code> Метод преобразует заданную строку <code>StudlyCase</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$converted</span> <span class="token operator">=</span> Str<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">studly</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'foo_bar'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// FooBar</span></code></pre>
<p></p>
<h4 id="method-str-substr"><a href="#method-str-substr"><code>Str::substr()</code></a></h4>
<p><code>Str::substr</code> Метод возвращает часть строки, указанной с помощью параметров запуска и длины:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$converted</span> <span class="token operator">=</span> Str<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">substr</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'The Laravel Framework'</span><span
                class="token punctuation">,</span> <span class="token number">4</span><span
                class="token punctuation">,</span> <span class="token number">7</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// Laravel</span></code></pre>
<p></p>
<h4 id="method-str-substrcount"><a href="#method-str-substrcount"><code>Str::substrCount()</code></a></h4>
<p><code>Str::substrCount</code> Метод возвращает число вхождений заданного значения в заданной строке:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$count</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">substrCount</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'If you like ice cream, you will like snow cones.'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'like'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 2</span></code></pre>
<p></p>
<h4 id="method-title-case"><a href="#method-title-case"><code>Str::title()</code></a></h4>
<p><code>Str::title</code> Метод преобразует заданную строку <code>Title Case</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$converted</span> <span class="token operator">=</span> Str<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">title</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'a nice title uses the correct case'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// A Nice Title Uses The Correct Case</span></code></pre>
<p></p>
<h4 id="method-str-ucfirst"><a href="#method-str-ucfirst"><code>Str::ucfirst()</code></a></h4>
<p><code>Str::ucfirst</code> Метод возвращает заданную строку с первым символом капитализированы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$string</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">ucfirst</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'foo bar'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// Foo bar</span></code></pre>
<p></p>
<h4 id="method-str-upper"><a href="#method-str-upper"><code>Str::upper()</code></a></h4>
<p><code>Str::upper</code> Метод преобразует заданную строку в верхний регистр:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$string</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">upper</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'laravel'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// LARAVEL</span></code></pre>
<p></p>
<h4 id="method-str-uuid"><a href="#method-str-uuid"><code>Str::uuid()</code></a></h4>
<p><code>Str::uuid</code> Метод генерирует UUID (версия 4):</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token keyword">return</span> <span class="token punctuation">(</span>string<span class="token punctuation">)</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">uuid</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-str-words"><a href="#method-str-words"><code>Str::words()</code></a></h4>
<p><code>Str::words</code> Метод ограничивает количество слов в строке. Дополнительная строка может быть передана этому
    методу через его третий аргумент, чтобы указать, какая строка должна быть добавлена в конец усеченной строки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token keyword">return</span> Str<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">words</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Perfectly balanced, as all things should be.'</span><span
                class="token punctuation">,</span> <span class="token number">3</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">' &gt;&gt;&gt;'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// Perfectly balanced, as &gt;&gt;&gt;</span></code></pre>
<p></p>
<h4 id="method-trans"><a href="#method-trans"><code>trans()</code></a></h4>
<p><code>trans</code> Функция переводит данную клавишу перевода, используя ваши <a href="localization">файлы
        локализации</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">echo</span> <span
                class="token function">trans</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'messages.welcome'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если указанный ключ перевода не существует, <code>trans</code> функция вернет данный ключ. Итак, используя
    приведенный выше пример, <code>trans</code> функция вернется, <code>messages.welcome</code> если ключ перевода не
    существует.</p>
<p></p>
<h4 id="method-trans-choice"><a href="#method-trans-choice"><code>trans_choice()</code></a></h4>
<p><code>trans_choice</code> Функция переводит данную клавишу перевода с интонацией:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">echo</span> <span
                class="token function">trans_choice</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'messages.notifications'</span><span
                class="token punctuation">,</span> <span class="token variable">$unreadCount</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если указанный ключ перевода не существует, <code>trans_choice</code> функция вернет данный ключ. Итак, используя
    приведенный выше пример, <code>trans_choice</code> функция вернется, <code>messages.notifications</code> если ключ
    перевода не существует.</p>
<p></p>
<h2 id="fluent-strings"><a href="#fluent-strings">Свободные строки <sup>Fluent strings</sup></a></h2>
<p>Свободные строки обеспечивают более плавный объектно-ориентированный интерфейс для работы со строковыми значениями,
    позволяя объединять несколько строковых операций вместе, используя более читаемый синтаксис по сравнению с
    традиционными строковыми операциями.</p>
<p></p>
<h4 id="method-fluent-str-after"><a href="#method-fluent-str-after"><code>after</code></a></h4>
<p><code>after</code> Метод возвращает все после заданного значения в строке. Вся строка будет возвращена, если значение
    не существует в строке:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$slice</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'This is my name'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">after</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'This is'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// ' my name'</span></code></pre>
<p></p>
<h4 id="method-fluent-str-after-last"><a href="#method-fluent-str-after-last"><code>afterLast</code></a></h4>
<p><code>afterLast</code> Метод возвращает все после последнего вхождения заданного значения в строке. Вся строка будет
    возвращена, если значение не существует в строке:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$slice</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'App\Http\Controllers\Controller'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">afterLast</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'\\'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 'Controller'</span></code></pre>
<p></p>
<h4 id="method-fluent-str-append"><a href="#method-fluent-str-append"><code>append</code></a></h4>
<p><code>append</code> Метод добавляет заданные значения в строку:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$string</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Taylor'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">append</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">' Otwell'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 'Taylor Otwell'</span></code></pre>
<p></p>
<h4 id="method-fluent-str-ascii"><a href="#method-fluent-str-ascii"><code>ascii</code></a></h4>
<p><code>ascii</code> Метод будет пытаться транслитерировать строку в значение ASCII:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$string</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'ü'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">ascii</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// 'u'</span></code></pre>
<p></p>
<h4 id="method-fluent-str-basename"><a href="#method-fluent-str-basename"><code>basename</code></a></h4>
<p><code>basename</code> Метод возвращает завершающее имя компоненты данной строки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$string</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'/foo/bar/baz'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">basename</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// 'baz'</span></code></pre>
<p>При необходимости вы можете предоставить «расширение», которое будет удалено из конечного компонента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$string</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'/foo/bar/baz.jpg'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">basename</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'.jpg'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 'baz'</span></code></pre>
<p></p>
<h4 id="method-fluent-str-before"><a href="#method-fluent-str-before"><code>before</code></a></h4>
<p><code>before</code> Метод возвращает все до заданного значения в строке:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$slice</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'This is my name'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">before</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'my name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 'This is '</span></code></pre>
<p></p>
<h4 id="method-fluent-str-before-last"><a href="#method-fluent-str-before-last"><code>beforeLast</code></a></h4>
<p><code>beforeLast</code> Метод возвращает все до последнего вхождения заданного значения в строке:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$slice</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'This is my name'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">beforeLast</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'is'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 'This '</span></code></pre>
<p></p>
<h4 id="method-fluent-str-camel"><a href="#method-fluent-str-camel"><code>camel</code></a></h4>
<p><code>camel</code> Метод преобразует заданную строку <code>camelCase</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$converted</span> <span class="token operator">=</span> Str<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">of</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'foo_bar'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">camel</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// fooBar</span></code></pre>
<p></p>
<h4 id="method-fluent-str-contains"><a href="#method-fluent-str-contains"><code>contains</code></a></h4>
<p><code>contains</code> Метод определяет, является ли данная строка содержит заданное значение. Этот метод чувствителен
    к регистру:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$contains</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'This is my name'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">contains</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'my'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// true</span></code></pre>
<p>Вы также можете передать массив значений, чтобы определить, содержит ли данная строка какое-либо из значений в
    массиве:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$contains</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'This is my name'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">contains</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'my'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'foo'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// true</span></code></pre>
<p></p>
<h4 id="method-fluent-str-contains-all"><a href="#method-fluent-str-contains-all"><code>containsAll</code></a></h4>
<p><code>containsAll</code> Метод определяет, является ли данная строка содержит все значения в данном массиве:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$containsAll</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'This is my name'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">containsAll</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'my'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'name'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// true</span></code></pre>
<p></p>
<h4 id="method-fluent-str-dirname"><a href="#method-fluent-str-dirname"><code>dirname</code></a></h4>
<p><code>dirname</code> Метод возвращает часть родительского каталога данной строки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$string</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'/foo/bar/baz'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">dirname</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// '/foo/bar'</span></code></pre>
<p>При необходимости вы можете указать, сколько уровней каталогов вы хотите вырезать из строки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$string</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'/foo/bar/baz'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">dirname</span><span
                class="token punctuation">(</span><span class="token number">2</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// '/foo'</span></code></pre>
<p></p>
<h4 id="method-fluent-str-ends-with"><a href="#method-fluent-str-ends-with"><code>endsWith</code></a></h4>
<p><code>endsWith</code> Метод определяет, является ли данная строка концов с заданным значением:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$result</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'This is my name'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">endsWith</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// true</span></code></pre>
<p>Вы также можете передать массив значений, чтобы определить, заканчивается ли данная строка любым из значений в
    массиве:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$result</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'This is my name'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">endsWith</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'name'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'foo'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// true</span>

<span class="token variable">$result</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'This is my name'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">endsWith</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'this'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'foo'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// false</span></code></pre>
<p></p>
<h4 id="method-fluent-str-exactly"><a href="#method-fluent-str-exactly"><code>exactly</code></a></h4>
<p><code>exactly</code> Метод определяет, является ли данная строка является точным соответствием с другой строкой:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$result</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Laravel'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">exactly</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Laravel'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// true</span></code></pre>
<p></p>
<h4 id="method-fluent-str-explode"><a href="#method-fluent-str-explode"><code>explode</code></a></h4>
<p><code>explode</code> Метод разбивает строку с заданным разделителем и возвращает коллекцию, содержащую каждую секцию
    разделенной строки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$collection</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'foo bar baz'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">explode</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">' '</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// collect(['foo', 'bar', 'baz'])</span></code></pre>
<p></p>
<h4 id="method-fluent-str-finish"><a href="#method-fluent-str-finish"><code>finish</code></a></h4>
<p><code>finish</code> Метод добавляет один экземпляр данного значения в строку, если он уже не закончится с этим
    значением:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$adjusted</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'this/string'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">finish</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// this/string/</span>

<span class="token variable">$adjusted</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'this/string/'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">finish</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// this/string/</span></code></pre>
<p></p>
<h4 id="method-fluent-str-is"><a href="#method-fluent-str-is"><code>is</code></a></h4>
<p><code>is</code> Метод определяет, является ли данная строка соответствует заданному шаблону. Звездочки могут
    использоваться как подстановочные знаки.</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$matches</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'foobar'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">is</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'foo*'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// true</span>

<span class="token variable">$matches</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'foobar'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">is</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'baz*'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// false</span></code></pre>
<p></p>
<h4 id="method-fluent-str-is-ascii"><a href="#method-fluent-str-is-ascii"><code>isAscii</code></a></h4>
<p><code>isAscii</code> Метод определяет, является ли данная строка является строкой ASCII:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$result</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Taylor'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">isAscii</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// true</span>

<span class="token variable">$result</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'ü'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">isAscii</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// false</span></code></pre>
<p></p>
<h4 id="method-fluent-str-is-empty"><a href="#method-fluent-str-is-empty"><code>isEmpty</code></a></h4>
<p><code>isEmpty</code> Метод определяет, является ли данная строка пуста:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$result</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'  '</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">trim</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">isEmpty</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// true</span>

<span class="token variable">$result</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Laravel'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">trim</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">isEmpty</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// false</span></code></pre>
<p></p>
<h4 id="method-fluent-str-is-not-empty"><a href="#method-fluent-str-is-not-empty"><code>isNotEmpty</code></a></h4>
<p><code>isNotEmpty</code> Метод определяет, является ли данная строка не пуста:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$result</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'  '</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">trim</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">isNotEmpty</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// false</span>

<span class="token variable">$result</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Laravel'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">trim</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">isNotEmpty</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// true</span></code></pre>
<p></p>
<h4 id="method-fluent-str-kebab"><a href="#method-fluent-str-kebab"><code>kebab</code></a></h4>
<p><code>kebab</code> Метод преобразует заданную строку <code>kebab-case</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$converted</span> <span class="token operator">=</span> Str<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">of</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'fooBar'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">kebab</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// foo-bar</span></code></pre>
<p></p>
<h4 id="method-fluent-str-length"><a href="#method-fluent-str-length"><code>length</code></a></h4>
<p><code>length</code> Метод возвращает длину заданной строки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$length</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Laravel'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">length</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// 7</span></code></pre>
<p></p>
<h4 id="method-fluent-str-limit"><a href="#method-fluent-str-limit"><code>limit</code></a></h4>
<p><code>limit</code> Метод обрезает данную строку заданной длины:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$truncated</span> <span class="token operator">=</span> Str<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">of</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'The quick brown fox jumps over the lazy dog'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">limit</span><span
                class="token punctuation">(</span><span class="token number">20</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// The quick brown fox...</span></code></pre>
<p>Вы также можете передать второй аргумент, чтобы изменить строку, которая будет добавлена ​​в конец усеченной
    строки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$truncated</span> <span class="token operator">=</span> Str<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">of</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'The quick brown fox jumps over the lazy dog'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">limit</span><span
                class="token punctuation">(</span><span class="token number">20</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">' (...)'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// The quick brown fox (...)</span></code></pre>
<p></p>
<h4 id="method-fluent-str-lower"><a href="#method-fluent-str-lower"><code>lower</code></a></h4>
<p><code>lower</code> Метод преобразует заданную строку в нижний регистр:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$result</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'LARAVEL'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">lower</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// 'laravel'</span></code></pre>
<p></p>
<h4 id="method-fluent-str-ltrim"><a href="#method-fluent-str-ltrim"><code>ltrim</code></a></h4>
<p><code>ltrim</code> Метод обрезает левую часть строки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$string</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'  Laravel  '</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">ltrim</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// 'Laravel  '</span>

<span class="token variable">$string</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'/Laravel/'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">ltrim</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 'Laravel/'</span></code></pre>
<p></p>
<h4 id="method-fluent-str-markdown"><a href="#method-fluent-str-markdown"><code>markdown</code></a></h4>
<p>В этом <code>markdown</code> методе преобразует GitHub приправленной Markdown в HTML:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$html</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'# Laravel'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">markdown</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// &lt;h1&gt;Laravel&lt;/h1&gt;</span>

<span class="token variable">$html</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'# Taylor &lt;b&gt;Otwell&lt;/b&gt;'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">markdown</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'html_input'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'strip'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// &lt;h1&gt;Taylor Otwell&lt;/h1&gt;</span></code></pre>
<p></p>
<h4 id="method-fluent-str-match"><a href="#method-fluent-str-match"><code>match</code></a></h4>
<p><code>match</code> Метод возвращает ту часть строки, которая соответствует заданному шаблону регулярного выражения:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$result</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'foo bar'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token keyword">match</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/bar/'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 'bar'</span>

<span class="token variable">$result</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'foo bar'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token keyword">match</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'/foo (.*)/'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 'bar'</span></code></pre>
<p></p>
<h4 id="method-fluent-str-match-all"><a href="#method-fluent-str-match-all"><code>matchAll</code></a></h4>
<p><code>matchAll</code> Метод возвращает коллекцию, содержащую те части строки, соответствующую заданный шаблон
    регулярного выражения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$result</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'bar foo bar'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">matchAll</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/bar/'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// collect(['bar', 'bar'])</span></code></pre>
<p>Если вы укажете соответствующую группу в выражении, Laravel вернет коллекцию совпадений этой группы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$result</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'bar fun bar fly'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">matchAll</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/f(\w*)/'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// collect(['un', 'ly']);</span></code></pre>
<p>Если совпадений не найдено, будет возвращена пустая коллекция.</p>
<p></p>
<h4 id="method-fluent-str-padboth"><a href="#method-fluent-str-padboth"><code>padBoth</code></a></h4>
<p>Этот <code>padBoth</code> метод обертывает <code>str_pad</code> функцию PHP, заполняя обе стороны строки другой
    строкой, пока последняя строка не достигнет желаемой длины:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$padded</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'James'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">padBoth</span><span
                class="token punctuation">(</span><span class="token number">10</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'_'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// '__James___'</span>

<span class="token variable">$padded</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'James'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">padBoth</span><span
                class="token punctuation">(</span><span class="token number">10</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// '  James   '</span></code></pre>
<p></p>
<h4 id="method-fluent-str-padleft"><a href="#method-fluent-str-padleft"><code>padLeft</code></a></h4>
<p>Этот <code>padLeft</code> метод оборачивает <code>str_pad</code> функцию PHP, заполняя левую часть строки другой
    строкой, пока конечная строка не достигнет желаемой длины:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$padded</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'James'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">padLeft</span><span
                class="token punctuation">(</span><span class="token number">10</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'-='</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// '-=-=-James'</span>

<span class="token variable">$padded</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'James'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">padLeft</span><span
                class="token punctuation">(</span><span class="token number">10</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// '     James'</span></code></pre>
<p></p>
<h4 id="method-fluent-str-padright"><a href="#method-fluent-str-padright"><code>padRight</code></a></h4>
<p>Этот <code>padRight</code> метод оборачивает <code>str_pad</code> функцию PHP, заполняя правую часть строки другой
    строкой, пока последняя строка не достигнет желаемой длины:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$padded</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'James'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">padRight</span><span
                class="token punctuation">(</span><span class="token number">10</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'-'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 'James-----'</span>

<span class="token variable">$padded</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'James'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">padRight</span><span
                class="token punctuation">(</span><span class="token number">10</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 'James     '</span></code></pre>
<p></p>
<h4 id="method-fluent-str-pipe"><a href="#method-fluent-str-pipe"><code>pipe</code></a></h4>
<p><code>pipe</code> Метод позволяет преобразовать строку, передавая ее текущее значение в данной отзывной:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$hash</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Laravel'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">pipe</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'md5'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">prepend</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'Checksum: '</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 'Checksum: a5c95b86291ea299fcbe64458ed12702'</span>

<span class="token variable">$closure</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'foo'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">pipe</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$str</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> <span class="token single-quoted-string string">'bar'</span><span
                class="token punctuation">;</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// 'bar'</span></code></pre>
<p></p>
<h4 id="method-fluent-str-plural"><a href="#method-fluent-str-plural"><code>plural</code></a></h4>
<p><code>plural</code> Метод преобразует сингулярное слово строку в форме множественного числа. Эта функция в настоящее
    время поддерживает только английский язык:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$plural</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'car'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">plural</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// cars</span>

<span class="token variable">$plural</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'child'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">plural</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// children</span></code></pre>
<p>Вы можете указать целое число в качестве второго аргумента функции для получения единственного или множественного
    числа строки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$plural</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'child'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">plural</span><span
                class="token punctuation">(</span><span class="token number">2</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// children</span>

<span class="token variable">$plural</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'child'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">plural</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// child</span></code></pre>
<p></p>
<h4 id="method-fluent-str-prepend"><a href="#method-fluent-str-prepend"><code>prepend</code></a></h4>
<p><code>prepend</code> Метод присоединяет заданные значения на строку:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$string</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'Framework'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">prepend</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Laravel '</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// Laravel Framework</span></code></pre>
<p></p>
<h4 id="method-fluent-str-replace"><a href="#method-fluent-str-replace"><code>replace</code></a></h4>
<p><code>replace</code> Метод заменяет данную строку в строке:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$replaced</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'Laravel 6.x'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">replace</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'6.x'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'7.x'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// Laravel 7.x</span></code></pre>
<p></p>
<h4 id="method-fluent-str-replace-array"><a href="#method-fluent-str-replace-array"><code>replaceArray</code></a></h4>
<p><code>replaceArray</code> Метод заменяет заданное значение в строке последовательно используя массив:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$string</span> <span class="token operator">=</span> <span
                class="token single-quoted-string string">'The event will take place between ? and ?'</span><span
                class="token punctuation">;</span>

<span class="token variable">$replaced</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token variable">$string</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">replaceArray</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'?'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'8:30'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'9:00'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// The event will take place between 8:30 and 9:00</span></code></pre>
<p></p>
<h4 id="method-fluent-str-replace-first"><a href="#method-fluent-str-replace-first"><code>replaceFirst</code></a></h4>
<p><code>replaceFirst</code> Метод заменяет первое вхождение заданного значения в строке:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$replaced</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'the quick brown fox jumps over the lazy dog'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">replaceFirst</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'the'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'a'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// a quick brown fox jumps over the lazy dog</span></code></pre>
<p></p>
<h4 id="method-fluent-str-replace-last"><a href="#method-fluent-str-replace-last"><code>replaceLast</code></a></h4>
<p><code>replaceLast</code> Метод заменяет последнее вхождение заданного значения в строке:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$replaced</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'the quick brown fox jumps over the lazy dog'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">replaceLast</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'the'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'a'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// the quick brown fox jumps over a lazy dog</span></code></pre>
<p></p>
<h4 id="method-fluent-str-replace-matches"><a href="#method-fluent-str-replace-matches"><code>replaceMatches</code></a></h4>
<p><code>replaceMatches</code> Метод заменяет все части строки, совпадающей с шаблоном с заданной строкой замены:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$replaced</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'(+1) 501-555-1000'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">replaceMatches</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'/[^A-Za-z0-9]++/'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">''</span><span
                class="token punctuation">)</span>

<span class="token comment">// '15015551000'</span></code></pre>
<p>Этот <code>replaceMatches</code> метод также принимает замыкание, которое будет вызываться с каждой частью строки,
    соответствующей данному шаблону, что позволяет вам выполнить логику замены внутри замыкания и вернуть замененное
    значение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$replaced</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'123'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">replaceMatches</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/\d/'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$match</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> <span class="token single-quoted-string string">'['</span><span
                class="token punctuation">.</span><span class="token variable">$match</span><span
                class="token punctuation">[</span><span class="token number">0</span><span
                class="token punctuation">]</span><span class="token punctuation">.</span><span
                class="token single-quoted-string string">']'</span><span class="token punctuation">;</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// '[1][2][3]'</span></code></pre>
<p></p>
<h4 id="method-fluent-str-rtrim"><a href="#method-fluent-str-rtrim"><code>rtrim</code></a></h4>
<p><code>rtrim</code> Метод обрежет правую часть данной строки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$string</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'  Laravel  '</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">rtrim</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// '  Laravel'</span>

<span class="token variable">$string</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'/Laravel/'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">rtrim</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// '/Laravel'</span></code></pre>
<p></p>
<h4 id="method-fluent-str-singular"><a href="#method-fluent-str-singular"><code>singular</code></a></h4>
<p><code>singular</code> Метод преобразует строку в своей особой форме. Эта функция в настоящее время поддерживает
    только английский язык:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$singular</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'cars'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">singular</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// car</span>

<span class="token variable">$singular</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'children'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">singular</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// child</span></code></pre>
<p></p>
<h4 id="method-fluent-str-slug"><a href="#method-fluent-str-slug"><code>slug</code></a></h4>
<p><code>slug</code> Метод генерирует URL дружественного «пулю» из заданной строки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$slug</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'Laravel Framework'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">slug</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'-'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// laravel-framework</span></code></pre>
<p></p>
<h4 id="method-fluent-str-snake"><a href="#method-fluent-str-snake"><code>snake</code></a></h4>
<p><code>snake</code> Метод преобразует заданную строку <code>snake_case</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$converted</span> <span class="token operator">=</span> Str<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">of</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'fooBar'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">snake</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// foo_bar</span></code></pre>
<p></p>
<h4 id="method-fluent-str-split"><a href="#method-fluent-str-split"><code>split</code></a></h4>
<p><code>split</code> Метод разбивает строку на коллекцию, используя регулярное выражение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$segments</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'one, two, three'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">split</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/[\s,]+/'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// collect(["one", "two", "three"])</span></code></pre>
<p></p>
<h4 id="method-fluent-str-start"><a href="#method-fluent-str-start"><code>start</code></a></h4>
<p><code>start</code> Метод добавляет один экземпляр данного значения в строку, если она уже не начать с этим значением:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$adjusted</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'this/string'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">start</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// /this/string</span>

<span class="token variable">$adjusted</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'/this/string'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">start</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// /this/string</span></code></pre>
<p></p>
<h4 id="method-fluent-str-starts-with"><a href="#method-fluent-str-starts-with"><code>startsWith</code></a></h4>
<p><code>startsWith</code> Метод определяет, является ли данная строка начинается с заданным значением:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$result</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'This is my name'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">startsWith</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'This'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// true</span></code></pre>
<p></p>
<h4 id="method-fluent-str-studly"><a href="#method-fluent-str-studly"><code>studly</code></a></h4>
<p><code>studly</code> Метод преобразует заданную строку <code>StudlyCase</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$converted</span> <span class="token operator">=</span> Str<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">of</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'foo_bar'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">studly</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// FooBar</span></code></pre>
<p></p>
<h4 id="method-fluent-str-substr"><a href="#method-fluent-str-substr"><code>substr</code></a></h4>
<p><code>substr</code> Метод возвращает часть строки, указанной по заданным начальным и длине параметров:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$string</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'Laravel Framework'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">substr</span><span
                class="token punctuation">(</span><span class="token number">8</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// Framework</span>

<span class="token variable">$string</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'Laravel Framework'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">substr</span><span
                class="token punctuation">(</span><span class="token number">8</span><span
                class="token punctuation">,</span> <span class="token number">5</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// Frame</span></code></pre>
<p></p>
<h4 id="method-fluent-str-tap"><a href="#method-fluent-str-tap"><code>tap</code></a></h4>
<p><code>tap</code> Метод передает строку данного закрытия, что позволяет исследовать и взаимодействовать со струной, не
    затрагивая саму строку. Исходная строка возвращается <code>tap</code> методом независимо от того, что возвращает
    закрытие:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$string</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Laravel'</span><span
                class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">append</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">' Framework'</span><span class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">tap</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$string</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token function">dump</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'String after append: '</span> <span
                class="token punctuation">.</span> <span class="token variable">$string</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">upper</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// LARAVEL FRAMEWORK</span></code></pre>
<p></p>
<h4 id="method-fluent-str-title"><a href="#method-fluent-str-title"><code>title</code></a></h4>
<p><code>title</code> Метод преобразует заданную строку <code>Title Case</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$converted</span> <span class="token operator">=</span> Str<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">of</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'a nice title uses the correct case'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">title</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// A Nice Title Uses The Correct Case</span></code></pre>
<p></p>
<h4 id="method-fluent-str-trim"><a href="#method-fluent-str-trim"><code>trim</code></a></h4>
<p><code>trim</code> Метод обрезает данную строку:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$string</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'  Laravel  '</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">trim</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// 'Laravel'</span>

<span class="token variable">$string</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'/Laravel/'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">trim</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 'Laravel'</span></code></pre>
<p></p>
<h4 id="method-fluent-str-ucfirst"><a href="#method-fluent-str-ucfirst"><code>ucfirst</code></a></h4>
<p><code>ucfirst</code> Метод возвращает заданную строку с первым символом капитализированы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$string</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'foo bar'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">ucfirst</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// Foo bar</span></code></pre>
<p></p>
<h4 id="method-fluent-str-upper"><a href="#method-fluent-str-upper"><code>upper</code></a></h4>
<p><code>upper</code> Метод преобразует заданную строку в верхний регистр:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$adjusted</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'laravel'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">upper</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// LARAVEL</span></code></pre>
<p></p>
<h4 id="method-fluent-str-when"><a href="#method-fluent-str-when"><code>when</code></a></h4>
<p><code>when</code> Метод вызывает данное замыкание, если данное условие <code>true</code>. Замыкание получит свободный
    экземпляр строки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$string</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Taylor'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">when</span><span class="token punctuation">(</span><span
                class="token boolean constant">true</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token variable">$string</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> <span class="token variable">$string</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">append</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">' Otwell'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// 'Taylor Otwell'</span></code></pre>
<p>При необходимости вы можете передать <code>when</code> методу другое замыкание в качестве третьего параметра. Это
    закрытие будет выполнено, если параметр условия оценивается как <code>false</code>.</p>
<p></p>
<h4 id="method-fluent-str-when-empty"><a href="#method-fluent-str-when-empty"><code>whenEmpty</code></a></h4>
<p><code>whenEmpty</code> Метод вызывает данное замыкание, если строка пуста. Если замыкание возвращает значение, это
    значение также будет возвращено <code>whenEmpty</code> методом. Если закрытие не возвращает значение, будет
    возвращен свободный экземпляр строки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$string</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'  '</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">whenEmpty</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$string</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> <span class="token variable">$string</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">trim</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">prepend</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Laravel'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// 'Laravel'</span></code></pre>
<p></p>
<h4 id="method-fluent-str-words"><a href="#method-fluent-str-words"><code>words</code></a></h4>
<p><code>words</code> Метод ограничивает количество слов в строке. При необходимости вы можете указать дополнительную
    строку, которая будет добавлена ​​к усеченной строке:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token variable">$string</span> <span class="token operator">=</span> Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">of</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Perfectly balanced, as all things should be.'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">words</span><span
                class="token punctuation">(</span><span class="token number">3</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">' &gt;&gt;&gt;'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// Perfectly balanced, as &gt;&gt;&gt;</span></code></pre>
<p></p>
<h2 id="urls"><a href="#urls">URL-адреса <sup>URLs</sup></a></h2>
<p></p>
<h4 id="method-action"><a href="#method-action"><code>action()</code></a></h4>
<p><code>action</code> Функция генерирует URL - адрес для данного контроллера действий:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>HomeController</span><span
                class="token punctuation">;</span>

<span class="token variable">$url</span> <span class="token operator">=</span> <span
                class="token function">action</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span>HomeController<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'index'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Если метод принимает параметры маршрута, вы можете передать их в качестве второго аргумента метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$url</span> <span
                class="token operator">=</span> <span class="token function">action</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>UserController<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'profile'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span><span class="token single-quoted-string string">'id'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">1</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-asset"><a href="#method-asset"><code>asset()</code></a></h4>
<p><code>asset</code> Функция генерирует URL для актива, используя текущую схему запроса HTTP (или HTTPS):</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$url</span> <span
                class="token operator">=</span> <span class="token function">asset</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'img/photo.jpg'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете настроить хост URL ресурса, установив <code>ASSET_URL</code> переменную в вашем <code>.env</code> файле.
    Это может быть полезно, если вы размещаете свои активы на внешнем сервисе, таком как Amazon S3 или другой CDN:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">// ASSET_URL=http://example.com/assets</span>

<span class="token variable">$url</span> <span class="token operator">=</span> <span class="token function">asset</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'img/photo.jpg'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span> <span class="token comment">// http://example.com/assets/img/photo.jpg</span></code></pre>
<p></p>
<h4 id="method-route"><a href="#method-route"><code>route()</code></a></h4>
<p><code>route</code> Функция генерирует URL для заданного <a href="routing#named-routes">имени маршрута</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$url</span> <span
                class="token operator">=</span> <span class="token function">route</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'route.name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если маршрут принимает параметры, вы можете передать их в качестве второго аргумента функции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$url</span> <span
                class="token operator">=</span> <span class="token function">route</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'route.name'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">1</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>По умолчанию <code>route</code> функция генерирует абсолютный URL. Если вы хотите сгенерировать относительный
    URL-адрес, вы можете передать <code>false</code> в качестве третьего аргумента функции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$url</span> <span
                class="token operator">=</span> <span class="token function">route</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'route.name'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">1</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span> <span
                class="token boolean constant">false</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-secure-asset"><a href="#method-secure-asset"><code>secure_asset()</code></a></h4>
<p><code>secure_asset</code> Функция генерирует URL для актива с использованием протокола HTTPS:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$url</span> <span
                class="token operator">=</span> <span class="token function">secure_asset</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'img/photo.jpg'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-secure-url"><a href="#method-secure-url"><code>secure_url()</code></a></h4>
<p><code>secure_url</code> Функция генерирует полный HTTPS URL для данного пути. Дополнительные сегменты URL могут быть
    переданы во втором аргументе функции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$url</span> <span
                class="token operator">=</span> <span class="token function">secure_url</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'user/profile'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$url</span> <span class="token operator">=</span> <span
                class="token function">secure_url</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'user/profile'</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span><span class="token number">1</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-url"><a href="#method-url"><code>url()</code></a></h4>
<p><code>url</code> Функция генерирует полное URL для данного пути:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$url</span> <span
                class="token operator">=</span> <span class="token function">url</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'user/profile'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$url</span> <span class="token operator">=</span> <span
                class="token function">url</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'user/profile'</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span><span class="token number">1</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Если путь не указан, <code>Illuminate\Routing\UrlGenerator</code> возвращается экземпляр:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$current</span> <span
                class="token operator">=</span> <span class="token function">url</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">current</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$full</span> <span class="token operator">=</span> <span
                class="token function">url</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">full</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$previous</span> <span class="token operator">=</span> <span
                class="token function">url</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">previous</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="miscellaneous"><a href="#miscellaneous">Разное <sup>Miscellaneous</sup></a></h2>
<p></p>
<h4 id="method-abort"><a href="#method-abort"><code>abort()</code></a></h4>
<p><code>abort</code> Функция вызывает <a href="errors#http-exceptions">исключение HTTP</a>, которое будет оказано на <a
            href="errors#the-exception-handler">обработчик исключения</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">abort</span><span
                class="token punctuation">(</span><span class="token number">403</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы также можете предоставить сообщение об исключении и настраиваемые заголовки HTTP-ответа, которые должны быть
    отправлены в браузер:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">abort</span><span
                class="token punctuation">(</span><span class="token number">403</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Unauthorized.'</span><span class="token punctuation">,</span> <span
                class="token variable">$headers</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-abort-if"><a href="#method-abort-if"><code>abort_if()</code></a></h4>
<p><code>abort_if</code> Функция вызывает исключение HTTP, если данное логическое выражение имеет значение
    <code>true</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">abort_if</span><span
                class="token punctuation">(</span><span class="token operator">!</span> Auth<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">user</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">isAdmin</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span> <span class="token number">403</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Как и в случае с <code>abort</code> методом, вы также можете предоставить текст ответа исключения в качестве третьего
    аргумента и массив настраиваемых заголовков ответа в качестве четвертого аргумента функции.</p>
<p></p>
<h4 id="method-abort-unless"><a href="#method-abort-unless"><code>abort_unless()</code></a></h4>
<p><code>abort_unless</code> Функция вызывает исключение HTTP, если данное логическое выражение имеет значение <code>false</code>:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">abort_unless</span><span
                class="token punctuation">(</span>Auth<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">user</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">isAdmin</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span> <span class="token number">403</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Как и в случае с <code>abort</code> методом, вы также можете предоставить текст ответа исключения в качестве третьего
    аргумента и массив настраиваемых заголовков ответа в качестве четвертого аргумента функции.</p>
<p></p>
<h4 id="method-app"><a href="#method-app"><code>app()</code></a></h4>
<p><code>app</code> Функция возвращает <a href="container">контейнер службы</a> экземпляра:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$container</span> <span
                class="token operator">=</span> <span class="token function">app</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы можете передать имя класса или интерфейса, чтобы разрешить его из контейнера:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$api</span> <span
                class="token operator">=</span> <span class="token function">app</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'HelpSpot\API'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-auth"><a href="#method-auth"><code>auth()</code></a></h4>
<p><code>auth</code> Функция возвращает <a href="authentication">аутентификатор</a> экземпляр. Можно использовать как
    альтернативу <code>Auth</code> фасаду:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span> <span
                class="token operator">=</span> <span class="token function">auth</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">user</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>При необходимости вы можете указать, к какому экземпляру защиты вы хотите получить доступ:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span> <span
                class="token operator">=</span> <span class="token function">auth</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'admin'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">user</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-back"><a href="#method-back"><code>back()</code></a></h4>
<p><code>back</code> Функция генерирует <a href="responses#redirects">ответ HTTP перенаправления</a> на предыдущее
    местоположение пользователя:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token function">back</span><span class="token punctuation">(</span><span class="token variable">$status</span> <span
                class="token operator">=</span> <span class="token number">302</span><span
                class="token punctuation">,</span> <span class="token variable">$headers</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span> <span class="token variable">$fallback</span> <span
                class="token operator">=</span> <span class="token single-quoted-string string">'/'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">return</span> <span class="token function">back</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-bcrypt"><a href="#method-bcrypt"><code>bcrypt()</code></a></h4>
<p><code>bcrypt</code> Функции <a href="hashing">хешей</a> данного значения с помощью Bcrypt. Вы можете использовать эту
    функцию как альтернативу <code>Hash</code> фасаду:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$password</span> <span
                class="token operator">=</span> <span class="token function">bcrypt</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'my-secret-password'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-blank"><a href="#method-blank"><code>blank()</code></a></h4>
<p><code>blank</code> Функция определяет, является ли «пустым» заданное значение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">blank</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">''</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token function">blank</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'   '</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token function">blank</span><span class="token punctuation">(</span><span
                class="token constant">null</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token function">blank</span><span class="token punctuation">(</span><span
                class="token function">collect</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// true</span>

<span class="token function">blank</span><span class="token punctuation">(</span><span
                class="token number">0</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token function">blank</span><span class="token punctuation">(</span><span class="token boolean constant">true</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token function">blank</span><span class="token punctuation">(</span><span class="token boolean constant">false</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// false</span></code></pre>
<p>Для обратного <code>blank</code> см. <a href="helpers#method-filled"><code>filled</code></a>Метод.</p>
<p></p>
<h4 id="method-broadcast"><a href="#method-broadcast"><code>broadcast()</code></a></h4>
<p><code>broadcast</code> Функция <a href="broadcasting">передает</a> данное <a href="events">событие</a> для
    слушателей:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">broadcast</span><span
                class="token punctuation">(</span><span class="token keyword">new</span> <span class="token class-name">UserRegistered</span><span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token function">broadcast</span><span class="token punctuation">(</span><span
                class="token keyword">new</span> <span class="token class-name">UserRegistered</span><span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">toOthers</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-cache"><a href="#method-cache"><code>cache()</code></a></h4>
<p><code>cache</code> Функция может быть использована для получения значений из <a href="cache">кэша</a>. Если данный
    ключ не существует в кеше, будет возвращено необязательное значение по умолчанию:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$value</span> <span
                class="token operator">=</span> <span class="token function">cache</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'key'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$value</span> <span class="token operator">=</span> <span
                class="token function">cache</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'key'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'default'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы можете добавлять элементы в кеш, передавая в функцию массив пар ключ / значение. Вы также должны передать
    количество секунд или продолжительность, в течение которых кешируемое значение должно считаться действительным:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">cache</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'key'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'value'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span> <span class="token number">300</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token function">cache</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'key'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'value'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span> <span class="token function">now</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">addSeconds</span><span
                class="token punctuation">(</span><span class="token number">10</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-class-uses-recursive"><a href="#method-class-uses-recursive"><code>class_uses_recursive()</code></a></h4>
<p><code>class_uses_recursive</code> Функция возвращает все признаки, используемые классом, в том числе признаков,
    используемых всеми его родительских классов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$traits</span> <span
                class="token operator">=</span> <span class="token function">class_uses_recursive</span><span
                class="token punctuation">(</span>App\<span class="token package">Models<span class="token punctuation">\</span>User</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-collect"><a href="#method-collect"><code>collect()</code></a></h4>
<p><code>collect</code> Функция создает <a href="collections">коллекцию</a> экземпляр от заданного значения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'taylor'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'abigail'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-config"><a href="#method-config"><code>config()</code></a></h4>
<p><code>config</code> Функция получает значение <a href="configuration">конфигурации</a> переменной. Доступ к значениям
    конфигурации можно получить с помощью синтаксиса «точка», который включает имя файла и параметр, к которому вы
    хотите получить доступ. Может быть указано значение по умолчанию, которое будет возвращено, если параметр
    конфигурации не существует:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$value</span> <span
                class="token operator">=</span> <span class="token function">config</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'app.timezone'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$value</span> <span class="token operator">=</span> <span
                class="token function">config</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'app.timezone'</span><span class="token punctuation">,</span> <span
                class="token variable">$default</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы можете установить переменные конфигурации во время выполнения, передав массив пар ключ / значение. Однако обратите
    внимание, что эта функция влияет только на значение конфигурации для текущего запроса и не обновляет ваши
    фактические значения конфигурации:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">config</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'app.debug'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token boolean constant">true</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-cookie"><a href="#method-cookie"><code>cookie()</code></a></h4>
<p><code>cookie</code> Функция создает новый <a href="requests#cookies">куки</a> экземпляр:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$cookie</span> <span
                class="token operator">=</span> <span class="token function">cookie</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'value'</span><span
                class="token punctuation">,</span> <span class="token variable">$minutes</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-csrf-field"><a href="#method-csrf-field"><code>csrf_field()</code></a></h4>
<p><code>csrf_field</code> Функция генерирует HTML <code>hidden</code> поля ввода, содержащее значение маркеров CSRF.
    Например, используя <a href="blade">синтаксис Blade</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token punctuation">{literal}{{/literal}</span><span
                class="token punctuation">{literal}{{/literal}</span> <span
                class="token function">csrf_field</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span> <span class="token punctuation">}</span><span
                class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="method-csrf-token"><a href="#method-csrf-token"><code>csrf_token()</code></a></h4>
<p><code>csrf_token</code> Функция возвращает значение текущего CSRF токен:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$token</span> <span
                class="token operator">=</span> <span class="token function">csrf_token</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-dd"><a href="#method-dd"><code>dd()</code></a></h4>
<p><code>dd</code> Функция выводит данные переменные и концы выполнения скрипта:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">dd</span><span
                class="token punctuation">(</span><span class="token variable">$value</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token function">dd</span><span class="token punctuation">(</span><span
                class="token variable">$value1</span><span class="token punctuation">,</span> <span
                class="token variable">$value2</span><span class="token punctuation">,</span> <span
                class="token variable">$value3</span><span class="token punctuation">,</span> <span
                class="token punctuation">.</span><span class="token punctuation">.</span><span
                class="token punctuation">.</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Если вы не хотите останавливать выполнение сценария, используйте <a href="helpers#method-dump"><code>dump</code></a>вместо
    этого функцию.</p>
<p></p>
<h4 id="method-dispatch"><a href="#method-dispatch"><code>dispatch()</code></a></h4>
<p><code>dispatch</code> Функция толкает данную <a href="queues#creating-jobs">работу</a> на Laravel <a href="queues">очереди
        заданий</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">dispatch</span><span
                class="token punctuation">(</span><span class="token keyword">new</span> <span class="token class-name">App<span
                    class="token punctuation">\</span>Jobs<span class="token punctuation">\</span>SendEmails</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-dispatch-now"><a href="#method-dispatch-now"><code>dispatch_now()</code></a></h4>
<p><code>dispatch_now</code> Функция выполняет данную <a href="queues#creating-jobs">работу</a> немедленно и возвращает
    значение из <code>handle</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$result</span> <span
                class="token operator">=</span> <span class="token function">dispatch_now</span><span
                class="token punctuation">(</span><span class="token keyword">new</span> <span class="token class-name">App<span
                    class="token punctuation">\</span>Jobs<span class="token punctuation">\</span>SendEmails</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-dump"><a href="#method-dump"><code>dump()</code></a></h4>
<p><code>dump</code> Функция сбрасывает данные переменные:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">dump</span><span
                class="token punctuation">(</span><span class="token variable">$value</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token function">dump</span><span class="token punctuation">(</span><span
                class="token variable">$value1</span><span class="token punctuation">,</span> <span
                class="token variable">$value2</span><span class="token punctuation">,</span> <span
                class="token variable">$value3</span><span class="token punctuation">,</span> <span
                class="token punctuation">.</span><span class="token punctuation">.</span><span
                class="token punctuation">.</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Если вы хотите остановить выполнение сценария после сброса переменных, используйте <a href="helpers#method-dd"><code>dd</code></a>вместо
    этого функцию.</p>
<p></p>
<h4 id="method-env"><a href="#method-env"><code>env()</code></a></h4>
<p><code>env</code> Функция возвращает значение в <a href="configuration#environment-configuration">переменной
        окружения</a> или возвращает значение по умолчанию:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$env</span> <span
                class="token operator">=</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'APP_ENV'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$env</span> <span class="token operator">=</span> <span
                class="token function">env</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'APP_ENV'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'production'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Если вы выполняете <code>config:cache</code> команду в процессе развертывания, вы должны быть уверены, что
            вызываете <code>env</code> функцию только из файлов конфигурации. После кэширования конфигурации
            <code>.env</code> файл не будет загружен, и все вызовы <code>env</code> функции вернутся <code>null</code>.
        </p></p></div>
</blockquote>
<p></p>
<h4 id="method-event"><a href="#method-event"><code>event()</code></a></h4>
<p><code>event</code> Функция отправляет данное <a href="events">событие</a> для своих слушателей:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">event</span><span
                class="token punctuation">(</span><span class="token keyword">new</span> <span class="token class-name">UserRegistered</span><span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-filled"><a href="#method-filled"><code>filled()</code></a></h4>
<p><code>filled</code> Функция определяет, является ли данное значение не является «пустым»:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">filled</span><span
                class="token punctuation">(</span><span class="token number">0</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token function">filled</span><span class="token punctuation">(</span><span class="token boolean constant">true</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token function">filled</span><span class="token punctuation">(</span><span class="token boolean constant">false</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// true</span>

<span class="token function">filled</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">''</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token function">filled</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'   '</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token function">filled</span><span class="token punctuation">(</span><span
                class="token constant">null</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token function">filled</span><span class="token punctuation">(</span><span
                class="token function">collect</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// false</span></code></pre>
<p>Для обратного <code>filled</code> см. <a href="helpers#method-blank"><code>blank</code></a>Метод.</p>
<p></p>
<h4 id="method-info"><a href="#method-info"><code>info()</code></a></h4>
<p><code>info</code> Функция будет записывать информацию вашего приложения <a href="logging">журнала</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">info</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Some helpful information!'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>В функцию также может быть передан массив контекстных данных:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">info</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'User login attempt failed.'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span><span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-logger"><a href="#method-logger"><code>logger()</code></a></h4>
<p><code>logger</code> Функция может быть использована, чтобы написать <code>debug</code> сообщение уровня в <a
            href="logging">журнале</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">logger</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Debug message'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>В функцию также может быть передан массив контекстных данных:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">logger</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'User has logged in.'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span><span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p><a href="errors#logging">Регистратор</a> экземпляр будет возвращен, если значение не передается функции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">logger</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">error</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'You are not allowed here.'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-method-field"><a href="#method-method-field"><code>method_field()</code></a></h4>
<p><code>method_field</code> Функция генерирует HTML <code>hidden</code> поля ввода, содержащее поддельное значение
    формы глагола HTTP - х. Например, используя <a href="blade">синтаксис Blade</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>form method<span
                class="token operator">=</span><span class="token double-quoted-string string">"POST"</span><span
                class="token operator">&gt;</span>
    <span class="token punctuation">{literal}{{/literal}</span><span
                class="token punctuation">{literal}{{/literal}</span> <span
                class="token function">method_field</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'DELETE'</span><span class="token punctuation">)</span> <span
                class="token punctuation">}</span><span class="token punctuation">}</span>
<span class="token operator">&lt;</span><span class="token operator">/</span>form<span
                class="token operator">&gt;</span></code></pre>
<p></p>
<h4 id="method-now"><a href="#method-now"><code>now()</code></a></h4>
<p><code>now</code> Функция создает новый <code>Illuminate\Support\Carbon</code> экземпляр для текущего времени:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$now</span> <span
                class="token operator">=</span> <span class="token function">now</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-old"><a href="#method-old"><code>old()</code></a></h4>
<p><code>old</code> Функция <a href="requests#retrieving-input">возвращает</a> к <a href="requests#old-input">старому
        входному</a> значению прошили в сессию:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$value</span> <span
                class="token operator">=</span> <span class="token function">old</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'value'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$value</span> <span class="token operator">=</span> <span class="token function">old</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'value'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'default'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-optional"><a href="#method-optional"><code>optional()</code></a></h4>
<p><code>optional</code> Функция принимает любой аргумент и позволяет вам доступ к свойствам или методам обработки
    вызовов на этом объекте. Если данный объект есть <code>null</code>, свойства и методы вернутся <code>null</code>
    вместо того, чтобы вызывать ошибку:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token function">optional</span><span class="token punctuation">(</span><span
                class="token variable">$user</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">address</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">street</span><span
                class="token punctuation">;</span>

<span class="token punctuation">{literal}{{/literal}</span><span class="token operator">!</span><span
                class="token operator">!</span> <span class="token function">old</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">,</span> <span class="token function">optional</span><span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">name</span><span
                class="token punctuation">)</span> <span class="token operator">!</span><span
                class="token operator">!</span><span class="token punctuation">}</span></code></pre>
<p><code>optional</code> Функция также принимает замыкание в качестве второго аргумента. Закрытие будет вызвано, если
    значение, указанное в качестве первого аргумента, не равно нулю:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token function">optional</span><span class="token punctuation">(</span>User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token variable">$id</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> <span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">name</span><span class="token punctuation">;</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-policy"><a href="#method-policy"><code>policy()</code></a></h4>
<p><code>policy</code> Метод извлекает <a href="authorization#creating-policies">политику</a> экземпляр для данного
    класса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$policy</span> <span
                class="token operator">=</span> <span class="token function">policy</span><span
                class="token punctuation">(</span>App\<span class="token package">Models<span class="token punctuation">\</span>User</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-redirect"><a href="#method-redirect"><code>redirect()</code></a></h4>
<p><code>redirect</code> Функция возвращает <a href="responses#redirects">ответ перенаправления HTTP</a>, или возвращает
    экземпляр редиректор, если вызывается без аргументов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token function">redirect</span><span class="token punctuation">(</span><span
                class="token variable">$to</span> <span class="token operator">=</span> <span class="token constant">null</span><span
                class="token punctuation">,</span> <span class="token variable">$status</span> <span
                class="token operator">=</span> <span class="token number">302</span><span
                class="token punctuation">,</span> <span class="token variable">$headers</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span> <span class="token variable">$https</span> <span
                class="token operator">=</span> <span class="token constant">null</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token keyword">return</span> <span class="token function">redirect</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/home'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">return</span> <span class="token function">redirect</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">route</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'route.name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-report"><a href="#method-report"><code>report()</code></a></h4>
<p><code>report</code> Функция сообщит исключение с помощью <a href="errors#the-exception-handler">обработчика
        исключений</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">report</span><span
                class="token punctuation">(</span><span class="token variable">$e</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p><code>report</code> Функция также принимает строку в качестве аргумента. Когда в функцию передается строка, функция
    создает исключение с данной строкой в ​​качестве сообщения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">report</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Something went wrong.'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-request"><a href="#method-request"><code>request()</code></a></h4>
<p><code>request</code> Функция возвращает текущий <a href="requests">запрос</a> экземпляр или получает значение поля
    ввода от текущего запроса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$request</span> <span
                class="token operator">=</span> <span class="token function">request</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$value</span> <span class="token operator">=</span> <span
                class="token function">request</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'key'</span><span class="token punctuation">,</span> <span
                class="token variable">$default</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-rescue"><a href="#method-rescue"><code>rescue()</code></a></h4>
<p><code>rescue</code> Функция выполняет данное замыкание и ловит любые исключения, возникающие в процессе его
    исполнения. Все перехваченные исключения будут отправлены вашему <a href="errors#the-exception-handler">обработчику
        исключений</a> ; однако запрос продолжит обработку:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token function">rescue</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">method</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы также можете передать функции второй аргумент <code>rescue</code>. Этот аргумент будет значением "по умолчанию",
    которое должно быть возвращено, если во время выполнения закрытия возникает исключение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token function">rescue</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">method</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
            <span class="token punctuation">}</span><span class="token punctuation">,</span> <span
                class="token boolean constant">false</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token keyword">return</span> <span class="token function">rescue</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">method</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
            <span class="token punctuation">}</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">failure</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-resolve"><a href="#method-resolve"><code>resolve()</code></a></h4>
<p><code>resolve</code> Функция решает данный класс или интерфейс имя экземпляра, используя <a href="container">контейнер
        службы</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$api</span> <span
                class="token operator">=</span> <span class="token function">resolve</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'HelpSpot\API'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-response"><a href="#method-response"><code>response()</code></a></h4>
<p><code>response</code> Функция создает <a href="responses">ответ</a> экземпляр или получает экземпляр фабрики ответа:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token function">response</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Hello World'</span><span
                class="token punctuation">,</span> <span class="token number">200</span><span class="token punctuation">,</span> <span
                class="token variable">$headers</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token keyword">return</span> <span class="token function">response</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">json</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'foo'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'bar'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span> <span class="token number">200</span><span class="token punctuation">,</span> <span
                class="token variable">$headers</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-retry"><a href="#method-retry"><code>retry()</code></a></h4>
<p>В <code>retry</code> попытках функции выполнить данную функцию обратного вызова, пока заданная максимальная пороговая
    попытка не будет достигнуты. Если обратный вызов не вызывает исключения, возвращается его возвращаемое значение.
    Если обратный вызов вызывает исключение, он будет автоматически повторен. Если максимальное количество попыток
    превышено, будет создано исключение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token function">retry</span><span class="token punctuation">(</span><span
                class="token number">5</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">// Attempt 5 times while resting 100ms in between attempts...</span>
            <span class="token punctuation">}</span><span class="token punctuation">,</span> <span class="token number">100</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-session"><a href="#method-session"><code>session()</code></a></h4>
<p><code>session</code> Функция может быть использована для получения или установки <a href="session">сеанса</a>
    значения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$value</span> <span
                class="token operator">=</span> <span class="token function">session</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'key'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете установить значения, передав в функцию массив пар ключ / значение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">session</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'chairs'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">7</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'instruments'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">3</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Хранилище сеансов будет возвращено, если функции не передано значение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$value</span> <span
                class="token operator">=</span> <span class="token function">session</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'key'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token function">session</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">put</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'key'</span><span
                class="token punctuation">,</span> <span class="token variable">$value</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-tap"><a href="#method-tap"><code>tap()</code></a></h4>
<p><code>tap</code> Функция принимает два аргумента: произвольные <code>$value</code> и замыкание. <code>$value</code>
    Будет передан к закрытию, а затем возвращается в <code>tap</code> функции. Возвращаемое значение закрытия не имеет
    значения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span> <span
                class="token operator">=</span> <span class="token function">tap</span><span
                class="token punctuation">(</span>User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">first</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token variable">$user</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">name</span> <span class="token operator">=</span> <span
                class="token single-quoted-string string">'taylor'</span><span class="token punctuation">;</span>

            <span class="token variable">$user</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">save</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Если в <code>tap</code> функцию не передается закрытие, вы можете вызвать любой метод для данного <code>$value</code>.
    Возвращаемое значение вызываемого вами метода всегда будет <code>$value</code>, независимо от того, что метод
    фактически возвращает в своем определении. Например, <code>update</code> метод Eloquent обычно возвращает целое
    число. Однако мы можем заставить метод вернуть саму модель, связав <code>update</code> вызов метода через
    <code>tap</code> функцию:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span> <span
                class="token operator">=</span> <span class="token function">tap</span><span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">update</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$name</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$email</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Чтобы добавить <code>tap</code> метод к классу, вы можете добавить <code>Illuminate\Support\Traits\Tappable</code>
    трейт к классу. <code>tap</code> Метод этого признака принимает Закрытие в качестве единственного аргумента. Сам
    экземпляр объекта будет передан Closure, а затем будет возвращен <code>tap</code> методом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token variable">$user</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">tap</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">//</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-throw-if"><a href="#method-throw-if"><code>throw_if()</code></a></h4>
<p><code>throw_if</code> Функция вызывает данное исключение, если данное логическое выражение имеет значение
    <code>true</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">throw_if</span><span
                class="token punctuation">(</span><span class="token operator">!</span> Auth<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">user</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">isAdmin</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span> AuthorizationException<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token function">throw_if</span><span class="token punctuation">(</span>
    <span class="token operator">!</span> Auth<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">user</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">isAdmin</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span>
    AuthorizationException<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'You are not allowed to access this page.'</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-throw-unless"><a href="#method-throw-unless"><code>throw_unless()</code></a></h4>
<p><code>throw_unless</code> Функция вызывает данное исключение, если данное логическое выражение имеет значение <code>false</code>:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">throw_unless</span><span
                class="token punctuation">(</span>Auth<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">user</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">isAdmin</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span> AuthorizationException<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token function">throw_unless</span><span class="token punctuation">(</span>
    Auth<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">user</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">isAdmin</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span>
    AuthorizationException<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'You are not allowed to access this page.'</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-today"><a href="#method-today"><code>today()</code></a></h4>
<p><code>today</code> Функция создает новый <code>Illuminate\Support\Carbon</code> экземпляр для текущей даты:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$today</span> <span
                class="token operator">=</span> <span class="token function">today</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-trait-uses-recursive"><a href="#method-trait-uses-recursive"><code>trait_uses_recursive()</code></a></h4>
<p><code>trait_uses_recursive</code> Функция возвращает все черты, используемые признак:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$traits</span> <span
                class="token operator">=</span> <span class="token function">trait_uses_recursive</span><span
                class="token punctuation">(</span>\<span class="token package">Illuminate<span
                    class="token punctuation">\</span>Notifications<span
                    class="token punctuation">\</span>Notifiable</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-transform"><a href="#method-transform"><code>transform()</code></a></h4>
<p><code>transform</code> Функция выполняет замыкание на заданное значение, если значение не <a
            href="helpers#method-blank">пусто</a>, а затем возвращает значение, возвращаемое закрытия:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$callback</span> <span
                class="token operator">=</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$value</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> <span class="token variable">$value</span> <span
                class="token operator">*</span> <span class="token number">2</span><span
                class="token punctuation">;</span>
            <span class="token punctuation">}</span><span class="token punctuation">;</span>

<span class="token variable">$result</span> <span class="token operator">=</span> <span
                class="token function">transform</span><span class="token punctuation">(</span><span
                class="token number">5</span><span class="token punctuation">,</span> <span class="token variable">$callback</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 10</span></code></pre>
<p>В качестве третьего аргумента функции может быть передано значение по умолчанию или закрытие. Это значение будет
    возвращено, если заданное значение пустое:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$result</span> <span
                class="token operator">=</span> <span class="token function">transform</span><span
                class="token punctuation">(</span><span class="token constant">null</span><span
                class="token punctuation">,</span> <span class="token variable">$callback</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'The value is blank'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// The value is blank</span></code></pre>
<p></p>
<h4 id="method-validator"><a href="#method-validator"><code>validator()</code></a></h4>
<p><code>validator</code> Функция создает новый <a href="validation">валидатор</a> экземпляр с заданными аргументами.
    Можно использовать как альтернативу <code>Validator</code> фасаду:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$validator</span> <span
                class="token operator">=</span> <span class="token function">validator</span><span
                class="token punctuation">(</span><span class="token variable">$data</span><span
                class="token punctuation">,</span> <span class="token variable">$rules</span><span
                class="token punctuation">,</span> <span class="token variable">$messages</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-value"><a href="#method-value"><code>value()</code></a></h4>
<p><code>value</code> Функция возвращает значение, которое она дается. Однако, если вы передадите закрытие функции,
    закрытие будет выполнено и будет возвращено его возвращенное значение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$result</span> <span
                class="token operator">=</span> <span class="token function">value</span><span
                class="token punctuation">(</span><span class="token boolean constant">true</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// true</span>

<span class="token variable">$result</span> <span class="token operator">=</span> <span
                class="token function">value</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> <span class="token boolean constant">false</span><span
                class="token punctuation">;</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// false</span></code></pre>
<p></p>
<h4 id="method-view"><a href="#method-view"><code>view()</code></a></h4>
<p><code>view</code> Функция возвращает <a href="views">вид</a> экземпляра:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token function">view</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'auth.login'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="method-with"><a href="#method-with"><code>with()</code></a></h4>
<p><code>with</code> Функция возвращает значение, которое она дается. Если закрытие передается в качестве второго
    аргумента функции, закрытие будет выполнено, и будет возвращено его возвращаемое значение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$callback</span> <span
                class="token operator">=</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$value</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> <span class="token punctuation">(</span><span
                class="token function">is_numeric</span><span class="token punctuation">(</span><span
                class="token variable">$value</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span> <span class="token operator">?</span> <span class="token variable">$value</span> <span
                class="token operator">*</span> <span class="token number">2</span> <span
                class="token punctuation">:</span> <span class="token number">0</span><span
                class="token punctuation">;</span>
            <span class="token punctuation">}</span><span class="token punctuation">;</span>

<span class="token variable">$result</span> <span class="token operator">=</span> <span
                class="token function">with</span><span class="token punctuation">(</span><span
                class="token number">5</span><span class="token punctuation">,</span> <span class="token variable">$callback</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 10</span>

<span class="token variable">$result</span> <span class="token operator">=</span> <span
                class="token function">with</span><span class="token punctuation">(</span><span class="token constant">null</span><span
                class="token punctuation">,</span> <span class="token variable">$callback</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 0</span>

<span class="token variable">$result</span> <span class="token operator">=</span> <span
                class="token function">with</span><span class="token punctuation">(</span><span
                class="token number">5</span><span class="token punctuation">,</span> <span
                class="token constant">null</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// 5</span></code></pre> 
       