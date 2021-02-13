<h1>Руководство по обновлению</h1>
<ul>
    <li><a href="upgrade#upgrade-8.0">Обновление до 8.0 с 7.x</a></li>
</ul>
<p></p>
<h2 id="high-impact-changes"><a href="#high-impact-changes">Изменения, оказывающие большое влияние</a></h2>
<div class="content-list">
    <ul>
        <li><a href="upgrade#model-factories">Модельные фабрики</a></li>
        <li><a href="upgrade#queue-retry-after-method"><code>retryAfter</code> Метод очереди</a></li>
        <li><a href="upgrade#queue-timeout-at-property"><code>timeoutAt</code> Свойство очереди</a></li>
        <li><a href="upgrade#queue-allOnQueue-allOnConnection">Очередь <code>allOnQueue</code>
                и<code>allOnConnection</code></a></li>
        <li><a href="upgrade#pagination-defaults">Пагинация по умолчанию</a></li>
        <li><a href="upgrade#seeder-factory-namespaces">Пространства имен Seeder и Factory</a></li>
    </ul>
</div>
<p></p>
<h2 id="medium-impact-changes"><a href="#medium-impact-changes">Изменения со средней степенью воздействия</a></h2>
<div class="content-list">
    <ul>
        <li><a href="upgrade#php-7.3.0-required">Требуется PHP 7.3.0</a></li>
        <li><a href="upgrade#failed-jobs-table-batch-support">Пакетная поддержка таблицы невыполненных заданий</a></li>
        <li><a href="upgrade#maintenance-mode-updates">Обновления режима обслуживания</a></li>
        <li><a href="upgrade#artisan-down-message"><code>php artisan down --message</code> Вариант</a></li>
        <li><a href="upgrade#assert-exact-json-method"><code>assertExactJson</code> Метод</a></li>
    </ul>
</div>
<p></p>
<h2 id="upgrade-8.0"><a href="#upgrade-8.0">Обновление до 8.0 с 7.x</a></h2>
<p></p>
<h4 id="estimated-upgrade-time-15-minutes"><a href="#estimated-upgrade-time-15-minutes">Приблизительное время
        обновления: 15 минут</a></h4>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0">
            <img src="img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Мы стараемся задокументировать все возможные критические изменения. Поскольку некоторые из этих критических
            изменений находятся в малоизвестных частях фреймворка, только часть этих изменений может повлиять на ваше
            приложение.</p></p></div>
</blockquote>
<p></p>
<h3 id="php-7.3.0-required"><a href="#php-7.3.0-required">Требуется PHP 7.3.0</a></h3>
<p><strong>Вероятность воздействия: средняя</strong></p>
<p>Новая минимальная версия PHP теперь 7.3.0.</p>
<p></p>
<h3 id="updating-dependencies"><a href="#updating-dependencies">Обновление зависимостей</a></h3>
<p>Обновите следующие зависимости в своем <code>composer.json</code> файле:</p>
<div class="content-list">
    <ul>
        <li><code>guzzlehttp/guzzle</code> к <code>^7.0.1</code></li>
        <li><code>facade/ignition</code> к <code>^2.3.6</code></li>
        <li><code>laravel/framework</code> к <code>^8.0</code></li>
        <li><code>laravel/ui</code> к <code>^3.0</code></li>
        <li><code>nunomaduro/collision</code> к <code>^5.0</code></li>
        <li><code>phpunit/phpunit</code> к <code>^9.0</code></li>
    </ul>
</div>
<p>Следующие основные пакеты имеют новые основные выпуски для поддержки Laravel 8. Если возможно, перед обновлением вы
    должны прочитать соответствующие руководства по обновлению:</p>
<div class="content-list">
    <ul>
        <li>
            <a href="https://github.com/laravel/horizon/blob/master/UPGRADE.md">Horizon
                v5.0</a></li>
        <li>
            <a href="https://github.com/laravel/passport/blob/master/UPGRADE.md">Паспорт
                v10.0</a></li>
        <li>
            <a href="https://github.com/laravel/socialite/blob/master/UPGRADE.md">Светская
                львица v5.0</a></li>
        <li>
            <a href="https://github.com/laravel/telescope/blob/master/UPGRADE.md">Телескоп
                v4.0</a></li>
    </ul>
