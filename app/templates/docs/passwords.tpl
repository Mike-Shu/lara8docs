<h1>Сброс паролей <sup>Resetting passwords</sup></h1>
<ul>
    <li><a href="passwords#introduction">Вступление</a>
        <ul>
            <li><a href="passwords#model-preparation">Подготовка модели</a></li>
            <li><a href="passwords#database-preparation">Подготовка базы данных</a></li>
        </ul>
    </li>
    <li><a href="passwords#routing">Маршрутизация</a>
        <ul>
            <li><a href="passwords#requesting-the-password-reset-link">Запрос ссылки для сброса пароля</a></li>
            <li><a href="passwords#resetting-the-password">Сброс пароля</a></li>
        </ul>
    </li>
    <li><a href="passwords#password-customization">Настройка</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Большинство веб-приложений предоставляют пользователям возможность сбросить забытые пароли. Вместо того, чтобы
    заставлять вас заново реализовывать это вручную для каждого создаваемого вами приложения, Laravel предоставляет
    удобные сервисы для отправки ссылок для сброса пароля и безопасного сброса паролей.</p>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Хотите быстро приступить к работе? Установите <a href="starter-kits">стартовый комплект приложения</a>
            Laravel в новое приложение Laravel. Стартовые комплекты Laravel позаботятся о выстраивании всей вашей
            системы аутентификации, включая сброс забытых паролей.</p></p></div>
</blockquote>
<p></p>
<h3 id="model-preparation"><a href="#model-preparation">Подготовка модели</a></h3>
<p>Перед использованием функций сброса пароля Laravel <code>App\Models\User</code> модель вашего приложения должна
    использовать эту <code>Illuminate\Notifications\Notifiable</code> черту. Обычно эта черта уже включена в <code>App\Models\User</code>
    модель по умолчанию, которая создается с новыми приложениями Laravel.</p>
<p>Затем убедитесь, что ваша <code>App\Models\User</code> модель реализует <code>Illuminate\Contracts\Auth\CanResetPassword</code>
    контракт. <code>App\Models\User</code> Модель входит в рамках уже реализует этот интерфейс, и использует <code>Illuminate\Auth\Passwords\CanResetPassword</code>
    признак, чтобы включать в себя методы, необходимые для реализации интерфейса.</p>
<p></p>
<h3 id="database-preparation"><a href="#database-preparation">Подготовка базы данных</a></h3>
<p>Необходимо создать таблицу для хранения токенов сброса пароля вашего приложения. Миграция для этой таблицы включена в
    приложение Laravel по умолчанию, поэтому вам нужно только перенести вашу базу данных, чтобы создать эту таблицу:</p>
<pre class=" language-php"><code class=" language-php">php artisan migrate</code></pre>
<p></p>
<h2 id="routing"><a href="#routing">Маршрутизация</a></h2>
<p>Чтобы правильно реализовать поддержку, позволяющую пользователям сбрасывать свои пароли, нам нужно будет определить
    несколько маршрутов. Во-первых, нам понадобится пара маршрутов для обработки, позволяющая пользователю запрашивать
    ссылку для сброса пароля через свой адрес электронной почты. Во-вторых, нам понадобится пара маршрутов для обработки
    фактического сброса пароля после того, как пользователь посетит ссылку для сброса пароля, отправленную ему по
    электронной почте, и заполнит форму сброса пароля.</p>
<p></p>
<h3 id="requesting-the-password-reset-link"><a href="#requesting-the-password-reset-link">Запрос ссылки для сброса
        пароля</a></h3>
<p></p>
<h4 id="the-password-reset-link-request-form"><a href="#the-password-reset-link-request-form">Форма запроса ссылки для
        сброса пароля</a></h4>
<p>Сначала мы определим маршруты, которые необходимы для запроса ссылок для сброса пароля. Для начала мы определим
    маршрут, который возвращает представление с формой запроса ссылки для сброса пароля:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'/forgot-password'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token function">view</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'auth.forgot-password'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">middleware</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'guest'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">name</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'password.request'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Представление, возвращаемое этим маршрутом, должно иметь форму, содержащую <code>email</code> поле, которое позволит
    пользователю запрашивать ссылку для сброса пароля для данного адреса электронной почты.</p>
