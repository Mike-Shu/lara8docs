<h1>HTTP-ответы</h1>
<ul>
    <li><a href="responses#creating-responses">Создание ответов</a>
        <ul>
            <li><a href="responses#attaching-headers-to-responses">Прикрепление заголовков к ответам</a></li>
            <li><a href="responses#attaching-cookies-to-responses">Прикрепление файлов cookie к ответам</a></li>
            <li><a href="responses#cookies-and-encryption">Файлы cookie и шифрование</a></li>
        </ul>
    </li>
    <li><a href="responses#redirects">Перенаправления</a>
        <ul>
            <li><a href="responses#redirecting-named-routes">Перенаправление на именованные маршруты</a></li>
            <li><a href="responses#redirecting-controller-actions">Перенаправление к действиям контроллера</a></li>
            <li><a href="responses#redirecting-external-domains">Перенаправление на внешние домены</a></li>
            <li><a href="responses#redirecting-with-flashed-session-data">Перенаправление с мигающими данными сеанса</a>
            </li>
        </ul>
    </li>
    <li><a href="responses#other-response-types">Другие типы ответов</a>
        <ul>
            <li><a href="responses#view-responses">Посмотреть ответы</a></li>
            <li><a href="responses#json-responses">Ответы JSON</a></li>
            <li><a href="responses#file-downloads">Загрузки файлов</a></li>
            <li><a href="responses#file-responses">Файловые ответы</a></li>
        </ul>
    </li>
    <li><a href="responses#response-macros">Макросы ответа</a></li>
</ul>
<p></p>
<h2 id="creating-responses"><a href="#creating-responses">Создание ответов</a></h2>
<p></p>
<h4 id="strings-arrays"><a href="#strings-arrays">Строки и массивы</a></h4>
<p>Все маршруты и контроллеры должны возвращать ответ, который будет отправлен обратно в браузер пользователя. Laravel
    предоставляет несколько разных способов вернуть ответы. Самый простой ответ - это возврат строки от маршрута или
    контроллера. Фреймворк автоматически преобразует строку в полный HTTP-ответ:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span
                class="token single-quoted-string string">'Hello World'</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Помимо возврата строк из ваших маршрутов и контроллеров, вы также можете возвращать массивы. Фреймворк автоматически
    преобразует массив в ответ JSON:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">2</span><span class="token punctuation">,</span> <span
                class="token number">3</span><span class="token punctuation">]</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Знаете ли вы, что вы также можете возвращать <a href="eloquent-collections">коллекции Eloquent</a> со своих
            маршрутов или контроллеров? Они будут автоматически преобразованы в JSON. Дать ему шанс!</p></p></div>
</blockquote>
<p></p>
<h4 id="response-objects"><a href="#response-objects">Объекты ответа</a></h4>
<p>Как правило, вы не просто будете возвращать простые строки или массивы из действий маршрута. Вместо этого вы вернете
    полные <code>Illuminate\Http\Response</code> экземпляры или <a href="views">представления</a>.</p>
<p>Возврат полного <code>Response</code> экземпляра позволяет настроить код состояния HTTP и заголовки ответа. A <code>Response</code> экземпляр
    наследует от <code>Symfony\Component\HttpFoundation\Response</code> класса, который обеспечивает различные методы для
    построения ответов HTTP:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/home'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token function">response</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'Hello World'</span><span
                class="token punctuation">,</span> <span class="token number">200</span><span class="token punctuation">)</span>
                  <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">header</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'Content-Type'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'text/plain'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="eloquent-models-and-collections"><a href="#eloquent-models-and-collections">Красноречивые модели и коллекции</a>
</h4>
<p>Вы также можете возвращать модели и коллекции <a href="eloquent">Eloquent ORM</a> прямо из ваших маршрутов и
    контроллеров. Когда вы это сделаете, Laravel автоматически преобразует модели и коллекции в ответы JSON, соблюдая <a
            href="eloquent-serialization#hiding-attributes-from-json">скрытые атрибуты</a> модели :</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/user/{literal}{user}{/literal}'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span>User <span
                class="token variable">$user</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$user</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="attaching-headers-to-responses"><a href="#attaching-headers-to-responses">Прикрепление заголовков к ответам</a>
