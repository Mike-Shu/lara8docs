<h1>Стартовые наборы</h1>
<ul>
    <li><a href="starter-kits#introduction">Вступление</a></li>
    <li><a href="starter-kits#laravel-breeze">Laravel Breeze</a>
        <ul>
            <li><a href="starter-kits#laravel-breeze-installation">Установка</a></li>
        </ul>
    </li>
    <li><a href="starter-kits#laravel-jetstream">Laravel Jetstream</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Чтобы дать вам фору при создании нового приложения Laravel, мы рады предложить наборы для аутентификации и запуска
    приложений. Эти комплекты автоматически дополняют ваше приложение маршрутами, контроллерами и представлениями,
    необходимыми для регистрации и аутентификации пользователей вашего приложения.</p>
<p>Хотя вы можете использовать эти стартовые наборы, они не требуются. Вы можете создать собственное приложение с нуля,
    просто установив новую копию Laravel. В любом случае, мы знаем, что вы построите что-то отличное!</p>
<p></p>
<h2 id="laravel-breeze"><a href="#laravel-breeze">Laravel Breeze</a></h2>
<p>Laravel Breeze - это минимальная и простая реализация всех функций <a href="authentication">аутентификации</a>
    Laravel, включая вход в систему, регистрацию, сброс пароля, проверку электронной почты и подтверждение пароля. Слой
    представления Laravel Breeze состоит из простых <a href="blade">шаблонов Blade,</a> стилизованных с помощью <a
            href="https://tailwindcss.com/">Tailwind CSS</a>. Breeze является прекрасной отправной точкой для создания
    нового приложения Laravel.</p>
<p></p>
<h3 id="laravel-breeze-installation"><a href="#laravel-breeze-installation">Установка</a></h3>
<p>Во-первых, вы должны <a href="installation">создать новое приложение Laravel</a>, настроить базу данных и выполнить
    <a href="migrations">миграцию базы данных</a> :</p>
<pre class=" language-bash"><code class=" language-bash"><span class="token function">curl</span> -s https://laravel.build/example-app <span
                class="token operator">|</span> <span class="token function">bash</span>

<span class="token builtin class-name">cd</span> example-app

php artisan migrate</code></pre>
<p>Создав новое приложение Laravel, вы можете установить Laravel Breeze с помощью Composer:</p>
<pre class=" language-bash"><code class=" language-bash"><span class="token function">composer</span> require laravel/breeze --dev</code></pre>
<p>После того, как Composer установил пакет Laravel Breeze, вы можете запустить команду <code>breeze:install</code> Artisan.
    Эта команда публикует для вашего приложения представления, маршруты, контроллеры и другие ресурсы аутентификации.
    Laravel Breeze публикует весь свой код в вашем приложении, чтобы у вас был полный контроль и видимость его функций и
    реализации. После установки Breeze вы также должны скомпилировать свои ресурсы, чтобы был доступен файл CSS вашего
    приложения:</p>
<pre class=" language-bash"><code class=" language-bash">php artisan breeze:install

<span class="token function">npm</span> <span class="token function">install</span>

<span class="token function">npm</span> run dev</code></pre>
<p>Затем вы можете перейти к своему приложению <code>/login</code> или <code>/register</code> URL-адресам в своем
    веб-браузере. Все маршруты Breeze определены в <code>routes/auth.php</code> файле.</p>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Чтобы узнать больше о компиляции CSS и JavaScript вашего приложения, ознакомьтесь с <a
                    href="mix#running-mix">документацией Laravel Mix</a>.</p></p></div>
</blockquote>
<p></p>
<h2 id="laravel-jetstream"><a href="#laravel-jetstream">Laravel Jetstream</a></h2>
<p>В то время как Laravel Breeze обеспечивает простую и минимальную отправную точку для создания приложения Laravel,
    Jetstream дополняет эту функциональность более надежными функциями и дополнительными стеками технологий внешнего
    интерфейса. <strong>Для новичков в Laravel мы рекомендуем изучить основы с Laravel Breeze, прежде чем переходить на
        Laravel Jetstream.</strong></p>
<p>Jetstream предоставляет красиво оформленный каркас приложений для Laravel и включает в себя вход в систему,
    регистрацию, проверку электронной почты, двухфакторную аутентификацию, управление сеансом, поддержку API через
    Laravel Sanctum и дополнительное управление командой. Jetstream разработан с использованием <a
            href="https://tailwindcss.com/">Tailwind CSS</a> и предлагает на ваш выбор строительные леса <a
            href="https://inertiajs.com/">внешнего</a> интерфейса, управляемые <a href="https://laravel-livewire.com/">Livewire</a>
    или <a href="https://inertiajs.com/">Inertia.js</a>.</p>
<p>Полную документацию по установке Laravel Jetstream можно найти в <a
            href="https://jetstream.laravel.com/2.x/introduction.html">официальной документации Jetstream</a>.</p>
