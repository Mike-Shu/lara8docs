<h1>Планирование задач <sup>Task scheduling</sup></h1>
<ul>
    <li><a href="scheduling#introduction">Вступление</a></li>
    <li><a href="scheduling#defining-schedules">Определение расписаний</a>
        <ul>
            <li><a href="scheduling#scheduling-artisan-commands">Планирование команд Artisan</a></li>
            <li><a href="scheduling#scheduling-queued-jobs">Планирование заданий в очереди</a></li>
            <li><a href="scheduling#scheduling-shell-commands">Планирование команд оболочки</a></li>
            <li><a href="scheduling#schedule-frequency-options">Параметры частоты расписания</a></li>
            <li><a href="scheduling#timezones">Часовые пояса</a></li>
            <li><a href="scheduling#preventing-task-overlaps">Предотвращение дублирования задач</a></li>
            <li><a href="scheduling#running-tasks-on-one-server">Выполнение задач на одном сервере</a></li>
            <li><a href="scheduling#background-tasks">Фоновые задачи</a></li>
            <li><a href="scheduling#maintenance-mode">Режим технического обслуживания</a></li>
        </ul>
    </li>
    <li><a href="scheduling#running-the-scheduler">Запуск планировщика</a>
        <ul>
            <li><a href="scheduling#running-the-scheduler-locally">Локальный запуск планировщика</a></li>
        </ul>
    </li>
    <li><a href="scheduling#task-output">Вывод задачи</a></li>
    <li><a href="scheduling#task-hooks">Перехватчики задач</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Раньше вы, возможно, писали запись конфигурации cron для каждой задачи, которую нужно было запланировать на своем
    сервере. Однако это может быстро стать проблемой, потому что ваше расписание задач больше не находится в системе
    управления версиями, и вы должны подключиться к серверу по SSH, чтобы просмотреть существующие записи cron или
    добавить дополнительные записи.</p>
<p>Планировщик команд Laravel предлагает новый подход к управлению запланированными задачами на вашем сервере.
    Планировщик позволяет вам плавно и выразительно определять расписание команд в самом приложении Laravel. При
    использовании планировщика на вашем сервере требуется только одна запись cron. Расписание вашей задачи определяется
    в методе <code>app/Console/Kernel.php</code> файла <code>schedule</code>. Чтобы помочь вам начать работу, в методе
    определен простой пример.</p>
