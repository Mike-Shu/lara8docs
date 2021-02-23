<h1>Консоль Artisan</h1>
<ul>
    <li><a href="artisan#introduction">Вступление</a>
        <ul>
            <li><a href="artisan#tinker">Тинкер (REPL)</a></li>
        </ul>
    </li>
    <li><a href="artisan#writing-commands">Написание команд</a>
        <ul>
            <li><a href="artisan#generating-commands">Генерация команд</a></li>
            <li><a href="artisan#command-structure">Структура команды</a></li>
            <li><a href="artisan#closure-commands">Команды закрытия</a></li>
        </ul>
    </li>
    <li><a href="artisan#defining-input-expectations">Определение входных ожиданий</a>
        <ul>
            <li><a href="artisan#arguments">Аргументы</a></li>
            <li><a href="artisan#options">Опции</a></li>
            <li><a href="artisan#input-arrays">Входные массивы</a></li>
            <li><a href="artisan#input-descriptions">Описание входов</a></li>
        </ul>
    </li>
    <li><a href="artisan#command-io">Командный ввод / вывод</a>
        <ul>
            <li><a href="artisan#retrieving-input">Получение ввода</a></li>
            <li><a href="artisan#prompting-for-input">Запрос ввода</a></li>
            <li><a href="artisan#writing-output">Написание вывода</a></li>
        </ul>
    </li>
    <li><a href="artisan#registering-commands">Регистрация команд</a></li>
    <li><a href="artisan#programmatically-executing-commands">Программное выполнение команд</a>
        <ul>
            <li><a href="artisan#calling-commands-from-other-commands">Вызов команд из других команд</a></li>
        </ul>
    </li>
    <li><a href="artisan#stub-customization">Настройка заглушки</a></li>
    <li><a href="artisan#events">События</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Artisan - это интерфейс командной строки, включенный в Laravel. Artisan существует в корне вашего приложения в виде
    <code>artisan</code> сценария и предоставляет ряд полезных команд, которые могут помочь вам при создании вашего
    приложения. Чтобы просмотреть список всех доступных Artisan-команд, вы можете использовать <code>list</code>
    команду:</p>
<pre class=" language-php"><code class=" language-php">php artisan <span class="token keyword">list</span></code></pre>
<p>Каждая команда также включает экран «справки», который отображает и описывает доступные аргументы и параметры
    команды. Чтобы просмотреть экран справки, перед именем команды укажите <code>help</code>:</p>
<pre class=" language-php"><code class=" language-php">php artisan help migrate</code></pre>
<p></p>
<h4 id="laravel-sail"><a href="#laravel-sail">Laravel Парус</a></h4>
<p>Если вы используете <a href="sail">Laravel Sail в</a> качестве локальной среды разработки, не забудьте использовать
    <code>sail</code> командную строку для вызова команд Artisan. Sail выполнит ваши Artisan-команды в контейнерах
    Docker вашего приложения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token punctuation">.</span><span
                class="token operator">/</span>sail artisan <span class="token keyword">list</span></code></pre>
<p></p>
<h3 id="tinker"><a href="#tinker">Тинкер (REPL)</a></h3>
<p>Laravel Tinker - это мощный REPL для фреймворка Laravel, работающий на <a
            href="https://translate.google.com/website?sl=en&amp;tl=ru&amp;prev=search&amp;u=https://github.com/bobthecow/psysh">базе</a>
    пакета <a
            href="https://translate.google.com/website?sl=en&amp;tl=ru&amp;prev=search&amp;u=https://github.com/bobthecow/psysh">PsySH</a>.
</p>
<p></p>
<h4 id="installation"><a href="#installation">Установка</a></h4>
<p>Все приложения Laravel по умолчанию включают Tinker. Однако вы можете установить Tinker с помощью Composer, если вы
    ранее удалили его из своего приложения:</p>
<pre class=" language-php"><code class=" language-php">composer <span class="token keyword">require</span> laravel<span
                class="token operator">/</span>tinker</code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Ищете графический интерфейс для взаимодействия с вашим приложением Laravel? Зацени <a
                    href="https://translate.google.com/website?sl=en&amp;tl=ru&amp;prev=search&amp;u=https://tinkerwell.app">Тинкеруэлл</a>
            !</p></p></div>
</blockquote>
<p></p>
<h4 id="usage"><a href="#usage">использование</a></h4>
<p>Tinker позволяет вам взаимодействовать со всем вашим приложением Laravel в командной строке, включая ваши модели
    Eloquent, задания, события и многое другое. Чтобы войти в среду Tinker, выполните команду <code>tinker</code>
    Artisan:</p>
