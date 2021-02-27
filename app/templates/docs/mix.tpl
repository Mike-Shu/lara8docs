<h1>Компиляция ассетов (Mix)</h1>
<ul>
    <li><a href="mix#introduction">Вступление</a></li>
    <li><a href="mix#installation">Установка и настройка</a></li>
    <li><a href="mix#running-mix">Запуск Mix</a></li>
    <li><a href="mix#working-with-stylesheets">Работа с таблицами стилей</a>
        <ul>
            <li><a href="mix#tailwindcss">Tailwind CSS</a></li>
            <li><a href="mix#postcss">PostCSS</a></li>
            <li><a href="mix#sass">Sass</a></li>
            <li><a href="mix#url-processing">Обработка URL</a></li>
            <li><a href="mix#css-source-maps">Исходные карты</a></li>
        </ul>
    </li>
    <li><a href="mix#working-with-scripts">Работа с JavaScript</a>
        <ul>
            <li><a href="mix#vue">Vue</a></li>
            <li><a href="mix#react">React</a></li>
            <li><a href="mix#vendor-extraction">Извлечение поставщика</a></li>
            <li><a href="mix#custom-webpack-configuration">Пользовательская конфигурация Webpack</a></li>
        </ul>
    </li>
    <li><a href="mix#versioning-and-cache-busting">Управление версиями / очистка кеша</a></li>
    <li><a href="mix#browsersync-reloading">Browsersync Reloading</a></li>
    <li><a href="mix#environment-variables">Переменные среды</a></li>
    <li><a href="mix#notifications">Уведомления</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p><a href="https://github.com/JeffreyWay/laravel-mix">Laravel Mix</a>, пакет, разработанный создателем <a
            href="https://laracasts.com">Laracasts</a> Джеффри <a href="https://laracasts.com">Уэем</a>, предоставляет
    свободный API для определения <a href="https://webpack.js.org">шагов</a> сборки <a href="https://webpack.js.org">веб-пакетов</a>
    для вашего приложения Laravel с использованием нескольких распространенных препроцессоров CSS и JavaScript.</p>
<p>Другими словами, Mix упрощает компиляцию и минимизацию файлов CSS и JavaScript вашего приложения. Посредством
    простого объединения методов вы можете плавно определить конвейер активов. Например:</p>
<pre class=" language-php"><code class=" language-php">mix<span class="token punctuation">.</span><span
                class="token function">js</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'resources/js/app.js'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'public/js'</span><span class="token punctuation">)</span>
    <span class="token punctuation">.</span><span class="token function">postCss</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'resources/css/app.css'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'public/css'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Если вы когда-либо были сбиты с толку и ошеломлены, начав работать с веб-пакетами и компиляцией ресурсов, вам понравится Laravel Mix. Однако от вас не требуется использовать его при разработке приложения; вы можете использовать любой инструмент конвейера активов, который пожелаете, или даже не использовать его вовсе.</p>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout"><div
                class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div><p class="mb-0 lg:ml-6"><p>Если вам нужно начать создание приложения с помощью Laravel и <a
                    href="https://tailwindcss.com">Tailwind CSS</a>, ознакомьтесь с одним из наших <a
                    href="starter-kits">стартовых наборов приложений</a>.</p></p></div>
</blockquote>
<p></p>
<h2 id="installation"><a href="#installation">Установка и настройка</a></h2>
<p></p>
<h4 id="installing-node"><a href="#installing-node">Установка узла</a></h4>
<p>Перед запуском Mix вы должны сначала убедиться, что на вашем компьютере установлены Node.js и NPM:</p>
<pre class=" language-php"><code class=" language-php">node <span class="token operator">-</span>v
npm <span class="token operator">-</span>v</code></pre>
<p>Вы можете легко установить последнюю версию Node и NPM с помощью простых графических установщиков с <a
            href="https://nodejs.org/en/download/">официального сайта Node</a>. Или, если вы используете <a href="sail">Laravel Sail</a>, вы можете вызвать Node и NPM через Sail:</p>
<pre class=" language-php"><code class=" language-php"><span class="token punctuation">.</span><span
                class="token operator">/</span>sail node <span class="token operator">-</span>v
