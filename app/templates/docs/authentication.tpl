<h1>Аутентификация <sup>Authentication</sup></h1>
<ul>
    <li><a href="authentication#introduction">Вступление</a>
        <ul>
            <li><a href="authentication#starter-kits">Стартовые наборы</a></li>
            <li><a href="authentication#introduction-database-considerations">Рекомендации по базе данных</a></li>
            <li><a href="authentication#ecosystem-overview">Обзор экосистемы</a></li>
        </ul>
    </li>
    <li><a href="authentication#authentication-quickstart">Краткое руководство по аутентификации</a>
        <ul>
            <li><a href="authentication#install-a-starter-kit">Установить стартовый комплект</a></li>
            <li><a href="authentication#retrieving-the-authenticated-user">Получение аутентифицированного
                    пользователя</a></li>
            <li><a href="authentication#protecting-routes">Защита маршрутов</a></li>
            <li><a href="authentication#login-throttling">Регулирование входа в систему</a></li>
        </ul>
    </li>
    <li><a href="authentication#authenticating-users">Ручная аутентификация пользователей</a>
        <ul>
            <li><a href="authentication#remembering-users">Запоминание пользователей</a></li>
            <li><a href="authentication#other-authentication-methods">Другие методы аутентификации</a></li>
        </ul>
    </li>
    <li><a href="authentication#http-basic-authentication">Базовая аутентификация HTTP</a>
        <ul>
            <li><a href="authentication#stateless-http-basic-authentication">Обычная HTTP-аутентификация без сохранения
                    состояния</a></li>
        </ul>
    </li>
    <li><a href="authentication#logging-out">Выход из системы</a>
        <ul>
            <li><a href="authentication#invalidating-sessions-on-other-devices">Аннулирование сеансов на других
                    устройствах</a></li>
        </ul>
    </li>
    <li><a href="authentication#password-confirmation">Подтверждение пароля</a>
        <ul>
            <li><a href="authentication#password-confirmation-configuration">Конфигурация</a></li>
            <li><a href="authentication#password-confirmation-routing">Маршрутизация</a></li>
            <li><a href="authentication#password-confirmation-protecting-routes">Защита маршрутов</a></li>
        </ul>
    </li>
    <li><a href="authentication#adding-custom-guards">Добавление специальных охранников</a>
        <ul>
            <li><a href="authentication#closure-request-guards">Охранники запроса закрытия</a></li>
        </ul>
    </li>
    <li><a href="authentication#adding-custom-user-providers">Добавление настраиваемых поставщиков пользователей</a>
        <ul>
            <li><a href="authentication#the-user-provider-contract">Контракт с поставщиком услуг</a></li>
            <li><a href="authentication#the-authenticatable-contract">Аутентифицируемый контракт</a></li>
        </ul>
    </li>
    <li><a href="socialite">Социальная аутентификация</a></li>
    <li><a href="authentication#events">События</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Многие веб-приложения предоставляют своим пользователям возможность аутентифицироваться в приложении и «войти в
    систему». Реализация этой функции в веб-приложениях может быть сложной и потенциально рискованной задачей. По этой
    причине Laravel стремится предоставить вам инструменты, необходимые для быстрой, безопасной и простой реализации
    аутентификации.</p>
<p>По своей сути средства аутентификации Laravel состоят из «охранников» и «провайдеров». Охранники определяют, как
    пользователи проходят проверку подлинности для каждого запроса. Например, Laravel поставляется с
    <code>session</code> защитой, которая поддерживает состояние с помощью хранилища сеансов и файлов cookie.</p>
<p>Провайдеры определяют, как пользователи извлекаются из вашего постоянного хранилища. Laravel поставляется с
    поддержкой получения пользователей с помощью <a href="eloquent">Eloquent</a> и построителя запросов к базе данных.
    Однако вы можете определить дополнительных поставщиков, если это необходимо для вашего приложения.</p>
<p>Файл конфигурации аутентификации вашего приложения находится по адресу <code>config/auth.php</code>. Этот файл
    содержит несколько хорошо задокументированных опций для настройки поведения служб аутентификации Laravel.</p>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Не следует путать охранников и провайдеров с «ролями» и «разрешениями». Чтобы узнать больше об авторизации
            действий пользователя с помощью разрешений, обратитесь к документации по <a
                    href="authorization">авторизации</a>.</p></p></div>
</blockquote>
<p></p>
<h3 id="starter-kits"><a href="#starter-kits">Стартовые наборы</a></h3>
<p>Хотите быстро приступить к работе? Установите <a href="starter-kits">стартовый комплект приложения Laravel</a> в
    новое приложение Laravel. После переноса базы данных перейдите в браузере <code>/register</code> или по любому
    другому URL-адресу, назначенному вашему приложению. Стартовые комплекты возьмут на себя всю вашу систему
    аутентификации!</p>
<p><strong>Даже если вы решите не использовать стартовый комплект в своем последнем приложении Laravel, установка
        стартового комплекта <a href="starter-kits#laravel-breeze">Laravel Breeze</a> может стать прекрасной
        возможностью узнать, как реализовать все функции аутентификации Laravel в реальном проекте Laravel. </strong>Поскольку
    Laravel Breeze создает для вас контроллеры аутентификации, маршруты и представления, вы можете изучить код в этих
    файлах, чтобы узнать, как могут быть реализованы функции аутентификации Laravel.</p>
<p></p>
<h3 id="introduction-database-considerations"><a href="#introduction-database-considerations">Рекомендации по базе
        данных</a></h3>
<p>По умолчанию Laravel включает в ваш каталог <code>App\Models\User</code> <a href="eloquent">модель Eloquent</a><code>app/Models</code>
    . Эта модель может использоваться с драйвером аутентификации Eloquent по умолчанию. Если ваше приложение не
    использует Eloquent, вы можете использовать <code>database</code> поставщика аутентификации, который использует
    построитель запросов Laravel.</p>
<p>При построении схемы базы данных для <code>App\Models\User</code> модели убедитесь, что длина столбца пароля
    составляет не менее 60 символов. Конечно, <code>users</code> миграция таблиц, включенная в новые приложения Laravel,
    уже создает столбец, длина которого превышает эту длину.</p>
<p>Кроме того, вы должны убедиться, что ваша <code>users</code> (или эквивалентная) таблица содержит <code>remember_token</code>
    100-символьный строковый столбец, допускающий значение NULL. Этот столбец будет использоваться для хранения токена
    для пользователей, которые выбирают опцию «запомнить меня» при входе в ваше приложение. Опять же, <code>users</code>
    миграция таблиц по умолчанию, включенная в новые приложения Laravel, уже содержит этот столбец.</p>
<p></p>
<h3 id="ecosystem-overview"><a href="#ecosystem-overview">Обзор экосистемы</a></h3>
<p>Laravel предлагает несколько пакетов, связанных с аутентификацией. Прежде чем продолжить, мы рассмотрим общую
    экосистему аутентификации в Laravel и обсудим предназначение каждого пакета.</p>
<p>Во-первых, рассмотрим, как работает аутентификация. При использовании веб-браузера пользователь вводит свое имя
    пользователя и пароль через форму входа. Если эти учетные данные верны, приложение сохранит информацию об
    аутентифицированном пользователе в пользовательском <a href="session">сеансе</a>. Файл cookie, выпущенный для
    браузера, содержит идентификатор сеанса, чтобы последующие запросы к приложению могли связать пользователя с
    правильным сеансом. После получения файла cookie сеанса приложение извлечет данные сеанса на основе идентификатора
    сеанса, обратите внимание, что информация аутентификации была сохранена в сеансе, и будет считать пользователя
    «аутентифицированным».</p>
