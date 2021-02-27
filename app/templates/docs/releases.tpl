<h1>Примечания к выпуску <sup>Release notes</sup></h1>
<ul>
    <li><a href="releases#versioning-scheme">Схема управления версиями</a>
        <ul>
            <li><a href="releases#exceptions">Исключения</a></li>
        </ul>
    </li>
    <li><a href="releases#support-policy">Политика поддержки</a></li>
    <li><a href="releases#laravel-8">Laravel 8</a></li>
</ul>
<p></p>
<h2 id="versioning-scheme"><a href="#versioning-scheme">Схема управления версиями</a></h2>
<p>Laravel и другие его собственные пакеты следуют <a href="https://semver.org/">семантическому управлению версиями</a>
    . Основные выпуски фреймворка выпускаются каждый год (~ сентябрь), а второстепенные выпуски и исправления могут
    выпускаться каждую неделю. Незначительные релизы и патчи <strong>никогда не</strong> должны содержать критических
    изменений.</p>
<p>При ссылке на фреймворк Laravel или его компоненты из вашего приложения или пакета вы всегда должны использовать
    ограничение версии, например <code>^8.0</code> , поскольку основные выпуски Laravel действительно включают
    критические изменения. Однако мы всегда стремимся к тому, чтобы вы могли выполнить обновление до новой основной
    версии в течение одного дня или меньше.</p>
<p></p>
<h3 id="exceptions"><a href="#exceptions">Исключения</a></h3>
<p></p>
<h4 id="named-arguments"><a href="#named-arguments">Именованные аргументы</a></h4>
<p>В настоящее время функциональные возможности <a
            href="https://www.php.net/manual/en/functions.arguments.php#functions.named-arguments">именованных
        аргументов</a> PHP не подпадают под правила обратной совместимости Laravel. При необходимости мы можем
    переименовать параметры функции, чтобы улучшить кодовую базу Laravel. Поэтому использовать именованные аргументы при
    вызове методов Laravel следует осторожно и с пониманием того, что имена параметров могут измениться в будущем.</p>
<p></p>
<h2 id="support-policy"><a href="#support-policy">Политика поддержки</a></h2>
<p>Для выпусков LTS, таких как Laravel 6, исправления ошибок предоставляются на 2 года, а исправления безопасности - на
    3 года. Эти выпуски обеспечивают самый продолжительный период поддержки и обслуживания. Для общих выпусков
    исправления ошибок предоставляются на 18 месяцев, а исправления безопасности - на 2 года. Для всех дополнительных
    библиотек, включая Lumen, только последний выпуск получает исправления ошибок. Кроме того, просмотрите версии баз
    данных, <a href="database#introduction">поддерживаемые Laravel</a>.</p>
<table>
    <thead>
    <tr>
        <th>Версия</th>
        <th>Релиз</th>
        <th>Исправления ошибок до</th>
        <th>Исправления безопасности до</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td>6 (LTS)</td>
        <td>3 сентября 2019 г.</td>
        <td>7 сентября 2021 г.</td>
        <td>6 сентября 2022 г.</td>
    </tr>
    <tr>
        <td>7</td>
        <td>3 марта 2020 г.</td>
        <td>6 октября 2020 г.</td>
        <td>3 марта 2021 г.</td>
    </tr>
    <tr>
        <td>8</td>
        <td>8 сентября 2020</td>
        <td>1 марта 2022 г.</td>
        <td>6 сентября 2022 г.</td>
    </tr>
    <tr>
        <td>9 (LTS)</td>
        <td>Сентябрь 2021 г.</td>
        <td>Сентябрь 2023 г.</td>
        <td>Сентябрь 2024 г.</td>
    </tr>
    <tr>
        <td>10</td>
        <td>Сентябрь 2022 г.</td>
        <td>Март 2024 г.</td>
        <td>Сентябрь 2024 г.</td>
    </tr>
    </tbody>
