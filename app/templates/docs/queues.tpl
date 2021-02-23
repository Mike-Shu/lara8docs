<h1>Очереди <sup>Queues</sup></h1>
<ul>
    <li><a href="queues#introduction">Вступление</a>
        <ul>
            <li><a href="queues#connections-vs-queues">Соединения Vs. Очереди</a></li>
            <li><a href="queues#driver-prerequisites">Примечания к драйверам и предварительные требования</a></li>
        </ul>
    </li>
    <li><a href="queues#creating-jobs">Создание рабочих мест</a>
        <ul>
            <li><a href="queues#generating-job-classes">Создание классов должностей</a></li>
            <li><a href="queues#class-structure">Структура класса</a></li>
            <li><a href="queues#unique-jobs">Уникальные вакансии</a></li>
        </ul>
    </li>
    <li><a href="queues#job-middleware">ПО промежуточного слоя вакансий</a>
        <ul>
            <li><a href="queues#rate-limiting">Ограничение скорости</a></li>
            <li><a href="queues#preventing-job-overlaps">Предотвращение дублирования работы</a></li>
        </ul>
    </li>
    <li><a href="queues#dispatching-jobs">Диспетчерские работы</a>
        <ul>
            <li><a href="queues#delayed-dispatching">Отложенная отправка</a></li>
            <li><a href="queues#synchronous-dispatching">Синхронная диспетчеризация</a></li>
            <li><a href="queues#jobs-and-database-transactions">Работа и транзакции в базе данных</a></li>
            <li><a href="queues#job-chaining">Связь вакансий</a></li>
            <li><a href="queues#customizing-the-queue-and-connection">Настройка очереди и подключения</a></li>
            <li><a href="queues#max-job-attempts-and-timeout">Указание максимального количества попыток задания /
                    значений тайм-аута</a></li>
            <li><a href="queues#error-handling">Обработка ошибок</a></li>
        </ul>
    </li>
    <li><a href="queues#job-batching">Пакетирование заданий</a>
        <ul>
            <li><a href="queues#defining-batchable-jobs">Определение заданий с возможностью батча</a></li>
            <li><a href="queues#dispatching-batches">Отгрузка партий</a></li>
            <li><a href="queues#adding-jobs-to-batches">Добавление заданий в пакеты</a></li>
            <li><a href="queues#inspecting-batches">Проверка партий</a></li>
            <li><a href="queues#cancelling-batches">Отмена пакетов</a></li>
            <li><a href="queues#batch-failures">Пакетные сбои</a></li>
            <li><a href="queues#pruning-batches">Партии обрезки</a></li>
        </ul>
    </li>
    <li><a href="queues#queueing-closures">Закрытие очередей</a></li>
    <li><a href="queues#running-the-queue-worker">Запуск обработчика очереди</a>
        <ul>
            <li><a href="queues#the-queue-work-command"><code>queue:work</code> Command</a></li>
            <li><a href="queues#queue-priorities">Приоритеты очереди</a></li>
            <li><a href="queues#queue-workers-and-deployment">Работники очереди и развертывание</a></li>
            <li><a href="queues#job-expirations-and-timeouts">Истечение срока работы и тайм-ауты</a></li>
        </ul>
    </li>
    <li><a href="queues#supervisor-configuration">Конфигурация супервизора</a></li>
    <li><a href="queues#dealing-with-failed-jobs">Работа с неудавшейся работой</a>
        <ul>
            <li><a href="queues#cleaning-up-after-failed-jobs">Очистка после неудачных заданий</a></li>
            <li><a href="queues#retrying-failed-jobs">Повторная попытка выполнения невыполненных заданий</a></li>
            <li><a href="queues#ignoring-missing-models">Игнорирование отсутствующих моделей</a></li>
            <li><a href="queues#failed-job-events">События неудачных заданий</a></li>
        </ul>
    </li>
    <li><a href="queues#clearing-jobs-from-queues">Удаление заданий из очередей</a></li>
    <li><a href="queues#job-events">События вакансий</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>При создании веб-приложения у вас могут быть некоторые задачи, такие как синтаксический анализ и сохранение
    загруженного файла CSV, выполнение которых во время типичного веб-запроса занимает слишком много времени. К счастью,
    Laravel позволяет легко создавать задания в очереди, которые могут обрабатываться в фоновом режиме. Перемещая
    трудоемкие задачи в очередь, ваше приложение может отвечать на веб-запросы с молниеносной скоростью и обеспечивать
    лучший пользовательский интерфейс для ваших клиентов.</p>
<p>Очереди Laravel предоставляют унифицированный API очередей для множества различных серверных частей очередей, таких
    как <a href="https://aws.amazon.com/sqs/">Amazon SQS</a>, <a href="https://redis.io">Redis</a> или даже реляционная
    база данных.</p>
<p>Параметры конфигурации очереди Laravel хранятся в <code>config/queue.php</code> файле конфигурации вашего приложения.
    В этом файле вы найдете конфигурации подключения для каждого из драйверов очереди, включенных в структуру, включая
    базу данных, драйверы <a href="https://aws.amazon.com/sqs/">Amazon SQS</a>, <a href="https://redis.io">Redis</a> и
    <a href="https://beanstalkd.github.io/">Beanstalkd</a>, а также синхронный драйвер, который будет выполнять задания
    немедленно (для использования во время местная разработка). <code>null</code> Водитель очереди также включен,
    который отбрасывает в очереди заданий.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Laravel теперь предлагает Horizon, красивую панель управления и систему конфигурации для ваших очередей с
            поддержкой Redis. Ознакомьтесь с полной <a href="horizon">документацией</a> по <a href="horizon">Horizon</a>
            для получения дополнительной информации.</p></p></div>
</blockquote>
<p></p>
<h3 id="connections-vs-queues"><a href="#connections-vs-queues">Соединения Vs. Очереди</a></h3>
<p>Прежде чем приступить к работе с очередями Laravel, важно понять различие между «соединениями» и «очередями». В вашем
    <code>config/queue.php</code> файле конфигурации есть <code>connections</code> массив конфигурации. Этот параметр
    определяет подключения к серверным службам очередей, таким как Amazon SQS, Beanstalk или Redis. Однако любое данное
    соединение очереди может иметь несколько «очередей», которые можно рассматривать как разные стопки или стопки
    заданий в очереди.</p>
<p>Обратите внимание, что каждый пример конфигурации подключения в <code>queue</code> файле конфигурации содержит <code>queue</code>
    атрибут. Это очередь по умолчанию, в которую будут отправляться задания при их отправке в определенное соединение.
    Другими словами, если вы отправляете задание без явного определения очереди, в которую оно должно быть отправлено,
    задание будет помещено в очередь, которая определена в <code>queue</code> атрибуте конфигурации соединения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Jobs<span
                    class="token punctuation">\</span>ProcessPodcast</span><span class="token punctuation">;</span>

<span class="token comment">// This job is sent to the default connection's default queue...</span>
ProcessPodcast<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">dispatch</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// This job is sent to the default connection's "emails" queue...</span>
ProcessPodcast<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">dispatch</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">onQueue</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'emails'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Некоторым приложениям может не понадобиться помещать задания в несколько очередей, вместо этого предпочитая иметь
    одну простую очередь. Однако отправка заданий в несколько очередей может быть особенно полезна для приложений,
    которые хотят расставить приоритеты или сегментировать способ обработки заданий, поскольку работник очереди Laravel
    позволяет вам указать, какие очереди он должен обрабатывать по приоритету. Например, если вы помещаете задания в
    <code>high</code> очередь, вы можете запустить воркер, который даст им более высокий приоритет обработки:</p>
<pre class=" language-php"><code class=" language-php">php artisan queue<span
                class="token punctuation">:</span>work <span class="token operator">--</span>queue<span
                class="token operator">=</span>high<span class="token punctuation">,</span><span class="token keyword">default</span></code></pre>
<p></p>
<h3 id="driver-prerequisites"><a href="#driver-prerequisites">Примечания к драйверам и предварительные требования</a>
</h3>
<p></p>
<h4 id="database"><a href="#database">База данных</a></h4>
<p>Чтобы использовать <code>database</code> драйвер очереди, вам понадобится таблица базы данных для хранения заданий.
    Чтобы сгенерировать миграцию, которая создает эту таблицу, запустите команду <code>queue:table</code> Artisan. После
    создания миграции вы можете выполнить миграцию своей базы данных с помощью <code>migrate</code> команды:</p>
<pre class=" language-php"><code class=" language-php">php artisan queue<span class="token punctuation">:</span>table

php artisan migrate</code></pre>
<p></p>
<h4 id="redis"><a href="#redis">Redis</a></h4>
<p>Чтобы использовать <code>redis</code> драйвер очереди, вы должны настроить соединение с базой данных Redis в <code>config/database.php</code>
    файле конфигурации.</p>
<p><strong>Кластер Redis</strong></p>
<p>Если ваше соединение с очередью Redis использует кластер Redis, имена ваших очередей должны содержать <a
            href="https://redis.io/topics/cluster-spec%23keys-hash-tags">ключевой хэш-тег</a>. Это необходимо для того,
    чтобы все ключи Redis для данной очереди были помещены в один и тот же хэш-слот:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'redis'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'driver'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'redis'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'connection'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'default'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'queue'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'{literal}{default}{/literal}'</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'retry_after'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">90</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p><strong>Блокировка</strong></p>
<p>При использовании очереди Redis вы можете использовать параметр <code>block_for</code> конфигурации, чтобы указать,
    как долго драйвер должен ждать, пока задание станет доступным, прежде чем выполнять итерацию через рабочий цикл и
    повторно опрашивать базу данных Redis.</p>
<p>Регулировка этого значения в зависимости от загрузки очереди может быть более эффективной, чем постоянный опрос базы
    данных Redis на предмет новых заданий. Например, вы можете установить значение, чтобы <code>5</code> указать, что
    драйвер должен блокироваться на пять секунд, ожидая, пока задание станет доступным:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'redis'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'driver'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'redis'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'connection'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'default'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'queue'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'default'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'retry_after'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">90</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'block_for'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">5</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Установка <code>block_for</code> для <code>0</code> волевых рабочих очередей причина заблокировать на
            неопределенный срок, пока задание не будет доступно. Это также предотвратит обработку таких сигналов, как
            <code>SIGTERM</code> обработка следующего задания.</p></p></div>
</blockquote>
<p></p>
<h4 id="other-driver-prerequisites"><a href="#other-driver-prerequisites">Другие необходимые драйверы</a></h4>
<p>Для перечисленных драйверов очереди необходимы следующие зависимости. Эти зависимости могут быть установлены через
    диспетчер пакетов Composer:</p>
<div class="content-list">
    <ul>
        <li>Amazon SQS: <code>aws/aws-sdk-php ~3.0</code></li>
        <li>Beanstalkd: <code>pda/pheanstalk ~4.0</code></li>
        <li>Redis: <code>predis/predis ~1.0</code> или расширение PHP phpredis</li>
    </ul>
</div>
<p></p>
<h2 id="creating-jobs"><a href="#creating-jobs">Создание рабочих мест</a></h2>
<p></p>
<h3 id="generating-job-classes"><a href="#generating-job-classes">Создание классов должностей</a></h3>
<p>По умолчанию все задания в очереди для вашего приложения хранятся в <code>app/Jobs</code> каталоге. Если <code>app/Jobs</code>
    каталог не существует, он будет создан при запуске <code>make:job</code> Artisan-команды:</p>
<pre class=" language-php"><code class=" language-php">php artisan make<span class="token punctuation">:</span>job ProcessPodcast</code></pre>
<p>Сгенерированный класс будет реализовывать <code>Illuminate\Contracts\Queue\ShouldQueue</code> интерфейс, указывая
    Laravel, что задание должно быть помещено в очередь для асинхронного выполнения.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Заготовки заданий можно настроить с помощью <a href="artisan#stub-customization">публикации заглушек.</a>
        </p></p></div>
