<h1>Локализация <sup>Localization</sup></h1>
<ul>
    <li><a href="localization#introduction">Вступление <sup>Introduction</sup></a>
        <ul>
            <li><a href="localization#configuring-the-locale">Настройка локали <sup>Configuring the locale</sup></a></li>
        </ul>
    </li>
    <li><a href="localization#defining-translation-strings">Определение строк перевода <sup>Defining translation strings</sup></a>
        <ul>
            <li><a href="localization#using-short-keys">Использование коротких клавиш <sup>Using short keys</sup></a></li>
            <li><a href="localization#using-translation-strings-as-keys">Использование строк перевода в качестве
                    ключей <sup>Using translation strings ss keys</sup></a></li>
        </ul>
    </li>
    <li><a href="localization#retrieving-translation-strings">Получение строк перевода <sup>Retrieving translation strings</sup></a>
        <ul>
            <li><a href="localization#replacing-parameters-in-translation-strings">Замена параметров в строках
                    перевода <sup>Replacing parameters in translation strings</sup></a></li>
            <li><a href="localization#pluralization">Плюрализация <sup>Pluralization</sup></a></li>
        </ul>
    </li>
    <li><a href="localization#overriding-package-language-files">Переопределение языковых файлов пакета <sup>Overriding package language files</sup></a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление <sup>Introduction</sup></a></h2>
<p>Функции локализации Laravel предоставляют удобный способ извлечения строк на разных языках, что позволяет легко
    поддерживать несколько языков в вашем приложении.</p>
<p>Laravel предоставляет два способа управления строками перевода. Во-первых, языковые строки могут храниться в файлах в
    <code>resources/lang</code> каталоге. В этом каталоге могут быть подкаталоги для каждого языка, поддерживаемого
    приложением. Это подход, который Laravel использует для управления строками перевода для встроенных функций Laravel,
    таких как сообщения об ошибках проверки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">/</span>resources
    <span class="token operator">/</span>lang
        <span class="token operator">/</span>en
            messages<span class="token punctuation">.</span>php
        <span class="token operator">/</span>es
            messages<span class="token punctuation">.</span>php</code></pre>
<p>Или строки перевода могут быть определены в файлах JSON, помещенных в <code>resources/lang</code> каталог. При таком
    подходе каждый язык, поддерживаемый вашим приложением, будет иметь соответствующий файл JSON в этом каталоге. Этот
    подход рекомендуется для приложений с большим количеством переводимых строк:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">/</span>resources
    <span class="token operator">/</span>lang
        en<span class="token punctuation">.</span>json
        es<span class="token punctuation">.</span>json</code></pre>
<p>Мы обсудим каждый подход к управлению строками перевода в этой документации.</p>
<p></p>
<h3 id="configuring-the-locale"><a href="#configuring-the-locale">Настройка локали <sup>Configuring the locale</sup></a></h3>
<p>Язык по умолчанию для вашего приложения хранится в параметре <code>config/app.php</code> конфигурации файла <code>locale</code>
    конфигурации. Вы можете изменить это значение в соответствии с потребностями вашего приложения.</p>