</div>
<p>Кроме того, установщик Laravel был обновлен для поддержки <code>composer create-project</code> и Laravel Jetstream.
    Любой установщик старше 4.0 перестанет работать после октября 2020 года. Вам следует <code>^4.0</code> как можно
    скорее обновить глобальный установщик.</p>
<p>Наконец, изучите любые другие сторонние пакеты, используемые вашим приложением, и убедитесь, что вы используете
    правильную версию для поддержки Laravel 8.</p>
<p></p>
<h3 id="collections"><a href="#collections">Коллекции</a></h3>
<p></p>
<h4 id="the-isset-method"><a href="#the-isset-method"><code>isset</code> Метод</a></h4>
<p><strong>Вероятность воздействия: низкая</strong></p>
<p>Чтобы соответствовать типичному поведению PHP, был обновлен <code>offsetExists</code> метод <code>Illuminate\Support\Collection</code>
    использования <code>isset</code> вместо <code>array_key_exists</code>. Это может привести к изменению поведения при
    работе с элементами коллекции, имеющими значение <code>null</code> :</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$collection</span> <span
                class="token operator">=</span> <span class="token function">collect</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span class="token constant">null</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// Laravel 7.x - true</span>
<span class="token keyword">isset</span><span class="token punctuation">(</span><span
            class="token variable">$collection</span><span class="token punctuation">[</span><span class="token number">0</span><span
            class="token punctuation">]</span><span class="token punctuation">)</span><span
            class="token punctuation">;</span>

<span class="token comment">// Laravel 8.x - false</span>
<span class="token keyword">isset</span><span class="token punctuation">(</span><span
            class="token variable">$collection</span><span class="token punctuation">[</span><span class="token number">0</span><span
            class="token punctuation">]</span><span class="token punctuation">)</span><span
            class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="database"><a href="#database">База данных</a></h3>
<p></p>
<h4 id="seeder-factory-namespaces"><a href="#seeder-factory-namespaces">Пространства имен Seeder и Factory</a></h4>
<p><strong>Вероятность воздействия: высокая</strong></p>
<p>Сеялки и фабрики теперь имеют пространство имен. Чтобы учесть эти изменения, добавьте <code>Database\Seeders</code>
    пространство имен в свои классы сидера. Кроме того, предыдущий <code>database/seeds</code> каталог следует
    переименовать в <code>database/seeders</code> :</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">Database<span
                        class="token punctuation">\</span>Seeders</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Seeder</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">DatabaseSeeder</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Seeder</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Seed the application's database.
     *
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">run</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token punctuation">.</span><span class="token punctuation">.</span><span class="token punctuation">.</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Если вы решили использовать <code>laravel/legacy-factories</code> пакет, никаких изменений в фабричных классах не
    требуется. Однако, если вы обновляете свои фабрики, вам следует добавить <code>Database\Factories</code>
    пространство имен к этим классам.</p>
<p>Затем в вашем <code>composer.json</code> файле удалите <code>classmap</code> блок из <code>autoload</code> раздела и
    добавьте новые сопоставления каталогов классов в пространстве имен:</p>
