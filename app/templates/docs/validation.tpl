<h1>Валидация (проверка)</h1>
<ul>
    <li><a href="validation#introduction">Вступление</a></li>
    <li><a href="validation#validation-quickstart">Быстрый запуск проверки</a>
        <ul>
            <li><a href="validation#quick-defining-the-routes">Определение маршрутов</a></li>
            <li><a href="validation#quick-creating-the-controller">Создание контроллера</a></li>
            <li><a href="validation#quick-writing-the-validation-logic">Написание логики проверки</a></li>
            <li><a href="validation#quick-displaying-the-validation-errors">Отображение ошибок проверки</a></li>
            <li><a href="validation#repopulating-forms">Повторное заселение форм</a></li>
            <li><a href="validation#a-note-on-optional-fields">Примечание о дополнительных полях</a></li>
        </ul>
    </li>
    <li><a href="validation#form-request-validation">Подтверждение запроса формы</a>
        <ul>
            <li><a href="validation#creating-form-requests">Создание запросов формы</a></li>
            <li><a href="validation#authorizing-form-requests">Запросы формы авторизации</a></li>
            <li><a href="validation#customizing-the-error-messages">Настройка сообщений об ошибках</a></li>
            <li><a href="validation#preparing-input-for-validation">Подготовка ввода к валидации</a></li>
        </ul>
    </li>
    <li><a href="validation#manually-creating-validators">Создание валидаторов вручную</a>
        <ul>
            <li><a href="validation#automatic-redirection">Автоматическое перенаправление</a></li>
            <li><a href="validation#named-error-bags">Именованные пакеты ошибок</a></li>
            <li><a href="validation#manual-customizing-the-error-messages">Настройка сообщений об ошибках</a></li>
            <li><a href="validation#after-validation-hook">После проверки</a></li>
        </ul>
    </li>
    <li><a href="validation#working-with-error-messages">Работа с сообщениями об ошибках</a>
        <ul>
            <li><a href="validation#specifying-custom-messages-in-language-files">Указание пользовательских сообщений в
                    языковых файлах</a></li>
            <li><a href="validation#specifying-attribute-in-language-files">Указание атрибутов в языковых файлах</a>
            </li>
            <li><a href="validation#specifying-values-in-language-files">Указание значений в языковых файлах</a></li>
        </ul>
    </li>
    <li><a href="validation#available-validation-rules">Доступные правила проверки</a></li>
    <li><a href="validation#conditionally-adding-rules">Условное добавление правил</a></li>
    <li><a href="validation#validating-arrays">Проверка массивов</a></li>
    <li><a href="validation#custom-validation-rules">Пользовательские правила проверки</a>
        <ul>
            <li><a href="validation#using-rule-objects">Использование объектов правила</a></li>
            <li><a href="validation#using-closures">Использование замыканий</a></li>
            <li><a href="validation#implicit-rules">Неявные правила</a></li>
        </ul>
    </li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Laravel предоставляет несколько разных подходов для проверки входящих данных вашего приложения. Чаще всего
    используется <code>validate</code> метод, доступный для всех входящих HTTP-запросов. Однако мы обсудим и другие
    подходы к валидации.</p>
<p>Laravel включает в себя широкий спектр удобных правил проверки, которые вы можете применять к данным, даже
    предоставляя возможность проверять, уникальны ли значения в данной таблице базы данных. Мы подробно рассмотрим
    каждое из этих правил проверки, чтобы вы были знакомы со всеми функциями проверки Laravel.</p>
<p></p>
<h2 id="validation-quickstart"><a href="#validation-quickstart">Быстрый запуск проверки</a></h2>
<p>Чтобы узнать о мощных функциях проверки Laravel, давайте рассмотрим полный пример проверки формы и отображения
    сообщений об ошибках обратно пользователю. Прочитав этот общий обзор, вы сможете получить хорошее общее
    представление о том, как проверять данные входящего запроса с помощью Laravel:</p>
<p></p>
<h3 id="quick-defining-the-routes"><a href="#quick-defining-the-routes">Определение маршрутов</a></h3>
<p>Сначала предположим, что в нашем <code>routes/web.php</code> файле определены следующие маршруты :</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>PostController</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/post/create'</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span>PostController<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'create'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">post</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/post'</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span>PostController<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'store'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p><code>GET</code> Маршрут будет отображать форму для пользователя, чтобы создать новое сообщение в блоге, в то время
    как <code>POST</code> маршрут будет хранить запись в блоге в базе данных.</p>
<p></p>
<h3 id="quick-creating-the-controller"><a href="#quick-creating-the-controller">Создание контроллера</a></h3>
<p>Далее давайте посмотрим на простой контроллер, который обрабатывает входящие запросы на эти маршруты.
    <code>store</code> Пока оставим метод пустым:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>Controller</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">PostController</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Show the form to create a new blog post.
    *
    * @return \Illuminate\View\View
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">create</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token function">view</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'post.create'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
    * Store a new blog post.
    *
    * @param  \Illuminate\Http\Request  $request
    * @return \Illuminate\Http\Response
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">store</span><span class="token punctuation">(</span>Request <span class="token variable">$request</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">// Validate and store the blog post...</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h3 id="quick-writing-the-validation-logic"><a href="#quick-writing-the-validation-logic">Написание логики проверки</a>
</h3>
<p>Теперь мы готовы заполнить наш <code>store</code> метод логикой для проверки нового сообщения в блоге. Для этого мы
    воспользуемся <code>validate</code> методом, предоставленным <code>Illuminate\Http\Request</code> объектом. Если
    правила проверки пройдут, ваш код продолжит нормально выполняться; однако, если проверка завершится неудачно, будет
    сгенерировано исключение, и правильный ответ об ошибке будет автоматически отправлен обратно пользователю.</p>
<p>Если проверка не выполняется во время традиционного HTTP-запроса, будет сгенерирован ответ перенаправления на
    предыдущий URL-адрес. Если входящий запрос является запросом XHR, будет возвращен ответ JSON, содержащий сообщения
    об ошибках проверки.</p>
<p>Чтобы лучше понять <code>validate</code> метод, вернемся к нему <code>store</code> :</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Store a new blog post.
 *
 * @param  \Illuminate\Http\Request  $request
 * @return \Illuminate\Http\Response
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">store</span><span class="token punctuation">(</span>Request <span
                class="token variable">$request</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$validated</span> <span class="token operator">=</span> <span class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">validate</span><span class="token punctuation">(</span><span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'title'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token single-quoted-string string">'required|unique:posts|max:255'</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'body'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token single-quoted-string string">'required'</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

    <span class="token comment">// The blog post is valid...</span>
<span class="token punctuation">}</span></code></pre>
<p>Как видите, правила валидации передаются в <code>validate</code> метод. Не волнуйтесь - все доступные правила проверки
    <a href="validation#available-validation-rules">задокументированы</a>. Опять же, если проверка не удалась,
    правильный ответ будет автоматически сгенерирован. Если проверка пройдет успешно, наш контроллер продолжит
    нормальную работу.</p>
<p>В качестве альтернативы правила проверки могут быть указаны как массивы правил вместо одной <code>|</code> строки с
    разделителями:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$validatedData</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">validate</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'title'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'required'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'unique:posts'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'max:255'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'body'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'required'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Кроме того, вы можете использовать этот <code>validateWithBag</code> метод для проверки запроса и сохранения сообщений
    об ошибках в <a href="validation#named-error-bags">именованном пакете ошибок</a> :</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$validatedData</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">validateWithBag</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'post'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'title'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'required'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'unique:posts'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'max:255'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'body'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'required'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="stopping-on-first-validation-failure"><a href="#stopping-on-first-validation-failure">Остановка при первой
        ошибке проверки</a></h4>
<p>Иногда может потребоваться прекратить выполнение правил проверки для атрибута после первого сбоя проверки. Для этого
    назначьте <code>bail</code> правило атрибуту:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">validate</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'title'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'bail|required|unique:posts|max:255'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'body'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'required'</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>В этом примере, если <code>unique</code> правило <code>title</code> атрибута не выполняется, <code>max</code> правило не
    проверяется. Правила будут проверяться в порядке их назначения.</p>
<p></p>
<h4 id="a-note-on-nested-attributes"><a href="#a-note-on-nested-attributes">Примечание о вложенных атрибутах</a></h4>
<p>Если входящий HTTP-запрос содержит данные «вложенных» полей, вы можете указать эти поля в своих правилах проверки,
    используя синтаксис «точка»:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">validate</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'title'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'required|unique:posts|max:255'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'author.name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'required'</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'author.description'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'required'</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>С другой стороны, если ваше имя поля содержит буквальную точку, вы можете явно запретить ее интерпретацию как
    синтаксис «точка», экранировав точку с помощью обратной косой черты:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">validate</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'title'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'required|unique:posts|max:255'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'v1\.0'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'required'</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="quick-displaying-the-validation-errors"><a href="#quick-displaying-the-validation-errors">Отображение ошибок
        проверки</a></h3>
<p>Итак, что, если поля входящего запроса не проходят заданные правила проверки? Как упоминалось ранее, Laravel
    автоматически перенаправит пользователя обратно в его предыдущее местоположение. Кроме того, все ошибки проверки и
    <a href="requests#retrieving-old-input">ввод запроса</a> будут автоматически перенесены <a
            href="session#flash-data">в сеанс</a>.</p>
<p><code>$errors</code> Переменная совместно со всеми видами вашего приложения со стороны <code>Illuminate\View\Middleware\ShareErrorsFromSession</code> промежуточного
    слоя, который предоставляется в <code>web</code> группе промежуточного программного обеспечения. Когда применяется
    это промежуточное ПО, <code>$errors</code> переменная всегда будет доступна в ваших представлениях, что позволяет вам
    удобно предполагать, что <code>$errors</code> переменная всегда определена и может безопасно использоваться. <code>$errors</code> Переменная
    будет экземпляром <code>Illuminate\Support\MessageBag</code>. Для получения дополнительной информации о работе с
    этим объектом <a href="validation#working-with-error-messages">ознакомьтесь с его документацией</a>.</p>
<p>Итак, в нашем примере пользователь будет перенаправлен на <code>create</code> метод нашего контроллера, когда проверка
    завершится неудачно, что позволит нам отображать сообщения об ошибках в представлении:</p>
<pre class=" language-html"><code class=" language-html"><span class="token comment">&lt;!-- /resources/views/post/create.blade.php --&gt;</span>

<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>h1</span><span
            class="token punctuation">&gt;</span></span>Create Post<span class="token tag"><span class="token tag"><span
                        class="token punctuation">&lt;/</span>h1</span><span
                    class="token punctuation">&gt;</span></span>