</h3>
<p>Имейте в виду, что большинство методов ответа объединяются в цепочку, что позволяет плавно создавать экземпляры
    ответа. Например, вы можете использовать этот <code>header</code> метод, чтобы добавить серию заголовков к ответу
    перед его отправкой пользователю:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token function">response</span><span class="token punctuation">(</span><span
                class="token variable">$content</span><span class="token punctuation">)</span>
              <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">header</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'Content-Type'</span><span class="token punctuation">,</span> <span
                class="token variable">$type</span><span class="token punctuation">)</span>
              <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">header</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'X-Header-One'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Header Value'</span><span class="token punctuation">)</span>
              <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">header</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'X-Header-Two'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Header Value'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Или вы можете использовать этот <code>withHeaders</code> метод, чтобы указать массив заголовков, которые нужно
    добавить в ответ:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token function">response</span><span class="token punctuation">(</span><span
                class="token variable">$content</span><span class="token punctuation">)</span>
              <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">withHeaders</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
                    <span class="token single-quoted-string string">'Content-Type'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token variable">$type</span><span
                class="token punctuation">,</span>
                    <span class="token single-quoted-string string">'X-Header-One'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Header Value'</span><span class="token punctuation">,</span>
                    <span class="token single-quoted-string string">'X-Header-Two'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Header Value'</span><span class="token punctuation">,</span>
              <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="cache-control-middleware"><a href="#cache-control-middleware">ПО промежуточного слоя управления кешем</a></h4>
<p>Laravel включает <code>cache.headers</code> промежуточное ПО, которое можно использовать для быстрой установки <code>Cache-Control</code> заголовка
    для группы маршрутов. Если <code>etag</code> указано в списке директив, MD5-хэш содержимого ответа будет
    автоматически установлен как идентификатор ETag:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">middleware</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'cache.headers:public;max_age=2628000;etag'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">group</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/privacy'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//...</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
            
    Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/terms'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//...</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="attaching-cookies-to-responses"><a href="#attaching-cookies-to-responses">Прикрепление файлов cookie к
        ответам</a></h3>