<p>Когда удаленной службе требуется пройти проверку подлинности для доступа к API, файлы cookie обычно не используются
    для проверки подлинности из-за отсутствия веб-браузера. Вместо этого удаленная служба отправляет токен API в API при
    каждом запросе. Приложение может проверить входящий токен по таблице допустимых токенов API и «аутентифицировать»
    запрос как выполняемый пользователем, связанным с этим токеном API.</p>
<p></p>
<h4 id="laravels-built-in-browser-authentication-services"><a href="#laravels-built-in-browser-authentication-services">Встроенные
        службы аутентификации браузера Laravel</a></h4>
<p>Laravel включает встроенные аутентификации и сеанса служб, которые, как правило, доступны через <code>Auth</code> и
    <code>Session</code> фасадов. Эти функции обеспечивают аутентификацию на основе файлов cookie для запросов, которые
    инициируются из веб-браузеров. Они предоставляют методы, которые позволяют вам проверять учетные данные пользователя
    и аутентифицировать пользователя. Кроме того, эти службы будут автоматически сохранять правильные данные
    аутентификации в сеансе пользователя и выпускать cookie сеанса пользователя. Обсуждение того, как использовать эти
    службы, содержится в этой документации.</p>
<p><strong>Стартовые наборы приложений</strong></p>
<p>Как описано в этой документации, вы можете взаимодействовать с этими службами аутентификации вручную, чтобы создать
    собственный уровень аутентификации вашего приложения. Однако, чтобы помочь вам начать работу быстрее, мы выпустили
    <a href="starter-kits">бесплатные пакеты,</a> которые обеспечивают надежную и современную основу всего уровня
    аутентификации. Это <a href="starter-kits#laravel-breeze">Laravel Breeze</a>, <a
            href="starter-kits#laravel-jetstream">Laravel Jetstream</a> и <a href="fortify">Laravel Fortify</a>.</p>
<p><em>Laravel Breeze</em> - это простая, минимальная реализация всех функций аутентификации Laravel, включая вход в
    систему, регистрацию, сброс пароля, проверку электронной почты и подтверждение пароля. Слой представления Laravel
    Breeze состоит из простых <a href="blade">шаблонов Blade,</a> стилизованных с помощью <a
            href="https://tailwindcss.com">Tailwind CSS</a>. Для начала ознакомьтесь с документацией по <a
            href="starter-kits">стартовым комплектам приложений</a> Laravel.</p>
<p><em>Laravel Fortify</em> - это бэкэнд безголовой аутентификации для Laravel, который реализует многие функции,
    описанные в этой документации, включая аутентификацию на основе <em>файлов</em> cookie, а также другие функции,
    такие как двухфакторная аутентификация и проверка электронной почты. Fortify предоставляет бэкэнд аутентификации для
    Laravel Jetstream или может использоваться независимо в сочетании с <a href="sanctum">Laravel Sanctum</a> для
    обеспечения аутентификации для SPA, который должен аутентифицироваться с Laravel.</p>
<p><em><a href="https://jetstream.laravel.com">Laravel Jetstream</a></em> - это надежный стартовый набор приложений,
    который использует и предоставляет сервисы аутентификации Laravel Fortify с красивым современным пользовательским
    интерфейсом на основе<a href="https://tailwindcss.com"> Tailwind CSS</a>,<a href="https://laravel-livewire.com">
        Livewire</a> и / или<a href="https://inertiajs.com"> Inertia.js</a>. Laravel Jetstream включает дополнительную
    поддержку двухфакторной аутентификации, поддержку команды, управление сеансами браузера, управление профилями и
    встроенную интеграцию с<a href="sanctum"> Laravel Sanctum</a> для обеспечения аутентификации токена API. Предложения
    аутентификации API Laravel обсуждаются ниже.</p>
<p></p>
<h4 id="laravels-api-authentication-services"><a href="#laravels-api-authentication-services">Службы аутентификации API
        Laravel</a></h4>
<p>Laravel предоставляет два дополнительных пакета, которые помогут вам в управлении токенами API и аутентификации
    запросов, сделанных с помощью токенов API: <a href="passport">Passport</a> и <a href="sanctum">Sanctum</a>. Обратите
    внимание, что эти библиотеки и встроенные в Laravel библиотеки аутентификации на основе файлов cookie не являются
    взаимоисключающими. Эти библиотеки в первую очередь ориентированы на аутентификацию токена API, в то время как
    встроенные службы аутентификации ориентированы на аутентификацию браузера на основе файлов cookie. Многие приложения
    будут использовать как встроенные службы аутентификации Laravel на основе файлов cookie, так и один из пакетов
    аутентификации API Laravel.</p>
<p><strong>Passport</strong></p>
<p>Passport - это провайдер аутентификации OAuth2, предлагающий различные «типы прав доступа» OAuth2, которые позволяют
    выпускать различные типы токенов. В общем, это надежный и сложный пакет для аутентификации API. Однако большинству
    приложений не требуются сложные функции, предлагаемые спецификацией OAuth2, что может сбивать с толку как
    пользователей, так и разработчиков. Кроме того, разработчики исторически не понимали, как аутентифицировать
    приложения SPA или мобильные приложения с помощью провайдеров аутентификации OAuth2, таких как Passport.</p>
<p><strong>Sanctum</strong></p>
<p>В ответ на сложность OAuth2 и путаницу разработчиков мы решили создать более простой и оптимизированный пакет
    аутентификации, который мог бы обрабатывать как сторонние веб-запросы из веб-браузера, так и запросы API через
    токены. Эта цель была реализована с выпуском <a href="sanctum">Laravel Sanctum</a>, который следует рассматривать
    как предпочтительный и рекомендуемый пакет аутентификации для приложений, которые будут предлагать собственный
    веб-интерфейс в дополнение к API или будут работать на основе одностраничного приложения ( SPA), который существует
    отдельно от серверного приложения Laravel или приложений, предлагающих мобильный клиент.</p>
<p>Laravel Sanctum - это гибридный пакет аутентификации через Интернет / API, который может управлять всем процессом
    аутентификации вашего приложения. Это возможно, потому что когда приложения на основе Sanctum получают запрос,
    Sanctum сначала определяет, содержит ли запрос файл cookie сеанса, который ссылается на сеанс, прошедший проверку
    подлинности. Sanctum выполняет это, вызывая встроенные службы аутентификации Laravel, которые мы обсуждали ранее.
    Если запрос не аутентифицируется с помощью файла cookie сеанса, Sanctum проверит запрос на наличие токена API. Если
    присутствует токен API, Sanctum аутентифицирует запрос с помощью этого токена. Чтобы узнать больше об этом процессе,
    обратитесь к документации Sanctum <a href="sanctum#how-it-works">«как это работает»</a>.</p>
<p>Laravel Sanctum - это пакет API, который мы выбрали для включения в стартовый комплект приложения <a
            href="https://jetstream.laravel.com">Laravel Jetstream</a>, потому что мы считаем, что он лучше всего
    подходит для большинства потребностей аутентификации веб-приложений.</p>