@if ($errors-&gt;any())
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>div</span> <span
                class="token attr-name">class</span><span class="token attr-value"><span
                    class="token punctuation attr-equals">=</span><span class="token punctuation">"</span>alert alert-danger<span
                    class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span>
        <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>ul</span><span
                    class="token punctuation">&gt;</span></span>
            @foreach ($errors-&gt;all() as $error)
                <span class="token tag"><span class="token tag"><span
                                class="token punctuation">&lt;</span>li</span><span
                            class="token punctuation">&gt;</span></span>{literal}{{ $error }}{/literal}<span class="token tag"><span
                    class="token tag"><span class="token punctuation">&lt;/</span>li</span><span
                    class="token punctuation">&gt;</span></span>
            @endforeach
        <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>ul</span><span
                    class="token punctuation">&gt;</span></span>
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>div</span><span
                class="token punctuation">&gt;</span></span>
@endif

<span class="token comment">&lt;!-- Create Post Form --&gt;</span></code></pre>
<p></p>
<h4 id="quick-customizing-the-error-messages"><a href="#quick-customizing-the-error-messages">Настройка сообщений об
        ошибках</a></h4>
<p>Каждое из встроенных правил проверки Laravel содержит сообщение об ошибке, которое находится в <code>resources/lang/en/validation.php</code> файле
    вашего приложения. В этом файле вы найдете запись о переводе для каждого правила проверки. Вы можете изменять или
    модифицировать эти сообщения в зависимости от потребностей вашего приложения.</p>
<p>Кроме того, вы можете скопировать этот файл в каталог другого языка перевода, чтобы переводить сообщения на язык
    вашего приложения. Чтобы узнать больше о локализации Laravel, ознакомьтесь с полной <a href="localization">документацией
        по локализации</a>.</p>
<p></p>
<h4 id="quick-xhr-requests-and-validation"><a href="#quick-xhr-requests-and-validation">Запросы и проверка XHR</a></h4>
<p>В этом примере мы использовали традиционную форму для отправки данных в приложение. Однако многие приложения получают
    запросы XHR от внешнего интерфейса на базе JavaScript. При использовании <code>validate</code> метода во время
    запроса XHR Laravel не будет генерировать ответ перенаправления. Вместо этого Laravel генерирует ответ JSON,
    содержащий все ошибки проверки. Этот ответ JSON будет отправлен с кодом состояния 422 HTTP.</p>
<p></p>
<h4 id="the-at-error-directive"><a href="#the-at-error-directive"><code>@error</code> Директива</a></h4>
<p>Вы можете использовать директиву <code>@error</code>  <a href="blade">Blade,</a> чтобы быстро определить, существуют
    ли сообщения об ошибках проверки для данного атрибута. Внутри <code>@error</code> директивы вы можете повторить
    <code>$message</code> переменную, чтобы отобразить сообщение об ошибке:</p>
<pre class=" language-html"><code class=" language-html"><span class="token comment">&lt;!-- /resources/views/post/create.blade.php --&gt;</span>

<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>label</span> <span
            class="token attr-name">for</span><span class="token attr-value"><span
                class="token punctuation attr-equals">=</span><span class="token punctuation">"</span>title<span
                class="token punctuation">"</span></span><span
            class="token punctuation">&gt;</span></span>Post Title<span class="token tag"><span class="token tag"><span
                        class="token punctuation">&lt;/</span>label</span><span
                    class="token punctuation">&gt;</span></span>

<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>input</span> <span
            class="token attr-name">id</span><span class="token attr-value"><span class="token punctuation attr-equals">=</span><span
                class="token punctuation">"</span>title<span class="token punctuation">"</span></span> <span
            class="token attr-name">type</span><span class="token attr-value"><span
                class="token punctuation attr-equals">=</span><span class="token punctuation">"</span>text<span
                class="token punctuation">"</span></span> <span class="token attr-name">class</span><span
            class="token attr-value"><span class="token punctuation attr-equals">=</span><span
                class="token punctuation">"</span>@error(<span class="token punctuation">'</span>title<span
                class="token punctuation">'</span>) is-invalid @enderror<span
                class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span>

@error('title')
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>div</span> <span
                class="token attr-name">class</span><span class="token attr-value"><span
                    class="token punctuation attr-equals">=</span><span class="token punctuation">"</span>alert alert-danger<span
                    class="token punctuation">"</span></span><span
                class="token punctuation">&gt;</span></span>{literal}{{ $message }}{/literal}<span class="token tag"><span
                    class="token tag"><span class="token punctuation">&lt;/</span>div</span><span
                    class="token punctuation">&gt;</span></span>
@enderror</code></pre>
<p></p>
<h3 id="repopulating-forms"><a href="#repopulating-forms">Повторное заселение форм</a></h3>
<p>Когда Laravel генерирует ответ перенаправления из-за ошибки проверки, фреймворк автоматически <a
            href="session#flash-data">мигает все входные данные запроса в сеанс</a>. Это сделано для того, чтобы вы
    могли легко получить доступ к вводу во время следующего запроса и повторно заполнить форму, которую пользователь
    пытался отправить.</p>
<p>Чтобы получить флэш-ввод из предыдущего запроса, вызовите <code>old</code> метод для экземпляра <code>Illuminate\Http\Request</code>.
    <code>old</code> Метод будет тянуть ранее мелькнула входные данные из <a href="session">сессии</a> :</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$title</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">old</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'title'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Laravel также предоставляет глобального <code>old</code> помощника. Если вы показываете старый ввод в <a href="blade">шаблоне
        Blade</a>, удобнее использовать <code>old</code> помощник для повторного заполнения формы. Если для данного поля
    нет старых данных, <code>null</code> будет возвращено:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>input type<span
                class="token operator">=</span><span class="token double-quoted-string string">"text"</span> name<span
                class="token operator">=</span><span class="token double-quoted-string string">"title"</span> value<span
                class="token operator">=</span><span
                class="token double-quoted-string string">"{literal}{{ old('title') }}{/literal}"</span><span
                class="token operator">&gt;</span></code></pre>
<p></p>
<h3 id="a-note-on-optional-fields"><a href="#a-note-on-optional-fields">Примечание о дополнительных полях</a></h3>
<p>По умолчанию, Laravel включает <code>TrimStrings</code> и <code>ConvertEmptyStringsToNull</code> промежуточное
    программное обеспечение глобального стека промежуточного программного приложения. Эти промежуточные программы
    перечислены в стеке по <code>App\Http\Kernel</code> классам. Из-за этого вам часто нужно будет отмечать
    «необязательные» поля запроса, как <code>nullable</code> если бы вы не хотели, чтобы валидатор считал
    <code>null</code> значения недопустимыми. Например:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">validate</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'title'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'required|unique:posts|max:255'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'body'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'required'</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'publish_at'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'nullable|date'</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>В этом примере мы указываем, что <code>publish_at</code> поле может быть либо <code>null</code> допустимым
    представлением даты, либо действительным. Если <code>nullable</code> модификатор не добавлен в определение правила,
    валидатор сочтет <code>null</code> недопустимую дату.</p>
<p></p>
<h2 id="form-request-validation"><a href="#form-request-validation">Подтверждение запроса формы</a></h2>
<p></p>
<h3 id="creating-form-requests"><a href="#creating-form-requests">Создание запросов формы</a></h3>
<p>Для более сложных сценариев проверки вы можете создать «запрос формы». Запросы формы - это настраиваемые классы
    запросов, которые инкапсулируют свою собственную логику проверки и авторизации. Чтобы создать класс запроса формы,
    вы можете использовать команду <code>make:request</code> Artisan CLI:</p>
<pre class=" language-php"><code class=" language-php">php artisan make<span class="token punctuation">:</span>request StorePostRequest</code></pre>
<p>Сгенерированный класс запроса формы будет помещен в <code>app/Http/Requests</code> каталог. Если этот каталог не
    существует, он будет создан при запуске <code>make:request</code> команды. Каждый запрос формы, созданный Laravel,
    имеет два метода: <code>authorize</code> и <code>rules</code>.</p>
<p>Как вы могли догадаться, <code>authorize</code> метод отвечает за определение того, может ли текущий
    аутентифицированный пользователь выполнить действие, представленное запросом, в то время как <code>rules</code> метод
    возвращает правила проверки, которые должны применяться к данным запроса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the validation rules that apply to the request.
 *
 * @return array
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">rules</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'title'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token single-quoted-string string">'required|unique:posts|max:255'</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'body'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token single-quoted-string string">'required'</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Вы можете указать любые требуемые зависимости в <code>rules</code> сигнатуре метода. Они будут автоматически
            разрешены через <a href="container">сервисный контейнер</a> Laravel.</p></p></div>
</blockquote>
<p>Итак, как оцениваются правила проверки? Все, что вам нужно сделать, это напечатать запрос на метод вашего
    контроллера. Входящий запрос формы проверяется до вызова метода контроллера, а это означает, что вам не нужно
    загромождать контроллер какой-либо логикой проверки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Store a new blog post.
 *
 * @param  \App\Http\Requests\StorePostRequest  $request
 * @return Illuminate\Http\Response
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">store</span><span class="token punctuation">(</span>StorePostRequest <span
                class="token variable">$request</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// The incoming request is valid...</span>

    <span class="token comment">// Retrieve the validated input data...</span>
    <span class="token variable">$validated</span> <span class="token operator">=</span> <span class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">validated</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Если проверка не удалась, будет сгенерирован ответ перенаправления, чтобы отправить пользователя обратно в предыдущее
    местоположение. Ошибки также будут перенесены в сеанс, чтобы они были доступны для отображения. Если запрос был
    запросом XHR, пользователю будет возвращен HTTP-ответ с кодом состояния 422, включая JSON-представление ошибок
    проверки.</p>
<p></p>
<h4 id="adding-after-hooks-to-form-requests"><a href="#adding-after-hooks-to-form-requests">Добавление хуков после
        запроса формы</a></h4>
