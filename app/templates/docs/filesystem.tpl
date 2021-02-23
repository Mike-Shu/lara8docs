<h1>Файловое хранилище</h1>
<ul>
    <li><a href="filesystem#introduction">Вступление</a></li>
    <li><a href="filesystem#configuration">Конфигурация</a>
        <ul>
            <li><a href="filesystem#the-local-driver">Местный водитель</a></li>
            <li><a href="filesystem#the-public-disk">Публичный диск</a></li>
            <li><a href="filesystem#driver-prerequisites">Требования к драйверам</a></li>
            <li><a href="filesystem#caching">Кеширование</a></li>
        </ul>
    </li>
    <li><a href="filesystem#obtaining-disk-instances">Получение экземпляров дисков</a></li>
    <li><a href="filesystem#retrieving-files">Получение файлов</a>
        <ul>
            <li><a href="filesystem#downloading-files">Скачивание файлов</a></li>
            <li><a href="filesystem#file-urls">URL-адреса файлов</a></li>
            <li><a href="filesystem#file-metadata">Метаданные файла</a></li>
        </ul>
    </li>
    <li><a href="filesystem#storing-files">Хранение файлов</a>
        <ul>
            <li><a href="filesystem#file-uploads">Загрузка файлов</a></li>
            <li><a href="filesystem#file-visibility">Видимость файла</a></li>
        </ul>
    </li>
    <li><a href="filesystem#deleting-files">Удаление файлов</a></li>
    <li><a href="filesystem#directories">Справочники</a></li>
    <li><a href="filesystem#custom-filesystems">Пользовательские файловые системы</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Laravel обеспечивает мощную абстракцию файловой системы благодаря замечательному PHP-пакету <a
            href="https://github.com/thephpleague/flysystem">Flysystem</a> от Фрэнка де Йонге. Интеграция Laravel
    Flysystem предоставляет простые драйверы для работы с локальными файловыми системами, SFTP и Amazon S3. Более того,
    удивительно просто переключаться между этими вариантами хранения между локальной машиной разработки и
    производственным сервером, поскольку API остается неизменным для каждой системы.</p>
<p></p>
<h2 id="configuration"><a href="#configuration">Конфигурация</a></h2>
<p>Файл конфигурации файловой системы Laravel находится по адресу <code>config/filesystems.php</code>. В этом файле вы
    можете настроить все «диски» файловой системы. Каждый диск представляет собой определенный драйвер хранилища и место
    хранения. Примеры конфигураций для каждого поддерживаемого драйвера включены в файл конфигурации, поэтому вы можете
    изменить конфигурацию в соответствии с вашими предпочтениями и учетными данными для хранения.</p>
<p>В <code>local</code> взаимодействует водитель с файлами, хранящимися на локальном сервере приложения Laravel в то
    время как <code>s3</code> драйвер используется для записи в службу хранения S3 облака Amazon.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p> Вы можете настроить столько дисков, сколько захотите, и даже можете иметь несколько дисков, использующих
            один и тот же драйвер.</p></p></div>
</blockquote>
<p></p>
<h3 id="the-local-driver"><a href="#the-local-driver">Местный водитель</a></h3>
<p>При использовании <code>local</code> драйвера все файловые операции относятся к <code>root</code> каталогу,
    определенному в вашем <code>filesystems</code> файле конфигурации. По умолчанию это значение установлено для <code>storage/app</code>
    каталога. Следовательно, следующий метод будет писать по адресу <code>storage/app/example.txt</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Storage</span><span
                class="token punctuation">;</span>

Storage<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">disk</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'local'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">put</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'example.txt'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Contents'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="the-public-disk"><a href="#the-public-disk">Публичный диск</a></h3>
<p><code>public</code> Диск включен в вашем приложении <code>filesystems</code> конфигурационного файла предназначен для
    файлов, которые будут доступны для общественности. По умолчанию <code>public</code> диск использует
    <code>local</code> драйвер и хранит свои файлы в формате <code>storage/app/public</code>.</p>
<p>Чтобы сделать эти файлы доступными из Интернета, вы должны создать символическую ссылку с <code>public/storage</code>
    на <code>storage/app/public</code>. Использование этого соглашения о папках позволит хранить ваши общедоступные
    файлы в одном каталоге, который можно легко использовать в разных развертываниях при использовании систем
    развертывания с нулевым временем простоя, таких как <a href="https://envoyer.io">Envoyer</a>.</p>