</table>
<p></p>
<h2 id="laravel-8"><a href="#laravel-8">Laravel 8</a></h2>
<p>Laravel 8 продолжает улучшения, сделанные в Laravel 7.x, представляя Laravel Jetstream, классы фабрики моделей,
    сжатие миграции, пакетирование заданий, улучшенное ограничение скорости, улучшения очереди, динамические компоненты
    Blade, представления разбивки на страницы Tailwind, помощники тестирования времени, улучшения <code>artisan serve</code> ,
    прослушиватель событий улучшения, а также множество других исправлений ошибок и улучшений удобства использования.</p>
<p></p>
<h3 id="laravel-jetstream"><a href="#laravel-jetstream">Laravel Jetstream</a></h3>
<p><em>Laravel Jetstream был написан <a href="https://github.com/taylorotwell">Тейлором Отвеллом</a></em>.</p>
<p><a href="https://jetstream.laravel.com/">Laravel Jetstream</a> - это красиво оформленный каркас приложений для
    Laravel. Jetstream обеспечивает идеальную отправную точку для вашего следующего проекта и включает в себя вход в
    систему, регистрацию, проверку электронной почты, двухфакторную аутентификацию, управление сеансом, поддержку API
    через Laravel Sanctum и дополнительное управление командой. Laravel Jetstream заменяет и улучшает устаревшие
    конструкции пользовательского интерфейса аутентификации, доступные для предыдущих версий Laravel.</p>
<p>Jetstream разработан с использованием <a href="https://tailwindcss.com/">Tailwind CSS</a> и предлагает на ваш выбор
    строительные леса <a href="https://laravel-livewire.com/">Livewire</a> или <a
            href="https://inertiajs.com/">Inertia</a>.</p>
<p></p>
<h3 id="models-directory"><a href="#models-directory">Каталог моделей</a></h3>
<p>По многочисленным просьбам сообщества скелет приложения Laravel по умолчанию теперь содержит <code>app/Models</code>  каталог.
    Надеемся, вам понравится этот новый дом для ваших моделей Eloquent! Все соответствующие команды генератора были
    обновлены, чтобы предполагать, что в <code>app/Models</code>  каталоге существуют модели, если он существует. Если
    каталог не существует, платформа предполагает, что ваши модели должны быть помещены в <code>app</code>  каталог.</p>