<p>Если вы хотите добавить обработчик проверки «после» к запросу формы, вы можете использовать этот
    <code>withValidator</code> метод. Этот метод получает полностью сконструированный валидатор, позволяющий вызвать
    любой из его методов до того, как правила валидации будут фактически оценены:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Configure the validator instance.
 *
 * @param  \Illuminate\Validation\Validator  $validator
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">withValidator</span><span
                class="token punctuation">(</span><span class="token variable">$validator</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$validator</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">after</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token variable">$validator</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">somethingElseIsInvalid</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token variable">$validator</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">errors</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">add</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'field'</span><span class="token punctuation">,</span> <span class="token single-quoted-string string">'Something is wrong with this field!'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="authorizing-form-requests"><a href="#authorizing-form-requests">Запросы формы авторизации</a></h3>
<p>Класс запроса формы также содержит <code>authorize</code> метод. В рамках этого метода вы можете определить,
    действительно ли аутентифицированный пользователь имеет право обновлять данный ресурс. Например, вы можете
    определить, действительно ли пользователь владеет комментарием в блоге, который он пытается обновить. Скорее всего,
    вы будете взаимодействовать со своими <a href="authorization">шлюзами авторизации и политиками</a> в этом методе:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>Comment</span><span class="token punctuation">;</span>

<span class="token comment">/**
 * Determine if the user is authorized to make this request.
 *
 * @return bool
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">authorize</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$comment</span> <span class="token operator">=</span> Comment<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">find</span><span class="token punctuation">(</span><span class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">route</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'comment'</span><span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

    <span class="token keyword">return</span> <span class="token variable">$comment</span> <span class="token operator">&amp;&amp;</span> <span class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">user</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">can</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'update'</span><span class="token punctuation">,</span> <span class="token variable">$comment</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Поскольку все запросы форм расширяют базовый класс запросов Laravel, мы можем использовать этот <code>user</code> метод
    для доступа к текущему аутентифицированному пользователю. Также обратите внимание на вызов <code>route</code> метода
    в приведенном выше примере. Этот метод предоставляет вам доступ к параметрам URI, определенным для вызываемого
    маршрута, таким как <code>{literal}{comment}{/literal}</code> параметр в примере ниже:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">post</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'/comment/{literal}{comment}{/literal}'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если <code>authorize</code> метод возвращается <code>false</code>, ответ HTTP с кодом состояния 403 будет
    автоматически возвращен, и метод вашего контроллера не будет выполняться.</p>
<p>Если вы планируете обрабатывать логику авторизации для запроса в другой части вашего приложения, вы можете просто
    вернуться <code>true</code> из <code>authorize</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Determine if the user is authorized to make this request.
 *
 * @return bool
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">authorize</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token boolean constant">true</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Вы можете указать любые зависимости в <code>authorize</code> сигнатуре метода. Они будут автоматически
            разрешены через <a href="container">сервисный контейнер</a> Laravel.</p></p></div>
</blockquote>
<p></p>
<h3 id="customizing-the-error-messages"><a href="#customizing-the-error-messages">Настройка сообщений об ошибках</a>
</h3>
<p>Вы можете настроить сообщения об ошибках, используемые в запросе формы, переопределив <code>messages</code> метод.
    Этот метод должен возвращать массив пар атрибут / правило и соответствующие им сообщения об ошибках:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the error messages for the defined validation rules.
 *
 * @return array
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">messages</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'title.required'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token single-quoted-string string">'A title is required'</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'body.required'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token single-quoted-string string">'A message is required'</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="customizing-the-validation-attributes"><a href="#customizing-the-validation-attributes">Настройка атрибутов
        проверки</a></h4>
<p>Многие сообщения об ошибках встроенных правил проверки Laravel содержат <code>:attribute</code> заполнитель. Если вы
    хотите, чтобы <code>:attribute</code> заполнитель вашего сообщения проверки был заменен именем настраиваемого
    атрибута, вы можете указать настраиваемые имена, переопределив <code>attributes</code> метод. Этот метод должен
    возвращать массив пар атрибут / имя:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get custom attributes for validator errors.
 *
 * @return array
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">attributes</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token single-quoted-string string">'email address'</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="preparing-input-for-validation"><a href="#preparing-input-for-validation">Подготовка ввода к валидации</a></h3>
<p>Если вам нужно подготовить или очистить какие-либо данные из запроса, прежде чем применять правила проверки, вы
    можете использовать <code>prepareForValidation</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token comment">/**
 * Prepare the data for validation.
 *
 * @return void
 */</span>
<span class="token keyword">protected</span> <span class="token keyword">function</span> <span class="token function">prepareForValidation</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">merge</span><span class="token punctuation">(</span><span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'slug'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> Str<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">slug</span><span class="token punctuation">(</span><span class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">slug</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h2 id="manually-creating-validators"><a href="#manually-creating-validators">Создание валидаторов вручную</a></h2>
<p>Если вы не хотите использовать <code>validate</code> метод в запросе, вы можете создать экземпляр валидатора вручную,
    используя <code>Validator</code>  <a href="facades">фасад</a>. <code>make</code> Метод на фасаде создает новый
    экземпляр валидатора:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>Controller</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Validator</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">PostController</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Store a new blog post.
    *
    * @param  Request  $request
    * @return Response
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">store</span><span class="token punctuation">(</span>Request <span class="token variable">$request</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$validator</span> <span class="token operator">=</span> Validator<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">make</span><span class="token punctuation">(</span><span class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">all</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">,</span> <span class="token punctuation">[</span>
            <span class="token single-quoted-string string">'title'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token single-quoted-string string">'required|unique:posts|max:255'</span><span class="token punctuation">,</span>
            <span class="token single-quoted-string string">'body'</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token single-quoted-string string">'required'</span><span class="token punctuation">,</span>
        <span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token variable">$validator</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">fails</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> <span class="token function">redirect</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'post/create'</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">withErrors</span><span class="token punctuation">(</span><span class="token variable">$validator</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">withInput</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span>

        <span class="token comment">// Store the blog post...</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Первый аргумент, переданный <code>make</code> методу, - это проверяемые данные. Второй аргумент - это массив правил
    проверки, которые должны применяться к данным.</p>
<p>После определения того, не прошла ли проверка запроса, вы можете использовать этот <code>withErrors</code> метод для
    передачи сообщений об ошибках в сеанс. При использовании этого метода <code>$errors</code> переменная будет
    автоматически предоставлена вашим представлениям после перенаправления, что позволит вам легко отобразить их
    обратно пользователю. <code>withErrors</code> Метод принимает валидатор, A <code>MessageBag</code>, или PHP <code>array</code>.
</p>
<p></p>
<h3 id="automatic-redirection"><a href="#automatic-redirection">Автоматическое перенаправление</a></h3>
<p>Если вы хотите создать экземпляр валидатора вручную, но по-прежнему использовать автоматическое перенаправление,
    предлагаемое методом HTTP-запроса <code>validate</code>, вы можете вызвать <code>validate</code> метод в существующем
    экземпляре валидатора. Если проверка не удалась, пользователь будет автоматически перенаправлен или, в случае
    запроса XHR, будет возвращен ответ JSON:</p>
<pre class=" language-php"><code class=" language-php">Validator<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">make</span><span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span>
    <span class="token single-quoted-string string">'title'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'required|unique:posts|max:255'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'body'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'required'</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">validate</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы можете использовать этот <code>validateWithBag</code> метод для сохранения сообщений об ошибках в <a
            href="validation#named-error-bags">именованном пакете ошибок,</a> если проверка не удалась:</p>
<pre class=" language-php"><code class=" language-php">Validator<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">make</span><span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span>
    <span class="token single-quoted-string string">'title'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'required|unique:posts|max:255'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'body'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'required'</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">validateWithBag</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'post'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="named-error-bags"><a href="#named-error-bags">Именованные пакеты ошибок</a></h3>
<p>Если у вас есть несколько форм на одной странице, вы можете указать имя, <code>MessageBag</code> содержащее ошибки
    проверки, что позволит вам получать сообщения об ошибках для конкретной формы. Для этого передайте имя в качестве
    второго аргумента <code>withErrors</code> :</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> <span
                class="token function">redirect</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'register'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">withErrors</span><span
                class="token punctuation">(</span><span class="token variable">$validator</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'login'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Затем вы можете получить доступ к названному <code>MessageBag</code> экземпляру из <code>$errors</code> переменной:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token punctuation">{literal}{{/literal}</span><span class="token punctuation">{literal}{{/literal}</span> <span class="token variable">$errors</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">login</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">first</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'email'</span><span class="token punctuation">)</span> <span class="token punctuation">}</span><span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="manual-customizing-the-error-messages"><a href="#manual-customizing-the-error-messages">Настройка сообщений об
        ошибках</a></h3>
<p>При необходимости вы можете предоставить настраиваемые сообщения об ошибках, которые должен использовать экземпляр
    валидатора вместо сообщений об ошибках по умолчанию, предоставляемых Laravel. Есть несколько способов указать
    собственные сообщения. Во-первых, вы можете передать настраиваемые сообщения в качестве третьего аргумента <code>Validator::make</code> метода:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$validator</span> <span
                class="token operator">=</span> Validator<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">make</span><span
                class="token punctuation">(</span><span class="token variable">$input</span><span
                class="token punctuation">,</span> <span class="token variable">$rules</span><span
                class="token punctuation">,</span> <span class="token variable">$messages</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'required'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'The :attribute field is required.'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>В этом примере <code>:attribute</code> заполнитель будет заменен фактическим именем проверяемого поля. Вы также можете
    использовать другие заполнители в сообщениях проверки. Например:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$messages</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'same'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'The :attribute and :other must match.'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'size'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'The :attribute must be exactly :size.'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'between'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'The :attribute value :input is not between :min - :max.'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'in'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'The :attribute must be one of the following types: :values'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="specifying-a-custom-message-for-a-given-attribute"><a href="#specifying-a-custom-message-for-a-given-attribute">Указание
        настраиваемого сообщения для заданного атрибута</a></h4>
<p>Иногда может потребоваться указать собственное сообщение об ошибке только для определенного атрибута. Вы можете
    сделать это, используя "точечную" нотацию. Сначала укажите имя атрибута, а затем правило:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$messages</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'email.required'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'We need to know your email address!'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="specifying-custom-attribute-values"><a href="#specifying-custom-attribute-values">Указание значений
        настраиваемых атрибутов</a></h4>
<p>Многие из встроенных сообщений об ошибках Laravel включают <code>:attribute:</code> заполнитель, который заменяется
    именем проверяемого поля или атрибута. Чтобы настроить значения, используемые для замены этих заполнителей для
    определенных полей, вы можете передать массив настраиваемых атрибутов в качестве четвертого аргумента <code>Validator::make</code> метода:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$validator</span> <span
                class="token operator">=</span> Validator<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">make</span><span
                class="token punctuation">(</span><span class="token variable">$input</span><span
                class="token punctuation">,</span> <span class="token variable">$rules</span><span
                class="token punctuation">,</span> <span class="token variable">$messages</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'email address'</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="after-validation-hook"><a href="#after-validation-hook">После проверки</a></h3>
<p>Вы также можете прикрепить обратные вызовы, которые будут запускаться после завершения проверки. Это позволяет легко
    выполнять дальнейшую проверку и даже добавлять сообщения об ошибках в коллекцию сообщений. Для начала вызовите
    <code>after</code> метод на экземпляре валидатора:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$validator</span> <span
                class="token operator">=</span> Validator<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">make</span><span
                class="token punctuation">(</span><span class="token punctuation">.</span><span
                class="token punctuation">.</span><span class="token punctuation">.</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$validator</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">after</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$validator</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">somethingElseIsInvalid</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$validator</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">errors</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">add</span><span class="token punctuation">(</span>
            <span class="token single-quoted-string string">'field'</span><span class="token punctuation">,</span> <span class="token single-quoted-string string">'Something is wrong with this field!'</span>
        <span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token keyword">if</span> <span class="token punctuation">(</span><span
                class="token variable">$validator</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">fails</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h2 id="working-with-error-messages"><a href="#working-with-error-messages">Работа с сообщениями об ошибках</a></h2>
<p>После вызова <code>errors</code> метода для <code>Validator</code> экземпляра вы получите <code>Illuminate\Support\MessageBag</code> экземпляр,
    в котором есть множество удобных методов для работы с сообщениями об ошибках. <code>$errors</code> Переменная,
    которая автоматически становится доступной для всех представлений также является экземпляром <code>MessageBag</code> класса.
</p>
<p></p>
<h4 id="retrieving-the-first-error-message-for-a-field"><a href="#retrieving-the-first-error-message-for-a-field">Получение
        первого сообщения об ошибке для поля</a></h4>
<p>Чтобы получить первое сообщение об ошибке для данного поля, используйте <code>first</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$errors</span> <span
                class="token operator">=</span> <span class="token variable">$validator</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">errors</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token keyword">echo</span> <span class="token variable">$errors</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">first</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'email'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="retrieving-all-error-messages-for-a-field"><a href="#retrieving-all-error-messages-for-a-field">Получение всех
        сообщений об ошибках для поля</a></h4>
<p>Если вам нужно получить массив всех сообщений для данного поля, используйте <code>get</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">foreach</span> <span
                class="token punctuation">(</span><span class="token variable">$errors</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'email'</span><span class="token punctuation">)</span> <span
                class="token keyword">as</span> <span class="token variable">$message</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p>Если вы проверяете поле формы массива, вы можете получить все сообщения для каждого из элементов массива, используя
    <code>*</code> символ:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">foreach</span> <span
                class="token punctuation">(</span><span class="token variable">$errors</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'attachments.*'</span><span class="token punctuation">)</span> <span
                class="token keyword">as</span> <span class="token variable">$message</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="retrieving-all-error-messages-for-all-fields"><a href="#retrieving-all-error-messages-for-all-fields">Получение
        всех сообщений об ошибках для всех полей</a></h4>
<p>Чтобы получить массив всех сообщений для всех полей, используйте <code>all</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">foreach</span> <span
                class="token punctuation">(</span><span class="token variable">$errors</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span> <span class="token keyword">as</span> <span class="token variable">$message</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="determining-if-messages-exist-for-a-field"><a href="#determining-if-messages-exist-for-a-field">Определение
        наличия сообщений для поля</a></h4>
<p>Этот <code>has</code> метод может использоваться, чтобы определить, существуют ли какие-либо сообщения об ошибках для
    данного поля:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">if</span> <span
                class="token punctuation">(</span><span class="token variable">$errors</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">has</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'email'</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="specifying-custom-messages-in-language-files"><a href="#specifying-custom-messages-in-language-files">Указание
        пользовательских сообщений в языковых файлах</a></h3>
<p>Каждое из встроенных правил проверки Laravel содержит сообщение об ошибке, которое находится в <code>resources/lang/en/validation.php</code> файле
    вашего приложения. В этом файле вы найдете запись о переводе для каждого правила проверки. Вы можете изменять или
    модифицировать эти сообщения в зависимости от потребностей вашего приложения.</p>
<p>Кроме того, вы можете скопировать этот файл в каталог другого языка перевода, чтобы переводить сообщения на язык
    вашего приложения. Чтобы узнать больше о локализации Laravel, ознакомьтесь с полной <a href="localization">документацией
        по локализации</a>.</p>
<p></p>
<h4 id="custom-messages-for-specific-attributes"><a href="#custom-messages-for-specific-attributes">Пользовательские
        сообщения для определенных атрибутов</a></h4>
<p>Вы можете настроить сообщения об ошибках, используемые для указанных комбинаций атрибутов и правил в файлах языка
    проверки вашего приложения. Для этого добавьте настройки сообщений в <code>custom</code> массив <code>resources/lang/xx/validation.php</code> языкового
    файла приложения:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'custom'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'required'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'We need to know your email address!'</span><span
                class="token punctuation">,</span>
        <span class="token single-quoted-string string">'max'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Your email address is too long!'</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p></p>
<h3 id="specifying-attribute-in-language-files"><a href="#specifying-attribute-in-language-files">Указание атрибутов в
        языковых файлах</a></h3>
<p>Многие из встроенных сообщений об ошибках Laravel включают <code>:attribute:</code> заполнитель, который заменяется
    именем проверяемого поля или атрибута. Если вы хотите, чтобы <code>:attribute</code> часть вашего сообщения проверки
    была заменена пользовательским значением, вы можете указать имя настраиваемого атрибута в <code>attributes</code> массиве
    вашего <code>resources/lang/xx/validation.php</code> языкового файла:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'attributes'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'email address'</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p></p>
<h3 id="specifying-values-in-language-files"><a href="#specifying-values-in-language-files">Указание значений в языковых
        файлах</a></h3>
<p>Некоторые из сообщений об ошибках встроенных правил проверки Laravel содержат <code>:value</code> заполнитель, который
    заменяется текущим значением атрибута запроса. Однако иногда вам может понадобиться <code>:value</code> заменить
    часть вашего сообщения проверки пользовательским представлением значения. Например, рассмотрим следующее правило,
    которое указывает, что номер кредитной карты требуется, если <code>payment_type</code> имеет значение <code>cc</code> :
</p>
<pre class=" language-php"><code class=" language-php">Validator<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">make</span><span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span>
    <span class="token single-quoted-string string">'credit_card_number'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'required_if:payment_type,cc'</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если это правило проверки не срабатывает, будет выдано следующее сообщение об ошибке:</p>
<pre class=" language-php"><code
            class=" language-php">The credit card number field is required when payment type is cc<span
                class="token punctuation">.</span></code></pre>
<p>Вместо отображения <code>cc</code> в качестве значения типа платежа вы можете указать более удобное для пользователя
    представление значения в вашем <code>resources/lang/xx/validation.php</code> языковом файле, определив
    <code>values</code> массив:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'values'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'payment_type'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'cc'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'credit card'</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p>После определения этого значения правило проверки выдаст следующее сообщение об ошибке:</p>
<pre class=" language-php"><code class=" language-php">The credit card number field is required when payment type is credit card<span
                class="token punctuation">.</span></code></pre>
<p></p>
<h2 id="available-validation-rules"><a href="#available-validation-rules">Доступные правила проверки</a></h2>
<p>Ниже приведен список всех доступных правил проверки и их функций:</p>
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
<div class="collection-method-list">
    <p><a href="#rule-accepted">Accepted</a>
        <a href="#rule-active-url">Active URL</a>
        <a href="#rule-after">After (Date)</a>
        <a href="#rule-after-or-equal">After Or Equal (Date)</a>
        <a href="#rule-alpha">Alpha</a>
        <a href="#rule-alpha-dash">Alpha Dash</a>
        <a href="#rule-alpha-num">Alpha Numeric</a>
        <a href="#rule-array">Array</a>
        <a href="#rule-bail">Bail</a>
        <a href="#rule-before">Before (Date)</a>
        <a href="#rule-before-or-equal">Before Or Equal (Date)</a>
        <a href="#rule-between">Between</a>
        <a href="#rule-boolean">Boolean</a>
        <a href="#rule-confirmed">Confirmed</a>
        <a href="#rule-date">Date</a>
        <a href="#rule-date-equals">Date Equals</a>
        <a href="#rule-date-format">Date Format</a>
        <a href="#rule-different">Different</a>
        <a href="#rule-digits">Digits</a>
        <a href="#rule-digits-between">Digits Between</a>
        <a href="#rule-dimensions">Dimensions (Image Files)</a>
        <a href="#rule-distinct">Distinct</a>
        <a href="#rule-email">Email</a>
        <a href="#rule-ends-with">Ends With</a>
        <a href="#rule-exclude-if">Exclude If</a>
        <a href="#rule-exclude-unless">Exclude Unless</a>
        <a href="#rule-exists">Exists (Database)</a>
        <a href="#rule-file">File</a>
        <a href="#rule-filled">Filled</a>
        <a href="#rule-gt">Greater Than</a>
        <a href="#rule-gte">Greater Than Or Equal</a>
        <a href="#rule-image">Image (File)</a>
        <a href="#rule-in">In</a>
        <a href="#rule-in-array">In Array</a>
        <a href="#rule-integer">Integer</a>
        <a href="#rule-ip">IP Address</a>
        <a href="#rule-json">JSON</a>
        <a href="#rule-lt">Less Than</a>
        <a href="#rule-lte">Less Than Or Equal</a>
        <a href="#rule-max">Max</a>
        <a href="#rule-mimetypes">MIME Types</a>
        <a href="#rule-mimes">MIME Type By File Extension</a>
        <a href="#rule-min">Min</a>
        <a href="#multiple-of">Multiple Of</a>
        <a href="#rule-not-in">Not In</a>
        <a href="#rule-not-regex">Not Regex</a>
        <a href="#rule-nullable">Nullable</a>
        <a href="#rule-numeric">Numeric</a>
        <a href="#rule-password">Password</a>
        <a href="#rule-present">Present</a>
        <a href="#rule-regex">Regular Expression</a>
        <a href="#rule-required">Required</a>
        <a href="#rule-required-if">Required If</a>
        <a href="#rule-required-unless">Required Unless</a>
        <a href="#rule-required-with">Required With</a>
        <a href="#rule-required-with-all">Required With All</a>
        <a href="#rule-required-without">Required Without</a>
        <a href="#rule-required-without-all">Required Without All</a>
        <a href="#rule-same">Same</a>
        <a href="#rule-size">Size</a>
        <a href="#conditionally-adding-rules">Sometimes</a>
        <a href="#rule-starts-with">Starts With</a>
        <a href="#rule-string">String</a>
        <a href="#rule-timezone">Timezone</a>
        <a href="#rule-unique">Unique (Database)</a>
        <a href="#rule-url">URL</a>
        <a href="#rule-uuid">UUID</a></p>
</div>
<p></p>
<h4 id="rule-accepted"><a href="#rule-accepted">accepted</a></h4>
<p>Поле под проверкой должно быть <code>"yes"</code>, <code>"on"</code>, <code>1</code> или <code>true</code>. Это
    полезно для проверки принятия "Условий использования" или аналогичных полей.</p>
<p></p>
<h4 id="rule-active-url"><a href="#rule-active-url">active_url</a></h4>
<p>Проверяемое поле должно иметь действительную запись A или AAAA в соответствии с <code>dns_get_record</code> функцией
    PHP. Имя хоста предоставленного URL-адреса <code>parse_url</code> перед передачей извлекается с помощью функции PHP
    <code>dns_get_record</code>.</p>
<p></p>
<h4 id="rule-after"><a href="#rule-after">after:<em>date</em></a></h4>
<p>Проверяемое поле должно иметь значение после заданной даты. Даты будут переданы в <code>strtotime</code> функцию PHP
    для преобразования в действительный <code>DateTime</code> экземпляр:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'start_date'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'required|date|after:tomorrow'</span></code></pre>
<p>Вместо передачи строки даты для оценки <code>strtotime</code> вы можете указать другое поле для сравнения с датой:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'finish_date'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'required|date|after:start_date'</span></code></pre>
<p></p>
<h4 id="rule-after-or-equal"><a href="#rule-after-or-equal">after_or_equal:<em>date</em></a></h4>
<p>Проверяемое поле должно иметь значение после указанной даты или равное ей. Для получения дополнительной информации
    см. Правило <a href="validation#rule-after">после</a>.</p>
<p></p>
<h4 id="rule-alpha"><a href="#rule-alpha">alpha</a></h4>
<p>Проверяемое поле должно состоять полностью из буквенных символов.</p>
<p></p>
<h4 id="rule-alpha-dash"><a href="#rule-alpha-dash">alpha_dash</a></h4>
<p>Проверяемое поле может содержать буквенно-цифровые символы, а также дефисы и подчеркивания.</p>
<p></p>
<h4 id="rule-alpha-num"><a href="#rule-alpha-num">alpha_num</a></h4>
<p>Проверяемое поле должно состоять полностью из буквенно-цифровых символов.</p>
<p></p>
<h4 id="rule-array"><a href="#rule-array">array</a></h4>
<p>Проверяемое поле должно быть PHP <code>array</code>.</p>
<p></p>
<h4 id="rule-bail"><a href="#rule-bail">bail</a></h4>
<p>Остановите выполнение правил проверки после первого сбоя проверки.</p>
<p></p>
<h4 id="rule-before"><a href="#rule-before">before:<em>date</em></a></h4>
<p>Проверяемое поле должно быть значением, предшествующим указанной дате. Даты будут переданы в <code>strtotime</code> функцию
    PHP для преобразования в действительный <code>DateTime</code> экземпляр. Кроме того, как и в случае с <a
            href="validation#rule-after"><code>after</code></a>правилом, имя другого проверяемого поля может быть
    указано в качестве значения <code>date</code>.</p>
<p></p>
<h4 id="rule-before-or-equal"><a href="#rule-before-or-equal">before_or_equal:<em>date</em></a></h4>
<p>Проверяемое поле должно иметь значение, предшествующее указанной дате или равное ей. Даты будут переданы в <code>strtotime</code> функцию
    PHP для преобразования в действительный <code>DateTime</code> экземпляр. Кроме того, как и в случае с <a
            href="validation#rule-after"><code>after</code></a>правилом, имя другого проверяемого поля может быть
    указано в качестве значения <code>date</code>.</p>
<p></p>
<h4 id="rule-between"><a href="#rule-between">between:<em>min</em>,<em>max</em></a></h4>
<p>Проверяемое поле должно иметь размер от заданного <em>минимума</em> до <em>максимума</em>. Строки, числа, массивы и
    файлы оцениваются так же, как и <a href="validation#rule-size"><code>size</code></a>правило.</p>
<p></p>
<h4 id="rule-boolean"><a href="#rule-boolean">boolean</a></h4>
<p>Проверяемое поле должно иметь возможность преобразования в логическое значение. Принимаемые входные <code>true</code>,
    <code>false</code>, <code>1</code>, <code>0</code>, <code>"1"</code>, и <code>"0"</code>.</p>
<p></p>
<h4 id="rule-confirmed"><a href="#rule-confirmed">confirmed</a></h4>
<p>Проверяемое поле должно иметь соответствующее поле <code>{literal}{field}{/literal}_confirmation</code>. Например, если
    <code>password</code> проверяется <code>password_confirmation</code> поле, во входных данных должно присутствовать
    соответствующее поле.</p>
<p></p>
<h4 id="rule-date"><a href="#rule-date">date</a></h4>
<p>Проверяемое поле должно быть действительной, не относительной датой в соответствии с <code>strtotime</code> функцией
    PHP.</p>
<p></p>
<h4 id="rule-date-equals"><a href="#rule-date-equals">date_equals:<em>date</em></a></h4>
<p>Проверяемое поле должно быть равно указанной дате. Даты будут переданы в <code>strtotime</code> функцию PHP для
    преобразования в действительный <code>DateTime</code> экземпляр.</p>
<p></p>
<h4 id="rule-date-format"><a href="#rule-date-format">date_format:<em>format</em></a></h4>
<p>Проверяемое поле должно соответствовать заданному <em>формату</em>. При проверке поля следует использовать <strong>либо
        то,</strong> <code>date</code>  либо <code>date_format</code> другое, а не то и другое одновременно. Это правило
    проверки поддерживает все форматы, поддерживаемые классом <a
            href="https://www.php.net/manual/en/class.datetime.php">DateTime</a> PHP.</p>
<p></p>
<h4 id="rule-different"><a href="#rule-different">different:<em>field</em></a></h4>
<p>Проверяемое поле должно иметь другое значение, чем <em>поле</em>.</p>
<p></p>
<h4 id="rule-digits"><a href="#rule-digits">digits:<em>value</em></a></h4>
<p>Проверяемое поле должно быть <em>числовым</em> и иметь точную длину <em>значения</em>.</p>
<p></p>
<h4 id="rule-digits-between"><a href="#rule-digits-between">digits_between:<em>min</em>,<em>max</em></a></h4>
<p>Проверяемое поле должно быть <em>числовым</em> и иметь длину от заданного <em>минимума</em> до <em>максимума</em>.
</p>
<p></p>
<h4 id="rule-dimensions"><a href="#rule-dimensions">dimensions</a></h4>
<p>Проверяемый файл должен быть изображением, отвечающим ограничениям размеров, указанным в параметрах правила:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'avatar'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'dimensions:min_width=100,min_height=200'</span></code></pre>
<p>Доступные ограничения: <em>min_width</em>, <em>max_width</em>, <em>min_height</em>, <em>max_height</em>, <em>width</em>
   , <em>height</em>, <em>ratio</em>.</p>
<p><em>Отношение</em> ограничение должно быть представлено в виде шириной деленной на высоту. Это может быть указано в
    виде дроби <code>3/2</code> или числа с плавающей запятой <code>1.5</code> :</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'avatar'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'dimensions:ratio=3/2'</span></code></pre>
<p>Поскольку это правило требует нескольких аргументов, вы можете использовать <code>Rule::dimensions</code> метод для
    плавного построения правила:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span
                    class="token punctuation">\</span>Validator</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Validation<span
                    class="token punctuation">\</span>Rule</span><span class="token punctuation">;</span>

Validator<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">make</span><span
                class="token punctuation">(</span><span class="token variable">$data</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'avatar'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'required'</span><span class="token punctuation">,</span>
        Rule<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">dimensions</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">maxWidth</span><span
                class="token punctuation">(</span><span class="token number">1000</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">maxHeight</span><span
                class="token punctuation">(</span><span class="token number">500</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">ratio</span><span
                class="token punctuation">(</span><span class="token number">3</span> <span
                class="token operator">/</span> <span class="token number">2</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="rule-distinct"><a href="#rule-distinct">distinct</a></h4>
<p>При проверке массивов проверяемое поле не должно иметь повторяющихся значений:</p>
<pre class=" language-php"><code class=" language-php"><span class="token single-quoted-string string">'foo.*.id'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'distinct'</span></code></pre>
<p>Вы можете добавить <code>ignore_case</code> аргументы правила проверки, чтобы правило игнорировало различия в
    регистрах:</p>
<pre class=" language-php"><code class=" language-php"><span class="token single-quoted-string string">'foo.*.id'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'distinct:ignore_case'</span></code></pre>
<p></p>
<h4 id="rule-email"><a href="#rule-email">email</a></h4>
<p>Проверяемое поле должно быть отформатировано как адрес электронной почты. Это правило проверки использует <a
            href="https://github.com/egulias/EmailValidator"><code>egulias/email-validator</code></a>пакет для проверки
    адреса электронной почты. По умолчанию применяется <code>RFCValidation</code> валидатор, но вы также можете применить
    другие стили валидации:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'email:rfc,dns'</span></code></pre>
<p>В приведенном выше примере будет применяться <code>RFCValidation</code> и <code>DNSCheckValidation</code> валидации.
    Вот полный список стилей проверки, которые вы можете применить:</p>
<div class="content-list">
    <ul>
        <li><code>rfc</code> : <code>RFCValidation</code></li>
        <li><code>strict</code> : <code>NoRFCWarningsValidation</code></li>
        <li><code>dns</code> : <code>DNSCheckValidation</code></li>
        <li><code>spoof</code> : <code>SpoofCheckValidation</code></li>
        <li><code>filter</code> : <code>FilterEmailValidation</code></li>
    </ul>
</div>
<p><code>filter</code> Валидатор, который использует PHP- <code>filter_var</code> функцию, корабли с Laravel и был
    поведение проверки электронной почты по умолчанию Laravel в до Laravel версии 5.8.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p><code>dns</code> И <code>spoof</code> валидаторы требуют PHP <code>intl</code> расширения.</p></p></div>
</blockquote>
<p></p>
<h4 id="rule-ends-with"><a href="#rule-ends-with">end_with:<em>foo</em>,<em>bar</em>,...</a></h4>
<p>Проверяемое поле должно заканчиваться одним из указанных значений.</p>
<p></p>
<h4 id="rule-exclude-if"><a href="#rule-exclude-if">exclude_if:<em>anotherfield</em>,<em>value</em></a></h4>
<p>Проверяемое поле будет исключено из данных запроса, возвращаемых методами <code>validate</code> и,
    <code>validated</code> если поле <em>другого</em> поля равно <em>значению</em>.</p>
<p></p>
<h4 id="rule-exclude-unless"><a href="#rule-exclude-unless">exclude_unless:<em>anotherfield</em>,<em>value</em></a>
</h4>
<p>Проверяемое поле будет исключено из данных запроса, возвращаемых методами <code>validate</code> и,
    <code>validated</code> если только поле <em>другого</em> поля не равно <em>значению</em>.</p>
<p></p>
<h4 id="rule-exists"><a href="#rule-exists">exists:<em>table</em>,<em>column</em></a></h4>
<p>Проверяемое поле должно существовать в данной таблице базы данных.</p>
<p></p>
<h4 id="basic-usage-of-exists-rule"><a href="#basic-usage-of-exists-rule">Основное использование правила Exists</a></h4>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'state'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'exists:states'</span></code></pre>
<p>Если <code>column</code> опция не указана, будет использоваться имя поля. Таким образом, в этом случае правило будет
    проверять, что <code>states</code> таблица базы данных содержит запись со <code>state</code> значением столбца,
    соответствующим <code>state</code> значению атрибута запроса.</p>
<p></p>
<h4 id="specifying-a-custom-column-name"><a href="#specifying-a-custom-column-name">Указание настраиваемого имени
        столбца</a></h4>
<p>Вы можете явно указать имя столбца базы данных, которое должно использоваться правилом проверки, поместив его после
    имени таблицы базы данных:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'state'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'exists:states,abbreviation'</span></code></pre>
<p>Иногда может потребоваться указать конкретное соединение с базой данных, которое будет использоваться для <code>exists</code> запроса.
    Вы можете сделать это, добавив имя подключения к имени таблицы:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'exists:connection.staff,email'</span></code></pre>
<p>Вместо того, чтобы указывать имя таблицы напрямую, вы можете указать модель Eloquent, которая должна использоваться
    для определения имени таблицы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token single-quoted-string string">'user_id'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'exists:App\Models\User,id'</span></code></pre>
<p>Если вы хотите настроить запрос, выполняемый правилом проверки, вы можете использовать <code>Rule</code> класс для
    плавного определения правила. В этом примере мы также укажем правила проверки в виде массива вместо использования
    <code>|</code> символа для их разделения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span
                    class="token punctuation">\</span>Validator</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Validation<span
                    class="token punctuation">\</span>Rule</span><span class="token punctuation">;</span>

Validator<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">make</span><span
                class="token punctuation">(</span><span class="token variable">$data</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'required'</span><span class="token punctuation">,</span>
        Rule<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">exists</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'staff'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$query</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> <span class="token variable">$query</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">where</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'account_id'</span><span class="token punctuation">,</span> <span class="token number">1</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="rule-file"><a href="#rule-file">file</a></h4>
<p>Проверяемое поле должно быть успешно загруженным файлом.</p>
<p></p>
<h4 id="rule-filled"><a href="#rule-filled">filled</a></h4>
<p>Проверяемое поле не должно быть пустым, если оно присутствует.</p>
<p></p>
<h4 id="rule-gt"><a href="#rule-gt">gt:<em>field</em></a></h4>
<p>Проверяемое поле должно быть больше заданного <em>поля</em>. Два поля должны быть одного типа. Строки, числа,
    массивы и файлы оцениваются с использованием тех же соглашений, что и <a
            href="validation#rule-size"><code>size</code></a>правило.</p>
<p></p>
<h4 id="rule-gte"><a href="#rule-gte">gte:<em>field</em></a></h4>
<p>Проверяемое поле должно быть больше или равно заданному <em>полю</em>. Два поля должны быть одного типа. Строки,
    числа, массивы и файлы оцениваются с использованием тех же соглашений, что и <a href="validation#rule-size"><code>size</code></a>правило.
</p>
<p></p>
<h4 id="rule-image"><a href="#rule-image">image</a></h4>
<p>Проверяемый файл должен быть изображением (jpg, jpeg, png, bmp, gif, svg или webp).</p>
<p></p>
<h4 id="rule-in"><a href="#rule-in">in:<em>foo</em>,<em>bar</em>,...</a></h4>
<p>Проверяемое поле должно быть включено в указанный список значений. Поскольку это правило часто требует от вас <code>implode</code> наличия
    массива, этот <code>Rule::in</code> метод может быть использован для плавного построения правила:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span
                    class="token punctuation">\</span>Validator</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Validation<span
                    class="token punctuation">\</span>Rule</span><span class="token punctuation">;</span>

Validator<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">make</span><span
                class="token punctuation">(</span><span class="token variable">$data</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'zones'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'required'</span><span class="token punctuation">,</span>
        Rule<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">in</span><span class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'first-zone'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'second-zone'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="rule-in-array"><a href="#rule-in-array">in_array:<em>anotherfield</em>.*</a></h4>
<p>Проверяемое поле должно существовать в значениях <em>другого</em> поля.</p>
<p></p>
<h4 id="rule-integer"><a href="#rule-integer">integer</a></h4>
<p>Проверяемое поле должно быть целым числом.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p> Это правило проверки не проверяет, что ввод относится к типу переменной «integer», а только то, что ввод
            является строковым или числовым значением, содержащим целое число.</p></p></div>
</blockquote>
<p></p>
<h4 id="rule-ip"><a href="#rule-ip">ip</a></h4>
<p>Проверяемое поле должно быть IP-адресом.</p>
<p></p>
<h4 id="ipv4"><a href="#ipv4">ipv4</a></h4>
<p>Проверяемое поле должно быть адресом IPv4.</p>
<p></p>
<h4 id="ipv6"><a href="#ipv6">ipv6</a></h4>
<p>Проверяемое поле должно быть адресом IPv6.</p>
<p></p>
<h4 id="rule-json"><a href="#rule-json">json</a></h4>
<p>Проверяемое поле должно быть допустимой строкой JSON.</p>
<p></p>
<h4 id="rule-lt"><a href="#rule-lt">lt:<em>field</em></a></h4>
<p>Проверяемое поле должно быть меньше указанного <em>поля</em>. Два поля должны быть одного типа. Строки, числа,
    массивы и файлы оцениваются с использованием тех же соглашений, что и <a
            href="validation#rule-size"><code>size</code></a>правило.</p>
<p></p>
<h4 id="rule-lte"><a href="#rule-lte">lte:<em>field</em></a></h4>
<p>Проверяемое поле должно быть меньше или равно заданному <em>полю</em>. Два поля должны быть одного типа. Строки,
    числа, массивы и файлы оцениваются с использованием тех же соглашений, что и <a href="validation#rule-size"><code>size</code></a>правило.
</p>
<p></p>
<h4 id="rule-max"><a href="#rule-max">max:<em>value</em></a></h4>
<p>Проверяемое поле должно быть меньше или равно максимальному <em>значению</em>. Строки, числа, массивы и файлы
    оцениваются так же, как и <a href="validation#rule-size"><code>size</code></a>правило.</p>
<p></p>
<h4 id="rule-mimetypes"><a href="#rule-mimetypes">mimetypes:<em>text/plain</em>,...</a></h4>
<p>Проверяемый файл должен соответствовать одному из указанных типов MIME:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'video'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'mimetypes:video/avi,video/mpeg,video/quicktime'</span></code></pre>
<p>Чтобы определить MIME-тип загруженного файла, содержимое файла будет прочитано, и платформа попытается угадать тип
    MIME, который может отличаться от типа MIME, предоставленного клиентом.</p>
<p></p>
<h4 id="rule-mimes"><a href="#rule-mimes">mimes:<em>foo</em>,<em>bar</em>,...</a></h4>
<p>Проверяемый файл должен иметь тип MIME, соответствующий одному из перечисленных расширений.</p>
<p></p>
<h4 id="basic-usage-of-mime-rule"><a href="#basic-usage-of-mime-rule">Основное использование правила MIME</a></h4>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'photo'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'mimes:jpg,bmp,png'</span></code></pre>
<p>Несмотря на то, что вам нужно только указать расширения, это правило фактически проверяет MIME-тип файла, читая его
    содержимое и угадывая его MIME-тип. Полный список типов MIME и их соответствующих расширений можно найти
    <a href="https://svn.apache.org/repos/asf/httpd/httpd/trunk/docs/conf/mime.types" target="_blank">тут</a>.</p>
<p></p>
<h4 id="rule-min"><a href="#rule-min">min:<em>value</em></a></h4>
<p>Проверяемое поле должно иметь минимальное <em>значение</em>. Строки, числа, массивы и файлы оцениваются так же, как
    и <a href="validation#rule-size"><code>size</code></a>правило.</p>
<p></p>
<h4 id="multiple-of"><a href="#multiple-of">multiple_of:<em>value</em></a></h4>
<p>Проверяемое поле должно быть кратным <em>значению</em>.</p>
<p></p>
<h4 id="rule-not-in"><a href="#rule-not-in">not_in:<em>foo</em>,<em>bar</em>,...</a></h4>
<p>Проверяемое поле не должно быть включено в данный список значений. Этот <code>Rule::notIn</code> метод можно
    использовать для плавного построения правила:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Validation<span
                    class="token punctuation">\</span>Rule</span><span class="token punctuation">;</span>

Validator<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">make</span><span
                class="token punctuation">(</span><span class="token variable">$data</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'toppings'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'required'</span><span class="token punctuation">,</span>
        Rule<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">notIn</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span
                class="token single-quoted-string string">'sprinkles'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'cherries'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="rule-not-regex"><a href="#rule-not-regex">not_regex:<em>pattern</em></a></h4>
<p>Проверяемое поле не должно соответствовать заданному регулярному выражению.</p>
<p>Внутри это правило использует <code>preg_match</code> функцию PHP. Указанный шаблон должен соответствовать тому же
    форматированию, что и требуется, <code>preg_match</code> и, следовательно, также включать допустимые разделители.
    Например: <code>'email' =&gt; 'not_regex:/^.+$/i'</code>.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>При использовании шаблонов <code>regex</code> / <code>not_regex</code> может потребоваться указать правила
            проверки с использованием массива вместо использования <code>|</code> разделителей, особенно если регулярное
            выражение содержит <code>|</code> символ.</p></p></div>
</blockquote>
<p></p>
<h4 id="rule-nullable"><a href="#rule-nullable">nullable</a></h4>
<p>Проверяемое поле может быть <code>null</code>.</p>
<p></p>
<h4 id="rule-numeric"><a href="#rule-numeric">numeric</a></h4>
<p>Проверяемое поле должно быть <a href="https://www.php.net/manual/en/function.is-numeric.php">числовым</a>.</p>
<p></p>
<h4 id="rule-password"><a href="#rule-password">password</a></h4>
<p>Проверяемое поле должно соответствовать паролю аутентифицированного пользователя. Вы можете указать защиту <a
            href="authentication">аутентификации,</a> используя первый параметр правила:</p>
<pre class=" language-php"><code class=" language-php"><span class="token single-quoted-string string">'password'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'password:api'</span></code></pre>
<p></p>
<h4 id="rule-present"><a href="#rule-present">present</a></h4>
<p>Проверяемое поле должно присутствовать во входных данных, но может быть пустым.</p>
<p></p>
<h4 id="rule-regex"><a href="#rule-regex">regex:<em>pattern</em></a></h4>
<p>Проверяемое поле должно соответствовать заданному регулярному выражению.</p>
<p>Внутри это правило использует <code>preg_match</code> функцию PHP. Указанный шаблон должен соответствовать тому же
    форматированию, что и требуется, <code>preg_match</code> и, следовательно, также включать допустимые разделители.
    Например: <code>'email' =&gt; 'regex:/^.+@.+$/i'</code>.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>При использовании шаблонов <code>regex</code> / <code>not_regex</code> может потребоваться указать правила в
            массиве вместо использования <code>|</code> разделителей, особенно если регулярное выражение содержит
            <code>|</code> символ.</p></p></div>
</blockquote>
<p></p>
<h4 id="rule-required"><a href="#rule-required">required</a></h4>
<p>Проверяемое поле должно присутствовать во входных данных и не быть пустым. Поле считается «пустым», если выполняется
    одно из следующих условий:</p>
<div class="content-list">
    <ul>
        <li>Стоимость есть <code>null</code>.</li>
        <li>Значение - пустая строка.</li>
        <li>Значение - пустой массив или пустой <code>Countable</code> объект.</li>
        <li>Значение - загруженный файл без пути.</li>
    </ul>
</div>
<p></p>
<h4 id="rule-required-if"><a href="#rule-required-if">required_if:<em>anotherfield</em>,<em>value</em>,...</a>
</h4>
<p>Проверяемое поле должно присутствовать и не быть пустым, если поле <em>anotherfield</em> равно любому
    <em>value</em>.</p>
<p>Если вы хотите построить более сложное условие для <code>required_if</code> правила, вы можете использовать этот
    <code>Rule::requiredIf</code> метод. Этот метод принимает логическое значение или закрытие. При прохождении закрытия
    закрытие должно возвращаться <code>true</code> или <code>false</code> указывать, требуется ли проверяемое поле:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span
                    class="token punctuation">\</span>Validator</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Validation<span
                    class="token punctuation">\</span>Rule</span><span class="token punctuation">;</span>

Validator<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">make</span><span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span>
    <span class="token single-quoted-string string">'role_id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> Rule<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">requiredIf</span><span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">user</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">is_admin</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

Validator<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">make</span><span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span>
    <span class="token single-quoted-string string">'role_id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> Rule<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">requiredIf</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token keyword">use</span> <span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">user</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">is_admin</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="rule-required-unless"><a href="#rule-required-unless">required_unless:<em>anotherfield</em>,<em>value</em>,...</a></h4>
<p>Проверяемое поле должно присутствовать и не быть пустым, если поле <em>anotherfield</em> не равно какому-либо <em>value</em>.</p>
<p></p>
<h4 id="rule-required-with"><a href="#rule-required-with">required_with:<em>foo</em>,<em>bar</em>,...</a></h4>
<p><em>Проверяемое</em> поле должно присутствовать, а не быть пустым, <em>только если присутствует</em> какое-либо из
    других указанных полей.</p>
<p></p>
<h4 id="rule-required-with-all"><a href="#rule-required-with-all">required_with_all:<em>foo</em>,<em>bar</em>,...</a></h4>
<p><em>Проверяемое</em> поле должно присутствовать, а не быть пустым, <em>только если присутствуют</em> все другие
    указанные поля.</p>
<p></p>
<h4 id="rule-required-without"><a href="#rule-required-without">required_without:<em>foo</em>,<em>bar</em>,...</a>
</h4>
<p>Проверяемое поле должно присутствовать, а не быть пустым <em>только тогда, когда отсутствуют</em> какие-либо другие
    указанные поля.</p>
<p></p>
<h4 id="rule-required-without-all"><a href="#rule-required-without-all">required_without_all:<em>foo</em>,<em>bar</em>,...</a></h4>
<p>Проверяемое поле должно присутствовать, а не быть пустым, <em>только когда</em> все другие указанные поля
    отсутствуют.</p>
<p></p>
<h4 id="rule-same"><a href="#rule-same">same:<em>field</em></a></h4>
<p>Указанное <em>field</em> должно соответствовать проверяемому полю.</p>
<p></p>
<h4 id="rule-size"><a href="#rule-size">size:<em>value</em></a></h4>
<p>Проверяемое поле должно иметь размер, соответствующий заданному <em>значению</em>. Для строковых данных
    <em>значение</em> соответствует количеству символов. Для числовых данных <em>значение</em> соответствует заданному
    целочисленному значению (атрибут также должен иметь правило <code>numeric</code> или <code>integer</code> ). Для
    массива <em>размер</em> соответствует <em>размеру</em><code>count</code>  массива. Для файлов <em>размер</em>
    соответствует размеру файла в килобайтах. Давайте посмотрим на несколько примеров:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">// Validate that a string is exactly 12 characters long...</span>
<span class="token single-quoted-string string">'title'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'size:12'</span><span
                class="token punctuation">;</span>

<span class="token comment">// Validate that a provided integer equals 10...</span>
<span class="token single-quoted-string string">'seats'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'integer|size:10'</span><span
                class="token punctuation">;</span>

<span class="token comment">// Validate that an array has exactly 5 elements...</span>
<span class="token single-quoted-string string">'tags'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'array|size:5'</span><span
                class="token punctuation">;</span>

<span class="token comment">// Validate that an uploaded file is exactly 512 kilobytes...</span>
<span class="token single-quoted-string string">'image'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'file|size:512'</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="rule-starts-with"><a href="#rule-starts-with">start_with:<em>foo</em>,<em>bar</em>,...</a></h4>
<p>Проверяемое поле должно начинаться с одного из указанных значений.</p>
<p></p>
<h4 id="rule-string"><a href="#rule-string">string</a></h4>
<p>Проверяемое поле должно быть строкой. Если вы хотите, чтобы поле тоже было <code>null</code>, вы должны назначить
    <code>nullable</code> этому полю правило.</p>
<p></p>
<h4 id="rule-timezone"><a href="#rule-timezone">timezone</a></h4>
<p>Проверяемое поле должно быть действительным идентификатором часового пояса в соответствии с <code>timezone_identifiers_list</code> функцией
    PHP.</p>
<p></p>
<h4 id="rule-unique"><a href="#rule-unique">unique:<em>table</em>,<em>column</em>,<em>except</em>,<em>idColumn</em></a></h4>
<p>Проверяемое поле не должно существовать в данной таблице базы данных.</p>
<p><strong>Указание настраиваемого имени таблицы / столбца:</strong></p>
<p>Вместо того, чтобы указывать имя таблицы напрямую, вы можете указать модель Eloquent, которая должна использоваться
    для определения имени таблицы:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'unique:App\Models\User,email_address'</span></code></pre>
<p><code>column</code> Вариант может быть использован для определения соответствующего столбца базы данных в полях. Если
    <code>column</code> опция не указана, будет использоваться имя проверяемого поля.</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'unique:users,email_address'</span></code></pre>
<p><strong>Указание настраиваемого подключения к базе данных</strong></p>
<p>Иногда вам может потребоваться настроить индивидуальное соединение для запросов к базе данных, сделанных валидатором.
    Для этого вы можете добавить имя подключения к имени таблицы:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'unique:connection.users,email_address'</span></code></pre>
<p><strong>Принуждение уникального правила игнорировать данный идентификатор:</strong></p>
<p>Иногда вы можете проигнорировать данный идентификатор во время уникальной проверки. Например, рассмотрим экран
    «обновить профиль», который включает имя пользователя, адрес электронной почты и местоположение. Вероятно, вы
    захотите убедиться, что адрес электронной почты уникален. Однако, если пользователь изменяет только поле имени, а не
    поле электронной почты, вы не хотите, чтобы возникала ошибка проверки, поскольку пользователь уже является
    владельцем рассматриваемого адреса электронной почты.</p>
<p>Чтобы указать валидатору игнорировать идентификатор пользователя, мы будем использовать <code>Rule</code> класс для
    плавного определения правила. В этом примере мы также укажем правила проверки в виде массива вместо использования
    <code>|</code> символа для ограничения правил:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span
                    class="token punctuation">\</span>Validator</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Validation<span
                    class="token punctuation">\</span>Rule</span><span class="token punctuation">;</span>

Validator<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">make</span><span
                class="token punctuation">(</span><span class="token variable">$data</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'required'</span><span class="token punctuation">,</span>
        Rule<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">unique</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'users'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">ignore</span><span
                class="token punctuation">(</span><span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">id</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Вы никогда не должны передавать в <code>ignore</code> метод какие-либо запросы, контролируемые пользователем.
            Вместо этого вы должны передавать только сгенерированный системой уникальный идентификатор, такой как
            автоматически увеличивающийся идентификатор или UUID из экземпляра модели Eloquent. В противном случае ваше
            приложение будет уязвимо для атаки с использованием SQL-инъекции.</p></p></div>
</blockquote>
<p>Вместо того, чтобы передавать значение ключа модели <code>ignore</code> методу, вы также можете передать весь
    экземпляр модели. Laravel автоматически извлечет ключ из модели:</p>
<pre class=" language-php"><code class=" language-php">Rule<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">unique</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">ignore</span><span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span></code></pre>
<p>Если ваша таблица использует имя столбца первичного ключа, отличное от <code>id</code>, вы можете указать имя столбца
    при вызове <code>ignore</code> метода:</p>
<pre class=" language-php"><code class=" language-php">Rule<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">unique</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">ignore</span><span
                class="token punctuation">(</span><span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">id</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'user_id'</span><span
                class="token punctuation">)</span></code></pre>
<p>По умолчанию <code>unique</code> правило проверяет уникальность столбца, совпадающего с именем проверяемого атрибута.
    Однако вы можете передать другое имя столбца в качестве второго аргумента <code>unique</code> метода:</p>
<pre class=" language-php"><code class=" language-php">Rule<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">unique</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'email_address'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">ignore</span><span
                class="token punctuation">(</span><span class="token variable">$user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">id</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span></code></pre>
<p><strong>Добавление дополнительных предложений Where:</strong></p>
<p>Вы можете указать дополнительные условия запроса, настроив запрос с помощью <code>where</code> метода. Например,
    давайте добавим условие запроса, которое ограничивает область действия запроса только поисковыми записями, которые
    имеют <code>account_id</code> значение столбца <code>1</code> :</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> Rule<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">unique</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$query</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$query</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">where</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'account_id'</span><span class="token punctuation">,</span> <span class="token number">1</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span></code></pre>
<p></p>
<h4 id="rule-url"><a href="#rule-url">url</a></h4>
<p>Проверяемое поле должно быть действительным URL.</p>
<p></p>
<h4 id="rule-uuid"><a href="#rule-uuid">uuid</a></h4>
<p>Проверяемое поле должно быть действительным универсальным уникальным идентификатором (UUID) RFC 4122 (версии 1, 3, 4
    или 5).</p>
<p></p>
<h2 id="conditionally-adding-rules"><a href="#conditionally-adding-rules">Условное добавление правил</a></h2>
<p></p>
<h4 id="skipping-validation-when-fields-have-certain-values"><a
            href="#skipping-validation-when-fields-have-certain-values">Пропуск проверки, когда поля имеют определенные
        значения</a></h4>
<p>Иногда вы можете захотеть не проверять данное поле, если другое поле имеет заданное значение. Вы можете сделать это с
    помощью <code>exclude_if</code> правила проверки. В этом примере, <code>appointment_date</code> и
    <code>doctor_name</code> поля не будут проверяться, если <code>has_appointment</code> поле имеет значение
    <code>false</code> :</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span
                    class="token punctuation">\</span>Validator</span><span class="token punctuation">;</span>

<span class="token variable">$validator</span> <span class="token operator">=</span> Validator<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">make</span><span
                class="token punctuation">(</span><span class="token variable">$data</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'has_appointment'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'required|bool'</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'appointment_date'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'exclude_if:has_appointment,false|required|date'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'doctor_name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'exclude_if:has_appointment,false|required|string'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>В качестве альтернативы вы можете использовать <code>exclude_unless</code> правило, чтобы не проверять данное поле,
    если другое поле не имеет заданного значения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$validator</span> <span
                class="token operator">=</span> Validator<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">make</span><span
                class="token punctuation">(</span><span class="token variable">$data</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'has_appointment'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'required|bool'</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'appointment_date'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'exclude_unless:has_appointment,true|required|date'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'doctor_name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'exclude_unless:has_appointment,true|required|string'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="validating-when-present"><a href="#validating-when-present">Проверка при наличии</a></h4>
<p>В некоторых ситуациях вы можете захотеть выполнить проверки для поля, <strong>только</strong> если это поле
    присутствует в проверяемых данных. Чтобы быстро добиться этого, добавьте <code>sometimes</code> правило в свой список
    правил:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$v</span> <span
                class="token operator">=</span> Validator<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">make</span><span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span>
    <span class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'sometimes|required|email'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>В приведенном выше примере <code>email</code> поле будет проверяться, только если оно присутствует в
    <code>$data</code> массиве.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Если вы пытаетесь проверить поле, которое всегда должно присутствовать, но может быть пустым, ознакомьтесь с
            <a href="validation#a-note-on-optional-fields">этим примечанием о дополнительных полях.</a></p></p></div>
</blockquote>
<p></p>
<h4 id="complex-conditional-validation"><a href="#complex-conditional-validation">Комплексная условная проверка</a></h4>
<p>Иногда вы можете добавить правила проверки, основанные на более сложной условной логике. Например, вы можете
    потребовать заданное поле только в том случае, если другое поле имеет значение больше 100. Или вам может
    потребоваться, чтобы два поля имели заданное значение только при наличии другого поля. Добавление этих правил
    проверки не должно вызывать затруднений. Сначала создайте <code>Validator</code> экземпляр со своими <em>статическими
        правилами,</em> которые никогда не меняются:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span
                    class="token punctuation">\</span>Validator</span><span class="token punctuation">;</span>

<span class="token variable">$validator</span> <span class="token operator">=</span> Validator<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">make</span><span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span>
    <span class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'required|email'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'games'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'required|numeric'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Предположим, наше веб-приложение предназначено для коллекционеров игр. Если коллекционер игр регистрируется в нашем
    приложении и у него есть более 100 игр, мы хотим, чтобы он объяснил, почему у него так много игр. Например,
    возможно, они владеют магазином по перепродаже игр или, может быть, им просто нравится коллекционировать игры. Чтобы
    условно добавить это требование, мы можем использовать <code>sometimes</code> метод в <code>Validator</code> экземпляре.
</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$v</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">sometimes</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'reason'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'required|max:500'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$input</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$input</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">games</span> <span class="token operator">&gt;=</span> <span class="token number">100</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Первым аргументом, передаваемым <code>sometimes</code> методу, является имя поля, которое мы условно проверяем. Второй
    аргумент - это список правил, которые мы хотим добавить. Если закрытие, переданное в качестве третьего аргумента,
    возвращается <code>true</code>, правила будут добавлены. Этот метод упрощает создание сложных условных проверок. Вы
    даже можете добавить условные проверки сразу для нескольких полей:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$v</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">sometimes</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'reason'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'cost'</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'required'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$input</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$input</span><span class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">games</span> <span class="token operator">&gt;=</span> <span class="token number">100</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p><code>$input</code> Параметр, переданный ваше закрытие будет экземпляром
            <code>Illuminate\Support\Fluent</code> и может быть использован для доступа ввода и хранение файлов в
            проверке.</p></p></div>
</blockquote>
<p></p>
<h2 id="validating-arrays"><a href="#validating-arrays">Проверка массивов</a></h2>
<p>Проверка полей ввода формы на основе массива не должна быть проблемой. Вы можете использовать "точечную нотацию" для
    проверки атрибутов в массиве. Например, если входящий HTTP-запрос содержит <code>photos[profile]</code> поле, вы
    можете проверить его следующим образом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span
                    class="token punctuation">\</span>Validator</span><span class="token punctuation">;</span>

<span class="token variable">$validator</span> <span class="token operator">=</span> Validator<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">make</span><span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span>
    <span class="token single-quoted-string string">'photos.profile'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'required|image'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы также можете проверить каждый элемент массива. Например, чтобы убедиться, что каждое электронное письмо в заданном
    поле ввода массива уникально, вы можете сделать следующее:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$validator</span> <span
                class="token operator">=</span> Validator<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">make</span><span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span>
    <span class="token single-quoted-string string">'person.*.email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'email|unique:users'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'person.*.first_name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'required_with:person.*.last_name'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Точно так же вы можете использовать <code>*</code> символ при указании <a
            href="validation#custom-messages-for-specific-attributes">пользовательских сообщений проверки в ваших
        языковых файлах</a>, что упрощает использование одного сообщения проверки для полей на основе массива:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'custom'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'person.*.email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'unique'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'Each person must have a unique email address'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p></p>
<h2 id="custom-validation-rules"><a href="#custom-validation-rules">Пользовательские правила проверки</a></h2>
<p></p>
<h3 id="using-rule-objects"><a href="#using-rule-objects">Использование объектов правила</a></h3>
<p>Laravel предоставляет множество полезных правил проверки; однако вы можете указать свои собственные. Один из методов
    регистрации настраиваемых правил проверки - использование объектов правил. Чтобы создать новый объект правила, вы
    можете использовать команду <code>make:rule</code> Artisan. Давайте воспользуемся этой командой, чтобы сгенерировать
    правило, которое проверяет, что строка является прописной. Laravel поместит новое правило в <code>app/Rules</code> каталог.
    Если этот каталог не существует, Laravel создаст его, когда вы выполните команду Artisan для создания своего
    правила:</p>
<pre class=" language-php"><code class=" language-php">php artisan make<span class="token punctuation">:</span>rule Uppercase</code></pre>
<p>Как только правило создано, мы готовы определить его поведение. Объект правила содержит два метода:
    <code>passes</code> и <code>message</code>. <code>passes</code> Метод получает значение атрибута и имя, и он должен
    возвращать <code>true</code> или в <code>false</code> зависимости от того, является ли или нет значение атрибута.
    <code>message</code> Метод должен возвращать сообщение об ошибке проверки, которая должна использоваться при сбое
    проверки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Rules</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Validation<span
                        class="token punctuation">\</span>Rule</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">Uppercase</span> <span class="token keyword">implements</span> <span
                    class="token class-name">Rule</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Determine if the validation rule passes.
    *
    * @param  string  $attribute
    * @param  mixed  $value
    * @return bool
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">passes</span><span class="token punctuation">(</span><span class="token variable">$attribute</span><span class="token punctuation">,</span> <span class="token variable">$value</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token function">strtoupper</span><span class="token punctuation">(</span><span class="token variable">$value</span><span class="token punctuation">)</span> <span class="token operator">===</span> <span class="token variable">$value</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
    * Get the validation error message.
    *
    * @return string
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">message</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token single-quoted-string string">'The :attribute must be uppercase.'</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Вы можете вызвать <code>trans</code> помощника из своего <code>message</code> метода, если хотите вернуть сообщение об
    ошибке из файлов перевода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the validation error message.
 *
 * @return string
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">message</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token function">trans</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'validation.uppercase'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>После определения правила вы можете прикрепить его к валидатору, передав экземпляр объекта правила с другими вашими
    правилами валидации:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Rules<span
                    class="token punctuation">\</span>Uppercase</span><span class="token punctuation">;</span>

<span class="token variable">$request</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">validate</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'required'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'string'</span><span
                class="token punctuation">,</span> <span class="token keyword">new</span> <span
                class="token class-name">Uppercase</span><span class="token punctuation">]</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="using-closures"><a href="#using-closures">Использование замыканий</a></h3>
<p>Если вам нужна функциональность настраиваемого правила только один раз во всем приложении, вы можете использовать
    замыкание вместо объекта правила. Замыкание получает имя атрибута, значение атрибута и <code>$fail</code> обратный
    вызов, который должен быть вызван, если проверка не удалась:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span
                    class="token punctuation">\</span>Validator</span><span class="token punctuation">;</span>

<span class="token variable">$validator</span> <span class="token operator">=</span> Validator<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">make</span><span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span>
    <span class="token single-quoted-string string">'title'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'required'</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'max:255'</span><span class="token punctuation">,</span>
        <span class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token variable">$attribute</span><span class="token punctuation">,</span> <span
                class="token variable">$value</span><span class="token punctuation">,</span> <span
                class="token variable">$fail</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token variable">$value</span> <span class="token operator">===</span> <span class="token single-quoted-string string">'foo'</span><span class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
                <span class="token variable">$fail</span><span class="token punctuation">(</span><span class="token single-quoted-string string">'The '</span><span class="token punctuation">.</span><span class="token variable">$attribute</span><span class="token punctuation">.</span><span class="token single-quoted-string string">' is invalid.'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
            <span class="token punctuation">}</span>
        <span class="token punctuation">}</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="implicit-rules"><a href="#implicit-rules">Неявные правила</a></h3>
<p>По умолчанию, когда проверяемый атрибут отсутствует или содержит пустую строку, обычные правила проверки, включая
    настраиваемые правила, не выполняются. Например, <a href="validation#rule-unique"><code>unique</code></a>правило не
    будет работать с пустой строкой:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span
                    class="token punctuation">\</span>Validator</span><span class="token punctuation">;</span>

<span class="token variable">$rules</span> <span class="token operator">=</span> <span
                class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'unique:users,name'</span><span
                class="token punctuation">]</span><span class="token punctuation">;</span>

<span class="token variable">$input</span> <span class="token operator">=</span> <span
                class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">''</span><span class="token punctuation">]</span><span
                class="token punctuation">;</span>

Validator<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">make</span><span
                class="token punctuation">(</span><span class="token variable">$input</span><span
                class="token punctuation">,</span> <span class="token variable">$rules</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">passes</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span> <span class="token comment">// true</span></code></pre>
<p>Чтобы настраиваемое правило работало, даже если атрибут пуст, правило должно подразумевать, что атрибут является
    обязательным. Чтобы создать «неявное» правило, реализуйте <code>Illuminate\Contracts\Validation\ImplicitRule</code> интерфейс.
    Этот интерфейс служит «маркерным интерфейсом» для валидатора; следовательно, он не содержит каких-либо
    дополнительных методов, которые необходимо реализовать помимо методов, требуемых типичным <code>Rule</code> интерфейсом.
</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>«Неявное» правило <em>подразумевает</em> только то, что атрибут является обязательным. Независимо от того,
            аннулирует ли он отсутствующий или пустой атрибут, решать вам.</p></p></div>
</blockquote> 
