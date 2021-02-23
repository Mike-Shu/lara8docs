<h1>Шифрование <sup>Encryption</sup></h1>
<ul>
    <li><a href="encryption#introduction">Вступление</a></li>
    <li><a href="encryption#configuration">Конфигурация</a></li>
    <li><a href="encryption#using-the-encrypter">Использование шифратора</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Сервисы шифрования Laravel предоставляют простой и удобный интерфейс для шифрования и дешифрования текста через
    OpenSSL с использованием шифрования AES-256 и AES-128. Все зашифрованные значения Laravel подписываются с
    использованием кода аутентификации сообщения (MAC), поэтому их базовое значение не может быть изменено или подделано
    после шифрования.</p>
<p></p>
<h2 id="configuration"><a href="#configuration">Конфигурация</a></h2>
<p>Перед использованием шифратора Laravel вы должны установить параметр <code>key</code> конфигурации в своем <code>config/app.php</code>
    файле конфигурации. Это значение конфигурации определяется <code>APP_KEY</code> переменной среды. Вы должны
    использовать <code>php artisan key:generate</code> команду для генерации значения этой переменной, поскольку <code>key:generate</code>
    команда будет использовать безопасный генератор случайных байтов PHP для создания криптографически безопасного ключа
    для вашего приложения. Обычно значение <code>APP_KEY</code> переменной окружения создается для вас во <a
            href="installation">время установки Laravel</a>.</p>
<p></p>
<h2 id="using-the-encrypter"><a href="#using-the-encrypter">Использование шифратора</a></h2>
<p></p>
<h4 id="encrypting-a-value"><a href="#encrypting-a-value">Шифрование значения</a></h4>
<p>Вы можете зашифровать значение, используя <code>encryptString</code> метод, предоставляемый <code>Crypt</code>
    фасадом. Все зашифрованные значения зашифрованы с использованием OpenSSL и шифра AES-256-CBC. Кроме того, все
    зашифрованные значения подписываются кодом аутентификации сообщения (MAC). Встроенный код аутентификации сообщений
    предотвратит расшифровку любых значений, которые были подделаны злоумышленниками:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>Controller</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span
                        class="token punctuation">\</span>Models<span class="token punctuation">\</span>User</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Crypt</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">DigitalOceanTokenController</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Store a DigitalOcean API token for the user.
    *
    * @param  \Illuminate\Http\Request  $request
    * @return \Illuminate\Http\Response
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">storeSecret</span><span
                    class="token punctuation">(</span>Request <span class="token variable">$request</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$request</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token function">user</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">fill</span><span
                    class="token punctuation">(</span><span class="token punctuation">[</span>
            <span class="token single-quoted-string string">'token'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> Crypt<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token function">encryptString</span><span
                    class="token punctuation">(</span><span class="token variable">$request</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">token</span><span
                    class="token punctuation">)</span><span class="token punctuation">,</span>
        <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">save</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h4 id="decrypting-a-value"><a href="#decrypting-a-value">Расшифровка значения</a></h4>
<p>Вы можете расшифровать значения, используя <code>decryptString</code> метод, предоставляемый <code>Crypt</code>
    фасадом. Если значение не может быть правильно расшифровано, например, когда код аутентификации сообщения
    недействителен, <code>Illuminate\Contracts\Encryption\DecryptException</code> будет выдано:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Contracts<span
                    class="token punctuation">\</span>Encryption<span class="token punctuation">\</span>DecryptException</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Crypt</span><span
                class="token punctuation">;</span>

<span class="token keyword">try</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token variable">$decrypted</span> <span class="token operator">=</span> Crypt<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">decryptString</span><span
                class="token punctuation">(</span><span class="token variable">$encryptedValue</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span> <span class="token keyword">catch</span> <span
                class="token punctuation">(</span>DecryptException <span class="token variable">$e</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//</span>
<span class="token punctuation">}</span></code></pre>