<pre class=" language-php"><code class=" language-php">php artisan tinker</code></pre>
<p>Вы можете опубликовать файл конфигурации Tinker с помощью <code>vendor:publish</code> команды:</p>
<pre class=" language-php"><code class=" language-php">php artisan vendor<span class="token punctuation">:</span>publish <span
                class="token operator">--</span>provider<span class="token operator">=</span><span
                class="token double-quoted-string string">"Laravel\Tinker\TinkerServiceProvider"</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p><code>dispatch</code> Вспомогательная функция и <code>dispatch</code> метод на <code>Dispatchable</code>
            классе зависит от сбора мусора, чтобы поместить работу в очереди. Следовательно, при использовании tinker вы
            должны использовать <code>Bus::dispatch</code> или <code>Queue::push</code> для отправки заданий.</p></p>
    </div>
</blockquote>
<p></p>
<h4 id="command-allow-list"><a href="#command-allow-list">Список разрешенных команд</a></h4>
<p>Tinker использует список «разрешенных», чтобы определить, какие команды Artisan разрешено запускать в его оболочке.
    По умолчанию, вы можете запустить <code>clear-compiled</code>, <code>down</code>, <code>env</code>,
    <code>inspire</code>, <code>migrate</code>, <code>optimize</code> и <code>up</code> команду. Если вы хотите
    разрешить больше команд, вы можете добавить их в <code>commands</code> массив в вашем <code>tinker.php</code> файле
    конфигурации:</p>
<pre class=" language-php"><code class=" language-php"><span class="token single-quoted-string string">'commands'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token comment">// App\Console\Commands\ExampleCommand::class,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p></p>
<h4 id="classes-that-should-not-be-aliased"><a href="#classes-that-should-not-be-aliased">Классы, которые не должны
        иметь псевдонимов</a></h4>
<p>Обычно Tinker автоматически присваивает классам псевдонимы, когда вы взаимодействуете с ними в Tinker. Однако вы
    можете никогда не использовать псевдонимы для некоторых классов. Вы можете сделать это, перечислив классы в <code>dont_alias</code>
    массиве вашего <code>tinker.php</code> файла конфигурации:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'dont_alias'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
    App\<span class="token package">Models<span class="token punctuation">\</span>User</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p></p>
<h2 id="writing-commands"><a href="#writing-commands">Написание команд</a></h2>
<p>В дополнение к командам, предоставленным Artisan, вы можете создавать свои собственные пользовательские команды.
    Команды обычно хранятся в <code>app/Console/Commands</code> каталоге; однако вы можете выбрать свое собственное
    место хранения, если ваши команды могут быть загружены Composer.</p>
<p></p>
<h3 id="generating-commands"><a href="#generating-commands">Генерация команд</a></h3>
<p>Чтобы создать новую команду, вы можете использовать <code>make:command</code> Artisan-команду. Эта команда создаст
    новый класс команд в <code>app/Console/Commands</code> каталоге. Не волнуйтесь, если этот каталог не существует в
    вашем приложении - он будет создан при первом запуске <code>make:command</code> Artisan-команды:</p>
<pre class=" language-php"><code class=" language-php">php artisan make<span class="token punctuation">:</span>command SendEmails</code></pre>
<p></p>
<h3 id="command-structure"><a href="#command-structure">Структура команды</a></h3>
<p>После создания вашей команды, вы должны определить соответствующие значения для <code>signature</code> и <code>description</code>
    свойств класса. Эти свойства будут использоваться при отображении вашей команды на <code>list</code> экране. <code>signature</code>
    Свойство также позволяет определить <a href="artisan#defining-input-expectations">входные ожидания вашего
        командования</a>. <code>handle</code> Метод будет вызываться, когда ваша команда будет выполнена. Вы можете
    поместить свою командную логику в этот метод.</p>
