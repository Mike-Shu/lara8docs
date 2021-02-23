<h1>HTTP-клиент <sup>HTTP-client</sup></h1>
<ul>
    <li><a href="http-client#introduction">Вступление <sup>Introduction</sup></a></li>
    <li><a href="http-client#making-requests">Делать запросы <sup>Making requests</sup></a>
        <ul>
            <li><a href="http-client#request-data">Данные запроса <sup>Request data</sup></a></li>
            <li><a href="http-client#headers">Заголовки <sup>Headers</sup></a></li>
            <li><a href="http-client#authentication">Аутентификация <sup>Authentication</sup></a></li>
            <li><a href="http-client#timeout">Тайм-аут <sup>Timeout</sup></a></li>
            <li><a href="http-client#retries">Повторные попытки <sup>Retries</sup></a></li>
            <li><a href="http-client#error-handling">Обработка ошибок <sup>Error handling</sup></a></li>
            <li><a href="http-client#guzzle-options">Опции Guzzle <sup>Guzzle options</sup></a></li>
        </ul>
    </li>
    <li><a href="http-client#testing">Тестирование <sup>Testing</sup></a>
        <ul>
            <li><a href="http-client#faking-responses">Поддельные ответы <sup>Faking responses</sup></a></li>
            <li><a href="http-client#inspecting-requests">Проверка запросов <sup>Inspecting requests</sup></a></li>
        </ul>
    </li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление <sup>Introduction</sup></a></h2>
<p>Laravel предоставляет выразительный минимальный API- <a href="http://docs.guzzlephp.org/en/stable/">интерфейс для
        HTTP-клиента Guzzle</a>, позволяющий быстро выполнять исходящие HTTP-запросы для связи с другими
    веб-приложениями. Обертка Laravel вокруг Guzzle сосредоточена на наиболее распространенных вариантах использования и
    дает прекрасные возможности для разработчиков.</p>
<p>Прежде чем начать, вы должны убедиться, что вы установили пакет Guzzle как зависимость вашего приложения. По
    умолчанию Laravel автоматически включает эту зависимость. Однако, если вы ранее удалили пакет, вы можете установить
    его снова через Composer:</p>
<pre class=" language-php"><code class=" language-php">composer <span
                class="token keyword">require</span> guzzlehttp<span class="token operator">/</span>guzzle</code></pre>
<p></p>
<h2 id="making-requests"><a href="#making-requests">Делать запросы <sup>Making requests</sup></a></h2>
<p>Для выполнения запросов, вы можете использовать <code>get</code>, <code>post</code>, <code>put</code>,
    <code>patch</code> и <code>delete</code> методы, предоставляемые <code>Http</code> фасадом. Во-первых, давайте
    посмотрим, как сделать базовый <code>GET</code> запрос на другой URL:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Http</span><span
                class="token punctuation">;</span>

<span class="token variable">$response</span> <span class="token operator">=</span> Http<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'http://example.com'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p><code>get</code> Метод возвращает экземпляр <code>Illuminate\Http\Client\Response</code>, который обеспечивает
    различные методы, которые могут быть использованы для проверки ответа:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">body</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span> <span class="token punctuation">:</span> string<span
                class="token punctuation">;</span>
<span class="token variable">$response</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">json</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">:</span> <span class="token keyword">array</span><span class="token operator">|</span>mixed<span
                class="token punctuation">;</span>
<span class="token variable">$response</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">status</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">:</span> int<span class="token punctuation">;</span>
<span class="token variable">$response</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">ok</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span> <span class="token punctuation">:</span> bool<span
                class="token punctuation">;</span>
<span class="token variable">$response</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">successful</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">:</span> bool<span class="token punctuation">;</span>
<span class="token variable">$response</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">failed</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">:</span> bool<span class="token punctuation">;</span>
<span class="token variable">$response</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">serverError</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">:</span> bool<span class="token punctuation">;</span>
<span class="token variable">$response</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">clientError</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">:</span> bool<span class="token punctuation">;</span>
<span class="token variable">$response</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">header</span><span
                class="token punctuation">(</span><span class="token variable">$header</span><span
                class="token punctuation">)</span> <span class="token punctuation">:</span> string<span
                class="token punctuation">;</span>