<p></p>
<h4 id="password-reset-link-handling-the-form-submission"><a href="#password-reset-link-handling-the-form-submission">Обработка
        отправки формы</a></h4>
<p>Затем мы определим маршрут, который обрабатывает запрос на отправку формы из представления «забытый пароль». Этот
    маршрут будет отвечать за проверку адреса электронной почты и отправку запроса на сброс пароля соответствующему
    пользователю:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span
                    class="token punctuation">\</span>Password</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">post</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/forgot-password'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>Request <span class="token variable">$request</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$request</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">validate</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'required|email'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
            
    <span class="token variable">$status</span> <span class="token operator">=</span> Password<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">sendResetLink</span><span
                class="token punctuation">(</span>
        <span class="token variable">$request</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">only</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'email'</span><span
                class="token punctuation">)</span>
    <span class="token punctuation">)</span><span class="token punctuation">;</span>
            
    <span class="token keyword">return</span> <span class="token variable">$status</span> <span
                class="token operator">===</span> Password<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token constant">RESET_LINK_SENT</span>
        <span class="token operator">?</span> <span class="token function">back</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">with</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'status'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token function">__</span><span class="token punctuation">(</span><span class="token variable">$status</span><span
                class="token punctuation">)</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span>
        <span class="token punctuation">:</span> <span class="token function">back</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">withErrors</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">__</span><span
                class="token punctuation">(</span><span class="token variable">$status</span><span
                class="token punctuation">)</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">middleware</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'guest'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">name</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'password.email'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Прежде чем двигаться дальше, давайте рассмотрим этот маршрут более подробно. Сначала <code>email</code> проверяется
    атрибут запроса. Затем мы будем использовать встроенный в Laravel «брокер паролей» (через <code>Password</code>
    фасад), чтобы отправить пользователю ссылку для сброса пароля. Брокер паролей позаботится о получении пользователя
    по заданному полю (в данном случае по адресу электронной почты) и отправит пользователю ссылку для сброса пароля
    через встроенную <a href="notifications">систему уведомлений</a> Laravel.</p>
<p><code>sendResetLink</code> Метод возвращает «статус» слизняк. Этот статус может быть переведен с помощью помощников
    по <a href="localization">локализации</a> Laravel, чтобы отобразить удобное для пользователя сообщение о статусе его
    запроса. Перевод статуса сброса пароля определяется <code>resources/lang/{literal}{lang}{/literal}/passwords.php</code> языковым файлом
    вашего приложения. Запись для каждого возможного значения ярлыка состояния находится в <code>passwords</code>
    языковом файле.</p>
<p>Вам может быть интересно, как Laravel знает, как получить запись пользователя из базы данных вашего приложения при
    вызове метода <code>Password</code> фасада <code>sendResetLink</code>. Брокер паролей Laravel использует
    "поставщиков пользователей" вашей системы аутентификации для получения записей из базы данных. Пользовательский
    провайдер, используемый брокером паролей, настраивается в <code>passwords</code> массиве
    <code>config/auth.php</code> конфигурации вашего файла конфигурации. Чтобы узнать больше о написании
    пользовательских провайдеров, обратитесь к <a href="authentication#adding-custom-user-providers">документации</a> по
    <a href="authentication#adding-custom-user-providers">аутентификации.</a></p>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>При выполнении сброса пароля вручную вы должны сами определять содержимое представлений и маршрутов. Если вам
            нужны строительные леса, включающие всю необходимую логику аутентификации и проверки, ознакомьтесь со <a
                    href="starter-kits">стартовыми наборами приложений Laravel</a>.</p></p></div>
