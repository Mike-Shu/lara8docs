<h1>Хеширование <sup>Hashing</sup></h1>
<ul>
    <li><a href="hashing#introduction">Вступление</a></li>
    <li><a href="hashing#configuration">Конфигурация</a></li>
    <li><a href="hashing#basic-usage">Основное использование</a>
        <ul>
            <li><a href="hashing#hashing-passwords">Хеширование паролей</a></li>
            <li><a href="hashing#verifying-that-a-password-matches-a-hash">Проверка совпадения пароля с хешем</a></li>
            <li><a href="hashing#determining-if-a-password-needs-to-be-rehashed">Определение необходимости повторного
                    хеширования пароля</a></li>
        </ul>
    </li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p><code>Hash</code> <a href="facades">Фасад</a> Laravel обеспечивает безопасное хеширование Bcrypt и Argon2 для
    хранения паролей пользователей. Если вы используете один из <a href="starter-kits">стартовых наборов приложений
        Laravel</a>, Bcrypt будет использоваться для регистрации и аутентификации по умолчанию.</p>
<p>Bcrypt - отличный выбор для хеширования паролей, потому что его «рабочий фактор» регулируется, а это означает, что
    время, необходимое для генерации хеш-кода, может быть увеличено по мере увеличения мощности оборудования. Медленное
    хеширование паролей - это хорошо. Чем больше времени требуется алгоритму для хеширования пароля, тем больше времени
    требуется злоумышленникам для создания «радужных таблиц» всех возможных строковых хеш-значений, которые могут
    использоваться в атаках методом грубой силы против приложений.</p>
<p></p>
<h2 id="configuration"><a href="#configuration">Конфигурация</a></h2>
<p>Драйвер хеширования по умолчанию для вашего приложения настраивается в <code>config/hashing.php</code> файле
    конфигурации вашего приложения. В настоящее время поддерживается несколько драйверов: <a
            href="https://en.wikipedia.org/wiki/Bcrypt">Bcrypt</a> и <a href="https://en.wikipedia.org/wiki/Argon2">Argon2</a>
    (варианты Argon2i и Argon2id).</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p> Драйвер Argon2i требует PHP 7.2.0 или выше, а драйвер Argon2id требует PHP 7.3.0 или выше.</p></p></div>
</blockquote>
<p></p>
<h2 id="basic-usage"><a href="#basic-usage">Основное использование</a></h2>
<p></p>
<h3 id="hashing-passwords"><a href="#hashing-passwords">Хеширование паролей</a></h3>
<p>Вы можете хешировать пароль, вызвав <code>make</code> метод на <code>Hash</code> фасаде:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>Controller</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Hash</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">PasswordController</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Update the password for the user.
    *
    * @param  \Illuminate\Http\Request  $request
    * @return \Illuminate\Http\Response
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">update</span><span
                    class="token punctuation">(</span>Request <span class="token variable">$request</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">// Validate the new password length...</span>

        <span class="token variable">$request</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">user</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">fill</span><span
                    class="token punctuation">(</span><span class="token punctuation">[</span>
            <span class="token single-quoted-string string">'password'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> Hash<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token function">make</span><span
                    class="token punctuation">(</span><span class="token variable">$request</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">newPassword</span><span
                    class="token punctuation">)</span>
        <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">save</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h4 id="adjusting-the-bcrypt-work-factor"><a href="#adjusting-the-bcrypt-work-factor">Регулировка рабочего фактора
        Bcrypt</a></h4>
<p>Если вы используете алгоритм Bcrypt, этот <code>make</code> метод позволяет вам управлять коэффициентом работы
    алгоритма с помощью <code>rounds</code> опции; однако коэффициент работы по умолчанию, управляемый Laravel, приемлем
    для большинства приложений:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$hashed</span> <span
                class="token operator">=</span> Hash<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">make</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'password'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'rounds'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">12</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="adjusting-the-argon2-work-factor"><a href="#adjusting-the-argon2-work-factor">Регулировка рабочего фактора
        Argon2</a></h4>
<p>Если вы используете алгоритм Argon 2, то <code>make</code> метод позволяет управлять фактором работы алгоритма с
    использованием <code>memory</code>, <code>time</code> и <code>threads</code> варианты; однако значения по умолчанию,
    которыми управляет Laravel, приемлемы для большинства приложений:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$hashed</span> <span
                class="token operator">=</span> Hash<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">make</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'password'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'memory'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">1024</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'time'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">2</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'threads'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">2</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Для получения дополнительной информации об этих параметрах обратитесь к <a
                    href="https://secure.php.net/manual/en/function.password-hash.php">официальной документации PHP,
                касающейся хеширования Argon</a>.</p></p></div>
</blockquote>
<p></p>
<h3 id="verifying-that-a-password-matches-a-hash"><a href="#verifying-that-a-password-matches-a-hash">Проверка
        совпадения пароля с хешем</a></h3>
<p><code>check</code> Метод обеспечивается <code>Hash</code> фасад позволяет проверить, что данные простые текстовые
    строки соответствуют заданному хешу:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">if</span> <span
                class="token punctuation">(</span>Hash<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">check</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'plain-text'</span><span
                class="token punctuation">,</span> <span class="token variable">$hashedPassword</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">// The passwords match...</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="determining-if-a-password-needs-to-be-rehashed"><a href="#determining-if-a-password-needs-to-be-rehashed">Определение
        необходимости повторного хеширования пароля</a></h3>
<p><code>needsRehash</code> Метод обеспечивается <code>Hash</code> фасад позволяет определить, является ли фактор
    работы, используемый Hasher изменился, так как пароль был хэшируется. Некоторые приложения выбирают выполнение этой
    проверки во время процесса аутентификации приложения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">if</span> <span
                class="token punctuation">(</span>Hash<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">needsRehash</span><span
                class="token punctuation">(</span><span class="token variable">$hashed</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$hashed</span> <span class="token operator">=</span> Hash<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">make</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'plain-text'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
