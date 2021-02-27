<h1>БД: пагинация <sup>Pagination</sup></h1>
<ul>
    <li><a href="pagination#introduction">Вступление</a></li>
    <li><a href="pagination#basic-usage">Основное использование</a>
        <ul>
            <li><a href="pagination#paginating-query-builder-results">Пагинация результатов построителя запросов</a>
            </li>
            <li><a href="pagination#paginating-eloquent-results">Пагинация красноречивых результатов</a></li>
            <li><a href="pagination#manually-creating-a-paginator">Создание пагинатора вручную</a></li>
            <li><a href="pagination#customizing-pagination-urls">Настройка URL-адресов пагинации</a></li>
        </ul>
    </li>
    <li><a href="pagination#displaying-pagination-results">Отображение результатов разбивки на страницы</a>
        <ul>
            <li><a href="pagination#adjusting-the-pagination-link-window">Настройка окна ссылки на страницы</a></li>
            <li><a href="pagination#converting-results-to-json">Преобразование результатов в JSON</a></li>
        </ul>
    </li>
    <li><a href="pagination#customizing-the-pagination-view">Настройка представления разбивки на страницы</a>
        <ul>
            <li><a href="pagination#using-bootstrap">Использование Bootstrap</a></li>
        </ul>
    </li>
    <li><a href="pagination#paginator-instance-methods">Методы экземпляра пагинатора</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>В других фреймворках разбивка на страницы может быть очень болезненной. Мы надеемся, что подход Laravel к разбиению
    на страницы станет глотком свежего воздуха. Пагинатор Laravel интегрирован с <a href="queries">построителем
        запросов</a> и <a href="eloquent">Eloquent ORM</a> и обеспечивает удобную, простую в использовании разбивку на
    страницы записей базы данных с нулевой конфигурацией.</p>
<p>По умолчанию HTML, сгенерированный средством разбиения на страницы, совместим со структурой <a
            href="https://tailwindcss.com/">Tailwind CSS</a> ; однако также доступна поддержка разбивки на страницы
    Bootstrap.</p>
<p></p>
<h2 id="basic-usage"><a href="#basic-usage">Основное использование</a></h2>
<p></p>
<h3 id="paginating-query-builder-results"><a href="#paginating-query-builder-results">Пагинация результатов построителя
        запросов</a></h3>
<p>Есть несколько способов разбить элементы на страницы. Самый простой - использовать <code>paginate</code> метод в <a
            href="queries">построителе запросов</a> или <a href="eloquent">запрос Eloquent</a>. <code>paginate</code>
    Метод автоматически заботится о настройке запроса в «предел» и «смещения» на основе текущей страницы
    просматриваемого пользователя. По умолчанию текущая страница определяется значением <code>page</code> аргумента
    строки запроса в HTTP-запросе. Это значение автоматически определяется Laravel, а также автоматически вставляется в
    ссылки, генерируемые пагинатором.</p>
<p>В этом примере единственный аргумент, переданный <code>paginate</code> методу, - это количество элементов, которые вы
    хотите отображать «на странице». В этом случае давайте укажем, что мы хотели бы отображать <code>15</code> элементы
    на странице:</p>
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
    * Show all of the users for the application.
    *
    * @return \Illuminate\Http\Response
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">index</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token function">view</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'user.index'</span><span
                    class="token punctuation">,</span> <span class="token punctuation">[</span>
            <span class="token single-quoted-string string">'users'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token constant">DB</span><span
                    class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">table</span><span class="token punctuation">(</span><span
                    class="token single-quoted-string string">'users'</span><span
                    class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">paginate</span><span class="token punctuation">(</span><span
                    class="token number">15</span><span class="token punctuation">)</span>
        <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h4 id="simple-pagination"><a href="#simple-pagination">«Простая разбивка на страницы»</a></h4>
<p><code>paginate</code> Метод подсчитывает общее количество записей, совпадающих с запросом перед извлечением записи из
    базы данных. Это сделано для того, чтобы пагинатор знал, сколько всего страниц записей. Однако, если вы не
    планируете отображать общее количество страниц в пользовательском интерфейсе вашего приложения, запрос количества
    записей не нужен.</p>