<p></p>
<h4 id="summary-choosing-your-stack"><a href="#summary-choosing-your-stack">Резюме и выбор вашего стека</a></h4>
<p>Таким образом, если ваше приложение будет доступно через браузер, и вы создаете монолитное приложение Laravel, ваше
    приложение будет использовать встроенные службы аутентификации Laravel.</p>
<p>Затем, если ваше приложение предлагает API, который будет использоваться третьими сторонами, вы должны выбрать между
    <a href="passport">Passport</a> или <a href="sanctum">Sanctum,</a> чтобы обеспечить аутентификацию токена API для
    вашего приложения. В целом, по возможности следует отдавать предпочтение Sanctum, поскольку это простое и полное
    решение для аутентификации API, аутентификации SPA и мобильной аутентификации, включая поддержку «областей» или
    «возможностей».</p>
<p>Если вы создаете одностраничное приложение (SPA), которое будет работать на серверной части Laravel, вам следует
    использовать <a href="sanctum">Laravel Sanctum</a>. При использовании Sanctum вам нужно будет либо <a
            href="authentication#authenticating-users">вручную реализовать собственные маршруты аутентификации на
        бэкэнд,</a> либо использовать <a href="fortify">Laravel Fortify</a> в качестве серверной службы аутентификации
    без управления, которая предоставляет маршруты и контроллеры для таких функций, как регистрация, сброс пароля,
    проверка электронной почты и т. Д.</p>
<p>Passport можно выбрать, если вашему приложению абсолютно необходимы все функции, предоставляемые спецификацией
    OAuth2.</p>
<p>И, если вы хотите быстро начать работу, мы рады рекомендовать <a href="https://jetstream.laravel.com">Laravel
        Jetstream</a> как быстрый способ запустить новое приложение Laravel, которое уже использует наш предпочтительный
    стек аутентификации встроенных служб аутентификации Laravel и Laravel Sanctum.</p>
<p></p>
<h2 id="authentication-quickstart"><a href="#authentication-quickstart">Краткое руководство по аутентификации</a></h2>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>В этой части документации обсуждается аутентификация пользователей с помощью <a href="starter-kits">стартовых
                наборов приложений Laravel</a>, которые включают в себя каркас пользовательского интерфейса, который
            поможет вам быстро начать работу. Если вы хотите напрямую интегрироваться с системами аутентификации
            Laravel, ознакомьтесь с документацией по <a href="authentication#authenticating-users">аутентификации
                пользователей вручную</a>.</p></p></div>
</blockquote>
<p></p>
<h3 id="install-a-starter-kit"><a href="#install-a-starter-kit">Установить стартовый комплект</a></h3>
<p>Во-первых, вы должны <a href="starter-kits">установить стартовый комплект приложения Laravel</a>. Наши текущие
    стартовые комплекты, Laravel Breeze и Laravel Jetstream, предлагают красиво оформленные отправные точки для
    включения аутентификации в ваше новое приложение Laravel.</p>
<p>Laravel Breeze - это минимальная и простая реализация всех функций аутентификации Laravel, включая вход в систему,
    регистрацию, сброс пароля, проверку электронной почты и подтверждение пароля. Слой представления Laravel Breeze
    состоит из простых <a href="blade">шаблонов Blade,</a> стилизованных с помощью <a href="https://tailwindcss.com">Tailwind
        CSS</a>.</p>
<p><a href="https://jetstream.laravel.com">Laravel Jetstream</a> - это более надежный стартовый набор приложений,
    который включает в себя поддержку построения вашего приложения с помощью <a href="https://laravel-livewire.com">Livewire</a>
    или <a href="https://inertiajs.com">Inertia.js и Vue</a>. Кроме того, Jetstream имеет дополнительную поддержку
    двухфакторной аутентификации, команд, управления профилями, управления сеансами браузера, поддержки API через <a
            href="sanctum">Laravel Sanctum</a>, удаления учетной записи и многого другого.</p>
<p></p>
<h3 id="retrieving-the-authenticated-user"><a href="#retrieving-the-authenticated-user">Получение аутентифицированного
        пользователя</a></h3>
<p>После установки стартового набора аутентификации и разрешения пользователям регистрироваться и аутентифицироваться в
    вашем приложении вам часто потребуется взаимодействовать с текущим аутентифицированным пользователем. Во время
    обработки входящего запроса вы можете получить доступ к аутентифицированному пользователю через метод
    <code>Auth</code> фасада <code>user</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Auth</span><span
                class="token punctuation">;</span>