<span class="token punctuation">.</span><span class="token operator">/</span>sail npm <span
                class="token operator">-</span>v</code></pre>
<p></p>
<h4 id="installing-laravel-mix"><a href="#installing-laravel-mix">Установка Laravel Mix</a></h4>
<p>Единственный оставшийся шаг - установить Laravel Mix. В новой установке Laravel вы найдете <code>package.json</code> файл в корне своей структуры каталогов. <code>package.json</code> Файл по умолчанию уже включает в себя все, что вам нужно, чтобы начать использовать Laravel Mix. Думайте об этом файле как о своем <code>composer.json</code> файле, за исключением того, что он определяет зависимости узла вместо зависимостей PHP. Вы можете установить зависимости, на которые он ссылается, запустив:</p>
<pre class=" language-php"><code class=" language-php">npm install</code></pre>
<p></p>
<h2 id="running-mix"><a href="#running-mix">Бегущий микс</a></h2>
<p>Mix - это уровень конфигурации поверх <a href="https://webpack.js.org">webpack</a>, поэтому для запуска задач Mix вам нужно только выполнить один из сценариев NPM, которые включены в <code>package.json</code> файл Laravel по умолчанию. Когда вы запускаете скрипты <code>dev</code> или <code>production</code>, все ресурсы CSS и JavaScript вашего приложения будут скомпилированы и помещены в <code>public</code> каталог вашего приложения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">// Run all Mix tasks...</span>
npm run dev

<span class="token comment">// Run all Mix tasks and minify output...</span>
npm run prod</code></pre>
<p></p>
<h4 id="watching-assets-for-changes"><a
            href="#watching-assets-for-changes">Наблюдение за активами на предмет изменений</a></h4>
<p>Команда <code>npm run watch</code> будет продолжать работать в вашем терминале и следить за изменениями во всех соответствующих файлах CSS и JavaScript. Webpack автоматически перекомпилирует ваши ресурсы, когда обнаружит изменение в одном из этих файлов:</p>
<pre class=" language-php"><code class=" language-php">npm run watch</code></pre>
<p>Webpack может не обнаруживать изменения ваших файлов в определенных локальных средах разработки. Если это так в вашей системе, рассмотрите возможность использования <code>watch-poll</code> команды:</p>
<pre class=" language-php"><code class=" language-php">npm run watch<span class="token operator">-</span>poll</code></pre>
<p></p>
<h2 id="working-with-stylesheets"><a href="#working-with-stylesheets">Работа с таблицами стилей</a></h2>
<p><code>webpack.mix.js</code> Файл вашего приложения является отправной точкой для компиляции всех ресурсов. Думайте об этом как о легкой <a
            href="https://webpack.js.org">оболочке</a> конфигурации вокруг <a href="https://webpack.js.org">webpack</a>. Задачи смешивания можно объединить в цепочку, чтобы точно определить, как должны компилироваться ваши ресурсы.</p>
<p></p>
<h3 id="tailwindcss"><a href="#tailwindcss">Tailwind CSS</a></h3>
<p><a href="https://tailwindcss.com">Tailwind CSS</a> - это современная, <a href="https://tailwindcss.com">ориентированная</a> на полезность фреймворк для создания потрясающих сайтов, не покидая своего HTML. Давайте рассмотрим, как начать использовать его в проекте Laravel с Laravel Mix. Во-первых, мы должны установить Tailwind с помощью NPM и сгенерировать наш файл конфигурации Tailwind:</p>
<pre class=" language-php"><code class=" language-php">npm install

npm install <span class="token operator">-</span><span class="token constant">D</span> tailwindcss