</blockquote>
<p></p>
<h3 id="class-structure"><a href="#class-structure">Структура класса</a></h3>
<p>Классы заданий очень простые и обычно содержат только <code>handle</code> метод, который вызывается, когда задание
    обрабатывается очередью. Для начала рассмотрим пример класса вакансии. В этом примере мы представим, что управляем
    службой публикации подкастов и нам необходимо обработать загруженные файлы подкастов перед их публикацией:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Jobs</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span
                        class="token punctuation">\</span>Podcast</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Services<span class="token punctuation">\</span>AudioProcessor</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Bus<span
                        class="token punctuation">\</span>Queueable</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>ShouldQueue</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Bus<span class="token punctuation">\</span>Dispatchable</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>InteractsWithQueue</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>SerializesModels</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ProcessPodcast</span> <span
                    class="token keyword">implements</span> <span class="token class-name">ShouldQueue</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">use</span> <span class="token package">Dispatchable</span><span
                    class="token punctuation">,</span> InteractsWithQueue<span class="token punctuation">,</span> Queueable<span
                    class="token punctuation">,</span> SerializesModels<span class="token punctuation">;</span>

    <span class="token comment">/**
    * The podcast instance.
    *
    * @var \App\Models\Podcast
    */</span>
    <span class="token keyword">protected</span> <span class="token variable">$podcast</span><span
                    class="token punctuation">;</span>

    <span class="token comment">/**
    * Create a new job instance.
    *
    * @param  App\Models\Podcast  $podcast
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">__construct</span><span
                    class="token punctuation">(</span>Podcast <span class="token variable">$podcast</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token property">podcast</span> <span
                    class="token operator">=</span> <span class="token variable">$podcast</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
    * Execute the job.
    *
    * @param  App\Services\AudioProcessor  $processor
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">handle</span><span
                    class="token punctuation">(</span>AudioProcessor <span class="token variable">$processor</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">// Process uploaded podcast...</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>В этом примере обратите внимание, что мы смогли передать <a href="eloquent">модель Eloquent</a> непосредственно в
    конструктор задания в очереди. Из-за <code>SerializesModels</code> признака, который использует задание, модели
    Eloquent и их загруженные отношения будут корректно сериализованы и десериализованы во время обработки задания.</p>
<p>Если ваше задание в очереди принимает модель Eloquent в своем конструкторе, в очередь будет сериализован только
    идентификатор модели. Когда задание действительно обрабатывается, система очередей автоматически повторно извлекает
    полный экземпляр модели и его загруженные связи из базы данных. Такой подход к сериализации модели позволяет
    отправлять в драйвер очереди гораздо меньшие полезные нагрузки.</p>
<p></p>
<h4 id="handle-method-dependency-injection"><a href="#handle-method-dependency-injection"><code>handle</code> Внедрение
        зависимости метода</a></h4>
<p><code>handle</code> Метод вызывается, когда задание обрабатывается очереди. Обратите внимание, что мы можем указывать
    зависимости типа от <code>handle</code> метода задания. <a href="container">Сервисный контейнер</a> Laravel
    автоматически внедряет эти зависимости.</p>
<p>Если вы хотите получить полный контроль над тем, как контейнер внедряет зависимости в <code>handle</code> метод, вы
    можете использовать метод контейнера <code>bindMethod</code>. <code>bindMethod</code> Метод принимает функцию
    обратного вызова, который принимает работу и контейнер. В обратном вызове вы можете вызывать <code>handle</code>
    метод, как хотите. Обычно этот метод следует вызывать из <code>boot</code> метода <code>App\Providers\AppServiceProvider</code>
    <a href="providers">поставщика услуг</a>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Jobs<span
                    class="token punctuation">\</span>ProcessPodcast</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                    class="token punctuation">\</span>Services<span
                    class="token punctuation">\</span>AudioProcessor</span><span class="token punctuation">;</span>

<span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">app</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">bindMethod</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>ProcessPodcast<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'handle'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$job</span><span
                class="token punctuation">,</span> <span class="token variable">$app</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$job</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">handle</span><span
                class="token punctuation">(</span><span class="token variable">$app</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">make</span><span class="token punctuation">(</span>AudioProcessor<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Двоичные данные, такие как необработанное содержимое изображения, должны быть переданы через <code>base64_encode</code>
            функцию перед передачей заданию в очереди. В противном случае задание может некорректно сериализоваться в
            JSON при помещении в очередь.</p></p></div>
</blockquote>
<p></p>
<h4 id="handling-relationships"><a href="#handling-relationships">Обработка отношений</a></h4>
<p>Поскольку загруженные отношения также сериализуются, сериализованная строка задания иногда может стать довольно
    большой. Чтобы предотвратить сериализацию отношений, вы можете вызвать <code>withoutRelations</code> метод модели
    при установке значения свойства. Этот метод вернет экземпляр модели без загруженных отношений:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Create a new job instance.
 *
 * @param  \App\Models\Podcast  $podcast
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">__construct</span><span
                class="token punctuation">(</span>Podcast <span class="token variable">$podcast</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">podcast</span> <span
                class="token operator">=</span> <span class="token variable">$podcast</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">withoutRelations</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="unique-jobs"><a href="#unique-jobs">Уникальные вакансии</a></h3>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Для уникальных заданий требуется драйвер кеша, поддерживающий <a href="cache#atomic-locks">блокировки</a>. В
            настоящее время <code>memcached</code>, <code>redis</code>, <code>dynamodb</code>, <code>database</code>,
            <code>file</code>, и <code>array</code> драйвера кэшей поддерживают атомные замки. Кроме того, уникальные
            ограничения задания не применяются к заданиям в пакетах.</p></p></div>
</blockquote>
<p>Иногда вам может потребоваться убедиться, что только один экземпляр определенного задания находится в очереди в любой
    момент времени. Вы можете сделать это, реализовав <code>ShouldBeUnique</code> интерфейс в своем классе работы. Этот
    интерфейс не требует от вас определения каких-либо дополнительных методов в вашем классе:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>ShouldQueue</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>ShouldBeUnique</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">UpdateSearchIndex</span> <span
                    class="token keyword">implements</span> <span class="token class-name">ShouldQueue</span><span
                    class="token punctuation">,</span> ShouldBeUnique
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token punctuation">.</span><span class="token punctuation">.</span><span
                    class="token punctuation">.</span>
<span class="token punctuation">}</span></span></code></pre>
<p>В приведенном выше примере <code>UpdateSearchIndex</code> работа уникальна. Таким образом, задание не будет
    отправлено, если другой экземпляр задания уже находится в очереди и еще не завершил обработку.</p>
<p>В некоторых случаях вы можете захотеть определить конкретный «ключ», который делает задание уникальным, или вы можете
    указать тайм-аут, по истечении которого задание больше не остается уникальным. Для достижения этой цели, вы можете
    определить <code>uniqueId</code> и <code>uniqueFor</code> свойства или методы вашего класса работы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Product</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>ShouldQueue</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>ShouldBeUnique</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">UpdateSearchIndex</span> <span
                    class="token keyword">implements</span> <span class="token class-name">ShouldQueue</span><span
                    class="token punctuation">,</span> ShouldBeUnique
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * The product instance.
     *
     * @var \App\Product
     */</span>
    <span class="token keyword">public</span> <span class="token variable">$product</span><span
                    class="token punctuation">;</span>

    <span class="token comment">/**
     * The number of seconds after which the job's unique lock will be released.
     *
     * @var int
     */</span>
    <span class="token keyword">public</span> <span class="token variable">$uniqueFor</span> <span
                    class="token operator">=</span> <span class="token number">3600</span><span
                    class="token punctuation">;</span>

    <span class="token comment">/**
     * The unique ID of the job.
     *
     * @return string
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">uniqueId</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$this</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token property">product</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">id</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>В приведенном выше примере <code>UpdateSearchIndex</code> задание уникально по идентификатору продукта. Таким
    образом, любые новые отправки задания с тем же идентификатором продукта будут игнорироваться, пока существующее
    задание не завершит обработку. Кроме того, если существующее задание не будет обработано в течение одного часа,
    уникальная блокировка будет снята, и в очередь может быть отправлено другое задание с таким же уникальным ключом.
</p>
<p></p>
<h4 id="keeping-jobs-unique-until-processing-begins"><a href="#keeping-jobs-unique-until-processing-begins">Сохранение
        уникальности вакансий до начала обработки</a></h4>
<p>По умолчанию уникальные задания «разблокируются» после того, как задание завершит обработку или потерпит неудачу во
    всех попытках повторения. Однако могут возникнуть ситуации, когда вы захотите, чтобы ваша работа была разблокирована
    непосредственно перед ее обработкой. Для этого ваша работа должна реализовывать
    <code>ShouldBeUniqueUntilProcessing</code> контракт вместо <code>ShouldBeUnique</code> контракта:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Product</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>ShouldQueue</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Queue<span class="token punctuation">\</span>ShouldBeUniqueUntilProcessing</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">UpdateSearchIndex</span> <span
                    class="token keyword">implements</span> <span class="token class-name">ShouldQueue</span><span
                    class="token punctuation">,</span> ShouldBeUniqueUntilProcessing
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//...</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h4 id="unique-job-locks"><a href="#unique-job-locks">Уникальные блокировки вакансий</a></h4>
<p>За кулисами, когда <code>ShouldBeUnique</code> задание отправлено, Laravel пытается получить <a
            href="cache#atomic-locks">блокировку</a> с помощью <code>uniqueId</code> ключа. Если блокировка не получена,
    задание не отправляется. Эта блокировка снимается, когда задание завершает обработку или терпит неудачу во всех
    попытках повторения. По умолчанию Laravel будет использовать драйвер кеша по умолчанию для получения этой
    блокировки. Однако, если вы хотите использовать другой драйвер для получения блокировки, вы можете определить <code>uniqueVia</code>
    метод, который возвращает драйвер кеша, который следует использовать:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Cache</span><span
                class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">UpdateSearchIndex</span> <span
                class="token keyword">implements</span> <span class="token class-name">ShouldQueue</span><span
                class="token punctuation">,</span> ShouldBeUnique
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token punctuation">.</span><span class="token punctuation">.</span><span
                class="token punctuation">.</span>

    <span class="token comment">/**
    * Get the cache driver for the unique job lock.
    *
    * @return \Illuminate\Contracts\Cache\Repository
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">uniqueVia</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> Cache<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">driver</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'redis'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Если вам нужно ограничить только одновременную обработку задания, используйте <a
                    href="queues#preventing-job-overlaps"><code>WithoutOverlapping</code></a>вместо этого промежуточное
            программное обеспечение задания.</p></p></div>
</blockquote>
<p></p>
<h2 id="job-middleware"><a href="#job-middleware">ПО промежуточного слоя вакансий</a></h2>
<p>Промежуточное ПО для заданий позволяет обернуть настраиваемую логику вокруг выполнения заданий в очереди, уменьшая
    количество шаблонов в самих заданиях. Например, рассмотрим следующий <code>handle</code> метод, который использует
    функции ограничения скорости Laravel Redis, позволяющие обрабатывать только одно задание каждые пять секунд:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Redis</span><span
                class="token punctuation">;</span>

<span class="token comment">/**
 * Execute the job.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">handle</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    Redis<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">throttle</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'key'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">block</span><span
                class="token punctuation">(</span><span class="token number">0</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">allow</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">every</span><span
                class="token punctuation">(</span><span class="token number">5</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">then</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
        <span class="token function">info</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Lock obtained...'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token comment">// Handle job...</span>
    <span class="token punctuation">}</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">// Could not obtain lock...</span>

        <span class="token keyword">return</span> <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">release</span><span
                class="token punctuation">(</span><span class="token number">5</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Хотя этот код действителен, реализация <code>handle</code> метода становится шумной, поскольку он загроможден логикой
    ограничения скорости Redis. Кроме того, эта логика ограничения скорости должна быть продублирована для любых других
    заданий, для которых мы хотим установить ограничение скорости.</p>
<p>Вместо ограничения скорости в методе handle мы могли бы определить промежуточное программное обеспечение задания,
    которое обрабатывает ограничение скорости. В Laravel нет места по умолчанию для промежуточного программного
    обеспечения заданий, поэтому вы можете разместить промежуточное ПО в любом месте вашего приложения. В этом примере
    мы поместим промежуточное ПО в <code>app/Jobs/Middleware</code> каталог:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Jobs<span
                        class="token punctuation">\</span>Middleware</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Redis</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">RateLimited</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Process the queued job.
     *
     * @param  mixed  $job
     * @param  callable  $next
     * @return mixed
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">handle</span><span
                    class="token punctuation">(</span><span class="token variable">$job</span><span
                    class="token punctuation">,</span> <span class="token variable">$next</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        Redis<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">throttle</span><span class="token punctuation">(</span><span
                    class="token single-quoted-string string">'key'</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">block</span><span class="token punctuation">(</span><span
                    class="token number">0</span><span class="token punctuation">)</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">allow</span><span
                    class="token punctuation">(</span><span class="token number">1</span><span
                    class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">every</span><span class="token punctuation">(</span><span
                    class="token number">5</span><span class="token punctuation">)</span>
                <span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">then</span><span class="token punctuation">(</span><span
                    class="token keyword">function</span> <span class="token punctuation">(</span><span
                    class="token punctuation">)</span> <span class="token keyword">use</span> <span
                    class="token punctuation">(</span><span class="token variable">$job</span><span
                    class="token punctuation">,</span> <span class="token variable">$next</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
                    <span class="token comment">// Lock obtained...</span>

                    <span class="token variable">$next</span><span class="token punctuation">(</span><span
                    class="token variable">$job</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
                <span class="token punctuation">}</span><span class="token punctuation">,</span> <span
                    class="token keyword">function</span> <span class="token punctuation">(</span><span
                    class="token punctuation">)</span> <span class="token keyword">use</span> <span
                    class="token punctuation">(</span><span class="token variable">$job</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
                    <span class="token comment">// Could not obtain lock...</span>

                    <span class="token variable">$job</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">release</span><span
                    class="token punctuation">(</span><span class="token number">5</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
                <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Как вы можете видеть, как и <a href="middleware">промежуточное ПО маршрутизации, промежуточное</a> ПО задания
    получает обрабатываемое задание и обратный вызов, который должен быть вызван для продолжения обработки задания.</p>
<p>После создания промежуточного программного обеспечения задания их можно прикрепить к заданию, вернув их из <code>middleware</code>
    метода задания. Этот метод не существует для заданий, созданных командой <code>make:job</code> Artisan, поэтому вам
    нужно будет вручную добавить его в свой класс задания:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Jobs<span
                    class="token punctuation">\</span>Middleware<span
                    class="token punctuation">\</span>RateLimited</span><span class="token punctuation">;</span>

<span class="token comment">/**
 * Get the middleware the job should pass through.
 *
 * @return array
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">middleware</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">[</span><span
                class="token keyword">new</span> <span class="token class-name">RateLimited</span><span
                class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="rate-limiting"><a href="#rate-limiting">Ограничение скорости</a></h3>
<p>Хотя мы только что продемонстрировали, как написать собственное промежуточное ПО с ограничением скорости, Laravel на
    самом деле включает промежуточное ПО с ограничением скорости, которое вы можете использовать для задания ограничения
    скорости. Как и <a href="routing#defining-rate-limiters">ограничители скорости маршрутизации, ограничители
        скорости</a> заданий определяются с помощью метода <code>RateLimiter</code> фасада <code>for</code>.</p>
<p>Например, вы можете разрешить пользователям выполнять резервное копирование своих данных один раз в час, при этом не
    накладывая таких ограничений на премиум-клиентов. Для этого вы можете определить a <code>RateLimiter</code> в <code>boot</code>
    методе вашего <code>AppServiceProvider</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Cache<span
                    class="token punctuation">\</span>RateLimiting<span
                    class="token punctuation">\</span>Limit</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span
                    class="token punctuation">\</span>RateLimiter</span><span class="token punctuation">;</span>

<span class="token comment">/**
 * Bootstrap any application services.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">boot</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    RateLimiter<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token keyword">for</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'backups'</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token variable">$job</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$job</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">vipCustomer</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
                    <span class="token operator">?</span> Limit<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">none</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
                    <span class="token punctuation">:</span> Limit<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">perHour</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">by</span><span class="token punctuation">(</span><span
                class="token variable">$job</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>В приведенном выше примере мы определили лимит почасовой оплаты; однако вы можете легко определить ограничение
    скорости на основе минут, используя этот <code>perMinute</code> метод. Кроме того, вы можете передать любое значение
    <code>by</code> методу ограничения скорости; однако это значение чаще всего используется для сегментирования лимитов
    ставок клиентом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> Limit<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">perMinute</span><span
                class="token punctuation">(</span><span class="token number">50</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">by</span><span class="token punctuation">(</span><span
                class="token variable">$job</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>После того, как вы определили предел скорости, вы можете присоединить ограничитель скорости к своему заданию
    резервного копирования с помощью <code>Illuminate\Queue\Middleware\RateLimited</code> промежуточного программного
    обеспечения. Каждый раз, когда задание превышает ограничение скорости, это ПО промежуточного слоя отправляет задание
    обратно в очередь с соответствующей задержкой в ​​зависимости от продолжительности ограничения скорости.</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Queue<span
                    class="token punctuation">\</span>Middleware<span
                    class="token punctuation">\</span>RateLimited</span><span class="token punctuation">;</span>

<span class="token comment">/**
 * Get the middleware the job should pass through.
 *
 * @return array
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">middleware</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">[</span><span
                class="token keyword">new</span> <span class="token class-name">RateLimited</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'backups'</span><span
                class="token punctuation">)</span><span class="token punctuation">]</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Если вернуть задание с ограниченной скоростью обратно в очередь, общее количество заданий будет увеличиваться на
    <code>attempts</code>. Вы можете настроить свои <code>tries</code> и <code>maxExceptions</code> свойства на классе
    работы соответственно. Или вы можете использовать этот <a href="queues#time-based-attempts"><code>retryUntil</code>
        метод,</a> чтобы определить количество времени, по истечении которого выполнение задания больше не будет
    выполняться.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Если вы используете Redis, вы можете использовать
            <code>Illuminate\Queue\Middleware\RateLimitedWithRedis</code> промежуточное ПО, которое точно настроено для
            Redis и более эффективно, чем базовое промежуточное ПО с ограничением скорости.</p></p></div>
</blockquote>
<p></p>
<h3 id="preventing-job-overlaps"><a href="#preventing-job-overlaps">Предотвращение дублирования работы</a></h3>
<p>Laravel включает <code>Illuminate\Queue\Middleware\WithoutOverlapping</code> промежуточное ПО, которое позволяет
    предотвращать дублирование заданий на основе произвольного ключа. Это может быть полезно, когда задание в очереди
    изменяет ресурс, который должен изменяться только одним заданием за раз.</p>
<p>Например, представим, что у вас есть задание в очереди, которое обновляет кредитный рейтинг пользователя, и вы хотите
    предотвратить дублирование заданий обновления кредитного рейтинга для одного и того же идентификатора пользователя.
    Для этого вы можете вернуть <code>WithoutOverlapping</code> промежуточное ПО из <code>middleware</code> метода вашей
    работы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Queue<span
                    class="token punctuation">\</span>Middleware<span class="token punctuation">\</span>WithoutOverlapping</span><span
                class="token punctuation">;</span>

<span class="token comment">/**
 * Get the middleware the job should pass through.
 *
 * @return array
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">middleware</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">[</span><span
                class="token keyword">new</span> <span class="token class-name">WithoutOverlapping</span><span
                class="token punctuation">(</span><span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">user</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span><span class="token punctuation">)</span><span class="token punctuation">]</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Любые перекрывающиеся задания будут возвращены в очередь. Вы также можете указать количество секунд, которое должно
    пройти до того, как выпущенное задание будет выполнено снова:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the middleware the job should pass through.
 *
 * @return array
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">middleware</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">[</span><span
                class="token punctuation">(</span><span class="token keyword">new</span> <span class="token class-name">WithoutOverlapping</span><span
                class="token punctuation">(</span><span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">order</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">id</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">releaseAfter</span><span
                class="token punctuation">(</span><span class="token number">60</span><span
                class="token punctuation">)</span><span class="token punctuation">]</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Если вы хотите немедленно удалить любые перекрывающиеся задания, чтобы их не повторить, вы можете использовать <code>dontRelease</code>
    метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the middleware the job should pass through.
 *
 * @return array
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">middleware</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">[</span><span
                class="token punctuation">(</span><span class="token keyword">new</span> <span class="token class-name">WithoutOverlapping</span><span
                class="token punctuation">(</span><span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">order</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">id</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">dontRelease</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Для <code>WithoutOverlapping</code> промежуточного программного обеспечения требуется драйвер кеша,
            поддерживающий <a href="cache#atomic-locks">блокировки</a>. В настоящее время <code>memcached</code>, <code>redis</code>,
            <code>dynamodb</code>, <code>database</code>, <code>file</code>, и <code>array</code> драйвера кэшей
            поддерживают атомные замки.</p></p></div>
</blockquote>
<p></p>
<h2 id="dispatching-jobs"><a href="#dispatching-jobs">Диспетчерские работы</a></h2>
<p>После того, как вы написали свой класс работы, вы можете отправить его, используя <code>dispatch</code> метод самого
    задания. Аргументы, переданные <code>dispatch</code> методу, будут переданы конструктору задания:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>Controller</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Jobs<span
                        class="token punctuation">\</span>ProcessPodcast</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span
                        class="token punctuation">\</span>Podcast</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">PodcastController</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Store a new podcast.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">store</span><span
                    class="token punctuation">(</span>Request <span class="token variable">$request</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$podcast</span> <span class="token operator">=</span> Podcast<span
                    class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">create</span><span class="token punctuation">(</span><span
                    class="token punctuation">.</span><span class="token punctuation">.</span><span
                    class="token punctuation">.</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>

        <span class="token comment">//...</span>

        ProcessPodcast<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">dispatch</span><span class="token punctuation">(</span><span
                    class="token variable">$podcast</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Если вы хотели бы условно направить работу, вы можете использовать <code>dispatchIf</code> и
    <code>dispatchUnless</code> методы:</p>
<pre class=" language-php"><code class=" language-php">ProcessPodcast<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">dispatchIf</span><span
                class="token punctuation">(</span><span class="token variable">$accountActive</span><span
                class="token punctuation">,</span> <span class="token variable">$podcast</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

ProcessPodcast<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">dispatchUnless</span><span class="token punctuation">(</span><span
                class="token variable">$accountSuspended</span><span class="token punctuation">,</span> <span
                class="token variable">$podcast</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="delayed-dispatching"><a href="#delayed-dispatching">Отложенная отправка</a></h3>
<p>Если вы хотите указать, что задание не должно быть немедленно доступно для обработки работником очереди, вы можете
    использовать этот <code>delay</code> метод при отправке задания. Например, давайте укажем, что задание не должно
    быть доступно для обработки в течение 10 минут после его отправки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>Controller</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Jobs<span
                        class="token punctuation">\</span>ProcessPodcast</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span
                        class="token punctuation">\</span>Podcast</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">PodcastController</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Store a new podcast.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">store</span><span
                    class="token punctuation">(</span>Request <span class="token variable">$request</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$podcast</span> <span class="token operator">=</span> Podcast<span
                    class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">create</span><span class="token punctuation">(</span><span
                    class="token punctuation">.</span><span class="token punctuation">.</span><span
                    class="token punctuation">.</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>

        <span class="token comment">//...</span>

        ProcessPodcast<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">dispatch</span><span class="token punctuation">(</span><span
                    class="token variable">$podcast</span><span class="token punctuation">)</span>
                    <span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">delay</span><span class="token punctuation">(</span><span
                    class="token function">now</span><span class="token punctuation">(</span><span
                    class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">addMinutes</span><span class="token punctuation">(</span><span
                    class="token number">10</span><span class="token punctuation">)</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p> У службы очередей Amazon SQS максимальное время задержки составляет 15 минут.</p></p></div>
</blockquote>
<p></p>
<h4 id="dispatching-after-the-response-is-sent-to-browser"><a href="#dispatching-after-the-response-is-sent-to-browser">Отправка
        после отправки ответа в браузер</a></h4>
<p>Кроме того, <code>dispatchAfterResponse</code> метод откладывает отправку задания до тех пор, пока HTTP-ответ не
    будет отправлен в браузер пользователя. Это по-прежнему позволит пользователю начать использовать приложение, даже
    если задание в очереди все еще выполняется. Обычно это следует использовать только для заданий, которые занимают
    около секунды, например, для отправки электронного письма. Поскольку они обрабатываются в рамках текущего
    HTTP-запроса, отправляемые таким образом задания не требуют запуска обработчика очереди для их обработки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Jobs<span
                    class="token punctuation">\</span>SendNotification</span><span class="token punctuation">;</span>

SendNotification<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">dispatchAfterResponse</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы также можете <code>dispatch</code> закрыть и связать <code>afterResponse</code> метод с <code>dispatch</code>
    помощником для выполнения закрытия после того, как HTTP-ответ был отправлен в браузер:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Mail<span
                    class="token punctuation">\</span>WelcomeMessage</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Mail</span><span
                class="token punctuation">;</span>

<span class="token function">dispatch</span><span class="token punctuation">(</span><span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    Mail<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">to</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'taylor@example.com'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">send</span><span
                class="token punctuation">(</span><span class="token keyword">new</span> <span class="token class-name">WelcomeMessage</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">afterResponse</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="synchronous-dispatching"><a href="#synchronous-dispatching">Синхронная диспетчеризация</a></h3>
<p>Если вы хотите отправить задание немедленно (синхронно), вы можете использовать этот <code>dispatchSync</code> метод.
    При использовании этого метода задание не будет помещено в очередь и будет выполнено немедленно в текущем процессе:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>Controller</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Jobs<span
                        class="token punctuation">\</span>ProcessPodcast</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span
                        class="token punctuation">\</span>Podcast</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">PodcastController</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Store a new podcast.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">store</span><span
                    class="token punctuation">(</span>Request <span class="token variable">$request</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$podcast</span> <span class="token operator">=</span> Podcast<span
                    class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">create</span><span class="token punctuation">(</span><span
                    class="token punctuation">.</span><span class="token punctuation">.</span><span
                    class="token punctuation">.</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>

        <span class="token comment">// Create podcast...</span>

        ProcessPodcast<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">dispatchSync</span><span class="token punctuation">(</span><span
                    class="token variable">$podcast</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h3 id="jobs-and-database-transactions"><a href="#jobs-and-database-transactions">Работа и транзакции в базе данных</a>
</h3>
<p>Хотя отправка заданий в транзакциях базы данных - это нормально, вам следует позаботиться о том, чтобы ваша работа
    действительно могла успешно выполняться. При отправке задания в рамках транзакции возможно, что задание будет
    обработано работником до того, как транзакция будет зафиксирована. Когда это происходит, любые обновления, внесенные
    вами в модели или записи базы данных во время транзакции базы данных, могут еще не быть отражены в базе данных.
    Кроме того, любые модели или записи базы данных, созданные в рамках транзакции, могут не существовать в базе
    данных.</p>
<p>К счастью, Laravel предоставляет несколько методов решения этой проблемы. Во-первых, вы можете установить <code>after_commit</code>
    параметр подключения в массиве конфигурации подключения к очереди:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'redis'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'driver'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'redis'</span><span
                class="token punctuation">,</span>
    <span class="token comment">//...</span>
    <span class="token single-quoted-string string">'after_commit'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token boolean constant">true</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p>Если установлен <code>after_commit</code> вариант <code>true</code>, вы можете отправлять задания в транзакциях базы
    данных; однако Laravel будет ждать, пока все открытые транзакции базы данных не будут зафиксированы, прежде чем
    фактически отправить задание. Конечно, если в настоящее время транзакции с базой данных не открыты, задание будет
    отправлено немедленно.</p>
<p>Если транзакция откатывается из-за исключения, которое возникает во время транзакции, отправленные задания, которые
    были отправлены во время этой транзакции, будут отброшены.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Установка <code>after_commit</code> для параметра конфигурации значения <code>true</code> также приведет к
            отправке любых обработчиков событий в очереди, почтовых сообщений, уведомлений и широковещательных событий
            после того, как все открытые транзакции базы данных были зафиксированы.</p></p></div>
</blockquote>
<p></p>
<h4 id="specifying-commit-dispatch-behavior-inline"><a href="#specifying-commit-dispatch-behavior-inline">Указание
        поведения отправки при фиксации в строке</a></h4>
<p>Если вы не установите <code>after_commit</code> для параметра конфигурации соединения очереди значение
    <code>true</code>, вы все равно можете указать, что конкретное задание должно быть отправлено после того, как все
    открытые транзакции базы данных были зафиксированы. Для этого вы можете связать <code>afterCommit</code> метод с
    операцией отправки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Jobs<span
                    class="token punctuation">\</span>ProcessPodcast</span><span class="token punctuation">;</span>

ProcessPodcast<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">dispatch</span><span class="token punctuation">(</span><span
                class="token variable">$podcast</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">afterCommit</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Аналогичным образом, если параметр <code>after_commit</code> конфигурации установлен в значение <code>true</code>, вы
    можете указать, что конкретное задание должно быть отправлено немедленно, не дожидаясь фиксации каких-либо открытых
    транзакций базы данных:</p>
<pre class=" language-php"><code class=" language-php">ProcessPodcast<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">dispatch</span><span
                class="token punctuation">(</span><span class="token variable">$podcast</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">beforeCommit</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="job-chaining"><a href="#job-chaining">Связь вакансий</a></h3>
<p>Цепочка заданий позволяет указать список заданий в очереди, которые должны выполняться последовательно после
    успешного выполнения основного задания. Если одно задание в последовательности выйдет из строя, остальные задания не
    будут запущены. Чтобы выполнить цепочку заданий в очереди, вы можете использовать <code>chain</code> метод,
    предоставляемый <code>Bus</code> фасадом. Командная шина Laravel - это компонент нижнего уровня, на котором
    построена диспетчеризация заданий в очереди:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Jobs<span
                    class="token punctuation">\</span>OptimizePodcast</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Jobs<span
                    class="token punctuation">\</span>ProcessPodcast</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Jobs<span
                    class="token punctuation">\</span>ReleasePodcast</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Bus</span><span
                class="token punctuation">;</span>

Bus<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">chain</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span>
    <span class="token keyword">new</span> <span class="token class-name">ProcessPodcast</span><span
                class="token punctuation">,</span>
    <span class="token keyword">new</span> <span class="token class-name">OptimizePodcast</span><span
                class="token punctuation">,</span>
    <span class="token keyword">new</span> <span class="token class-name">ReleasePodcast</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">dispatch</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>В дополнение к цепочке экземпляров класса задания вы также можете цеплять замыкания:</p>
<pre class=" language-php"><code class=" language-php">Bus<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">chain</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token keyword">new</span> <span class="token class-name">ProcessPodcast</span><span
                class="token punctuation">,</span>
    <span class="token keyword">new</span> <span class="token class-name">OptimizePodcast</span><span
                class="token punctuation">,</span>
    <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
        Podcast<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">update</span><span class="token punctuation">(</span><span
                class="token punctuation">.</span><span class="token punctuation">.</span><span
                class="token punctuation">.</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">dispatch</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Удаление заданий с помощью <code>$this-&gt;delete()</code> метода внутри задания не предотвратит обработку
            связанных заданий. Цепочка прекратит выполнение только в случае сбоя задания в цепочке.</p></p></div>
</blockquote>
<p></p>
<h4 id="chain-connection-queue"><a href="#chain-connection-queue">Цепное соединение и очередь</a></h4>
<p>Если вы хотите, чтобы указать соединение и очереди, которые должны быть использованы для прикованных рабочих мест, вы
    можете использовать <code>onConnection</code> и <code>onQueue</code> методы. Эти методы указывают подключение к
    очереди и имя очереди, которые следует использовать, если заданию в очереди явно не назначено другое подключение /
    очередь:</p>
<pre class=" language-php"><code class=" language-php">Bus<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">chain</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token keyword">new</span> <span class="token class-name">ProcessPodcast</span><span
                class="token punctuation">,</span>
    <span class="token keyword">new</span> <span class="token class-name">OptimizePodcast</span><span
                class="token punctuation">,</span>
    <span class="token keyword">new</span> <span class="token class-name">ReleasePodcast</span><span
                class="token punctuation">,</span>
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
<p></p>
<h4 id="chain-failures"><a href="#chain-failures">Цепные отказы</a></h4>
<p>При связывании заданий вы можете использовать этот <code>catch</code> метод, чтобы указать закрытие, которое должно
    вызываться в случае сбоя задания в цепочке. Данный обратный вызов получит <code>Throwable</code> экземпляр,
    вызвавший сбой задания:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Bus</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Throwable</span><span
                class="token punctuation">;</span>

Bus<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">chain</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span>
    <span class="token keyword">new</span> <span class="token class-name">ProcessPodcast</span><span
                class="token punctuation">,</span>
    <span class="token keyword">new</span> <span class="token class-name">OptimizePodcast</span><span
                class="token punctuation">,</span>
    <span class="token keyword">new</span> <span class="token class-name">ReleasePodcast</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token keyword">catch</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span>Throwable <span class="token variable">$e</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// A job within the chain has failed...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">dispatch</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="customizing-the-queue-and-connection"><a href="#customizing-the-queue-and-connection">Настройка очереди и
        подключения</a></h3>
<p></p>
<h4 id="dispatching-to-a-particular-queue"><a href="#dispatching-to-a-particular-queue">Отправка в определенную
        очередь</a></h4>
<p>Помещая задания в разные очереди, вы можете «классифицировать» свои задания в очереди и даже определять приоритеты,
    сколько работников вы назначаете в разные очереди. Имейте в виду, что при этом задания не отправляются в разные
    «соединения» очередей, как определено в файле конфигурации очереди, а только в определенные очереди в рамках одного
    соединения. Чтобы указать очередь, используйте <code>onQueue</code> метод при отправке задания:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>Controller</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Jobs<span
                        class="token punctuation">\</span>ProcessPodcast</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span
                        class="token punctuation">\</span>Podcast</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">PodcastController</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Store a new podcast.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">store</span><span
                    class="token punctuation">(</span>Request <span class="token variable">$request</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$podcast</span> <span class="token operator">=</span> Podcast<span
                    class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">create</span><span class="token punctuation">(</span><span
                    class="token punctuation">.</span><span class="token punctuation">.</span><span
                    class="token punctuation">.</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>

        <span class="token comment">// Create podcast...</span>

        ProcessPodcast<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">dispatch</span><span class="token punctuation">(</span><span
                    class="token variable">$podcast</span><span class="token punctuation">)</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">onQueue</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'processing'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>В качестве альтернативы вы можете указать очередь задания, вызвав <code>onQueue</code> метод в конструкторе задания:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Jobs</span><span
                    class="token punctuation">;</span>

 <span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Bus<span
                        class="token punctuation">\</span>Queueable</span><span class="token punctuation">;</span>
 <span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>ShouldQueue</span><span class="token punctuation">;</span>
 <span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Bus<span class="token punctuation">\</span>Dispatchable</span><span
                    class="token punctuation">;</span>
 <span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>InteractsWithQueue</span><span
                    class="token punctuation">;</span>
 <span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>SerializesModels</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ProcessPodcast</span> <span
                    class="token keyword">implements</span> <span class="token class-name">ShouldQueue</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">use</span> <span class="token package">Dispatchable</span><span
                    class="token punctuation">,</span> InteractsWithQueue<span class="token punctuation">,</span> Queueable<span
                    class="token punctuation">,</span> SerializesModels<span class="token punctuation">;</span>

    <span class="token comment">/**
     * Create a new job instance.
     *
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">__construct</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">onQueue</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'processing'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h4 id="dispatching-to-a-particular-connection"><a href="#dispatching-to-a-particular-connection">Отправка на конкретное
        соединение</a></h4>
<p>Если ваше приложение взаимодействует с несколькими подключениями к очереди, вы можете указать, на какое подключение
    нужно отправить задание, используя <code>onConnection</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>Controller</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Jobs<span
                        class="token punctuation">\</span>ProcessPodcast</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span
                        class="token punctuation">\</span>Podcast</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">PodcastController</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Store a new podcast.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">store</span><span
                    class="token punctuation">(</span>Request <span class="token variable">$request</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$podcast</span> <span class="token operator">=</span> Podcast<span
                    class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">create</span><span class="token punctuation">(</span><span
                    class="token punctuation">.</span><span class="token punctuation">.</span><span
                    class="token punctuation">.</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>

        <span class="token comment">// Create podcast...</span>

        ProcessPodcast<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">dispatch</span><span class="token punctuation">(</span><span
                    class="token variable">$podcast</span><span class="token punctuation">)</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">onConnection</span><span
                    class="token punctuation">(</span><span class="token single-quoted-string string">'sqs'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Вы можете приковать <code>onConnection</code> и <code>onQueue</code> методы вместе, чтобы указать соединение и
    очередь на работу:</p>
<pre class=" language-php"><code class=" language-php">ProcessPodcast<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">dispatch</span><span
                class="token punctuation">(</span><span class="token variable">$podcast</span><span
                class="token punctuation">)</span>
              <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">onConnection</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'sqs'</span><span
                class="token punctuation">)</span>
              <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">onQueue</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'processing'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>В качестве альтернативы вы можете указать соединение с заданием, вызвав <code>onConnection</code> метод в
    конструкторе задания:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Jobs</span><span
                    class="token punctuation">;</span>

 <span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Bus<span
                        class="token punctuation">\</span>Queueable</span><span class="token punctuation">;</span>
 <span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>ShouldQueue</span><span class="token punctuation">;</span>
 <span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Bus<span class="token punctuation">\</span>Dispatchable</span><span
                    class="token punctuation">;</span>
 <span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>InteractsWithQueue</span><span
                    class="token punctuation">;</span>
 <span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>SerializesModels</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ProcessPodcast</span> <span
                    class="token keyword">implements</span> <span class="token class-name">ShouldQueue</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">use</span> <span class="token package">Dispatchable</span><span
                    class="token punctuation">,</span> InteractsWithQueue<span class="token punctuation">,</span> Queueable<span
                    class="token punctuation">,</span> SerializesModels<span class="token punctuation">;</span>

    <span class="token comment">/**
     * Create a new job instance.
     *
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">__construct</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">onConnection</span><span
                    class="token punctuation">(</span><span class="token single-quoted-string string">'sqs'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h3 id="max-job-attempts-and-timeout"><a href="#max-job-attempts-and-timeout">Указание максимального количества попыток
        задания / значений тайм-аута</a></h3>
<p></p>
<h4 id="max-attempts"><a href="#max-attempts">Максимальное количество попыток</a></h4>
<p>Если одно из ваших заданий в очереди обнаруживает ошибку, вы, вероятно, не хотите, чтобы оно продолжало повторять
    попытки бесконечно. Следовательно, Laravel предоставляет различные способы указать, сколько раз и как долго задание
    может быть выполнено.</p>
<p>Один из подходов к указанию максимального количества попыток выполнения задания - использование <code>--tries</code>
    переключателя в командной строке Artisan. Это будет применяться ко всем заданиям, обрабатываемым работником, если
    только обрабатываемое задание не указывает более конкретное количество попыток его выполнения:</p>
<pre class=" language-php"><code class=" language-php">php artisan queue<span
                class="token punctuation">:</span>work <span class="token operator">--</span>tries<span
                class="token operator">=</span><span class="token number">3</span></code></pre>
<p>Если задание превышает максимальное количество попыток, оно будет считаться «неудачным». Для получения дополнительной
    информации об обработке невыполненных заданий обратитесь к <a
            href="queues#dealing-with-failed-jobs">документации</a> по <a href="queues#dealing-with-failed-jobs">невыполненным
        заданиям</a>.</p>
<p>Вы можете использовать более детальный подход, определив максимальное количество попыток выполнения задания для
    самого класса задания. Если для задания указано максимальное количество попыток, оно будет иметь приоритет над
    <code>--tries</code> значением, указанным в командной строке:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Jobs</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ProcessPodcast</span> <span
                    class="token keyword">implements</span> <span class="token class-name">ShouldQueue</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * The number of times the job may be attempted.
     *
     * @var int
     */</span>
    <span class="token keyword">public</span> <span class="token variable">$tries</span> <span
                    class="token operator">=</span> <span class="token number">5</span><span
                    class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h4 id="time-based-attempts"><a href="#time-based-attempts">Попытки, основанные на времени</a></h4>