<p>Чтобы создать символическую ссылку, вы можете использовать <code>storage:link</code> Artisan-команду:</p>
<pre class=" language-php"><code class=" language-php">php artisan storage<span
                class="token punctuation">:</span>link</code></pre>
<p>После того, как файл был сохранен и была создана символическая ссылка, вы можете создать URL-адрес файлов с помощью
    <code>asset</code> помощника:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">echo</span> <span
                class="token function">asset</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'storage/file.txt'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете настроить дополнительные символические ссылки в вашем <code>filesystems</code> файле конфигурации. Каждая
    из настроенных ссылок будет создана при запуске <code>storage:link</code> команды:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'links'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token function">public_path</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'storage'</span><span class="token punctuation">)</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token function">storage_path</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'app/public'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token function">public_path</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'images'</span><span class="token punctuation">)</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token function">storage_path</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'app/images'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p></p>
<h3 id="driver-prerequisites"><a href="#driver-prerequisites">Требования к драйверам</a></h3>
<p></p>
<h4 id="composer-packages"><a href="#composer-packages">Композиторные пакеты</a></h4>
<p>Перед использованием драйверов S3 или SFTP вам необходимо установить соответствующий пакет через диспетчер пакетов
    Composer:</p>
<ul>
    <li>Amazon S3: <code>league/flysystem-aws-s3-v3 ~1.0</code></li>
    <li>SFTP: <code>league/flysystem-sftp ~1.0</code></li>
</ul>
<p>Кроме того, вы можете установить кэшированный адаптер для повышения производительности:</p>
<ul>
    <li>CachedAdapter: <code>league/flysystem-cached-adapter ~1.0</code></li>
</ul>
<p></p>
<h4 id="s3-driver-configuration"><a href="#s3-driver-configuration">Конфигурация драйвера S3</a></h4>
<p>Информация о конфигурации драйвера S3 находится в вашем <code>config/filesystems.php</code> файле конфигурации. Этот
    файл содержит пример массива конфигурации для драйвера S3. Вы можете изменить этот массив своей собственной
    конфигурацией S3 и учетными данными. Для удобства эти переменные среды соответствуют соглашению об именах,
    используемому в интерфейсе командной строки AWS.</p>
<p></p>
<h4 id="ftp-driver-configuration"><a href="#ftp-driver-configuration">Конфигурация драйвера FTP</a></h4>
<p>Интеграция Laravel's Flysystem отлично работает с FTP; однако образец конфигурации не включен в
    <code>filesystems.php</code> файл конфигурации платформы по умолчанию. Если вам нужно настроить файловую систему
    FTP, вы можете использовать пример конфигурации ниже:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'ftp'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'driver'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'ftp'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'host'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'ftp.example.com'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'username'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'your-username'</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'password'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'your-password'</span><span class="token punctuation">,</span>

    <span class="token comment">// Optional FTP Settings...</span>
    <span class="token comment">// 'port' =&gt; 21,</span>
    <span class="token comment">// 'root' =&gt; '',</span>
    <span class="token comment">// 'passive' =&gt; true,</span>
    <span class="token comment">// 'ssl' =&gt; true,</span>
    <span class="token comment">// 'timeout' =&gt; 30,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p></p>
<h4 id="sftp-driver-configuration"><a href="#sftp-driver-configuration">Конфигурация драйвера SFTP</a></h4>
<p>Интеграция Laravel's Flysystem отлично работает с SFTP; однако образец конфигурации не включен в <code>filesystems.php</code>
    файл конфигурации платформы по умолчанию. Если вам нужно настроить файловую систему SFTP, вы можете использовать
    пример конфигурации ниже:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'sftp'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'driver'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'sftp'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'host'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'example.com'</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'username'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'your-username'</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'password'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'your-password'</span><span class="token punctuation">,</span>

    <span class="token comment">// Settings for SSH key based authentication...</span>
    <span class="token single-quoted-string string">'privateKey'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'/path/to/privateKey'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'password'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'encryption-password'</span><span
                class="token punctuation">,</span>

    <span class="token comment">// Optional SFTP Settings...</span>
    <span class="token comment">// 'port' =&gt; 22,</span>
    <span class="token comment">// 'root' =&gt; '',</span>
    <span class="token comment">// 'timeout' =&gt; 30,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p></p>