<span class="token variable">$response</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">headers</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">:</span> <span class="token keyword">array</span><span
                class="token punctuation">;</span></code></pre>
<p><code>Illuminate\Http\Client\Response</code> Объект также реализует PHP <code>ArrayAccess</code> интерфейс,
    позволяющий вам ответные данные JSON доступа непосредственно на ответ:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> Http<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'http://example.com/users/1'</span><span
                class="token punctuation">)</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'name'</span><span class="token punctuation">]</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="request-data"><a href="#request-data">Данные запроса <sup>Request data</sup></a></h3>
<p>Конечно, это часто, когда делают <code>POST</code>, <code>PUT</code> и <code>PATCH</code> прошу прислать
    дополнительные данные с вашим запросом, поэтому эти методы принимают массив данных в качестве второго аргумента. По
    умолчанию данные будут отправляться с использованием <code>application/json</code> типа контента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Http</span><span
                class="token punctuation">;</span>

<span class="token variable">$response</span> <span class="token operator">=</span> Http<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">post</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'http://example.com/users'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Steve'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'role'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Network Administrator'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="get-request-query-parameters"><a href="#get-request-query-parameters">Параметры запроса GET-запроса</a></h4>
<p>При выполнении <code>GET</code> запросов вы можете либо добавить строку запроса непосредственно к URL-адресу, либо
    передать массив пар ключ / значение в качестве второго аргумента <code>get</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span> <span
                class="token operator">=</span> Http<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'http://example.com/users'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Taylor'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'page'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">1</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="sending-form-url-encoded-requests"><a href="#sending-form-url-encoded-requests">Отправка запросов с
        закодированными URL-адресами</a></h4>
<p>Если вы хотите отправлять данные с использованием <code>application/x-www-form-urlencoded</code> типа контента, вы
    должны вызвать <code>asForm</code> метод перед отправкой запроса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span> <span
                class="token operator">=</span> Http<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">asForm</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">post</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'http://example.com/users'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Sara'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'role'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Privacy Consultant'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="sending-a-raw-request-body"><a href="#sending-a-raw-request-body">Отправка необработанного тела запроса</a></h4>