<p>В качестве альтернативы определению количества попыток выполнения задания до того, как оно завершится ошибкой, вы
    можете определить время, когда выполнение задания больше не должно выполняться. Это позволяет выполнять задание
    любое количество раз в течение заданного периода времени. Чтобы определить время, в которое больше не следует
    пытаться <code>retryUntil</code> выполнить задание, добавьте метод в свой класс задания. Этот метод должен
    возвращать <code>DateTime</code> экземпляр:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Determine the time at which the job should timeout.
 *
 * @return \DateTime
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">retryUntil</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token function">now</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">addMinutes</span><span
                class="token punctuation">(</span><span class="token number">10</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Вы также можете определить <code>tries</code> свойство или <code>retryUntil</code> метод в ваших <a
                    href="events#queued-event-listeners">слушателях событий в очереди</a>.</p></p></div>
</blockquote>
<p></p>
<h4 id="max-exceptions"><a href="#max-exceptions">Максимальное количество исключений</a></h4>
<p>Иногда вы можете указать, что задание может быть выполнено много раз, но должно завершиться ошибкой, если повторные
    попытки инициированы заданным количеством необработанных исключений (в отличие от того, чтобы запускаться <code>release</code>
    методом напрямую). Для этого вы можете определить <code>maxExceptions</code> свойство в своем классе работы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Jobs</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Redis</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ProcessPodcast</span> <span
                    class="token keyword">implements</span> <span class="token class-name">ShouldQueue</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * The number of times the job may be attempted.
     *
     * @var int
     */</span>
    <span class="token keyword">public</span> <span class="token variable">$tries</span> <span
                    class="token operator">=</span> <span class="token number">25</span><span class="token punctuation">;</span>

    <span class="token comment">/**
     * The maximum number of unhandled exceptions to allow before failing.
     *
     * @var int
     */</span>
    <span class="token keyword">public</span> <span class="token variable">$maxExceptions</span> <span
                    class="token operator">=</span> <span class="token number">3</span><span
                    class="token punctuation">;</span>

    <span class="token comment">/**
     * Execute the job.
     *
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">handle</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        Redis<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">throttle</span><span class="token punctuation">(</span><span
                    class="token single-quoted-string string">'key'</span><span class="token punctuation">)</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">allow</span><span
                    class="token punctuation">(</span><span class="token number">10</span><span
                    class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">every</span><span class="token punctuation">(</span><span
                    class="token number">60</span><span class="token punctuation">)</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">then</span><span
                    class="token punctuation">(</span><span class="token keyword">function</span> <span
                    class="token punctuation">(</span><span class="token punctuation">)</span> <span
                    class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">// Lock obtained, process the podcast...</span>
        <span class="token punctuation">}</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span
                    class="token punctuation">(</span><span class="token punctuation">)</span> <span
                    class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">// Unable to obtain lock...</span>
            <span class="token keyword">return</span> <span class="token variable">$this</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">release</span><span
                    class="token punctuation">(</span><span class="token number">10</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>В этом примере задание освобождается на десять секунд, если приложение не может получить блокировку Redis, и будет
    продолжать повторяться до 25 раз. Однако задание завершится ошибкой, если оно вызовет три необработанных
    исключения.</p>
<p></p>
<h4 id="timeout"><a href="#timeout">Тайм-аут</a></h4>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p><code>pcntl</code> Расширение PHP должен быть установлен для того, чтобы указать время ожидания задания.
        </p></p></div>
</blockquote>
<p>Часто вы приблизительно знаете, сколько времени займет выполнение заданий в очереди. По этой причине Laravel
    позволяет вам указать значение «тайм-аута». Если задание обрабатывается дольше, чем количество секунд, указанное
    значением тайм-аута, рабочий, выполняющий задание, завершится с ошибкой. Обычно рабочий <a
            href="queues#supervisor-configuration">процесс</a> перезапускается автоматически <a
            href="queues#supervisor-configuration">менеджером процессов, настроенным на вашем сервере</a>.</p>
<p>Максимальное количество секунд, в течение которых могут выполняться задания, можно указать с помощью
    <code>--timeout</code> переключателя в командной строке Artisan:</p>
<pre class=" language-php"><code class=" language-php">php artisan queue<span
                class="token punctuation">:</span>work <span class="token operator">--</span>timeout<span
                class="token operator">=</span><span class="token number">30</span></code></pre>
<p>Если задание превышает максимальное количество попыток из-за постоянного тайм-аута, оно будет помечено как
    неудачное.</p>
<p>Вы также можете определить максимальное количество секунд, в течение которого задание может выполняться в самом
    классе задания. Если для задания указан тайм-аут, он будет иметь приоритет над любым тайм-аутом, указанным в
    командной строке:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Jobs</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ProcessPodcast</span> <span
                    class="token keyword">implements</span> <span class="token class-name">ShouldQueue</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * The number of seconds the job can run before timing out.
     *
     * @var int
     */</span>
    <span class="token keyword">public</span> <span class="token variable">$timeout</span> <span class="token operator">=</span> <span
                    class="token number">120</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Иногда процессы блокировки ввода-вывода, такие как сокеты или исходящие HTTP-соединения, могут не учитывать указанный
    вами тайм-аут. Следовательно, при использовании этих функций вы всегда должны пытаться указать тайм-аут, используя
    также их API. Например, при использовании Guzzle вы всегда должны указывать значение таймаута соединения и
    запроса.</p>
<p></p>
<h3 id="error-handling"><a href="#error-handling">Обработка ошибок</a></h3>
<p>Если во время обработки задания возникает исключение, задание автоматически возвращается в очередь, чтобы его можно
    было повторить. Задание будет продолжать освобождаться до тех пор, пока оно не будет выполнено максимальное
    количество раз, разрешенное вашим приложением. Максимальное количество попыток определяется <code>--tries</code>
    переключателем, используемым в команде <code>queue:work</code> Artisan. В качестве альтернативы максимальное
    количество попыток может быть определено в самом классе задания. Более подробную информацию о запуске обработчика
    очереди <a href="queues#running-the-queue-worker">можно найти ниже</a>.</p>
<p></p>
<h4 id="manually-releasing-a-job"><a href="#manually-releasing-a-job">Освобождение работы вручную</a></h4>
<p>Иногда вы можете захотеть вручную вернуть задание в очередь, чтобы его можно было повторить позже. Вы можете сделать
    это, вызвав <code>release</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Execute the job.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">handle</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//...</span>

    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">release</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>По умолчанию этот <code>release</code> метод возвращает задание в очередь для немедленной обработки. Однако, передав
    <code>release</code> методу целое число, вы можете указать очереди не делать задание доступным для обработки, пока
    не пройдет заданное количество секунд:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">release</span><span
                class="token punctuation">(</span><span class="token number">10</span><span
                class="token punctuation">)</span></code></pre>
<p></p>
<h4 id="manually-failing-a-job"><a href="#manually-failing-a-job">Сбой работы вручную</a></h4>
<p>Иногда вам может потребоваться вручную пометить задание как «неудачное». Для этого вы можете вызвать
    <code>fail</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Execute the job.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">handle</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//...</span>

    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">fail</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Если вы хотите пометить свою работу как неудавшуюся из-за обнаруженного исключения, вы можете передать исключение в
    <code>fail</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">fail</span><span class="token punctuation">(</span><span class="token variable">$exception</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Для получения дополнительной информации о невыполненных заданиях ознакомьтесь с <a
                    href="queues#dealing-with-failed-jobs">документацией по устранению сбоев в работе</a>.</p></p></div>
</blockquote>
<p></p>
<h2 id="job-batching"><a href="#job-batching">Пакетирование заданий</a></h2>
<p>Функция пакетной обработки заданий Laravel позволяет вам легко выполнять пакет заданий, а затем выполнять некоторые
    действия после завершения выполнения пакета заданий. Перед тем, как начать, вы должны создать миграцию базы данных,
    чтобы построить таблицу, содержащую метаинформацию о ваших пакетах заданий, такую ​​как процент их завершения. Эту
    миграцию можно сгенерировать с помощью <code>queue:batches-table</code> Artisan-команды:</p>
<pre class=" language-php"><code class=" language-php">php artisan queue<span
                class="token punctuation">:</span>batches<span class="token operator">-</span>table

php artisan migrate</code></pre>
<p></p>
<h3 id="defining-batchable-jobs"><a href="#defining-batchable-jobs">Определение заданий с возможностью батча</a></h3>
<p>Чтобы определить задание с возможностью пакетной передачи, вы должны <a href="queues#creating-jobs">создать
        задание</a> в <a href="queues#creating-jobs">очереди</a> как обычно; однако вы должны добавить эту <code>Illuminate\Bus\Batchable</code>
    черту к классу работы. Эта черта предоставляет доступ к <code>batch</code> методу, который можно использовать для
    получения текущего пакета, в котором выполняется задание:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Jobs</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Bus<span
                        class="token punctuation">\</span>Batchable</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Bus<span
                        class="token punctuation">\</span>Queueable</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>ShouldQueue</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Bus<span class="token punctuation">\</span>Dispatchable</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>InteractsWithQueue</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>SerializesModels</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ImportCsv</span> <span class="token keyword">implements</span> <span
                    class="token class-name">ShouldQueue</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">use</span> <span class="token package">Batchable</span><span
                    class="token punctuation">,</span> Dispatchable<span class="token punctuation">,</span> InteractsWithQueue<span
                    class="token punctuation">,</span> Queueable<span class="token punctuation">,</span> SerializesModels<span
                    class="token punctuation">;</span>

    <span class="token comment">/**
     * Execute the job.
     *
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">handle</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">if</span> <span class="token punctuation">(</span><span
                    class="token variable">$this</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">batch</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">cancelled</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">// Determine if the batch has been cancelled...</span>

            <span class="token keyword">return</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span>

        <span class="token comment">// Import a portion of the CSV file...</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h3 id="dispatching-batches"><a href="#dispatching-batches">Отгрузка партий</a></h3>
<p>Чтобы отправить пакет заданий, следует использовать <code>batch</code> метод <code>Bus</code> фасада. Конечно,
    пакетирование в первую очередь полезно в сочетании с обратными вызовами завершения. Таким образом, вы можете
    использовать <code>then</code>, <code>catch</code> и <code>finally</code> методы для определения завершения
    обратного вызова для партии. Каждый из этих обратных вызовов получит <code>Illuminate\Bus\Batch</code> экземпляр при
    вызове. В этом примере мы представим, что ставим в очередь пакет заданий, каждое из которых обрабатывает заданное
    количество строк из файла CSV:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Jobs<span
                    class="token punctuation">\</span>ImportCsv</span><span class="token punctuation">;</span>
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
    <span class="token keyword">new</span> <span class="token class-name">ImportCsv</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">,</span> <span class="token number">100</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span>
    <span class="token keyword">new</span> <span class="token class-name">ImportCsv</span><span
                class="token punctuation">(</span><span class="token number">101</span><span
                class="token punctuation">,</span> <span class="token number">200</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span>
    <span class="token keyword">new</span> <span class="token class-name">ImportCsv</span><span
                class="token punctuation">(</span><span class="token number">201</span><span
                class="token punctuation">,</span> <span class="token number">300</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span>
    <span class="token keyword">new</span> <span class="token class-name">ImportCsv</span><span
                class="token punctuation">(</span><span class="token number">301</span><span
                class="token punctuation">,</span> <span class="token number">400</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span>
    <span class="token keyword">new</span> <span class="token class-name">ImportCsv</span><span
                class="token punctuation">(</span><span class="token number">401</span><span
                class="token punctuation">,</span> <span class="token number">500</span><span class="token punctuation">)</span><span
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
                class="token property">id</span><span class="token punctuation">;</span></code></pre>
<p>Идентификатор пакета, к которому можно получить доступ через <code>$batch-&gt;id</code> свойство, можно использовать
    для <a href="queues#inspecting-batches">запроса на шину команд Laravel</a> информации о пакете после того, как он
    был отправлен.</p>
<p></p>
<h4 id="naming-batches"><a href="#naming-batches">Именование партий</a></h4>
<p>Некоторые инструменты, такие как Laravel Horizon и Laravel Telescope, могут предоставлять более удобную для
    пользователя отладочную информацию для пакетов, если пакеты названы. Чтобы присвоить пакету произвольное имя, вы
    можете вызвать <code>name</code> метод при определении пакета:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$batch</span> <span
                class="token operator">=</span> Bus<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">batch</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token comment">//...</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">then</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span>Batch <span class="token variable">$batch</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// All jobs completed successfully...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">name</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Import CSV'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">dispatch</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="batch-connection-queue"><a href="#batch-connection-queue">Пакетное подключение и очередь</a></h4>
<p>Если вы хотите, чтобы указать соединение и очереди, которые должны быть использованы для пакетных заданий, вы можете
    использовать <code>onConnection</code> и <code>onQueue</code> методы. Все пакетные задания должны выполняться в
    одном соединении и в одной очереди:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$batch</span> <span
                class="token operator">=</span> Bus<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">batch</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token comment">//...</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">then</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span>Batch <span class="token variable">$batch</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// All jobs completed successfully...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">onConnection</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'redis'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">onQueue</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'imports'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">dispatch</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="chains-within-batches"><a href="#chains-within-batches">Цепочки внутри партий</a></h4>
<p>Вы можете определить набор <a href="queues#job-chaining">связанных заданий</a> в пакете, поместив связанные задания в
    массив. Например, мы можем выполнить две цепочки заданий параллельно и выполнить обратный вызов, когда обе цепочки
    заданий завершили обработку:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Jobs<span
                    class="token punctuation">\</span>ReleasePodcast</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Jobs<span
                    class="token punctuation">\</span>SendPodcastReleaseNotification</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Bus<span
                    class="token punctuation">\</span>Batch</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Bus</span><span
                class="token punctuation">;</span>

Bus<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">batch</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span>
    <span class="token punctuation">[</span>
        <span class="token keyword">new</span> <span class="token class-name">ReleasePodcast</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
        <span class="token keyword">new</span> <span class="token class-name">SendPodcastReleaseNotification</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span>
        <span class="token keyword">new</span> <span class="token class-name">ReleasePodcast</span><span
                class="token punctuation">(</span><span class="token number">2</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
        <span class="token keyword">new</span> <span class="token class-name">SendPodcastReleaseNotification</span><span
                class="token punctuation">(</span><span class="token number">2</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">then</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span>Batch <span class="token variable">$batch</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">dispatch</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="adding-jobs-to-batches"><a href="#adding-jobs-to-batches">Добавление заданий в пакеты</a></h3>
<p>Иногда может быть полезно добавить дополнительные задания в пакет из пакетного задания. Этот шаблон может быть
    полезен, когда вам нужно выполнить пакетную обработку тысяч заданий, выполнение которых может занять слишком много
    времени во время веб-запроса. Таким образом, вместо этого вы можете отправить начальный пакет заданий «загрузчик»,
    которые насыщают пакет еще большим количеством заданий:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$batch</span> <span
                class="token operator">=</span> Bus<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">batch</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token keyword">new</span> <span class="token class-name">LoadImportBatch</span><span
                class="token punctuation">,</span>
    <span class="token keyword">new</span> <span class="token class-name">LoadImportBatch</span><span
                class="token punctuation">,</span>
    <span class="token keyword">new</span> <span class="token class-name">LoadImportBatch</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">then</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span>Batch <span class="token variable">$batch</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// All jobs completed successfully...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">name</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Import Contacts'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">dispatch</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>В этом примере мы будем использовать <code>LoadImportBatch</code> задание для гидратации партии дополнительными
    заданиями. Для этого мы можем использовать <code>add</code> метод в экземпляре пакета, к которому можно получить
    доступ через метод задания <code>batch</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Jobs<span
                    class="token punctuation">\</span>ImportContacts</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Collection</span><span class="token punctuation">;</span>

<span class="token comment">/**
 * Execute the job.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">handle</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">if</span> <span class="token punctuation">(</span><span
                class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">batch</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">cancelled</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>

    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">batch</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">add</span><span class="token punctuation">(</span>Collection<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">times</span><span
                class="token punctuation">(</span><span class="token number">1000</span><span class="token punctuation">,</span> <span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token keyword">new</span> <span class="token class-name">ImportContacts</span><span
                class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p> Вы можете добавлять задания в пакет только из задания, которое принадлежит к тому же пакету.</p></p></div>
</blockquote>
<p></p>
<h3 id="inspecting-batches"><a href="#inspecting-batches">Проверка партий</a></h3>
<p><code>Illuminate\Bus\Batch</code> Экземпляр, который предусмотрен для завершения партии обратных вызовов имеет
    множество свойств и методы, чтобы помочь вам в общении с и инспектированием данной партии рабочих мест:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">// The UUID of the batch...</span>
<span class="token variable">$batch</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">id</span><span class="token punctuation">;</span>

<span class="token comment">// The name of the batch (if applicable)...</span>
<span class="token variable">$batch</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">name</span><span
                class="token punctuation">;</span>

<span class="token comment">// The number of jobs assigned to the batch...</span>
<span class="token variable">$batch</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">totalJobs</span><span
                class="token punctuation">;</span>

<span class="token comment">// The number of jobs that have not been processed by the queue...</span>
<span class="token variable">$batch</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">pendingJobs</span><span
                class="token punctuation">;</span>

<span class="token comment">// The number of jobs that have failed...</span>
<span class="token variable">$batch</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">failedJobs</span><span
                class="token punctuation">;</span>

<span class="token comment">// The number of jobs that have been processed thus far...</span>
<span class="token variable">$batch</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">processedJobs</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// The completion percentage of the batch (0-100)...</span>
<span class="token variable">$batch</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">progress</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// Indicates if the batch has finished executing...</span>
<span class="token variable">$batch</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">finished</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// Cancel the execution of the batch...</span>
<span class="token variable">$batch</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">cancel</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// Indicates if the batch has been cancelled...</span>
<span class="token variable">$batch</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">cancelled</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="returning-batches-from-routes"><a href="#returning-batches-from-routes">Возврат партий с маршрутов</a></h4>
<p>Все <code>Illuminate\Bus\Batch</code> экземпляры являются сериализуемыми в формате JSON, что означает, что вы можете
    возвращать их непосредственно из одного из маршрутов приложения, чтобы получить полезную нагрузку JSON, содержащую
    информацию о пакете, включая ход его завершения. Это позволяет удобно отображать информацию о ходе выполнения пакета
    в пользовательском интерфейсе вашего приложения.</p>
<p>Чтобы получить пакет по его идентификатору, вы можете использовать метод <code>Bus</code> фасада
    <code>findBatch</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Bus</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Route</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/batch/{literal}{batchId}{/literal}'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span>string <span class="token variable">$batchId</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> Bus<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">findBatch</span><span
                class="token punctuation">(</span><span class="token variable">$batchId</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="cancelling-batches"><a href="#cancelling-batches">Отмена пакетов</a></h3>
<p>Иногда вам может потребоваться отменить выполнение определенного пакета. Это можно сделать, вызвав
    <code>cancel</code> метод <code>Illuminate\Bus\Batch</code> экземпляра:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Execute the job.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">handle</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">if</span> <span class="token punctuation">(</span><span
                class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">user</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">exceedsImportLimit</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">batch</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">cancel</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token punctuation">}</span>

    <span class="token keyword">if</span> <span class="token punctuation">(</span><span
                class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">batch</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">cancelled</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></code></pre>
<p>Как вы могли заметить в предыдущих примерах, пакетные задания обычно должны проверять, был ли пакет отменен в начале
    их <code>handle</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Execute the job.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">handle</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">if</span> <span class="token punctuation">(</span><span
                class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">batch</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">cancelled</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>

    <span class="token comment">// Continue processing...</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="batch-failures"><a href="#batch-failures">Пакетные сбои</a></h3>
<p>При сбое пакетного задания будет активирован <code>catch</code> обратный вызов (если назначен). Этот обратный вызов
    вызывается только для первого сбойного задания в пакете.</p>
<p></p>
<h4 id="allowing-failures"><a href="#allowing-failures">Допускать неудачи</a></h4>
<p>Когда задание в пакете терпит неудачу, Laravel автоматически помечает пакет как «отмененный». При желании вы можете
    отключить это поведение, чтобы при сбое задания пакет не отмечался автоматически как отмененный. Это может быть
    выполнено путем вызова <code>allowFailures</code> метода при отправке пакета:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$batch</span> <span
                class="token operator">=</span> Bus<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">batch</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token comment">//...</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">then</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span>Batch <span class="token variable">$batch</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// All jobs completed successfully...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">allowFailures</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">dispatch</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="retrying-failed-batch-jobs"><a href="#retrying-failed-batch-jobs">Повторная попытка выполнения неудачных
        пакетных заданий</a></h4>
<p>Для удобства Laravel предоставляет <code>queue:retry-batch</code> Artisan-команду, которая позволяет легко повторить
    все неудачные задания для данного пакета. Команда <code>queue:retry-batch</code> принимает UUID пакета, чьи
    неудачные задания следует повторить:</p>
<pre class=" language-bash"><code class=" language-bash">php artisan queue:retry-batch 32dbc76c-4f82-4749-b610-a639fe0099b5</code></pre>
<p></p>
<h3 id="pruning-batches"><a href="#pruning-batches">Партии обрезки</a></h3>
<p>Без обрезки <code>job_batches</code> таблица может очень быстро накапливать записи. Чтобы смягчить это, вы должны <a
            href="scheduling">запланировать выполнение</a> команды <code>queue:prune-batches</code> Artisan ежедневно:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$schedule</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">command</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'queue:prune-batches'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">daily</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>По умолчанию все готовые пакеты, возраст которых превышает 24 часа, будут удалены. Вы можете использовать эту <code>hours</code>
    опцию при вызове команды, чтобы определить, как долго хранить пакетные данные. Например, следующая команда удалит
    все пакеты, завершенные более 48 часов назад:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$schedule</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">command</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'queue:prune-batches --hours=48'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">daily</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="queueing-closures"><a href="#queueing-closures">Закрытие очередей</a></h2>
<p>Вместо отправки класса задания в очередь вы также можете отправить закрытие. Это отлично подходит для быстрых и
    простых задач, которые необходимо выполнять вне текущего цикла запроса. При отправке закрытий в очередь содержимое
    кода закрытия криптографически подписывается, поэтому его нельзя изменить при передаче:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$podcast</span> <span
                class="token operator">=</span> App\<span class="token package">Podcast</span><span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">find</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token function">dispatch</span><span class="token punctuation">(</span><span
                class="token keyword">function</span> <span class="token punctuation">(</span><span
                class="token punctuation">)</span> <span class="token keyword">use</span> <span
                class="token punctuation">(</span><span class="token variable">$podcast</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$podcast</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">publish</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Используя этот <code>catch</code> метод, вы можете обеспечить закрытие, которое должно быть выполнено, если закрытие
    в очереди не удалось успешно завершить после исчерпания всех <a href="queues#max-job-attempts-and-timeout">настроенных
        попыток повтора</a> вашей очереди:</p>
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
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="running-the-queue-worker"><a href="#running-the-queue-worker">Запуск обработчика очереди</a></h2>
<p></p>
<h3 id="the-queue-work-command"><a href="#the-queue-work-command"><code>queue:work</code> Command</a></h3>
<p>Laravel включает команду Artisan, которая запускает обработчика очереди и обрабатывает новые задания по мере их
    помещения в очередь. Вы можете запустить воркер с помощью <code>queue:work</code> Artisan-команды. Обратите
    внимание, что после <code>queue:work</code> запуска команды она будет продолжать работать до тех пор, пока не будет
    остановлена ​​вручную или пока вы не закроете терминал:</p>
<pre class=" language-php"><code class=" language-php">php artisan queue<span
                class="token punctuation">:</span>work</code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Чтобы <code>queue:work</code> процесс постоянно работал в фоновом режиме, следует использовать монитор
            процесса, например <a href="queues#supervisor-configuration">Supervisor,</a> чтобы гарантировать, что
            работник очереди не прекращает работу.</p></p></div>
</blockquote>
<p>Помните, что обработчики очередей - это долгоживущие процессы, которые хранят состояние загруженного приложения в
    памяти. В результате они не заметят изменений в вашей кодовой базе после их запуска. Итак, во время процесса
    развертывания не забудьте <a href="queues#queue-workers-and-deployment">перезапустить своих работников очереди</a>.
    Кроме того, помните, что любое статическое состояние, созданное или измененное вашим приложением, не будет
    автоматически сбрасываться между заданиями.</p>
<p>В качестве альтернативы вы можете запустить <code>queue:listen</code> команду. При использовании
    <code>queue:listen</code> команды вам не нужно вручную перезапускать воркера, если вы хотите перезагрузить
    обновленный код или сбросить состояние приложения; однако эта команда значительно менее эффективна, чем <code>queue:work</code>
    команда:</p>
<pre class=" language-php"><code class=" language-php">php artisan queue<span
                class="token punctuation">:</span>listen</code></pre>
<p></p>
<h4 id="running-multiple-queue-workers"><a href="#running-multiple-queue-workers">Запуск нескольких работников
        очереди</a></h4>
<p>Чтобы назначить несколько воркеров в очередь и одновременно обрабатывать задания, вам нужно просто запустить
    несколько <code>queue:work</code> процессов. Это можно сделать либо локально с помощью нескольких вкладок в вашем
    терминале, либо в процессе производства, используя параметры конфигурации вашего диспетчера процессов. <a
            href="queues#supervisor-configuration">При использовании Supervisor</a> вы можете использовать <code>numprocs</code>
    значение конфигурации.</p>
<p></p>
<h4 id="specifying-the-connection-queue"><a href="#specifying-the-connection-queue">Указание подключения и очереди</a>
</h4>
<p>Вы также можете указать, какое подключение к очереди должен использовать рабочий. Имя соединения, переданное <code>work</code>
    команде, должно соответствовать одному из соединений, определенных в вашем <code>config/queue.php</code> файле
    конфигурации:</p>
<pre class=" language-php"><code class=" language-php">php artisan queue<span class="token punctuation">:</span>work redis</code></pre>
<p>Вы можете дополнительно настроить своего обработчика очереди, обрабатывая только определенные очереди для данного
    соединения. Например, если все ваши электронные письма обрабатываются в <code>emails</code> очереди на вашем <code>redis</code>
    подключении к очереди, вы можете выполнить следующую команду, чтобы запустить воркер, который обрабатывает только
    эту очередь:</p>
<pre class=" language-php"><code class=" language-php">php artisan queue<span class="token punctuation">:</span>work redis <span
                class="token operator">--</span>queue<span class="token operator">=</span>emails</code></pre>
<p></p>
<h4 id="processing-a-specified-number-of-jobs"><a href="#processing-a-specified-number-of-jobs">Обработка указанного
        количества заданий</a></h4>
<p><code>--once</code> Вариант может быть использован, чтобы поручить работнику обрабатывать только одно задание из
    очереди:</p>
<pre class=" language-php"><code class=" language-php">php artisan queue<span
                class="token punctuation">:</span>work <span class="token operator">--</span>once</code></pre>
<p>Эта <code>--max-jobs</code> опция может использоваться, чтобы проинструктировать работника обработать заданное
    количество заданий и затем выйти. Эта опция может быть полезна в сочетании с <a
            href="queues#supervisor-configuration">Supervisor,</a> чтобы ваши рабочие процессы автоматически
    перезапускались после обработки заданного количества заданий, освобождая всю память, которую они могли накопить:</p>
<pre class=" language-php"><code class=" language-php">php artisan queue<span
                class="token punctuation">:</span>work <span class="token operator">--</span>max<span
                class="token operator">-</span>jobs<span class="token operator">=</span><span
                class="token number">1000</span></code></pre>
<p></p>
<h4 id="processing-all-queued-jobs-then-exiting"><a href="#processing-all-queued-jobs-then-exiting">Обработка всех
        заданий в очереди и выход</a></h4>
<p>Эта <code>--stop-when-empty</code> опция может использоваться, чтобы дать рабочему указание обработать все задания и
    затем корректно завершить работу. Эта опция может быть полезна при обработке очередей Laravel в контейнере Docker,
    если вы хотите выключить контейнер после того, как очередь пуста:</p>
<pre class=" language-php"><code class=" language-php">php artisan queue<span
                class="token punctuation">:</span>work <span class="token operator">--</span>stop<span
                class="token operator">-</span>when<span class="token operator">-</span><span class="token keyword">empty</span></code></pre>
<p></p>
<h4 id="processing-jobs-for-a-given-number-of-seconds"><a href="#processing-jobs-for-a-given-number-of-seconds">Обработка
        заданий за заданное количество секунд</a></h4>
<p>Эта <code>--max-time</code> опция может использоваться, чтобы проинструктировать работника обрабатывать задания в
    течение заданного количества секунд, а затем выйти. Эта опция может быть полезна в сочетании с <a
            href="queues#supervisor-configuration">Supervisor,</a> чтобы ваши рабочие процессы автоматически
    перезапускались после обработки заданий в течение заданного промежутка времени, освобождая всю память, которую они
    могли накопить:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">// Process jobs for one hour and then exit...</span>
php artisan queue<span class="token punctuation">:</span>work <span class="token operator">--</span>max<span
                class="token operator">-</span>time<span class="token operator">=</span><span
                class="token number">3600</span></code></pre>
<p></p>
<h4 id="worker-sleep-duration"><a href="#worker-sleep-duration">Продолжительность сна рабочего</a></h4>
<p>Когда задания доступны в очереди, работник будет продолжать обрабатывать задания без задержки между ними. Однако этот
    <code>sleep</code> параметр определяет, сколько секунд рабочий будет «спать», если новых рабочих мест нет. Во время
    сна рабочий не будет обрабатывать никаких новых заданий - задания будут обработаны после того, как воркер снова
    проснется.</p>
<pre class=" language-php"><code class=" language-php">php artisan queue<span
                class="token punctuation">:</span>work <span class="token operator">--</span>sleep<span
                class="token operator">=</span><span class="token number">3</span></code></pre>
<p></p>
<h4 id="resource-considerations"><a href="#resource-considerations">Соображения относительно ресурсов</a></h4>
<p>Рабочие очереди демонов не «перезагружают» структуру перед обработкой каждого задания. Следовательно, вы должны
    освобождать все тяжелые ресурсы после завершения каждого задания. Например, если вы выполняете манипуляции с
    изображениями с помощью библиотеки GD, вам следует освободить память с помощью, <code>imagedestroy</code> когда вы
    закончите обработку изображения.</p>
<p></p>
<h3 id="queue-priorities"><a href="#queue-priorities">Приоритеты очереди</a></h3>
<p>Иногда вы можете установить приоритетность обработки очередей. Например, в <code>config/queue.php</code> файле
    конфигурации вы можете установить значение <code>queue</code> по умолчанию для вашего <code>redis</code> подключения
    <code>low</code>. Однако иногда вы можете захотеть поместить задание в <code>high</code> приоритетную очередь,
    например:</p>
<pre class=" language-php"><code class=" language-php"><span class="token function">dispatch</span><span
                class="token punctuation">(</span><span class="token punctuation">(</span><span class="token keyword">new</span> <span
                class="token class-name">Job</span><span class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">onQueue</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'high'</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Чтобы запустить рабочий процесс, который проверяет, что все <code>high</code> задания очереди обработаны, прежде чем
    <code>low</code> переходить к каким-либо заданиям в очереди, передайте разделенный запятыми список имен очередей в
    <code>work</code> команду:</p>
<pre class=" language-php"><code class=" language-php">php artisan queue<span
                class="token punctuation">:</span>work <span class="token operator">--</span>queue<span
                class="token operator">=</span>high<span class="token punctuation">,</span>low</code></pre>
<p></p>
<h3 id="queue-workers-and-deployment"><a href="#queue-workers-and-deployment">Работники очереди и развертывание</a></h3>
<p>Поскольку работники очереди - это долгоживущие процессы, они не заметят изменений в вашем коде без перезапуска. Итак,
    самый простой способ развернуть приложение с использованием обработчиков очереди - это перезапустить работников во
    время процесса развертывания. Вы можете корректно перезапустить все рабочие процессы, выполнив
    <code>queue:restart</code> команду:</p>
<pre class=" language-php"><code class=" language-php">php artisan queue<span class="token punctuation">:</span>restart</code></pre>
<p>Эта команда проинструктирует всех работников очереди корректно выйти после завершения обработки своего текущего
    задания, чтобы существующие задания не были потеряны. Поскольку обработчики очереди завершают работу при выполнении
    <code>queue:restart</code> команды, вы должны запустить диспетчер процессов, например <a
            href="queues#supervisor-configuration">Supervisor,</a> для автоматического перезапуска работников очереди.
</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Очередь использует <a href="cache">кеш</a> для хранения сигналов перезапуска, поэтому перед использованием
            этой функции необходимо убедиться, что драйвер кеша правильно настроен для вашего приложения.</p></p></div>
</blockquote>
<p></p>
<h3 id="job-expirations-and-timeouts"><a href="#job-expirations-and-timeouts">Истечение срока работы и тайм-ауты</a>
</h3>
<p></p>
<h4 id="job-expiration"><a href="#job-expiration">Срок действия вакансии</a></h4>
<p>В вашем <code>config/queue.php</code> файле конфигурации каждое соединение с очередью определяет
    <code>retry_after</code> параметр. Этот параметр указывает, сколько секунд соединение очереди должно ждать перед
    повторной попыткой выполнения задания, которое обрабатывается. Например, если значение <code>retry_after</code>
    установлено на <code>90</code> задание будет выпущен обратно в очередь, если он перерабатывает в течение 90 секунд
    без освобождения или удалены. Как правило, вы должны установить <code>retry_after</code> максимальное количество
    секунд, которое может потребоваться вашим заданиям для завершения обработки.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Единственное подключение к очереди, которое не содержит <code>retry_after</code> значения, - это Amazon SQS.
            SQS будет повторять выполнение задания в соответствии с <a
                    href="https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/AboutVT.html">таймаутом
                видимости</a> по <a
                    href="https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/AboutVT.html">умолчанию,</a>
            который управляется в консоли AWS.</p></p></div>
</blockquote>
<p></p>
<h4 id="worker-timeouts"><a href="#worker-timeouts">Тайм-ауты рабочего</a></h4>
<p>Команда <code>queue:work</code> Artisan предоставляет <code>--timeout</code> параметр. Если задание обрабатывается
    дольше, чем количество секунд, указанное значением тайм-аута, рабочий, выполняющий задание, завершится с ошибкой.
    Обычно рабочий <a href="queues#supervisor-configuration">процесс</a> перезапускается автоматически <a
            href="queues#supervisor-configuration">менеджером процессов, настроенным на вашем сервере</a>:</p>
<pre class=" language-bash"><code class=" language-bash">php artisan queue:work --timeout<span
                class="token operator">=</span><span class="token number">60</span></code></pre>
<p>Параметр <code>retry_after</code> конфигурации и параметр <code>--timeout</code> CLI различны, но работают вместе,
    чтобы гарантировать, что задания не будут потеряны и что задания будут успешно обработаны только один раз.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p><code>--timeout</code> Значение всегда должно быть по крайней мере, несколько секунд короче, чем <code>retry_after</code>
            значение конфигурации. Это гарантирует, что работник, обрабатывающий замороженное задание, всегда завершает
            работу перед повторной попыткой выполнения задания. Если ваш <code>--timeout</code> параметр длиннее, чем
            <code>retry_after</code> значение вашей конфигурации, ваши задания могут быть обработаны дважды.</p></p>
    </div>
</blockquote>
<p></p>
<h2 id="supervisor-configuration"><a href="#supervisor-configuration">Конфигурация супервизора</a></h2>
<p>В производственной среде вам нужен способ поддерживать работу ваших <code>queue:work</code> процессов. <code>queue:work</code>
    Процесс может быть прекращен по ряду причин, таких как тайм - аут превышен рабочий или выполнения <code>queue:restart</code>
    команды.</p>
<p>По этой причине вам необходимо настроить монитор процессов, который может определять, когда ваши
    <code>queue:work</code> процессы завершаются, и автоматически перезапускать их. Кроме того, мониторы процессов
    позволяют вам указать, сколько <code>queue:work</code> процессов вы хотите запускать одновременно. Supervisor - это
    монитор процессов, обычно используемый в средах Linux, и мы обсудим, как его настроить в следующей документации.</p>
<p></p>
<h4 id="installing-supervisor"><a href="#installing-supervisor">Установка Supervisor</a></h4>
<p>Supervisor - это монитор процессов для операционной системы Linux, который автоматически перезапускает ваши <code>queue:work</code>
    процессы в случае их сбоя. Чтобы установить Supervisor в Ubuntu, вы можете использовать следующую команду:</p>
<pre class=" language-php"><code class=" language-php">sudo apt<span class="token operator">-</span>get install supervisor</code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Если настройка Supervisor и управление им самостоятельно звучит ошеломляюще, подумайте об использовании <a
                    href="https://forge.laravel.com">Laravel Forge</a>, который автоматически установит и настроит
            Supervisor для ваших производственных проектов Laravel.</p></p></div>
</blockquote>
<p></p>
<h4 id="configuring-supervisor"><a href="#configuring-supervisor">Настройка Supervisor</a></h4>
<p>Файлы конфигурации супервизора обычно хранятся в <code>/etc/supervisor/conf.d</code> каталоге. В этом каталоге вы
    можете создать любое количество файлов конфигурации, которые сообщают супервизору, как следует контролировать ваши
    процессы. Например, создадим <code>laravel-worker.conf</code> файл, который запускает и контролирует <code>queue:work</code>
    процессы:</p>
<pre class=" language-ini"><code class=" language-ini"><span class="token selector">[program:laravel-worker]</span>
<span class="token constant">process_name</span><span class="token attr-value"><span class="token punctuation">=</span>%(program_name)s_%(process_num)02d</span>
<span class="token constant">command</span><span class="token attr-value"><span class="token punctuation">=</span>php /home/forge/app.com/artisan queue:work sqs --sleep=3 --tries=3 --max-time=3600</span>
<span class="token constant">autostart</span><span class="token attr-value"><span class="token punctuation">=</span>true</span>
<span class="token constant">autorestart</span><span class="token attr-value"><span class="token punctuation">=</span>true</span>
<span class="token constant">stopasgroup</span><span class="token attr-value"><span class="token punctuation">=</span>true</span>
<span class="token constant">killasgroup</span><span class="token attr-value"><span class="token punctuation">=</span>true</span>
<span class="token constant">user</span><span class="token attr-value"><span
                    class="token punctuation">=</span>forge</span>
<span class="token constant">numprocs</span><span class="token attr-value"><span
                    class="token punctuation">=</span>8</span>
<span class="token constant">redirect_stderr</span><span class="token attr-value"><span
                    class="token punctuation">=</span>true</span>
<span class="token constant">stdout_logfile</span><span class="token attr-value"><span
                    class="token punctuation">=</span>/home/forge/app.com/worker.log</span>
<span class="token constant">stopwaitsecs</span><span class="token attr-value"><span class="token punctuation">=</span>3600</span></code></pre>
<p>В этом примере <code>numprocs</code> директива инструктирует Supervisor запускать восемь <code>queue:work</code>
    процессов и отслеживать их все, автоматически перезапуская их в случае сбоя. Вам следует изменить
    <code>command</code> директиву конфигурации, чтобы отразить желаемое соединение с очередью и параметры рабочего
    стола.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Вы должны убедиться, что значение <code>stopwaitsecs</code> больше, чем количество секунд, потребляемых вашим
            самым продолжительным заданием. В противном случае Supervisor может убить задание до того, как оно завершит
            обработку.</p></p></div>
</blockquote>
<p></p>
<h4 id="starting-supervisor"><a href="#starting-supervisor">Стартовый супервайзер</a></h4>
<p>После создания файла конфигурации вы можете обновить конфигурацию Supervisor и запустить процессы, используя
    следующие команды:</p>
<pre class=" language-bash"><code class=" language-bash"><span class="token function">sudo</span> supervisorctl reread

<span class="token function">sudo</span> supervisorctl update

<span class="token function">sudo</span> supervisorctl start laravel-worker:*</code></pre>
<p>Для получения дополнительной информации о Supervisor обратитесь к <a href="http://supervisord.org/index.html">документации
        Supervisor</a>.</p>
<p></p>
<h2 id="dealing-with-failed-jobs"><a href="#dealing-with-failed-jobs">Работа с неудавшейся работой</a></h2>
<p>Иногда ваши задания в очереди терпят неудачу. Не волнуйтесь, не всегда все идет по плану! Laravel включает удобный
    способ <a href="queues#max-job-attempts-and-timeout">указать максимальное количество попыток выполнения задания</a>.
    После того, как задание превысит это количество попыток, оно будет вставлено в <code>failed_jobs</code> таблицу базы
    данных. Конечно, нам нужно будет создать эту таблицу, если она еще не существует. Чтобы создать миграцию для <code>failed_jobs</code>
    таблицы, вы можете использовать <code>queue:failed-table</code> команду:</p>
<pre class=" language-php"><code class=" language-php">php artisan queue<span
                class="token punctuation">:</span>failed<span class="token operator">-</span>table

php artisan migrate</code></pre>
<p>При запуске <a href="queues#running-the-queue-worker">рабочего</a> процесса <a
            href="queues#running-the-queue-worker">очереди</a> вы можете указать максимальное количество попыток
    выполнения задания, используя <code>--tries</code> переключатель в <code>queue:work</code> команде. Если вы не
    укажете значение для <code>--tries</code> параметра, задания будут выполняться только один или столько раз, сколько
    указано в <code>$tries</code> свойстве класса задания:</p>
<pre class=" language-php"><code class=" language-php">php artisan queue<span class="token punctuation">:</span>work redis <span
                class="token operator">--</span>tries<span class="token operator">=</span><span
                class="token number">3</span></code></pre>
<p>Используя эту <code>--backoff</code> опцию, вы можете указать, сколько секунд Laravel должен ждать перед повторной
    попыткой выполнения задания, которое обнаружило исключение. По умолчанию задание немедленно возвращается в очередь,
    чтобы его можно было повторить:</p>
<pre class=" language-php"><code class=" language-php">php artisan queue<span class="token punctuation">:</span>work redis <span
                class="token operator">--</span>tries<span class="token operator">=</span><span
                class="token number">3</span> <span class="token operator">--</span>backoff<span class="token operator">=</span><span
                class="token number">3</span></code></pre>
<p>Если вы хотите настроить, сколько секунд Laravel должен ждать перед повторной попыткой задания, которое обнаружило
    исключение для каждого задания, вы можете сделать это, определив <code>backoff</code> свойство в своем классе
    задания:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * The number of seconds to wait before retrying the job.
 *
 * @var int
 */</span>
<span class="token keyword">public</span> <span class="token variable">$backoff</span> <span
                class="token operator">=</span> <span class="token number">3</span><span
                class="token punctuation">;</span></code></pre>
<p>Если вам требуется более сложная логика для определения времени отсрочки задания, вы можете определить
    <code>backoff</code> метод в своем классе задания:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
* Calculate the number of seconds to wait before retrying the job.
*
* @return int
*/</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">backoff</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token number">3</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Вы можете легко настроить «экспоненциальную» отсрочку, вернув из <code>backoff</code> метода массив значений
    отсрочки. В этом примере задержка повтора будет составлять 1 секунду для первой попытки, 5 секунд для второй попытки
    и 10 секунд для третьей попытки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
* Calculate the number of seconds to wait before retrying the job.
*
* @return array
*/</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">backoff</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token punctuation">[</span><span
                class="token number">1</span><span class="token punctuation">,</span> <span
                class="token number">5</span><span class="token punctuation">,</span> <span
                class="token number">10</span><span class="token punctuation">]</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="cleaning-up-after-failed-jobs"><a href="#cleaning-up-after-failed-jobs">Очистка после неудачных заданий</a></h3>
<p>В случае сбоя определенного задания вы можете отправить предупреждение своим пользователям или отменить любые
    действия, которые были частично выполнены заданием. Для этого вы можете определить <code>failed</code> метод в своем
    классе работы. <code>Throwable</code> Экземпляр, который вызвал работу на провал будет передана <code>failed</code>
    метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Jobs</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span
                        class="token punctuation">\</span>Podcast</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Services<span class="token punctuation">\</span>AudioProcessor</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Bus<span
                        class="token punctuation">\</span>Queueable</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                        class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>ShouldQueue</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>InteractsWithQueue</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>SerializesModels</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Throwable</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">ProcessPodcast</span> <span
                    class="token keyword">implements</span> <span class="token class-name">ShouldQueue</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">use</span> <span class="token package">InteractsWithQueue</span><span
                    class="token punctuation">,</span> Queueable<span class="token punctuation">,</span> SerializesModels<span
                    class="token punctuation">;</span>

    <span class="token comment">/**
     * The podcast instance.
     *
     * @var \App\Podcast
     */</span>
    <span class="token keyword">protected</span> <span class="token variable">$podcast</span><span
                    class="token punctuation">;</span>

    <span class="token comment">/**
     * Create a new job instance.
     *
     * @param  \App\Models\Podcast  $podcast
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">__construct</span><span
                    class="token punctuation">(</span>Podcast <span class="token variable">$podcast</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token property">podcast</span> <span
                    class="token operator">=</span> <span class="token variable">$podcast</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
     * Execute the job.
     *
     * @param  \App\Services\AudioProcessor  $processor
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">handle</span><span
                    class="token punctuation">(</span>AudioProcessor <span class="token variable">$processor</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">// Process uploaded podcast...</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
     * Handle a job failure.
     *
     * @param  \Throwable  $exception
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">failed</span><span
                    class="token punctuation">(</span>Throwable <span class="token variable">$exception</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">// Send user notification of failure, etc...</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h3 id="retrying-failed-jobs"><a href="#retrying-failed-jobs">Повторная попытка выполнения невыполненных заданий</a>
</h3>
<p>Чтобы просмотреть все неудачные задания, которые были вставлены в вашу <code>failed_jobs</code> таблицу базы данных,
    вы можете использовать <code>queue:failed</code> Artisan-команду:</p>
<pre class=" language-php"><code class=" language-php">php artisan queue<span
                class="token punctuation">:</span>failed</code></pre>
<p>Команда <code>queue:failed</code> отобразит идентификатор задания, соединение, очередь, время сбоя и другую
    информацию о задании. Идентификатор задания может использоваться для повторной попытки выполнить задание,
    завершившееся ошибкой. Например, чтобы повторить неудачное задание с идентификатором <code>5</code>, введите
    следующую команду:</p>
<pre class=" language-php"><code class=" language-php">php artisan queue<span
                class="token punctuation">:</span>retry <span class="token number">5</span></code></pre>
<p>При необходимости вы можете передать команде несколько идентификаторов или диапазон идентификаторов (при
    использовании числовых идентификаторов):</p>
<pre class=" language-php"><code class=" language-php">php artisan queue<span
                class="token punctuation">:</span>retry <span class="token number">5</span> <span
                class="token number">6</span> <span class="token number">7</span> <span
                class="token number">8</span> <span class="token number">9</span> <span class="token number">10</span>

php artisan queue<span class="token punctuation">:</span>retry <span class="token operator">--</span>range<span
                class="token operator">=</span><span class="token number">5</span><span
                class="token operator">-</span><span class="token number">10</span></code></pre>
<p>Чтобы повторить все неудачные задания, выполните <code>queue:retry</code> команду и передайте <code>all</code> в
    качестве идентификатора:</p>
<pre class=" language-php"><code class=" language-php">php artisan queue<span class="token punctuation">:</span>retry all</code></pre>
<p>Если вы хотите удалить неудавшееся задание, вы можете использовать <code>queue:forget</code> команду:</p>
<pre class=" language-php"><code class=" language-php">php artisan queue<span
                class="token punctuation">:</span>forget <span class="token number">5</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>При использовании <a href="horizon">Horizon</a> вы должны использовать <code>horizon:forget</code> команду
            для удаления неудачного задания вместо <code>queue:forget</code> команды.</p></p></div>
</blockquote>
<p>Чтобы удалить все неудачные задания из <code>failed_jobs</code> таблицы, вы можете использовать
    <code>queue:flush</code> команду:</p>
<pre class=" language-php"><code class=" language-php">php artisan queue<span
                class="token punctuation">:</span>flush</code></pre>
<p></p>
<h3 id="ignoring-missing-models"><a href="#ignoring-missing-models">Игнорирование отсутствующих моделей</a></h3>
<p>При внедрении модели Eloquent в задание, модель автоматически сериализуется перед помещением в очередь и повторно
    извлекается из базы данных при обработке задания. Однако, если модель была удалена во время ожидания обработки
    работником, ваша работа может завершиться ошибкой с расширением <code>ModelNotFoundException</code>.</p>
<p>Для удобства вы можете выбрать автоматическое удаление заданий с отсутствующими моделями, установив для <code>deleteWhenMissingModels</code>
    свойства задания значение <code>true</code>. Если для этого свойства установлено значение <code>true</code>, Laravel
    незаметно отбрасывает задание без создания исключения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Delete the job if its models no longer exist.
 *
 * @var bool
 */</span>
<span class="token keyword">public</span> <span class="token variable">$deleteWhenMissingModels</span> <span
                class="token operator">=</span> <span class="token boolean constant">true</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="failed-job-events"><a href="#failed-job-events">События неудачных заданий</a></h3>
<p>Если вы хотите зарегистрировать прослушиватель событий, который будет вызываться при сбое задания, вы можете
    использовать метод <code>Queue</code> фасада <code>failing</code>. Например, мы можем прикрепить закрытие к этому
    событию из <code>boot</code> метода <code>AppServiceProvider</code>, включенного в Laravel:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Providers</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Queue</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>ServiceProvider</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>Events<span class="token punctuation">\</span>JobFailed</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">AppServiceProvider</span> <span
                    class="token keyword">extends</span> <span class="token class-name">ServiceProvider</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Register any application services.
     *
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">register</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
     * Bootstrap any application services.
     *
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">boot</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        Queue<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">failing</span><span class="token punctuation">(</span><span
                    class="token keyword">function</span> <span class="token punctuation">(</span>JobFailed <span
                    class="token variable">$event</span><span class="token punctuation">)</span> <span
                    class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">// $event-&gt;connectionName</span>
            <span class="token comment">// $event-&gt;job</span>
            <span class="token comment">// $event-&gt;exception</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h2 id="clearing-jobs-from-queues"><a href="#clearing-jobs-from-queues">Удаление заданий из очередей</a></h2>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>При использовании <a href="horizon">Horizon</a> вы должны использовать <code>horizon:clear</code> команду для
            удаления заданий из очереди вместо <code>queue:clear</code> команды.</p></p></div>
</blockquote>
<p>Если вы хотите удалить все задания из очереди по умолчанию соединения по умолчанию, вы можете сделать это с помощью
    <code>queue:clear</code> Artisan-команды:</p>
<pre class=" language-php"><code class=" language-php">php artisan queue<span
                class="token punctuation">:</span>clear</code></pre>
<p>Вы также можете указать <code>connection</code> аргумент и <code>queue</code> вариант для удаления заданий из
    определенного соединения и очереди:</p>
<pre class=" language-php"><code class=" language-php">php artisan queue<span class="token punctuation">:</span>clear redis <span
                class="token operator">--</span>queue<span class="token operator">=</span>emails</code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Удаление заданий из очередей доступно только для драйверов очереди SQS, Redis и базы данных. Кроме того,
            процесс удаления сообщения SQS занимает до 60 секунд, поэтому задания, отправленные в очередь SQS в течение
            60 секунд после очистки очереди, также могут быть удалены.</p></p></div>
</blockquote>
<p></p>
<h2 id="job-events"><a href="#job-events">События вакансий</a></h2>
<p>Использование <code>before</code> и <code>after</code> метод на <code>Queue</code> <a href="facades">фасаде</a>, вы
    можете указать функции обратного вызова, которые должны выполняться до или после постановки задания в очереди
    обрабатывается. Эти обратные вызовы - прекрасная возможность для дополнительной регистрации или увеличения
    статистики для панели мониторинга. Как правило, эти методы следует вызывать из <code>boot</code> метода <a
            href="providers">поставщика услуг</a>. Например, мы можем использовать то, <code>AppServiceProvider</code>
    что включено в Laravel:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Providers</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Queue</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>ServiceProvider</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>Events<span
                        class="token punctuation">\</span>JobProcessed</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Queue<span
                        class="token punctuation">\</span>Events<span
                        class="token punctuation">\</span>JobProcessing</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">AppServiceProvider</span> <span
                    class="token keyword">extends</span> <span class="token class-name">ServiceProvider</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * Register any application services.
     *
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">register</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//</span>
    <span class="token punctuation">}</span>

    <span class="token comment">/**
     * Bootstrap any application services.
     *
     * @return void
     */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">boot</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        Queue<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">before</span><span class="token punctuation">(</span><span
                    class="token keyword">function</span> <span class="token punctuation">(</span>JobProcessing <span
                    class="token variable">$event</span><span class="token punctuation">)</span> <span
                    class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">// $event-&gt;connectionName</span>
            <span class="token comment">// $event-&gt;job</span>
            <span class="token comment">// $event-&gt;job-&gt;payload()</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

        Queue<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                    class="token function">after</span><span class="token punctuation">(</span><span
                    class="token keyword">function</span> <span class="token punctuation">(</span>JobProcessed <span
                    class="token variable">$event</span><span class="token punctuation">)</span> <span
                    class="token punctuation">{literal}{{/literal}</span>
            <span class="token comment">// $event-&gt;connectionName</span>
            <span class="token comment">// $event-&gt;job</span>
            <span class="token comment">// $event-&gt;job-&gt;payload()</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Используя <code>looping</code> метод на <code>Queue</code> <a href="facades">фасаде</a>, вы можете указать обратные
    вызовы, которые выполняются до того, как рабочий попытается получить задание из очереди. Например, вы можете
    зарегистрировать закрытие для отката любых транзакций, оставшихся открытыми из-за ранее неудачного задания:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>DB</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Queue</span><span
                class="token punctuation">;</span>

Queue<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">looping</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">while</span> <span class="token punctuation">(</span><span
                class="token constant">DB</span><span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">transactionLevel</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span> <span class="token operator">&gt;</span> <span
                class="token number">0</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
        <span class="token constant">DB</span><span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">rollBack</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre> 