<h3 id="caching"><a href="#caching">Кеширование</a></h3>
<p>Чтобы включить кэширование для данного диска, вы можете добавить <code>cache</code> директиву в параметры
    конфигурации диска. Параметр <code>cache</code> должен быть массивом параметров кеширования, содержащим
    <code>disk</code> имя, <code>expire</code> время в секундах и кеш <code>prefix</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token single-quoted-string string">'s3'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'driver'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'s3'</span><span
                class="token punctuation">,</span>

    <span class="token comment">// Other Disk Options...</span>

    <span class="token single-quoted-string string">'cache'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'store'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'memcached'</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'expire'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">600</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'prefix'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'cache-prefix'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p></p>
<h2 id="obtaining-disk-instances"><a href="#obtaining-disk-instances">Получение экземпляров дисков</a></h2>
<p><code>Storage</code> Фасад может быть использован для взаимодействия с любым из ваших настроенных дисков. Например,
    вы можете использовать <code>put</code> метод фасада для сохранения аватара на диске по умолчанию. Если вы вызываете
    методы на <code>Storage</code> фасаде без предварительного вызова <code>disk</code> метода, метод будет
    автоматически передан на диск по умолчанию:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Storage</span><span
                class="token punctuation">;</span>

Storage<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">put</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'avatars/1'</span><span
                class="token punctuation">,</span> <span class="token variable">$content</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если ваше приложение взаимодействует с несколькими дисками, вы можете использовать <code>disk</code> метод <code>Storage</code>
    фасада для работы с файлами на определенном диске:</p>
<pre class=" language-php"><code class=" language-php">Storage<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">disk</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'s3'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">put</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'avatars/1'</span><span
                class="token punctuation">,</span> <span class="token variable">$content</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="retrieving-files"><a href="#retrieving-files">Получение файлов</a></h2>