<p>Давайте посмотрим на пример команды. Обратите внимание, что мы можем запрашивать любые зависимости, которые нам
    нужны, с помощью <code>handle</code> метода команды. <a href="container">Сервисный контейнер</a> Laravel
    автоматически внедрит все зависимости, которые указаны в сигнатуре этого метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Console<span
                        class="token punctuation">\</span>Commands</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>DripEmailer</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Console<span
                        class="token punctuation">\</span>Command</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">SendEmails</span> <span class="token keyword">extends</span> <span
                    class="token class-name">Command</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * The name and signature of the console command.
    *
    * @var string
    */</span>
    <span class="token keyword">protected</span> <span class="token variable">$signature</span> <span
                    class="token operator">=</span> <span
                    class="token single-quoted-string string">'mail:send {literal}{user}{/literal}'</span><span
                    class="token punctuation">;</span>

    <span class="token comment">/**
    * The console command description.
    *
    * @var string
    */</span>
    <span class="token keyword">protected</span> <span class="token variable">$description</span> <span
                    class="token operator">=</span> <span class="token single-quoted-string string">'Send a marketing email to a user'</span><span
                    class="token punctuation">;</span>

    <span class="token comment">/**
    * Create a new command instance.
    *
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">__construct</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">parent</span><span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token function">__construct</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
    * Execute the console command.
    *
    * @param  \App\Support\DripEmailer  $drip
    * @return mixed
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">handle</span><span
                    class="token punctuation">(</span>DripEmailer <span class="token variable">$drip</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$drip</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">send</span><span
                    class="token punctuation">(</span>User<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token function">find</span><span
                    class="token punctuation">(</span><span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">argument</span><span
                    class="token punctuation">(</span><span class="token single-quoted-string string">'user'</span><span
                    class="token punctuation">)</span><span class="token punctuation">)</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Для более широкого повторного использования кода рекомендуется держать консольные команды светлыми и
            позволять им доверять выполнение своих задач службам приложений. Обратите внимание, что в приведенном выше
            примере мы внедряем класс обслуживания, чтобы выполнить «тяжелую работу» по отправке электронных
            писем.</p></p></div>
</blockquote>
<p></p>
<h3 id="closure-commands"><a href="#closure-commands">Команды закрытия</a></h3>
<p>Команды на основе замыкания предоставляют альтернативу определению консольных команд как классов. Точно так же, как
    закрытие маршрута является альтернативой контроллерам, думайте о закрытии команд как об альтернативе классам команд.
    В рамках <code>commands</code> метода вашего <code>app/Console/Kernel.php</code> файла Laravel загружает <code>routes/console.php</code>
    файл:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Register the closure based commands for the application.
 *
 * @return void
 */</span>
<span class="token keyword">protected</span> <span class="token keyword">function</span> <span class="token function">commands</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">require</span> <span class="token function">base_path</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'routes/console.php'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Несмотря на то, что этот файл не определяет маршруты HTTP, он определяет точки входа (маршруты) в ваше приложение на
    основе консоли. В этом файле вы можете определить все свои консольные команды на основе закрытия, используя <code>Artisan::command</code>
    метод. <code>command</code> Метод принимает два аргумента: <a href="artisan#defining-input-expectations">команда
        подпись</a> и замыкание, которое принимает аргументы и параметры данной команды:</p>