<p></p>
<h3 id="model-factory-classes"><a href="#model-factory-classes">Классы фабрики моделей</a></h3>
<p><em>Модельные фабричные классы были предоставлены <a href="https://github.com/taylorotwell">Тейлор Отвелл</a></em>.
</p>
<p><a href="database-testing#defining-model-factories">Фабрики</a> красноречивых <a
            href="database-testing#defining-model-factories">моделей</a> были полностью переписаны как фабрики на основе
    классов и улучшены для обеспечения первоклассной поддержки отношений. Например, <code>UserFactory</code>  входящий в
    состав Laravel написан так:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">Database<span
                        class="token punctuation">\</span>Factories</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Database<span
                        class="token punctuation">\</span>Eloquent<span class="token punctuation">\</span>Factories<span
                        class="token punctuation">\</span>Factory</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Str</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">UserFactory</span> <span class="token keyword">extends</span> <span
                    class="token class-name">Factory</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * The name of the factory's corresponding model.
     *
     * @var string
     */</span>
    <span class="token keyword">protected</span> <span class="token variable">$model</span> <span
                    class="token operator">=</span> User<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token keyword">class</span><span
                    class="token punctuation">;</span>

    <span class="token comment">/**
     * Define the model's default state.
    *
    * @return array
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">definition</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'name'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">faker</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">name</span><span
                    class="token punctuation">,</span>
    <span class="token single-quoted-string string">'email'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">faker</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">unique</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">safeEmail</span><span
                    class="token punctuation">,</span>
    <span class="token single-quoted-string string">'email_verified_at'</span> <span
                    class="token operator">=</span><span class="token operator">&gt;</span> <span
                    class="token function">now</span><span class="token punctuation">(</span><span
                    class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'password'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> <span class="token single-quoted-string string">'$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi'</span><span
                    class="token punctuation">,</span> <span class="token comment">// password</span>
    <span class="token single-quoted-string string">'remember_token'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> Str<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token function">random</span><span
                    class="token punctuation">(</span><span class="token number">10</span><span
                    class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
    <span class="token punctuation">}</span></span></code> </pre>
<p>Благодаря новому <code>HasFactory</code>  признаку, доступному для сгенерированных моделей, фабрика моделей может
    использоваться следующим образом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

User<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">factory</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">count</span><span
                class="token punctuation">(</span><span class="token number">50</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code> </pre>
<p>Поскольку фабрики моделей теперь являются простыми классами PHP, преобразования состояний могут быть записаны как
    методы класса. Кроме того, при необходимости вы можете добавить любые другие вспомогательные классы в фабрику
    моделей Eloquent.</p>
<p>Например, ваша <code>User</code>  модель может иметь <code>suspended</code>  состояние, которое изменяет одно из значений
    атрибута по умолчанию. Вы можете определить свои преобразования состояния, используя метод базовой фабрики <code>state</code>.
    Вы можете называть свой метод состояния как угодно. В конце концов, это просто типичный PHP-метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Indicate that the user is suspended.
 *
 * @return \Illuminate\Database\Eloquent\Factories\Factory
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">suspended</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">state</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'account_status'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'suspended'</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token punctuation">}</span></code> </pre>
<p>После определения метода преобразования состояния мы можем использовать его так:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Models<span
                    class="token punctuation">\</span>User</span><span class="token punctuation">;</span>

User<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">factory</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">count</span><span
                class="token punctuation">(</span><span class="token number">5</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">suspended</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code> </pre>
<p>Как уже упоминалось, фабрики моделей Laravel 8 содержат первоклассную поддержку отношений. Итак, предполагая, что
    наша <code>User</code>  модель имеет <code>posts</code>  метод отношения, мы можем просто запустить следующий код, чтобы
    сгенерировать пользователя с тремя сообщениями:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$users</span> <span
                class="token operator">=</span> User<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">factory</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">hasPosts</span><span
                class="token punctuation">(</span><span class="token number">3</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
                <span class="token single-quoted-string string">'published'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token boolean constant">false</span><span
                class="token punctuation">,</span>
            <span class="token punctuation">]</span><span class="token punctuation">)</span>
            <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">create</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code> </pre>
<p>Чтобы упростить процесс обновления, был выпущен пакет <a href="https://github.com/laravel/legacy-factories">laravel /
        legacy-factoryies,</a> обеспечивающий поддержку предыдущей итерации фабрик моделей в Laravel 8.x.</p>
<p>Переписанные фабрики Laravel содержат гораздо больше функций, которые, как мы думаем, вам понравятся. Чтобы узнать
    больше о фабриках моделей, обратитесь к <a href="database-testing#defining-model-factories">документации по
        тестированию баз данных</a>.</p>
<p></p>
<h3 id="migration-squashing"><a href="#migration-squashing">Сжатие миграции</a></h3>
<p><em><a href="https://github.com/taylorotwell">Противодействие</a></em><em> миграции было внесено </em><em><a
                href="https://github.com/taylorotwell">Тейлором Отуэлл</a></em>.</p>
<p>По мере создания приложения вы можете со временем накапливать все больше и больше миграций. Это может привести к
    тому, что ваш каталог миграции станет раздутым за счет потенциально сотен миграций. Если вы используете MySQL или
    PostgreSQL, теперь вы можете «сжать» свои миграции в один файл SQL. Для начала выполните <code>schema:dump</code>  команду:
</p>
<pre class=" language-php"><code class=" language-php">php artisan schema<span class="token punctuation">:</span>dump

<span class="token comment">// Dump the current database schema and prune all existing migrations...</span>
php artisan schema<span class="token punctuation">:</span>dump <span class="token operator">--</span>prune</code> </pre>
<p>Когда вы выполните эту команду, Laravel запишет файл «схемы» в ваш <code>database/schema</code>  каталог. Теперь, когда
    вы пытаетесь перенести свою базу данных, и никакие другие миграции не выполнялись, Laravel сначала выполнит SQL
    файла схемы. После выполнения команд файла схемы Laravel выполнит все оставшиеся миграции, которые не были частью
    дампа схемы.</p>
<p></p>
<h3 id="job-batching"><a href="#job-batching">Пакетирование заданий</a></h3>
<p><em><a href="https://github.com/taylorotwell">Пакетирование</a> заданий было предоставлено <a
                href="https://github.com/taylorotwell">Тейлор Отвелл</a> и <a href="https://github.com/themsaid">Мохамед
            Саид</a></em>.</p>
<p>Функция пакетной обработки заданий Laravel позволяет вам легко выполнять пакет заданий, а затем выполнять некоторые
    действия после завершения выполнения пакета заданий.</p>
<p>Новый <code>batch</code>  метод <code>Bus</code>  фасада может использоваться для отправки пакета заданий. Конечно,
    пакетирование в первую очередь полезно в сочетании с обратными вызовами завершения. Таким образом, вы можете
    использовать <code>then</code> , <code>catch</code>  и <code>finally</code>  методы для определения завершения обратного
    вызова для партии. Каждый из этих обратных вызовов получит <code>Illuminate\Bus\Batch</code>  экземпляр при вызове:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Jobs<span
                    class="token punctuation">\</span>ProcessPodcast</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Podcast</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Bus<span
                    class="token punctuation">\</span>Batch</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Bus</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Throwable</span><span
                class="token punctuation">;</span>

<span class="token variable">$batch</span> <span class="token operator">=</span> Bus<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">batch</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token keyword">new</span> <span class="token class-name">ProcessPodcast</span><span
                class="token punctuation">(</span>Podcast<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span>
    <span class="token keyword">new</span> <span class="token class-name">ProcessPodcast</span><span
                class="token punctuation">(</span>Podcast<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">2</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span>
    <span class="token keyword">new</span> <span class="token class-name">ProcessPodcast</span><span
                class="token punctuation">(</span>Podcast<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">3</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span>
    <span class="token keyword">new</span> <span class="token class-name">ProcessPodcast</span><span
                class="token punctuation">(</span>Podcast<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">4</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span>
    <span class="token keyword">new</span> <span class="token class-name">ProcessPodcast</span><span
                class="token punctuation">(</span>Podcast<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">5</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">then</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span>Batch <span class="token variable">$batch</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">// All jobs completed successfully...</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token keyword">catch</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span>Batch <span class="token variable">$batch</span><span
                class="token punctuation">,</span> Throwable <span class="token variable">$e</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">// First batch job failure detected...</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token keyword">finally</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span>Batch <span class="token variable">$batch</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">// The batch has finished executing...</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">dispatch</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token keyword">return</span> <span class="token variable">$batch</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span><span class="token punctuation">;</span></code> </pre>
<p>Чтобы узнать больше о пакетировании заданий, обратитесь к <a href="queues#job-batching">документации</a> по <a
            href="queues#job-batching">очереди</a>.</p>
<p></p>
<h3 id="improved-rate-limiting"><a href="#improved-rate-limiting">Улучшенное ограничение скорости</a></h3>
<p><em>Улучшения ограничения скорости были внесены <a href="https://github.com/taylorotwell">Тейлор Отвелл</a></em>.</p>
<p>Функция ограничителя скорости запросов Laravel была расширена с большей гибкостью и мощностью, при этом сохранена
    обратная совместимость с <code>throttle</code>  API промежуточного программного обеспечения предыдущей версии .</p>
<p>Ограничители скорости определяются с помощью метода <code>RateLimiter</code>  фасада <code>for</code>. <code>for</code>  Метод
    принимает имя ограничителя скорости и замыкание , которое возвращает конфигурацию предела , который должен
    применяться к маршрутам, присвоенные этот ограничитель скорости:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Cache<span
                    class="token punctuation">\</span>RateLimiting<span
                    class="token punctuation">\</span>Limit</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span
                    class="token punctuation">\</span>RateLimiter</span><span class="token punctuation">;</span>

RateLimiter<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">for</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'global'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>Request <span class="token variable">$request</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> Limit<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">perMinute</span><span
                class="token punctuation">(</span><span class="token number">1000</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code> </pre>
<p>Поскольку обратные вызовы ограничителя скорости получают экземпляр входящего HTTP-запроса, вы можете динамически
    создать соответствующее ограничение скорости на основе входящего запроса или аутентифицированного пользователя:</p>
<pre class=" language-php"><code class=" language-php">RateLimiter<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">for</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'uploads'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span>Request <span
                class="token variable">$request</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">user</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">vipCustomer</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
            <span class="token operator">?</span> Limit<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">none</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
            <span class="token punctuation">:</span> Limit<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">perMinute</span><span
                class="token punctuation">(</span><span class="token number">100</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code> </pre>
<p>Иногда вы можете захотеть сегментировать ограничения скорости на какое-то произвольное значение. Например, вы можете
    разрешить пользователям получать доступ к заданному маршруту 100 раз в минуту на каждый IP-адрес. Для этого вы
    можете использовать <code>by</code>  метод при построении лимита скорости:</p>
<pre class=" language-php"><code class=" language-php">RateLimiter<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">for</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'uploads'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span>Request <span
                class="token variable">$request</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
            <span class="token keyword">return</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">user</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">vipCustomer</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
            <span class="token operator">?</span> Limit<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">none</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
            <span class="token punctuation">:</span> Limit<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">perMinute</span><span
                class="token punctuation">(</span><span class="token number">100</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">by</span><span class="token punctuation">(</span><span
                class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">ip</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code> </pre>
<p>Ограничители скорости могут быть присоединены к маршрутам или группам маршрутов с помощью <code>throttle</code>  <a
            href="middleware">промежуточного программного обеспечения</a>. Промежуточное программное обеспечение
    дроссельной заслонки принимает имя ограничителя скорости, которое вы хотите назначить маршруту:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">middleware</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'throttle:uploads'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">group</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
            Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">post</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/audio'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">//</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

            Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">post</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/video'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">//</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code> </pre>
<p>Чтобы узнать больше об ограничении скорости, обратитесь к <a href="routing#rate-limiting">документации</a> по <a
            href="routing#rate-limiting">маршрутизации</a>.</p>
<p></p>
<h3 id="improved-maintenance-mode"><a href="#improved-maintenance-mode">Улучшенный режим обслуживания</a></h3>
<p><em>Улучшения режима обслуживания были внесены <a href="https://github.com/taylorotwell">Тейлором Отвеллом</a> с
        вдохновением от <a href="https://spatie.be/">Spatie</a></em>.</p>
<p>В предыдущих выпусках Laravel <code>php artisan down</code>  функцию режима обслуживания можно было обойти с помощью
    «разрешенного списка» IP-адресов, которым был разрешен доступ к приложению. Эта функция была удалена в пользу более
    простого решения «секрет» / токен.</p>
<p>Находясь в режиме обслуживания, вы можете использовать <code>secret</code>  опцию для указания токена обхода режима
    обслуживания:</p>
<pre class=" language-php"><code class=" language-php">php artisan down <span
                class="token operator">--</span>secret<span class="token operator">=</span><span
                class="token double-quoted-string string">"1630542a-246b-4b66-afa1-dd72a4c43515"</span></code> </pre>
<p>После перевода приложения в режим обслуживания вы можете перейти к URL-адресу приложения, соответствующему этому
    токену, и Laravel выдаст вашему браузеру файл cookie обхода режима обслуживания:</p>
<pre class=" language-php"><code class=" language-php">https<span class="token punctuation">:</span><span
                class="token comment">//example.com/1630542a-246b-4b66-afa1-dd72a4c43515</span></code> </pre>
<p>При доступе к этому скрытому маршруту вы будете перенаправлены на <code>/</code>  маршрут приложения. Как только cookie
    будет отправлен вашему браузеру, вы сможете просматривать приложение в обычном режиме, как если бы оно не находилось
    в режиме обслуживания.</p>
<p></p>
<h4 id="pre-rendering-the-maintenance-mode-view"><a href="#pre-rendering-the-maintenance-mode-view">Предварительная
        визуализация представления режима обслуживания</a></h4>
<p>Если вы используете <code>php artisan down</code>  команду во время развертывания, ваши пользователи могут иногда
    сталкиваться с ошибками, если они обращаются к приложению во время обновления ваших зависимостей Composer или других
    компонентов инфраструктуры. Это происходит потому, что значительная часть инфраструктуры Laravel должна загружаться,
    чтобы определить, находится ли ваше приложение в режиме обслуживания, и отобразить представление режима обслуживания
    с помощью механизма шаблонов.</p>
<p>По этой причине Laravel теперь позволяет вам предварительно визуализировать представление режима обслуживания,
    которое будет возвращено в самом начале цикла запроса. Это представление отображается перед загрузкой любой из
    зависимостей вашего приложения. Вы можете предварительно вынести шаблон по своему выбору с помощью <code>down</code>  командования
    <code>render</code>  опции:</p>
<pre class=" language-php"><code class=" language-php">php artisan down <span
                class="token operator">--</span>render<span class="token operator">=</span><span
                class="token double-quoted-string string">"errors::503"</span></code> </pre>
<p></p>
<h3 id="closure-dispatch-chain-catch"><a href="#closure-dispatch-chain-catch">Закрытие отправка / цепочка
        <code>catch</code> </a></h3>
<p><em>Улучшения улова были внесены <a href="https://github.com/themsaid">Мохамедом Саидом</a></em>.</p>
<p>Используя новый <code>catch</code>  метод, теперь вы можете обеспечить закрытие, которое должно выполняться, если
    закрытие в очереди не удалось успешно завершить после исчерпания всех настроенных попыток повтора вашей очереди:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Throwable</span><span class="token punctuation">;</span>

<span class="token function">dispatch</span><span class="token punctuation">(</span><span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token punctuation">)</span> <span class="token keyword">use</span> <span
                class="token punctuation">(</span><span class="token variable">$podcast</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token variable">$podcast</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">publish</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token keyword">catch</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span>Throwable <span class="token variable">$e</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">// This job has failed...</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code> </pre>
<p></p>
<h3 id="dynamic-blade-components"><a href="#dynamic-blade-components">Компоненты Dynamic Blade</a></h3>
<p><em>Компоненты Dynamic Blade были предоставлены <a href="https://github.com/taylorotwell">Тейлором Отвеллом</a></em>
    .</p>
<p>Иногда вам может потребоваться визуализировать компонент, но вы не знаете, какой компонент следует визуализировать,
    до времени выполнения. В этой ситуации теперь вы можете использовать встроенный <code>dynamic-component</code>  компонент
    Laravel для рендеринга компонента на основе значения времени выполнения или переменной:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>x<span
                class="token operator">-</span>dynamic<span class="token operator">-</span>component <span
                class="token punctuation">:</span>component<span class="token operator">=</span><span
                class="token double-quoted-string string">"<span class="token interpolation"><span
                        class="token variable">$componentName</span></span>"</span> <span
                class="token keyword">class</span><span class="token operator">=</span><span
                class="token double-quoted-string string">"mt-4"</span> <span class="token operator">/</span><span
                class="token operator">&gt;</span></code> </pre>
<p>Чтобы узнать больше о компонентах Blade, обратитесь к <a href="blade#components">документации Blade</a>.</p>
<p></p>
<h3 id="event-listener-improvements"><a href="#event-listener-improvements">Улучшения прослушивателя событий</a></h3>
<p><em>Улучшения в слушателе событий были внесены <a href="https://github.com/taylorotwell">Тейлор Отвелл</a></em>.</p>
<p>Слушатели событий, основанные на закрытии, теперь могут быть зарегистрированы, только передав закрытие <code>Event::listen</code>  методу.
    Laravel проверит закрытие, чтобы определить, какой тип события обрабатывает слушатель:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Events<span
                    class="token punctuation">\</span>PodcastProcessed</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Event</span><span
                class="token punctuation">;</span>

Event<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">listen</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span>PodcastProcessed <span class="token variable">$event</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">//</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code> </pre>
<p>Кроме того, прослушиватели событий на основе закрытия теперь могут быть помечены как стоящие в очереди с помощью
    <code>Illuminate\Events\queueable</code>  функции:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Events<span
                    class="token punctuation">\</span>PodcastProcessed</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">function</span> Illuminate\<span
                class="token package">Events<span class="token punctuation">\</span>queueable</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Event</span><span
                class="token punctuation">;</span>

Event<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">listen</span><span class="token punctuation">(</span><span
                class="token function">queueable</span><span class="token punctuation">(</span><span
                class="token keyword">function</span> <span class="token punctuation">(</span>PodcastProcessed <span
                class="token variable">$event</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">//</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code> </pre>
<p>Как очереди заданий, вы можете использовать <code>onConnection</code> , <code>onQueue</code>  и <code>delay</code>  методы
    , чтобы настроить выполнение очереди слушателя:</p>
<pre class=" language-php"><code class=" language-php">Event<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">listen</span><span
                class="token punctuation">(</span><span class="token function">queueable</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span>PodcastProcessed <span class="token variable">$event</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">//</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">onConnection</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'redis'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">onQueue</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'podcasts'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">delay</span><span
                class="token punctuation">(</span><span class="token function">now</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">addSeconds</span><span
                class="token punctuation">(</span><span class="token number">10</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code> </pre>
<p>Если вы хотите обрабатывать сбои анонимного прослушивателя в очереди, вы можете обеспечить закрытие
    <code>catch</code>  метода при определении <code>queueable</code>  слушателя:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Events<span
                    class="token punctuation">\</span>PodcastProcessed</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">function</span> Illuminate\<span
                class="token package">Events<span class="token punctuation">\</span>queueable</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Event</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Throwable</span><span
                class="token punctuation">;</span>

Event<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">listen</span><span class="token punctuation">(</span><span
                class="token function">queueable</span><span class="token punctuation">(</span><span
                class="token keyword">function</span> <span class="token punctuation">(</span>PodcastProcessed <span
                class="token variable">$event</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">//</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token keyword">catch</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span>PodcastProcessed <span class="token variable">$event</span><span
                class="token punctuation">,</span> Throwable <span class="token variable">$e</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">// The queued listener failed...</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code> </pre>
<p></p>
<h3 id="time-testing-helpers"><a href="#time-testing-helpers">Помощники по тестированию времени</a></h3>
<p><em>Помощники по тестированию времени были предоставлены <a href="https://github.com/taylorotwell">Тейлором
            Отвеллом,</a> вдохновленным Ruby on Rails</em>.</p>
<p>При тестировании вам может иногда потребоваться изменить время, возвращаемое такими помощниками, как <code>now</code>  или
    <code>Illuminate\Support\Carbon::now()</code>. Базовый класс тестирования функций Laravel теперь включает
    помощников, которые позволяют вам управлять текущим временем:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">public</span> <span
                class="token keyword">function</span> <span class="token function">testTimeCanBeManipulated</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// Travel into the future...</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">travel</span><span
                class="token punctuation">(</span><span class="token number">5</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">milliseconds</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">travel</span><span
                class="token punctuation">(</span><span class="token number">5</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">seconds</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">travel</span><span
                class="token punctuation">(</span><span class="token number">5</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">minutes</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">travel</span><span
                class="token punctuation">(</span><span class="token number">5</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">hours</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">travel</span><span
                class="token punctuation">(</span><span class="token number">5</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">days</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">travel</span><span
                class="token punctuation">(</span><span class="token number">5</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">weeks</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">travel</span><span
                class="token punctuation">(</span><span class="token number">5</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">years</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

    <span class="token comment">// Travel into the past...</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">travel</span><span
                class="token punctuation">(</span><span class="token operator">-</span><span
                class="token number">5</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">hours</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

    <span class="token comment">// Travel to an explicit time...</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">travelTo</span><span
                class="token punctuation">(</span><span class="token function">now</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">subHours</span><span
                class="token punctuation">(</span><span class="token number">6</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

    <span class="token comment">// Return back to the present time...</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">travelBack</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token punctuation">}</span></code> </pre>
<p></p>
<h3 id="artisan-serve-improvements"><a href="#artisan-serve-improvements">Ремесленные <code>serve</code>  улучшения</a>
</h3>
<p><em>Ремесленные <code>serve</code>  улучшения были внесены <a href="https://github.com/taylorotwell">Тейлор Отвелл</a></em>
    .</p>
<p>В <code>serve</code>  команду Artisan добавлена автоматическая перезагрузка при обнаружении изменений переменных
    среды в вашем локальном <code>.env</code>  файле. Раньше команду приходилось останавливать и перезапускать вручную.
</p>
<p></p>
<h3 id="tailwind-pagination-views"><a href="#tailwind-pagination-views">Просмотры с попутным ветром</a></h3>
<p>Пагинатор Laravel был обновлен для использования по умолчанию <a href="https://tailwindcss.com/">CSS-</a> фреймворка
    <a href="https://tailwindcss.com/">Tailwind</a>. Tailwind CSS - это настраиваемая низкоуровневая CSS-структура,
    которая дает вам все строительные блоки, необходимые для создания нестандартных дизайнов без каких-либо раздражающих
    самоуверенных стилей, за которые вам придется бороться. Конечно, также остаются доступными представления Bootstrap 3
    и 4.</p>
<p></p>
<h3 id="routing-namespace-updates"><a href="#routing-namespace-updates">Обновления пространства имен маршрутизации</a>
</h3>
<p>В предыдущих выпусках Laravel объект <code>RouteServiceProvider</code>  содержал <code>$namespace</code>  свойство.
    Значение этого свойства будет автоматически добавлено к определениям маршрута контроллера и вызовам
    <code>action</code>  помощника / <code>URL::action</code>  метода. В Laravel 8.x это свойство <code>null</code> по
    умолчанию. Это означает, что Laravel не будет выполнять автоматическое префиксы пространства имен. Поэтому в новых
    приложениях Laravel 8.x определения маршрутов контроллера должны быть определены с использованием стандартного
    синтаксиса вызываемых PHP:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>UserController</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/users'</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span>UserController<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'index'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code> </pre>
<p>Вызов <code>action</code> связанных методов должен использовать тот же синтаксис вызова:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">action</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>UserController<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'index'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token keyword">return</span> Redirect<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">action</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>UserController<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'index'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code> </pre>
<p>Если вы предпочитаете префикс маршрута контроллера в стиле Laravel 7.x, вы можете просто добавить
    <code>$namespace</code> свойство в свое приложение <code>RouteServiceProvider</code>.</p>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Это изменение касается только новых приложений Laravel 8.x. Приложения, обновляющиеся с Laravel 7.x,
            по-прежнему будут иметь <code>$namespace</code> свойство <code>RouteServiceProvider</code>.</p></p></div>
</blockquote>
                        