<p>Вы можете изменить язык по умолчанию для одного HTTP-запроса во время выполнения, используя <code>setLocale</code>
    метод, предоставляемый <code>App</code> фасадом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>App</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/greeting/{literal}{locale}{/literal}'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$locale</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">if</span> <span class="token punctuation">(</span><span
                class="token operator">!</span> <span class="token function">in_array</span><span
                class="token punctuation">(</span><span class="token variable">$locale</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'en'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'es'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'fr'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
        <span class="token function">abort</span><span class="token punctuation">(</span><span class="token number">400</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
            
    App<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">setLocale</span><span class="token punctuation">(</span><span
                class="token variable">$locale</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
            
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы можете настроить «запасной язык», который будет использоваться, когда активный язык не содержит заданной строки
    перевода. Как и язык по умолчанию, резервный язык также настраивается в <code>config/app.php</code> файле
    конфигурации:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'fallback_locale'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'en'</span><span
                class="token punctuation">,</span></code></pre>
<p></p>
<h4 id="determining-the-current-locale"><a href="#determining-the-current-locale">Определение текущего языкового
        стандарта</a></h4>
<p>Вы можете использовать <code>currentLocale</code> и <code>isLocale</code> методы на <code>App</code> фасаде для
    определения текущей локали или проверить, если локаль заданное значение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>App</span><span
                class="token punctuation">;</span>

<span class="token variable">$locale</span> <span class="token operator">=</span> App<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">currentLocale</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token keyword">if</span> <span class="token punctuation">(</span>App<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">isLocale</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'en'</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h2 id="defining-translation-strings"><a href="#defining-translation-strings">Определение строк перевода <sup>Defining translation strings</sup></a></h2>
<p></p>
<h3 id="using-short-keys"><a href="#using-short-keys">Использование коротких клавиш <sup>Using short keys</sup></a></h3>
<p>Обычно строки перевода хранятся в файлах в <code>resources/lang</code> каталоге. В этом каталоге должен быть
    подкаталог для каждого языка, поддерживаемого вашим приложением. Это подход, который Laravel использует для
    управления строками перевода для встроенных функций Laravel, таких как сообщения об ошибках проверки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">/</span>resources
    <span class="token operator">/</span>lang
        <span class="token operator">/</span>en
            messages<span class="token punctuation">.</span>php
        <span class="token operator">/</span>es
            messages<span class="token punctuation">.</span>php</code></pre>
<p>Все языковые файлы возвращают массив строк с ключами. Например:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token comment">// resources/lang/en/messages.php</span>

<span class="token keyword">return</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'welcome'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token single-quoted-string string">'Welcome to our application!'</span><span
                    class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">;</span></span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p> Для языков, которые различаются по территории, вы должны назвать языковые каталоги в соответствии с ISO
            15897. Например, для британского английского следует использовать «en_GB», а не «en-gb».</p></p></div>
</blockquote>
<p></p>
<h3 id="using-translation-strings-as-keys"><a href="#using-translation-strings-as-keys">Использование строк перевода в
        качестве ключей <sup>Using translation strings ss keys</sup></a></h3>
<p>Для приложений с большим количеством переводимых строк определение каждой строки с помощью «короткого ключа» может
    сбивать с толку при обращении к ключам в ваших представлениях, и постоянно изобретать ключи для каждой строки
    перевода, поддерживаемой вашим приложением, затруднительно.</p>
<p>По этой причине Laravel также предоставляет поддержку для определения строк перевода с использованием перевода строки
    «по умолчанию» в качестве ключа. Файлы перевода, которые используют строки перевода в качестве ключей, хранятся в
    каталоге в виде файлов JSON <code>resources/lang</code>. Например, если ваше приложение имеет испанский перевод, вы
    должны создать <code>resources/lang/es.json</code> файл:</p>
<pre class=" language-js"><code class=" language-js"><span class="token punctuation">{literal}{{/literal}</span>
    <span class="token string">"I love programming."</span><span class="token operator">:</span> <span
                class="token string">"Me encanta programar."</span>
<span class="token punctuation">}</span></code></pre>
<h4>Конфликты ключей / файлов</h4>
<p>Вы не должны определять ключи строки перевода, которые конфликтуют с другими именами файлов перевода. Например,
    перевод <code>__('Action')</code> для языкового стандарта «NL», когда <code>nl/action.php</code> файл существует, но
    <code>nl.json</code> файл не существует, приведет к тому, что переводчик вернет содержимое
    <code>nl/action.php</code>.</p>
<p></p>
<h2 id="retrieving-translation-strings"><a href="#retrieving-translation-strings">Получение строк перевода <sup>Retrieving translation strings</sup></a></h2>
<p>Вы можете получить строки перевода из своих языковых файлов с помощью <code>__</code> вспомогательной функции. Если
    вы используете «короткие ключи» для определения строк перевода, вы должны передать файл, содержащий ключ, и сам ключ
    в <code>__</code> функцию, используя синтаксис «точка». Например, давайте извлечем <code>welcome</code> строку
    перевода из <code>resources/lang/en/messages.php</code> языкового файла:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">echo</span> <span
                class="token function">__</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'messages.welcome'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если указанная строка перевода не существует, <code>__</code> функция вернет ключ строки перевода. Итак, используя
    приведенный выше пример, <code>__</code> функция вернется, <code>messages.welcome</code> если строка перевода не
    существует.</p>
<p>Если вы используете <a href="localization#using-translation-strings-as-keys">строки перевода по умолчанию в качестве
        ключей перевода</a>, вы должны передать перевод вашей строки по умолчанию в <code>__</code> функцию;</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">echo</span> <span
                class="token function">__</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'I love programming.'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Опять же, если строка перевода не существует, <code>__</code> функция вернет ключ строки перевода, который ей был
    дан.</p>
<p>Если вы используете <a href="blade">шаблонизатор Blade</a>, вы можете использовать
    <code>{literal}{{ }}{/literal}</code> синтаксис echo для отображения строки перевода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token punctuation">{literal}{{/literal}</span><span
                class="token punctuation">{literal}{{/literal}</span> <span class="token function">__</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'messages.welcome'</span><span
                class="token punctuation">)</span> <span class="token punctuation">}</span><span
                class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="replacing-parameters-in-translation-strings"><a href="#replacing-parameters-in-translation-strings">Замена
        параметров в строках перевода <sup>Replacing parameters in translation strings</sup></a></h3>
<p>При желании вы можете определить заполнители в строках перевода. Все заполнители имеют префикс <code>:</code>.
    Например, вы можете определить приветственное сообщение с именем-заполнителем:</p>
<pre class=" language-php"><code class=" language-php"><span class="token single-quoted-string string">'welcome'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Welcome, :name'</span><span
                class="token punctuation">,</span></code></pre>
<p>Чтобы заменить заполнители при получении строки перевода, вы можете передать массив замен в качестве второго
    аргумента <code>__</code> функции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">echo</span> <span
                class="token function">__</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'messages.welcome'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'dayle'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Если ваш заполнитель содержит все заглавные буквы или имеет заглавную только первую букву, переведенное значение
    будет соответственно заглавным:</p>
<pre class=" language-php"><code class=" language-php"><span class="token single-quoted-string string">'welcome'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Welcome, :NAME'</span><span
                class="token punctuation">,</span> <span class="token comment">// Welcome, DAYLE</span>
<span class="token single-quoted-string string">'goodbye'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Goodbye, :Name'</span><span
                class="token punctuation">,</span> <span class="token comment">// Goodbye, Dayle</span></code></pre>
<p></p>
<h3 id="pluralization"><a href="#pluralization">Плюрализация <sup>Pluralization</sup></a></h3>
<p>Плюрализация - сложная проблема, поскольку разные языки имеют множество сложных правил плюрализации; однако Laravel
    может помочь вам переводить строки по-разному в зависимости от правил множественного числа, которые вы определяете.
    Используя <code>|</code> символ, вы можете различать формы единственного и множественного числа строки:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'apples'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'There is one apple|There are many apples'</span><span
                class="token punctuation">,</span></code></pre>
<p>Конечно, плюрализация также поддерживается при использовании <a
            href="localization#using-translation-strings-as-keys">строк перевода в качестве ключей</a>:</p>
<pre class=" language-js"><code class=" language-js"><span class="token punctuation">{literal}{{/literal}</span>
    <span class="token string">"There is one apple|There are many apples"</span><span
                class="token operator">:</span> <span class="token string">"Hay una manzana|Hay muchas manzanas"</span>
<span class="token punctuation">}</span></code></pre>
<p>Вы даже можете создать более сложные правила множественного числа, которые определяют строки перевода для нескольких
    диапазонов значений:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'apples'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'{literal}{0}{/literal} There are none|[1,19] There are some|[20,*] There are many'</span><span
                class="token punctuation">,</span></code></pre>
<p>После определения строки перевода, которая имеет параметры множественного числа, вы можете использовать <code>trans_choice</code>
    функцию для получения строки для заданного «счетчика». В этом примере, поскольку счетчик больше единицы,
    возвращается форма множественного числа строки перевода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">echo</span> <span
                class="token function">trans_choice</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'messages.apples'</span><span
                class="token punctuation">,</span> <span class="token number">10</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы также можете определить атрибуты заполнителя в строках множественного числа. Эти заполнители можно заменить,
    передав массив в качестве третьего аргумента <code>trans_choice</code> функции:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'minutes_ago'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'{literal}{1}{/literal} :value minute ago|[2,*] :value minutes ago'</span><span
                class="token punctuation">,</span>

<span class="token keyword">echo</span> <span class="token function">trans_choice</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'time.minutes_ago'</span><span
                class="token punctuation">,</span> <span class="token number">5</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'value'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">5</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Если вы хотите отобразить целочисленное значение, переданное <code>trans_choice</code> функции, вы можете
    использовать встроенный <code>:count</code> заполнитель:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'apples'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'{literal}{0}{/literal} There are none|{literal}{1}{/literal} There is one|[2,*] There are :count'</span><span
                class="token punctuation">,</span></code></pre>
<p></p>
<h2 id="overriding-package-language-files"><a href="#overriding-package-language-files">Переопределение языковых файлов
        пакета <sup>Overriding package language files</sup></a></h2>
<p>Некоторые пакеты могут поставляться с собственными языковыми файлами. Вместо того, чтобы изменять основные файлы
    пакета для настройки этих строк, вы можете переопределить их, поместив файлы в каталог
    <code>resources/lang/vendor/{literal}{package}{/literal}/{literal}{locale}{/literal}</code>.</p>
<p>Так, например, если вам необходимо изменить строки в переводе на английском языке <code>messages.php</code> для
    пакета с именем <code>skyrim/hearthfire</code>, вы должны поместить файл языка по адресу: <code>resources/lang/vendor/hearthfire/en/messages.php</code>.
    В этом файле вы должны определять только те строки перевода, которые хотите переопределить. Любые строки перевода,
    которые вы не отменяете, все равно будут загружаться из исходных языковых файлов пакета.</p>