<pre class=" language-php"><code class=" language-php">Artisan<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">command</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'mail:send {literal}{user}{/literal}'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">info</span><span
                class="token punctuation">(</span><span
                class="token double-quoted-string string">"Sending email to: <span class="token interpolation"><span
                        class="token punctuation">{literal}{{/literal}</span><span
                        class="token variable">$user</span><span class="token punctuation">}</span></span>!"</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Замыкание привязано к базовому экземпляру команды, поэтому у вас есть полный доступ ко всем вспомогательным методам,
    к которым вы обычно можете получить доступ в полном классе команд.</p>
<p></p>
<h4 id="type-hinting-dependencies"><a href="#type-hinting-dependencies">Типовые зависимости</a></h4>
<p>Помимо получения аргументов и опций вашей команды, закрытие команд также может указывать на дополнительные
    зависимости, которые вы хотели бы разрешить вне <a href="container">контейнера службы</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>DripEmailer</span><span class="token punctuation">;</span>

Artisan<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">command</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'mail:send {literal}{user}{/literal}'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>DripEmailer <span class="token variable">$drip</span><span
                class="token punctuation">,</span> <span class="token variable">$user</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$drip</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">send</span><span
                class="token punctuation">(</span>User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="closure-command-descriptions"><a href="#closure-command-descriptions">Описание команд закрытия</a></h4>
<p>При определении команды на основе замыкания вы можете использовать <code>purpose</code> метод для добавления описания
    к команде. Это описание будет отображаться при запуске команд <code>php artisan list</code> или
    <code>php artisan help</code>:</p>
<pre class=" language-php"><code class=" language-php">Artisan<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">command</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'mail:send {literal}{user}{/literal}'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">purpose</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Send a marketing email to a user'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="defining-input-expectations"><a href="#defining-input-expectations">Определение входных ожиданий</a></h2>
<p>При написании консольных команд обычно вводятся данные от пользователя с помощью аргументов или параметров. Laravel
    позволяет очень удобно определять ввод, который вы ожидаете от пользователя, используя <code>signature</code>
    свойство в ваших командах. <code>signature</code> Свойство позволяет определить имя, аргументы и варианты команды в
    одном, выразительных, маршрут-подобный синтаксис.</p>
<p></p>
<h3 id="arguments"><a href="#arguments">Аргументы</a></h3>
<p>Все аргументы и параметры, предоставленные пользователем, заключены в фигурные скобки. В следующем примере команда
    определяет один обязательный аргумент <code>user</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * The name and signature of the console command.
 *
 * @var string
 */</span>
<span class="token keyword">protected</span> <span class="token variable">$signature</span> <span
                class="token operator">=</span> <span
                class="token single-quoted-string string">'mail:send {literal}{user}{/literal}'</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы также можете сделать аргументы необязательными или определить значения по умолчанию для аргументов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">// Optional argument...</span>
mail<span class="token punctuation">:</span>send <span class="token punctuation">{literal}{{/literal}</span>user<span
                class="token operator">?</span><span class="token punctuation">}</span>

<span class="token comment">// Optional argument with default value...</span>
mail<span class="token punctuation">:</span>send <span class="token punctuation">{literal}{{/literal}</span>user<span
                class="token operator">=</span>foo<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="options"><a href="#options">Опции</a></h3>
<p>Параметры, как и аргументы, являются еще одной формой пользовательского ввода. Параметры начинаются с двух дефисов (
    <code>--</code> ), когда они предоставляются через командную строку. Есть два типа вариантов: те, которые получают
    значение, и те, которые не получают. Опции, которые не получают значения, служат логическим «переключателем».
    Давайте посмотрим на пример такого типа опций:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * The name and signature of the console command.
 *
 * @var string
 */</span>
<span class="token keyword">protected</span> <span class="token variable">$signature</span> <span
                class="token operator">=</span> <span
                class="token single-quoted-string string">'mail:send {literal}{user}{/literal} {literal}{--queue}{/literal}'</span><span
                class="token punctuation">;</span></code></pre>
<p>В этом примере <code>--queue</code> переключатель может быть указан при вызове команды Artisan. Если
    <code>--queue</code> переключатель передан, значение параметра будет <code>true</code>. В противном случае значение
    будет <code>false</code>:</p>
<pre class=" language-php"><code class=" language-php">php artisan mail<span
                class="token punctuation">:</span>send <span class="token number">1</span> <span class="token operator">--</span>queue</code></pre>
<p></p>
<h4 id="options-with-values"><a href="#options-with-values">Параметры со значениями</a></h4>
<p>Далее давайте посмотрим на вариант, который ожидает значение. Если пользователь должен указать значение для
    параметра, вы должны добавить к имени параметра <code>=</code> знак:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * The name and signature of the console command.
 *
 * @var string
 */</span>
<span class="token keyword">protected</span> <span class="token variable">$signature</span> <span
                class="token operator">=</span> <span
                class="token single-quoted-string string">'mail:send {literal}{user}{/literal} {literal}{--queue=}{/literal}'</span><span
                class="token punctuation">;</span></code></pre>
<p>В этом примере пользователь может передать такое значение для параметра. Если опция не указана при вызове команды, ее
    значение будет <code>null</code>:</p>
<pre class=" language-php"><code class=" language-php">php artisan mail<span
                class="token punctuation">:</span>send <span class="token number">1</span> <span class="token operator">--</span>queue<span
                class="token operator">=</span><span class="token keyword">default</span></code></pre>
<p>Вы можете присвоить параметрам значения по умолчанию, указав значение по умолчанию после имени параметра. Если
    пользователь не передал значение параметра, будет использоваться значение по умолчанию:</p>
<pre class=" language-php"><code class=" language-php">mail<span class="token punctuation">:</span>send <span
                class="token punctuation">{literal}{{/literal}</span>user<span class="token punctuation">}</span> <span
                class="token punctuation">{literal}{{/literal}</span><span class="token operator">--</span>queue<span
                class="token operator">=</span><span class="token keyword">default</span><span
                class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="option-shortcuts"><a href="#option-shortcuts">Варианты быстрого доступа</a></h4>
<p>Чтобы назначить ярлык при определении параметра, вы можете указать его перед именем параметра и использовать
    <code>|</code> символ в качестве разделителя, чтобы отделить ярлык от полного имени параметра:</p>
<pre class=" language-php"><code class=" language-php">mail<span class="token punctuation">:</span>send <span
                class="token punctuation">{literal}{{/literal}</span>user<span class="token punctuation">}</span> <span
                class="token punctuation">{literal}{{/literal}</span><span class="token operator">--</span><span
                class="token constant">Q</span><span class="token operator">|</span>queue<span
                class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="input-arrays"><a href="#input-arrays">Входные массивы</a></h3>
<p>Если вы хотите определить аргументы или параметры для ожидания нескольких входных значений, вы можете использовать
    <code>*</code> символ. Во-первых, давайте взглянем на пример, который определяет такой аргумент:</p>
<pre class=" language-php"><code class=" language-php">mail<span class="token punctuation">:</span>send <span
                class="token punctuation">{literal}{{/literal}</span>user<span class="token operator">*</span><span
                class="token punctuation">}</span></code></pre>
<p>При вызове этого метода <code>user</code> аргументы могут передаваться в командную строку по порядку. Например,
    следующая команда установит значение <code>user</code> массива с <code>foo</code> и в <code>bar</code> качестве его
    значений:</p>
<pre class=" language-php"><code class=" language-php">php artisan mail<span class="token punctuation">:</span>send foo bar</code></pre>
<p></p>
<h4 id="option-arrays"><a href="#option-arrays">Массивы вариантов</a></h4>
<p>При определении параметра, который ожидает несколько входных значений, каждое значение параметра, передаваемое
    команде, должно иметь префикс с именем параметра:</p>
<pre class=" language-php"><code class=" language-php">mail<span class="token punctuation">:</span>send <span
                class="token punctuation">{literal}{{/literal}</span>user<span class="token punctuation">}</span> <span
                class="token punctuation">{literal}{{/literal}</span><span class="token operator">--</span>id<span
                class="token operator">=</span><span class="token operator">*</span><span
                class="token punctuation">}</span>

php artisan mail<span class="token punctuation">:</span>send <span class="token operator">--</span>id<span
                class="token operator">=</span><span class="token number">1</span> <span
                class="token operator">--</span>id<span class="token operator">=</span><span
                class="token number">2</span></code></pre>
<p></p>
<h3 id="input-descriptions"><a href="#input-descriptions">Описание входов</a></h3>
<p>Вы можете назначить описания входным аргументам и параметрам, отделив имя аргумента от описания двоеточием. Если вам
    нужно немного больше места для определения вашей команды, не стесняйтесь распространять определение на несколько
    строк:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * The name and signature of the console command.
 *
 * @var string
 */</span>
<span class="token keyword">protected</span> <span class="token variable">$signature</span> <span
                class="token operator">=</span> <span class="token single-quoted-string string">'mail:send
                        {literal}{user: The ID of the user}{/literal}
                        {literal}{--queue=: Whether the job should be queued}{/literal}'</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="command-io"><a href="#command-io">Командный ввод / вывод</a></h2>
<p></p>
<h3 id="retrieving-input"><a href="#retrieving-input">Получение ввода</a></h3>
<p>Пока ваша команда выполняется, вам, вероятно, потребуется получить доступ к значениям аргументов и параметров,
    принимаемых вашей командой. Для этого вы можете использовать <code>argument</code> и <code>option</code> методы.
    Если аргумент или опция не существует, <code>null</code> будет возвращено:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Execute the console command.
 *
 * @return int
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">handle</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$userId</span> <span class="token operator">=</span> <span
                class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">argument</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'user'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p>Если вам нужно получить все аргументы в виде <code>array</code>, вызовите <code>arguments</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$arguments</span> <span
                class="token operator">=</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">arguments</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Параметры можно получить так же легко, как и аргументы, используя <code>option</code> метод. Чтобы получить все
    параметры в виде массива, вызовите <code>options</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token comment">// Retrieve a specific option...</span>
<span class="token variable">$queueName</span> <span class="token operator">=</span> <span
                class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">option</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'queue'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// Retrieve all options as an array...</span>
<span class="token variable">$options</span> <span class="token operator">=</span> <span
                class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">options</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="prompting-for-input"><a href="#prompting-for-input">Запрос ввода</a></h3>
<p>В дополнение к отображению вывода вы также можете попросить пользователя ввести ввод во время выполнения вашей
    команды. <code>ask</code> Метод предложит пользователю с данным вопросом, принять их ввод, а затем вернуть обратно
    ввод пользователя к вашей команде:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Execute the console command.
 *
 * @return mixed
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">handle</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$name</span> <span class="token operator">=</span> <span
                class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">ask</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'What is your name?'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p><code>secret</code> Метод аналогичен <code>ask</code>, но вход пользователя не будет виден им, как они типа в
    консоли. Этот метод полезен при запросе конфиденциальной информации, такой как пароли:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$password</span> <span
                class="token operator">=</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">secret</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'What is the password?'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="asking-for-confirmation"><a href="#asking-for-confirmation">Просить подтверждения</a></h4>
<p>Если вам нужно попросить пользователя дать простое подтверждение «да или нет», вы можете использовать этот <code>confirm</code>
    метод. По умолчанию этот метод вернется <code>false</code>. Однако, если пользователь вводит запрос <code>y</code>
    или <code>yes</code> отвечает на него, метод вернется <code>true</code>.</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">if</span> <span
                class="token punctuation">(</span><span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">confirm</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Do you wish to continue?'</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p>При необходимости вы можете указать, что запрос подтверждения должен возвращаться <code>true</code> по умолчанию,
    передав его <code>true</code> в качестве второго аргумента <code>confirm</code> методу:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">if</span> <span
                class="token punctuation">(</span><span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">confirm</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Do you wish to continue?'</span><span
                class="token punctuation">,</span> <span class="token boolean constant">true</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="auto-completion"><a href="#auto-completion">Автозаполнение</a></h4>
<p>Этот <code>anticipate</code> метод может использоваться для автоматического завершения возможных вариантов.
    Пользователь по-прежнему может дать любой ответ, независимо от подсказок автозаполнения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$name</span> <span
                class="token operator">=</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">anticipate</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'What is your name?'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'Taylor'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Dayle'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>В качестве альтернативы вы можете передать закрытие в качестве второго аргумента <code>anticipate</code> метода.
    Замыкание будет вызываться каждый раз, когда пользователь вводит вводимый символ. Замыкание должно принимать
    строковый параметр, содержащий введенные пользователем данные, и возвращать массив параметров для автозаполнения:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$name</span> <span
                class="token operator">=</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">anticipate</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'What is your address?'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$input</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// Return auto-completion options...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="multiple-choice-questions"><a href="#multiple-choice-questions">Вопросы с множественным выбором</a></h4>
<p>Если вам нужно предоставить пользователю предопределенный набор вариантов выбора при задании вопроса, вы можете
    использовать этот <code>choice</code> метод. Вы можете установить индекс массива для значения по умолчанию, которое
    будет возвращаться, если не выбран ни один из вариантов, передав индекс в качестве третьего аргумента метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$name</span> <span
                class="token operator">=</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">choice</span><span
                class="token punctuation">(</span>
    <span class="token single-quoted-string string">'What is your name?'</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'Taylor'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'Dayle'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token variable">$defaultIndex</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Кроме того, <code>choice</code> метод принимает необязательные четвертый и пятый аргументы для определения
    максимального количества попыток выбора допустимого ответа и разрешения множественного выбора:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$name</span> <span
                class="token operator">=</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">choice</span><span
                class="token punctuation">(</span>
    <span class="token single-quoted-string string">'What is your name?'</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'Taylor'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'Dayle'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token variable">$defaultIndex</span><span class="token punctuation">,</span>
    <span class="token variable">$maxAttempts</span> <span class="token operator">=</span> <span class="token constant">null</span><span
                class="token punctuation">,</span>
    <span class="token variable">$allowMultipleSelections</span> <span class="token operator">=</span> <span
                class="token boolean constant">false</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="writing-output"><a href="#writing-output">Написание вывода</a></h3>
<p>Для отправки вывода на консоль, вы можете использовать <code>line</code>, <code>info</code>, <code>comment</code>,
    <code>question</code> и <code>error</code> методу. Каждый из этих методов будет использовать соответствующие цвета
    ANSI для своей цели. Например, давайте покажем пользователю некоторую общую информацию. Обычно <code>info</code>
    метод отображается в консоли в виде текста зеленого цвета:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Execute the console command.
 *
 * @return mixed
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">handle</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//...</span>

    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">info</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'The command was successful!'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Чтобы отобразить сообщение об ошибке, используйте <code>error</code> метод. Текст сообщения об ошибке обычно
    отображается красным цветом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">error</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Something went wrong!'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете использовать этот <code>line</code> метод для отображения простого неокрашенного текста:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">line</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Display this on the screen'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете использовать этот <code>newLine</code> метод для отображения пустой строки:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token comment">// Write a single blank line...</span>
<span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">newLine</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// Write three blank lines...</span>
<span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">newLine</span><span
                class="token punctuation">(</span><span class="token number">3</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="tables"><a href="#tables">Столы</a></h4>
<p>Этот <code>table</code> метод позволяет легко правильно форматировать несколько строк / столбцов данных. Все, что вам
    нужно сделать, это указать имена столбцов и данные для таблицы, и Laravel автоматически вычислит для вас подходящую
    ширину и высоту таблицы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

<span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">table</span><span
                class="token punctuation">(</span>
    <span class="token punctuation">[</span><span class="token single-quoted-string string">'Name'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'Email'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    User<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">all</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'name'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'email'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">toArray</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="progress-bars"><a href="#progress-bars">Индикаторы прогресса</a></h4>
<p>Для длительных задач может быть полезно показать индикатор выполнения, который информирует пользователей о том,
    насколько завершена задача. Используя этот <code>withProgressBar</code> метод, Laravel будет отображать индикатор
    выполнения и продвигать свой прогресс для каждой итерации по заданному повторяемому значению:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

<span class="token variable">$users</span> <span class="token operator">=</span> <span
                class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">withProgressBar</span><span class="token punctuation">(</span>User<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">performTask</span><span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Иногда вам может потребоваться больше ручного контроля над продвижением индикатора выполнения. Сначала определите
    общее количество шагов, через которые будет проходить процесс. Затем продвигайте индикатор выполнения после
    обработки каждого элемента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> App\<span class="token package">Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">all</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$bar</span> <span class="token operator">=</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">output</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">createProgressBar</span><span
                class="token punctuation">(</span><span class="token function">count</span><span
                class="token punctuation">(</span><span class="token variable">$users</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$bar</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">start</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token keyword">foreach</span> <span class="token punctuation">(</span><span
                class="token variable">$users</span> <span class="token keyword">as</span> <span class="token variable">$user</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">performTask</span><span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

    <span class="token variable">$bar</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">advance</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span>

<span class="token variable">$bar</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">finish</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Чтобы узнать о дополнительных параметрах, ознакомьтесь с <a
                    href="https://translate.google.com/website?sl=en&amp;tl=ru&amp;prev=search&amp;u=https://symfony.com/doc/current/components/console/helpers/progressbar.html">документацией
                по компонентам Symfony Progress Bar</a>.</p></p></div>
</blockquote>
<p></p>
<h2 id="registering-commands"><a href="#registering-commands">Регистрация команд</a></h2>
<p>Все ваши консольные команды зарегистрированы в <code>App\Console\Kernel</code> классе вашего приложения, который
    является «ядром консоли» вашего приложения. Внутри <code>commands</code> метода этого класса вы увидите вызов <code>load</code>
    метода ядра. <code>load</code> Метод будет сканировать <code>app/Console/Commands</code> каталог и автоматически
    регистрировать каждую команду он содержит с Artisan. Вы даже можете выполнять дополнительные вызовы
    <code>load</code> метода для сканирования других каталогов на предмет команд Artisan:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Register the commands for the application.
 *
 * @return void
 */</span>
<span class="token keyword">protected</span> <span class="token keyword">function</span> <span class="token function">commands</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">load</span><span
                class="token punctuation">(</span><span class="token constant">__DIR__</span><span
                class="token punctuation">.</span><span
                class="token single-quoted-string string">'/Commands'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">load</span><span
                class="token punctuation">(</span><span class="token constant">__DIR__</span><span
                class="token punctuation">.</span><span class="token single-quoted-string string">'/../Domain/Orders/Commands'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

    <span class="token comment">//...</span>
<span class="token punctuation">}</span></code></pre>
<p>При необходимости вы можете вручную зарегистрировать команды, добавив имя класса команды в <code>$commands</code>
    свойство вашего <code>App\Console\Kernel</code> класса. Когда Artisan загружается, все команды, перечисленные в этом
    свойстве, будут разрешены <a href="container">сервисным контейнером</a> и зарегистрированы в Artisan:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">protected</span> <span
                class="token variable">$commands</span> <span class="token operator">=</span> <span
                class="token punctuation">[</span>
    Commands\<span class="token package">SendEmails</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span>
<span class="token punctuation">]</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="programmatically-executing-commands"><a href="#programmatically-executing-commands">Программное выполнение
        команд</a></h2>
<p>Иногда вы можете захотеть выполнить Artisan-команду вне CLI. Например, вы можете захотеть выполнить Artisan-команду
    из маршрута или контроллера. Для этого вы можете использовать <code>call</code> метод на <code>Artisan</code>
    фасаде. <code>call</code> Метод принимает либо имя командования подписи или имя класса в качестве первого аргумента,
    и массив параметров команды в качестве второго аргумента. Будет возвращен код выхода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Artisan</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">post</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/user/{literal}{user}{/literal}/mail'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$exitCode</span> <span class="token operator">=</span> Artisan<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">call</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'mail:send'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'user'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$user</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'--queue'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'default'</span>
    <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>В качестве альтернативы вы можете передать всю команду Artisan <code>call</code> методу в виде строки:</p>
<pre class=" language-php"><code class=" language-php">Artisan<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">call</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'mail:send 1 --queue=default'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="passing-array-values"><a href="#passing-array-values">Передача значений массива</a></h4>
<p>Если ваша команда определяет параметр, который принимает массив, вы можете передать в этот параметр массив
    значений:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Artisan</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">post</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/mail'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$exitCode</span> <span class="token operator">=</span> Artisan<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">call</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'mail:send'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'--id'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span><span
                class="token number">5</span><span class="token punctuation">,</span> <span
                class="token number">13</span><span class="token punctuation">]</span>
    <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="passing-boolean-values"><a href="#passing-boolean-values">Передача логических значений</a></h4>
<p>Если вам нужно указать значение параметра, который не принимает строковые значения, например <code>--force</code>
    флаг в <code>migrate:refresh</code> команде, вы должны передать <code>true</code> или <code>false</code> в качестве
    значения параметра:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$exitCode</span> <span
                class="token operator">=</span> Artisan<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">call</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'migrate:refresh'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'--force'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token boolean constant">true</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="queueing-artisan-commands"><a href="#queueing-artisan-commands">Очередь команд Artisan</a></h4>
<p>Используя <code>queue</code> метод на <code>Artisan</code> фасаде, вы можете даже ставить Artisan-команды в очередь,
    чтобы они обрабатывались в фоновом режиме вашими <a href="queues">работниками очереди</a>. Перед использованием
    этого метода убедитесь, что вы настроили свою очередь и запускаете прослушиватель очереди:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Artisan</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">post</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/user/{literal}{user}{/literal}/mail'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$user</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    Artisan<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">queue</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'mail:send'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'user'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token variable">$user</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'--queue'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'default'</span>
    <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Использование <code>onConnection</code> и <code>onQueue</code> методы, вы можете указать соединение или очереди
    команды Artisan должны быть отправлены:</p>
<pre class=" language-php"><code class=" language-php">Artisan<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">queue</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'mail:send'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'user'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">1</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'--queue'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'default'</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">onConnection</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'redis'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">onQueue</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'commands'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="calling-commands-from-other-commands"><a href="#calling-commands-from-other-commands">Вызов команд из других
        команд</a></h3>
<p>Иногда вам может потребоваться вызвать другие команды из существующей команды Artisan. Вы можете сделать это с
    помощью <code>call</code> метода. Этот <code>call</code> метод принимает имя команды и массив аргументов /
    параметров команды:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Execute the console command.
 *
 * @return mixed
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">handle</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">call</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'mail:send'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'user'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">1</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'--queue'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'default'</span>
    <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
<p>Если вы хотите вызвать другую консольную команду и подавить весь ее вывод, вы можете использовать этот <code>callSilently</code>
    метод. <code>callSilently</code> Метод имеет ту же сигнатуру, что и <code>call</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">callSilently</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'mail:send'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'user'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">1</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'--queue'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'default'</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="stub-customization"><a href="#stub-customization">Настройка заглушки</a></h2>
<p><code>make</code> Команды консоли Artisan используются для создания различных классов, таких как контроллеры,
    задания, миграции и тесты. Эти классы создаются с использованием файлов-заглушек, которые заполняются значениями на
    основе ваших входных данных. Однако вы можете захотеть внести небольшие изменения в файлы, созданные Artisan. Для
    этого вы можете использовать <code>stub:publish</code> команду для публикации наиболее распространенных заглушек в
    вашем приложении, чтобы вы могли их настраивать:</p>
<pre class=" language-php"><code class=" language-php">php artisan stub<span
                class="token punctuation">:</span>publish</code></pre>
<p>Опубликованные заглушки будут расположены в <code>stubs</code> каталоге в корне вашего приложения. Любые изменения,
    внесенные вами в эти заглушки, будут отражены при создании соответствующих классов с помощью <code>make</code>
    команд Artisan.</p>
<p></p>
<h2 id="events"><a href="#events">События</a></h2>
<p>Artisan отправляет три события при запуске команды: <code>Illuminate\Console\Events\ArtisanStarting</code>, <code>Illuminate\Console\Events\CommandStarting</code>
    и <code>Illuminate\Console\Events\CommandFinished</code>. <code>ArtisanStarting</code> Событие отправляется сразу
    после Artisan начинает работать. Затем <code>CommandStarting</code> событие отправляется непосредственно перед
    запуском команды. Наконец, <code>CommandFinished</code> событие отправляется после завершения выполнения команды.
</p>
