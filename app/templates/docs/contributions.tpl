<h1>Руководство по вкладу</h1>
<ul>
    <li><a href="contributions#bug-reports">Отчеты об ошибках</a></li>
    <li><a href="contributions#support-questions">Вопросы поддержки</a></li>
    <li><a href="contributions#core-development-discussion">Обсуждение разработки ядра</a></li>
    <li><a href="contributions#which-branch">В каком отделении?</a></li>
    <li><a href="contributions#compiled-assets">Скомпилированные активы</a></li>
    <li><a href="contributions#security-vulnerabilities">Уязвимости безопасности</a></li>
    <li><a href="contributions#coding-style">Кодирование Стиль</a>
        <ul>
            <li><a href="contributions#phpdoc">PHPDoc</a></li>
            <li><a href="contributions#styleci">StyleCI</a></li>
        </ul>
    </li>
    <li><a href="contributions#code-of-conduct">Нормы поведения</a></li>
</ul>
<p></p>
<h2 id="bug-reports"><a href="#bug-reports">Отчеты об ошибках</a></h2>
<p>Чтобы стимулировать активное сотрудничество, Laravel настоятельно рекомендует запросы на вытягивание, а не только
    отчеты об ошибках. «Отчеты об ошибках» также могут быть отправлены в форме запроса на вытягивание, содержащего
    неудачный тест.</p>
<p>Однако, если вы отправляете отчет об ошибке, ваша проблема должна содержать заголовок и четкое описание проблемы. Вы
    также должны включить как можно больше релевантной информации и образец кода, демонстрирующий проблему. Цель отчета
    об ошибке - упростить для вас и окружающих воспроизведение ошибки и разработку исправления.</p>
<p>Помните, что отчеты об ошибках создаются в надежде, что другие, у кого возникла такая же проблема, смогут
    сотрудничать с вами в ее решении. Не ожидайте, что в отчете об ошибке будет автоматически отображаться какая-либо
    активность или что другие попытаются ее исправить. Создание отчета об ошибке помогает вам и другим начать устранение
    проблемы. Если вы хотите внести свой вклад, вы можете помочь, исправив <a
            href="https://github.com/issues?q=is%3Aopen+is%3Aissue+label%3Abug+user%3Alaravel"
            target="_blank">все ошибки, перечисленные в наших средствах отслеживания проблем</a>. Вы должны быть аутентифицированы на GitHub, чтобы просматривать все проблемы Laravel.</p>
<p>Исходный код Laravel управляется на GitHub, и для каждого проекта Laravel есть репозитории:</p>
<div class="content-list">
    <ul>

        <li><a href="https://github.com/laravel/laravel">Laravel Application</a></li>
        <li><a href="https://github.com/laravel/art">Laravel Art</a></li>
        <li><a href="https://github.com/laravel/docs">Laravel Documentation</a></li>
        <li><a href="https://github.com/laravel/dusk">Laravel Dusk</a></li>
        <li><a href="https://github.com/laravel/cashier">Laravel Cashier Stripe</a></li>
        <li><a href="https://github.com/laravel/cashier-paddle">Laravel Cashier Paddle</a></li>
        <li><a href="https://github.com/laravel/echo">Laravel Echo</a></li>
        <li><a href="https://github.com/laravel/envoy">Laravel Envoy</a></li>
        <li><a href="https://github.com/laravel/framework">Laravel Framework</a></li>
        <li><a href="https://github.com/laravel/homestead">Laravel Homestead</a></li>
        <li><a href="https://github.com/laravel/settler">Laravel Homestead Build Scripts</a></li>
        <li><a href="https://github.com/laravel/horizon">Laravel Horizon</a></li>
        <li><a href="https://github.com/laravel/jetstream">Laravel Jetstream</a></li>
        <li><a href="https://github.com/laravel/passport">Laravel Passport</a></li>
        <li><a href="https://github.com/laravel/sanctum">Laravel Sanctum</a></li>
        <li><a href="https://github.com/laravel/scout">Laravel Scout</a></li>
        <li><a href="https://github.com/laravel/socialite">Laravel Socialite</a></li>
        <li><a href="https://github.com/laravel/telescope">Laravel Telescope</a></li>
        <li><a href="https://github.com/laravel/laravel.com-next">Laravel Website</a></li>
    </ul>
</div>
<p></p>
<h2 id="support-questions"><a href="#support-questions">Вопросы поддержки</a></h2>
<p>Трекеры проблем Laravel GitHub не предназначены для предоставления помощи или поддержки Laravel. Вместо этого
    используйте один из следующих каналов:</p>
<div class="content-list">
    <ul>

        <li><a href="https://github.com/laravel/framework/discussions">GitHub Discussions</a></li>
        <li><a href="https://laracasts.com/discuss">Laracasts Forums</a></li>
        <li><a href="https://laravel.io/forum">Laravel.io Forums</a></li>
        <li><a href="https://stackoverflow.com/questions/tagged/laravel">StackOverflow</a></li>
        <li><a href="https://discordapp.com/invite/KxwQuKb">Discord</a></li>
        <li><a href="https://larachat.co">Larachat</a></li>
        <li><a href="https://webchat.freenode.net/?nick=artisan&amp;amp;channels=%23laravel&amp;amp;prompt=1">IRC</a></li>
    </ul>