npx tailwindcss init</code></pre>
<p>Команда <code>init</code> сгенерирует <code>tailwind.config.js</code> файл. В этом файле вы можете настроить пути ко всем шаблонам вашего приложения и JavaScript, чтобы Tailwind мог изменять неиспользуемые стили при оптимизации CSS для производства:</p>
<pre class=" language-js"><code class=" language-js">purge<span class="token operator">:</span> <span
                class="token punctuation">[</span>
    <span class="token string">'./storage/framework/views/*.php'</span><span class="token punctuation">,</span>
    <span class="token string">'./resources/**/*.blade.php'</span><span class="token punctuation">,</span>
    <span class="token string">'./resources/**/*.js'</span><span class="token punctuation">,</span>
    <span class="token string">'./resources/**/*.vue'</span><span class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">,</span></code></pre>
<p>Затем вы должны добавить каждый из «слоев» Tailwind в <code>resources/css/app.css</code> файл вашего приложения:</p>
<pre class=" language-css"><code class=" language-css"><span class="token atrule"><span
                    class="token rule">@tailwind</span> base<span class="token punctuation">;</span></span>
<span class="token atrule"><span class="token rule">@tailwind</span> components<span class="token punctuation">;</span></span>
<span class="token atrule"><span class="token rule">@tailwind</span> utilities<span
            class="token punctuation">;</span></span></code></pre>
<p>После того, как вы настроили слои Tailwind, вы готовы обновить <code>webpack.mix.js</code> файл своего приложения, чтобы скомпилировать CSS на основе Tailwind:</p>
<pre class=" language-js"><code class=" language-js">mix<span class="token punctuation">.</span><span
                class="token function">js</span><span class="token punctuation">(</span><span class="token string">'resources/js/app.js'</span><span
                class="token punctuation">,</span> <span class="token string">'public/js'</span><span
                class="token punctuation">)</span>
    <span class="token punctuation">.</span><span class="token function">postCss</span><span
                class="token punctuation">(</span><span class="token string">'resources/css/app.css'</span><span
                class="token punctuation">,</span> <span class="token string">'public/css'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
        <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'tailwindcss'</span><span
                class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Наконец, вы должны указать свою таблицу стилей в основном шаблоне макета вашего приложения. Многие приложения предпочитают хранить этот шаблон в <code>resources/views/layouts/app.blade.php</code>. Кроме того, убедитесь, что вы добавили <code>meta</code> тег адаптивного окна просмотра, если он еще не присутствует:</p>
<pre class=" language-html"><code class=" language-html"><span class="token tag"><span class="token tag"><span
                        class="token punctuation">&lt;</span>head</span><span
                    class="token punctuation">&gt;</span></span>
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>meta</span> <span
                class="token attr-name">charset</span><span class="token attr-value"><span
                    class="token punctuation attr-equals">=</span><span class="token punctuation">"</span>UTF-8<span
                    class="token punctuation">"</span></span> <span class="token punctuation">/&gt;</span></span>
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>meta</span> <span
                class="token attr-name">name</span><span class="token attr-value"><span
                    class="token punctuation attr-equals">=</span><span class="token punctuation">"</span>viewport<span
                    class="token punctuation">"</span></span> <span class="token attr-name">content</span><span
                class="token attr-value"><span class="token punctuation attr-equals">=</span><span
                    class="token punctuation">"</span>width=device-width, initial-scale=1.0<span
                    class="token punctuation">"</span></span> <span class="token punctuation">/&gt;</span></span>
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>link</span> <span
                class="token attr-name">href</span><span class="token attr-value"><span
                    class="token punctuation attr-equals">=</span><span
                    class="token punctuation">"</span>/css/app.css<span class="token punctuation">"</span></span> <span
                class="token attr-name">rel</span><span class="token attr-value"><span
                    class="token punctuation attr-equals">=</span><span
                    class="token punctuation">"</span>stylesheet<span class="token punctuation">"</span></span><span
                class="token punctuation">&gt;</span></span>
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>head</span><span
            class="token punctuation">&gt;</span></span></code></pre>
<p></p>
<h3 id="postcss"><a href="#postcss">PostCSS</a></h3>
<p><a href="https://postcss.org/">PostCSS</a>, мощный инструмент для преобразования вашего CSS, включен в Laravel Mix из коробки. По умолчанию Mix использует популярный плагин <a
            href="https://github.com/postcss/autoprefixer">Autoprefixer</a> для автоматического применения всех необходимых префиксов поставщиков CSS3. Однако вы можете добавлять любые дополнительные плагины, подходящие для вашего приложения.</p>
<p>Сначала установите нужный плагин через NPM и включите его в свой массив плагинов при вызове <code>postCss</code> метода Mix. <code>postCss</code> Метод принимает путь к файлу CSS в качестве первого аргумента и каталога, в котором скомпилированный файл должен быть помещен в качестве второго аргумента:</p>
<pre class=" language-php"><code class=" language-php">mix<span class="token punctuation">.</span><span
                class="token function">postCss</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'resources/css/app.css'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'public/css'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>
    <span class="token keyword">require</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'postcss-custom-properties'</span><span
                class="token punctuation">)</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Или вы можете выполнить <code>postCss</code> без дополнительных плагинов, чтобы добиться простой компиляции и минификации CSS:</p>
<pre class=" language-php"><code class=" language-php">mix<span class="token punctuation">.</span><span
                class="token function">postCss</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'resources/css/app.css'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'public/css'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="sass"><a href="#sass">Sass</a></h3>
<p>Этот <code>sass</code> метод позволяет вам скомпилировать <a href="https://sass-lang.com/">Sass</a> в CSS, понятный веб-браузерам. <code>sass</code> Метод принимает путь к файлу Сасс в качестве первого аргумента и каталог, в котором скомпилированный файл должен быть помещен в качестве второго аргумента:</p>
<pre class=" language-php"><code class=" language-php">mix<span class="token punctuation">.</span><span
                class="token function">sass</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'resources/sass/app.scss'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'public/css'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете скомпилировать несколько файлов Sass в их собственные соответствующие файлы CSS и даже настроить выходной каталог результирующего CSS, вызвав <code>sass</code> метод несколько раз:</p>
<pre class=" language-php"><code class=" language-php">mix<span class="token punctuation">.</span><span
                class="token function">sass</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'resources/sass/app.sass'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'public/css'</span><span class="token punctuation">)</span>
    <span class="token punctuation">.</span><span class="token function">sass</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'resources/sass/admin.sass'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'public/css/admin'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="url-processing"><a href="#url-processing">Обработка URL</a></h3>