<p></p>
<h2 id="defining-schedules"><a href="#defining-schedules">Определение расписаний</a></h2>
<p>Вы можете определить все ваши запланированные задачи в <code>schedule</code> методе вашего
    <code>App\Console\Kernel</code> класса приложения. Для начала рассмотрим пример. В этом примере мы запланируем
    закрытие, которое будет вызываться каждый день в полночь. В закрытии мы выполним запрос к базе данных, чтобы
    очистить таблицу:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Console</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Console<span
                        class="token punctuation">\</span>Scheduling<span
                        class="token punctuation">\</span>Schedule</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Foundation<span
                        class="token punctuation">\</span>Console<span
                        class="token punctuation">\</span>Kernel</span> <span class="token keyword">as</span> ConsoleKernel<span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span class="token punctuation">\</span>DB</span><span
                    class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">Kernel</span> <span class="token keyword">extends</span> <span
                    class="token class-name">ConsoleKernel</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
     * The Artisan commands provided by your application.
     *
     * @var array
     */</span>
    <span class="token keyword">protected</span> <span class="token variable">$commands</span> <span class="token operator">=</span> <span
                    class="token punctuation">[</span>
        <span class="token comment">//</span>
    <span class="token punctuation">]</span><span class="token punctuation">;</span>

    <span class="token comment">/**
     * Define the application's command schedule.
     *
     * @param  \Illuminate\Console\Scheduling\Schedule  $schedule
     * @return void
     */</span>
    <span class="token keyword">protected</span> <span class="token keyword">function</span> <span
                    class="token function">schedule</span><span class="token punctuation">(</span>Schedule <span
                    class="token variable">$schedule</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$schedule</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">call</span><span class="token punctuation">(</span><span
                    class="token keyword">function</span> <span class="token punctuation">(</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token constant">DB</span><span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token function">table</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'recent_users'</span><span
                    class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">delete</span><span class="token punctuation">(</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">daily</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Помимо планирования с использованием замыканий, вы также можете запланировать <a
            href="https://secure.php.net/manual/en/language.oop5.magic.php%23object.invoke">вызываемые объекты</a>.
    Вызываемые объекты - это простые PHP-классы, содержащие <code>__invoke</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$schedule</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">call</span><span class="token punctuation">(</span><span class="token keyword">new</span> <span
                class="token class-name">DeleteRecentUsers</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">daily</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Если вы хотите просмотреть обзор ваших запланированных задач и в следующий раз, когда они будут запланированы для
    выполнения, вы можете использовать <code>schedule:list</code> Artisan-команду:</p>
<pre class=" language-nothing"><code class=" language-nothing">php artisan schedule:list</code></pre>
<p></p>
<h3 id="scheduling-artisan-commands"><a href="#scheduling-artisan-commands">Планирование команд Artisan</a></h3>
<p>В дополнение к планированию закрытия вы также можете запланировать <a href="artisan">Artisan-команды</a> и системные
    команды. Например, вы можете использовать этот <code>command</code> метод для планирования команды Artisan,
    используя имя или класс команды.</p>
<p>При планировании команд Artisan с использованием имени класса команды вы можете передать массив дополнительных
    аргументов командной строки, которые должны быть предоставлены команде при ее вызове:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Console<span class="token punctuation">\</span>Commands<span
                    class="token punctuation">\</span>SendEmailsCommand</span><span class="token punctuation">;</span>

<span class="token variable">$schedule</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">command</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'emails:send Taylor --force'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">daily</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token variable">$schedule</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">command</span><span
                class="token punctuation">(</span>SendEmailsCommand<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span><span
                class="token single-quoted-string string">'Taylor'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'--force'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">daily</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="scheduling-queued-jobs"><a href="#scheduling-queued-jobs">Планирование заданий в очереди</a></h3>
<p>Этот <code>job</code> метод можно использовать для планирования <a href="queues">задания</a> в <a href="queues">очереди</a>.
    Этот метод обеспечивает удобный способ планирования заданий в очереди без использования <code>call</code> метода
    определения закрытий для постановки задания в очередь:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Jobs<span
                    class="token punctuation">\</span>Heartbeat</span><span class="token punctuation">;</span>

<span class="token variable">$schedule</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">job</span><span
                class="token punctuation">(</span><span class="token keyword">new</span> <span class="token class-name">Heartbeat</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">everyFiveMinutes</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Необязательные второй и третий аргументы могут быть предоставлены <code>job</code> методу, который указывает имя
    очереди и соединение с очередью, которое следует использовать для постановки задания в очередь:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Jobs<span
                    class="token punctuation">\</span>Heartbeat</span><span class="token punctuation">;</span>

<span class="token comment">// Dispatch the job to the "heartbeats" queue on the "sqs" connection...</span>
<span class="token variable">$schedule</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">job</span><span
                class="token punctuation">(</span><span class="token keyword">new</span> <span class="token class-name">Heartbeat</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'heartbeats'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'sqs'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">everyFiveMinutes</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="scheduling-shell-commands"><a href="#scheduling-shell-commands">Планирование команд оболочки</a></h3>
<p><code>exec</code> Метод может быть использован, чтобы выдать команду к операционной системе:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$schedule</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">exec</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'node /home/forge/script.js'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">daily</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="schedule-frequency-options"><a href="#schedule-frequency-options">Параметры частоты расписания</a></h3>
<p>Мы уже видели несколько примеров того, как вы можете настроить задачу для запуска через определенные промежутки
    времени. Однако вы можете назначить задаче гораздо больше частот расписания задач:</p>
<table>
    <thead>
    <tr>
        <th>Метод</th>
        <th>Описание</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td><code>-&gt;cron('* * * * *');</code></td>
        <td>Запустить задачу по индивидуальному расписанию cron</td>
    </tr>
    <tr>
        <td><code>-&gt;everyMinute();</code></td>
        <td>Запускать задачу каждую минуту</td>
    </tr>
    <tr>
        <td><code>-&gt;everyTwoMinutes();</code></td>
        <td>Запускать задачу каждые две минуты</td>
    </tr>
    <tr>
        <td><code>-&gt;everyThreeMinutes();</code></td>
        <td>Запускать задачу каждые три минуты</td>
    </tr>
    <tr>
        <td><code>-&gt;everyFourMinutes();</code></td>
        <td>Запускать задачу каждые четыре минуты</td>
    </tr>
    <tr>
        <td><code>-&gt;everyFiveMinutes();</code></td>
        <td>Запускать задачу каждые пять минут</td>
    </tr>
    <tr>
        <td><code>-&gt;everyTenMinutes();</code></td>
        <td>Запускать задачу каждые десять минут</td>
    </tr>
    <tr>
        <td><code>-&gt;everyFifteenMinutes();</code></td>
        <td>Запускать задачу каждые пятнадцать минут</td>
    </tr>
    <tr>
        <td><code>-&gt;everyThirtyMinutes();</code></td>
        <td>Запускать задачу каждые тридцать минут</td>
    </tr>
    <tr>
        <td><code>-&gt;hourly();</code></td>
        <td>Запускать задачу каждый час</td>
    </tr>
    <tr>
        <td><code>-&gt;hourlyAt(17);</code></td>
        <td>Запускать задачу каждый час в 17 минут после часа</td>
    </tr>
    <tr>
        <td><code>-&gt;everyTwoHours();</code></td>
        <td>Запускать задачу каждые два часа</td>
    </tr>
    <tr>
        <td><code>-&gt;everyThreeHours();</code></td>
        <td>Запускать задачу каждые три часа</td>
    </tr>
    <tr>
        <td><code>-&gt;everyFourHours();</code></td>
        <td>Запускать задачу каждые четыре часа</td>
    </tr>
    <tr>
        <td><code>-&gt;everySixHours();</code></td>
        <td>Запускать задачу каждые шесть часов</td>
    </tr>
    <tr>
        <td><code>-&gt;daily();</code></td>
        <td>Запускать задачу каждый день в полночь</td>
    </tr>
    <tr>
        <td><code>-&gt;dailyAt('13:00');</code></td>
        <td>Запускать задание каждый день в 13:00</td>
    </tr>
    <tr>
        <td><code>-&gt;twiceDaily(1, 13);</code></td>
        <td>Запускать задачу ежедневно в 1:00 и 13:00.</td>
    </tr>
    <tr>
        <td><code>-&gt;weekly();</code></td>
        <td>Запускать задачу каждое воскресенье в 00:00</td>
    </tr>
    <tr>
        <td><code>-&gt;weeklyOn(1, '8:00');</code></td>
        <td>Запускать задачу каждую неделю в понедельник в 8:00.</td>
    </tr>
    <tr>
        <td><code>-&gt;monthly();</code></td>
        <td>Запускать задачу первого числа каждого месяца в 00:00.</td>
    </tr>
    <tr>
        <td><code>-&gt;monthlyOn(4, '15:00');</code></td>
        <td>Запускать задачу каждый месяц 4 числа в 15:00</td>
    </tr>
    <tr>
        <td><code>-&gt;twiceMonthly(1, 16, '13:00');</code></td>
        <td>Запускать задачу ежемесячно 1 и 16 числа в 13:00.</td>
    </tr>
    <tr>
        <td><code>-&gt;lastDayOfMonth('15:00');</code></td>
        <td>Запустить задачу в последний день месяца в 15:00</td>
    </tr>
    <tr>
        <td><code>-&gt;quarterly();</code></td>
        <td>Запускать задачу в первый день каждого квартала в 00:00.</td>
    </tr>
    <tr>
        <td><code>-&gt;yearly();</code></td>
        <td>Запускать задачу в первый день каждого года в 00:00</td>
    </tr>
    <tr>
        <td><code>-&gt;yearlyOn(6, 1, '17:00');</code></td>
        <td>Запускать задачу каждый год 1 июня в 17:00.</td>
    </tr>
    <tr>
        <td><code>-&gt;timezone('America/New_York');</code></td>
        <td>Установите часовой пояс для задачи</td>
    </tr>
    </tbody>
</table>
<p>Эти методы можно комбинировать с дополнительными ограничениями для создания еще более точных расписаний, которые
    выполняются только в определенные дни недели. Например, вы можете запланировать выполнение команды еженедельно в
    понедельник:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">// Run once per week on Monday at 1 PM...</span>
<span class="token variable">$schedule</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">call</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">weekly</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">mondays</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">at</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'13:00'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// Run hourly from 8 AM to 5 PM on weekdays...</span>
<span class="token variable">$schedule</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">command</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'foo'</span><span
                class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">weekdays</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">hourly</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">timezone</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'America/Chicago'</span><span
                class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">between</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'8:00'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'17:00'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Список дополнительных ограничений расписания можно найти ниже:</p>
<table>
    <thead>
    <tr>
        <th>Метод</th>
        <th>Описание</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td><code>-&gt;weekdays();</code></td>
        <td>Ограничьте задачу рабочими днями</td>
    </tr>
    <tr>
        <td><code>-&gt;weekends();</code></td>
        <td>Ограничьте задачу выходными</td>
    </tr>
    <tr>
        <td><code>-&gt;sundays();</code></td>
        <td>Ограничьте задачу до воскресенья</td>
    </tr>
    <tr>
        <td><code>-&gt;mondays();</code></td>
        <td>Ограничьте задачу до понедельника</td>
    </tr>
    <tr>
        <td><code>-&gt;tuesdays();</code></td>
        <td>Ограничьте задачу вторником</td>
    </tr>
    <tr>
        <td><code>-&gt;wednesdays();</code></td>
        <td>Ограничьте задачу средой</td>
    </tr>
    <tr>
        <td><code>-&gt;thursdays();</code></td>
        <td>Ограничьте задачу до четверга</td>
    </tr>
    <tr>
        <td><code>-&gt;fridays();</code></td>
        <td>Ограничьте задачу до пятницы</td>
    </tr>
    <tr>
        <td><code>-&gt;saturdays();</code></td>
        <td>Ограничьте задачу субботой</td>
    </tr>
    <tr>
        <td><code>-&gt;days(array|mixed);</code></td>
        <td>Ограничьте задачу определенными днями</td>
    </tr>
    <tr>
        <td><code>-&gt;between($startTime, $endTime);</code></td>
        <td>Ограничьте выполнение задачи между временем начала и окончания</td>
    </tr>
    <tr>
        <td><code>-&gt;unlessBetween($startTime, $endTime);</code></td>
        <td>Ограничьте выполнение задачи между временем начала и окончания</td>
    </tr>
    <tr>
        <td><code>-&gt;when(Closure);</code></td>
        <td>Ограничьте задачу на основе проверки истинности</td>
    </tr>
    <tr>
        <td><code>-&gt;environments($env);</code></td>
        <td>Ограничьте задачу конкретными средами</td>
    </tr>
    </tbody>
</table>
<p></p>
<h4 id="day-constraints"><a href="#day-constraints">Дневные ограничения</a></h4>
<p><code>days</code> Метод может быть использован для ограничения выполнения задачи в определенные дни недели. Например,
    вы можете запланировать выполнение команды ежечасно по воскресеньям и средам:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$schedule</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">command</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'emails:send'</span><span class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">hourly</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">days</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span><span class="token number">0</span><span
                class="token punctuation">,</span> <span class="token number">3</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>В качестве альтернативы вы можете использовать константы, доступные в
    <code>Illuminate\Console\Scheduling\Schedule</code> классе, при определении дней, в которые должна выполняться
    задача:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Console<span
                    class="token punctuation">\</span>Scheduling<span
                    class="token punctuation">\</span>Schedule</span><span class="token punctuation">;</span>

<span class="token variable">$schedule</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">command</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'emails:send'</span><span class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">hourly</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">days</span><span class="token punctuation">(</span><span
                class="token punctuation">[</span>Schedule<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token constant">SUNDAY</span><span
                class="token punctuation">,</span> Schedule<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token constant">WEDNESDAY</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="between-time-constraints"><a href="#between-time-constraints">Между временными ограничениями</a></h4>
<p><code>between</code> Метод может быть использован для ограничения выполнения задачи на основе времени суток:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$schedule</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">command</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'emails:send'</span><span class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">hourly</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">between</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'7:00'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'22:00'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Точно так же <code>unlessBetween</code> метод может использоваться для исключения выполнения задачи на период
    времени:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$schedule</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">command</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'emails:send'</span><span class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">hourly</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">unlessBetween</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'23:00'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'4:00'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="truth-test-constraints"><a href="#truth-test-constraints">Ограничения проверки правды</a></h4>
<p><code>when</code> Метод может быть использован для ограничения выполнения задачи на основе результата проверки данной
    истины. Другими словами, если данное закрытие возвращается <code>true</code>, задача будет выполняться до тех пор,
    пока никакие другие ограничивающие условия не препятствуют ее запуску:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$schedule</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">command</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'emails:send'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">daily</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">when</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token boolean constant">true</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Этот <code>skip</code> метод можно рассматривать как инверсию <code>when</code>. Если <code>skip</code> метод
    вернется <code>true</code>, запланированная задача не будет выполнена:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$schedule</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">command</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'emails:send'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">daily</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">skip</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token boolean constant">true</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>При использовании связанных <code>when</code> методов запланированная команда будет выполняться только в том случае,
    если все <code>when</code> условия вернутся <code>true</code>.</p>
<p></p>
<h4 id="environment-constraints"><a href="#environment-constraints">Ограничения среды</a></h4>
<p><code>environments</code> Способ может быть использован для выполнения задач только на заданных условиях (как это
    определено в <code>APP_ENV</code> <a href="configuration#environment-configuration">переменной окружения</a> ):</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$schedule</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">command</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'emails:send'</span><span class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">daily</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">environments</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'staging'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'production'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="timezones"><a href="#timezones">Часовые пояса</a></h3>
<p>Используя этот <code>timezone</code> метод, вы можете указать, что время запланированной задачи должно
    интерпретироваться в пределах заданного часового пояса:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$schedule</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">command</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'report:generate'</span><span
                class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">timezone</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'America/New_York'</span><span
                class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">at</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'2:00'</span><span
                class="token punctuation">)</span></code></pre>
<p>Если вы постоянно назначаете один и тот же часовой пояс для всех ваших запланированных задач, вы можете определить
    <code>scheduleTimezone</code> метод в своем <code>App\Console\Kernel</code> классе. Этот метод должен возвращать
    часовой пояс по умолчанию, который должен быть назначен для всех запланированных задач:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Get the timezone that should be used by default for scheduled events.
 *
 * @return \DateTimeZone|string|null
 */</span>
<span class="token keyword">protected</span> <span class="token keyword">function</span> <span class="token function">scheduleTimezone</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span
                class="token single-quoted-string string">'America/Chicago'</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Помните, что в некоторых часовых поясах используется летнее время. Когда происходит переход на летнее время,
            ваша запланированная задача может запускаться дважды или даже не запускаться вообще. По этой причине мы
            рекомендуем по возможности избегать планирования часовых поясов.</p></p></div>
</blockquote>
<p></p>
<h3 id="preventing-task-overlaps"><a href="#preventing-task-overlaps">Предотвращение дублирования задач</a></h3>
<p>По умолчанию запланированные задачи будут выполняться, даже если предыдущий экземпляр задачи все еще выполняется.
    Чтобы предотвратить это, вы можете использовать <code>withoutOverlapping</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$schedule</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">command</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'emails:send'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">withoutOverlapping</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>В этом примере команда <code>emails:send</code> <a href="artisan">Artisan</a> будет запускаться каждую минуту, если
    она еще не запущена. Этот <code>withoutOverlapping</code> метод особенно полезен, если у вас есть задачи, которые
    сильно различаются по времени выполнения, что не позволяет вам точно предсказать, сколько времени займет данная
    задача.</p>
<p>При необходимости вы можете указать, сколько минут должно пройти до истечения срока действия блокировки «без
    перекрытия». По умолчанию срок действия блокировки истекает через 24 часа:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$schedule</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">command</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'emails:send'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">withoutOverlapping</span><span
                class="token punctuation">(</span><span class="token number">10</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="running-tasks-on-one-server"><a href="#running-tasks-on-one-server">Выполнение задач на одном сервере</a></h3>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Для того, чтобы использовать эту функцию, приложение должно быть с помощью <code>database</code>, <code>memcached</code>,
            <code>dynamodb</code> или <code>redis</code> драйвер кэша в качестве драйвера по умолчанию кэша приложения.
            Кроме того, все серверы должны взаимодействовать с одним и тем же центральным сервером кэширования.</p></p>
    </div>
</blockquote>
<p>Если планировщик вашего приложения работает на нескольких серверах, вы можете ограничить выполнение запланированного
    задания только на одном сервере. Например, предположим, что у вас есть запланированная задача, по которой каждую
    пятницу вечером создается новый отчет. Если планировщик задач работает на трех рабочих серверах, запланированная
    задача будет запущена на всех трех серверах и трижды сгенерирует отчет. Фигово!</p>
<p>Чтобы указать, что задача должна выполняться только на одном сервере, используйте <code>onOneServer</code> метод при
    определении запланированной задачи. Первый сервер, который получит задачу, обеспечит атомарную блокировку задания,
    чтобы другие серверы не могли одновременно выполнять ту же задачу:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$schedule</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">command</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'report:generate'</span><span
                class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">fridays</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">at</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'17:00'</span><span class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">onOneServer</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="background-tasks"><a href="#background-tasks">Фоновые задачи</a></h3>
<p>По умолчанию несколько задач, запланированных одновременно, будут выполняться последовательно в соответствии с
    порядком, который они определены в вашем <code>schedule</code> методе. Если у вас есть длительные задачи, это может
    привести к тому, что последующие задачи начнутся намного позже, чем ожидалось. Если вы хотите запускать задачи в
    фоновом режиме, чтобы все они могли выполняться одновременно, вы можете использовать <code>runInBackground</code>
    метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$schedule</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">command</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'analytics:report'</span><span
                class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">daily</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">runInBackground</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p><code>runInBackground</code> Метод может быть использован только при планировании задач с помощью <code>command</code>
            и <code>exec</code> методов.</p></p></div>
</blockquote>
<p></p>
<h3 id="maintenance-mode"><a href="#maintenance-mode">Режим технического обслуживания</a></h3>
<p>Запланированные задачи вашего приложения не будут выполняться, когда приложение находится в <a
            href="configuration#maintenance-mode">режиме обслуживания</a>, поскольку мы не хотим, чтобы ваши задачи
    мешали любому незавершенному обслуживанию, которое вы можете выполнять на своем сервере. Однако, если вы хотите
    принудительно запустить задачу даже в режиме обслуживания, вы можете вызвать <code>evenInMaintenanceMode</code>
    метод при определении задачи:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$schedule</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">command</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'emails:send'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">evenInMaintenanceMode</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="running-the-scheduler"><a href="#running-the-scheduler">Запуск планировщика</a></h2>
<p>Теперь, когда мы узнали, как определять запланированные задачи, давайте обсудим, как на самом деле запускать их на
    нашем сервере. Команда <code>schedule:run</code> Artisan оценит все ваши запланированные задачи и определит, нужно
    ли их запускать, на основе текущего времени сервера.</p>
<p>Итак, при использовании планировщика Laravel нам нужно только добавить одну запись конфигурации cron на наш сервер,
    которая запускает <code>schedule:run</code> команду каждую минуту. Если вы не знаете, как добавлять записи cron на
    свой сервер, рассмотрите возможность использования такой службы, как <a href="https://forge.laravel.com">Laravel
        Forge,</a> которая может управлять записями cron за вас:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">*</span> <span
                class="token operator">*</span> <span class="token operator">*</span> <span
                class="token operator">*</span> <span class="token operator">*</span> cd <span
                class="token operator">/</span>path<span class="token operator">-</span>to<span
                class="token operator">-</span>your<span class="token operator">-</span>project <span
                class="token operator">&amp;&amp;</span> php artisan schedule<span class="token punctuation">:</span>run <span
                class="token operator">&gt;</span><span class="token operator">&gt;</span> <span class="token operator">/</span>dev<span
                class="token operator">/</span><span class="token constant">null</span> <span
                class="token number">2</span><span class="token operator">&gt;</span><span
                class="token operator">&amp;</span><span class="token number">1</span></code></pre>
<p></p>
<h2 id="running-the-scheduler-locally"><a href="#running-the-scheduler-locally">Локальный запуск планировщика</a></h2>
<p>Как правило, вы не добавляете запись cron планировщика на локальную машину разработки. Вместо этого вы можете
    использовать команду <code>schedule:work</code> Artisan. Эта команда будет выполняться на переднем плане и вызывать
    планировщик каждую минуту, пока вы не завершите команду:</p>
<pre class=" language-php"><code class=" language-php">php artisan schedule<span class="token punctuation">:</span>work</code></pre>
<p></p>
<h2 id="task-output"><a href="#task-output">Вывод задачи</a></h2>
<p>Планировщик Laravel предоставляет несколько удобных методов для работы с выводом, созданным запланированными
    задачами. Во-первых, используя этот <code>sendOutputTo</code> метод, вы можете отправить результат в файл для
    последующей проверки:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$schedule</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">command</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'emails:send'</span><span class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">daily</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">sendOutputTo</span><span
                class="token punctuation">(</span><span class="token variable">$filePath</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если вы хотите добавить вывод в данный файл, вы можете использовать <code>appendOutputTo</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$schedule</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">command</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'emails:send'</span><span class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">daily</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">appendOutputTo</span><span
                class="token punctuation">(</span><span class="token variable">$filePath</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Используя этот <code>emailOutputTo</code> метод, вы можете отправить вывод по электронной почте на любой адрес
    электронной почты. Перед отправкой результатов задачи по <a href="mail">электронной почте</a> вам следует настроить
    <a href="mail">почтовые службы</a> Laravel:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$schedule</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">command</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'report:generate'</span><span
                class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">daily</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">sendOutputTo</span><span
                class="token punctuation">(</span><span class="token variable">$filePath</span><span
                class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">emailOutputTo</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'taylor@example.com'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если вы хотите отправить вывод по электронной почте только в том случае, если запланированная Artisan или системная
    команда завершается ненулевым кодом выхода, используйте <code>emailOutputOnFailure</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$schedule</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">command</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'report:generate'</span><span
                class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">daily</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">emailOutputOnFailure</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'taylor@example.com'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>В <code>emailOutputTo</code>, <code>emailOutputOnFailure</code>, <code>sendOutputTo</code> и <code>appendOutputTo</code>
            методы являются исключительными к <code>command</code> и <code>exec</code> методам.</p></p></div>
</blockquote>
<p></p>
<h2 id="task-hooks"><a href="#task-hooks">Перехватчики задач</a></h2>
<p>Использование <code>before</code> и <code>after</code> методы, вы можете задать код, который будет выполняться до и
    после того, как запланированное задание выполняется:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$schedule</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">command</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'emails:send'</span><span class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">daily</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">before</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
             <span class="token comment">// The task is about to execute...</span>
         <span class="token punctuation">}</span><span class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">after</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
             <span class="token comment">// The task has executed...</span>
         <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p><code>onSuccess</code> И <code>onFailure</code> методы позволяют задать код, который будет выполняться, если
    запланированное задание успешно или не. Ошибка указывает, что запланированная Artisan или системная команда
    завершилась ненулевым кодом выхода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$schedule</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">command</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'emails:send'</span><span class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">daily</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">onSuccess</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
             <span class="token comment">// The task succeeded...</span>
         <span class="token punctuation">}</span><span class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">onFailure</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
             <span class="token comment">// The task failed...</span>
         <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Если вывод доступен из вашей команды, вы можете получить к нему доступ в своем или хуках <code>after</code>, указав
    тип экземпляра в качестве аргумента определения закрытия вашего
    хука:<code>onSuccess</code><code>onFailure</code><code>Illuminate\Support\Stringable</code><code>$output</code></p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Stringable</span><span class="token punctuation">;</span>

<span class="token variable">$schedule</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">command</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'emails:send'</span><span class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">daily</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">onSuccess</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span>Stringable <span class="token variable">$output</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
             <span class="token comment">// The task succeeded...</span>
         <span class="token punctuation">}</span><span class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">onFailure</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span>Stringable <span class="token variable">$output</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
             <span class="token comment">// The task failed...</span>
         <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="pinging-urls"><a href="#pinging-urls">Проверка URL-адресов</a></h4>
<p>Используя <code>pingBefore</code> и <code>thenPing</code> методы, планировщик может автоматически пинговать заданный
    URL до или после того, как задача будет выполнена. Этот метод полезен для уведомления внешней службы, такой как <a
            href="https://envoyer.io">Envoyer</a>, о том, что ваша запланированная задача начинается или завершена:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$schedule</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">command</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'emails:send'</span><span class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">daily</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">pingBefore</span><span
                class="token punctuation">(</span><span class="token variable">$url</span><span
                class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">thenPing</span><span
                class="token punctuation">(</span><span class="token variable">$url</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Эти <code>pingBeforeIf</code> и <code>thenPingIf</code> методы могут использоваться для проверки заданного URL,
    только если данное условие <code>true</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$schedule</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">command</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'emails:send'</span><span class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">daily</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">pingBeforeIf</span><span
                class="token punctuation">(</span><span class="token variable">$condition</span><span
                class="token punctuation">,</span> <span class="token variable">$url</span><span
                class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">thenPingIf</span><span
                class="token punctuation">(</span><span class="token variable">$condition</span><span
                class="token punctuation">,</span> <span class="token variable">$url</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p><code>pingOnSuccess</code> И <code>pingOnFailure</code> методы могут использоваться для проверки заданного URL только
    если задача успешно или не удается. Ошибка указывает, что запланированная Artisan или системная команда завершилась
    ненулевым кодом выхода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$schedule</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">command</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'emails:send'</span><span class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">daily</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">pingOnSuccess</span><span
                class="token punctuation">(</span><span class="token variable">$successUrl</span><span
                class="token punctuation">)</span>
         <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">pingOnFailure</span><span
                class="token punctuation">(</span><span class="token variable">$failureUrl</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Для всех методов ping требуется HTTP-библиотека Guzzle. Guzzle обычно устанавливается во всех новых проектах Laravel
    по умолчанию, но вы можете вручную установить Guzzle в свой проект с помощью диспетчера пакетов Composer, если он
    был случайно удален:</p>
<pre class=" language-php"><code class=" language-php">composer <span
                class="token keyword">require</span> guzzlehttp<span class="token operator">/</span>guzzle</code></pre>