<p>Вы можете прикрепить cookie к исходящему <code>Illuminate\Http\Response</code> экземпляру, используя этот
    <code>cookie</code> метод. Вы должны передать этому методу имя, значение и количество минут, в течение которых файл
    cookie должен считаться действительным:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token function">response</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Hello World'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">cookie</span><span
                class="token punctuation">(</span>
    <span class="token single-quoted-string string">'name'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'value'</span><span class="token punctuation">,</span> <span
                class="token variable">$minutes</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p><code>cookie</code> Метод также принимает несколько аргументов больше, которые используются реже. Как правило, эти
    аргументы имеют то же назначение и значение, что и аргументы, передаваемые встроенному в <a
            href="https://secure.php.net/manual/en/function.setcookie.php">PHP</a> методу <a
            href="https://secure.php.net/manual/en/function.setcookie.php">setcookie</a> :</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token function">response</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Hello World'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">cookie</span><span
                class="token punctuation">(</span>
    <span class="token single-quoted-string string">'name'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'value'</span><span class="token punctuation">,</span> <span
                class="token variable">$minutes</span><span class="token punctuation">,</span> <span
                class="token variable">$path</span><span class="token punctuation">,</span> <span
                class="token variable">$domain</span><span class="token punctuation">,</span> <span
                class="token variable">$secure</span><span class="token punctuation">,</span> <span
                class="token variable">$httpOnly</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если вы хотите убедиться, что cookie отправляется с исходящим ответом, но у вас еще нет экземпляра этого ответа, вы
    можете использовать <code>Cookie</code> фасад для «постановки в очередь» файлов cookie для прикрепления к ответу при
    его отправке. <code>queue</code> Метод принимает аргументы, необходимые для создания экземпляра печенья. Эти файлы
    cookie будут прикреплены к исходящему ответу перед его отправкой в браузер:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Cookie</span><span
                class="token punctuation">;</span>

Cookie<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">queue</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'name'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'value'</span><span class="token punctuation">,</span> <span
                class="token variable">$minutes</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="generating-cookie-instances"><a href="#generating-cookie-instances">Создание экземпляров файлов cookie</a></h4>
<p>Если вы хотите создать <code>Symfony\Component\HttpFoundation\Cookie</code> экземпляр, который можно будет
    присоединить к экземпляру ответа позже, вы можете использовать глобальный <code>cookie</code> помощник. Этот файл
    cookie не будет отправлен обратно клиенту, если он не прикреплен к экземпляру ответа:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$cookie</span> <span
                class="token operator">=</span> <span class="token function">cookie</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'value'</span><span
                class="token punctuation">,</span> <span class="token variable">$minutes</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">return</span> <span class="token function">response</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'Hello World'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">cookie</span><span
                class="token punctuation">(</span><span class="token variable">$cookie</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="expiring-cookies-early"><a href="#expiring-cookies-early">Устаревшие файлы cookie</a></h4>
<p>Вы можете удалить файл cookie, истек его срок действия с помощью <code>withoutCookie</code> метода исходящего ответа:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token function">response</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Hello World'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">withoutCookie</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если у вас еще нет экземпляра исходящего ответа, вы можете использовать метод <code>Cookie</code> фасада
    <code>queue</code> для истечения срока действия cookie:</p>
<pre class=" language-php"><code class=" language-php">Cookie<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">queue</span><span
                class="token punctuation">(</span>Cookie<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">forget</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="cookies-and-encryption"><a href="#cookies-and-encryption">Файлы cookie и шифрование</a></h3>
<p>По умолчанию все файлы cookie, сгенерированные Laravel, зашифрованы и подписаны, поэтому клиент не может их изменить
    или прочитать. Если вы хотите отключить шифрование для подмножества файлов cookie, сгенерированных вашим
    приложением, вы можете использовать <code>$except</code> свойство <code>App\Http\Middleware\EncryptCookies</code> промежуточного
    программного обеспечения, которое находится в <code>app/Http/Middleware</code> каталоге:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * The names of the cookies that should not be encrypted.
 *
 * @var array
 */</span>
<span class="token keyword">protected</span> <span class="token variable">$except</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'cookie_name'</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="redirects"><a href="#redirects">Перенаправления</a></h2>
<p>Ответы на перенаправление являются экземплярами <code>Illuminate\Http\RedirectResponse</code> класса и содержат
    правильные заголовки, необходимые для перенаправления пользователя на другой URL-адрес. Есть несколько способов
    создать <code>RedirectResponse</code> экземпляр. Самый простой способ - использовать глобальный <code>redirect</code> помощник:
</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'/dashboard'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token function">redirect</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'home/dashboard'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Иногда вы можете захотеть перенаправить пользователя в его предыдущее местоположение, например, когда отправленная
    форма недействительна. Вы можете сделать это с помощью глобальной <code>back</code> вспомогательной функции.
    Поскольку эта функция использует <a href="session">сеанс</a>, убедитесь, что маршрут, вызывающий <code>back</code> функцию,
    использует группу <code>web</code> промежуточного программного обеспечения:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">post</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/user/profile'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// Validate the request...</span>
            
    <span class="token keyword">return</span> <span class="token function">back</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">withInput</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="redirecting-named-routes"><a href="#redirecting-named-routes">Перенаправление на именованные маршруты</a></h3>
<p>Когда вы вызываете <code>redirect</code> помощник без параметров, <code>Illuminate\Routing\Redirector</code> возвращается
    экземпляр, позволяющий вызывать любой метод <code>Redirector</code> экземпляра. Например, чтобы сгенерировать <code>RedirectResponse</code> именованный
    маршрут, вы можете использовать <code>route</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token function">redirect</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">route</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'login'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если ваш маршрут имеет параметры, вы можете передать их в качестве второго аргумента <code>route</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">// For a route with the following URI: /profile/{literal}{id}{/literal}</span>

<span class="token keyword">return</span> <span class="token function">redirect</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">route</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'profile'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">1</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="populating-parameters-via-eloquent-models"><a href="#populating-parameters-via-eloquent-models">Заполнение
        параметров с помощью красноречивых моделей</a></h4>
<p>Если вы перенаправляете на маршрут с параметром «ID», который заполняется из модели Eloquent, вы можете передать саму
    модель. ID будет извлечен автоматически:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">// For a route with the following URI: /profile/{literal}{id}{/literal}</span>

<span class="token keyword">return</span> <span class="token function">redirect</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">route</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'profile'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span class="token variable">$user</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Если вы хотите настроить значение, которое помещается в параметр маршрута, вы можете указать столбец в определении
    параметра маршрута ( <code>/profile/{literal}{id:slug}{/literal}</code> ) или переопределить <code>getRouteKey</code> метод в своей
    модели Eloquent:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the value of the model's route key.
 *
 * @return mixed
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">getRouteKey</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">slug</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="redirecting-controller-actions"><a href="#redirecting-controller-actions">Перенаправление к действиям
        контроллера</a></h3>
<p>Вы также можете создавать перенаправления на <a href="controllers">действия контроллера</a>. Для этого передайте в
    <code>action</code> метод имя контроллера и действия :</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>UserController</span><span
                class="token punctuation">;</span>

<span class="token keyword">return</span> <span class="token function">redirect</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">action</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>UserController<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'index'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Если вашему маршруту контроллера требуются параметры, вы можете передать их в качестве второго аргумента
    <code>action</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token function">redirect</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">action</span><span
                class="token punctuation">(</span>
    <span class="token punctuation">[</span>UserController<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'profile'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span><span class="token single-quoted-string string">'id'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">1</span><span class="token punctuation">]</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="redirecting-external-domains"><a href="#redirecting-external-domains">Перенаправление на внешние домены</a></h3>
<p>Иногда вам может потребоваться перенаправление на домен за пределами вашего приложения. Вы можете сделать это, вызвав
    <code>away</code> метод, который создает <code>RedirectResponse</code> без какой-либо дополнительной кодировки,
    проверки или проверки URL:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token function">redirect</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">away</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'https://www.google.com'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="redirecting-with-flashed-session-data"><a href="#redirecting-with-flashed-session-data">Перенаправление с
        мигающими данными сеанса</a></h3>
<p>Перенаправление на новый URL-адрес и <a href="session#flash-data">перенос данных в сеанс</a> обычно выполняются
    одновременно. Обычно это делается после успешного выполнения действия, когда вы отправляете сообщение об успешном
    завершении сеанса. Для удобства вы можете создать <code>RedirectResponse</code> экземпляр и передать данные сеанса в
    единую цепочку методов:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">post</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/user/profile'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//...</span>
            
    <span class="token keyword">return</span> <span class="token function">redirect</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'dashboard'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">with</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'status'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Profile updated!'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>После перенаправления пользователя вы можете отобразить мигающее сообщение из <a href="session">сеанса</a>.
    Например, используя <a href="blade">синтаксис Blade</a> :</p>
<pre class=" language-php"><code class=" language-php">@<span class="token keyword">if</span> <span
                class="token punctuation">(</span><span class="token function">session</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'status'</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span>
    <span class="token operator">&lt;</span>div <span class="token keyword">class</span><span
                class="token operator">=</span><span
                class="token double-quoted-string string">"alert alert-success"</span><span
                class="token operator">&gt;</span>
        <span class="token punctuation">{literal}{{/literal}</span><span
                class="token punctuation">{literal}{{/literal}</span> <span class="token function">session</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'status'</span><span
                class="token punctuation">)</span> <span class="token punctuation">}</span><span
                class="token punctuation">}</span>
    <span class="token operator">&lt;</span><span class="token operator">/</span>div<span
                class="token operator">&gt;</span>
@<span class="token keyword">endif</span></code></pre>
<p></p>
<h4 id="redirecting-with-input"><a href="#redirecting-with-input">Перенаправление с вводом</a></h4>
<p>Вы можете использовать <code>withInput</code> метод, предоставленный <code>RedirectResponse</code> экземпляром, для
    передачи входных данных текущего запроса в сеанс перед перенаправлением пользователя в новое место. Обычно это
    делается, если пользователь обнаружил ошибку проверки. После того, как ввод был записан в сеанс, вы можете легко <a
            href="requests#retrieving-old-input">получить его</a> во время следующего запроса, чтобы повторно заполнить
    форму:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token function">back</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">withInput</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="other-response-types"><a href="#other-response-types">Другие типы ответов</a></h2>
<p><code>response</code> Помощник может быть использован для создания других типов экземпляров ответа. Когда <code>response</code> помощник
    вызывается без аргументов, возвращается реализация <code>Illuminate\Contracts\Routing\ResponseFactory</code>  <a
            href="contracts">контракта</a>. Этот контракт предоставляет несколько полезных методов для генерации
    ответов.</p>
<p></p>
<h3 id="view-responses"><a href="#view-responses">Посмотреть ответы</a></h3>
<p>Если вам нужен контроль над статусом и заголовками ответа, но также необходимо вернуть <a
            href="views">представление</a> в качестве содержимого ответа, вы должны использовать <code>view</code> метод:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token function">response</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
              <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">view</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'hello'</span><span
                class="token punctuation">,</span> <span class="token variable">$data</span><span
                class="token punctuation">,</span> <span class="token number">200</span><span class="token punctuation">)</span>
              <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">header</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'Content-Type'</span><span class="token punctuation">,</span> <span
                class="token variable">$type</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Конечно, если вам не нужно передавать настраиваемый код состояния HTTP или настраиваемые заголовки, вы можете
    использовать глобальную <code>view</code> вспомогательную функцию.</p>
<p></p>
<h3 id="json-responses"><a href="#json-responses">Ответы JSON</a></h3>
<p><code>json</code> Метод автоматически устанавливает <code>Content-Type</code> заголовок <code>application/json</code>,
    а также преобразовать данный массив JSON с помощью <code>json_encode</code> функции PHP:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token function">response</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">json</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Abigail'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'state'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'CA'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если вы хотите создать ответ JSONP, вы можете использовать этот <code>json</code> метод в сочетании с <code>withCallback</code> методом:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token function">response</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
              <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">json</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Abigail'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'state'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'CA'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span>
              <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">withCallback</span><span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">input</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'callback'</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="file-downloads"><a href="#file-downloads">Загрузки файлов</a></h3>
<p><code>download</code> Метод может быть использован для создания ответа, что браузер заставляет пользователя, чтобы
    загрузить файл на данном пути. <code>download</code> Метод принимает имя файла в качестве второго аргумента метода,
    который будет определять имя файла, видимый пользователем загрузку файла. Наконец, вы можете передать массив
    заголовков HTTP в качестве третьего аргумента метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token function">response</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">download</span><span
                class="token punctuation">(</span><span class="token variable">$pathToFile</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">return</span> <span class="token function">response</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">download</span><span
                class="token punctuation">(</span><span class="token variable">$pathToFile</span><span
                class="token punctuation">,</span> <span class="token variable">$name</span><span
                class="token punctuation">,</span> <span class="token variable">$headers</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p> Symfony HttpFoundation, который управляет загрузкой файлов, требует, чтобы загружаемый файл имел имя файла
            ASCII.</p></p></div>
</blockquote>
<p></p>
<h4 id="streamed-downloads"><a href="#streamed-downloads">Потоковые загрузки</a></h4>
<p>Иногда вы можете захотеть превратить строковый ответ данной операции в загружаемый ответ без необходимости записывать
    содержимое операции на диск. Вы можете использовать этот <code>streamDownload</code> метод в этом сценарии. Этот
    метод принимает в качестве аргументов обратный вызов, имя файла и необязательный массив заголовков:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Services<span
                    class="token punctuation">\</span>GitHub</span><span class="token punctuation">;</span>

<span class="token keyword">return</span> <span class="token function">response</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">streamDownload</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">echo</span> GitHub<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">api</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'repo'</span><span
                class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">contents</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">readme</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'laravel'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'laravel'</span><span
                class="token punctuation">)</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'contents'</span><span class="token punctuation">]</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'laravel-readme.md'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="file-responses"><a href="#file-responses">Файловые ответы</a></h3>
<p>Этот <code>file</code> метод может использоваться для отображения файла, такого как изображение или PDF-файл,
    непосредственно в браузере пользователя вместо того, чтобы инициировать загрузку. Этот метод принимает путь к файлу
    в качестве первого аргумента и массив заголовков в качестве второго аргумента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token function">response</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">file</span><span
                class="token punctuation">(</span><span class="token variable">$pathToFile</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">return</span> <span class="token function">response</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">file</span><span class="token punctuation">(</span><span class="token variable">$pathToFile</span><span
                class="token punctuation">,</span> <span class="token variable">$headers</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="response-macros"><a href="#response-macros">Макросы ответа</a></h2>123456
<p>Если вы хотите определить настраиваемый ответ, который можно повторно использовать в различных маршрутах и
    
    контроллерах, вы можете использовать <code>macro</code> метод <code>Response</code> фасада. Как правило, вы должны
    вызывать этот метод из <code>boot</code> метода одного из <a href="providers">провайдеров</a> вашего приложения,
    например <code>App\Providers\AppServiceProvider</code> поставщика услуг:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Providers</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Response</span><span
                    class="token punctuation">;</span>
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
        Response<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">macro</span><span class="token punctuation">(</span><span
                    class="token single-quoted-string string">'caps'</span><span
                    class="token punctuation">,</span> <span class="token keyword">function</span> <span
                    class="token punctuation">(</span><span class="token variable">$value</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> Response<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token function">make</span><span
                    class="token punctuation">(</span><span class="token function">strtoupper</span><span
                    class="token punctuation">(</span><span class="token variable">$value</span><span
                    class="token punctuation">)</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p><code>macro</code> Функция принимает имя в качестве первого аргумента и закрытия в качестве второго аргумента.
    Замыкание макроса будет выполнено при вызове имени макроса из <code>ResponseFactory</code> реализации или <code>response</code> помощника:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token function">response</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">caps</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'foo'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
