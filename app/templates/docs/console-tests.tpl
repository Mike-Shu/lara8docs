<h1>Консольные тесты <sup>Console tests</sup></h1>
<ul>
    <li><a href="console-tests#introduction">Вступление</a></li>
    <li><a href="console-tests#input-output-expectations">Ожидания ввода/вывода</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Помимо упрощения HTTP-тестирования, Laravel предоставляет простой API для тестирования <a href="artisan">пользовательских
        консольных команд</a> вашего приложения.</p>
<p></p>
<h2 id="input-output-expectations"><a href="#input-output-expectations">Ожидания ввода/вывода</a></h2>
<p>Laravel позволяет вам легко «имитировать» ввод пользователя для консольных команд с помощью этого <code>expectsQuestion</code>
    метода. Кроме того, вы можете указать код выхода и текст, который вы ожидаете, будет выводиться с помощью команды
    консоли, используя <code>assertExitCode</code> и <code>expectsOutput</code> методы. Например, рассмотрим следующую
    консольную команду:</p>
<pre class=" language-php"><code class=" language-php">Artisan<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">command</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'question'</span><span
                class="token punctuation">,</span> <span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$name</span> <span class="token operator">=</span> <span
                class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">ask</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'What is your name?'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
            
    <span class="token variable">$language</span> <span class="token operator">=</span> <span
                class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">choice</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Which language do you prefer?'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'PHP'</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'Ruby'</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'Python'</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
            
    <span class="token variable">$this</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">line</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'Your name is '</span><span class="token punctuation">.</span><span
                class="token variable">$name</span><span class="token punctuation">.</span><span
                class="token single-quoted-string string">' and you prefer '</span><span
                class="token punctuation">.</span><span class="token variable">$language</span><span
                class="token punctuation">.</span><span class="token single-quoted-string string">'.'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы можете проверить эту команду следующим тестом, в котором используется <code>expectsQuestion</code>, <code>expectsOutput</code>,
    <code>doesntExpectOutput</code> и <code>assertExitCode</code> методы:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Test a console command.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">test_console_command</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">artisan</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'question'</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">expectsQuestion</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'What is your name?'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Taylor Otwell'</span><span class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">expectsQuestion</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Which language do you prefer?'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'PHP'</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">expectsOutput</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Your name is Taylor Otwell and you prefer PHP.'</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">doesntExpectOutput</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Your name is Taylor Otwell and you prefer Ruby.'</span><span
                class="token punctuation">)</span>
        <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertExitCode</span><span
                class="token punctuation">(</span><span class="token number">0</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="confirmation-expectations"><a href="#confirmation-expectations">Ожидания подтверждения</a></h4>
<p>При написании команды, которая ожидает подтверждения в виде ответа «да» или «нет», вы можете использовать <code>expectsConfirmation</code>
    метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">artisan</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'module:import'</span><span
                class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">expectsConfirmation</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'Do you really wish to run this command?'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'no'</span><span
                class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">assertExitCode</span><span
                class="token punctuation">(</span><span class="token number">1</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="table-expectations"><a href="#table-expectations">Таблица ожидания</a></h4>
<p>Если ваша команда отображает таблицу информации с использованием <code>table</code> метода Artisan, может быть сложно
    написать ожидаемый результат для всей таблицы. Вместо этого вы можете использовать <code>expectsTable</code> метод.
    Этот метод принимает заголовки таблицы в качестве первого аргумента, а данные таблицы - в качестве второго
    аргумента:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">artisan</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'users:all'</span><span class="token punctuation">)</span>
    <span class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">expectsTable</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'ID'</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'Email'</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span> <span
                class="token punctuation">[</span>
        <span class="token punctuation">[</span><span class="token number">1</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'taylor@example.com'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
        <span class="token punctuation">[</span><span class="token number">2</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'abigail@example.com'</span><span
                class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