</blockquote>
<p></p>
<h3 id="resetting-the-password"><a href="#resetting-the-password">Сброс пароля</a></h3>
<p></p>
<h4 id="the-password-reset-form"><a href="#the-password-reset-form">Форма сброса пароля</a></h4>
<p>Затем мы определим маршруты, необходимые для фактического сброса пароля после того, как пользователь щелкнет ссылку
    для сброса пароля, отправленную ему по электронной почте, и предоставит новый пароль. Во-первых, давайте определим
    маршрут, который будет отображать форму сброса пароля, которая отображается, когда пользователь щелкает ссылку
    сброса пароля. Этот маршрут получит <code>token</code> параметр, который мы будем использовать позже для проверки
    запроса на сброс пароля:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'/reset-password/{literal}{token}{/literal}'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$token</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token function">view</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'auth.reset-password'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'token'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$token</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">middleware</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'guest'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">name</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'password.reset'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Представление, возвращаемое этим маршрутом, должно отображать форму, содержащую <code>email</code> поле, <code>password</code>
    поле, <code>password_confirmation</code> поле и скрытое <code>token</code> поле, которое должно содержать значение
    секрета, <code>$token</code> полученного нашим маршрутом.</p>
<p></p>
<h4 id="password-reset-handling-the-form-submission"><a href="#password-reset-handling-the-form-submission">Обработка
        отправки формы</a></h4>
<p>Конечно, нам нужно определить маршрут для фактической обработки отправки формы сброса пароля. Этот маршрут будет
    отвечать за проверку входящего запроса и обновление пароля пользователя в базе данных:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Auth<span
                    class="token punctuation">\</span>Events<span class="token punctuation">\</span>PasswordReset</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Hash</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span
                    class="token punctuation">\</span>Password</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">post</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/reset-password'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>Request <span class="token variable">$request</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$request</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">validate</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'token'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'required'</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'required|email'</span><span
                class="token punctuation">,</span>
        <span class="token single-quoted-string string">'password'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'required|min:8|confirmed'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
            
    <span class="token variable">$status</span> <span class="token operator">=</span> Password<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">reset</span><span
                class="token punctuation">(</span>
        <span class="token variable">$request</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">only</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'email'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'password'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'password_confirmation'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'token'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
        <span class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token variable">$user</span><span class="token punctuation">,</span> <span
                class="token variable">$password</span><span class="token punctuation">)</span> <span
                class="token keyword">use</span> <span class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token variable">$user</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">forceFill</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span>
                <span class="token single-quoted-string string">'password'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> Hash<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">make</span><span
                class="token punctuation">(</span><span class="token variable">$password</span><span
                class="token punctuation">)</span>
            <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">save</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
            
            <span class="token variable">$user</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">setRememberToken</span><span class="token punctuation">(</span>Str<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">random</span><span
                class="token punctuation">(</span><span class="token number">60</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
            
            <span class="token function">event</span><span class="token punctuation">(</span><span
                class="token keyword">new</span> <span class="token class-name">PasswordReset</span><span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
        <span class="token punctuation">}</span>
    <span class="token punctuation">)</span><span class="token punctuation">;</span>
            
    <span class="token keyword">return</span> <span class="token variable">$status</span> <span
                class="token operator">==</span> Password<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token constant">PASSWORD_RESET</span>
        <span class="token operator">?</span> <span class="token function">redirect</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">route</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'login'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">with</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'status'</span><span
                class="token punctuation">,</span> <span class="token function">__</span><span
                class="token punctuation">(</span><span class="token variable">$status</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span>
        <span class="token punctuation">:</span> <span class="token function">back</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">withErrors</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span class="token function">__</span><span
                class="token punctuation">(</span><span class="token variable">$status</span><span
                class="token punctuation">)</span><span class="token punctuation">]</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">middleware</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'guest'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">name</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'password.update'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Прежде чем двигаться дальше, давайте рассмотрим этот маршрут более подробно. Во-первых, запрос в <code>token</code>,
    <code>email</code> и <code>password</code> атрибуты проверяются. Затем мы будем использовать встроенный в Laravel
    «брокер паролей» (через <code>Password</code> фасад) для проверки учетных данных запроса сброса пароля.</p>
<p>Если токен, адрес электронной почты и пароль, данные брокеру паролей, действительны, <code>reset</code> будет вызвано
    закрытие, переданное методу. В рамках этого закрытия, которое получает экземпляр пользователя и пароль в виде
    обычного текста, предоставленный для формы сброса пароля, мы можем обновить пароль пользователя в базе данных.</p>