<span class="token comment">// Retrieve the currently authenticated user...</span>
<span class="token variable">$user</span> <span class="token operator">=</span> Auth<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">user</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// Retrieve the currently authenticated user's ID...</span>
<span class="token variable">$id</span> <span class="token operator">=</span> Auth<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">id</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>В качестве альтернативы, как только пользователь аутентифицирован, вы можете получить доступ к аутентифицированному
    пользователю через <code>Illuminate\Http\Request</code> экземпляр. Помните, что классы с указанием типа будут
    автоматически добавлены в методы вашего контроллера. Путем указания типа <code>Illuminate\Http\Request</code>
    объекта вы можете получить удобный доступ к аутентифицированному пользователю из любого метода контроллера в вашем
    приложении через метод запроса <code>user</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">FlightController</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Update the flight information for an existing flight.
    *
    * @param  \Illuminate\Http\Request  $request
    * @return \Illuminate\Http\Response
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">update</span><span
                    class="token punctuation">(</span>Request <span class="token variable">$request</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">// $request-&gt;user()</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h4 id="determining-if-the-current-user-is-authenticated"><a href="#determining-if-the-current-user-is-authenticated">Определение
        подлинности текущего пользователя</a></h4>
<p>Чтобы определить, аутентифицирован ли пользователь, выполняющий входящий HTTP-запрос, вы можете использовать <code>check</code>
    метод <code>Auth</code> фасада. Этот метод вернется, <code>true</code> если пользователь аутентифицирован:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Auth</span><span
                class="token punctuation">;</span>

<span class="token keyword">if</span> <span class="token punctuation">(</span>Auth<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">check</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// The user is logged in...</span>
<span class="token punctuation">}</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Несмотря на то, что можно определить, аутентифицирован ли пользователь с помощью этого <code>check</code>
            метода, вы обычно будете использовать промежуточное программное обеспечение для проверки аутентификации
            пользователя, прежде чем разрешить пользователю доступ к определенным маршрутам / контроллерам. Чтобы узнать
            больше об этом, ознакомьтесь с документацией по <a href="authentication#protecting-routes">защите
                маршрутов</a>.</p></p></div>
</blockquote>
<p></p>
<h3 id="protecting-routes"><a href="#protecting-routes">Защита маршрутов</a></h3>
<p><a href="middleware">Промежуточное ПО маршрута</a> может использоваться только для того, чтобы разрешить
    аутентифицированным пользователям доступ к заданному маршруту. Laravel поставляется с <code>auth</code>
    промежуточным программным обеспечением, которое ссылается на <code>Illuminate\Auth\Middleware\Authenticate</code>
    класс. Поскольку это промежуточное ПО уже зарегистрировано в HTTP-ядре вашего приложения, все, что вам нужно
    сделать, это прикрепить промежуточное ПО к определению маршрута:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/flights'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// Only authenticated users may access this route...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">middleware</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'auth'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="redirecting-unauthenticated-users"><a href="#redirecting-unauthenticated-users">Перенаправление
        неаутентифицированных пользователей</a></h4>
<p>Когда <code>auth</code> промежуточное программное обеспечение обнаруживает неаутентифицированного пользователя, оно
    перенаправляет пользователя на <code>login</code> <a href="routing#named-routes">указанный маршрут</a>. Вы можете
    изменить это поведение, обновив <code>redirectTo</code> функцию в <code>app/Http/Middleware/Authenticate.php</code>
    файле вашего приложения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the path the user should be redirected to.
 *
 * @param  \Illuminate\Http\Request  $request
 * @return string
 */</span>
<span class="token keyword">protected</span> <span class="token keyword">function</span> <span class="token function">redirectTo</span><span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token function">route</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'login'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="specifying-a-guard"><a href="#specifying-a-guard">Определение стража</a></h4>
<p>При присоединении <code>auth</code> промежуточного программного обеспечения к маршруту вы также можете указать, какой
    «охранник» следует использовать для аутентификации пользователя. Указанный охранник должен соответствовать одному из
    ключей в <code>guards</code> массиве вашего <code>auth.php</code> файла конфигурации:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/flights'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// Only authenticated users may access this route...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">middleware</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'auth:admin'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="login-throttling"><a href="#login-throttling">Регулирование входа в систему</a></h3>
<p>Если вы используете <a href="starter-kits">стартовые наборы</a> Laravel Breeze или Laravel Jetstream, ограничение
    скорости будет автоматически применяться к попыткам входа в систему. По умолчанию, пользователь не сможет войти в
    систему в течение одной минуты, если он не сможет предоставить правильные учетные данные после нескольких попыток.
    Регулировка уникальна для имени пользователя / адреса электронной почты и их IP-адреса.</p>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Если вы хотите ограничить скорость других маршрутов в своем приложении, ознакомьтесь с <a
                    href="routing#rate-limiting">документацией по ограничению скорости</a>.</p></p></div>
</blockquote>
<p></p>
<h2 id="authenticating-users"><a href="#authenticating-users">Ручная аутентификация пользователей</a></h2>
<p>Вам не обязательно использовать каркас аутентификации, включенный в <a href="starter-kits">стартовые наборы
        приложений</a> Laravel. Если вы решите не использовать этот шаблон, вам нужно будет управлять аутентификацией
    пользователей напрямую, используя классы аутентификации Laravel. Не волнуйтесь, это круто!</p>
<p>Мы получим доступ к службам аутентификации Laravel через <code>Auth</code> <a href="facades">фасад</a>, поэтому нам
    нужно обязательно импортировать <code>Auth</code> фасад в верхней части класса. Далее давайте проверим
    <code>attempt</code> метод. Этот <code>attempt</code> метод обычно используется для обработки попыток аутентификации
    из формы входа в систему вашего приложения. Если аутентификация прошла успешно, вы должны повторно создать <a
            href="session">сеанс</a> пользователя, чтобы предотвратить <a
            href="https://en.wikipedia.org/wiki/Session_fixation">фиксацию сеанса</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Auth</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">LoginController</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Handle an authentication attempt.
    *
    * @param  \Illuminate\Http\Request $request
    * @return \Illuminate\Http\Response
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">authenticate</span><span
                    class="token punctuation">(</span>Request <span class="token variable">$request</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$credentials</span> <span class="token operator">=</span> <span class="token variable">$request</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">only</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'email'</span><span
                    class="token punctuation">,</span> <span class="token single-quoted-string string">'password'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token keyword">if</span> <span class="token punctuation">(</span>Auth<span
                    class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">attempt</span><span class="token punctuation">(</span><span
                    class="token variable">$credentials</span><span class="token punctuation">)</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token variable">$request</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">session</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">regenerate</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>

            <span class="token keyword">return</span> <span class="token function">redirect</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">intended</span><span
                    class="token punctuation">(</span><span class="token single-quoted-string string">'dashboard'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span>

        <span class="token keyword">return</span> <span class="token function">back</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">withErrors</span><span
                    class="token punctuation">(</span><span class="token punctuation">[</span>
            <span class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token single-quoted-string string">'The provided credentials do not match our records.'</span><span
                    class="token punctuation">,</span>
        <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p><code>attempt</code> Метод принимает массив пар ключ / значение в качестве первого аргумента. Значения в массиве
    будут использоваться для поиска пользователя в таблице базы данных. Итак, в приведенном выше примере пользователь
    будет извлечен по значению <code>email</code> столбца. Если пользователь найден, хешированный пароль, хранящийся в
    базе данных, будет сравниваться со <code>password</code> значением, переданным методу через массив. Вы не должны
    хешировать значение входящего запроса <code>password</code>, поскольку фреймворк автоматически хеширует значение,
    прежде чем сравнивать его с хешированным паролем в базе данных. Если два хешированных пароля совпадают, для
    пользователя будет запущен сеанс аутентификации.</p>
<p>Помните, что службы аутентификации Laravel будут извлекать пользователей из вашей базы данных на основе конфигурации
    «провайдера» вашего средства аутентификации. В <code>config/auth.php</code> файле конфигурации по умолчанию указан
    поставщик пользователей Eloquent, и ему дано указание использовать <code>App\Models\User</code> модель при получении
    пользователей. Вы можете изменить эти значения в своем файле конфигурации в зависимости от потребностей вашего
    приложения.</p>
<p><code>attempt</code> Метод будет возвращать, <code>true</code> если аутентификация прошла успешно. В противном случае
    <code>false</code> будет возвращен.</p>
<p><code>intended</code> Метод, предоставляемый перенаправителю Laravel будет перенаправлять пользователь на URL они
    были пытающимся доступ перед тем, как перехвачены промежуточной аутентификацией. Этому методу может быть
    предоставлен резервный URI, если предполагаемый пункт назначения недоступен.</p>
<p></p>
<h4 id="specifying-additional-conditions"><a href="#specifying-additional-conditions">Указание дополнительных
        условий</a></h4>
<p>При желании вы также можете добавить дополнительные условия запроса к запросу аутентификации в дополнение к
    электронной почте и паролю пользователя. Для этого мы можем просто добавить условия запроса в массив, переданный
    <code>attempt</code> методу. Например, мы можем проверить, что пользователь отмечен как «активный»:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">if</span> <span
                class="token punctuation">(</span>Auth<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">attempt</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$email</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'password'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$password</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'active'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token number">1</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// Authentication was successful...</span>
<span class="token punctuation">}</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>В этих примерах <code>email</code> это необязательный параметр, он просто используется в качестве примера. Вы
            должны использовать любое имя столбца, соответствующее «имени пользователя» в таблице базы данных.</p></p>
    </div>
</blockquote>
<p></p>
<h4 id="accessing-specific-guard-instances"><a href="#accessing-specific-guard-instances">Доступ к определенным
        экземплярам защиты</a></h4>
<p>С помощью метода <code>Auth</code> фасада <code>guard</code> вы можете указать, какой экземпляр защиты вы хотите
    использовать при аутентификации пользователя. Это позволяет вам управлять аутентификацией для отдельных частей
    вашего приложения с использованием полностью отдельных аутентифицируемых моделей или пользовательских таблиц.</p>
<p>Имя охранника, переданное <code>guard</code> методу, должно соответствовать одному из охранников, настроенных в вашем
    <code>auth.php</code> файле конфигурации:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">if</span> <span
                class="token punctuation">(</span>Auth<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">guard</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'admin'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">attempt</span><span
                class="token punctuation">(</span><span class="token variable">$credentials</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//...</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="remembering-users"><a href="#remembering-users">Запоминание пользователей</a></h3>
<p>Многие веб-приложения предоставляют флажок «Запомнить меня» в форме входа. Если вы хотите обеспечить функциональность
    «запомнить меня» в своем приложении, вы можете передать логическое значение в качестве второго аргумента <code>attempt</code>
    метода.</p>
<p>Когда это значение равно <code>true</code>, Laravel будет поддерживать аутентификацию пользователя неопределенно
    долго или до тех пор, пока он не выйдет из системы вручную. Ваша <code>users</code> таблица должна включать
    строковый <code>remember_token</code> столбец, который будет использоваться для хранения токена «запомнить меня».
    <code>users</code> Миграции таблицы включены новые приложения Laravel уже включает эту колонку:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Auth</span><span
                class="token punctuation">;</span>

<span class="token keyword">if</span> <span class="token punctuation">(</span>Auth<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">attempt</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$email</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'password'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$password</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span> <span class="token variable">$remember</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// The user is being remembered...</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="other-authentication-methods"><a href="#other-authentication-methods">Другие методы аутентификации</a></h3>
<p></p>
<h4 id="authenticate-a-user-instance"><a href="#authenticate-a-user-instance">Аутентификация экземпляра пользователя</a>
</h4>
<p>Если вам нужно установить существующий пользовательский экземпляр в качестве текущего аутентифицированного
    пользователя, вы можете передать пользовательский экземпляр в метод <code>Auth</code> фасада <code>login</code>.
    Данный пользовательский экземпляр должен быть реализацией <code>Illuminate\Contracts\Auth\Authenticatable</code> <a
            href="contracts">контракта</a>. <code>App\Models\User</code> Модель в комплекте с Laravel уже реализует этот
    интерфейс. Этот метод аутентификации полезен, когда у вас уже есть действительный экземпляр пользователя, например,
    сразу после того, как пользователь регистрируется в вашем приложении:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Auth</span><span
                class="token punctuation">;</span>

Auth<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">login</span><span class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете передать логическое значение в качестве второго аргумента <code>login</code> метода. Это значение
    указывает, требуется ли для аутентифицированного сеанса функциональность «запомнить меня». Помните, это означает,
    что сеанс будет аутентифицироваться бесконечно или до тех пор, пока пользователь вручную не выйдет из приложения:
</p>
<pre class=" language-php"><code class=" language-php">Auth<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">login</span><span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">,</span> <span class="token variable">$remember</span> <span
                class="token operator">=</span> <span class="token boolean constant">true</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если необходимо, перед вызовом <code>login</code> метода вы можете указать средство защиты аутентификации:</p>
<pre class=" language-php"><code class=" language-php">Auth<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">guard</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'admin'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">login</span><span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="authenticate-a-user-by-id"><a href="#authenticate-a-user-by-id">Аутентифицировать пользователя по ID</a></h4>
<p>Для аутентификации пользователя с использованием первичного ключа записи в базе данных вы можете использовать этот
    <code>loginUsingId</code> метод. Этот метод принимает первичный ключ пользователя, которого вы хотите
    аутентифицировать:</p>
<pre class=" language-php"><code class=" language-php">Auth<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">loginUsingId</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете передать логическое значение в качестве второго аргумента <code>loginUsingId</code> метода. Это значение
    указывает, требуется ли для аутентифицированного сеанса функциональность «запомнить меня». Помните, это означает,
    что сеанс будет аутентифицироваться бесконечно или до тех пор, пока пользователь вручную не выйдет из приложения:
</p>
<pre class=" language-php"><code class=" language-php">Auth<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">loginUsingId</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">,</span> <span class="token variable">$remember</span> <span
                class="token operator">=</span> <span class="token boolean constant">true</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="authenticate-a-user-once"><a href="#authenticate-a-user-once">Однократная аутентификация пользователя</a></h4>
<p>Вы можете использовать этот <code>once</code> метод для аутентификации пользователя в приложении для одного запроса.
    При вызове этого метода не будут использоваться сеансы или файлы cookie:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">if</span> <span
                class="token punctuation">(</span>Auth<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">once</span><span
                class="token punctuation">(</span><span class="token variable">$credentials</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h2 id="http-basic-authentication"><a href="#http-basic-authentication">Базовая аутентификация HTTP</a></h2>
<p><a href="https://en.wikipedia.org/wiki/Basic_access_authentication">Базовая проверка подлинности HTTP</a>
    обеспечивает быстрый способ проверки подлинности пользователей вашего приложения без создания специальной страницы
    «входа в систему». Для начала прикрепите <code>auth.basic</code> <a href="middleware">промежуточное ПО</a> к
    маршруту. <code>auth.basic</code> Промежуточный слой входят в рамках Laravel, так что вам не нужно определить его:
</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/profile'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// Only authenticated users may access this route...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">middleware</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'auth.basic'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>После того, как промежуточное ПО будет подключено к маршруту, вам будет автоматически предложено ввести учетные
    данные при доступе к маршруту в вашем браузере. По умолчанию <code>auth.basic</code> промежуточное программное
    обеспечение предполагает, что <code>email</code> столбец в <code>users</code> таблице базы данных является «именем
    пользователя».</p>
<p></p>
<h4 id="a-note-on-fastcgi"><a href="#a-note-on-fastcgi">Примечание о FastCGI</a></h4>
<p>Если вы используете PHP FastCGI и Apache для обслуживания своего приложения Laravel, аутентификация HTTP Basic может
    работать некорректно. Чтобы исправить эти проблемы, в <code>.htaccess</code> файл вашего приложения можно добавить
    следующие строки:</p>
<pre class=" language-php"><code class=" language-php">RewriteCond <span class="token operator">%</span><span
                class="token punctuation">{literal}{{/literal}</span><span class="token constant">HTTP</span><span
                class="token punctuation">:</span>Authorization<span class="token punctuation">}</span> <span
                class="token operator">^</span><span class="token punctuation">(</span><span
                class="token punctuation">.</span><span class="token operator">+</span><span
                class="token punctuation">)</span>$
RewriteRule <span class="token punctuation">.</span><span class="token operator">*</span> <span
                class="token operator">-</span> <span class="token punctuation">[</span><span
                class="token constant">E</span><span class="token operator">=</span><span class="token constant">HTTP_AUTHORIZATION</span><span
                class="token punctuation">:</span><span class="token operator">%</span><span
                class="token punctuation">{literal}{{/literal}</span><span class="token constant">HTTP</span><span
                class="token punctuation">:</span>Authorization<span class="token punctuation">}</span><span
                class="token punctuation">]</span></code></pre>
<p></p>
<h3 id="stateless-http-basic-authentication"><a href="#stateless-http-basic-authentication">Обычная HTTP-аутентификация
        без сохранения состояния</a></h3>
<p>Вы также можете использовать базовую аутентификацию HTTP без установки файла cookie идентификатора пользователя в
    сеансе. Это в первую очередь полезно, если вы решите использовать HTTP-аутентификацию для аутентификации запросов к
    API вашего приложения. Для этого <a href="middleware">определите промежуточное программное обеспечение,</a> которое
    вызывает <code>onceBasic</code> метод. Если <code>onceBasic</code> метод не возвращает ответ, запрос может быть
    передан дальше в приложение:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Middleware</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Auth</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">AuthenticateOnceWithBasicAuth</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">handle</span><span
                    class="token punctuation">(</span><span class="token variable">$request</span><span
                    class="token punctuation">,</span> <span class="token variable">$next</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> Auth<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token function">onceBasic</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span> <span
                    class="token operator">?</span><span class="token punctuation">:</span> <span
                    class="token variable">$next</span><span class="token punctuation">(</span><span
                    class="token variable">$request</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>

<span class="token punctuation">}</span></span></code></pre>
<p>Затем <a href="middleware#registering-middleware">зарегистрируйте промежуточное ПО маршрута</a> и прикрепите его к
    маршруту:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'/api/user'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// Only authenticated users may access this route...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">middleware</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'auth.basic.once'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="logging-out"><a href="#logging-out">Выход из системы</a></h2>
<p>Чтобы вручную вывести пользователей из вашего приложения, вы можете использовать <code>logout</code> метод,
    предоставляемый <code>Auth</code> фасадом. Это удалит информацию аутентификации из сеанса пользователя, так что
    последующие запросы не будут аутентифицированы.</p>
<p>В дополнение к вызову <code>logout</code> метода рекомендуется аннулировать сеанс пользователя и <a href="csrf">повторно
        сгенерировать его токен CSRF</a>. После выхода пользователя из системы вы обычно перенаправляете пользователя в
    корень вашего приложения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Auth</span><span
                class="token punctuation">;</span>

<span class="token comment">/**
 * Log the user out of the application.
 *
 * @param  \Illuminate\Http\Request $request
 * @return \Illuminate\Http\Response
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">logout</span><span
                class="token punctuation">(</span>Request <span class="token variable">$request</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    Auth<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">logout</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    
    <span class="token variable">$request</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">session</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">invalidate</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    
    <span class="token variable">$request</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">session</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">regenerateToken</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    
    <span class="token keyword">return</span> <span class="token function">redirect</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'/'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="invalidating-sessions-on-other-devices"><a href="#invalidating-sessions-on-other-devices">Аннулирование сеансов
        на других устройствах</a></h3>
<p>Laravel также предоставляет механизм для аннулирования и «выхода» из сеансов пользователя, которые активны на других
    устройствах, без аннулирования сеанса на их текущем устройстве. Эта функция обычно используется, когда пользователь
    меняет или обновляет свой пароль, и вы хотите аннулировать сеансы на других устройствах, сохранив аутентификацию
    текущего устройства.</p>
<p>Перед тем, как начать, вы должны убедиться, что <code>Illuminate\Session\Middleware\AuthenticateSession</code>
    промежуточное ПО присутствует и не прокомментировано в группе промежуточного ПО вашего <code>App\Http\Kernel</code>
    класса <code>web</code>:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'web'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token comment">//...</span>
    \<span class="token package">Illuminate<span class="token punctuation">\</span>Session<span
                    class="token punctuation">\</span>Middleware<span class="token punctuation">\</span>AuthenticateSession</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
    <span class="token comment">//...</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p>Затем вы можете использовать <code>logoutOtherDevices</code> метод, предоставляемый <code>Auth</code> фасадом. Этот
    метод требует, чтобы пользователь подтвердил свой текущий пароль, который ваше приложение должно принять через форму
    ввода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Auth</span><span
                class="token punctuation">;</span>

Auth<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">logoutOtherDevices</span><span
                class="token punctuation">(</span><span class="token variable">$currentPassword</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Когда этот <code>logoutOtherDevices</code> метод вызывается, другие сеансы пользователя будут полностью аннулированы,
    то есть они будут "отключены" от всех охранников, которыми они ранее были аутентифицированы.</p>
<p></p>
<h2 id="password-confirmation"><a href="#password-confirmation">Подтверждение пароля</a></h2>
<p>При создании приложения у вас могут иногда быть действия, которые должны требовать от пользователя подтверждения
    пароля перед выполнением действия или перед перенаправлением пользователя в конфиденциальную область приложения.
    Laravel включает встроенное ПО промежуточного слоя, чтобы упростить этот процесс. Реализация этой функции потребует
    от вас определения двух маршрутов: один маршрут для отображения представления, предлагающего пользователю
    подтвердить свой пароль, и другой маршрут, чтобы подтвердить, что пароль действителен, и перенаправить пользователя
    к предполагаемому месту назначения.</p>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>В следующей документации обсуждается, как напрямую интегрироваться с функциями подтверждения пароля Laravel;
            однако, если вы хотите начать работу быстрее, <a href="starter-kits">стартовые комплекты приложений
                Laravel</a> включают поддержку этой функции!</p></p></div>
</blockquote>
<p></p>
<h3 id="password-confirmation-configuration"><a href="#password-confirmation-configuration">Конфигурация</a></h3>
<p>После подтверждения пароля пользователю не будет предлагаться повторно подтвердить пароль в течение трех часов.
    Однако вы можете настроить время, по истечении которого у пользователя будет повторно запрашиваться пароль, изменив
    значение <code>password_timeout</code> значения <code>config/auth.php</code> конфигурации в файле конфигурации
    вашего приложения.</p>
<p></p>
<h3 id="password-confirmation-routing"><a href="#password-confirmation-routing">Маршрутизация</a></h3>
<p></p>
<h4 id="the-password-confirmation-form"><a href="#the-password-confirmation-form">Форма подтверждения пароля</a></h4>
<p>Сначала мы определим маршрут для отображения представления, которое запрашивает у пользователя подтверждение своего
    пароля:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'/confirm-password'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token function">view</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'auth.confirm-password'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">middleware</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'auth'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">name</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'password.confirm'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Как и следовало ожидать, представление, возвращаемое этим маршрутом, должно иметь форму, содержащую
    <code>password</code> поле. Кроме того, не стесняйтесь включать в представление текст, который объясняет, что
    пользователь входит в защищенную область приложения и должен подтвердить свой пароль.</p>
<p></p>
<h4 id="confirming-the-password"><a href="#confirming-the-password">Подтверждение пароля</a></h4>
<p>Затем мы определим маршрут, который будет обрабатывать запрос формы из представления «подтвердить пароль». Этот
    маршрут будет отвечать за проверку пароля и перенаправление пользователя к месту назначения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Hash</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span
                    class="token punctuation">\</span>Redirect</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">post</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/confirm-password'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>Request <span class="token variable">$request</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">if</span> <span class="token punctuation">(</span><span
                class="token operator">!</span> Hash<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">check</span><span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">password</span><span
                class="token punctuation">,</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">user</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">password</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token function">back</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">withErrors</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
            <span class="token single-quoted-string string">'password'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'The provided password does not match our records.'</span><span
                class="token punctuation">]</span>
        <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token punctuation">}</span>
            
    <span class="token variable">$request</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">session</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">passwordConfirmed</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
            
    <span class="token keyword">return</span> <span class="token function">redirect</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">intended</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">middleware</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'auth'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'throttle:6,1'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">name</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'password.confirm'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Прежде чем двигаться дальше, давайте рассмотрим этот маршрут более подробно. Сначала определяется, что
    <code>password</code> поле запроса действительно соответствует паролю аутентифицированного пользователя. Если пароль
    действителен, нам нужно сообщить сеансу Laravel, что пользователь подтвердил свой пароль.
    <code>passwordConfirmed</code> Метод будет установить метку времени в сеансе пользователя, что Laravel можно
    использовать, чтобы определить, когда пользователь последний раз подтвердил свой пароль. Наконец, мы можем
    перенаправить пользователя по назначению.</p>
<p></p>
<h3 id="password-confirmation-protecting-routes"><a href="#password-confirmation-protecting-routes">Защита маршрутов</a>
</h3>
<p>Вы должны убедиться, что <code>password.confirm</code> промежуточному программному обеспечению назначен любой
    маршрут, который выполняет действие, требующее недавнего подтверждения пароля. Это промежуточное программное
    обеспечение входит в стандартную установку Laravel и автоматически сохраняет предполагаемое место назначения
    пользователя в сеансе, чтобы пользователь мог быть перенаправлен в это место после подтверждения своего пароля.
    После сохранения предполагаемого пункта назначения пользователя в сеансе промежуточное программное обеспечение
    перенаправит пользователя на <code>password.confirm</code> <a href="routing#named-routes">указанный маршрут</a>:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'/settings'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">middleware</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'password.confirm'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">post</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/settings'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">middleware</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'password.confirm'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="adding-custom-guards"><a href="#adding-custom-guards">Добавление специальных охранников</a></h2>
<p>Вы можете определить свои собственные средства защиты аутентификации, используя <code>extend</code> метод на <code>Auth</code>
    фасаде. Вы должны разместить свой вызов <code>extend</code> метода внутри <a href="providers">поставщика услуг</a>.
    Поскольку Laravel уже поставляется с an <code>AuthServiceProvider</code>, мы можем разместить код в этом провайдере:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Providers</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Services<span class="token punctuation">\</span>Auth<span
                        class="token punctuation">\</span>JwtGuard</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Support<span class="token punctuation">\</span>Providers<span
                        class="token punctuation">\</span>AuthServiceProvider</span> <span
                    class="token keyword">as</span> ServiceProvider<span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Auth</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">AuthServiceProvider</span> <span
                    class="token keyword">extends</span> <span class="token class-name">ServiceProvider</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Register any application authentication / authorization services.
    *
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">boot</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">registerPolicies</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>

        Auth<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">extend</span><span
                    class="token punctuation">(</span><span class="token single-quoted-string string">'jwt'</span><span
                    class="token punctuation">,</span> <span class="token keyword">function</span> <span
                    class="token punctuation">(</span><span class="token variable">$app</span><span
                    class="token punctuation">,</span> <span class="token variable">$name</span><span
                    class="token punctuation">,</span> <span class="token keyword">array</span> <span
                    class="token variable">$config</span><span class="token punctuation">)</span> <span
                    class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">// Return an instance of Illuminate\Contracts\Auth\Guard...</span>

            <span class="token keyword">return</span> <span class="token keyword">new</span> <span class="token class-name">JwtGuard</span><span
                    class="token punctuation">(</span>Auth<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token function">createUserProvider</span><span
                    class="token punctuation">(</span><span class="token variable">$config</span><span
                    class="token punctuation">[</span><span
                    class="token single-quoted-string string">'provider'</span><span
                    class="token punctuation">]</span><span class="token punctuation">)</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Как вы можете видеть в приведенном выше примере, обратный вызов, переданный <code>extend</code> методу, должен
    возвращать реализацию <code>Illuminate\Contracts\Auth\Guard</code>. Этот интерфейс содержит несколько методов,
    которые вам необходимо реализовать для определения настраиваемой защиты. После того, как ваш пользовательский
    охранник был определен, вы можете ссылаться на него в <code>guards</code> конфигурации вашего <code>auth.php</code>
    файла конфигурации:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'guards'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'api'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'driver'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'jwt'</span><span
                class="token punctuation">,</span>
        <span class="token single-quoted-string string">'provider'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p></p>
<h3 id="closure-request-guards"><a href="#closure-request-guards">Охранники запроса закрытия</a></h3>
<p>Самый простой способ реализовать настраиваемую систему аутентификации на основе HTTP-запросов - использовать этот
    <code>Auth::viaRequest</code> метод. Этот метод позволяет быстро определить процесс аутентификации с помощью одного
    закрытия.</p>
<p>Для начала вызовите <code>Auth::viaRequest</code> метод внутри <code>boot</code> метода вашего <code>AuthServiceProvider</code>.
    <code>viaRequest</code> Метод принимает аутентификацию имя драйвера в качестве первого аргумента. Это имя может быть
    любой строкой, описывающей вашу индивидуальную защиту. Второй аргумент передается методу должен быть замыкание,
    которое принимает входящий запрос HTTP и возвращает экземпляр пользователя или, если аутентификация завершается
    неудачно, <code>null</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Auth</span><span
                class="token punctuation">;</span>

<span class="token comment">/**
 * Register any application authentication / authorization services.
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
    
    Auth<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">viaRequest</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'custom-token'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span>Request <span
                class="token variable">$request</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">where</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'token'</span><span
                class="token punctuation">,</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">token</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">first</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>После того, как ваш пользовательский драйвер аутентификации был определен, вы можете настроить его как драйвер в
    <code>guards</code> конфигурации вашего <code>auth.php</code> файла конфигурации:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'guards'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'api'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'driver'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'custom-token'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p></p>
<h2 id="adding-custom-user-providers"><a href="#adding-custom-user-providers">Добавление настраиваемых поставщиков
        пользователей</a></h2>
<p>Если вы не используете традиционную реляционную базу данных для хранения своих пользователей, вам нужно будет
    расширить Laravel с помощью вашего собственного провайдера аутентификации пользователей. Мы будем использовать
    <code>provider</code> метод на <code>Auth</code> фасаде, чтобы определить настраиваемого поставщика пользователей.
    Сопоставитель провайдера пользователей должен возвращать реализацию
    <code>Illuminate\Contracts\Auth\UserProvider</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Providers</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Extensions<span
                        class="token punctuation">\</span>MongoUserProvider</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Support<span class="token punctuation">\</span>Providers<span
                        class="token punctuation">\</span>AuthServiceProvider</span> <span
                    class="token keyword">as</span> ServiceProvider<span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Auth</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">AuthServiceProvider</span> <span
                    class="token keyword">extends</span> <span class="token class-name">ServiceProvider</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Register any application authentication / authorization services.
     *
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">boot</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">registerPolicies</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>

        Auth<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">provider</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'mongo'</span><span
                    class="token punctuation">,</span> <span class="token keyword">function</span> <span
                    class="token punctuation">(</span><span class="token variable">$app</span><span
                    class="token punctuation">,</span> <span class="token keyword">array</span> <span
                    class="token variable">$config</span><span class="token punctuation">)</span> <span
                    class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">// Return an instance of Illuminate\Contracts\Auth\UserProvider...</span>

            <span class="token keyword">return</span> <span class="token keyword">new</span> <span class="token class-name">MongoUserProvider</span><span
                    class="token punctuation">(</span><span class="token variable">$app</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">make</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'mongo.connection'</span><span
                    class="token punctuation">)</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>После того, как вы зарегистрировали поставщика с помощью этого <code>provider</code> метода, вы можете переключиться
    на нового поставщика пользователей в вашем <code>auth.php</code> файле конфигурации. Сначала определите, <code>provider</code>
    что использует ваш новый драйвер:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'providers'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'users'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'driver'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'mongo'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p>Наконец, вы можете указать этого провайдера в своей <code>guards</code> конфигурации:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'guards'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'web'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'driver'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'session'</span><span
                class="token punctuation">,</span>
        <span class="token single-quoted-string string">'provider'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p></p>
<h3 id="the-user-provider-contract"><a href="#the-user-provider-contract">Контракт с поставщиком услуг</a></h3>
<p><code>Illuminate\Contracts\Auth\UserProvider</code> реализации отвечают за выборку <code>Illuminate\Contracts\Auth\Authenticatable</code>
    реализации из системы постоянного хранения, такой как MySQL, MongoDB и т. д. Эти два интерфейса позволяют механизмам
    аутентификации Laravel продолжать функционировать независимо от того, как хранятся пользовательские данные или какой
    тип класса используется для представления аутентифицированный пользователь:</p>
<p>Взглянем на <code>Illuminate\Contracts\Auth\UserProvider</code> договор:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">Illuminate<span
                        class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Auth</span><span class="token punctuation">;</span>

<span class="token keyword">interface</span> <span class="token class-name">UserProvider</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">retrieveById</span><span
                    class="token punctuation">(</span><span class="token variable">$identifier</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">retrieveByToken</span><span
                    class="token punctuation">(</span><span class="token variable">$identifier</span><span
                    class="token punctuation">,</span> <span class="token variable">$token</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">updateRememberToken</span><span
                    class="token punctuation">(</span>Authenticatable <span class="token variable">$user</span><span
                    class="token punctuation">,</span> <span class="token variable">$token</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">retrieveByCredentials</span><span
                    class="token punctuation">(</span><span class="token keyword">array</span> <span
                    class="token variable">$credentials</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">validateCredentials</span><span
                    class="token punctuation">(</span>Authenticatable <span class="token variable">$user</span><span
                    class="token punctuation">,</span> <span class="token keyword">array</span> <span
                    class="token variable">$credentials</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
<p><code>retrieveById</code> Функции, как правило, получает ключ, представляющий пользователю, например, как
    автоинкрементным ID из базы данных MySQL. <code>Authenticatable</code> Реализация согласования ID должна быть
    извлечена и возвращена методом.</p>
<p><code>retrieveByToken</code> Функция возвращает пользователя по их уникальным <code>$identifier</code> и «запомнить
    меня» <code>$token</code>, как правило, хранятся в столбце базы данных, как <code>remember_token</code>. Как и в
    случае с предыдущим методом, <code>Authenticatable</code> этот метод должен возвращать реализацию с соответствующим
    значением токена.</p>
<p><code>updateRememberToken</code> Метод обновляет <code>$user</code> экземпляр <code>remember_token</code> с новым
    <code>$token</code>. Новый токен назначается пользователям при успешной попытке аутентификации «запомнить меня» или
    когда пользователь выходит из системы.</p>
<p><code>retrieveByCredentials</code> Метод получает массив учетных данных, передаваемых <code>Auth::attempt</code>
    методу при попытке аутентификации с приложением. Затем метод должен «запросить» базовое постоянное хранилище для
    пользователя, соответствующего этим учетным данным. Обычно этот метод запускает запрос с условием «где», который
    ищет запись пользователя с «именем пользователя», совпадающим со значением <code>$credentials['username']</code>.
    Метод должен возвращать реализацию <code>Authenticatable</code>. <strong>Этот метод не должен пытаться выполнить
        проверку пароля или аутентификацию.</strong></p>
<p>Этот <code>validateCredentials</code> метод должен сравнивать данные <code>$user</code> с тем,
    <code>$credentials</code> чтобы аутентифицировать пользователя. Например, в этом методе обычно используется <code>Hash::check</code>
    метод для сравнения значения <code>$user-&gt;getAuthPassword()</code> со значением
    <code>$credentials['password']</code>. Этот метод должен возвращать <code>true</code> или <code>false</code>
    указывать, действителен ли пароль.</p>
<p></p>
<h3 id="the-authenticatable-contract"><a href="#the-authenticatable-contract">Аутентифицируемый контракт</a></h3>
<p>Теперь, когда мы изучили каждый из методов в <code>UserProvider</code>, давайте взглянем на
    <code>Authenticatable</code> контракт. Помните, что провайдеры пользователя должны возвращать реализации этого
    интерфейса из <code>retrieveById</code>, <code>retrieveByToken</code> и <code>retrieveByCredentials</code> методов:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">Illuminate<span
                        class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Auth</span><span class="token punctuation">;</span>

<span class="token keyword">interface</span> <span class="token class-name">Authenticatable</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">getAuthIdentifierName</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">getAuthIdentifier</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">getAuthPassword</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">getRememberToken</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">setRememberToken</span><span
                    class="token punctuation">(</span><span class="token variable">$value</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">getRememberTokenName</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Этот интерфейс прост. <code>getAuthIdentifierName</code> Метод должен возвращать имя поля «первичный ключ»
    пользователя и <code>getAuthIdentifier</code> метод должен вернуть «первичный ключ» пользователя. При использовании
    серверной части MySQL это, скорее всего, будет автоматически увеличивающийся первичный ключ, назначенный записи
    пользователя. <code>getAuthPassword</code> Метод должен возвращать хэш пароля пользователя.</p>
<p>Этот интерфейс позволяет системе аутентификации работать с любым «пользовательским» классом, независимо от того,
    какой ORM или уровень абстракции хранилища вы используете. По умолчанию Laravel включает
    <code>App\Models\User</code> в <code>app/Models</code> каталог класс, реализующий этот интерфейс.</p>
<p></p>
<h2 id="events"><a href="#events">События</a></h2>
<p>Laravel отправляет множество <a href="events">событий</a> во время процесса аутентификации. Вы можете прикрепить
    слушателей к этим событиям в своем <code>EventServiceProvider</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * The event listener mappings for the application.
 *
 * @var array
 */</span>
<span class="token keyword">protected</span> <span class="token variable">$listen</span> <span
                class="token operator">=</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'Illuminate\Auth\Events\Registered'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'App\Listeners\LogRegisteredUser'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>

    <span class="token single-quoted-string string">'Illuminate\Auth\Events\Attempting'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'App\Listeners\LogAuthenticationAttempt'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>

    <span class="token single-quoted-string string">'Illuminate\Auth\Events\Authenticated'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'App\Listeners\LogAuthenticated'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>

    <span class="token single-quoted-string string">'Illuminate\Auth\Events\Login'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'App\Listeners\LogSuccessfulLogin'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>

    <span class="token single-quoted-string string">'Illuminate\Auth\Events\Failed'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'App\Listeners\LogFailedLogin'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>

    <span class="token single-quoted-string string">'Illuminate\Auth\Events\Validated'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'App\Listeners\LogValidated'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>

    <span class="token single-quoted-string string">'Illuminate\Auth\Events\Verified'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'App\Listeners\LogVerified'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>

    <span class="token single-quoted-string string">'Illuminate\Auth\Events\Logout'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'App\Listeners\LogSuccessfulLogout'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>

    <span class="token single-quoted-string string">'Illuminate\Auth\Events\CurrentDeviceLogout'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'App\Listeners\LogCurrentDeviceLogout'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>

    <span class="token single-quoted-string string">'Illuminate\Auth\Events\OtherDeviceLogout'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'App\Listeners\LogOtherDeviceLogout'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>

    <span class="token single-quoted-string string">'Illuminate\Auth\Events\Lockout'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'App\Listeners\LogLockout'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>

    <span class="token single-quoted-string string">'Illuminate\Auth\Events\PasswordReset'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'App\Listeners\LogPasswordReset'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">;</span></code></pre> 