<pre class=" language-php"><code class=" language-php"><span class="token double-quoted-string string">"autoload"</span><span
                class="token punctuation">:</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token double-quoted-string string">"psr-4"</span><span class="token punctuation">:</span> <span
                class="token punctuation">{literal}{{/literal}</span>
        <span class="token double-quoted-string string">"App\\"</span><span class="token punctuation">:</span> <span
                class="token double-quoted-string string">"app/"</span><span class="token punctuation">,</span>
        <span class="token double-quoted-string string">"Database\\Factories\\"</span><span
                class="token punctuation">:</span> <span
                class="token double-quoted-string string">"database/factories/"</span><span
                class="token punctuation">,</span>
        <span class="token double-quoted-string string">"Database\\Seeders\\"</span><span
                class="token punctuation">:</span> <span
                class="token double-quoted-string string">"database/seeders/"</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">,</span></code></pre>
<p></p>
<h3 id="eloquent"><a href="#eloquent">Красноречивый</a></h3>
<p></p>
<h4 id="model-factories"><a href="#model-factories">Модельные фабрики</a></h4>
<p><strong>Вероятность воздействия: высокая</strong></p>
<p>Функция <a href="database-testing#defining-model-factories">фабрик
        моделей</a> Laravel была полностью переписана для поддержки классов и несовместима с фабриками стиля Laravel
    7.x. Однако, чтобы упростить процесс обновления, был создан новый <code>laravel/legacy-factories</code> пакет для
    продолжения использования ваших существующих фабрик с Laravel 8.x. Вы можете установить этот пакет через Composer:
</p>
<pre class=" language-php"><code class=" language-php">composer <span class="token keyword">require</span> laravel<span
                class="token operator">/</span>legacy<span class="token operator">-</span>factories</code></pre>
<p></p>
<h4 id="the-castable-interface"><a href="#the-castable-interface"><code>Castable</code> Интерфейс</a></h4>
<p><strong>Вероятность воздействия: низкая</strong></p>
<p><code>castUsing</code> Метод <code>Castable</code> интерфейса был обновлен , чтобы принять массив аргументов. Если вы
    реализуете этот интерфейс, вам следует соответствующим образом обновить свою реализацию:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">public</span> <span
                class="token keyword">static</span> <span class="token keyword">function</span> <span
                class="token function">castUsing</span><span class="token punctuation">(</span><span
                class="token keyword">array</span> <span class="token variable">$arguments</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="increment-decrement-events"><a href="#increment-decrement-events">События увеличения / уменьшения</a></h4>
<p><strong>Вероятность воздействия: низкая</strong></p>
<p>Правильные события модели, связанные с «обновлением» и «сохранением», теперь будут отправляться при выполнении
    методов <code>increment</code> или <code>decrement</code> в экземплярах модели Eloquent.</p>
<p></p>
<h3 id="events"><a href="#events">События</a></h3>
<p></p>
<h4 id="the-event-service-provider-class"><a href="#the-event-service-provider-class"><code>EventServiceProvider</code>
        Класс</a></h4>
<p><strong>Вероятность воздействия: низкая</strong></p>
<p>Если ваш <code>App\Providers\EventServiceProvider</code> класс содержит <code>register</code> функцию, вы должны
    убедиться, что вызываете <code>parent::register</code> в начале этого метода. В противном случае события вашего
    приложения не будут зарегистрированы.</p>
<p></p>
<h4 id="the-dispatcher-contract"><a href="#the-dispatcher-contract"><code>Dispatcher</code> Договор</a></h4>
<p><strong>Вероятность воздействия: низкая</strong></p>
<p><code>listen</code> Метод <code>Illuminate\Contracts\Events\Dispatcher</code> договора был обновлен , чтобы сделать
    <code>$listener</code> свойство необязательно. Это изменение было внесено для поддержки автоматического определения
    обрабатываемых типов событий через отражение. Если вы реализуете этот интерфейс вручную, вам следует соответствующим
    образом обновить свою реализацию:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">public</span> <span
                class="token keyword">function</span> <span class="token function">listen</span><span
                class="token punctuation">(</span><span class="token variable">$events</span><span
                class="token punctuation">,</span> <span class="token variable">$listener</span> <span
                class="token operator">=</span> <span class="token constant">null</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="framework"><a href="#framework">Рамки</a></h3>
<p></p>
<h4 id="maintenance-mode-updates"><a href="#maintenance-mode-updates">Обновления режима обслуживания</a></h4>
<p><strong>Вероятность воздействия: необязательно</strong></p>
<p>Функция <a href="configuration#maintenance-mode">режима обслуживания</a>
    Laravel была улучшена в Laravel 8.x. Теперь поддерживается предварительная визуализация шаблона режима обслуживания,
    что исключает вероятность того, что конечные пользователи столкнутся с ошибками в режиме обслуживания. Однако для
    поддержки этого в ваш <code>public/index.php</code> файл необходимо добавить следующие строки. Эти строки следует
    разместить непосредственно под существующим <code>LARAVEL_START</code> определением константы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">define</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'LARAVEL_START'</span><span
                class="token punctuation">,</span> <span class="token function">microtime</span><span
                class="token punctuation">(</span><span class="token boolean constant">true</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token keyword">if</span> <span class="token punctuation">(</span><span
            class="token function">file_exists</span><span class="token punctuation">(</span><span
            class="token constant">__DIR__</span><span class="token punctuation">.</span><span
            class="token single-quoted-string string">'/../storage/framework/maintenance.php'</span><span
            class="token punctuation">)</span><span class="token punctuation">)</span> <span
            class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">require</span> <span class="token constant">__DIR__</span><span
            class="token punctuation">.</span><span class="token single-quoted-string string">'/../storage/framework/maintenance.php'</span><span
            class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="artisan-down-message"><a href="#artisan-down-message"><code>php artisan down --message</code> Вариант</a></h4>
<p><strong>Вероятность воздействия: средняя</strong></p>
<p><code>--message</code> Вариант из <code>php artisan down</code> команды был удален. В качестве альтернативы
    рассмотрите возможность <a href="configuration#maintenance-mode">предварительной
        визуализации представлений в режиме обслуживания</a> с выбранным вами сообщением.</p>
<p></p>
<h4 id="php-artisan-serve-no-reload-option"><a href="#php-artisan-serve-no-reload-option"><code>php artisan serve
            --no-reload</code> Вариант</a></h4>
<p><strong>Вероятность воздействия: низкая</strong></p>
<p>В команду <code>--no-reload</code> добавлена опция <code>php artisan serve</code>. Это даст указание встроенному
    серверу не перезагружать сервер при обнаружении изменений файла среды. Эта опция в первую очередь полезна при
    запуске тестов Laravel Dusk в среде CI.</p>
<p></p>
<h4 id="manager-app-property"><a href="#manager-app-property"><code>$app</code> Недвижимость менеджера</a></h4>
<p><strong>Вероятность воздействия: низкая</strong></p>
<p>Ранее устаревшее <code>$app</code> свойство <code>Illuminate\Support\Manager</code> класса было удалено. Если вы
    полагались на это свойство, вам следует использовать это <code>$container</code> свойство.</p>
<p></p>
<h4 id="the-elixir-helper"><a href="#the-elixir-helper"><code>elixir</code> Helper</a></h4>
<p><strong>Вероятность воздействия: низкая</strong></p>
<p>Удален ранее устаревший <code>elixir</code> помощник. Приложениям, все еще использующим этот метод, рекомендуется
    перейти на <a href="https://github.com/JeffreyWay/laravel-mix">Laravel
        Mix</a>.</p>
<p></p>
<h3 id="mail"><a href="#mail">Почта</a></h3>
<p></p>
<h4 id="the-sendnow-method"><a href="#the-sendnow-method"><code>sendNow</code> Метод</a></h4>
<p><strong>Вероятность воздействия: низкая</strong></p>
<p>Ранее устаревший <code>sendNow</code> метод был удален. Вместо этого используйте <code>send</code> метод.</p>
<p></p>
<h3 id="pagination"><a href="#pagination">Пагинация</a></h3>
<p></p>
<h4 id="pagination-defaults"><a href="#pagination-defaults">Пагинация по умолчанию</a></h4>
<p><strong>Вероятность воздействия: высокая</strong></p>
<p>Пагинатор теперь использует <a href="https://tailwindcss.com/">фреймворк
        Tailwind CSS</a> для своего стиля по умолчанию. Чтобы продолжать использовать Bootstrap, вы должны добавить
    следующий вызов метода к <code>boot</code> методу вашего приложения <code>AppServiceProvider</code> :</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Pagination<span
                    class="token punctuation">\</span>Paginator</span><span class="token punctuation">;</span>

Paginator<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">useBootstrap</span><span
            class="token punctuation">(</span><span class="token punctuation">)</span><span
            class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="queue"><a href="#queue">Очередь</a></h3>
<p></p>
<h4 id="queue-retry-after-method"><a href="#queue-retry-after-method"><code>retryAfter</code> Метод</a></h4>
<p><strong>Вероятность воздействия: высокая</strong></p>
<p>Для согласования с другими функциями Laravel <code>retryAfter</code> метод и <code>retryAfter</code> свойство заданий
    в очереди, почтовых программ, уведомлений и слушателей были переименованы в <code>backoff</code>. Вам следует
    обновить имя этого метода / свойства в соответствующих классах вашего приложения.</p>
<p></p>
<h4 id="queue-timeout-at-property"><a href="#queue-timeout-at-property"><code>timeoutAt</code> недвижимости</a></h4>
<p><strong>Вероятность воздействия: высокая</strong></p>
<p><code>timeoutAt</code> Свойство очереди заданий, уведомлений и слушателей было переименовано <code>retryUntil</code>.
    Вам следует обновить имя этого свойства в соответствующих классах вашего приложения.</p>
<p></p>
<h4 id="queue-allOnQueue-allOnConnection"><a href="#queue-allOnQueue-allOnConnection">В <code>allOnQueue()</code> /
        <code>allOnConnection()</code> Методы</a></h4>
<p><strong>Вероятность воздействия: высокая</strong></p>
<p>Для обеспечения согласованности с другими методами диспетчеризации методы <code>allOnQueue()</code> и, <code>allOnConnection()</code>
    используемые с цепочкой заданий, были удалены. Вместо этого вы можете использовать методы <code>onQueue()</code> и
    <code>onConnection()</code>. Эти методы следует вызывать перед вызовом <code>dispatch</code> метода:</p>
<pre class=" language-php"><code class=" language-php">ProcessPodcast<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">withChain</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token keyword">new</span> <span class="token class-name">OptimizePodcast</span><span
                class="token punctuation">,</span>
    <span class="token keyword">new</span> <span class="token class-name">ReleasePodcast</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">onConnection</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'redis'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">onQueue</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'podcasts'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">dispatch</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Обратите внимание, что это изменение влияет только на код, использующий <code>withChain</code> метод. Символы <code>allOnQueue()</code>
    и <code>allOnConnection()</code> по-прежнему доступны при использовании глобального <code>dispatch()</code>
    помощника.</p>
<p></p>
<h4 id="failed-jobs-table-batch-support"><a href="#failed-jobs-table-batch-support">Пакетная поддержка таблицы
        невыполненных заданий</a></h4>
<p><strong>Вероятность воздействия: необязательно</strong></p>
<p>Если вы планируете использовать <a href="queues#job-batching">работу
        дозирующих</a> особенности Laravel 8.x, ваша <code>failed_jobs</code> таблица базы данных должна быть обновлена.
    Во-первых, <code>uuid</code> в вашу таблицу нужно добавить новый столбец:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                    class="token punctuation">\</span>Schema<span
                    class="token punctuation">\</span>Blueprint</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Schema</span><span
                class="token punctuation">;</span>

Schema<span class="token punctuation">:</span><span class="token punctuation">:</span><span
            class="token function">table</span><span class="token punctuation">(</span><span
            class="token single-quoted-string string">'failed_jobs'</span><span class="token punctuation">,</span> <span
            class="token keyword">function</span> <span class="token punctuation">(</span>Blueprint <span
            class="token variable">$table</span><span class="token punctuation">)</span> <span
            class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$table</span><span class="token operator">-</span><span
            class="token operator">&gt;</span><span class="token function">string</span><span class="token punctuation">(</span><span
            class="token single-quoted-string string">'uuid'</span><span class="token punctuation">)</span><span
            class="token operator">-</span><span class="token operator">&gt;</span><span
            class="token function">after</span><span class="token punctuation">(</span><span
            class="token single-quoted-string string">'id'</span><span class="token punctuation">)</span><span
            class="token operator">-</span><span class="token operator">&gt;</span><span
            class="token function">nullable</span><span class="token punctuation">(</span><span
            class="token punctuation">)</span><span class="token operator">-</span><span
            class="token operator">&gt;</span><span class="token function">unique</span><span class="token punctuation">(</span><span
            class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Затем параметр <code>failed.driver</code> конфигурации в вашем <code>queue</code> файле конфигурации должен быть
    обновлен до <code>database-uuids</code>.</p>
<p>Кроме того, вы можете сгенерировать UUID для существующих неудачных заданий:</p>
<pre class=" language-php"><code class=" language-php"><span class="token constant">DB</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'failed_jobs'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">whereNull</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'uuid'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">cursor</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">each</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$job</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token constant">DB</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">table</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'failed_jobs'</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">where</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'id'</span><span class="token punctuation">,</span> <span
                class="token variable">$job</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">id</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">update</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token single-quoted-string string">'uuid'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">(</span>string<span
                class="token punctuation">)</span> Illuminate\<span class="token package">Support<span
                    class="token punctuation">\</span>Str</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">uuid</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="routing"><a href="#routing">Маршрутизация</a></h3>
<p></p>
<h4 id="automatic-controller-namespace-prefixing"><a href="#automatic-controller-namespace-prefixing">Автоматическое
        префикс пространства имен контроллера</a></h4>
<p><strong>Вероятность воздействия: необязательно</strong></p>
<p>В предыдущих выпусках Laravel <code>RouteServiceProvider</code> класс содержал <code>$namespace</code> свойство со
    значением <code>App\Http\Controllers</code>. Это значение этого свойства использовалось для автоматического
    префикса объявлений маршрута контроллера и генерации URL маршрута контроллера, например, при вызове
    <code>action</code> помощника.</p>
<p>В Laravel 8 для этого свойства установлено значение <code>null</code> по умолчанию. Это позволяет объявлениям
    маршрута вашего контроллера использовать стандартный вызываемый синтаксис PHP, который обеспечивает лучшую поддержку
    перехода к классу контроллера во многих IDE:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>UserController</span><span
                class="token punctuation">;</span>

<span class="token comment">// Using PHP callable syntax...</span>
Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
            class="token function">get</span><span class="token punctuation">(</span><span
            class="token single-quoted-string string">'/users'</span><span class="token punctuation">,</span> <span
            class="token punctuation">[</span>UserController<span class="token punctuation">:</span><span
            class="token punctuation">:</span><span class="token keyword">class</span><span
            class="token punctuation">,</span> <span class="token single-quoted-string string">'index'</span><span
            class="token punctuation">]</span><span class="token punctuation">)</span><span
            class="token punctuation">;</span>

<span class="token comment">// Using string syntax...</span>
Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
            class="token function">get</span><span class="token punctuation">(</span><span
            class="token single-quoted-string string">'/users'</span><span class="token punctuation">,</span> <span
            class="token single-quoted-string string">'App\Http\Controllers\UserController@index'</span><span
            class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>В большинстве случаев это не повлияет на приложения, которые обновляются, потому что ваше свойство <code>RouteServiceProvider</code>
    по-прежнему будет содержать <code>$namespace</code> его предыдущее значение. Однако, если вы обновите свое приложение,
    создав новый проект Laravel, вы можете столкнуться с этим как критическое изменение.</p>
<p>Если вы хотите продолжить использование исходной маршрутизации контроллера с автоматическим префиксом, вы можете
    просто установить значение <code>$namespace</code> свойства в своем <code>RouteServiceProvider</code> и обновить
    регистрации маршрута в <code>boot</code> методе, чтобы использовать <code>$namespace</code> свойство:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">class</span> <span
                class="token class-name">RouteServiceProvider</span> <span class="token keyword">extends</span> <span
                class="token class-name">ServiceProvider</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * The path to the "home" route for your application.
     *
     * This is used by Laravel authentication to redirect users after login.
     *
     * @var string
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">const</span> <span
                class="token constant">HOME</span> <span class="token operator">=</span> <span
                class="token single-quoted-string string">'/home'</span><span class="token punctuation">;</span>

    <span class="token comment">/**
     * If specified, this namespace is automatically applied to your controller routes.
     *
     * In addition, it is set as the URL generator's root namespace.
    *
    * @var string
    */</span>
    <span class="token keyword">protected</span> <span class="token variable">$namespace</span> <span
            class="token operator">=</span> <span
            class="token single-quoted-string string">'App\Http\Controllers'</span><span
            class="token punctuation">;</span>
    
    <span class="token comment">/**
    * Define your route model bindings, pattern filters, etc.
    *
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">boot</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">configureRateLimiting</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">routes</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">middleware</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'web'</span><span
                class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token keyword">namespace</span><span class="token punctuation">(</span><span
                class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token keyword">namespace</span><span class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">group</span><span class="token punctuation">(</span><span class="token function">base_path</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'routes/web.php'</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    
    Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">prefix</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'api'</span><span
                class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">middleware</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'api'</span><span class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token keyword">namespace</span><span class="token punctuation">(</span><span
                class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token keyword">namespace</span><span class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">group</span><span class="token punctuation">(</span><span class="token function">base_path</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'routes/api.php'</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token punctuation">}</span>
    
    <span class="token comment">/**
    * Configure the rate limiters for the application.
    *
    * @return void
    */</span>
    <span class="token keyword">protected</span> <span class="token keyword">function</span> <span
                class="token function">configureRateLimiting</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
    RateLimiter<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">for</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'api'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span>Request <span
                class="token variable">$request</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> Limit<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">perMinute</span><span
                class="token punctuation">(</span><span class="token number">60</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">by</span><span class="token punctuation">(</span><span
                class="token function">optional</span><span class="token punctuation">(</span><span
                class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">user</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span> <span class="token operator">?</span><span
                class="token punctuation">:</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">ip</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token punctuation">}</span>
    <span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="scheduling"><a href="#scheduling">Планирование</a></h3>
<p></p>
<h4 id="the-cron-expression-library"><a href="#the-cron-expression-library"><code>cron-expression</code> Библиотека</a>
</h4>
<p><strong>Вероятность воздействия: низкая</strong></p>
<p>Зависимость Laravel от <code>dragonmantank/cron-expression</code> была обновлена с <code>2.x</code> до
    <code>3.x</code>. Это не должно вызывать каких-либо критических изменений в вашем приложении, если вы не
    взаимодействуете с <code>cron-expression</code> библиотекой напрямую. Если вы напрямую взаимодействуете с этой
    библиотекой, просмотрите ее <a
            href="https://github.com/dragonmantank/cron-expression/blob/master/CHANGELOG.md">журнал
        изменений</a>.</p>
<p></p>
<h3 id="session"><a href="#session">Сессия</a></h3>
<p></p>
<h4 id="the-session-contract"><a href="#the-session-contract"><code>Session</code> Договор</a></h4>
<p><strong>Вероятность воздействия: низкая</strong></p>
<p><code>Illuminate\Contracts\Session\Session</code> Контракт получил новый <code>pull</code> метод. Если вы реализуете
    этот контракт вручную, вам следует соответствующим образом обновить свою реализацию:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the value of a given key and then forget it.
 *
 * @param  string  $key
 * @param  mixed  $default
 * @return mixed
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">pull</span><span class="token punctuation">(</span><span class="token variable">$key</span><span
                class="token punctuation">,</span> <span class="token variable">$default</span> <span
                class="token operator">=</span> <span class="token constant">null</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="testing"><a href="#testing">Тестирование</a></h3>
<p></p>
<h4 id="decode-response-json-method"><a href="#decode-response-json-method"><code>decodeResponseJson</code> Метод</a>
</h4>
<p><strong>Вероятность воздействия: низкая</strong></p>
<p>Не <code>decodeResponseJson</code> метод , который относится к <code>Illuminate\Testing\TestResponse</code> классу
    больше не принимает никаких аргументов. Пожалуйста, подумайте об использовании этого <code>json</code> метода.</p>
<p></p>
<h4 id="assert-exact-json-method"><a href="#assert-exact-json-method"><code>assertExactJson</code> Метод</a></h4>
<p><strong>Вероятность воздействия: средняя</strong></p>
<p>Теперь <code>assertExactJson</code> метод требует, чтобы числовые ключи сравниваемых массивов совпадали и
    располагались в одном порядке. Если вы хотите сравнить JSON с массивом, не требуя, чтобы массивы с числовыми ключами
    имели одинаковый порядок, вы можете <code>assertSimilarJson</code> вместо этого использовать этот метод.</p>
<p></p>
<h3 id="validation"><a href="#validation">Проверка</a></h3>
<p></p>
<h3 id="database-rule-connections"><a href="#database-rule-connections">Подключения правил базы данных</a></h3>
<p><strong>Вероятность воздействия: низкая</strong></p>
<p><code>unique</code> И <code>exists</code> правили теперь будет соблюдать имя указанного соединения (доступ через
    модель <code>getConnectionName</code> методу) моделей красноречив при выполнении запросов.</p>
<p></p>
<h3 id="miscellaneous"><a href="#miscellaneous">Разное</a></h3>
<p>Мы также рекомендуем вам просматривать изменения в <code>laravel/laravel</code>
    <a href="https://github.com/laravel/laravel">репозитории GitHub</a>.
    Хотя многие из этих изменений не требуются, вы можете захотеть синхронизировать эти файлы с вашим приложением.
    Некоторые из этих изменений будут рассмотрены в этом руководстве по обновлению, но другие, такие как изменения
    файлов конфигурации или комментарии, не будут. Вы можете легко просмотреть изменения с помощью <a
            href="https://github.com/laravel/laravel/compare/7.x...8.x">инструмента
        сравнения GitHub</a> и выбрать, какие обновления важны для вас.</p>
                        