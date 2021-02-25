<h1>БД: построитель запросов <sup>Query builder</sup></h1>
<ul>
    <li><a href="queries#introduction">Вступление</a></li>
    <li><a href="queries#running-database-queries">Выполнение запросов к базе данных</a>
        <ul>
            <li><a href="queries#chunking-results">Разделение результатов</a></li>
            <li><a href="queries#aggregates">Агрегаты</a></li>
        </ul>
    </li>
    <li><a href="queries#select-statements">Выбрать заявления</a></li>
    <li><a href="queries#raw-expressions">Необработанные выражения</a></li>
    <li><a href="queries#joins">Присоединяется</a></li>
    <li><a href="queries#unions">Союзы</a></li>
    <li><a href="queries#basic-where-clauses">Основные предложения Where</a>
        <ul>
            <li><a href="queries#where-clauses">Где пункты</a></li>
            <li><a href="queries#or-where-clauses">Или где статьи</a></li>
            <li><a href="queries#json-where-clauses">JSON, где предложения</a></li>
            <li><a href="queries#additional-where-clauses">Дополнительные условия Where</a></li>
            <li><a href="queries#logical-grouping">Логическая группировка</a></li>
        </ul>
    </li>
    <li><a href="queries#advanced-where-clauses">Расширенные предложения Where</a>
        <ul>
            <li><a href="queries#where-exists-clauses">Где существуют пункты</a></li>
            <li><a href="queries#subquery-where-clauses">Подзапрос Where Clauses</a></li>
        </ul>
    </li>
    <li><a href="queries#ordering-grouping-limit-and-offset">Упорядочивание, группировка, ограничение и смещение</a>
        <ul>
            <li><a href="queries#ordering">Заказ</a></li>
            <li><a href="queries#grouping">Группировка</a></li>
            <li><a href="queries#limit-and-offset">Предел и смещение</a></li>
        </ul>
    </li>
    <li><a href="queries#conditional-clauses">Условные предложения</a></li>
    <li><a href="queries#insert-statements">Вставить заявления</a>
        <ul>
            <li><a href="queries#upserts">Upserts</a></li>
        </ul>
    </li>
    <li><a href="queries#update-statements">Обновить заявления</a>
        <ul>
            <li><a href="queries#updating-json-columns">Обновление столбцов JSON</a></li>
            <li><a href="queries#increment-and-decrement">Увеличение и уменьшение</a></li>
        </ul>
    </li>
    <li><a href="queries#delete-statements">Удалить заявления</a></li>
    <li><a href="queries#pessimistic-locking">Пессимистическая блокировка</a></li>
    <li><a href="queries#debugging">Отладка</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Конструктор запросов к базе данных Laravel предоставляет удобный и понятный интерфейс для создания и выполнения
    запросов к базе данных. Его можно использовать для выполнения большинства операций с базой данных в вашем
    приложении, и он отлично работает со всеми поддерживаемыми Laravel системами баз данных.</p>
<p>Конструктор запросов Laravel использует привязку параметров PDO для защиты вашего приложения от атак SQL-инъекций.
    Нет необходимости очищать или дезинфицировать строки, переданные в построитель запросов в качестве привязок
    запросов.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>PDO не поддерживает имена столбцов привязки. Следовательно, вы никогда не должны позволять пользовательскому
            вводу диктовать имена столбцов, на которые ссылаются ваши запросы, включая столбцы «порядок по».</p></p>
    </div>
</blockquote>
<p></p>
<h2 id="running-database-queries"><a href="#running-database-queries">Выполнение запросов к базе данных</a></h2>
<p></p>
<h4 id="retrieving-all-rows-from-a-table"><a href="#retrieving-all-rows-from-a-table">Получение всех строк из
        таблицы</a></h4>
<p>Вы можете использовать <code>table</code> метод, предоставляемый <code>DB</code> фасадом, чтобы начать запрос. <code>table</code>
    Метод возвращает беглый экземпляр построителя запросов для данной таблицы, что позволяет цепи более ограничений на
    запрос, а затем, наконец, получить результаты запроса с использованием <code>get</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>Controller</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span class="token punctuation">\</span>DB</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">UserController</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