<p>Вы можете использовать этот <code>withBody</code> метод, если хотите предоставить необработанное тело запроса при
    отправке запроса. Тип контента может быть предоставлен через второй аргумент метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span> <span
                class="token operator">=</span> Http<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">withBody</span><span
                class="token punctuation">(</span>
    <span class="token function">base64_encode</span><span class="token punctuation">(</span><span
                class="token variable">$photo</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'image/jpeg'</span>
<span class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">post</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'http://example.com/photo'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="multi-part-requests"><a href="#multi-part-requests">Многостраничные запросы</a></h4>
<p>Если вы хотите отправлять файлы в виде запросов, состоящих из нескольких частей, вы должны вызвать
    <code>attach</code> метод перед отправкой запроса. Этот метод принимает имя файла и его содержимое. При
    необходимости вы можете указать третий аргумент, который будет считаться именем файла:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span> <span
                class="token operator">=</span> Http<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">attach</span><span
                class="token punctuation">(</span>
    <span class="token single-quoted-string string">'attachment'</span><span class="token punctuation">,</span> <span
                class="token function">file_get_contents</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'photo.jpg'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'photo.jpg'</span>
<span class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">post</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'http://example.com/attachments'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вместо передачи необработанного содержимого файла вы можете передать ресурс потока:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$photo</span> <span
                class="token operator">=</span> <span class="token function">fopen</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'photo.jpg'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'r'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$response</span> <span class="token operator">=</span> Http<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">attach</span><span
                class="token punctuation">(</span>
    <span class="token single-quoted-string string">'attachment'</span><span class="token punctuation">,</span> <span
                class="token variable">$photo</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'photo.jpg'</span>
<span class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">post</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'http://example.com/attachments'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="headers"><a href="#headers">Заголовки <sup>Headers</sup></a></h3>
<p>Заголовки могут быть добавлены к запросам с помощью <code>withHeaders</code> метода. Этот <code>withHeaders</code>
    метод принимает массив пар ключ / значение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span> <span
                class="token operator">=</span> Http<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">withHeaders</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'X-First'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'foo'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'X-Second'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'bar'</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">post</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'http://example.com/users'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Taylor'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="authentication"><a href="#authentication">Аутентификация <sup>Authentication</sup></a></h3>
<p>Вы можете указать основные и переваривать учетные данные аутентификации, используя <code>withBasicAuth</code> и
    <code>withDigestAuth</code> методы, соответственно:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">// Basic authentication...</span>
<span class="token variable">$response</span> <span class="token operator">=</span> Http<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">withBasicAuth</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'taylor@laravel.com'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'secret'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">post</span><span
                class="token punctuation">(</span><span class="token punctuation">.</span><span
                class="token punctuation">.</span><span class="token punctuation">.</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// Digest authentication...</span>
<span class="token variable">$response</span> <span class="token operator">=</span> Http<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">withDigestAuth</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'taylor@laravel.com'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'secret'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">post</span><span
                class="token punctuation">(</span><span class="token punctuation">.</span><span
                class="token punctuation">.</span><span class="token punctuation">.</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="bearer-tokens"><a href="#bearer-tokens">Жетоны на предъявителя</a></h4>
<p>Если вы хотите быстро добавить токен-носитель в <code>Authorization</code> заголовок запроса, вы можете использовать
    <code>withToken</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span> <span
                class="token operator">=</span> Http<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">withToken</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'token'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">post</span><span
                class="token punctuation">(</span><span class="token punctuation">.</span><span
                class="token punctuation">.</span><span class="token punctuation">.</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="timeout"><a href="#timeout">Тайм-аут <sup>Timeout</sup></a></h3>
<p><code>timeout</code> Метод может быть использован, чтобы указать максимальное количество секунд, чтобы ждать ответа:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span> <span
                class="token operator">=</span> Http<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">timeout</span><span
                class="token punctuation">(</span><span class="token number">3</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token punctuation">.</span><span
                class="token punctuation">.</span><span class="token punctuation">.</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если заданный тайм-аут превышен, <code>Illuminate\Http\Client\ConnectionException</code> будет брошен экземпляр.</p>
<p></p>
<h3 id="retries"><a href="#retries">Повторные попытки <sup>Retries</sup></a></h3>
<p>Если вы хотите, чтобы HTTP-клиент автоматически повторял запрос при возникновении ошибки клиента или сервера, вы
    можете использовать этот <code>retry</code> метод. <code>retry</code> Метод принимает два аргумента: максимальное
    количество раз, запрос должен быть покушениями и количество миллисекунд, Laravel должна ждать между попытками:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span> <span
                class="token operator">=</span> Http<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">retry</span><span
                class="token punctuation">(</span><span class="token number">3</span><span
                class="token punctuation">,</span> <span class="token number">100</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">post</span><span class="token punctuation">(</span><span
                class="token punctuation">.</span><span class="token punctuation">.</span><span
                class="token punctuation">.</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Если все запросы терпят неудачу, <code>Illuminate\Http\Client\RequestException</code> будет брошен экземпляр.</p>
<p></p>
<h3 id="error-handling"><a href="#error-handling">Обработка ошибок <sup>Error handling</sup></a></h3>
<p>В отличие от поведения Guzzle по умолчанию, клиентская оболочка HTTP Laravel не генерирует исключения при ошибках
    клиента или сервера ( <code>400</code> и <code>500</code> выравнивает ответы серверов). Вы можете определить, если
    одна из этих ошибок был возвращен с помощью <code>successful</code>, <code>clientError</code> или
    <code>serverError</code> методы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">// Determine if the status code is &gt;= 200 and &lt; 300...</span>
<span class="token variable">$response</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">successful</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// Determine if the status code is &gt;= 400...</span>
<span class="token variable">$response</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">failed</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// Determine if the response has a 400 level status code...</span>
<span class="token variable">$response</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">clientError</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// Determine if the response has a 500 level status code...</span>
<span class="token variable">$response</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">serverError</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="throwing-exceptions"><a href="#throwing-exceptions">Выбрасывание исключений</a></h4>
<p>Если у вас есть экземпляр ответа и вы хотите сгенерировать экземпляр,
    <code>Illuminate\Http\Client\RequestException</code> если код состояния ответа указывает на ошибку клиента или
    сервера, вы можете использовать <code>throw</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span> <span
                class="token operator">=</span> Http<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">post</span><span
                class="token punctuation">(</span><span class="token punctuation">.</span><span
                class="token punctuation">.</span><span class="token punctuation">.</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// Throw an exception if a client or server error occurred...</span>
<span class="token variable">$response</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token keyword">throw</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token keyword">return</span> <span class="token variable">$response</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'user'</span><span
                class="token punctuation">]</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'id'</span><span class="token punctuation">]</span><span
                class="token punctuation">;</span></code></pre>
<p>У <code>Illuminate\Http\Client\RequestException</code> экземпляра есть общедоступное <code>$response</code> свойство,
    которое позволит вам проверить возвращенный ответ.</p>
<p><code>throw</code> Метод возвращает экземпляр ответа, если ошибки не произошло, что позволяет цепи других операций на
    <code>throw</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> Http<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">post</span><span
                class="token punctuation">(</span><span class="token punctuation">.</span><span
                class="token punctuation">.</span><span class="token punctuation">.</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token keyword">throw</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">json</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если вы хотите выполнить некоторую дополнительную логику до того, как будет сгенерировано исключение, вы можете
    передать закрытие <code>throw</code> метода. Исключение будет сгенерировано автоматически после вызова закрытия,
    поэтому вам не нужно повторно генерировать исключение изнутри закрытия:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> Http<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">post</span><span
                class="token punctuation">(</span><span class="token punctuation">.</span><span
                class="token punctuation">.</span><span class="token punctuation">.</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token keyword">throw</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$response</span><span
                class="token punctuation">,</span> <span class="token variable">$e</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">json</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="guzzle-options"><a href="#guzzle-options">Опции Guzzle <sup>Guzzle options</sup></a></h3>
<p>Вы можете указать дополнительные <a href="http://docs.guzzlephp.org/en/stable/request-options.html">параметры запроса
        Guzzle</a> с помощью <code>withOptions</code> метода. <code>withOptions</code> Метод принимает массив пар ключ /
    значение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$response</span> <span
                class="token operator">=</span> Http<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">withOptions</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'debug'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token boolean constant">true</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'http://example.com/users'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="testing"><a href="#testing">Тестирование <sup>Testing</sup></a></h2>
<p>Многие сервисы Laravel предоставляют функциональные возможности, которые помогут вам легко и выразительно писать
    тесты, и HTTP-оболочка Laravel не является исключением. Метод <code>Http</code> фасада <code>fake</code> позволяет
    указать HTTP-клиенту возвращать заглушенные / фиктивные ответы при выполнении запросов.</p>
<p></p>
<h3 id="faking-responses"><a href="#faking-responses">Поддельные ответы <sup>Faking responses</sup></a></h3>
<p>Например, чтобы указать HTTP-клиенту возвращать пустые <code>200</code> ответы с кодом состояния для каждого запроса,
    вы можете вызвать <code>fake</code> метод без аргументов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Http</span><span
                class="token punctuation">;</span>

Http<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">fake</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$response</span> <span class="token operator">=</span> Http<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">post</span><span
                class="token punctuation">(</span><span class="token punctuation">.</span><span
                class="token punctuation">.</span><span class="token punctuation">.</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>При подделке запросов промежуточное ПО HTTP-клиента не выполняется. Вы должны определить ожидания для ложных
            ответов, как если бы это промежуточное программное обеспечение работало правильно.</p></p></div>
</blockquote>
<p></p>
<h4 id="faking-specific-urls"><a href="#faking-specific-urls">Подделка определенных URL-адресов</a></h4>
<p>В качестве альтернативы вы можете передать в <code>fake</code> метод массив. Ключи массива должны представлять
    шаблоны URL, которые вы хотите подделать, и связанные с ними ответы. Этот <code>*</code> символ может использоваться
    как подстановочный знак. Любые запросы к URL-адресам, которые не были подделаны, будут фактически выполнены. Вы
    можете использовать метод <code>Http</code> фасада <code>response</code> для создания тупиковых / фальшивых ответов
    для этих конечных точек:</p>
<pre class=" language-php"><code class=" language-php">Http<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">fake</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token comment">// Stub a JSON response for GitHub endpoints...</span>
    <span class="token single-quoted-string string">'github.com/*'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> Http<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">response</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'foo'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'bar'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span> <span class="token number">200</span><span
                class="token punctuation">,</span> <span class="token variable">$headers</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>

    <span class="token comment">// Stub a string response for Google endpoints...</span>
    <span class="token single-quoted-string string">'google.com/*'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> Http<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">response</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'Hello World'</span><span
                class="token punctuation">,</span> <span class="token number">200</span><span class="token punctuation">,</span> <span
                class="token variable">$headers</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если вы хотите указать шаблон резервного URL-адреса, который заглушит все несовпадающие URL-адреса, вы можете
    использовать один <code>*</code> символ:</p>
<pre class=" language-php"><code class=" language-php">Http<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">fake</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token comment">// Stub a JSON response for GitHub endpoints...</span>
    <span class="token single-quoted-string string">'github.com/*'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> Http<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">response</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'foo'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'bar'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span> <span class="token number">200</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'Headers'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>

    <span class="token comment">// Stub a string response for all other endpoints...</span>
    <span class="token single-quoted-string string">'*'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> Http<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">response</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'Hello World'</span><span
                class="token punctuation">,</span> <span class="token number">200</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span><span class="token single-quoted-string string">'Headers'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="faking-response-sequences"><a href="#faking-response-sequences">Поддельные последовательности ответов</a></h4>
<p>Иногда вам может потребоваться указать, что один URL-адрес должен возвращать серию поддельных ответов в определенном
    порядке. Вы можете сделать это, используя <code>Http::sequence</code> метод построения ответов:</p>
<pre class=" language-php"><code class=" language-php">Http<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">fake</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token comment">// Stub a series of responses for GitHub endpoints...</span>
    <span class="token single-quoted-string string">'github.com/*'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> Http<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">sequence</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
                            <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">push</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Hello World'</span><span
                class="token punctuation">,</span> <span class="token number">200</span><span class="token punctuation">)</span>
                            <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">push</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'foo'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'bar'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span> <span class="token number">200</span><span class="token punctuation">)</span>
                            <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">pushStatus</span><span class="token punctuation">(</span><span
                class="token number">404</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Когда все ответы в последовательности ответов будут использованы, любые дальнейшие запросы приведут к тому, что
    последовательность ответов вызовет исключение. Если вы хотите указать ответ по умолчанию, который должен
    возвращаться, когда последовательность пуста, вы можете использовать <code>whenEmpty</code> метод:</p>
<pre class=" language-php"><code class=" language-php">Http<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">fake</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token comment">// Stub a series of responses for GitHub endpoints...</span>
    <span class="token single-quoted-string string">'github.com/*'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> Http<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">sequence</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
                            <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">push</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Hello World'</span><span
                class="token punctuation">,</span> <span class="token number">200</span><span class="token punctuation">)</span>
                            <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">push</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'foo'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'bar'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span> <span class="token number">200</span><span class="token punctuation">)</span>
                            <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">whenEmpty</span><span class="token punctuation">(</span>Http<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">response</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если вы хотите подделать последовательность ответов, но вам не нужно указывать конкретный шаблон URL, который следует
    подделать, вы можете использовать <code>Http::fakeSequence</code> метод:</p>
<pre class=" language-php"><code class=" language-php">Http<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">fakeSequence</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">push</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Hello World'</span><span
                class="token punctuation">,</span> <span class="token number">200</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">whenEmpty</span><span
                class="token punctuation">(</span>Http<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">response</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="fake-callback"><a href="#fake-callback">Поддельный обратный звонок</a></h4>
<p>Если вам требуется более сложная логика для определения, какие ответы возвращать для определенных конечных точек, вы
    можете передать закрытие <code>fake</code> метода. Это закрытие получит экземпляр <code>Illuminate\Http\Client\Request</code>
    и должно вернуть экземпляр ответа. При закрытии вы можете выполнить любую логику, необходимую для определения типа
    ответа, который нужно вернуть:</p>
<pre class=" language-php"><code class=" language-php">Http<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">fake</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> Http<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">response</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'Hello World'</span><span class="token punctuation">,</span> <span class="token number">200</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="inspecting-requests"><a href="#inspecting-requests">Проверка запросов <sup>Inspecting requests</sup></a></h3>
<p>При подделке ответов вы можете иногда захотеть проверить запросы, которые получает клиент, чтобы убедиться, что ваше
    приложение отправляет правильные данные или заголовки. Вы можете сделать это, вызвав <code>Http::assertSent</code>
    метод после вызова <code>Http::fake</code>.</p>
<p><code>assertSent</code> Метод принимает замыкание, которое получит <code>Illuminate\Http\Client\Request</code>
    экземпляр и должны возвращать логическое значение, указывающее, если запрос соответствует вашим ожиданиям. Для
    успешного прохождения теста должен быть выдан хотя бы один запрос, соответствующий заданным ожиданиям:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Client<span class="token punctuation">\</span>Request</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Http</span><span
                class="token punctuation">;</span>

Http<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">fake</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

Http<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">withHeaders</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'X-First'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'foo'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">post</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'http://example.com/users'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Taylor'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'role'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Developer'</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

Http<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">assertSent</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span>Request <span class="token variable">$request</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">hasHeader</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'X-First'</span><span class="token punctuation">,</span> <span class="token single-quoted-string string">'foo'</span><span class="token punctuation">)</span> <span class="token operator">&amp;&amp;</span>
    <span class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">url</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token operator">==</span> <span class="token single-quoted-string string">'http://example.com/users'</span> <span class="token operator">&amp;&amp;</span>
    <span class="token variable">$request</span><span class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span><span class="token punctuation">]</span> <span class="token operator">==</span> <span class="token single-quoted-string string">'Taylor'</span> <span class="token operator">&amp;&amp;</span>
    <span class="token variable">$request</span><span class="token punctuation">[</span><span class="token single-quoted-string string">'role'</span><span class="token punctuation">]</span> <span class="token operator">==</span> <span class="token single-quoted-string string">'Developer'</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>При необходимости вы можете утверждать, что конкретный запрос не был отправлен с помощью <code>assertNotSent</code>
    метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Client<span class="token punctuation">\</span>Request</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Http</span><span
                class="token punctuation">;</span>

Http<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">fake</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

Http<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">post</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'http://example.com/users'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Taylor'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'role'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'Developer'</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

Http<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">assertNotSent</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span>Request <span class="token variable">$request</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">url</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token operator">===</span> <span class="token single-quoted-string string">'http://example.com/posts'</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Или вы можете использовать этот <code>assertNothingSent</code> метод, чтобы подтвердить, что во время теста не было
    отправлено никаких запросов:</p>
<pre class=" language-php"><code class=" language-php">Http<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">fake</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

Http<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">assertNothingSent</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre> 