<p>Поскольку Laravel Mix построен поверх webpack, важно понимать несколько концепций webpack. Для компиляции CSS webpack перезапишет и оптимизирует любые <code>url()</code> вызовы в ваших таблицах стилей. Хотя поначалу это может показаться странным, это невероятно мощная функциональность. Представьте, что мы хотим скомпилировать Sass, который включает относительный URL-адрес изображения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token punctuation">.</span>example <span
                class="token punctuation">{literal}{{/literal}</span>
    background<span class="token punctuation">:</span> <span class="token function">url</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'../images/example.png'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<blockquote>
    <div class="mb-10 mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout"><div
                class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-red-600 lg:mb-0"><img
                    src="/img/callouts/exclamation.min.svg" class="opacity-75"></div><p class="mb-0 lg:ml-6"><p>Абсолютные пути для любого заданного <code>url()</code> будут исключены из перезаписи URL. Например, <code>url('/images/thing.png')</code> или <code>url('http://example.com/images/thing.png')</code> не будут изменены.</p></p></div>
</blockquote>
<p>По умолчанию Laravel Mix и webpack найдут <code>example.png</code>, скопируют его в вашу <code>public/images</code> папку, а затем перезапишут <code>url()</code> в созданной вами таблице стилей. Таким образом, ваш скомпилированный CSS будет:</p>
<pre class=" language-php"><code class=" language-php"><span class="token punctuation">.</span>example <span
                class="token punctuation">{literal}{{/literal}</span>
    background<span class="token punctuation">:</span> <span class="token function">url</span><span
                class="token punctuation">(</span><span class="token operator">/</span>images<span
                class="token operator">/</span>example<span class="token punctuation">.</span>png<span
                class="token operator">?</span>d41d8cd98f00b204e9800998ecf8427e<span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p>Какой бы полезной ни была эта функция, ваша существующая структура папок может быть уже настроена так, как вам нравится. В этом случае вы можете отключить <code>url()</code> перезапись следующим образом:</p>
<pre class=" language-php"><code class=" language-php">mix<span class="token punctuation">.</span><span
                class="token function">sass</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'resources/sass/app.scss'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'public/css'</span><span
                class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">options</span><span
                class="token punctuation">(</span><span class="token punctuation">{literal}{{/literal}</span>
    processCssUrls<span class="token punctuation">:</span> <span class="token boolean constant">false</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>С этим добавлением к вашему <code>webpack.mix.js</code> файлу Mix больше не будет сопоставлять <code>url()</code> или копировать ресурсы в ваш общедоступный каталог. Другими словами, скомпилированный CSS будет выглядеть так же, как вы его изначально набрали:</p>
<pre class=" language-php"><code class=" language-php"><span class="token punctuation">.</span>example <span
                class="token punctuation">{literal}{{/literal}</span>
    background<span class="token punctuation">:</span> <span class="token function">url</span><span
                class="token punctuation">(</span><span
                class="token double-quoted-string string">"../images/thing.png"</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="css-source-maps"><a href="#css-source-maps">Исходные карты</a></h3>
<p>Хотя исходные карты отключены по умолчанию, их можно активировать, вызвав <code>mix.sourceMaps()</code> метод в вашем <code>webpack.mix.js</code> файле. Хотя это связано с затратами на компиляцию / производительность, это предоставит дополнительную отладочную информацию для инструментов разработчика вашего браузера при использовании скомпилированных ресурсов:</p>
<pre class=" language-php"><code class=" language-php">mix<span class="token punctuation">.</span><span
                class="token function">js</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'resources/js/app.js'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'public/js'</span><span class="token punctuation">)</span>
    <span class="token punctuation">.</span><span class="token function">sourceMaps</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="style-of-source-mapping"><a href="#style-of-source-mapping">Стиль сопоставления источников</a></h4>
<p>Webpack предлагает множество <a href="https://webpack.js.org/configuration/devtool/%23devtool">стилей сопоставления источников</a>. По умолчанию для стиля сопоставления источника Mix установлено значение <code>eval-source-map</code>, что обеспечивает быстрое восстановление. Если вы хотите изменить стиль сопоставления, вы можете сделать это с помощью <code>sourceMaps</code> метода:</p>
<pre class=" language-php"><code class=" language-php">let productionSourceMaps <span
                class="token operator">=</span> <span class="token boolean constant">false</span><span
                class="token punctuation">;</span>

mix<span class="token punctuation">.</span><span class="token function">js</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'resources/js/app.js'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'public/js'</span><span class="token punctuation">)</span>
    <span class="token punctuation">.</span><span class="token function">sourceMaps</span><span
                class="token punctuation">(</span>productionSourceMaps<span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'source-map'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="working-with-scripts"><a href="#working-with-scripts">Работа с JavaScript</a></h2>
<p>Mix предоставляет несколько функций, которые помогут вам работать с вашими файлами JavaScript, такими как компиляция современного ECMAScript, объединение модулей, минификация и объединение простых файлов JavaScript. Более того, все это работает без проблем, не требуя ни унции специальной конфигурации:</p>
<pre class=" language-php"><code class=" language-php">mix<span class="token punctuation">.</span><span
                class="token function">js</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'resources/js/app.js'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'public/js'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>С помощью этой единственной строчки кода теперь вы можете воспользоваться следующими преимуществами:</p>
<div class="content-list">
    <ul>
        <li>Последний синтаксис EcmaScript.</li>
        <li>Модули</li>
        <li>Минификация для производственных сред.</li>
    </ul>
</div>
<p></p>
<h3 id="vue"><a href="#vue">Vue</a></h3>
<p>Mix автоматически установит плагины Babel, необходимые для поддержки компиляции однофайловых компонентов Vue при использовании этого <code>vue</code> метода. Никакой дополнительной настройки не требуется:</p>
<pre class=" language-php"><code class=" language-php">mix<span class="token punctuation">.</span><span
                class="token function">js</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'resources/js/app.js'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'public/js'</span><span class="token punctuation">)</span>
   <span class="token punctuation">.</span><span class="token function">vue</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>После того, как ваш JavaScript скомпилирован, вы можете ссылаться на него в своем приложении:</p>
<pre class=" language-html"><code class=" language-html"><span class="token tag"><span class="token tag"><span
                        class="token punctuation">&lt;</span>head</span><span
                    class="token punctuation">&gt;</span></span>
    <span class="token comment">&lt;!--... --&gt;</span>

    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>script</span> <span
                class="token attr-name">src</span><span class="token attr-value"><span
                    class="token punctuation attr-equals">=</span><span
                    class="token punctuation">"</span>/js/app.js<span class="token punctuation">"</span></span><span
                class="token punctuation">&gt;</span></span><span class="token script"></span><span
                class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>script</span><span
                    class="token punctuation">&gt;</span></span>
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>head</span><span
            class="token punctuation">&gt;</span></span></code></pre>
<p></p>
<h3 id="react"><a href="#react">React</a></h3>
<p>Mix может автоматически устанавливать плагины Babel, необходимые для поддержки React. Для начала добавьте вызов <code>react</code> метода:</p>
<pre class=" language-php"><code class=" language-php">mix<span class="token punctuation">.</span><span
                class="token function">js</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'resources/js/app.jsx'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'public/js'</span><span class="token punctuation">)</span>
   <span class="token punctuation">.</span><span class="token function">react</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>За кулисами Mix загрузит и включит соответствующий <code>babel-preset-react</code> плагин Babel. После того, как ваш JavaScript скомпилирован, вы можете ссылаться на него в своем приложении:</p>
<pre class=" language-html"><code class=" language-html"><span class="token tag"><span class="token tag"><span
                        class="token punctuation">&lt;</span>head</span><span
                    class="token punctuation">&gt;</span></span>
    <span class="token comment">&lt;!--... --&gt;</span>

    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>script</span> <span
                class="token attr-name">src</span><span class="token attr-value"><span
                    class="token punctuation attr-equals">=</span><span
                    class="token punctuation">"</span>/js/app.js<span class="token punctuation">"</span></span><span
                class="token punctuation">&gt;</span></span><span class="token script"></span><span
                class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>script</span><span
                    class="token punctuation">&gt;</span></span>
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>head</span><span
            class="token punctuation">&gt;</span></span></code></pre>
<p></p>
<h3 id="vendor-extraction"><a href="#vendor-extraction">Извлечение поставщика</a></h3>
<p>Одним из потенциальных недостатков объединения всего кода JavaScript для конкретного приложения с библиотеками поставщика, такими как React и Vue, является то, что это затрудняет долгосрочное кэширование. Например, одно обновление кода вашего приложения заставит браузер повторно загрузить все библиотеки вашего поставщика, даже если они не изменились.</p>
<p>Если вы намереваетесь часто обновлять JavaScript своего приложения, вам следует рассмотреть возможность извлечения всех библиотек вашего поставщика в их собственный файл. Таким образом, изменение кода вашего приложения не повлияет на кеширование вашего большого <code>vendor.js</code> файла. <code>extract</code> Метод Mix делает это проще простого:</p>
<pre class=" language-php"><code class=" language-php">mix<span class="token punctuation">.</span><span
                class="token function">js</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'resources/js/app.js'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'public/js'</span><span class="token punctuation">)</span>
    <span class="token punctuation">.</span><span class="token function">extract</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span><span
                class="token single-quoted-string string">'vue'</span><span class="token punctuation">]</span><span
                class="token punctuation">)</span></code></pre>
<p><code>extract</code> Метод принимает массив из всех библиотек или модулей, которые вы хотите извлечь в <code>vendor.js</code> файл. Используя приведенный выше фрагмент в качестве примера, Mix сгенерирует следующие файлы:</p>
<div class="content-list">
    <ul>
        <li><code>public/js/manifest.js</code>: <em>Среда выполнения манифеста Webpack</em></li>
        <li><code>public/js/vendor.js</code>: <em>Библиотеки вашего поставщика</em></li>
        <li><code>public/js/app.js</code>: <em>Код вашего приложения</em></li>
    </ul>
</div>
<p>Чтобы избежать ошибок JavaScript, обязательно загружайте эти файлы в правильном порядке:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>script src<span
                class="token operator">=</span><span
                class="token double-quoted-string string">"/js/manifest.js"</span><span
                class="token operator">&gt;</span><span class="token operator">&lt;</span><span
                class="token operator">/</span>script<span class="token operator">&gt;</span>
<span class="token operator">&lt;</span>script src<span class="token operator">=</span><span
                class="token double-quoted-string string">"/js/vendor.js"</span><span class="token operator">&gt;</span><span
                class="token operator">&lt;</span><span class="token operator">/</span>script<span
                class="token operator">&gt;</span>
<span class="token operator">&lt;</span>script src<span class="token operator">=</span><span
                class="token double-quoted-string string">"/js/app.js"</span><span
                class="token operator">&gt;</span><span class="token operator">&lt;</span><span
                class="token operator">/</span>script<span class="token operator">&gt;</span></code></pre>
<p></p>
<h3 id="custom-webpack-configuration"><a href="#custom-webpack-configuration">Пользовательская конфигурация Webpack</a></h3>
<p>Иногда вам может потребоваться вручную изменить базовую конфигурацию Webpack. Например, у вас может быть специальный загрузчик или плагин, на который нужно сослаться.</p>
<p>Mix предоставляет полезный <code>webpackConfig</code> метод, который позволяет объединить любые короткие переопределения конфигурации Webpack. Это особенно привлекательно, поскольку не требует от вас копирования и сохранения вашей собственной копии <code>webpack.config.js</code> файла. <code>webpackConfig</code> Метод принимает объект, который должен содержать любую <a
            href="https://webpack.js.org/configuration/">конфигурацию Webpack специфичной</a>, которые вы хотите применить.</p>
<pre class=" language-php"><code class=" language-php">mix<span class="token punctuation">.</span><span
                class="token function">webpackConfig</span><span class="token punctuation">(</span><span
                class="token punctuation">{literal}{{/literal}</span>
    resolve<span class="token punctuation">:</span> <span class="token punctuation">{literal}{{/literal}</span>
        modules<span class="token punctuation">:</span> <span class="token punctuation">[</span>
            path<span class="token punctuation">.</span><span class="token function">resolve</span><span
                class="token punctuation">(</span>__dirname<span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'vendor/laravel/spark/resources/assets/js'</span><span
                class="token punctuation">)</span>
        <span class="token punctuation">]</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="versioning-and-cache-busting"><a
            href="#versioning-and-cache-busting">Управление версиями / очистка кеша</a></h2>
<p>Многие разработчики дополняют свои скомпилированные ресурсы меткой времени или уникальным токеном, чтобы заставить браузеры загружать свежие ресурсы вместо обслуживания устаревших копий кода. Mix может автоматически справиться с этим за вас с помощью <code>version</code> метода.</p>
<p>Этот <code>version</code> метод добавит уникальный хэш к именам файлов всех скомпилированных файлов, что позволит более удобно очистить кеш:</p>
<pre class=" language-php"><code class=" language-php">mix<span class="token punctuation">.</span><span
                class="token function">js</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'resources/js/app.js'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'public/js'</span><span class="token punctuation">)</span>
    <span class="token punctuation">.</span><span class="token function">version</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>После создания версионного файла вы не узнаете точное имя файла. Итак, вы должны использовать глобальную <code>mix</code> функцию Laravel в своих <a
            href="views">представлениях</a> для загрузки соответствующим образом хешированного ресурса. <code>mix</code> Функция будет автоматически определять текущее имя хэшированного файла:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">&lt;</span>script src<span
                class="token operator">=</span><span
                class="token double-quoted-string string">"{literal}{{ mix('/js/app.js') }}{/literal}"</span><span class="token operator">&gt;</span><span
                class="token operator">&lt;</span><span class="token operator">/</span>script<span
                class="token operator">&gt;</span></code></pre>
<p>Поскольку файлы с контролем версий обычно не нужны при разработке, вы можете указать, чтобы процесс управления версиями выполнялся только во время <code>npm run prod</code>:</p>
<pre class=" language-php"><code class=" language-php">mix<span class="token punctuation">.</span><span
                class="token function">js</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'resources/js/app.js'</span><span
                class="token punctuation">,</span> <span
                class="token single-quoted-string string">'public/js'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">if</span> <span class="token punctuation">(</span>mix<span
                class="token punctuation">.</span><span class="token function">inProduction</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    mix<span class="token punctuation">.</span><span class="token function">version</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
<span class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="custom-mix-base-urls"><a href="#custom-mix-base-urls">Пользовательские базовые URL-адреса Mix</a></h4>
<p>Если ваши скомпилированные ресурсы Mix развернуты в CDN отдельно от вашего приложения, вам нужно будет изменить базовый URL-адрес, сгенерированный <code>mix</code> функцией. Вы можете сделать это, добавив <code>mix_url</code> параметр <code>config/app.php</code> конфигурации в файл конфигурации вашего приложения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token single-quoted-string string">'mix_url'</span> <span
                class="token operator">=</span><span class="token operator">&gt;</span> <span
                class="token function">env</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'MIX_ASSET_URL'</span><span class="token punctuation">,</span> <span
                class="token constant">null</span><span class="token punctuation">)</span></code></pre>
<p>После настройки URL-адреса Mix, <code>mix</code> функция будет префикс настроенного URL-адреса при создании URL-адресов для ресурсов:</p>
<pre class=" language-bash"><code class=" language-bash">https://cdn.example.com/js/app.js?id<span
                class="token operator">=</span>1964becbdd96414518cd</code></pre>
<p></p>
<h2 id="browsersync-reloading"><a href="#browsersync-reloading">Browsersync Reloading</a></h2>
<p><a href="https://browsersync.io/">BrowserSync</a> может автоматически отслеживать изменения в файлах и вносить изменения в браузер без необходимости обновления вручную. Вы можете включить поддержку для этого, вызвав <code>mix.browserSync()</code> метод:</p>
<pre class=" language-js"><code class=" language-js">mix<span class="token punctuation">.</span><span
                class="token function">browserSync</span><span class="token punctuation">(</span><span
                class="token string">'laravel.test'</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p><a href="https://browsersync.io/docs/options">Параметры BrowserSync</a> можно указать, передав объект JavaScript в <code>browserSync</code> метод:</p>
<pre class=" language-js"><code class=" language-js">mix<span class="token punctuation">.</span><span
                class="token function">browserSync</span><span class="token punctuation">(</span><span
                class="token punctuation">{literal}{{/literal}</span>
    proxy<span class="token operator">:</span> <span class="token string">'laravel.test'</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Затем запустите сервер разработки webpack с помощью <code>npm run watch</code> команды. Теперь, когда вы изменяете скрипт или файл PHP, вы можете наблюдать, как браузер мгновенно обновляет страницу, чтобы отразить ваши изменения.</p>
<p></p>
<h2 id="environment-variables"><a href="#environment-variables">Переменные среды</a></h2>
<p>Вы можете вставить переменные среды в свой <code>webpack.mix.js</code> скрипт, добавив к одной из переменных среды в вашем <code>.env</code> файле префикс <code>MIX_</code>:</p>
<pre class=" language-php"><code class=" language-php"><span class="token constant">MIX_SENTRY_DSN_PUBLIC</span><span
                class="token operator">=</span>http<span class="token punctuation">:</span><span class="token comment">//example.com</span></code></pre>
<p>После того, как переменная была определена в вашем <code>.env</code> файле, вы можете получить к ней доступ через <code>process.env</code> объект. Однако вам нужно будет перезапустить задачу, если значение переменной среды изменится во время выполнения задачи:</p>
<pre class=" language-php"><code class=" language-php">process<span class="token punctuation">.</span>env<span
                class="token punctuation">.</span><span class="token constant">MIX_SENTRY_DSN_PUBLIC</span></code></pre>
<p></p>
<h2 id="notifications"><a href="#notifications">Уведомления</a></h2>
<p>Когда доступно, Mix будет автоматически отображать уведомления ОС при компиляции, давая вам мгновенную информацию о том, была ли компиляция успешной или нет. Однако могут быть случаи, когда вы предпочтете отключить эти уведомления. Одним из таких примеров может быть запуск Mix на вашем рабочем сервере. Уведомления можно отключить с помощью <code>disableNotifications</code> метода:</p>
<pre class=" language-php"><code class=" language-php">mix<span class="token punctuation">.</span><span
                class="token function">disableNotifications</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