<span class="token comment">/**
* Show a list of all of the application's users.
     *
     * @return \Illuminate\Http\Response
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">index</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$users</span> <span class="token operator">=</span> <span
                    class="token constant">DB</span><span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token function">table</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'users'</span><span
                    class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">get</span><span class="token punctuation">(</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token keyword">return</span> <span class="token function">view</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'user.index'</span><span
                    class="token punctuation">,</span> <span class="token punctuation">[</span><span
                    class="token single-quoted-string string">'users'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token variable">$users</span><span
                    class="token punctuation">]</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p><code>get</code> Метод возвращает <code>Illuminate\Support\Collection</code> содержащие результаты запроса, где
    каждый результат является экземпляром РНР <code>stdClass</code> объекта. Вы можете получить доступ к значению
    каждого столбца, обратившись к столбцу как к свойству объекта:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>DB</span><span
                class="token punctuation">;</span>

<span class="token variable">$users</span> <span class="token operator">=</span> <span
                class="token constant">DB</span><span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">table</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'users'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">foreach</span> <span class="token punctuation">(</span><span
                class="token variable">$users</span> <span class="token keyword">as</span> <span class="token variable">$user</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">echo</span> <span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">name</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Коллекции Laravel предоставляют множество чрезвычайно мощных методов для сопоставления и сокращения данных.
            Для получения дополнительной информации о коллекциях Laravel ознакомьтесь с <a href="collections">документацией</a>
            по <a href="collections">коллекции</a>.</p></p></div>
</blockquote>
<p></p>
<h4 id="retrieving-a-single-row-column-from-a-table"><a href="#retrieving-a-single-row-column-from-a-table">Получение
        одной строки / столбца из таблицы</a></h4>
<p>Если вам просто нужно получить одну строку из таблицы базы данных, вы можете использовать метод <code>DB</code>
    фасада <code>first</code>. Этот метод вернет один <code>stdClass</code> объект:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'John'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">first</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token keyword">return</span> <span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">email</span><span
                class="token punctuation">;</span></code></pre>
<p>Если вам не нужна вся строка, вы можете извлечь одно значение из записи с помощью этого <code>value</code> метода.
    Этот метод вернет значение столбца напрямую:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$email</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'John'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">value</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'email'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Чтобы получить одну строку по ее <code>id</code> значению столбца, используйте <code>find</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">3</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="retrieving-a-list-of-column-values"><a href="#retrieving-a-list-of-column-values">Получение списка значений
        столбца</a></h4>
<p>Если вы хотите получить <code>Illuminate\Support\Collection</code> экземпляр, содержащий значения одного столбца, вы
    можете использовать этот <code>pluck</code> метод. В этом примере мы получим коллекцию заголовков пользователей:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>DB</span><span
                class="token punctuation">;</span>

<span class="token variable">$titles</span> <span class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">pluck</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'title'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">foreach</span> <span class="token punctuation">(</span><span
                class="token variable">$titles</span> <span class="token keyword">as</span> <span
                class="token variable">$title</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">echo</span> <span class="token variable">$title</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Вы можете указать столбец, который результирующая коллекция должна использовать в качестве ключей, указав второй
    аргумент <code>pluck</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$titles</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">pluck</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'title'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">foreach</span> <span class="token punctuation">(</span><span
                class="token variable">$titles</span> <span class="token keyword">as</span> <span
                class="token variable">$name</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token variable">$title</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">echo</span> <span class="token variable">$title</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="chunking-results"><a href="#chunking-results">Разделение результатов</a></h3>
<p>Если вам нужно работать с тысячами записей базы данных, подумайте об использовании <code>chunk</code> метода,
    предоставляемого <code>DB</code> фасадом. Этот метод извлекает за раз небольшой фрагмент результатов и передает
    каждый фрагмент в закрытие для обработки. Например, давайте извлечем всю <code>users</code> таблицу кусками по 100
    записей за раз:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>DB</span><span
                class="token punctuation">;</span>

<span class="token constant">DB</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">orderBy</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'id'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">chunk</span><span
                class="token punctuation">(</span><span class="token number">100</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$users</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">foreach</span> <span class="token punctuation">(</span><span class="token variable">$users</span> <span
                class="token keyword">as</span> <span class="token variable">$user</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете остановить обработку следующих фрагментов, вернувшись <code>false</code> из закрытия:</p>
<pre class=" language-php"><code class=" language-php"><span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">orderBy</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'id'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">chunk</span><span
                class="token punctuation">(</span><span class="token number">100</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$users</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// Process the records...</span>

    <span class="token keyword">return</span> <span class="token boolean constant">false</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если вы обновляете записи базы данных во время фрагментирования результатов, результаты ваших фрагментов могут
    измениться неожиданным образом. Если вы планируете обновлять полученные записи при фрагментировании, всегда лучше
    использовать этот <code>chunkById</code> метод. Этот метод автоматически разбивает результаты на страницы на основе
    первичного ключа записи:</p>
<pre class=" language-php"><code class=" language-php"><span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'active'</span><span
                class="token punctuation">,</span> <span class="token boolean constant">false</span><span
                class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">chunkById</span><span class="token punctuation">(</span><span
                class="token number">100</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$users</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">foreach</span> <span class="token punctuation">(</span><span class="token variable">$users</span> <span
                class="token keyword">as</span> <span class="token variable">$user</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token constant">DB</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">where</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'id'</span><span class="token punctuation">,</span> <span
                class="token variable">$user</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">update</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'active'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token boolean constant">true</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>При обновлении или удалении записей внутри обратного вызова фрагмента любые изменения первичного ключа или
            внешних ключей могут повлиять на запрос фрагмента. Это может потенциально привести к тому, что записи не
            будут включены в результаты по фрагментам.</p></p></div>
</blockquote>
<p></p>
<h3 id="aggregates"><a href="#aggregates">Агрегаты</a></h3>
<p>Конструктор запросов также предоставляет различные методы для извлечения агрегированных значений, как
    <code>count</code>, <code>max</code>, <code>min</code>, <code>avg</code>, и <code>sum</code>. После создания запроса
    вы можете вызвать любой из этих методов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>DB</span><span
                class="token punctuation">;</span>

<span class="token variable">$users</span> <span class="token operator">=</span> <span
                class="token constant">DB</span><span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">table</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'users'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">count</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$price</span> <span class="token operator">=</span> <span
                class="token constant">DB</span><span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">table</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'orders'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">max</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'price'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Конечно, вы можете комбинировать эти методы с другими предложениями, чтобы точно настроить способ вычисления вашего
    совокупного значения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$price</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'orders'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">where</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'finalized'</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">avg</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'price'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="determining-if-records-exist"><a href="#determining-if-records-exist">Определение наличия записей</a></h4>
<p>Вместо того, чтобы использовать <code>count</code> метод, чтобы определить, какие записи существуют, которые
    соответствуют ограничениям вашего запроса, вы можете использовать <code>exists</code> и <code>doesntExist</code>
    методы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">if</span> <span
                class="token punctuation">(</span><span class="token constant">DB</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'orders'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">where</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'finalized'</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">exists</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//...</span>
<span class="token punctuation">}</span>

<span class="token keyword">if</span> <span class="token punctuation">(</span><span
                class="token constant">DB</span><span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">table</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'orders'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">where</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'finalized'</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">doesntExist</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//...</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h2 id="select-statements"><a href="#select-statements">Выбрать заявления</a></h2>
<p></p>
<h4 id="specifying-a-select-clause"><a href="#specifying-a-select-clause">Указание предложения Select</a></h4>
<p>Возможно, вам не всегда нужно выбирать все столбцы из таблицы базы данных. Используя этот <code>select</code> метод,
    вы можете указать настраиваемое предложение «select» для запроса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>DB</span><span
                class="token punctuation">;</span>

<span class="token variable">$users</span> <span class="token operator">=</span> <span
                class="token constant">DB</span><span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">table</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'users'</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">select</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'email as user_email'</span><span
                class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Этот <code>distinct</code> метод позволяет заставить запрос возвращать отличные результаты:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">distinct</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если у вас уже есть экземпляр построителя запросов и вы хотите добавить столбец к его существующему предложению
    select, вы можете использовать <code>addSelect</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$query</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">select</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$users</span> <span class="token operator">=</span> <span
                class="token variable">$query</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">addSelect</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'age'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="raw-expressions"><a href="#raw-expressions">Необработанные выражения</a></h2>
<p>Иногда вам может понадобиться вставить в запрос произвольную строку. Чтобы создать необработанное строковое
    выражение, вы можете использовать <code>raw</code> метод, предоставляемый <code>DB</code> фасадом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
             <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">select</span><span
                class="token punctuation">(</span><span class="token constant">DB</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">raw</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'count(*) as user_count, status'</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span>
             <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'status'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'&lt;&gt;'</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">)</span>
             <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">groupBy</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'status'</span><span
                class="token punctuation">)</span>
             <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p> Необработанные операторы будут вставлены в запрос в виде строк, поэтому следует проявлять особую
            осторожность, чтобы не создавать уязвимости для SQL-инъекций.</p></p></div>
</blockquote>
<p></p>
<h3 id="raw-methods"><a href="#raw-methods">Необработанные методы</a></h3>
<p>Вместо использования <code>DB::raw</code> метода вы также можете использовать следующие методы для вставки
    необработанного выражения в различные части вашего запроса. <strong>Помните, Laravel не может гарантировать, что
        любой запрос, использующий необработанные выражения, защищен от уязвимостей SQL-инъекций.</strong></p>
<p></p>
<h4 id="selectraw"><a href="#selectraw"><code>selectRaw</code></a></h4>
<p><code>selectRaw</code> Метод может быть использован вместо <code>addSelect(DB::raw(...))</code>. Этот метод принимает
    необязательный массив привязок в качестве второго аргумента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$orders</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'orders'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">selectRaw</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'price * ? as price_with_tax'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span class="token number">1.0825</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="whereraw-orwhereraw"><a href="#whereraw-orwhereraw"><code>whereRaw / orWhereRaw</code></a></h4>
<p><code>whereRaw</code> И <code>orWhereRaw</code> методы могут быть использованы для введения сырой « где» пункт в
    вашем запросе. Эти методы принимают необязательный массив привязок в качестве второго аргумента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$orders</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'orders'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">whereRaw</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'price &gt; IF(state = "TX", ?, 100)'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span class="token number">200</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="havingraw-orhavingraw"><a href="#havingraw-orhavingraw"><code>havingRaw / orHavingRaw</code></a></h4>
<p><code>havingRaw</code> И <code>orHavingRaw</code> способы могут быть использованы дл получени исходного строку в
    качестве значения « имеющего» п. Эти методы принимают необязательный массив привязок в качестве второго аргумента:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$orders</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'orders'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">select</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'department'</span><span
                class="token punctuation">,</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">raw</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'SUM(price) as total_sales'</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">groupBy</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'department'</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">havingRaw</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'SUM(price) &gt; ?'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span class="token number">2500</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="orderbyraw"><a href="#orderbyraw"><code>orderByRaw</code></a></h4>
<p>Этот <code>orderByRaw</code> метод может использоваться для предоставления необработанной строки в качестве значения
    предложения «порядок по»:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$orders</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'orders'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">orderByRaw</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'updated_at - created_at DESC'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="groupbyraw"><a href="#groupbyraw"><code>groupByRaw</code></a></h3>
<p><code>groupByRaw</code> Способ может быть использован дл получени исходную строки в качестве значения <code>group
        by</code> пункта:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$orders</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'orders'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">select</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'city'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'state'</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">groupByRaw</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'city, state'</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="joins"><a href="#joins">Присоединяется</a></h2>
<p></p>
<h4 id="inner-join-clause"><a href="#inner-join-clause">Предложение внутреннего соединения</a></h4>
<p>Конструктор запросов также может использоваться для добавления предложений соединения к вашим запросам. Чтобы
    выполнить базовое «внутреннее соединение», вы можете использовать этот <code>join</code> метод в экземпляре
    построителя запросов. Первым аргументом, передаваемым <code>join</code> методу, является имя таблицы, к которой
    необходимо присоединиться, а остальные аргументы определяют ограничения столбца для соединения. Вы даже можете
    объединить несколько таблиц в один запрос:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>DB</span><span
                class="token punctuation">;</span>

<span class="token variable">$users</span> <span class="token operator">=</span> <span
                class="token constant">DB</span><span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">table</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'users'</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">join</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'contacts'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'users.id'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'='</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'contacts.user_id'</span><span
                class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">join</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'orders'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'users.id'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'='</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'orders.user_id'</span><span
                class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">select</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users.*'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'contacts.phone'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'orders.price'</span><span
                class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="left-join-right-join-clause"><a href="#left-join-right-join-clause">Предложение Left Join / Right Join</a></h4>
<p>Если вы хотите выполнить «левое соединение» или «правое соединение» вместо «внутреннего соединения», используйте
    методы <code>leftJoin</code> или <code>rightJoin</code>. Эти методы имеют ту же сигнатуру, что и <code>join</code>
    метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">leftJoin</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'posts'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'users.id'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'='</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'posts.user_id'</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$users</span> <span class="token operator">=</span> <span
                class="token constant">DB</span><span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">table</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'users'</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">rightJoin</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'posts'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'users.id'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'='</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'posts.user_id'</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="cross-join-clause"><a href="#cross-join-clause">Предложение о перекрестном соединении</a></h4>
<p>Вы можете использовать этот <code>crossJoin</code> метод для выполнения «перекрестного соединения». Перекрестные
    соединения создают декартово произведение между первой таблицей и объединенной таблицей:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$sizes</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'sizes'</span><span
                class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">crossJoin</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'colors'</span><span
                class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="advanced-join-clauses"><a href="#advanced-join-clauses">Дополнительные условия соединения <sup>Advanced join clauses</sup></a></h4>
<p>Вы также можете указать более сложные условия соединения. Для начала передайте закрытие в качестве второго аргумента
    <code>join</code> метода. Замыкание получит <code>Illuminate\Database\Query\JoinClause</code> экземпляр, который
    позволит вам указать ограничения для предложения "join":</p>
<pre class=" language-php"><code class=" language-php"><span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">join</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'contacts'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$join</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token variable">$join</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">on</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'users.id'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'='</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'contacts.user_id'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">orOn</span><span
                class="token punctuation">(</span><span class="token punctuation">.</span><span
                class="token punctuation">.</span><span class="token punctuation">.</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если вы хотели бы использовать « где» пункт о вашем соединении, вы можете использовать <code>where</code> и <code>orWhere</code>
    методы, предоставляемые, <code>JoinClause</code> например. Вместо сравнения двух столбцов эти методы будут
    сравнивать столбец со значением:</p>
<pre class=" language-php"><code class=" language-php"><span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">join</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'contacts'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$join</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token variable">$join</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">on</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'users.id'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'='</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'contacts.user_id'</span><span
                class="token punctuation">)</span>
                 <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">where</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'contacts.user_id'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'&gt;'</span><span
                class="token punctuation">,</span> <span class="token number">5</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="subquery-joins"><a href="#subquery-joins">Присоединение подзапроса <sup>Subquery joins</sup></a></h4>
<p>Вы можете использовать <code>joinSub</code>, <code>leftJoinSub</code> и <code>rightJoinSub</code> методы, чтобы
    присоединиться к запросу подзапроса. Каждый из этих методов получает три аргумента: подзапрос, псевдоним таблицы и
    замыкание, определяющее связанные столбцы. В этом примере мы получим коллекцию пользователей, в которой каждая
    запись пользователя также содержит <code>created_at</code> отметку времени последнего опубликованного сообщения в
    блоге пользователя:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$latestPosts</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'posts'</span><span
                class="token punctuation">)</span>
                   <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">select</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'user_id'</span><span class="token punctuation">,</span> <span
                class="token constant">DB</span><span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">raw</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'MAX(created_at) as last_post_created_at'</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span>
                   <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">where</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'is_published'</span><span class="token punctuation">,</span> <span
                class="token boolean constant">true</span><span class="token punctuation">)</span>
                   <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">groupBy</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'user_id'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$users</span> <span class="token operator">=</span> <span
                class="token constant">DB</span><span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">table</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'users'</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">joinSub</span><span
                class="token punctuation">(</span><span class="token variable">$latestPosts</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'latest_posts'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$join</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token variable">$join</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">on</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'users.id'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'='</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'latest_posts.user_id'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="unions"><a href="#unions">Объединения <sup>Unions</sup></a></h2>
<p>Построитель запросов также предоставляет удобный метод «объединения» двух или более запросов вместе. Например, вы
    можете создать начальный запрос и использовать <code>union</code> метод для объединения его с другими запросами:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>DB</span><span
                class="token punctuation">;</span>

<span class="token variable">$first</span> <span class="token operator">=</span> <span
                class="token constant">DB</span><span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">table</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'users'</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">whereNull</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'first_name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$users</span> <span class="token operator">=</span> <span
                class="token constant">DB</span><span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">table</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'users'</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">whereNull</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'last_name'</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">union</span><span
                class="token punctuation">(</span><span class="token variable">$first</span><span
                class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>В дополнение к <code>union</code> методу построитель запросов предоставляет <code>unionAll</code> метод. Для
    запросов, которые объединены с помощью этого <code>unionAll</code> метода, не удаляются повторяющиеся результаты.
    <code>unionAll</code> Метод имеет один и тот же метод подписи в качестве <code>union</code> метода.</p>
<p></p>
<h2 id="basic-where-clauses"><a href="#basic-where-clauses">Основные условия Where <sup>Basic where clauses</sup></a></h2>
<p></p>
<h3 id="where-clauses"><a href="#where-clauses">Условия Where <sup>Where clauses</sup></a></h3>
<p>Вы можете использовать метод построителя запросов, <code>where</code> чтобы добавить в запрос предложения «where».
    Самый простой вызов <code>where</code> метода требует трех аргументов. Первый аргумент - это имя столбца. Второй
    аргумент - это оператор, который может быть любым из поддерживаемых базой данных операторов. Третий аргумент - это
    значение, которое нужно сравнить со значением столбца.</p>
<p>Например, следующий запрос извлекает пользователей, у которых значение <code>votes</code> столбца равно,
    <code>100</code> а значение <code>age</code> столбца больше, чем <code>35</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">where</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'votes'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'='</span><span class="token punctuation">,</span> <span
                class="token number">100</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">where</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'age'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'&gt;'</span><span class="token punctuation">,</span> <span
                class="token number">35</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Для удобства, если вы хотите проверить, соответствует ли столбец <code>=</code> заданному значению, вы можете
    передать это значение в качестве второго аргумента <code>where</code> метода. Laravel предполагает, что вы хотите
    использовать <code>=</code> оператор:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'votes'</span><span
                class="token punctuation">,</span> <span class="token number">100</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Как упоминалось ранее, вы можете использовать любой оператор, который поддерживается вашей системой баз данных:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">where</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'votes'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'&gt;='</span><span class="token punctuation">,</span> <span
                class="token number">100</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$users</span> <span class="token operator">=</span> <span
                class="token constant">DB</span><span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">table</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'users'</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">where</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'votes'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'&lt;&gt;'</span><span
                class="token punctuation">,</span> <span class="token number">100</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$users</span> <span class="token operator">=</span> <span
                class="token constant">DB</span><span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">table</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'users'</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">where</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'name'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'like'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'T%'</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы также можете передать в функцию массив условий <code>where</code>. Каждый элемент массива должен быть массивом,
    содержащим три аргумента, которые обычно передаются <code>where</code> методу:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'status'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'='</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'1'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'subscribed'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'&lt;&gt;'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'1'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="or-where-clauses"><a href="#or-where-clauses">Условия Or Where <sup>Or Where clauses</sup></a></h3>
<p>При объединении вызовов <code>where</code> метода построителя запросов в цепочку предложения where будут объединены
    вместе с помощью <code>and</code> оператора. Однако вы можете использовать этот <code>orWhere</code> метод для
    присоединения предложения к запросу с помощью <code>or</code> оператора. <code>orWhere</code> Метод принимает те же
    аргументы, что и <code>where</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
                    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">where</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'votes'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'&gt;'</span><span class="token punctuation">,</span> <span
                class="token number">100</span><span class="token punctuation">)</span>
                    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">orWhere</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'name'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'John'</span><span class="token punctuation">)</span>
                    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если вам нужно сгруппировать условие «или» в круглых скобках, вы можете передать закрытие в качестве первого
    аргумента <code>orWhere</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'votes'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'&gt;'</span><span
                class="token punctuation">,</span> <span class="token number">100</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">orWhere</span><span
                class="token punctuation">(</span><span class="token keyword">function</span><span
                class="token punctuation">(</span><span class="token variable">$query</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
                <span class="token variable">$query</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'Abigail'</span><span
                class="token punctuation">)</span>
                      <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">where</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'votes'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'&gt;'</span><span class="token punctuation">,</span> <span
                class="token number">50</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>В приведенном выше примере будет получен следующий SQL:</p>
<pre class=" language-sql"><code class=" language-sql"><span class="token keyword">select</span> <span
                class="token operator">*</span> <span class="token keyword">from</span> users <span
                class="token keyword">where</span> votes <span class="token operator">&gt;</span> <span
                class="token number">100</span> <span class="token operator">or</span> <span
                class="token punctuation">(</span>name <span class="token operator">=</span> <span class="token string">'Abigail'</span> <span
                class="token operator">and</span> votes <span class="token operator">&gt;</span> <span
                class="token number">50</span><span class="token punctuation">)</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Вы всегда должны группировать <code>orWhere</code> вызовы, чтобы избежать неожиданного поведения при
            применении глобальных областей.</p></p></div>
</blockquote>
<p></p>
<h3 id="json-where-clauses"><a href="#json-where-clauses">Условия JSON Where <sup>JSON Where clauses</sup></a></h3>
<p>Laravel также поддерживает запросы типов столбцов JSON в базах данных, которые обеспечивают поддержку типов столбцов
    JSON. В настоящее время это MySQL 5.7+, PostgreSQL, SQL Server 2016 и SQLite 3.9.0 (с <a
            href="https://www.sqlite.org/json1.html">расширением JSON1</a> ). Чтобы запросить столбец JSON, используйте
    <code>-&gt;</code> оператор:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">where</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'preferences-&gt;dining-&gt;meal'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'salad'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете использовать <code>whereJsonContains</code> для запроса массивов JSON. Эта функция не поддерживается базой
    данных SQLite:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">whereJsonContains</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'options-&gt;languages'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'en'</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если ваше приложение использует базы данных MySQL или PostgreSQL, вы можете передать в <code>whereJsonContains</code>
    метод массив значений:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">whereJsonContains</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'options-&gt;languages'</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span><span class="token single-quoted-string string">'en'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'de'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете использовать <code>whereJsonLength</code> метод для запроса массивов JSON по их длине:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">whereJsonLength</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'options-&gt;languages'</span><span class="token punctuation">,</span> <span
                class="token number">0</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$users</span> <span class="token operator">=</span> <span
                class="token constant">DB</span><span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">table</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'users'</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">whereJsonLength</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'options-&gt;languages'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'&gt;'</span><span class="token punctuation">,</span> <span
                class="token number">1</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="additional-where-clauses"><a href="#additional-where-clauses">Дополнительные условия Where <sup>Additional Where clauses</sup></a></h3>
<p><strong>whereBetween / orWhereBetween</strong></p>
<p>В <code>whereBetween</code> методе проверяет, что значение столбца находится между двумя значениями:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
           <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">whereBetween</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'votes'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">100</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span>
           <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p><strong>whereNotBetween / orWhereNotBetween</strong></p>
<p>В <code>whereNotBetween</code> методе проверяет, что столбец значения лежит за пределы двух значений:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
                    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">whereNotBetween</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'votes'</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span><span class="token number">1</span><span
                class="token punctuation">,</span> <span class="token number">100</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span>
                    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p><strong>whereIn / whereNotIn / orWhereIn / orWhereNotIn</strong></p>
<p>В <code>whereIn</code> методе проверяет, что значение данного столбца содержится в пределах данного массива:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
                    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">whereIn</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'id'</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span><span class="token number">1</span><span
                class="token punctuation">,</span> <span class="token number">2</span><span
                class="token punctuation">,</span> <span class="token number">3</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span>
                    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>В <code>whereNotIn</code> методе проверяет, что значение данного столбца не содержатся в данном массиве:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
                    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">whereNotIn</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'id'</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span><span class="token number">1</span><span
                class="token punctuation">,</span> <span class="token number">2</span><span
                class="token punctuation">,</span> <span class="token number">3</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span>
                    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Если вы добавляете в свой запрос большой массив целочисленных привязок, можно использовать методы <code>whereIntegerInRaw</code>
            или <code>whereIntegerNotInRaw</code> для значительного сокращения использования памяти.</p></p></div>
</blockquote>
<p><strong>whereNull / whereNotNull / orWhereNull / orWhereNotNull</strong></p>
<p>В <code>whereNull</code> методе проверяет, что значение данного столбца является <code>NULL</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">whereNull</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'updated_at'</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>В <code>whereNotNull</code> методе проверяет, что значения столбца не является <code>NULL</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">whereNotNull</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'updated_at'</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p><strong>whereDate / whereMonth / whereDay / whereYear / whereTime</strong></p>
<p>Этот <code>whereDate</code> метод можно использовать для сравнения значения столбца с датой:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">whereDate</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'created_at'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'2016-12-31'</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Этот <code>whereMonth</code> метод можно использовать для сравнения значения столбца с конкретным месяцем:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">whereMonth</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'created_at'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'12'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Этот <code>whereDay</code> метод можно использовать для сравнения значения столбца с определенным днем месяца:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">whereDay</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'created_at'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'31'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Этот <code>whereYear</code> метод можно использовать для сравнения значения столбца с конкретным годом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">whereYear</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'created_at'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'2016'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Этот <code>whereTime</code> метод можно использовать для сравнения значения столбца с определенным временем:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">whereTime</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'created_at'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'='</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'11:20:45'</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p><strong>whereColumn / orWhereColumn</strong></p>
<p>Этот <code>whereColumn</code> метод можно использовать для проверки равенства двух столбцов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">whereColumn</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'first_name'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'last_name'</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы также можете передать <code>whereColumn</code> методу оператор сравнения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">whereColumn</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'updated_at'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'&gt;'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'created_at'</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы также можете передать в <code>whereColumn</code> метод массив сравнений столбцов. Эти условия будут объединены с
    помощью <code>and</code> оператора:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">whereColumn</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span>
                    <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'first_name'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'='</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'last_name'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
                    <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'updated_at'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'&gt;'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'created_at'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
                <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="logical-grouping"><a href="#logical-grouping">Логическая группировка</a></h3>
<p>Иногда вам может потребоваться сгруппировать несколько предложений «where» в круглых скобках, чтобы добиться желаемой
    логической группировки вашего запроса. Фактически, вы обычно всегда должны группировать вызовы <code>orWhere</code>
    метода в круглых скобках, чтобы избежать неожиданного поведения запроса. Для этого вы можете передать закрытие
    <code>where</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
           <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'='</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'John'</span><span
                class="token punctuation">)</span>
           <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$query</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
               <span class="token variable">$query</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'votes'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'&gt;'</span><span
                class="token punctuation">,</span> <span class="token number">100</span><span class="token punctuation">)</span>
                     <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">orWhere</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'title'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'='</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Admin'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
           <span class="token punctuation">}</span><span class="token punctuation">)</span>
           <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Как видите, передача замыкания в <code>where</code> метод инструктирует построитель запросов начать группу
    ограничений. Замыкание получит экземпляр построителя запросов, который вы можете использовать для установки
    ограничений, которые должны содержаться в группе скобок. В приведенном выше примере будет получен следующий SQL:</p>
<pre class=" language-sql"><code class=" language-sql"><span class="token keyword">select</span> <span
                class="token operator">*</span> <span class="token keyword">from</span> users <span
                class="token keyword">where</span> name <span class="token operator">=</span> <span
                class="token string">'John'</span> <span class="token operator">and</span> <span
                class="token punctuation">(</span>votes <span class="token operator">&gt;</span> <span
                class="token number">100</span> <span class="token operator">or</span> title <span
                class="token operator">=</span> <span class="token string">'Admin'</span><span
                class="token punctuation">)</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Вы всегда должны группировать <code>orWhere</code> вызовы, чтобы избежать неожиданного поведения при
            применении глобальных областей.</p></p></div>
</blockquote>
<p></p>
<h3 id="advanced-where-clauses"><a href="#advanced-where-clauses">Расширенные условия Where <sup>Advanced Where clauses</sup></a></h3>
<p></p>
<h3 id="where-exists-clauses"><a href="#where-exists-clauses">Условия Where Exists <sup>Where Exists clauses</sup></a></h3>
<p><code>whereExists</code> Метод позволяет писать « где существует» SQL положения. <code>whereExists</code> Метод
    принимает замыкание, которое получит экземпляр построителя запросов, что позволяет определить запрос, который должен
    быть расположен внутри «существует» пункт:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
           <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">whereExists</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$query</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
               <span class="token variable">$query</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">select</span><span
                class="token punctuation">(</span><span class="token constant">DB</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">raw</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span>
                     <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">from</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'orders'</span><span class="token punctuation">)</span>
                     <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">whereColumn</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'orders.user_id'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'users.id'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
           <span class="token punctuation">}</span><span class="token punctuation">)</span>
           <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Приведенный выше запрос выдаст следующий SQL:</p>
<pre class=" language-sql"><code class=" language-sql"><span class="token keyword">select</span> <span
                class="token operator">*</span> <span class="token keyword">from</span> users
<span class="token keyword">where</span> <span class="token keyword">exists</span> <span
                class="token punctuation">(</span>
    <span class="token keyword">select</span> <span class="token number">1</span>
    <span class="token keyword">from</span> orders
    <span class="token keyword">where</span> orders<span class="token punctuation">.</span>user_id <span
                class="token operator">=</span> users<span class="token punctuation">.</span>id
<span class="token punctuation">)</span></code></pre>
<p></p>
<h3 id="subquery-where-clauses"><a href="#subquery-where-clauses">Подзапрос Where Clauses</a></h3>
<p>Иногда вам может потребоваться создать предложение «where», которое сравнивает результаты подзапроса с заданным
    значением. Вы можете сделать это, передав закрытие и значение <code>where</code> методу. Например, следующий запрос
    будет извлекать всех пользователей, недавно имевших "членство" данного типа;</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

<span class="token variable">$users</span> <span class="token operator">=</span> User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$query</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$query</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">select</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'type'</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">from</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'membership'</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">whereColumn</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'membership.user_id'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'users.id'</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">orderByDesc</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'membership.start_date'</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">limit</span><span class="token punctuation">(</span><span
                class="token number">1</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Pro'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Или вам может потребоваться создать предложение «where», которое сравнивает столбец с результатами подзапроса. Вы
    можете добиться этого, передав <code>where</code> методу столбец, оператор и закрытие. Например, следующий запрос
    будет извлекать все записи о доходах, где сумма меньше средней;</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Income</span><span class="token punctuation">;</span>

<span class="token variable">$incomes</span> <span class="token operator">=</span> Income<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'amount'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'&lt;'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$query</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$query</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">selectRaw</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'avg(i.amount)'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">from</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'incomes as i'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="ordering-grouping-limit-and-offset"><a href="#ordering-grouping-limit-and-offset">Упорядочивание, группировка,
        ограничение и смещение</a></h2>
<p></p>
<h3 id="ordering"><a href="#ordering">Заказ</a></h3>
<p></p>
<h4 id="orderby"><a href="#orderby"><code>orderBy</code> Метод</a></h4>
<p><code>orderBy</code> Метод позволяет отсортировать результаты запроса по данному колонку. Первый аргумент, принятый
    <code>orderBy</code> методом, должен быть столбцом, по которому вы хотите выполнить сортировку, а второй аргумент
    определяет направление сортировки и может быть либо, <code>asc</code> либо <code>desc</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">orderBy</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'name'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'desc'</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Для сортировки по нескольким столбцам вы можете просто вызывать <code>orderBy</code> столько раз, сколько необходимо:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">orderBy</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'name'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'desc'</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">orderBy</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'email'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'asc'</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="latest-oldest"><a href="#latest-oldest">В <code>latest</code> &amp; <code>oldest</code> Методы</a></h4>
<p><code>latest</code> И <code>oldest</code> методы позволяют легко результатам заказа по дате. По умолчанию результат
    будет упорядочен по <code>created_at</code> столбцу таблицы. Или вы можете передать имя столбца, по которому хотите
    сортировать:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">latest</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">first</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="random-ordering"><a href="#random-ordering">Случайный порядок</a></h4>
<p><code>inRandomOrder</code> Способ может быть использован для сортировки результатов запроса в случайном порядке.
    Например, вы можете использовать этот метод для выборки случайного пользователя:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$randomUser</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">inRandomOrder</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">first</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="removing-existing-orderings"><a href="#removing-existing-orderings">Удаление существующих заказов</a></h4>
<p><code>reorder</code> Метод удаляет все «распоряжение» положения, которые ранее были применены к запросу:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$query</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">orderBy</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$unorderedUsers</span> <span class="token operator">=</span> <span class="token variable">$query</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">reorder</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете передать столбец и направление при вызове <code>reorder</code> метода, чтобы удалить все существующие
    предложения «порядок по» и применить к запросу совершенно новый порядок:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$query</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">orderBy</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$usersOrderedByEmail</span> <span class="token operator">=</span> <span
                class="token variable">$query</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">reorder</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'email'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'desc'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="grouping"><a href="#grouping">Группировка</a></h3>
<p></p>
<h4 id="groupby-having"><a href="#groupby-having">В <code>groupBy</code> &amp; <code>having</code> Методы</a></h4>
<p>Как и следовало ожидать, <code>groupBy</code> и <code>having</code> методы могут быть использованы для группы
    результатов запроса. В <code>having</code> подписи методы подобна тому из <code>where</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">groupBy</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'account_id'</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">having</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'account_id'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'&gt;'</span><span
                class="token punctuation">,</span> <span class="token number">100</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете передать несколько аргументов <code>groupBy</code> методу для группировки по нескольким столбцам:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">groupBy</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'first_name'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'status'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">having</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'account_id'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'&gt;'</span><span
                class="token punctuation">,</span> <span class="token number">100</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Чтобы построить более сложные <code>having</code> инструкции, см. <a
            href="queries#raw-methods"><code>havingRaw</code></a>Метод.</p>
<p></p>
<h3 id="limit-and-offset"><a href="#limit-and-offset">Предел и смещение</a></h3>
<p></p>
<h4 id="skip-take"><a href="#skip-take">В <code>skip</code> &amp; <code>take</code> Методы</a></h4>
<p>Вы можете использовать <code>skip</code> и <code>take</code> методы, чтобы ограничить количество результатов,
    возвращаемых из запроса или пропустить заданное число результатов в запросе:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">skip</span><span
                class="token punctuation">(</span><span class="token number">10</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">take</span><span
                class="token punctuation">(</span><span class="token number">5</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>В качестве альтернативы, вы можете использовать <code>limit</code> и <code>offset</code> методы. Эти методы являются
    функционально эквивалентными <code>take</code> и <code>skip</code> методами, соответственно:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">offset</span><span class="token punctuation">(</span><span class="token number">10</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">limit</span><span class="token punctuation">(</span><span
                class="token number">5</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="conditional-clauses"><a href="#conditional-clauses">Условные предложения</a></h2>
<p>Иногда может потребоваться, чтобы определенные предложения запроса применялись к запросу на основе другого условия.
    Например, вы можете захотеть применить <code>where</code> оператор только в том случае, если данное входное значение
    присутствует во входящем HTTP-запросе. Вы можете сделать это с помощью <code>when</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$role</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">input</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'role'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$users</span> <span class="token operator">=</span> <span
                class="token constant">DB</span><span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">table</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'users'</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">when</span><span class="token punctuation">(</span><span class="token variable">$role</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$query</span><span
                class="token punctuation">,</span> <span class="token variable">$role</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
                    <span class="token keyword">return</span> <span class="token variable">$query</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'role_id'</span><span
                class="token punctuation">,</span> <span class="token variable">$role</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
                <span class="token punctuation">}</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p><code>when</code> Метод выполняется только данное замыкание, когда первый аргумент <code>true</code>. Если первый
    аргумент равен <code>false</code>, закрытие не будет выполнено. Итак, в приведенном выше примере закрытие, данное
    <code>when</code> методу, будет вызываться только в том случае, если <code>role</code> поле присутствует во входящем
    запросе и оценивается как <code>true</code>.</p>
<p>Вы можете передать другое закрытие в качестве третьего аргумента <code>when</code> метода. Это закрытие будет
    выполнено, только если первый аргумент оценивается как <code>false</code>. Чтобы проиллюстрировать, как можно
    использовать эту функцию, мы будем использовать ее для настройки порядка запроса по умолчанию:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$sortByVotes</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">input</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'sort_by_votes'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$users</span> <span class="token operator">=</span> <span
                class="token constant">DB</span><span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">table</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'users'</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">when</span><span class="token punctuation">(</span><span class="token variable">$sortByVotes</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$query</span><span
                class="token punctuation">,</span> <span class="token variable">$sortByVotes</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
                    <span class="token keyword">return</span> <span class="token variable">$query</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">orderBy</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'votes'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
                <span class="token punctuation">}</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token variable">$query</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
                    <span class="token keyword">return</span> <span class="token variable">$query</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">orderBy</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
                <span class="token punctuation">}</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="insert-statements"><a href="#insert-statements">Вставить заявления</a></h2>
<p>Построитель запросов также предоставляет <code>insert</code> метод, который можно использовать для вставки записей в
    таблицу базы данных. <code>insert</code> Метод принимает массив имен столбцов и значений:</p>
<pre class=" language-php"><code class=" language-php"><span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">insert</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'kayla@example.com'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'votes'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">0</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете вставить сразу несколько записей, передав массив массивов. Каждый массив представляет собой запись, которую
    нужно вставить в таблицу:</p>
<pre class=" language-php"><code class=" language-php"><span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">insert</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'email'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'picard@example.com'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'votes'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">0</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'email'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'janeway@example.com'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'votes'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">0</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p><code>insertOrIgnore</code> Метод будет игнорировать повторяющиеся ошибки записи при вставке записей в базу данных:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">insertOrIgnore</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'id'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'sisko@example.com'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'id'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'archer@example.com'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="auto-incrementing-ids"><a href="#auto-incrementing-ids">Автоинкремент ID</a></h4>
<p>Если таблица имеет автоматически увеличивающийся идентификатор, используйте <code>insertGetId</code> метод для
    вставки записи, а затем получите идентификатор:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$id</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">insertGetId</span><span
                class="token punctuation">(</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'email'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'john@example.com'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'votes'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">0</span><span class="token punctuation">]</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>При использовании PostgreSQL <code>insertGetId</code> метод ожидает, что будет назван автоматически
            увеличивающийся столбец <code>id</code>. Если вы хотите получить идентификатор из другой
            «последовательности», вы можете передать имя столбца в качестве второго параметра <code>insertGetId</code>
            методу.</p></p></div>
</blockquote>
<p></p>
<h3 id="upserts"><a href="#upserts">Upserts</a></h3>
<p><code>upsert</code> Метод вставки записей, которые не существуют и обновления записей, которые уже существуют с
    новыми значениями, которые вы можете указать. Первый аргумент метода состоит из значений для вставки или обновления,
    а второй аргумент перечисляет столбцы, которые однозначно идентифицируют записи в связанной таблице. Третий и
    последний аргумент метода - это массив столбцов, который следует обновить, если соответствующая запись уже
    существует в базе данных:</p>
<pre class=" language-php"><code class=" language-php"><span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'flights'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">upsert</span><span
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
<p>В приведенном выше примере Laravel попытается вставить две записи. Если запись уже существует с такими же значениями
    <code>departure</code> и <code>destination</code> столбцами, Laravel обновит <code>price</code> столбец этой записи.
</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Все базы данных, кроме SQL Server, требуют, чтобы столбцы во втором аргументе <code>upsert</code> метода
            имели «первичный» или «уникальный» индекс.</p></p></div>
</blockquote>
<p></p>
<h2 id="update-statements"><a href="#update-statements">Обновить заявления</a></h2>
<p>Помимо вставки записей в базу данных, построитель запросов также может обновлять существующие записи с помощью этого
    <code>update</code> метода. <code>update</code> Метод, как <code>insert</code> метод, принимает массив столбцов и
    пар значений, указывающий столбцы, которые будут обновлены. Вы можете ограничить <code>update</code> запрос с
    помощью <code>where</code> предложений:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$affected</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
              <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'id'</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">)</span>
              <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">update</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'votes'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">1</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="update-or-insert"><a href="#update-or-insert">Обновить или вставить</a></h4>
<p>Иногда вам может потребоваться обновить существующую запись в базе данных или создать ее, если соответствующей записи
    не существует. В этом сценарии <code>updateOrInsert</code> можно использовать метод. <code>updateOrInsert</code>
    Метод принимает два аргумента: массив условий с помощью которых можно найти запись, и массив столбцов и пар значений
    указывает на столбцы, которые будут обновлены.</p>
<p><code>updateOrInsert</code> Метод попытается найти запись сопоставления базы данных с помощью столбцов и пары
    значений первого аргумента. Если запись существует, она будет обновлена значениями во втором аргументе. Если
    запись не может быть найдена, будет вставлена новая запись с объединенными атрибутами обоих аргументов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">updateOrInsert</span><span
                class="token punctuation">(</span>
        <span class="token punctuation">[</span><span class="token single-quoted-string string">'email'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'john@example.com'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'John'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
        <span class="token punctuation">[</span><span class="token single-quoted-string string">'votes'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'2'</span><span class="token punctuation">]</span>
    <span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="updating-json-columns"><a href="#updating-json-columns">Обновление столбцов JSON</a></h3>
<p>При обновлении столбца JSON следует использовать <code>-&gt;</code> синтаксис для обновления соответствующего ключа в
    объекте JSON. Эта операция поддерживается в MySQL 5.7+ и PostgreSQL 9.5+:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$affected</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
              <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'id'</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">)</span>
              <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">update</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'options-&gt;enabled'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token boolean constant">true</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="increment-and-decrement"><a href="#increment-and-decrement">Увеличение и уменьшение</a></h3>
<p>Конструктор запросов также предоставляет удобные методы увеличения или уменьшения значения данного столбца. Оба эти
    метода принимают по крайней мере один аргумент: столбец, который нужно изменить. Может быть предоставлен второй
    аргумент, чтобы указать величину, на которую следует увеличивать или уменьшать столбец:</p>
<pre class=" language-php"><code class=" language-php"><span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">increment</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'votes'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token constant">DB</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">increment</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'votes'</span><span
                class="token punctuation">,</span> <span class="token number">5</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token constant">DB</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">decrement</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'votes'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token constant">DB</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">decrement</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'votes'</span><span
                class="token punctuation">,</span> <span class="token number">5</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы также можете указать дополнительные столбцы для обновления во время операции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">increment</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'votes'</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'John'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="delete-statements"><a href="#delete-statements">Удалить заявления</a></h2>
<p>Для <code>delete</code> удаления записей из таблицы можно использовать метод построителя запросов. Вы можете
    ограничить <code>delete</code> операторы, добавив предложения "where" перед вызовом <code>delete</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">delete</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token constant">DB</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'votes'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'&gt;'</span><span
                class="token punctuation">,</span> <span class="token number">100</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">delete</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Если вы хотите обрезать всю таблицу, что приведет к удалению всех записей из таблицы и сбросу автоматически
    увеличивающегося идентификатора на ноль, вы можете использовать <code>truncate</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">truncate</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="table-truncation-and-postgresql"><a href="#table-truncation-and-postgresql">Усечение таблицы и PostgreSQL</a>
</h4>
<p>При усечении базы данных PostgreSQL <code>CASCADE</code> будет применено поведение. Это означает, что все связанные с
    внешним ключом записи в других таблицах также будут удалены.</p>
<p></p>
<h2 id="pessimistic-locking"><a href="#pessimistic-locking">Пессимистическая блокировка</a></h2>
<p>Построитель запросов также включает несколько функций, которые помогут вам достичь «пессимистической блокировки» при
    выполнении ваших <code>select</code> операторов. Чтобы выполнить оператор с «разделяемой блокировкой», вы можете
    вызвать <code>sharedLock</code> метод. Общая блокировка предотвращает изменение выбранных строк до тех пор, пока
    ваша транзакция не будет зафиксирована:</p>
<pre class=" language-php"><code class=" language-php"><span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">where</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'votes'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'&gt;'</span><span class="token punctuation">,</span> <span
                class="token number">100</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">sharedLock</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>В качестве альтернативы вы можете использовать <code>lockForUpdate</code> метод. Блокировка «на обновление»
    предотвращает изменение выбранных записей или их выбор с помощью другой общей блокировки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">where</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'votes'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'&gt;'</span><span class="token punctuation">,</span> <span
                class="token number">100</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">lockForUpdate</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="debugging"><a href="#debugging">Отладка</a></h2>
<p>Вы можете использовать <code>dd</code> и <code>dump</code> методы при построении запроса дампа текущей привязки
    запросов и SQL. <code>dd</code> Метод будет отображать отладочную информацию, а затем прекратить выполнение запроса.
    <code>dump</code> Метод будет отображать информацию об отладке, но позволяет запрос на продолжение выполнения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'votes'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'&gt;'</span><span
                class="token punctuation">,</span> <span class="token number">100</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">dd</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token constant">DB</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'votes'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'&gt;'</span><span
                class="token punctuation">,</span> <span class="token number">100</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">dump</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