<p><code>reset</code> Метод возвращает «статус» слизняк. Этот статус может быть переведен с помощью помощников по <a
            href="localization">локализации</a> Laravel, чтобы отобразить удобное для пользователя сообщение о статусе
    его запроса. Перевод статуса сброса пароля определяется <code>resources/lang/{literal}{lang}{/literal}/passwords.php</code> языковым
    файлом вашего приложения. Запись для каждого возможного значения ярлыка состояния находится в <code>passwords</code>
    языковом файле.</p>
<p>Прежде чем двигаться дальше, вам может быть интересно, как Laravel знает, как получить запись пользователя из базы
    данных вашего приложения при вызове метода <code>Password</code> фасада <code>reset</code>. Брокер паролей Laravel
    использует "поставщиков пользователей" вашей системы аутентификации для получения записей из базы данных.
    Пользовательский провайдер, используемый брокером паролей, настраивается в <code>passwords</code> массиве <code>config/auth.php</code>
    конфигурации вашего файла конфигурации. Чтобы узнать больше о написании пользовательских провайдеров, обратитесь к
    <a href="authentication#adding-custom-user-providers">документации</a> по <a
            href="authentication#adding-custom-user-providers">аутентификации.</a></p>
<p></p>
<h2 id="password-customization"><a href="#password-customization">Настройка</a></h2>
<p></p>
<h4 id="reset-link-customization"><a href="#reset-link-customization">Сбросить настройки ссылки</a></h4>
<p>Вы можете настроить URL-адрес ссылки для сброса пароля, используя <code>createUrlUsing</code> метод, предоставленный
    <code>ResetPassword</code> классом уведомления. Этот метод принимает закрытие, которое получает пользовательский
    экземпляр, получающий уведомление, а также токен ссылки для сброса пароля. Обычно этот метод следует вызывать из
    метода <code>App\Providers\AuthServiceProvider</code> поставщика услуг <code>boot</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Auth<span
                    class="token punctuation">\</span>Notifications<span class="token punctuation">\</span>ResetPassword</span><span
                class="token punctuation">;</span>

<span class="token comment">/**
 * Register any authentication / authorization services.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">boot</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">registerPolicies</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    
    ResetPassword<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">createUrlUsing</span><span class="token punctuation">(</span><span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token variable">$user</span><span class="token punctuation">,</span> string <span
                class="token variable">$token</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token single-quoted-string string">'https://example.com/reset-password?token='</span><span
                class="token punctuation">.</span><span class="token variable">$token</span><span
                class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="reset-email-customization"><a href="#reset-email-customization">Сбросить настройки электронной почты</a></h4>
<p>Вы можете легко изменить класс уведомлений, используемый для отправки пользователю ссылки для сброса пароля. Для
    начала переопределите <code>sendPasswordResetNotification</code> метод в своей <code>App\Models\User</code> модели.
    В этом методе вы можете отправить уведомление, используя любой <a href="notifications">класс уведомлений,
        созданный</a> вами. Сброс пароля <code>$token</code> - это первый аргумент, полученный методом. Вы можете
    использовать это, <code>$token</code> чтобы создать URL-адрес для сброса пароля по вашему выбору и отправить
    уведомление пользователю:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Notifications<span
                    class="token punctuation">\</span>ResetPasswordNotification</span><span
                class="token punctuation">;</span>

<span class="token comment">/**
 * Send a password reset notification to the user.
 *
 * @param  string  $token
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">sendPasswordResetNotification</span><span
                class="token punctuation">(</span><span class="token variable">$token</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$url</span> <span class="token operator">=</span> <span
                class="token single-quoted-string string">'https://example.com/reset-password?token='</span><span
                class="token punctuation">.</span><span class="token variable">$token</span><span
                class="token punctuation">;</span>
    
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">notify</span><span
                class="token punctuation">(</span><span class="token keyword">new</span> <span class="token class-name">ResetPasswordNotification</span><span
                class="token punctuation">(</span><span class="token variable">$url</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