</div>
<p></p>
<h2 id="core-development-discussion"><a href="#core-development-discussion">Обсуждение разработки ядра</a></h2>
<p>Вы можете предлагать новые функции или улучшения существующего поведения Laravel на <a
            href="https://github.com/laravel/ideas/issues" target="_blank">доске</a> задач Laravel Ideas . Если вы предлагаете новую
    функцию, пожалуйста, будьте готовы реализовать хотя бы часть кода, который потребуется для завершения функции.</p>
<p>Неформальное обсуждение ошибок, новых функций и реализации существующих функций происходит на <code>#internals</code>
    канале <a href="https://discordapp.com/invite/mPZNm7A">сервера Laravel Discord</a>. Тейлор Отвелл, сопровождающий
    Laravel, обычно присутствует на канале в будние дни с 8:00 до 17:00 (UTC-06: 00 или Америка / Чикаго) и время от
    времени присутствует на канале.</p>
<p></p>
<h2 id="which-branch"><a href="#which-branch">В каком отделении?</a></h2>
<p><strong>Все</strong> исправления ошибок следует отправлять в последнюю стабильную ветку или в <a
            href="releases#support-policy">текущую ветку LTS</a>. Исправления ошибок <strong>никогда не</strong>
    следует отправлять в <code>master</code> ветку, если они не исправляют функции, существующие только в следующем
    выпуске.</p>
<p><strong>Незначительные</strong> функции, <strong>полностью обратно совместимые</strong> с текущим выпуском, могут
    быть отправлены в последнюю стабильную ветку.</p>
<p><strong>Основные</strong> новые функции всегда следует присылать в <code>master</code> ветку, содержащую предстоящий
    выпуск.</p>
<p>Если вы не уверены, относится ли ваша функция к основной или второстепенной, спросите Тейлора Отвелла на <code>#internals</code>
    канале <a href="https://discordapp.com/invite/mPZNm7A">сервера Laravel Discord</a>.</p>
<p></p>
<h2 id="compiled-assets"><a href="#compiled-assets">Скомпилированные активы</a></h2>
<p>Если вы отправляете изменения, которые будут влиять на скомпилированный файл, например, большинство файлов в <code>resources/css</code>
    или <code>resources/js</code> из <code>laravel/laravel</code> хранилища, не совершайте скомпилированные файлы. Из-за
    большого размера они не могут быть реально рассмотрены сопровождающим. Это может быть использовано как способ
    внедрения вредоносного кода в Laravel. Чтобы предотвратить это, все скомпилированные файлы будут сгенерированы и
    зафиксированы сопровождающими Laravel.</p>
<p></p>
<h2 id="security-vulnerabilities"><a href="#security-vulnerabilities">Уязвимости безопасности</a></h2>
<p>Если вы обнаружите уязвимость системы безопасности в Laravel, отправьте электронное письмо Тейлору Отвеллу по адресу
    <a href="https://laravel.com/cdn-cgi/l/email-protection#a2d6c3dbcecdd0e2cec3d0c3d4c7ce8cc1cdcf">taylor@laravel.com</a>
    . Все уязвимости безопасности будут незамедлительно устранены.</p>
<p></p>
<h2 id="coding-style"><a href="#coding-style">Кодирование Стиль</a></h2>
<p>Laravel следует стандарту кодирования <a
            href="https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-2-coding-style-guide.md">PSR-2</a> и
    стандарту автозагрузки <a href="https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-4-autoloader.md">PSR-4</a>
    .</p>
<p></p>
<h3 id="phpdoc"><a href="#phpdoc">PHPDoc</a></h3>
<p>Ниже приведен пример действующего блока документации Laravel. Обратите внимание, что за <code>@param</code> атрибутом
    следуют два пробела, тип аргумента, еще два пробела и, наконец, имя переменной:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Register a binding with the container.
 *
 * @param  string|array  $abstract
 * @param  \Closure|string|null  $concrete
 * @param  bool  $shared
 * @return void
 *
 * @throws \Exception
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">bind</span><span class="token punctuation">(</span><span class="token variable">$abstract</span><span
                class="token punctuation">,</span> <span class="token variable">$concrete</span> <span
                class="token operator">=</span> <span class="token constant">null</span><span class="token punctuation">,</span> <span
                class="token variable">$shared</span> <span class="token operator">=</span> <span
                class="token boolean constant">false</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="styleci"><a href="#styleci">StyleCI</a></h3>
<p>Не волнуйтесь, если стиль вашего кода не идеален! <a href="https://styleci.io/">StyleCI</a> автоматически объединит
    любые исправления стиля в репозиторий Laravel после объединения запросов на вытягивание. Это позволяет нам
    сосредоточиться на содержании статьи, а не на стиле кода.</p>
<p></p>
<h2 id="code-of-conduct"><a href="#code-of-conduct">Нормы поведения</a></h2>
<p>Кодекс поведения Laravel является производным от кодекса поведения Ruby. О любых нарушениях кодекса поведения можно
    сообщить Тейлору Отвеллу ( taylor@laravel.com ):</p>
<div class="content-list">
    <ul>
        <li>Участники будут терпимо относиться к противоположным взглядам.</li>
        <li>Участники должны гарантировать, что их язык и действия не содержат личных нападок и пренебрежительных личных
            замечаний.
        </li>
        <li>Интерпретируя слова и действия других, участники всегда должны исходить из добрых намерений.</li>
        <li>Не допускается поведение, которое можно обоснованно считать преследованием.</li>
    </ul>
</div>
                        