<p><code>get</code> Метод может быть использован для извлечения содержимого файла. Необработанное строковое содержимое
    файла будет возвращено методом. Помните, что все пути к файлам должны быть указаны относительно «корневого»
    расположения диска:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$contents</span> <span
                class="token operator">=</span> Storage<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'file.jpg'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Этот <code>exists</code> метод может использоваться, чтобы определить, существует ли файл на диске:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">if</span> <span
                class="token punctuation">(</span>Storage<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">disk</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'s3'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">exists</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'file.jpg'</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//...</span>
<span class="token punctuation">}</span></code></pre>
<p>Этот <code>missing</code> метод может использоваться для определения отсутствия файла на диске:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">if</span> <span
                class="token punctuation">(</span>Storage<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">disk</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'s3'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">missing</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'file.jpg'</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span> <span
                class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">//...</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="downloading-files"><a href="#downloading-files">Скачивание файлов</a></h3>
<p><code>download</code> Метод может быть использован для создания ответа, что браузер заставляет пользователя, чтобы
    загрузить файл на данном пути. <code>download</code> Метод принимает имя файла в качестве второго аргумента метода,
    который будет определять имя файла, видимый пользователем загрузку файла. Наконец, вы можете передать массив
    заголовков HTTP в качестве третьего аргумента метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">return</span> Storage<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">download</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'file.jpg'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">return</span> Storage<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">download</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'file.jpg'</span><span
                class="token punctuation">,</span> <span class="token variable">$name</span><span
                class="token punctuation">,</span> <span class="token variable">$headers</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="file-urls"><a href="#file-urls">URL-адреса файлов</a></h3>
<p>Вы можете использовать этот <code>url</code> метод, чтобы получить URL-адрес для данного файла. Если вы используете
    <code>local</code> драйвер, он обычно просто добавляется <code>/storage</code> к заданному пути и возвращает
    относительный URL-адрес файла. Если вы используете <code>s3</code> драйвер, будет возвращен полный удаленный URL:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Storage</span><span
                class="token punctuation">;</span>

<span class="token variable">$url</span> <span class="token operator">=</span> Storage<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">url</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'file.jpg'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>При использовании <code>local</code> драйвера все файлы, которые должны быть общедоступными, должны быть помещены в
    <code>storage/app/public</code> каталог. Кроме того, вы должны <a href="filesystem#the-public-disk">создать
        символическую ссылку</a> на <code>public/storage</code> который указывает на <code>storage/app/public</code>
    каталог.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>При использовании <code>local</code> драйвера возвращаемое значение <code>url</code> не кодируется URL. По
            этой причине мы рекомендуем всегда хранить ваши файлы, используя имена, которые будут создавать
            действительные URL-адреса.</p></p></div>
</blockquote>
<p></p>
<h4 id="temporary-urls"><a href="#temporary-urls">Временные URL</a></h4>
<p>Используя этот <code>temporaryUrl</code> метод, вы можете создавать временные URL-адреса для файлов, хранящихся с
    помощью <code>s3</code> драйвера. Этот метод принимает путь и <code>DateTime</code> экземпляр, указывающий, когда
    должен истечь URL:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Storage</span><span
                class="token punctuation">;</span>

<span class="token variable">$url</span> <span class="token operator">=</span> Storage<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">temporaryUrl</span><span
                class="token punctuation">(</span>
    <span class="token single-quoted-string string">'file.jpg'</span><span class="token punctuation">,</span> <span
                class="token function">now</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">addMinutes</span><span
                class="token punctuation">(</span><span class="token number">5</span><span
                class="token punctuation">)</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если вам нужно указать дополнительные <a
            href="https://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectGET.html%23RESTObjectGET-requests">параметры
        запроса S3</a>, вы можете передать массив параметров запроса в качестве третьего аргумента
    <code>temporaryUrl</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$url</span> <span
                class="token operator">=</span> Storage<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">temporaryUrl</span><span
                class="token punctuation">(</span>
    <span class="token single-quoted-string string">'file.jpg'</span><span class="token punctuation">,</span>
    <span class="token function">now</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">addMinutes</span><span
                class="token punctuation">(</span><span class="token number">5</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'ResponseContentType'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'application/octet-stream'</span><span
                class="token punctuation">,</span>
        <span class="token single-quoted-string string">'ResponseContentDisposition'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token single-quoted-string string">'attachment; filename=file2.jpg'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="url-host-customization"><a href="#url-host-customization">Настройка хоста URL</a></h4>
<p>Если вы хотите предварительно определить хост для URL-адресов, сгенерированных с помощью <code>Storage</code> фасада,
    вы можете добавить <code>url</code> параметр в массив конфигурации диска:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'public'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'driver'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'local'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'root'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">storage_path</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'app/public'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'url'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">env</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'APP_URL'</span><span
                class="token punctuation">)</span><span class="token punctuation">.</span><span
                class="token single-quoted-string string">'/storage'</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'visibility'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'public'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p></p>
<h3 id="file-metadata"><a href="#file-metadata">Метаданные файла</a></h3>
<p>Помимо чтения и записи файлов, Laravel также может предоставлять информацию о самих файлах. Например,
    <code>size</code> метод можно использовать для получения размера файла в байтах:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Storage</span><span
                class="token punctuation">;</span>

<span class="token variable">$size</span> <span class="token operator">=</span> Storage<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">size</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'file.jpg'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p><code>lastModified</code> Метод возвращает UNIX временную метку последнего времени файл был изменен:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$time</span> <span
                class="token operator">=</span> Storage<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">lastModified</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'file.jpg'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="file-paths"><a href="#file-paths">Пути к файлам</a></h4>
<p>Вы можете использовать этот <code>path</code> метод, чтобы получить путь к заданному файлу. Если вы используете
    <code>local</code> драйвер, он вернет абсолютный путь к файлу. Если вы используете <code>s3</code> драйвер, этот
    метод вернет относительный путь к файлу в корзине S3:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Storage</span><span
                class="token punctuation">;</span>

<span class="token variable">$path</span> <span class="token operator">=</span> Storage<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">path</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'file.jpg'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="storing-files"><a href="#storing-files">Хранение файлов</a></h2>
<p><code>put</code> Метод может быть использован для хранения содержимого файла на диске. Вы также можете передать PHP
    <code>resource</code> к <code>put</code> методу, который будет использовать основную поддержку потока Flysystem в.
    Помните, что все пути к файлам должны быть указаны относительно «корневого» расположения, настроенного для диска:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Storage</span><span
                class="token punctuation">;</span>

Storage<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">put</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'file.jpg'</span><span
                class="token punctuation">,</span> <span class="token variable">$contents</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

Storage<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">put</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'file.jpg'</span><span
                class="token punctuation">,</span> <span class="token variable">$resource</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="automatic-streaming"><a href="#automatic-streaming">Автоматическая потоковая передача</a></h4>
<p>Потоковая передача файлов в хранилище позволяет значительно сократить использование памяти. Если вы хотите, чтобы
    Laravel автоматически управлял потоковой передачей данного файла в ваше хранилище, вы можете использовать метод
    <code>putFile</code> или <code>putFileAs</code>. Этот метод принимает экземпляр <code>Illuminate\Http\File</code>
    или <code>Illuminate\Http\UploadedFile</code> и автоматически передает файл в желаемое место:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>File</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Storage</span><span
                class="token punctuation">;</span>

<span class="token comment">// Automatically generate a unique ID for filename...</span>
<span class="token variable">$path</span> <span class="token operator">=</span> Storage<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">putFile</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'photos'</span><span
                class="token punctuation">,</span> <span class="token keyword">new</span> <span
                class="token class-name">File</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/path/to/photo'</span><span
                class="token punctuation">)</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>

<span class="token comment">// Manually specify a filename...</span>
<span class="token variable">$path</span> <span class="token operator">=</span> Storage<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">putFileAs</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'photos'</span><span
                class="token punctuation">,</span> <span class="token keyword">new</span> <span
                class="token class-name">File</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/path/to/photo'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'photo.jpg'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Следует отметить несколько важных моментов, касающихся этого <code>putFile</code> метода. Обратите внимание, что мы
    указали только имя каталога, а не имя файла. По умолчанию <code>putFile</code> метод генерирует уникальный
    идентификатор, который будет служить именем файла. Расширение файла будет определено путем проверки MIME-типа файла.
    Путь к файлу будет возвращен <code>putFile</code> методом, поэтому вы можете сохранить путь, включая сгенерированное
    имя файла, в своей базе данных.</p>
<p>В <code>putFile</code> и <code>putFileAs</code> методы также принимают аргумент, чтобы указать «видимость»
    сохраненный файл. Это особенно полезно, если вы храните файл на облачном диске, таком как Amazon S3, и хотите, чтобы
    файл был общедоступным через сгенерированные URL-адреса:</p>
<pre class=" language-php"><code class=" language-php">Storage<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">putFile</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'photos'</span><span
                class="token punctuation">,</span> <span class="token keyword">new</span> <span
                class="token class-name">File</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/path/to/photo'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'public'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="prepending-appending-to-files"><a href="#prepending-appending-to-files">Подготовка и добавление к файлам</a>
</h4>
<p>В <code>prepend</code> и <code>append</code> методы позволяют писать в начало или конец файла:</p>
<pre class=" language-php"><code class=" language-php">Storage<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">prepend</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'file.log'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Prepended Text'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

Storage<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">append</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'file.log'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'Appended Text'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="copying-moving-files"><a href="#copying-moving-files">Копирование и перемещение файлов</a></h4>
<p><code>copy</code> Метод может быть использован для копирования существующего файла в новое место на диске, в то время
    как <code>move</code> метод может быть использован, чтобы переименовать или переместить существующий файл в новое
    место:</p>
<pre class=" language-php"><code class=" language-php">Storage<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">copy</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'old/file.jpg'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'new/file.jpg'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

Storage<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">move</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'old/file.jpg'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'new/file.jpg'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="file-uploads"><a href="#file-uploads">Загрузка файлов</a></h3>
<p>В веб-приложениях одним из наиболее распространенных вариантов использования файлов является хранение загруженных
    пользователем файлов, таких как фотографии и документы. Laravel позволяет очень легко хранить загруженные файлы,
    используя <code>store</code> метод для экземпляра загруженного файла. Вызовите <code>store</code> метод с путем, по
    которому вы хотите сохранить загруженный файл:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>Controller</span><span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">UserAvatarController</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Update the avatar for the user.
    *
    * @param  \Illuminate\Http\Request  $request
    * @return \Illuminate\Http\Response
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">update</span><span
                    class="token punctuation">(</span>Request <span class="token variable">$request</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$path</span> <span class="token operator">=</span> <span class="token variable">$request</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">file</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'avatar'</span><span
                    class="token punctuation">)</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                    class="token function">store</span><span class="token punctuation">(</span><span
                    class="token single-quoted-string string">'avatars'</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>

        <span class="token keyword">return</span> <span class="token variable">$path</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>В этом примере следует отметить несколько важных моментов. Обратите внимание, что мы указали только имя каталога, а
    не имя файла. По умолчанию <code>store</code> метод генерирует уникальный идентификатор, который будет служить
    именем файла. Расширение файла будет определено путем проверки MIME-типа файла. Путь к файлу будет возвращен <code>store</code>
    методом, поэтому вы можете сохранить путь, включая сгенерированное имя файла, в своей базе данных.</p>
<p>Вы также можете вызвать <code>putFile</code> метод на <code>Storage</code> фасаде, чтобы выполнить ту же операцию
    хранения файлов, что и в примере выше:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$path</span> <span
                class="token operator">=</span> Storage<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">putFile</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'avatars'</span><span
                class="token punctuation">,</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">file</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'avatar'</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="specifying-a-file-name"><a href="#specifying-a-file-name">Указание имени файла</a></h4>
<p>Если вы не хотите, чтобы имя файла автоматически присваивалось вашему сохраненному файлу, вы можете использовать
    <code>storeAs</code> метод, который получает путь, имя файла и (необязательный) диск в качестве аргументов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$path</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">file</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'avatar'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">storeAs</span><span
                class="token punctuation">(</span>
    <span class="token single-quoted-string string">'avatars'</span><span class="token punctuation">,</span> <span
                class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">user</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">id</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы также можете использовать <code>putFileAs</code> метод на <code>Storage</code> фасаде, который будет выполнять ту
    же операцию хранения файлов, что и в примере выше:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$path</span> <span
                class="token operator">=</span> Storage<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">putFileAs</span><span
                class="token punctuation">(</span>
    <span class="token single-quoted-string string">'avatars'</span><span class="token punctuation">,</span> <span
                class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">file</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'avatar'</span><span class="token punctuation">)</span><span
                class="token punctuation">,</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">user</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">id</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Непечатаемые и недопустимые символы Unicode будут автоматически удалены из путей к файлам. Следовательно, вы
            можете очистить пути к файлам перед их передачей в методы хранения файлов Laravel. Пути к файлам
            нормализованы с помощью <code>League\Flysystem\Util::normalizePath</code> метода.</p></p></div>
</blockquote>
<p></p>
<h4 id="specifying-a-disk"><a href="#specifying-a-disk">Указание диска</a></h4>
<p>По умолчанию <code>store</code> метод этого загруженного файла будет использовать ваш диск по умолчанию. Если вы
    хотите указать другой диск, передайте имя диска в качестве второго аргумента <code>store</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$path</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">file</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'avatar'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">store</span><span
                class="token punctuation">(</span>
    <span class="token single-quoted-string string">'avatars/'</span><span class="token punctuation">.</span><span
                class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">user</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token property">id</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'s3'</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если вы используете <code>storeAs</code> метод, вы можете передать имя диска в качестве третьего аргумента метода:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$path</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">file</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'avatar'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">storeAs</span><span
                class="token punctuation">(</span>
    <span class="token single-quoted-string string">'avatars'</span><span class="token punctuation">,</span>
    <span class="token variable">$request</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">user</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'s3'</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="other-uploaded-file-information"><a href="#other-uploaded-file-information">Другая информация о загруженном
        файле</a></h4>
<p>Если вы хотите получить исходное имя загруженного файла, вы можете сделать это с помощью
    <code>getClientOriginalName</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$name</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">file</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'avatar'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">getClientOriginalName</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p><code>extension</code> Метод может быть использован, чтобы получить расширение файла загруженного файла:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$extension</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">file</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'avatar'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">extension</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="file-visibility"><a href="#file-visibility">Видимость файла</a></h3>
<p>В интеграции Laravel с Flysystem «видимость» - это абстракция прав доступа к файлам на нескольких платформах. Файлы
    могут быть объявлены <code>public</code> либо <code>private</code>. Когда файл объявляется <code>public</code>, вы
    указываете, что файл должен быть доступен другим. Например, при использовании драйвера S3 вы можете получать
    URL-адреса <code>public</code> файлов.</p>
<p>Вы можете установить видимость при записи файла с помощью <code>put</code> метода:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Storage</span><span
                class="token punctuation">;</span>

Storage<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">put</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'file.jpg'</span><span
                class="token punctuation">,</span> <span class="token variable">$contents</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'public'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если файл уже был сохранен, его видимость может быть получена и установить с помощью <code>getVisibility</code> и
    <code>setVisibility</code> методов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$visibility</span> <span
                class="token operator">=</span> Storage<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">getVisibility</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'file.jpg'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

Storage<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">setVisibility</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'file.jpg'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'public'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>При взаимодействии с загруженными файлами, вы можете использовать <code>storePublicly</code> и
    <code>storePubliclyAs</code> методы, чтобы сохранить загруженный файл с <code>public</code> видимостью:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$path</span> <span
                class="token operator">=</span> <span class="token variable">$request</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">file</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'avatar'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">storePublicly</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'avatars'</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'s3'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$path</span> <span class="token operator">=</span> <span
                class="token variable">$request</span><span class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token function">file</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'avatar'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">storePubliclyAs</span><span
                class="token punctuation">(</span>
    <span class="token single-quoted-string string">'avatars'</span><span class="token punctuation">,</span>
    <span class="token variable">$request</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">user</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span
                class="token property">id</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'s3'</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="local-files-and-visibility"><a href="#local-files-and-visibility">Локальные файлы и видимость</a></h4>
<p>При использовании <code>local</code> драйвера <code>public</code> <a href="filesystem#file-visibility">видимость</a>
    преобразуется в <code>0755</code> разрешения для каталогов и <code>0644</code> разрешения для файлов. Вы можете
    изменить сопоставления разрешений в <code>filesystems</code> файле конфигурации вашего приложения:</p>
<pre class=" language-php"><code class=" language-php"><span
                class="token single-quoted-string string">'local'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'driver'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'local'</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'root'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token function">storage_path</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'app'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token single-quoted-string string">'permissions'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'file'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
            <span class="token single-quoted-string string">'public'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">0664</span><span
                class="token punctuation">,</span>
            <span class="token single-quoted-string string">'private'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">0600</span><span
                class="token punctuation">,</span>
        <span class="token punctuation">]</span><span class="token punctuation">,</span>
        <span class="token single-quoted-string string">'dir'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token punctuation">[</span>
            <span class="token single-quoted-string string">'public'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">0775</span><span
                class="token punctuation">,</span>
            <span class="token single-quoted-string string">'private'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token number">0700</span><span
                class="token punctuation">,</span>
        <span class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p></p>
<h2 id="deleting-files"><a href="#deleting-files">Удаление файлов</a></h2>
<p><code>delete</code> Метод принимает один имя файла или массив удаляемых файлов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Storage</span><span
                class="token punctuation">;</span>

Storage<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">delete</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'file.jpg'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

Storage<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">delete</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'file.jpg'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'file2.jpg'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>При необходимости вы можете указать диск, с которого следует удалить файл:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Storage</span><span
                class="token punctuation">;</span>

Storage<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">disk</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'s3'</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">delete</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'path/file.jpg'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="directories"><a href="#directories">Справочники</a></h2>
<p></p>
<h4 id="get-all-files-within-a-directory"><a href="#get-all-files-within-a-directory">Получить все файлы в каталоге</a>
</h4>
<p><code>files</code> Метод возвращает массив всех файлов в заданном каталоге. Если вы хотите получить список всех
    файлов в данном каталоге, включая все подкаталоги, вы можете использовать <code>allFiles</code> метод:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                    class="token punctuation">\</span>Facades<span class="token punctuation">\</span>Storage</span><span
                class="token punctuation">;</span>

<span class="token variable">$files</span> <span class="token operator">=</span> Storage<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">files</span><span
                class="token punctuation">(</span><span class="token variable">$directory</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$files</span> <span class="token operator">=</span> Storage<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">allFiles</span><span
                class="token punctuation">(</span><span class="token variable">$directory</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="get-all-directories-within-a-directory"><a href="#get-all-directories-within-a-directory">Получить все каталоги
        в каталоге</a></h4>
<p><code>directories</code> Метод возвращает массив всех каталогов в данном каталоге. Кроме того, вы можете использовать
    этот <code>allDirectories</code> метод для получения списка всех каталогов в данном каталоге и всех его
    подкаталогах:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$directories</span> <span
                class="token operator">=</span> Storage<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">directories</span><span
                class="token punctuation">(</span><span class="token variable">$directory</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token variable">$directories</span> <span class="token operator">=</span> Storage<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">allDirectories</span><span
                class="token punctuation">(</span><span class="token variable">$directory</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="create-a-directory"><a href="#create-a-directory">Создать каталог</a></h4>
<p><code>makeDirectory</code> Метод создания данного каталога, включая все необходимые подкаталоги:</p>
<pre class=" language-php"><code class=" language-php">Storage<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">makeDirectory</span><span
                class="token punctuation">(</span><span class="token variable">$directory</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="delete-a-directory"><a href="#delete-a-directory">Удалить каталог</a></h4>
<p>Наконец, этот <code>deleteDirectory</code> метод можно использовать для удаления каталога и всех его файлов:</p>
<pre class=" language-php"><code class=" language-php">Storage<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">deleteDirectory</span><span
                class="token punctuation">(</span><span class="token variable">$directory</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="custom-filesystems"><a href="#custom-filesystems">Пользовательские файловые системы</a></h2>
<p>Интеграция Laravel с Flysystem обеспечивает поддержку нескольких «драйверов» из коробки; однако Flysystem этим не
    ограничивается и имеет адаптеры для многих других систем хранения. Вы можете создать собственный драйвер, если
    хотите использовать один из этих дополнительных адаптеров в своем приложении Laravel.</p>
<p>Чтобы определить собственную файловую систему, вам понадобится адаптер Flysystem. Давайте добавим в наш проект
    адаптер Dropbox, поддерживаемый сообществом:</p>
<pre class=" language-php"><code class=" language-php">composer <span class="token keyword">require</span> spatie<span
                class="token operator">/</span>flysystem<span class="token operator">-</span>dropbox</code></pre>
<p>Затем вы можете зарегистрировать драйвер с помощью <code>boot</code> метода одного из <a href="providers">поставщиков
        услуг</a> вашего приложения. Для этого следует использовать <code>extend</code> метод <code>Storage</code>
    фасада:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Providers</span><span
                    class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>Facades<span
                        class="token punctuation">\</span>Storage</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Support<span
                        class="token punctuation">\</span>ServiceProvider</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">League<span class="token punctuation">\</span>Flysystem<span
                        class="token punctuation">\</span>Filesystem</span><span class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Spatie<span class="token punctuation">\</span>Dropbox<span
                        class="token punctuation">\</span>Client</span> <span class="token keyword">as</span> DropboxClient<span
                    class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">Spatie<span class="token punctuation">\</span>FlysystemDropbox<span
                        class="token punctuation">\</span>DropboxAdapter</span><span class="token punctuation">;</span>

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
        Storage<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">extend</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'dropbox'</span><span
                    class="token punctuation">,</span> <span class="token keyword">function</span> <span
                    class="token punctuation">(</span><span class="token variable">$app</span><span
                    class="token punctuation">,</span> <span class="token variable">$config</span><span
                    class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
            <span class="token variable">$client</span> <span class="token operator">=</span> <span
                    class="token keyword">new</span> <span class="token class-name">DropboxClient</span><span
                    class="token punctuation">(</span>
                <span class="token variable">$config</span><span class="token punctuation">[</span><span
                    class="token single-quoted-string string">'authorization_token'</span><span
                    class="token punctuation">]</span>
            <span class="token punctuation">)</span><span class="token punctuation">;</span>

            <span class="token keyword">return</span> <span class="token keyword">new</span> <span class="token class-name">Filesystem</span><span
                    class="token punctuation">(</span><span class="token keyword">new</span> <span
                    class="token class-name">DropboxAdapter</span><span class="token punctuation">(</span><span
                    class="token variable">$client</span><span class="token punctuation">)</span><span
                    class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Первый аргумент <code>extend</code> метода является имя драйвера, а второй является замыканием, который принимает
    <code>$app</code> и <code>$config</code> переменные. Замыкание должно возвращать экземпляр <code>League\Flysystem\Filesystem</code>.
    <code>$config</code> Переменные содержит значение, определенное в <code>config/filesystems.php</code> течение
    указанного диска.</p>
<p>После того, как вы создали и зарегистрировали поставщика услуг расширения, вы можете использовать
    <code>dropbox</code> драйвер в своем <code>config/filesystems.php</code> файле конфигурации.</p>