<p>Следовательно, если вам нужно отобразить только простые ссылки «Далее» и «Назад» в пользовательском интерфейсе
    приложения, вы можете использовать этот <code>simplePaginate</code> метод для выполнения одного эффективного
    запроса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> <span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">simplePaginate</span><span
                class="token punctuation">(</span><span class="token number">15</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="paginating-eloquent-results"><a href="#paginating-eloquent-results">Пагинация красноречивых результатов</a></h3>
<p>Вы также можете разбивать запросы <a href="eloquent">Eloquent на</a> страницы. В этом примере мы разберем <code>App\Models\User</code>
    модель на страницы и укажем, что планируем отображать 15 записей на странице. Как видите, синтаксис почти идентичен
    разбивке на страницы результатов построителя запросов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

<span class="token variable">$users</span> <span class="token operator">=</span> User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">paginate</span><span
                class="token punctuation">(</span><span class="token number">15</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Конечно, вы можете вызвать <code>paginate</code> метод после установки других ограничений для запроса, таких как
    <code>where</code> предложения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'votes'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'&gt;'</span><span
                class="token punctuation">,</span> <span class="token number">100</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">paginate</span><span
                class="token punctuation">(</span><span class="token number">15</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы также можете использовать этот <code>simplePaginate</code> метод при разбивке на страницы моделей Eloquent:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'votes'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'&gt;'</span><span
                class="token punctuation">,</span> <span class="token number">100</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">simplePaginate</span><span
                class="token punctuation">(</span><span class="token number">15</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="manually-creating-a-paginator"><a href="#manually-creating-a-paginator">Создание пагинатора вручную</a></h3>
<p>Иногда вы можете захотеть создать экземпляр разбивки на страницы вручную, передав ему массив элементов, которые у вас
    уже есть в памяти. Вы можете сделать это, создав экземпляр <code>Illuminate\Pagination\Paginator</code> или <code>Illuminate\Pagination\LengthAwarePaginator</code>,
    в зависимости от ваших потребностей.</p>
<p><code>Paginator</code> Класс не нужно знать общее количество элементов в наборе результатов; однако из-за этого у
    класса нет методов для получения индекса последней страницы. <code>LengthAwarePaginator</code> Принимает почти те же
    аргументы, что и <code>Paginator</code> ; однако для этого требуется подсчет общего количества элементов в наборе
    результатов.</p>
<p>Другими словами, <code>Paginator</code> соответствует <code>simplePaginate</code> методу в построителе запросов, а
    <code>LengthAwarePaginator</code> соответствует <code>paginate</code> методу.</p>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>При создании экземпляра пагинатора вручную вы должны вручную «разрезать» массив результатов, который вы
            передаете пагинатору. Если вы не знаете, как это сделать, <a
                    href="https://secure.php.net/manual/en/function.array-slice.php">попробуйте</a> PHP-функцию <a
                    href="https://secure.php.net/manual/en/function.array-slice.php">array_slice</a>.</p></p></div>
</blockquote>
<p></p>
<h3 id="customizing-pagination-urls"><a href="#customizing-pagination-urls">Настройка URL-адресов пагинации</a></h3>
<p>По умолчанию ссылки, созданные пагинатором, будут соответствовать URI текущего запроса. Однако метод разбиения на
    страницы <code>withPath</code> позволяет настроить URI, используемый средством разбиения на страницы при создании
    ссылок. Например, если вы хотите, чтобы пагинатор генерировал ссылки типа <code>http://example.com/admin/users?page=N</code>,
    вы должны перейти <code>/admin/users</code> к <code>withPath</code> методу:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/users'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$users</span> <span class="token operator">=</span> User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">paginate</span><span
                class="token punctuation">(</span><span class="token number">15</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
            
    <span class="token variable">$users</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">withPath</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/admin/users'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
            
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="appending-query-string-values"><a href="#appending-query-string-values">Добавление значений строки запроса</a>
</h4>
<p>Вы можете добавить в строку запроса ссылки для пагинации с помощью этого <code>appends</code> метода. Например, чтобы
    добавить <code>sort=votes</code> к каждой ссылке пагинации, вы должны сделать следующий вызов <code>appends</code>:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/users'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$users</span> <span class="token operator">=</span> User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">paginate</span><span
                class="token punctuation">(</span><span class="token number">15</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
            
    <span class="token variable">$users</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">appends</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'sort'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'votes'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
            
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы можете использовать этот <code>withQueryString</code> метод, если хотите добавить все значения строки запроса
    текущего запроса к ссылкам пагинации:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">paginate</span><span
                class="token punctuation">(</span><span class="token number">15</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">withQueryString</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="appending-hash-fragments"><a href="#appending-hash-fragments">Добавление фрагментов хэша</a></h4>
<p>Если вам нужно добавить «хеш-фрагмент» к URL-адресам, сгенерированным пагинатором, вы можете использовать этот <code>fragment</code>
    метод. Например, чтобы добавить <code>#users</code> в конец каждой ссылки нумерации страниц, вы должны вызвать такой
    <code>fragment</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">paginate</span><span
                class="token punctuation">(</span><span class="token number">15</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">fragment</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="displaying-pagination-results"><a href="#displaying-pagination-results">Отображение результатов разбивки на
        страницы</a></h2>
<p>При вызове <code>paginate</code> метода вы получите экземпляр <code>Illuminate\Pagination\LengthAwarePaginator</code>.
    При вызове <code>simplePaginate</code> метода вы получите экземпляр <code>Illuminate\Pagination\Paginator</code>.
    Эти объекты предоставляют несколько методов, описывающих набор результатов. В дополнение к этим вспомогательным
    методам экземпляры разбиения на страницы являются итераторами и могут быть зациклены как массив. Итак, после
    получения результатов вы можете отображать результаты и отображать ссылки на страницы с помощью <a href="blade">Blade</a>:
</p>
<pre class=" language-html"><code class=" language-html"><span class="token tag"><span class="token tag"><span
                        class="token punctuation">&lt;</span>div</span> <span class="token attr-name">class</span><span
                    class="token attr-value"><span class="token punctuation attr-equals">=</span><span
                        class="token punctuation">"</span>container<span class="token punctuation">"</span></span><span
                    class="token punctuation">&gt;</span></span>
    @foreach ($users as $user)
        {literal}{{{/literal} $user-&gt;name }}
    @endforeach
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>div</span><span
            class="token punctuation">&gt;</span></span>

{literal}{{{/literal} $users-&gt;links() }}</code></pre>
<p><code>links</code> Метод будет оказывать ссылки на остальные страницы в наборе результатов. Каждая из этих ссылок уже
    будет содержать правильную <code>page</code> переменную строки запроса. Помните, что HTML, сгенерированный этим
    <code>links</code> методом, совместим со структурой <a href="https://tailwindcss.com">Tailwind CSS</a>.</p>
<p></p>
<h3 id="adjusting-the-pagination-link-window"><a href="#adjusting-the-pagination-link-window">Настройка окна ссылки на
        страницы</a></h3>
<p>Когда пагинатор отображает ссылки для пагинации, отображается номер текущей страницы, а также ссылки для трех страниц
    до и после текущей страницы. При необходимости вы можете контролировать, сколько дополнительных ссылок отображается
    с каждой стороны текущей страницы, используя <code>onEachSide</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token punctuation">{literal}{{/literal}</span><span
                class="token punctuation">{literal}{{/literal}</span> <span class="token variable">$users</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">onEachSide</span><span
                class="token punctuation">(</span><span class="token number">5</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">links</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">}</span><span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="converting-results-to-json"><a href="#converting-results-to-json">Преобразование результатов в JSON</a></h3>
<p>Классы разбиения на страницы Laravel реализуют <code>Illuminate\Contracts\Support\Jsonable</code> контракт интерфейса
    и предоставляют <code>toJson</code> метод, поэтому очень легко преобразовать результаты разбиения на страницы в
    JSON. Вы также можете преобразовать экземпляр пагинатора в JSON, вернув его из маршрута или действия контроллера:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/users'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">paginate</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>JSON из постраничной навигации будет включать в себя мета информацию, такую как <code>total</code>, <code>current_page</code>,
    <code>last_page</code> и многое другое. Записи результатов доступны через <code>data</code> ключ в массиве JSON. Вот
    пример JSON, созданного путем возврата экземпляра пагинатора из маршрута:</p>
<pre class=" language-php"><code class=" language-php"><span class="token punctuation">{literal}{{/literal}</span>
    <span class="token double-quoted-string string">"total"</span><span class="token punctuation">:</span> <span
                class="token number">50</span><span class="token punctuation">,</span>
    <span class="token double-quoted-string string">"per_page"</span><span
                class="token punctuation">:</span> <span class="token number">15</span><span
                class="token punctuation">,</span>
    <span class="token double-quoted-string string">"current_page"</span><span
                class="token punctuation">:</span> <span class="token number">1</span><span
                class="token punctuation">,</span>
    <span class="token double-quoted-string string">"last_page"</span><span
                class="token punctuation">:</span> <span class="token number">4</span><span
                class="token punctuation">,</span>
    <span class="token double-quoted-string string">"first_page_url"</span><span
                class="token punctuation">:</span> <span class="token double-quoted-string string">"http://laravel.app?page=1"</span><span
                class="token punctuation">,</span>
    <span class="token double-quoted-string string">"last_page_url"</span><span
                class="token punctuation">:</span> <span class="token double-quoted-string string">"http://laravel.app?page=4"</span><span
                class="token punctuation">,</span>
    <span class="token double-quoted-string string">"next_page_url"</span><span
                class="token punctuation">:</span> <span class="token double-quoted-string string">"http://laravel.app?page=2"</span><span
                class="token punctuation">,</span>
    <span class="token double-quoted-string string">"prev_page_url"</span><span
                class="token punctuation">:</span> <span class="token constant">null</span><span
                class="token punctuation">,</span>
    <span class="token double-quoted-string string">"path"</span><span class="token punctuation">:</span> <span
                class="token double-quoted-string string">"http://laravel.app"</span><span
                class="token punctuation">,</span>
    <span class="token double-quoted-string string">"from"</span><span class="token punctuation">:</span> <span
                class="token number">1</span><span class="token punctuation">,</span>
    <span class="token double-quoted-string string">"to"</span><span class="token punctuation">:</span> <span
                class="token number">15</span><span class="token punctuation">,</span>
    <span class="token double-quoted-string string">"data"</span><span class="token punctuation">:</span><span
                class="token punctuation">[</span>
        <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">// Record...</span>
        <span class="token punctuation">}</span><span class="token punctuation">,</span>
        <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">// Record...</span>
        <span class="token punctuation">}</span>
    <span class="token punctuation">]</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h2 id="customizing-the-pagination-view"><a href="#customizing-the-pagination-view">Настройка представления разбивки на
        страницы</a></h2>
<p>По умолчанию представления, отображаемые для отображения ссылок на страницы, совместимы с фреймворком <a
            href="https://tailwindcss.com">Tailwind CSS</a>. Однако, если вы не используете Tailwind, вы можете
    определять свои собственные представления для отображения этих ссылок. При вызове <code>links</code> метода в
    экземпляре пагинатора вы можете передать имя представления в качестве первого аргумента метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token punctuation">{literal}{{/literal}</span><span
                class="token punctuation">{literal}{{/literal}</span> <span
                class="token variable">$paginator</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">links</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'view.name'</span><span
                class="token punctuation">)</span> <span class="token punctuation">}</span><span
                class="token punctuation">}</span>

<span class="token comment">// Passing additional data to the view...</span>
<span class="token punctuation">{literal}{{/literal}</span><span
                class="token punctuation">{literal}{{/literal}</span> <span
                class="token variable">$paginator</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">links</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'view.name'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'foo'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'bar'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span> <span
                class="token punctuation">}</span><span class="token punctuation">}</span></code></pre>
<p>Однако самый простой способ настроить представления разбивки на страницы - экспортировать их в свой <code>resources/views/vendor</code>
    каталог с помощью <code>vendor:publish</code> команды:</p>
<pre class=" language-php"><code class=" language-php">php artisan vendor<span class="token punctuation">:</span>publish <span
                class="token operator">--</span>tag<span class="token operator">=</span>laravel<span
                class="token operator">-</span>pagination</code></pre>
<p>Эта команда поместит представления в <code>resources/views/vendor/pagination</code> каталог вашего приложения. <code>tailwind.blade.php</code>
    Файл в этом каталоге соответствует виду по умолчанию постраничного. Вы можете редактировать этот файл, чтобы
    изменить HTML-код нумерации страниц.</p>
<p>Если вы хотите назначить другой файл в качестве представления разбивки на страницы по умолчанию, вы можете вызвать
    методы разбиения на страницы <code>defaultView</code> и <code>defaultSimpleView</code> внутри <code>boot</code>
    метода вашего <code>App\Providers\AppServiceProvider</code> класса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Providers</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Pagination<span
                        class="token punctuation">\</span>Paginator</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Blade</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>ServiceProvider</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">AppServiceProvider</span> <span
                    class="token keyword">extends</span> <span class="token class-name">ServiceProvider</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Bootstrap any application services.
    *
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">boot</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        Paginator<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">defaultView</span><span class="token punctuation">(</span><span
                    class="token single-quoted-string string">'view-name'</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>

        Paginator<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">defaultSimpleView</span><span class="token punctuation">(</span><span
                    class="token single-quoted-string string">'view-name'</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h3 id="using-bootstrap"><a href="#using-bootstrap">Использование Bootstrap</a></h3>
<p>Laravel включает представления с <a href="https://getbootstrap.com/">разбивкой на</a> страницы, построенные с
    использованием <a href="https://getbootstrap.com/">Bootstrap CSS</a>. Чтобы использовать эти представления вместо
    представлений Tailwind по умолчанию, вы можете вызвать метод разбиения на страницы <code>useBootstrap</code> в
    <code>boot</code> методе вашего <code>App\Providers\AppServiceProvider</code> класса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Pagination<span
                    class="token punctuation">\</span>Paginator</span><span class="token punctuation">;</span>

<span class="token comment">/**
 * Bootstrap any application services.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">boot</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    Paginator<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">useBootstrap</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h2 id="paginator-instance-methods"><a href="#paginator-instance-methods">Методы экземпляра пагинатора</a></h2>
<p>Каждый экземпляр разбиения на страницы предоставляет дополнительную информацию о разбиении на страницы с помощью
    следующих методов:</p>
<table>
    <thead>
    <tr>
        <th>Метод</th>
        <th>Описание</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td><code>$paginator-&gt;count()</code></td>
        <td>Получите количество элементов для текущей страницы.</td>
    </tr>
    <tr>
        <td><code>$paginator-&gt;currentPage()</code></td>
        <td>Получить номер текущей страницы.</td>
    </tr>
    <tr>
        <td><code>$paginator-&gt;firstItem()</code></td>
        <td>Получите номер результата первого элемента в результатах.</td>
    </tr>
    <tr>
        <td><code>$paginator-&gt;getOptions()</code></td>
        <td>Получите параметры пагинатора.</td>
    </tr>
    <tr>
        <td><code>$paginator-&gt;getUrlRange($start, $end)</code></td>
        <td>Создайте диапазон URL-адресов для пагинации.</td>
    </tr>
    <tr>
        <td><code>$paginator-&gt;hasPages()</code></td>
        <td>Определите, достаточно ли элементов для разделения на несколько страниц.</td>
    </tr>
    <tr>
        <td><code>$paginator-&gt;hasMorePages()</code></td>
        <td>Определите, есть ли еще элементы в хранилище данных.</td>
    </tr>
    <tr>
        <td><code>$paginator-&gt;items()</code></td>
        <td>Получить элементы для текущей страницы.</td>
    </tr>
    <tr>
        <td><code>$paginator-&gt;lastItem()</code></td>
        <td>Получить номер результата последнего элемента в результатах.</td>
    </tr>
    <tr>
        <td><code>$paginator-&gt;lastPage()</code></td>
        <td>Получите номер последней доступной страницы. (Недоступно при использовании <code>simplePaginate</code> ).
        </td>
    </tr>
    <tr>
        <td><code>$paginator-&gt;nextPageUrl()</code></td>
        <td>Получите URL-адрес следующей страницы.</td>
    </tr>
    <tr>
        <td><code>$paginator-&gt;onFirstPage()</code></td>
        <td>Определите, находится ли пагинатор на первой странице.</td>
    </tr>
    <tr>
        <td><code>$paginator-&gt;perPage()</code></td>
        <td>Количество элементов, отображаемых на странице.</td>
    </tr>
    <tr>
        <td><code>$paginator-&gt;previousPageUrl()</code></td>
        <td>Получите URL-адрес предыдущей страницы.</td>
    </tr>
    <tr>
        <td><code>$paginator-&gt;total()</code></td>
        <td>Определите общее количество совпадающих элементов в хранилище данных. (Недоступно при использовании <code>simplePaginate</code>
            ).
        </td>
    </tr>
    <tr>
        <td><code>$paginator-&gt;url($page)</code></td>
        <td>Получите URL-адрес для заданного номера страницы.</td>
    </tr>
    <tr>
        <td><code>$paginator-&gt;getPageName()</code></td>
        <td>Получите переменную строки запроса, используемую для хранения страницы.</td>
    </tr>
    <tr>
        <td><code>$paginator-&gt;setPageName($name)</code></td>
        <td>Установите переменную строки запроса, используемую для хранения страницы.</td>
    </tr>
    </tbody>
</table> 
