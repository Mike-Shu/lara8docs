<h1>Eloquent: отношения <sup>Relationships</sup></h1>
<ul>
    <li><a href="eloquent-relationships#introduction">Вступление</a></li>
    <li><a href="eloquent-relationships#defining-relationships">Определение отношений</a>
        <ul>
            <li><a href="eloquent-relationships#one-to-one">Один к одному</a></li>
            <li><a href="eloquent-relationships#one-to-many">Один ко многим</a></li>
            <li><a href="eloquent-relationships#one-to-many-inverse">Один ко многим (инверсия) / принадлежит</a></li>
            <li><a href="eloquent-relationships#has-one-through">Имеет один сквозной</a></li>
            <li><a href="eloquent-relationships#has-many-through">Имеет много сквозных</a></li>
        </ul>
    </li>
    <li><a href="eloquent-relationships#many-to-many">Отношения многие ко многим</a>
        <ul>
            <li><a href="eloquent-relationships#retrieving-intermediate-table-columns">Получение промежуточных столбцов
                    таблицы</a></li>
            <li><a href="eloquent-relationships#filtering-queries-via-intermediate-table-columns">Фильтрация запросов по
                    промежуточным столбцам таблицы</a></li>
            <li><a href="eloquent-relationships#defining-custom-intermediate-table-models">Определение пользовательских
                    моделей промежуточных таблиц</a></li>
        </ul>
    </li>
    <li><a href="eloquent-relationships#polymorphic-relationships">Полиморфные отношения</a>
        <ul>
            <li><a href="eloquent-relationships#one-to-one-polymorphic-relations">Один к одному</a></li>
            <li><a href="eloquent-relationships#one-to-many-polymorphic-relations">Один ко многим</a></li>
            <li><a href="eloquent-relationships#many-to-many-polymorphic-relations">Многие ко многим</a></li>
            <li><a href="eloquent-relationships#custom-polymorphic-types">Пользовательские полиморфные типы</a></li>
        </ul>
    </li>
    <li><a href="eloquent-relationships#dynamic-relationships">Динамические отношения</a></li>
    <li><a href="eloquent-relationships#querying-relations">Запрос отношений</a>
        <ul>
            <li><a href="eloquent-relationships#relationship-methods-vs-dynamic-properties">Методы взаимоотношений Vs.
                    Динамические свойства</a></li>
            <li><a href="eloquent-relationships#querying-relationship-existence">Запрос существования отношений</a></li>
            <li><a href="eloquent-relationships#querying-relationship-absence">Запрос отсутствия связи</a></li>
            <li><a href="eloquent-relationships#querying-morph-to-relationships">Запрос морфа к отношениям</a></li>
        </ul>
    </li>
    <li><a href="eloquent-relationships#aggregating-related-models">Агрегирование связанных моделей</a>
        <ul>
            <li><a href="eloquent-relationships#counting-related-models">Подсчет связанных моделей</a></li>
            <li><a href="eloquent-relationships#other-aggregate-functions">Другие агрегатные функции</a></li>
            <li><a href="eloquent-relationships#counting-related-models-on-morph-to-relationships">Подсчет связанных
                    моделей при преобразовании в отношения</a></li>
        </ul>
    </li>
    <li><a href="eloquent-relationships#eager-loading">Нетерпеливая загрузка</a>
        <ul>
            <li><a href="eloquent-relationships#constraining-eager-loads">Ограничение нетерпеливой нагрузки</a></li>
            <li><a href="eloquent-relationships#lazy-eager-loading">Ленивая загрузка</a></li>
        </ul>
    </li>
    <li><a href="eloquent-relationships#inserting-and-updating-related-models">Вставка и обновление связанных
            моделей</a>
        <ul>
            <li><a href="eloquent-relationships#the-save-method"><code>save</code> Метод</a></li>
            <li><a href="eloquent-relationships#the-create-method"><code>create</code> Метод</a></li>
            <li><a href="eloquent-relationships#updating-belongs-to-relationships">Принадлежит к отношениям</a></li>
            <li><a href="eloquent-relationships#updating-many-to-many-relationships">Отношения многие ко многим</a></li>
        </ul>
    </li>
    <li><a href="eloquent-relationships#touching-parent-timestamps">Касание родительских отметок времени</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Таблицы базы данных часто связаны друг с другом. Например, сообщение в блоге может содержать много комментариев или
    заказ может быть связан с пользователем, который его разместил. Eloquent упрощает управление этими отношениями и
    работу с ними, а также поддерживает множество общих отношений:</p>
<div class="content-list">
    <ul>
        <li><a href="eloquent-relationships#one-to-one">Один к одному</a></li>
        <li><a href="eloquent-relationships#one-to-many">Один ко многим</a></li>
        <li><a href="eloquent-relationships#many-to-many">Многие ко многим</a></li>
        <li><a href="eloquent-relationships#has-one-through">Имеет один сквозной</a></li>
        <li><a href="eloquent-relationships#has-many-through">Имеет много сквозных</a></li>
        <li><a href="eloquent-relationships#one-to-one-polymorphic-relations">Один к одному (полиморфный)</a></li>
        <li><a href="eloquent-relationships#one-to-many-polymorphic-relations">Один ко многим (полиморфный)</a></li>
        <li><a href="eloquent-relationships#many-to-many-polymorphic-relations">Многие ко многим (полиморфный)</a></li>
    </ul>
</div>
<p></p>
<h2 id="defining-relationships"><a href="#defining-relationships">Определение отношений</a></h2>
<p>Отношения Eloquent определяются как методы в классах модели Eloquent. Поскольку отношения также служат мощными
    конструкторами <a href="queries">запросов</a>, определение отношений как методов обеспечивает мощные возможности
    построения цепочек методов и запросов. Например, мы можем связать дополнительные ограничения запроса на эту <code>posts</code>
    связь:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">posts</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'active'</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Но, прежде чем углубляться в использование отношений, давайте узнаем, как определить каждый тип отношений,
    поддерживаемый Eloquent.</p>
<p></p>
<h3 id="one-to-one"><a href="#one-to-one">Один к одному</a></h3>
<p>Отношения «один к одному» - это очень простой тип отношений с базой данных. Например, <code>User</code> модель может
    быть связана с одной <code>Phone</code> моделью. Чтобы определить это отношение, мы поместим <code>phone</code>
    метод в <code>User</code> модель. <code>phone</code> Метод должен вызвать <code>hasOne</code> метод и вернуть
    результат. <code>hasOne</code> Метод доступен для вашей модели с помощью модели <code>Illuminate\Database\Eloquent\Model</code>
    базового класса:</p>
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
    * Get the phone associated with the user.
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">phone</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">hasOne</span><span
                    class="token punctuation">(</span>Phone<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Первым аргументом, переданным <code>hasOne</code> методу, является имя связанного класса модели. Как только связь
    определена, мы можем получить связанную запись, используя динамические свойства Eloquent. Динамические свойства
    позволяют получить доступ к методам отношений, как если бы они были свойствами, определенными в модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$phone</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">phone</span><span
                class="token punctuation">;</span></code></pre>
<p>Eloquent определяет внешний ключ отношения на основе имени родительской модели. В этом случае <code>Phone</code>
    автоматически предполагается, что модель имеет <code>user_id</code> внешний ключ. Если вы хотите переопределить это
    соглашение, вы можете передать второй аргумент <code>hasOne</code> методу:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">hasOne</span><span class="token punctuation">(</span>Phone<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'foreign_key'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Кроме того, Eloquent предполагает, что внешний ключ должен иметь значение, соответствующее столбцу первичного ключа
    родительского элемента. Другими словами, Eloquent будет искать значение <code>id</code> столбца пользователя в
    <code>user_id</code> столбце <code>Phone</code> записи. Если вы хотите, чтобы отношение использовало значение
    первичного ключа, отличное от свойства <code>id</code> вашей модели <code>$primaryKey</code>, вы можете передать
    третий аргумент <code>hasOne</code> методу:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">hasOne</span><span class="token punctuation">(</span>Phone<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'foreign_key'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'local_key'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="one-to-one-defining-the-inverse-of-the-relationship"><a
            href="#one-to-one-defining-the-inverse-of-the-relationship">Определение обратной связи</a></h4>
<p>Итак, мы можем получить доступ к <code>Phone</code> модели из нашей <code>User</code> модели. Затем давайте определим
    отношения в <code>Phone</code> модели, которые позволят нам получить доступ к пользователю, которому принадлежит
    телефон. Мы можем определить обратную <code>hasOne</code> связь, используя <code>belongsTo</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Model</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">Phone</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Get the user that owns the phone.
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">user</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">belongsTo</span><span
                    class="token punctuation">(</span>User<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>При вызове <code>user</code> метода Eloquent попытается найти <code>User</code> модель, <code>id</code> которая
    соответствует <code>user_id</code> столбцу в <code>Phone</code> модели.</p>
<p>Eloquent определяет имя внешнего ключа, исследуя имя метода отношения и добавляя к имени метода суффикс
    <code>_id</code>. Итак, в этом случае Eloquent предполагает, что в <code>Phone</code> модели есть
    <code>user_id</code> столбец. Однако, если внешнего ключа в <code>Phone</code> модели нет <code>user_id</code>, вы
    можете передать собственное имя ключа в качестве второго аргумента <code>belongsTo</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the user that owns the phone.
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">user</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">belongsTo</span><span
                class="token punctuation">(</span>User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'foreign_key'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Если родительская модель не используется в <code>id</code> качестве первичного ключа или вы хотите найти связанную
    модель, используя другой столбец, вы можете передать третий аргумент <code>belongsTo</code> методу, определяющему
    настраиваемый ключ родительской таблицы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the user that owns the phone.
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">user</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">belongsTo</span><span
                class="token punctuation">(</span>User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'foreign_key'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'owner_key'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="one-to-many"><a href="#one-to-many">Один ко многим</a></h3>
<p>Отношение «один ко многим» используется для определения отношений, в которых одна модель является родительской для
    одной или нескольких дочерних моделей. Например, сообщение в блоге может содержать бесконечное количество
    комментариев. Как и все другие отношения Eloquent, отношения один-ко-многим определяются путем определения метода в
    вашей модели Eloquent:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Model</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">Post</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Get the comments for the blog post.
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">comments</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">hasMany</span><span
                    class="token punctuation">(</span>Comment<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Помните, что Eloquent автоматически определит правильный столбец внешнего ключа для <code>Comment</code> модели. По
    соглашению Eloquent берет имя "змеиный футляр" родительской модели и добавляет к нему суффикс <code>_id</code>.
    Итак, в этом примере Eloquent предполагает, что столбец внешнего ключа <code>Comment</code> модели равен <code>post_id</code>.
</p>
<p>После определения метода отношения мы можем получить доступ к <a href="eloquent-collections">коллекции</a> связанных
    комментариев, обратившись к <code>comments</code> свойству. Помните, поскольку Eloquent предоставляет «динамические
    свойства отношений», мы можем получить доступ к методам отношений, как если бы они были определены как свойства в
    модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Post</span><span class="token punctuation">;</span>

<span class="token variable">$comments</span> <span class="token operator">=</span> Post<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">comments</span><span
                class="token punctuation">;</span>

<span class="token keyword">foreach</span> <span class="token punctuation">(</span><span class="token variable">$comments</span> <span
                class="token keyword">as</span> <span class="token variable">$comment</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p>Поскольку все отношения также служат в качестве построителей запросов, вы можете добавить дополнительные ограничения
    в запрос отношения, вызвав <code>comments</code> метод и продолжив связывать условия с запросом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$comment</span> <span
                class="token operator">=</span> Post<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">comments</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
                    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">where</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'title'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'foo'</span><span class="token punctuation">)</span>
                    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">first</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Как и в случае с <code>hasOne</code> методом, вы также можете переопределить внешние и локальные ключи, передав
    <code>hasMany</code> методу дополнительные аргументы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">hasMany</span><span class="token punctuation">(</span>Comment<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'foreign_key'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">return</span> <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">hasMany</span><span
                class="token punctuation">(</span>Comment<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'foreign_key'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'local_key'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="one-to-many-inverse"><a href="#one-to-many-inverse">Один ко многим (инверсия) / принадлежит</a></h3>
<p>Теперь, когда мы можем получить доступ ко всем комментариям поста, давайте определим отношение, чтобы разрешить
    комментарию доступ к его родительскому посту. Чтобы определить обратное <code>hasMany</code> отношение, определите
    метод отношения в дочерней модели, который вызывает этот <code>belongsTo</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Model</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">Comment</span> <span class="token keyword">extends</span> <span
                    class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Get the post that owns the comment.
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">post</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">belongsTo</span><span
                    class="token punctuation">(</span>Post<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>После определения отношения мы можем получить родительский пост комментария, обратившись к <code>post</code>
    «свойству динамического отношения»:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Comment</span><span class="token punctuation">;</span>

<span class="token variable">$comment</span> <span class="token operator">=</span> Comment<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">return</span> <span class="token variable">$comment</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">post</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">title</span><span
                class="token punctuation">;</span></code></pre>
<p>В приведенном выше примере Eloquent попытается найти <code>Post</code> модель, <code>id</code> которая соответствует
    <code>post_id</code> столбцу в <code>Comment</code> модели.</p>
<p>Eloquent определяет имя внешнего ключа по умолчанию, проверяя имя метода отношения и добавляя к имени метода суффикс,
    за <code>_</code> которым следует имя столбца первичного ключа родительской модели. Итак, в этом примере Eloquent
    предполагает, что <code>Post</code> внешний ключ модели в <code>comments</code> таблице равен <code>post_id</code>.
</p>
<p>Однако, если внешний ключ для ваших отношений не соответствует этим соглашениям, вы можете передать настраиваемое имя
    внешнего ключа в качестве второго аргумента <code>belongsTo</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the post that owns the comment.
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">post</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">belongsTo</span><span
                class="token punctuation">(</span>Post<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'foreign_key'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Если ваша родительская модель не используется в <code>id</code> качестве первичного ключа или вы хотите найти
    связанную модель, используя другой столбец, вы можете передать третий аргумент <code>belongsTo</code> методу,
    определяющему настраиваемый ключ родительской таблицы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the post that owns the comment.
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">post</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">belongsTo</span><span
                class="token punctuation">(</span>Post<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'foreign_key'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'owner_key'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="default-models"><a href="#default-models">Модели по умолчанию</a></h4>
<p>В <code>belongsTo</code>, <code>hasOne</code>, <code>hasOneThrough</code> и <code>morphOne</code> отношения позволяют
    определить модель по умолчанию, который будет возвращен, если данная взаимосвязь <code>null</code>. Этот шаблон
    часто называют <a href="https://en.wikipedia.org/wiki/Null_Object_pattern">шаблоном нулевого объекта</a> и может
    помочь удалить условные проверки в вашем коде. В следующем примере <code>user</code> отношение вернет пустую <code>App\Models\User</code>
    модель, если к модели не привязан пользователь <code>Post</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the author of the post.
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">user</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">belongsTo</span><span
                class="token punctuation">(</span>User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">withDefault</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Чтобы заполнить модель по умолчанию атрибутами, вы можете передать в <code>withDefault</code> метод массив или
    замыкание:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the author of the post.
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">user</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">belongsTo</span><span
                class="token punctuation">(</span>User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">withDefault</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Guest Author'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span>

<span class="token comment">/**
 * Get the author of the post.
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">user</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">belongsTo</span><span
                class="token punctuation">(</span>User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">withDefault</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">,</span> <span class="token variable">$post</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">name</span> <span class="token operator">=</span> <span
                class="token single-quoted-string string">'Guest Author'</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="has-one-through"><a href="#has-one-through">Имеет один сквозной</a></h3>
<p>Отношение «сквозные» определяет взаимно-однозначные отношения с другой моделью. Однако это отношение указывает на то,
    что декларирующую модель можно сопоставить с одним экземпляром другой модели, пройдя <em>через</em> третью модель.
</p>
<p>Например, в приложении автомастерской каждая <code>Mechanic</code> модель может быть связана с одной <code>Car</code>
    моделью, и каждая <code>Car</code> модель может быть связана с одной <code>Owner</code> моделью. В то время как
    механик и владелец не имеет прямого отношения в базе данных, механик может получить доступ к владельцу
    <em>через</em> к <code>Car</code> модели. Давайте посмотрим на таблицы, необходимые для определения этой связи:</p>
<pre class=" language-php"><code class=" language-php">mechanics
    id <span class="token operator">-</span> integer
    name <span class="token operator">-</span> string

cars
    id <span class="token operator">-</span> integer
    model <span class="token operator">-</span> string
    mechanic_id <span class="token operator">-</span> integer

owners
    id <span class="token operator">-</span> integer
    name <span class="token operator">-</span> string
    car_id <span class="token operator">-</span> integer</code></pre>
<p>Теперь, когда мы изучили структуру таблицы для отношений, давайте определим отношения в <code>Mechanic</code> модели:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Model</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">Mechanic</span> <span class="token keyword">extends</span> <span
                    class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Get the car's owner.
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">carOwner</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$this</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">hasOneThrough</span><span
                    class="token punctuation">(</span>Owner<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">,</span> Car<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Первый аргумент, переданный <code>hasOneThrough</code> методу, - это имя последней модели, к которой мы хотим
    получить доступ, а второй аргумент - это имя промежуточной модели.</p>
<p></p>
<h4 id="has-one-through-key-conventions"><a href="#has-one-through-key-conventions">Ключевые соглашения</a></h4>
<p>Типичные соглашения о внешнем ключе Eloquent будут использоваться при выполнении запросов отношения. Если вы хотите
    настроить ключи отношения, вы можете передать их в качестве третьего и четвертого аргументов
    <code>hasOneThrough</code> метода. Третий аргумент - это имя внешнего ключа промежуточной модели. Четвертый аргумент
    - это имя внешнего ключа окончательной модели. Пятый аргумент - это локальный ключ, а шестой аргумент - это
    локальный ключ промежуточной модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">class</span> <span
                class="token class-name">Mechanic</span> <span class="token keyword">extends</span> <span
                class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Get the car's owner.
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">carOwner</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">hasOneThrough</span><span
                class="token punctuation">(</span>
            Owner<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
            Car<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span><span class="token punctuation">,</span>
            <span class="token single-quoted-string string">'mechanic_id'</span><span class="token punctuation">,</span> <span
                class="token comment">// Foreign key on the cars table...</span>
            <span class="token single-quoted-string string">'car_id'</span><span class="token punctuation">,</span> <span
                class="token comment">// Foreign key on the owners table...</span>
            <span class="token single-quoted-string string">'id'</span><span class="token punctuation">,</span> <span
                class="token comment">// Local key on the mechanics table...</span>
            <span class="token single-quoted-string string">'id'</span> <span class="token comment">// Local key on the cars table...</span>
        <span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="has-many-through"><a href="#has-many-through">Имеет много сквозных</a></h3>
<p>Отношение «имеет многие сквозные» обеспечивает удобный способ доступа к удаленным отношениям через промежуточное
    отношение. Например, предположим, что мы создаем платформу развертывания, такую ​​как <a
            href="https://vapor.laravel.com">Laravel Vapor</a>. <code>Project</code> Модель может получить доступ ко
    многим <code>Deployment</code> модели через промежуточную <code>Environment</code> модель. Используя этот пример, вы
    можете легко собрать все развертывания для данной среды. Давайте посмотрим на таблицы, необходимые для определения
    этой связи:</p>
<pre class=" language-php"><code class=" language-php">projects
    id <span class="token operator">-</span> integer
    name <span class="token operator">-</span> string

environments
    id <span class="token operator">-</span> integer
    project_id <span class="token operator">-</span> integer
    name <span class="token operator">-</span> string

deployments
    id <span class="token operator">-</span> integer
    environment_id <span class="token operator">-</span> integer
    commit_hash <span class="token operator">-</span> string</code></pre>
<p>Теперь, когда мы изучили структуру таблицы для отношений, давайте определим отношения в <code>Project</code> модели:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Model</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">Project</span> <span class="token keyword">extends</span> <span
                    class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Get all of the deployments for the project.
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">deployments</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">hasManyThrough</span><span
                    class="token punctuation">(</span>Deployment<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">,</span> Environment<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Первый аргумент, переданный <code>hasManyThrough</code> методу, - это имя последней модели, к которой мы хотим
    получить доступ, а второй аргумент - это имя промежуточной модели.</p>
<p>Хотя <code>Deployment</code> таблица модели не содержит <code>project_id</code> столбца, <code>hasManyThrough</code>
    отношение обеспечивает доступ к развертываниям проекта через <code>$project-&gt;deployments</code>. Чтобы получить
    эти модели, Eloquent проверяет <code>project_id</code> столбец <code>Environment</code> в таблице промежуточной
    модели. После нахождения соответствующих идентификаторов среды они используются для запроса <code>Deployment</code>
    таблицы модели.</p>
<p></p>
<h4 id="has-many-through-key-conventions"><a href="#has-many-through-key-conventions">Ключевые соглашения</a></h4>
<p>Типичные соглашения о внешнем ключе Eloquent будут использоваться при выполнении запросов отношения. Если вы хотите
    настроить ключи отношения, вы можете передать их в качестве третьего и четвертого аргументов
    <code>hasManyThrough</code> метода. Третий аргумент - это имя внешнего ключа промежуточной модели. Четвертый
    аргумент - это имя внешнего ключа окончательной модели. Пятый аргумент - это локальный ключ, а шестой аргумент - это
    локальный ключ промежуточной модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">class</span> <span
                class="token class-name">Project</span> <span class="token keyword">extends</span> <span
                class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">deployments</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">hasManyThrough</span><span
                class="token punctuation">(</span>
            Deployment<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span><span class="token punctuation">,</span>
            Environment<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span><span class="token punctuation">,</span>
            <span class="token single-quoted-string string">'project_id'</span><span class="token punctuation">,</span> <span
                class="token comment">// Foreign key on the environments table...</span>
            <span class="token single-quoted-string string">'environment_id'</span><span
                class="token punctuation">,</span> <span class="token comment">// Foreign key on the deployments table...</span>
            <span class="token single-quoted-string string">'id'</span><span class="token punctuation">,</span> <span
                class="token comment">// Local key on the projects table...</span>
            <span class="token single-quoted-string string">'id'</span> <span class="token comment">// Local key on the environments table...</span>
        <span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h2 id="many-to-many"><a href="#many-to-many">Отношения многие ко многим</a></h2>
<p>Многие-ко-многим отношения немного более сложным, чем <code>hasOne</code> и <code>hasMany</code> отношения. Примером
    отношения «многие ко многим» является пользователь, у которого много ролей, и эти роли также используются другими
    пользователями в приложении. Например, пользователю могут быть назначены роли «Автор» и «Редактор»; однако эти роли
    также могут быть назначены другим пользователям. Итак, у пользователя много ролей, а у роли много пользователей.</p>
<p></p>
<h4 id="many-to-many-table-structure"><a href="#many-to-many-table-structure">Структура таблицы</a></h4>
<p>Для определения этого отношения, необходимы три таблицы базы данных: <code>users</code>, <code>roles</code>, и <code>role_user</code>.
    <code>role_user</code> Таблица выводится из алфавитного порядка соответствующих названий модели и содержит <code>user_id</code>
    и <code>role_id</code> столбцы. Эта таблица используется как промежуточная таблица, связывающая пользователей и
    роли.</p>
<p>Помните, что поскольку роль может принадлежать многим пользователям, мы не можем просто разместить
    <code>user_id</code> столбец в <code>roles</code> таблице. Это означало бы, что роль могла принадлежать только
    одному пользователю. <code>role_user</code> Таблица необходима для поддержки ролей, назначаемых нескольким
    пользователям. Мы можем резюмировать структуру таблицы отношений следующим образом:</p>
<pre class=" language-php"><code class=" language-php">users
    id <span class="token operator">-</span> integer
    name <span class="token operator">-</span> string

roles
    id <span class="token operator">-</span> integer
    name <span class="token operator">-</span> string

role_user
    user_id <span class="token operator">-</span> integer
    role_id <span class="token operator">-</span> integer</code></pre>
<p></p>
<h4 id="many-to-many-model-structure"><a href="#many-to-many-model-structure">Структура модели</a></h4>
<p>Отношения «многие ко многим» определяются путем написания метода, который возвращает результат
    <code>belongsToMany</code> метода. Этот <code>belongsToMany</code> метод предоставляется <code>Illuminate\Database\Eloquent\Model</code>
    базовым классом, который используется всеми моделями Eloquent вашего приложения. Например, давайте определим <code>roles</code>
    метод на нашей <code>User</code> модели. Первым аргументом, передаваемым этому методу, является имя соответствующего
    класса модели:</p>
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
     * The roles that belong to the user.
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">roles</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">belongsToMany</span><span
                    class="token punctuation">(</span>Role<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>После определения отношения вы можете получить доступ к ролям пользователя, используя <code>roles</code> свойство
    динамического отношения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

<span class="token variable">$user</span> <span class="token operator">=</span> User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">foreach</span> <span class="token punctuation">(</span><span
                class="token variable">$user</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">roles</span> <span class="token keyword">as</span> <span class="token variable">$role</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p>Поскольку все отношения также служат в качестве построителей запросов, вы можете добавить дополнительные ограничения
    в запрос отношения, вызвав <code>roles</code> метод и продолжив связывать условия с запросом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$roles</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">roles</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">orderBy</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Чтобы определить имя таблицы промежуточной таблицы отношения, Eloquent соединит имена двух связанных моделей в
    алфавитном порядке. Однако вы можете изменить это соглашение. Вы можете сделать это, передав
    <code>belongsToMany</code> методу второй аргумент:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">belongsToMany</span><span class="token punctuation">(</span>Role<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'role_user'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Помимо настройки имени промежуточной таблицы, вы также можете настроить имена столбцов ключей в таблице, передав в
    <code>belongsToMany</code> метод дополнительные аргументы. Третий аргумент - это имя внешнего ключа модели, для
    которой вы определяете отношение, а четвертый аргумент - это имя внешнего ключа модели, к которой вы
    присоединяетесь:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">belongsToMany</span><span class="token punctuation">(</span>Role<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'role_user'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'user_id'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'role_id'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="many-to-many-defining-the-inverse-of-the-relationship"><a
            href="#many-to-many-defining-the-inverse-of-the-relationship">Определение обратной связи</a></h4>
<p>Чтобы определить «обратное» отношение «многие ко многим», вы должны определить метод в связанной модели, который
    также возвращает результат <code>belongsToMany</code> метода. Чтобы завершить наш пример пользователя / роли,
    давайте определим <code>users</code> метод в <code>Role</code> модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Model</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">Role</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * The users that belong to the role.
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">users</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">belongsToMany</span><span
                    class="token punctuation">(</span>User<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Как видите, отношение определяется точно так же, как и его <code>User</code> аналог в модели, за исключением ссылки
    на <code>App\Models\User</code> модель. Поскольку мы повторно используем этот <code>belongsToMany</code> метод, при
    определении «обратных» отношений «многие ко многим» доступны все обычные параметры настройки таблиц и ключей.</p>
<p></p>
<h3 id="retrieving-intermediate-table-columns"><a href="#retrieving-intermediate-table-columns">Получение промежуточных
        столбцов таблицы</a></h3>
<p>Как вы уже узнали, для работы с отношениями «многие ко многим» требуется наличие промежуточной таблицы. Eloquent
    предоставляет несколько очень полезных способов взаимодействия с этой таблицей. Например, предположим, что наша
    <code>User</code> модель имеет много <code>Role</code> моделей, с которыми она связана. После доступа к этой связи
    мы можем получить доступ к промежуточной таблице, используя <code>pivot</code> атрибут в моделях:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

<span class="token variable">$user</span> <span class="token operator">=</span> User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">foreach</span> <span class="token punctuation">(</span><span
                class="token variable">$user</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">roles</span> <span class="token keyword">as</span> <span class="token variable">$role</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">echo</span> <span class="token variable">$role</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">pivot</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">created_at</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Обратите внимание, что каждой <code>Role</code> модели, которую мы получаем, автоматически назначается
    <code>pivot</code> атрибут. Этот атрибут содержит модель, представляющую промежуточную таблицу.</p>
<p>По умолчанию на модели будут присутствовать только ключи <code>pivot</code> модели. Если ваша промежуточная таблица
    содержит дополнительные атрибуты, вы должны указать их при определении отношения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">belongsToMany</span><span class="token punctuation">(</span>Role<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">withPivot</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'active'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'created_by'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если вы хотите, чтобы ваш промежуточный стол, чтобы иметь <code>created_at</code> и <code>updated_at</code> временные
    метки, которые автоматически поддержанные красноречива, вызовите <code>withTimestamps</code> метод при определении
    отношения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">belongsToMany</span><span class="token punctuation">(</span>Role<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">withTimestamps</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Промежуточные таблицы, которые используют автоматически поддерживаемые метки времени Eloquent, должны иметь
            столбцы с метками времени <code>created_at</code> и <code>updated_at</code>.</p></p></div>
</blockquote>
<p></p>
<h4 id="customizing-the-pivot-attribute-name"><a href="#customizing-the-pivot-attribute-name">Настройка имени <code>pivot</code>
        атрибута</a></h4>
<p>Как отмечалось ранее, к атрибутам из промежуточной таблицы можно получить доступ в моделях через <code>pivot</code>
    атрибут. Однако вы можете изменить имя этого атрибута, чтобы лучше отразить его назначение в вашем приложении.</p>
<p>Например, если ваше приложение содержит пользователей, которые могут подписаться на подкасты, вы, вероятно, имеете
    отношение «многие ко многим» между пользователями и подкастами. В этом случае вы можете захотеть переименовать
    атрибут промежуточной таблицы в <code>subscription</code> вместо <code>pivot</code>. Это можно сделать с помощью
    <code>as</code> метода при определении отношения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">belongsToMany</span><span class="token punctuation">(</span>Podcast<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token keyword">as</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'subscription'</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">withTimestamps</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>После указания атрибута настраиваемой промежуточной таблицы вы можете получить доступ к данным промежуточной таблицы,
    используя настраиваемое имя:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">with</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'podcasts'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token keyword">foreach</span> <span class="token punctuation">(</span><span
                class="token variable">$users</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">flatMap</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">podcasts</span> <span class="token keyword">as</span> <span
                class="token variable">$podcast</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">echo</span> <span class="token variable">$podcast</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">subscription</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">created_at</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="filtering-queries-via-intermediate-table-columns"><a href="#filtering-queries-via-intermediate-table-columns">Фильтрация
        запросов по промежуточным столбцам таблицы</a></h3>
<p>Вы также можете отфильтровать результаты, возвращаемые <code>belongsToMany</code> отношения запросов с использованием
    <code>wherePivot</code>, <code>wherePivotIn</code> и <code>wherePivotNotIn</code> методы при определении отношений:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">belongsToMany</span><span class="token punctuation">(</span>Role<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">wherePivot</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'approved'</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">return</span> <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">belongsToMany</span><span
                class="token punctuation">(</span>Role<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">wherePivotIn</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'priority'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">return</span> <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">belongsToMany</span><span
                class="token punctuation">(</span>Role<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">wherePivotNotIn</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'priority'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="defining-custom-intermediate-table-models"><a href="#defining-custom-intermediate-table-models">Определение
        пользовательских моделей промежуточных таблиц</a></h3>
<p>Если вы хотите определить пользовательскую модель для представления промежуточной таблицы вашего отношения «многие ко
    многим», вы можете вызвать <code>using</code> метод при определении отношения. Пользовательские сводные модели дают
    вам возможность определять дополнительные методы в сводной модели.</p>
<p>Пользовательские сводные модели «многие ко многим» должны расширять <code>Illuminate\Database\Eloquent\Relations\Pivot</code>
    класс, тогда как пользовательские полиморфные сводные модели «многие ко многим» должны расширять <code>Illuminate\Database\Eloquent\Relations\MorphPivot</code>
    класс. Например, мы можем определить <code>Role</code> модель, которая использует настраиваемую
    <code>RoleUser</code> модель поворота:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Model</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">Role</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * The users that belong to the role.
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">users</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">belongsToMany</span><span
                    class="token punctuation">(</span>User<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">using</span><span class="token punctuation">(</span>RoleUser<span
                    class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token keyword">class</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>При определении <code>RoleUser</code> модели следует расширить
    <code>Illuminate\Database\Eloquent\Relations\Pivot</code> класс:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span class="token punctuation">\</span>Relations<span
                        class="token punctuation">\</span>Pivot</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">RoleUser</span> <span class="token keyword">extends</span> <span
                    class="token class-name">Pivot</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Модель Pivot может не использовать эту <code>SoftDeletes</code> черту. Если вам нужно мягко удалить сводные
            записи, подумайте о преобразовании вашей сводной модели в реальную модель Eloquent.</p></p></div>
</blockquote>
<p></p>
<h4 id="custom-pivot-models-and-incrementing-ids"><a href="#custom-pivot-models-and-incrementing-ids">Пользовательские
        модели Pivot и увеличивающиеся идентификаторы</a></h4>
<p>Если вы определили отношение «многие ко многим», в котором используется настраиваемая сводная модель, и эта сводная
    модель имеет автоматически увеличивающийся первичный ключ, вы должны убедиться, что класс настраиваемой сводной
    модели определяет <code>incrementing</code> свойство, для которого установлено значение <code>true</code>.</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Indicates if the IDs are auto-incrementing.
 *
 * @var bool
 */</span>
<span class="token keyword">public</span> <span class="token variable">$incrementing</span> <span
                class="token operator">=</span> <span class="token boolean constant">true</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="polymorphic-relationships"><a href="#polymorphic-relationships">Полиморфные отношения</a></h2>
<p>Полиморфные отношения позволяют дочерней модели принадлежать более чем к одному типу моделей с использованием одной
    ассоциации. Например, представьте, что вы создаете приложение, которое позволяет пользователям делиться сообщениями
    и видео в блогах. В таком приложении <code>Comment</code> модель может принадлежать как моделям, так
    <code>Post</code> и <code>Video</code>.</p>
<p></p>
<h3 id="one-to-one-polymorphic-relations"><a href="#one-to-one-polymorphic-relations">Один к одному (полиморфный)</a>
</h3>
<p></p>
<h4 id="one-to-one-polymorphic-table-structure"><a href="#one-to-one-polymorphic-table-structure">Структура таблицы</a>
</h4>
<p>Полиморфное отношение «один-к-одному» похоже на типичное взаимно-однозначное отношение; однако дочерняя модель может
    принадлежать более чем к одному типу моделей с помощью одной ассоциации. Например, блог <code>Post</code> и объект
    <code>User</code> могут иметь полиморфное отношение к <code>Image</code> модели. Использование однозначного
    полиморфного отношения позволяет вам иметь единую таблицу уникальных изображений, которые могут быть связаны с
    сообщениями и пользователями. Сначала рассмотрим структуру таблицы:</p>
<pre class=" language-php"><code class=" language-php">posts
    id <span class="token operator">-</span> integer
    name <span class="token operator">-</span> string

users
    id <span class="token operator">-</span> integer
    name <span class="token operator">-</span> string

images
    id <span class="token operator">-</span> integer
    url <span class="token operator">-</span> string
    imageable_id <span class="token operator">-</span> integer
    imageable_type <span class="token operator">-</span> string</code></pre>
<p>Обратите внимание на столбцы <code>imageable_id</code> и <code>imageable_type</code> в <code>images</code> таблице.
    <code>imageable_id</code> Столбец будет содержать значение ID поста или пользователя, в то время как <code>imageable_type</code>
    колонок будет содержать имя класса родительской модели. <code>imageable_type</code> Колонка используется
    красноречив, чтобы определить, какой «тип» родительской модели для возврата при обращении к <code>imageable</code>
    соотношению. В этом случае столбец будет содержать либо <code>App\Models\Post</code> или
    <code>App\Models\User</code>.</p>
<p></p>
<h4 id="one-to-one-polymorphic-model-structure"><a href="#one-to-one-polymorphic-model-structure">Структура модели</a>
</h4>
<p>Затем давайте рассмотрим определения модели, необходимые для построения этой связи:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Model</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">Image</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Get the parent imageable model (user or post).
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">imageable</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">morphTo</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span>

<span class="token keyword">class</span> <span class="token class-name">Post</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Get the post's image.
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">image</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$this</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">morphOne</span><span
                    class="token punctuation">(</span>Image<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">,</span> <span
                    class="token single-quoted-string string">'imageable'</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span>

<span class="token keyword">class</span> <span class="token class-name">User</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Get the user's image.
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">image</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">morphOne</span><span
                    class="token punctuation">(</span>Image<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">,</span> <span
                    class="token single-quoted-string string">'imageable'</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h4 id="one-to-one-polymorphic-retrieving-the-relationship"><a
            href="#one-to-one-polymorphic-retrieving-the-relationship">Получение отношения</a></h4>
<p>Как только ваша таблица базы данных и модели определены, вы можете получить доступ к отношениям через ваши модели.
    Например, чтобы получить изображение для публикации, мы можем получить доступ к <code>image</code> свойству
    динамического отношения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Post</span><span class="token punctuation">;</span>

<span class="token variable">$post</span> <span class="token operator">=</span> Post<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$image</span> <span class="token operator">=</span> <span
                class="token variable">$post</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">image</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете получить родительский элемент полиморфной модели, обратившись к имени метода, который выполняет вызов
    <code>morphTo</code>. В данном случае это <code>imageable</code> метод <code>Image</code> модели. Итак, мы будем
    обращаться к этому методу как к свойству динамического отношения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Image</span><span class="token punctuation">;</span>

<span class="token variable">$image</span> <span class="token operator">=</span> Image<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$imageable</span> <span class="token operator">=</span> <span
                class="token variable">$image</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">imageable</span><span class="token punctuation">;</span></code></pre>
<p><code>imageable</code> Отношение на <code>Image</code> модели будет возвращать <code>Post</code> или
    <code>User</code> экземпляр, в зависимости от того, какого типа модели имеет изображение.</p>
<p></p>
<h4 id="morph-one-to-one-key-conventions"><a href="#morph-one-to-one-key-conventions">Ключевые соглашения</a></h4>
<p>При необходимости вы можете указать имя столбцов «id» и «type», используемых вашей полиморфной дочерней моделью. В
    этом случае убедитесь, что вы всегда передаете имя отношения в качестве первого аргумента <code>morphTo</code>
    метода. Обычно это значение должно совпадать с именем метода, поэтому вы можете использовать
    <code>__FUNCTION__</code> константу PHP:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the model that the image belongs to.
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">imageable</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">morphTo</span><span
                class="token punctuation">(</span><span class="token constant">__FUNCTION__</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'imageable_type'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'imageable_id'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="one-to-many-polymorphic-relations"><a href="#one-to-many-polymorphic-relations">Один ко многим (полиморфный)</a>
</h3>
<p></p>
<h4 id="one-to-many-polymorphic-table-structure"><a href="#one-to-many-polymorphic-table-structure">Структура
        таблицы</a></h4>
<p>Полиморфное отношение «один ко многим» похоже на типичное отношение «один ко многим»; однако дочерняя модель может
    принадлежать более чем к одному типу моделей с помощью одной ассоциации. Например, представьте, что пользователи
    вашего приложения могут «комментировать» сообщения и видео. Используя полиморфные отношения, вы можете использовать
    одну <code>comments</code> таблицу, чтобы содержать комментарии как для сообщений, так и для видео. Во-первых,
    давайте рассмотрим структуру таблицы, необходимую для построения этой связи:</p>
<pre class=" language-php"><code class=" language-php">posts
    id <span class="token operator">-</span> integer
    title <span class="token operator">-</span> string
    body <span class="token operator">-</span> text

videos
    id <span class="token operator">-</span> integer
    title <span class="token operator">-</span> string
    url <span class="token operator">-</span> string

comments
    id <span class="token operator">-</span> integer
    body <span class="token operator">-</span> text
    commentable_id <span class="token operator">-</span> integer
    commentable_type <span class="token operator">-</span> string</code></pre>
<p></p>
<h4 id="one-to-many-polymorphic-model-structure"><a href="#one-to-many-polymorphic-model-structure">Структура модели</a>
</h4>
<p>Затем давайте рассмотрим определения модели, необходимые для построения этой связи:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Model</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">Comment</span> <span class="token keyword">extends</span> <span
                    class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Get the parent commentable model (post or video).
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">commentable</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">morphTo</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span>

<span class="token keyword">class</span> <span class="token class-name">Post</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Get all of the post's comments.
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">comments</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$this</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">morphMany</span><span
                    class="token punctuation">(</span>Comment<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">,</span> <span
                    class="token single-quoted-string string">'commentable'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span>

<span class="token keyword">class</span> <span class="token class-name">Video</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Get all of the video's comments.
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">comments</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">morphMany</span><span
                    class="token punctuation">(</span>Comment<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">,</span> <span
                    class="token single-quoted-string string">'commentable'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h4 id="one-to-many-polymorphic-retrieving-the-relationship"><a
            href="#one-to-many-polymorphic-retrieving-the-relationship">Получение отношения</a></h4>
<p>После того, как ваша таблица базы данных и модели определены, вы можете получить доступ к отношениям через свойства
    динамических отношений вашей модели. Например, чтобы получить доступ ко всем комментариям к публикации, мы можем
    использовать <code>comments</code> динамическое свойство:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Post</span><span class="token punctuation">;</span>

<span class="token variable">$post</span> <span class="token operator">=</span> Post<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">foreach</span> <span class="token punctuation">(</span><span
                class="token variable">$post</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">comments</span> <span class="token keyword">as</span> <span
                class="token variable">$comment</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p>Вы также можете получить родительский элемент полиморфной дочерней модели, обратившись к имени метода, который
    выполняет вызов <code>morphTo</code>. В данном случае это <code>commentable</code> метод <code>Comment</code>
    модели. Итак, мы будем обращаться к этому методу как к свойству динамического отношения, чтобы получить доступ к
    родительской модели комментария:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Comment</span><span class="token punctuation">;</span>

<span class="token variable">$comment</span> <span class="token operator">=</span> Comment<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$commentable</span> <span class="token operator">=</span> <span class="token variable">$comment</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">commentable</span><span
                class="token punctuation">;</span></code></pre>
<p><code>commentable</code> Отношение на <code>Comment</code> модели будет возвращать <code>Post</code> или
    <code>Video</code> экземпляр, в зависимости от того, какого типа модели является комментарий родительским.</p>
<p></p>
<h3 id="many-to-many-polymorphic-relations"><a href="#many-to-many-polymorphic-relations">Многие ко многим
        (полиморфный)</a></h3>
<p></p>
<h4 id="many-to-many-polymorphic-table-structure"><a href="#many-to-many-polymorphic-table-structure">Структура
        таблицы</a></h4>
<p>Полиморфные отношения "многие ко многим" немного сложнее, чем отношения "морфировать один" и "морфировать многие".
    Например, <code>Post</code> модель и <code>Video</code> модель могут иметь полиморфную связь с <code>Tag</code>
    моделью. Использование полиморфного отношения «многие ко многим» в этой ситуации позволит вашему приложению иметь
    единую таблицу уникальных тегов, которые могут быть связаны с сообщениями или видео. Во-первых, давайте рассмотрим
    структуру таблицы, необходимую для построения этой связи:</p>
<pre class=" language-php"><code class=" language-php">posts
    id <span class="token operator">-</span> integer
    name <span class="token operator">-</span> string

videos
    id <span class="token operator">-</span> integer
    name <span class="token operator">-</span> string

tags
    id <span class="token operator">-</span> integer
    name <span class="token operator">-</span> string

taggables
    tag_id <span class="token operator">-</span> integer
    taggable_id <span class="token operator">-</span> integer
    taggable_type <span class="token operator">-</span> string</code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Прежде чем погрузиться в полиморфные отношения «многие ко многим», вам может быть полезно прочитать
            документацию по типичным отношениям « <a href="eloquent-relationships#many-to-many">многие ко многим»</a>.
        </p></p></div>
</blockquote>
<p></p>
<h4 id="many-to-many-polymorphic-model-structure"><a href="#many-to-many-polymorphic-model-structure">Структура
        модели</a></h4>
<p>Далее мы готовы определить отношения на моделях. В <code>Post</code> и <code>Video</code> модели оба содержит <code>tags</code>
    метод, который вызывает <code>morphToMany</code> метод, предоставленный базовые красноречивые модели класса.</p>
<p><code>morphToMany</code> Метод принимает название соответствующей модели, а также «имя отношения». В зависимости от
    имени, которое мы присвоили имени нашей промежуточной таблицы и содержащихся в ней ключей, мы будем называть эту
    связь «taggable»:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Model</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">Post</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Get all of the tags for the post.
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">tags</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">morphToMany</span><span
                    class="token punctuation">(</span>Tag<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">,</span> <span class="token single-quoted-string string">'taggable'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h4 id="many-to-many-polymorphic-defining-the-inverse-of-the-relationship"><a
            href="#many-to-many-polymorphic-defining-the-inverse-of-the-relationship">Определение обратной связи</a>
</h4>
<p>Затем в <code>Tag</code> модели вы должны определить метод для каждой из ее возможных родительских моделей. Итак, в
    этом примере мы определим <code>posts</code> метод и <code>videos</code> метод. Оба эти метода должны возвращать
    результат <code>morphedByMany</code> метода.</p>
<p><code>morphedByMany</code> Метод принимает название соответствующей модели, а также «имя отношения». В зависимости от
    имени, которое мы присвоили имени нашей промежуточной таблицы и содержащихся в ней ключей, мы будем называть эту
    связь «taggable»:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Model</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">Tag</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Get all of the posts that are assigned this tag.
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">posts</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">morphedByMany</span><span
                    class="token punctuation">(</span>Post<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">,</span> <span class="token single-quoted-string string">'taggable'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
     * Get all of the videos that are assigned this tag.
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">videos</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">morphedByMany</span><span
                    class="token punctuation">(</span>Video<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">,</span> <span class="token single-quoted-string string">'taggable'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h4 id="many-to-many-polymorphic-retrieving-the-relationship"><a
            href="#many-to-many-polymorphic-retrieving-the-relationship">Получение отношения</a></h4>
<p>Как только ваша таблица базы данных и модели определены, вы можете получить доступ к отношениям через ваши модели.
    Например, чтобы получить доступ ко всем тегам сообщения, вы можете использовать <code>tags</code> свойство
    динамической связи:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Post</span><span class="token punctuation">;</span>

<span class="token variable">$post</span> <span class="token operator">=</span> Post<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">foreach</span> <span class="token punctuation">(</span><span
                class="token variable">$post</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">tags</span> <span class="token keyword">as</span> <span class="token variable">$tag</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p>Вы можете получить родителя полиморфного отношения из полиморфной дочерней модели, обратившись к имени метода,
    который выполняет вызов <code>morphedByMany</code>. В данном случае это методы <code>posts</code> или <code>videos</code> модели <code>Tag</code>:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Tag</span><span class="token punctuation">;</span>

<span class="token variable">$tag</span> <span class="token operator">=</span> Tag<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">foreach</span> <span class="token punctuation">(</span><span
                class="token variable">$tag</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">posts</span> <span class="token keyword">as</span> <span
                class="token variable">$post</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span>

<span class="token keyword">foreach</span> <span class="token punctuation">(</span><span
                class="token variable">$tag</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">videos</span> <span
                class="token keyword">as</span> <span class="token variable">$video</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="custom-polymorphic-types"><a href="#custom-polymorphic-types">Пользовательские полиморфные типы</a></h3>
<p>По умолчанию Laravel будет использовать полное имя класса для хранения «типа» связанной модели. Например, учитывая
    приведенный выше пример отношения «один ко многим», где <code>Comment</code> модель может принадлежать к
    <code>Post</code> или <code>Video</code> модели, по умолчанию <code>commentable_type</code> будет либо, <code>App\Models\Post</code>
    либо <code>App\Models\Video</code>, соответственно. Однако вы можете захотеть отделить эти значения от внутренней
    структуры вашего приложения.</p>
<p>Например, вместо использования названий моделей в качестве «типа» мы можем использовать простые строки, такие как
    <code>post</code> и <code>video</code>. Таким образом, значения столбца полиморфного типа в нашей базе данных
    останутся действительными, даже если модели будут переименованы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                    class="token punctuation">\</span>Eloquent<span class="token punctuation">\</span>Relations<span
                    class="token punctuation">\</span>Relation</span><span class="token punctuation">;</span>

Relation<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">morphMap</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'post'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'App\Models\Post'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'video'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'App\Models\Video'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете зарегистрировать <code>morphMap</code> в <code>boot</code> функции своего <code>App\Providers\AppServiceProvider</code>
    класса или создать отдельного поставщика услуг, если хотите.</p>
<p>Вы можете определить морфинговый псевдоним данной модели во время выполнения, используя метод модели <code>getMorphClass</code>.
    И наоборот, вы можете определить полное имя класса, связанное с псевдонимом морфинга, используя <code>Relation::getMorphedModel</code>
    метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                    class="token punctuation">\</span>Eloquent<span class="token punctuation">\</span>Relations<span
                    class="token punctuation">\</span>Relation</span><span class="token punctuation">;</span>

<span class="token variable">$alias</span> <span class="token operator">=</span> <span
                class="token variable">$post</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">getMorphClass</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$class</span> <span class="token operator">=</span> Relation<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">getMorphedModel</span><span
                class="token punctuation">(</span><span class="token variable">$alias</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>При добавлении «карты морфинга» к существующему приложению каждое <code>*_type</code> значение морфируемого
            столбца в базе данных, которое все еще содержит полностью определенный класс, необходимо преобразовать в его
            имя «карты».</p></p></div>
</blockquote>
<p></p>
<h3 id="dynamic-relationships"><a href="#dynamic-relationships">Динамические отношения</a></h3>
<p>Вы можете использовать этот <code>resolveRelationUsing</code> метод для определения отношений между моделями Eloquent
    во время выполнения. Хотя обычно это не рекомендуется для нормальной разработки приложений, иногда это может быть
    полезно при разработке пакетов Laravel.</p>
<p><code>resolveRelationUsing</code> Метод принимает желаемое имя отношения в качестве первого аргумента. Второй
    аргумент, передаваемый методу, должен быть замыканием, которое принимает экземпляр модели и возвращает
    действительное определение отношения Eloquent. Как правило, вы должны настроить динамические отношения в методе
    загрузки <a href="providers">поставщика услуг</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Order</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Models<span class="token punctuation">\</span>Customer</span><span
                class="token punctuation">;</span>

Order<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">resolveRelationUsing</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'customer'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$orderModel</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$orderModel</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">belongsTo</span><span
                class="token punctuation">(</span>Customer<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'customer_id'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p> При определении динамических отношений всегда предоставляйте явные аргументы имени ключа методам связи
            Eloquent.</p></p></div>
</blockquote>
<p></p>
<h2 id="querying-relations"><a href="#querying-relations">Запрос отношений</a></h2>
<p>Поскольку все отношения Eloquent определяются с помощью методов, вы можете вызывать эти методы для получения
    экземпляра отношения без фактического выполнения запроса для загрузки связанных моделей. Кроме того, все типы
    отношений Eloquent также служат в качестве <a href="queries">построителей запросов</a>, позволяя вам продолжать
    связывать ограничения в запросе отношений, прежде чем окончательно выполнить SQL-запрос к вашей базе данных.</p>
<p>Например, представьте себе приложение для блога, в котором <code>User</code> модель имеет много связанных
    <code>Post</code> моделей:</p>
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
     * Get all of the posts for the user.
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">posts</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">hasMany</span><span
                    class="token punctuation">(</span>Post<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Вы можете запросить <code>posts</code> отношения и добавить к ним дополнительные ограничения, например:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

<span class="token variable">$user</span> <span class="token operator">=</span> User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">posts</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'active'</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы можете использовать любой из методов <a href="queries">построителя запросов</a> Laravel для отношений, поэтому
    обязательно изучите документацию по построителю запросов, чтобы узнать обо всех доступных вам методах.</p>
<p></p>
<h4 id="chaining-orwhere-clauses-after-relationships"><a href="#chaining-orwhere-clauses-after-relationships">Привязка
        предложений <code>orWhere</code> после отношений</a></h4>
<p>Как показано в приведенном выше примере, вы можете добавлять дополнительные ограничения к отношениям при их запросе.
    Однако будьте осторожны при связывании <code>orWhere</code> предложений с отношениями, так как <code>orWhere</code>
    предложения будут логически сгруппированы на том же уровне, что и ограничение отношения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">posts</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">where</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'active'</span><span class="token punctuation">,</span> <span
                class="token number">1</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">orWhere</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'votes'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'&gt;='</span><span
                class="token punctuation">,</span> <span class="token number">100</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>В приведенном выше примере будет сгенерирован следующий SQL. Как видите, это <code>or</code> предложение предписывает
    запросу возвращать <em>любого</em> пользователя с более чем 100 голосами. Запрос больше не ограничен конкретным
    пользователем:</p>
<pre class=" language-sql"><code class=" language-sql"><span class="token keyword">select</span> <span
                class="token operator">*</span>
<span class="token keyword">from</span> posts
<span class="token keyword">where</span> user_id <span class="token operator">=</span> ? <span class="token operator">and</span> active <span
                class="token operator">=</span> <span class="token number">1</span> <span
                class="token operator">or</span> votes <span class="token operator">&gt;=</span> <span
                class="token number">100</span></code></pre>
<p>В большинстве случаев вам следует использовать <a href="queries#logical-grouping">логические группы</a> для
    группирования условных проверок в круглых скобках:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                    class="token punctuation">\</span>Eloquent<span
                    class="token punctuation">\</span>Builder</span><span class="token punctuation">;</span>

<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">posts</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">where</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span>Builder <span class="token variable">$query</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> <span class="token variable">$query</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'active'</span><span
                class="token punctuation">,</span> <span class="token number">1</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">orWhere</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'votes'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'&gt;='</span><span
                class="token punctuation">,</span> <span class="token number">100</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>В приведенном выше примере будет получен следующий SQL. Обратите внимание, что логическая группировка правильно
    сгруппировала ограничения, и запрос остается ограниченным для конкретного пользователя:</p>
<pre class=" language-sql"><code class=" language-sql"><span class="token keyword">select</span> <span
                class="token operator">*</span>
<span class="token keyword">from</span> posts
<span class="token keyword">where</span> user_id <span class="token operator">=</span> ? <span class="token operator">and</span> <span
                class="token punctuation">(</span>active <span class="token operator">=</span> <span
                class="token number">1</span> <span class="token operator">or</span> votes <span class="token operator">&gt;=</span> <span
                class="token number">100</span><span class="token punctuation">)</span></code></pre>
<p></p>
<h3 id="relationship-methods-vs-dynamic-properties"><a href="#relationship-methods-vs-dynamic-properties">Методы
        взаимоотношений Vs. Динамические свойства</a></h3>
<p>Если вам не нужно добавлять дополнительные ограничения в запрос отношения Eloquent, вы можете получить доступ к
    взаимосвязи, как если бы это было свойство. Например, продолжая использовать наши модели <code>User</code> и <code>Post</code>
    примеры, мы можем получить доступ ко всем сообщениям пользователя следующим образом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

<span class="token variable">$user</span> <span class="token operator">=</span> User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">foreach</span> <span class="token punctuation">(</span><span
                class="token variable">$user</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">posts</span> <span class="token keyword">as</span> <span class="token variable">$post</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p>Свойства динамических отношений выполняют «отложенную загрузку», то есть они будут загружать данные своих отношений
    только тогда, когда вы действительно обращаетесь к ним. Из-за этого разработчики часто используют <a
            href="eloquent-relationships#eager-loading">активную загрузку</a> для предварительной загрузки отношений,
    которые, как они знают, будут доступны после загрузки модели. Активная загрузка обеспечивает значительное сокращение
    количества SQL-запросов, которые необходимо выполнить для загрузки отношений модели.</p>
<p></p>
<h3 id="querying-relationship-existence"><a href="#querying-relationship-existence">Запрос существования отношений</a>
</h3>
<p>При извлечении записей модели вы можете захотеть ограничить свои результаты в зависимости от наличия связи. Например,
    представьте, что вы хотите получить все сообщения в блоге, содержащие хотя бы один комментарий. Для этого, вы можете
    передать имя отношения к <code>has</code> и <code>orHas</code> методам:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Post</span><span class="token punctuation">;</span>

<span class="token comment">// Retrieve all posts that have at least one comment...</span>
<span class="token variable">$posts</span> <span class="token operator">=</span> Post<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">has</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'comments'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы также можете указать оператор и значение счетчика для дальнейшей настройки запроса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">// Retrieve all posts that have three or more comments...</span>
<span class="token variable">$posts</span> <span class="token operator">=</span> Post<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">has</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'comments'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'&gt;='</span><span
                class="token punctuation">,</span> <span class="token number">3</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вложенные <code>has</code> операторы могут быть построены с использованием «точечной» нотации. Например, вы можете
    получить все сообщения, в которых есть хотя бы один комментарий с хотя бы одним изображением:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">// Retrieve posts that have at least one comment with images...</span>
<span class="token variable">$posts</span> <span class="token operator">=</span> Post<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">has</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'comments.images'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Если вам нужно еще больше мощности, вы можете использовать <code>whereHas</code> и <code>orWhereHas</code> методы
    определения дополнительных ограничений запросов на ваших <code>has</code> запросов, например, проверяя содержание
    комментария:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                    class="token punctuation">\</span>Eloquent<span
                    class="token punctuation">\</span>Builder</span><span class="token punctuation">;</span>

<span class="token comment">// Retrieve posts with at least one comment containing words like code%...</span>
<span class="token variable">$posts</span> <span class="token operator">=</span> Post<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">whereHas</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'comments'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>Builder <span class="token variable">$query</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$query</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">where</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'content'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'like'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'code%'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// Retrieve posts with at least ten comments containing words like code%...</span>
<span class="token variable">$posts</span> <span class="token operator">=</span> Post<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">whereHas</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'comments'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>Builder <span class="token variable">$query</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$query</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">where</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'content'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'like'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'code%'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'&gt;='</span><span class="token punctuation">,</span> <span
                class="token number">10</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Eloquent в настоящее время не поддерживает запросы о существовании отношений между базами данных. Отношения
            должны существовать в одной базе данных.</p></p></div>
</blockquote>
<p></p>
<h3 id="querying-relationship-absence"><a href="#querying-relationship-absence">Запрос отсутствия связи</a></h3>
<p>При извлечении записей модели вы можете захотеть ограничить свои результаты на основе отсутствия связи. Например,
    представьте, что вы хотите получить все сообщения в блоге, у <strong>которых нет</strong> комментариев. Для этого,
    вы можете передать имя отношения к <code>doesntHave</code> и <code>orDoesntHave</code> методам:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Post</span><span class="token punctuation">;</span>

<span class="token variable">$posts</span> <span class="token operator">=</span> Post<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">doesntHave</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'comments'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Если вам нужна еще больше мощности, вы можете использовать <code>whereDoesntHave</code> и
    <code>orWhereDoesntHave</code> методы для добавления дополнительных ограничений запросов для ваших
    <code>doesntHave</code> запросов, таких как инспектирование содержания комментария:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                    class="token punctuation">\</span>Eloquent<span
                    class="token punctuation">\</span>Builder</span><span class="token punctuation">;</span>

<span class="token variable">$posts</span> <span class="token operator">=</span> Post<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">whereDoesntHave</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'comments'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>Builder <span class="token variable">$query</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$query</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">where</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'content'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'like'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'code%'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете использовать "точечную" нотацию для выполнения запроса к вложенным отношениям. Например, следующий запрос
    будет извлекать все сообщения, у которых нет комментариев; однако сообщения с комментариями от авторов, которые не
    забанены, будут включены в результаты:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                    class="token punctuation">\</span>Eloquent<span
                    class="token punctuation">\</span>Builder</span><span class="token punctuation">;</span>

<span class="token variable">$posts</span> <span class="token operator">=</span> Post<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">whereDoesntHave</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'comments.author'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>Builder <span class="token variable">$query</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$query</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">where</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'banned'</span><span class="token punctuation">,</span> <span
                class="token number">0</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="querying-morph-to-relationships"><a href="#querying-morph-to-relationships">Запрос морфа к отношениям</a></h3>
<p>Для запроса о существовании «морфинг» отношения, вы можете использовать <code>whereHasMorph</code> и <code>whereDoesntHaveMorph</code>
    методу. Эти методы принимают имя отношения в качестве своего первого аргумента. Затем методы принимают имена
    связанных моделей, которые вы хотите включить в запрос. Наконец, вы можете предоставить закрытие, которое
    настраивает запрос отношения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Comment</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Models<span class="token punctuation">\</span>Post</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Models<span class="token punctuation">\</span>Video</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                    class="token punctuation">\</span>Eloquent<span
                    class="token punctuation">\</span>Builder</span><span class="token punctuation">;</span>

<span class="token comment">// Retrieve comments associated to posts or videos with a title like code%...</span>
<span class="token variable">$comments</span> <span class="token operator">=</span> Comment<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">whereHasMorph</span><span
                class="token punctuation">(</span>
    <span class="token single-quoted-string string">'commentable'</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span>Post<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span><span class="token punctuation">,</span> Video<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token keyword">function</span> <span class="token punctuation">(</span>Builder <span
                class="token variable">$query</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$query</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">where</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'title'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'like'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'code%'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// Retrieve comments associated to posts with a title not like code%...</span>
<span class="token variable">$comments</span> <span class="token operator">=</span> Comment<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">whereDoesntHaveMorph</span><span
                class="token punctuation">(</span>
    <span class="token single-quoted-string string">'commentable'</span><span class="token punctuation">,</span>
    Post<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
    <span class="token keyword">function</span> <span class="token punctuation">(</span>Builder <span
                class="token variable">$query</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$query</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">where</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'title'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'like'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'code%'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Иногда вам может потребоваться добавить ограничения запроса в зависимости от «типа» связанной полиморфной модели.
    Замыкание, переданное <code>whereHasMorph</code> методу, может получить <code>$type</code> значение в качестве
    второго аргумента. Этот аргумент позволяет вам проверить «тип» создаваемого запроса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                    class="token punctuation">\</span>Eloquent<span
                    class="token punctuation">\</span>Builder</span><span class="token punctuation">;</span>

<span class="token variable">$comments</span> <span class="token operator">=</span> Comment<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">whereHasMorph</span><span
                class="token punctuation">(</span>
    <span class="token single-quoted-string string">'commentable'</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span>Post<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span><span class="token punctuation">,</span> Video<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token keyword">function</span> <span class="token punctuation">(</span>Builder <span
                class="token variable">$query</span><span class="token punctuation">,</span> <span
                class="token variable">$type</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$column</span> <span class="token operator">=</span> <span
                class="token variable">$type</span> <span class="token operator">===</span> Post<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span> <span
                class="token operator">?</span> <span class="token single-quoted-string string">'content'</span> <span
                class="token punctuation">:</span> <span class="token single-quoted-string string">'title'</span><span
                class="token punctuation">;</span>
            
        <span class="token variable">$query</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">where</span><span class="token punctuation">(</span><span class="token variable">$column</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'like'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'code%'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="querying-all-morph-to-related-models"><a href="#querying-all-morph-to-related-models">Запрос всех связанных
        моделей</a></h4>
<p>Вместо передачи массива возможных полиморфных моделей вы можете указать <code>*</code> в качестве подстановочного
    знака значение. Это проинструктирует Laravel извлечь все возможные полиморфные типы из базы данных. Laravel выполнит
    дополнительный запрос, чтобы выполнить эту операцию:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                    class="token punctuation">\</span>Eloquent<span
                    class="token punctuation">\</span>Builder</span><span class="token punctuation">;</span>

<span class="token variable">$comments</span> <span class="token operator">=</span> Comment<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">whereHasMorph</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'commentable'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'*'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>Builder <span class="token variable">$query</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$query</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">where</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'title'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'like'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'foo%'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="aggregating-related-models"><a href="#aggregating-related-models">Агрегирование связанных моделей</a></h2>
<p></p>
<h3 id="counting-related-models"><a href="#counting-related-models">Подсчет связанных моделей</a></h3>
<p>Иногда вам может потребоваться подсчитать количество связанных моделей для данного отношения, не загружая модели. Для
    этого вы можете использовать <code>withCount</code> метод. <code>withCount</code> Метод, который поместит
    <code>{literal}{relation}{/literal}_count</code> атрибут получающихся моделей:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Post</span><span class="token punctuation">;</span>

<span class="token variable">$posts</span> <span class="token operator">=</span> Post<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">withCount</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'comments'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token keyword">foreach</span> <span class="token punctuation">(</span><span
                class="token variable">$posts</span> <span class="token keyword">as</span> <span class="token variable">$post</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">echo</span> <span class="token variable">$post</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">comments_count</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Передавая массив <code>withCount</code> методу, вы можете добавить «счетчики» для нескольких отношений, а также
    добавить дополнительные ограничения к запросам:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                    class="token punctuation">\</span>Eloquent<span
                    class="token punctuation">\</span>Builder</span><span class="token punctuation">;</span>

<span class="token variable">$posts</span> <span class="token operator">=</span> Post<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">withCount</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'votes'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'comments'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>Builder <span class="token variable">$query</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$query</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">where</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'content'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'like'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'code%'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token keyword">echo</span> <span class="token variable">$posts</span><span
                class="token punctuation">[</span><span class="token number">0</span><span
                class="token punctuation">]</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">votes_count</span><span
                class="token punctuation">;</span>
<span class="token keyword">echo</span> <span class="token variable">$posts</span><span
                class="token punctuation">[</span><span class="token number">0</span><span
                class="token punctuation">]</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">comments_count</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы также можете использовать псевдоним результата подсчета отношений, разрешив несколько подсчетов для одной и той же
    связи:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                    class="token punctuation">\</span>Eloquent<span
                    class="token punctuation">\</span>Builder</span><span class="token punctuation">;</span>

<span class="token variable">$posts</span> <span class="token operator">=</span> Post<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">withCount</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'comments'</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'comments as pending_comments_count'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>Builder <span class="token variable">$query</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$query</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">where</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'approved'</span><span
                class="token punctuation">,</span> <span class="token boolean constant">false</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">echo</span> <span class="token variable">$posts</span><span
                class="token punctuation">[</span><span class="token number">0</span><span
                class="token punctuation">]</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">comments_count</span><span
                class="token punctuation">;</span>
<span class="token keyword">echo</span> <span class="token variable">$posts</span><span
                class="token punctuation">[</span><span class="token number">0</span><span
                class="token punctuation">]</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">pending_comments_count</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="deferred-count-loading"><a href="#deferred-count-loading">Загрузка отложенного счета</a></h4>
<p>Используя этот <code>loadCount</code> метод, вы можете загрузить счетчик отношений после того, как родительская
    модель уже была получена:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$book</span> <span
                class="token operator">=</span> Book<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">first</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$book</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">loadCount</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'genres'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если вам нужно установить дополнительные ограничения запроса для запроса подсчета, вы можете передать массив с
    ключами отношений, которые вы хотите подсчитать. Значения массива должны быть замыканиями, которые получают
    экземпляр построителя запросов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$book</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">loadCount</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'reviews'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$query</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$query</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">where</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'rating'</span><span class="token punctuation">,</span> <span
                class="token number">5</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span></code></pre>
<p></p>
<h4 id="relationship-counting-and-custom-select-statements"><a
            href="#relationship-counting-and-custom-select-statements">Подсчет отношений и настраиваемые операторы
        выбора</a></h4>
<p>Если вы комбинируете <code>withCount</code> с <code>select</code> оператором, убедитесь, что вы вызываете <code>withCount</code>
    после <code>select</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$posts</span> <span
                class="token operator">=</span> Post<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">select</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'title'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'body'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">withCount</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'comments'</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="other-aggregate-functions"><a href="#other-aggregate-functions">Другие агрегатные функции</a></h3>
<p>В дополнении к <code>withCount</code> способу, Красноречивый предусматривает <code>withMin</code>,
    <code>withMax</code>, <code>withAvg</code> и <code>withSum</code> методу. Эти методы добавят 
    <code>{literal}{relation}{/literal}_{literal}{function}{/literal}_{literal}{column}{/literal}</code> атрибут к вашим результирующим моделям:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Post</span><span class="token punctuation">;</span>

<span class="token variable">$posts</span> <span class="token operator">=</span> Post<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">withSum</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'comments'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'votes'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token keyword">foreach</span> <span class="token punctuation">(</span><span
                class="token variable">$posts</span> <span class="token keyword">as</span> <span class="token variable">$post</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">echo</span> <span class="token variable">$post</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">comments_sum_votes</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Как и <code>loadCount</code> метод, также доступны отложенные версии этих методов. Эти дополнительные агрегатные
    операции могут выполняться на уже полученных моделях Eloquent:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$post</span> <span
                class="token operator">=</span> Post<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">first</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$post</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">loadSum</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'comments'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'votes'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="counting-related-models-on-morph-to-relationships"><a href="#counting-related-models-on-morph-to-relationships">Подсчет
        связанных моделей при преобразовании в отношения</a></h3>
<p>Если вы хотите загрузить отношение «преобразование в», а также соответствующие счетчики модели для различных
    сущностей, которые могут быть возвращены этим отношением, вы можете использовать этот <code>with</code> метод в
    сочетании с методом <code>morphTo</code> отношения <code>morphWithCount</code>.</p>
<p>В этом примере предположим, что <code>Photo</code> и <code>Post</code> модели могут создавать
    <code>ActivityFeed</code> модели. Предположим, что <code>ActivityFeed</code> модель определяет отношение
    «преобразование в» с именем, <code>parentable</code> которое позволяет нам получить родительский элемент
    <code>Photo</code> или <code>Post</code> модель для данного <code>ActivityFeed</code> экземпляра. Кроме того,
    предположим, что у <code>Photo</code> моделей «много» <code>Tag</code> моделей, а у <code>Post</code> моделей
    «много» <code>Comment</code> моделей.</p>
<p>Теперь представим, что мы хотим получить <code>ActivityFeed</code> экземпляры и с нетерпением загрузить <code>parentable</code>
    родительские модели для каждого <code>ActivityFeed</code> экземпляра. Кроме того, мы хотим получить количество
    тегов, связанных с каждой родительской фотографией, и количество комментариев, связанных с каждым родительским
    постом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                    class="token punctuation">\</span>Eloquent<span class="token punctuation">\</span>Relations<span
                    class="token punctuation">\</span>MorphTo</span><span class="token punctuation">;</span>

<span class="token variable">$activities</span> <span class="token operator">=</span> ActivityFeed<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">with</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'parentable'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>MorphTo <span class="token variable">$morphTo</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$morphTo</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">morphWithCount</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
            Photo<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token punctuation">[</span><span class="token single-quoted-string string">'tags'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
            Post<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token punctuation">[</span><span class="token single-quoted-string string">'comments'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
        <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="morph-to-deferred-count-loading"><a href="#morph-to-deferred-count-loading">Загрузка отложенного счета</a></h4>
<p>Предположим, мы уже получили набор <code>ActivityFeed</code> моделей и теперь хотим загрузить счетчики вложенных
    отношений для различных <code>parentable</code> моделей, связанных с фидами активности. Для этого вы можете
    использовать <code>loadMorphCount</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$activities</span> <span
                class="token operator">=</span> ActivityFeed<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">with</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'parentable'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$activities</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">loadMorphCount</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'parentable'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
    Photo<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'tags'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    Post<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'comments'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="eager-loading"><a href="#eager-loading">Нетерпеливая загрузка</a></h2>
<p>При доступе к отношениям Eloquent как к свойствам связанные модели «загружаются отложенно». Это означает, что данные
    отношения фактически не загружаются, пока вы впервые не получите доступ к свойству. Однако Eloquent может
    «нетерпеливо загрузить» отношения во время запроса родительской модели. Активная загрузка устраняет проблему запроса
    "N + 1". Чтобы проиллюстрировать проблему запроса N + 1, рассмотрим <code>Book</code> модель, которая «принадлежит»
    <code>Author</code> модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Model</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">Book</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Get the author that wrote the book.
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">author</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">belongsTo</span><span
                    class="token punctuation">(</span>Author<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Теперь давайте найдем все книги и их авторов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Book</span><span class="token punctuation">;</span>

<span class="token variable">$books</span> <span class="token operator">=</span> Book<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token keyword">foreach</span> <span class="token punctuation">(</span><span
                class="token variable">$books</span> <span class="token keyword">as</span> <span class="token variable">$book</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">echo</span> <span class="token variable">$book</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">author</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">name</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Этот цикл выполнит один запрос для получения всех книг в таблице базы данных, затем еще один запрос для каждой книги,
    чтобы получить автора книги. Итак, если у нас есть 25 книг, приведенный выше код будет запускать 26 запросов: один
    для исходной книги и 25 дополнительных запросов для получения автора каждой книги.</p>
<p>К счастью, мы можем использовать нетерпеливую загрузку, чтобы сократить эту операцию до двух запросов. При построении
    запроса вы можете указать, какие отношения должны быть загружены с помощью <code>with</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$books</span> <span
                class="token operator">=</span> Book<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">with</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'author'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token keyword">foreach</span> <span class="token punctuation">(</span><span
                class="token variable">$books</span> <span class="token keyword">as</span> <span class="token variable">$book</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">echo</span> <span class="token variable">$book</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">author</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">name</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Для этой операции будут выполнены только два запроса - один запрос для получения всех книг и один запрос для
    получения всех авторов для всех книг:</p>
<pre class=" language-sql"><code class=" language-sql"><span class="token keyword">select</span> <span
                class="token operator">*</span> <span class="token keyword">from</span> books

<span class="token keyword">select</span> <span class="token operator">*</span> <span class="token keyword">from</span> authors <span
                class="token keyword">where</span> id <span class="token operator">in</span> <span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">,</span> <span class="token number">2</span><span
                class="token punctuation">,</span> <span class="token number">3</span><span
                class="token punctuation">,</span> <span class="token number">4</span><span
                class="token punctuation">,</span> <span class="token number">5</span><span
                class="token punctuation">,</span> <span class="token punctuation">.</span><span
                class="token punctuation">.</span><span class="token punctuation">.</span><span
                class="token punctuation">)</span></code></pre>
<p></p>
<h4 id="eager-loading-multiple-relationships"><a href="#eager-loading-multiple-relationships">Жажда загрузки
        множественных отношений</a></h4>
<p>Иногда вам может понадобиться загрузить несколько разных отношений. Для этого просто передайте в <code>with</code>
    метод массив отношений:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$books</span> <span
                class="token operator">=</span> Book<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">with</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'author'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'publisher'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="nested-eager-loading"><a href="#nested-eager-loading">Вложенная жадная загрузка</a></h4>
<p>Чтобы наладить отношения, вы можете использовать синтаксис «точка». Например, давайте загрузим всех авторов книги и
    все личные контакты автора:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$books</span> <span
                class="token operator">=</span> Book<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">with</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'author.contacts'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="nested-eager-loading-morphto-relationships"><a href="#nested-eager-loading-morphto-relationships">Вложенные
        <code>morphTo</code> отношения нетерпеливой загрузки</a></h4>
<p>Если вы хотите загрузить <code>morphTo</code> отношение, а также вложенные отношения для различных сущностей, которые
    могут быть возвращены этим отношением, вы можете использовать этот <code>with</code> метод в сочетании с методом
    <code>morphTo</code> отношения <code>morphWith</code>. Чтобы проиллюстрировать этот метод, давайте рассмотрим
    следующую модель:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Model</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ActivityFeed</span> <span class="token keyword">extends</span> <span
                    class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Get the parent of the activity feed record.
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">parentable</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">morphTo</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>В этом примере, предположим <code>Event</code>, <code>Photo</code> и <code>Post</code> модели могут создавать <code>ActivityFeed</code>
    модели. Кроме того, предположим, что <code>Event</code> модели принадлежат <code>Calendar</code> модели,
    <code>Photo</code> модели связаны с <code>Tag</code> моделями, а <code>Post</code> модели принадлежат
    <code>Author</code> модели.</p>
<p>Используя эти определения и отношения моделей, мы можем извлекать <code>ActivityFeed</code> экземпляры <code>parentable</code>
    моделей и загружать все модели и их соответствующие вложенные отношения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                    class="token punctuation">\</span>Eloquent<span class="token punctuation">\</span>Relations<span
                    class="token punctuation">\</span>MorphTo</span><span class="token punctuation">;</span>

<span class="token variable">$activities</span> <span class="token operator">=</span> ActivityFeed<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">query</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">with</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span
                class="token single-quoted-string string">'parentable'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>MorphTo <span class="token variable">$morphTo</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$morphTo</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">morphWith</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
            Event<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token punctuation">[</span><span class="token single-quoted-string string">'calendar'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
            Photo<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token punctuation">[</span><span class="token single-quoted-string string">'tags'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
            Post<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token punctuation">[</span><span class="token single-quoted-string string">'author'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
        <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="eager-loading-specific-columns"><a href="#eager-loading-specific-columns">Активная загрузка определенных
        столбцов</a></h4>
<p>Вам не всегда может понадобиться каждый столбец из извлекаемых вами отношений. По этой причине Eloquent позволяет вам
    указать, какие столбцы отношения вы хотите получить:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$books</span> <span
                class="token operator">=</span> Book<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">with</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'author:id,name'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>При использовании этой функции вы всегда должны включать <code>id</code> столбец и любые соответствующие
            столбцы внешнего ключа в список столбцов, которые вы хотите получить.</p></p></div>
</blockquote>
<p></p>
<h4 id="eager-loading-by-default"><a href="#eager-loading-by-default">Активная загрузка по умолчанию</a></h4>
<p>Иногда вам может потребоваться всегда загружать некоторые отношения при извлечении модели. Для этого вы можете
    определить <code>$with</code> свойство модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Model</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">Book</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * The relationships that should always be loaded.
     *
     * @var array
     */</span>
    <span class="token keyword">protected</span> <span class="token variable">$with</span> <span class="token operator">=</span> <span
                    class="token punctuation">[</span><span
                    class="token single-quoted-string string">'author'</span><span
                    class="token punctuation">]</span><span class="token punctuation">;</span>

    <span class="token comment">/**
     * Get the author that wrote the book.
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">author</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">belongsTo</span><span
                    class="token punctuation">(</span>Author<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Если вы хотите удалить элемент из <code>$with</code> свойства для одного запроса, вы можете использовать <code>without</code>
    метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$books</span> <span
                class="token operator">=</span> Book<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">without</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'author'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="constraining-eager-loads"><a href="#constraining-eager-loads">Ограничение нетерпеливой нагрузки</a></h3>
<p>Иногда вам может потребоваться активная загрузка отношения, но также указать дополнительные условия запроса для
    запроса активной загрузки. Вы можете сделать это, передав массив отношений в <code>with</code> метод, где ключ
    массива - это имя отношения, а значение массива - это замыкание, которое добавляет дополнительные ограничения к
    запросу нетерпеливой загрузки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

<span class="token variable">$users</span> <span class="token operator">=</span> User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">with</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'posts'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$query</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$query</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">where</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'title'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'like'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'%code%'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>В этом примере Eloquent будет загружать только сообщения, в <code>title</code> столбце которых содержится слово
    <code>code</code>. Вы можете вызвать другие методы <a href="queries">построителя запросов</a> для дальнейшей
    настройки операции активной загрузки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">with</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'posts'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$query</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$query</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">orderBy</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'created_at'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'desc'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p><code>limit</code> И <code>take</code> построитель запросов методы не могут быть использованы при сдерживая
            нетерпеливые нагрузки.</p></p></div>
</blockquote>
<p></p>
<h4 id="constraining-eager-loading-of-morph-to-relationships"><a
            href="#constraining-eager-loading-of-morph-to-relationships">Ограничение нетерпеливой загрузки
        <code>morphTo</code> отношений</a></h4>
<p>Если вам не терпится загрузить <code>morphTo</code> отношения, Eloquent выполнит несколько запросов для получения
    каждого типа связанной модели. Вы можете добавить дополнительные ограничения к каждому из этих запросов, используя
    метод <code>MorphTo</code> отношения <code>constrain</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                    class="token punctuation">\</span>Eloquent<span
                    class="token punctuation">\</span>Builder</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                    class="token punctuation">\</span>Eloquent<span class="token punctuation">\</span>Relations<span
                    class="token punctuation">\</span>MorphTo</span><span class="token punctuation">;</span>

<span class="token variable">$comments</span> <span class="token operator">=</span> Comment<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">with</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'commentable'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>MorphTo <span class="token variable">$morphTo</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$morphTo</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">constrain</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
        Post<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span>Builder <span
                class="token variable">$query</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
            <span class="token variable">$query</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">whereNull</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'hidden_at'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">,</span>
        Video<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span>Builder <span
                class="token variable">$query</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
            <span class="token variable">$query</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">where</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'type'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'educational'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>В этом примере Eloquent будет загружать только те сообщения, которые не были скрыты, а видео имеют <code>type</code>
    значение «образовательные».</p>
<p></p>
<h3 id="lazy-eager-loading"><a href="#lazy-eager-loading">Ленивая загрузка</a></h3>
<p>Иногда вам может потребоваться загрузить отношение после того, как родительская модель уже получена. Например, это
    может быть полезно, если вам нужно динамически решать, загружать ли связанные модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Book</span><span class="token punctuation">;</span>

<span class="token variable">$books</span> <span class="token operator">=</span> Book<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token variable">$someCondition</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$books</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">load</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'author'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'publisher'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Если вам нужно установить дополнительные ограничения запроса для запроса активной загрузки, вы можете передать массив
    с ключом отношений, которые вы хотите загрузить. Значения массива должны быть экземплярами замыкания, которые
    получают экземпляр запроса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$author</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">load</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'books'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$query</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$query</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">orderBy</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'published_date'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'asc'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Чтобы загрузить отношение только тогда, когда оно еще не было загружено, используйте <code>loadMissing</code> метод:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$book</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">loadMissing</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'author'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="nested-lazy-eager-loading-morphto"><a href="#nested-lazy-eager-loading-morphto">Вложенная отложенная загрузка и
        <code>morphTo</code></a></h4>
<p>Если вы хотите загружать <code>morphTo</code> отношения, а также вложенные отношения для различных сущностей, которые
    могут быть возвращены этим отношением, вы можете использовать этот <code>loadMorph</code> метод.</p>
<p>Этот метод принимает имя <code>morphTo</code> отношения в качестве первого аргумента и массив пар модель / отношение
    в качестве второго аргумента. Чтобы проиллюстрировать этот метод, давайте рассмотрим следующую модель:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Model</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ActivityFeed</span> <span class="token keyword">extends</span> <span
                    class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Get the parent of the activity feed record.
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">parentable</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">morphTo</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>В этом примере, предположим <code>Event</code>, <code>Photo</code> и <code>Post</code> модели могут создавать <code>ActivityFeed</code>
    модели. Кроме того, предположим, что <code>Event</code> модели принадлежат <code>Calendar</code> модели,
    <code>Photo</code> модели связаны с <code>Tag</code> моделями, а <code>Post</code> модели принадлежат
    <code>Author</code> модели.</p>
<p>Используя эти определения и отношения моделей, мы можем извлекать <code>ActivityFeed</code> экземпляры <code>parentable</code>
    моделей и загружать все модели и их соответствующие вложенные отношения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$activities</span> <span
                class="token operator">=</span> ActivityFeed<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">with</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'parentable'</span><span class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">loadMorph</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'parentable'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
        Event<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token punctuation">[</span><span class="token single-quoted-string string">'calendar'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
        Photo<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">class</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token punctuation">[</span><span class="token single-quoted-string string">'tags'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
        Post<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'author'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="inserting-and-updating-related-models"><a href="#inserting-and-updating-related-models">Вставка и обновление
        связанных моделей</a></h2>
<p></p>
<h3 id="the-save-method"><a href="#the-save-method"><code>save</code> Метод</a></h3>
<p>Eloquent предоставляет удобные методы для добавления новых моделей в отношения. Например, возможно, вам нужно
    добавить новый комментарий к сообщению. Вместо того, чтобы вручную устанавливать <code>post_id</code> атрибут в
    <code>Comment</code> модели, вы можете вставить комментарий, используя метод отношения <code>save</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Comment</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Models<span class="token punctuation">\</span>Post</span><span
                class="token punctuation">;</span>

<span class="token variable">$comment</span> <span class="token operator">=</span> <span
                class="token keyword">new</span> <span class="token class-name">Comment</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'message'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'A new comment.'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$post</span> <span class="token operator">=</span> Post<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$post</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">comments</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">save</span><span class="token punctuation">(</span><span class="token variable">$comment</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Обратите внимание, что мы не использовали <code>comments</code> отношение как динамическое свойство. Вместо этого мы
    вызвали <code>comments</code> метод, чтобы получить экземпляр отношения. <code>save</code> Метод будет автоматически
    добавить соответствующее <code>post_id</code> значение для новой <code>Comment</code> модели.</p>
<p>Если вам нужно сохранить несколько связанных моделей, вы можете использовать <code>saveMany</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$post</span> <span
                class="token operator">=</span> Post<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$post</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">comments</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">saveMany</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token keyword">new</span> <span class="token class-name">Comment</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'message'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'A new comment.'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span>
    <span class="token keyword">new</span> <span class="token class-name">Comment</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'message'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Another new comment.'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p><code>save</code> И <code>saveMany</code> методы не будут добавлять новые модели для любых отношений в памяти,
    которые уже загружены на родительской модели. Если вы планируете получить доступ к взаимосвязи после использования
    методов <code>save</code> или <code>saveMany</code>, вы можете использовать этот <code>refresh</code> метод для
    перезагрузки модели и ее взаимосвязей:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$post</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">comments</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">save</span><span class="token punctuation">(</span><span class="token variable">$comment</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$post</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">refresh</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// All comments, including the newly saved comment...</span>
<span class="token variable">$post</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">comments</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="the-push-method"><a href="#the-push-method">Рекурсивное сохранение моделей и отношений</a></h4>
<p>Если вам нужна <code>save</code> ваша модель и все связанные с ней отношения, вы можете использовать этот
    <code>push</code> метод. В этом примере <code>Post</code> будет сохранена модель, а также ее комментарии и авторы
    комментария:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$post</span> <span
                class="token operator">=</span> Post<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$post</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">comments</span><span
                class="token punctuation">[</span><span class="token number">0</span><span
                class="token punctuation">]</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">message</span> <span
                class="token operator">=</span> <span class="token single-quoted-string string">'Message'</span><span
                class="token punctuation">;</span>
<span class="token variable">$post</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">comments</span><span
                class="token punctuation">[</span><span class="token number">0</span><span
                class="token punctuation">]</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">author</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">name</span> <span class="token operator">=</span> <span
                class="token single-quoted-string string">'Author Name'</span><span class="token punctuation">;</span>

<span class="token variable">$post</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">push</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="the-create-method"><a href="#the-create-method"><code>create</code> Метод</a></h3>
<p>В дополнении к <code>save</code> и <code>saveMany</code> методам, вы можете также использовать <code>create</code>
    метод, который принимает массив атрибутов, создает модель, и вставляет его в базу данных. Разница между
    <code>save</code> и <code>create</code> заключается в том, что он <code>save</code> принимает полный экземпляр
    модели Eloquent, в то время как <code>create</code> принимает простой PHP <code>array</code>. Вновь созданная модель
    будет возвращена <code>create</code> методом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Post</span><span class="token punctuation">;</span>

<span class="token variable">$post</span> <span class="token operator">=</span> Post<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$comment</span> <span class="token operator">=</span> <span
                class="token variable">$post</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">comments</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'message'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'A new comment.'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете использовать этот <code>createMany</code> метод для создания нескольких связанных моделей:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$post</span> <span
                class="token operator">=</span> Post<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$post</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">comments</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">createMany</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'message'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'A new comment.'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'message'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Another new comment.'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы также можете использовать <code>findOrNew</code>, <code>firstOrNew</code>, <code>firstOrCreate</code> и <code>updateOrCreate</code>
    методы <a href="eloquent#upserts">создания и модель обновления на отношениях</a>.</p>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Перед использованием <code>create</code> метода обязательно ознакомьтесь с документацией по <a
                    href="eloquent#mass-assignment">массовому назначению</a>.</p></p></div>
</blockquote>
<p></p>
<h3 id="updating-belongs-to-relationships"><a href="#updating-belongs-to-relationships">Принадлежит к отношениям</a>
</h3>
<p>Если вы хотите назначить дочернюю модель новой родительской модели, вы можете использовать этот
    <code>associate</code> метод. В этом примере <code>User</code> модель определяет <code>belongsTo</code> отношение к
    <code>Account</code> модели. Этот <code>associate</code> метод установит внешний ключ для дочерней модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Account</span><span class="token punctuation">;</span>

<span class="token variable">$account</span> <span class="token operator">=</span> Account<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">10</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">account</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">associate</span><span
                class="token punctuation">(</span><span class="token variable">$account</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">save</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Чтобы удалить родительскую модель из дочерней модели, вы можете использовать <code>dissociate</code> метод. Этот
    метод установит внешний ключ отношения на <code>null</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">account</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">dissociate</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">save</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="updating-many-to-many-relationships"><a href="#updating-many-to-many-relationships">Отношения многие ко
        многим</a></h3>
<p></p>
<h4 id="attaching-detaching"><a href="#attaching-detaching">Присоединение / Отсоединение</a></h4>
<p>Eloquent также предоставляет методы, которые делают работу с отношениями «многие ко многим» более удобными. Например,
    представим, что у пользователя может быть много ролей, а у роли может быть много пользователей. Вы можете
    использовать этот <code>attach</code> метод для присоединения роли к пользователю, вставив запись в промежуточную
    таблицу отношения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

<span class="token variable">$user</span> <span class="token operator">=</span> User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">roles</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">attach</span><span
                class="token punctuation">(</span><span class="token variable">$roleId</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>При присоединении отношения к модели вы также можете передать массив дополнительных данных для вставки в
    промежуточную таблицу:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">roles</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">attach</span><span
                class="token punctuation">(</span><span class="token variable">$roleId</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'expires'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$expires</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Иногда может потребоваться удалить роль пользователя. Чтобы удалить запись отношения «многие ко многим», используйте
    <code>detach</code> метод. <code>detach</code> Метод удалит соответствующий записывались, промежуточной таблицы;
    однако обе модели останутся в базе данных:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">// Detach a single role from the user...</span>
<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">roles</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">detach</span><span
                class="token punctuation">(</span><span class="token variable">$roleId</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// Detach all roles from the user...</span>
<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">roles</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">detach</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Для удобства, <code>attach</code> а <code>detach</code> также принимаем в качестве входных данных массивы
    идентификаторов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">roles</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">detach</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">roles</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">attach</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token number">1</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'expires'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$expires</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token number">2</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'expires'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$expires</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="syncing-associations"><a href="#syncing-associations">Синхронизация ассоциаций</a></h4>
<p>Вы также можете использовать этот <code>sync</code> метод для построения ассоциаций "многие ко многим".
    <code>sync</code> Метод принимает массив идентификаторов для размещения на промежуточной таблице. Любые
    идентификаторы, которых нет в данном массиве, будут удалены из промежуточной таблицы. Итак, после завершения этой
    операции в промежуточной таблице будут существовать только идентификаторы из данного массива:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">roles</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">sync</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token number">1</span><span
                class="token punctuation">,</span> <span class="token number">2</span><span
                class="token punctuation">,</span> <span class="token number">3</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы также можете передать дополнительные промежуточные значения таблицы с идентификаторами:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">roles</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">sync</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token number">1</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'expires'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token boolean constant">true</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если вы не хотите отделять существующие идентификаторы, которые отсутствуют в данном массиве, вы можете использовать
    <code>syncWithoutDetaching</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">roles</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">syncWithoutDetaching</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="toggling-associations"><a href="#toggling-associations">Переключение ассоциаций</a></h4>
<p>Отношение «многие ко многим» также предоставляет <code>toggle</code> метод, который «переключает» статус
    присоединения для данных идентификаторов связанных моделей. Если данный идентификатор в настоящее время прикреплен,
    он будет отключен. Аналогичным образом, если он в настоящее время отсоединен, он будет прикреплен:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">roles</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">toggle</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="updating-a-record-on-the-intermediate-table"><a href="#updating-a-record-on-the-intermediate-table">Обновление
        записи в промежуточной таблице</a></h4>
<p>Если вам нужно обновить существующую строку в промежуточной таблице ваших отношений, вы можете использовать этот
    <code>updateExistingPivot</code> метод. Этот метод принимает внешний ключ промежуточной записи и массив атрибутов
    для обновления:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$user</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">roles</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">updateExistingPivot</span><span
                class="token punctuation">(</span><span class="token variable">$roleId</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'active'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token boolean constant">false</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="touching-parent-timestamps"><a href="#touching-parent-timestamps">Касание родительских отметок времени</a></h2>
<p>Когда модель определяет отношение <code>belongsTo</code> или <code>belongsToMany</code> к другой модели, например,
    <code>Comment</code> которая принадлежит к <code>Post</code>, иногда бывает полезно обновить метку времени родителя
    при обновлении дочерней модели.</p>
<p>Например, при <code>Comment</code> обновлении модели вы можете захотеть автоматически «прикоснуться» к <code>updated_at</code>
    временной метке владельца, <code>Post</code> чтобы установить текущую дату и время. Для этого вы можете добавить
    <code>touches</code> свойство в свою дочернюю модель, содержащее имена отношений, <code>updated_at</code> метки
    времени которых должны обновляться при обновлении дочерней модели:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Models</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span
                        class="token punctuation">\</span>Model</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">Comment</span> <span class="token keyword">extends</span> <span
                    class="token class-name">Model</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * All of the relationships to be touched.
     *
     * @var array
     */</span>
    <span class="token keyword">protected</span> <span class="token variable">$touches</span> <span
                    class="token operator">=</span> <span class="token punctuation">[</span><span
                    class="token single-quoted-string string">'post'</span><span class="token punctuation">]</span><span
                    class="token punctuation">;</span>

    <span class="token comment">/**
     * Get the post that the comment belongs to.
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">post</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">belongsTo</span><span
                    class="token punctuation">(</span>Post<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Временные метки родительской модели будут обновлены, только если дочерняя модель обновлена ​​с помощью <code>save</code>
            метода Eloquent.</p></p></div>
</blockquote> 
