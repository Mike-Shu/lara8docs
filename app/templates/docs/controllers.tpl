<h1>Контроллеры</h1>
<ul>
    <li><a href="controllers#introduction">Вступление</a></li>
    <li><a href="controllers#writing-controllers">Написание контроллеров</a>
        <ul>
            <li><a href="controllers#basic-controllers">Базовые контроллеры</a></li>
            <li><a href="controllers#single-action-controllers">Контроллеры простого действия</a></li>
        </ul>
    </li>
    <li><a href="controllers#controller-middleware">ПО промежуточного слоя контроллера</a></li>
    <li><a href="controllers#resource-controllers">Контроллеры ресурсов</a>
        <ul>
            <li><a href="controllers#restful-partial-resource-routes">Частичные маршруты ресурсов</a></li>
            <li><a href="controllers#restful-nested-resources">Вложенные ресурсы</a></li>
            <li><a href="controllers#restful-naming-resource-routes">Именование маршрутов ресурсов</a></li>
            <li><a href="controllers#restful-naming-resource-route-parameters">Именование параметров маршрута
                    ресурса</a></li>
            <li><a href="controllers#restful-scoping-resource-routes">Обзор маршрутов ресурсов</a></li>
            <li><a href="controllers#restful-localizing-resource-uris">Локализация URI ресурсов</a></li>
            <li><a href="controllers#restful-supplementing-resource-controllers">Дополнительные контроллеры ресурсов</a>
            </li>
        </ul>
    </li>
    <li><a href="controllers#dependency-injection-and-controllers">Внедрение зависимостей и контроллеры</a></li>
</ul>
<p></p>
<h2 id="introduction"><a href="#introduction">Вступление</a></h2>
<p>Вместо того, чтобы определять всю логику обработки запросов как замыкания в файлах маршрутов, вы можете захотеть
    организовать это поведение с помощью классов «контроллеров». Контроллеры могут сгруппировать связанную логику
    обработки запросов в один класс. Например, <code>UserController</code> класс может обрабатывать все входящие запросы,
    относящиеся к пользователям, включая отображение, создание, обновление и удаление пользователей. По умолчанию
    контроллеры хранятся в <code>app/Http/Controllers</code> каталоге.</p>
<p></p>
<h2 id="writing-controllers"><a href="#writing-controllers">Написание контроллеров</a></h2>
<p></p>
<h3 id="basic-controllers"><a href="#basic-controllers">Базовые контроллеры</a></h3>
<p>Давайте посмотрим на пример базового контроллера. Обратите внимание, что контроллер расширяет базовый класс
    контроллера, включенный в Laravel <code>App\Http\Controllers\Controller</code> :</p>
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

<span class="token keyword">class</span> <span class="token class-name">UserController</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Show the profile for a given user.
    *
    * @param  int  $id
    * @return \Illuminate\View\View
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">show</span><span
                    class="token punctuation">(</span><span class="token variable">$id</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token keyword">return</span> <span class="token function">view</span><span
                    class="token punctuation">(</span><span
                    class="token single-quoted-string string">'user.profile'</span><span
                    class="token punctuation">,</span> <span class="token punctuation">[</span>
            <span class="token single-quoted-string string">'user'</span> <span class="token operator">=</span><span
                    class="token operator">&gt;</span> User<span class="token punctuation">:</span><span
                    class="token punctuation">:</span><span class="token function">findOrFail</span><span
                    class="token punctuation">(</span><span class="token variable">$id</span><span
                    class="token punctuation">)</span>
        <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Вы можете определить маршрут к этому методу контроллера следующим образом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>UserController</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/user/{literal}{id}{/literal}'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>UserController<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'show'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Когда входящий запрос совпадает с указанным URI маршрута, будет вызван <code>show</code> метод <code>App\Http\Controllers\UserController</code> класса,
    и параметры маршрута будут переданы методу.</p>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Контроллеры не <strong>обязаны</strong> расширять базовый класс. Тем не менее, вы не будете иметь доступ к
            удобным функциям таких как <code>middleware</code> и <code>authorize</code> метода.</p></p></div>
</blockquote>
<p></p>
<h3 id="single-action-controllers"><a href="#single-action-controllers">Контроллеры простого действия</a></h3>
<p>Если действие контроллера особенно сложно, вам может показаться удобным выделить целый класс контроллера для этого
    единственного действия. Для этого вы можете определить один <code>__invoke</code> метод в контроллере:</p>
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

<span class="token keyword">class</span> <span class="token class-name">ProvisionServer</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Provision a new web server.
    *
    * @param  int  $id
    * @return \Illuminate\Http\Response
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">__invoke</span><span
                    class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//...</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>При регистрации маршрутов для контроллеров одиночного действия вам не нужно указывать метод контроллера. Вместо этого
    вы можете просто передать маршрутизатору имя контроллера:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>ProvisionServer</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">post</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/server'</span><span class="token punctuation">,</span> ProvisionServer<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете сгенерировать вызываемый контроллер, используя <code>--invokable</code> опцию <code>make:controller</code> Artisan-команды:
</p>
<pre class=" language-php"><code class=" language-php">php artisan make<span class="token punctuation">:</span>controller ProvisionServer <span
                class="token operator">--</span>invokable</code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Заглушки контроллера можно настроить с помощью <a href="artisan#stub-customization">публикации заглушек.</a>
        </p></p></div>
</blockquote>
<p></p>
<h2 id="controller-middleware"><a href="#controller-middleware">ПО промежуточного слоя контроллера</a></h2>
<p><a href="middleware&amp;usg=ALkJrhjIMbvKvyAll38ZAYvItZbgOjPvFw">Промежуточное ПО</a> может быть назначено маршрутам
    контроллера в ваших файлах маршрутов:</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">get</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'profile'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>UserController<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'show'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">middleware</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'auth'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Или вам может быть удобно указать промежуточное программное обеспечение в конструкторе вашего контроллера. Используя
    <code>middleware</code> метод в конструкторе вашего контроллера, вы можете назначить промежуточное ПО для действий
    контроллера:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">class</span> <span
                class="token class-name">UserController</span> <span class="token keyword">extends</span> <span
                class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Instantiate a new controller instance.
    *
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">__construct</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">middleware</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'auth'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">middleware</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'log'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">only</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'index'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">middleware</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'subscribed'</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">except</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'store'</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></code></pre>
<p>Контроллеры также позволяют регистрировать промежуточное ПО с помощью замыкания. Это обеспечивает удобный способ
    определения встроенного промежуточного программного обеспечения для одного контроллера без определения всего класса
    промежуточного программного обеспечения:</p>
<pre class=" language-php"><code class=" language-php"><span class="token variable">$this</span><span
                class="token operator">-</span><span class="token operator">&gt;</span><span class="token function">middleware</span><span
                class="token punctuation">(</span><span class="token keyword">function</span> <span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token punctuation">,</span> <span class="token variable">$next</span><span
                class="token punctuation">)</span> <span class="token punctuation">{literal}{{/literal}</span>
    <span class="token keyword">return</span> <span class="token variable">$next</span><span
                class="token punctuation">(</span><span class="token variable">$request</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p></p>
<h2 id="resource-controllers"><a href="#resource-controllers">Контроллеры ресурсов</a></h2>
<p>Если вы думаете о каждой модели Eloquent в вашем приложении как о «ресурсе», то для каждого ресурса в вашем
    приложении обычно выполняются одни и те же наборы действий. Например, представьте, что ваше приложение содержит
    <code>Photo</code> модель и <code>Movie</code> модель. Вполне вероятно, что пользователи могут создавать, читать,
    обновлять или удалять эти ресурсы.</p>
<p>Из-за этого распространенного варианта использования маршрутизация ресурсов Laravel назначает типичные маршруты
    создания, чтения, обновления и удаления («CRUD») контроллеру с помощью одной строки кода. Для начала мы можем
    использовать опцию <code>make:controller</code> команды Artisan, <code>--resource</code> чтобы быстро создать
    контроллер для обработки этих действий:</p>
<pre class=" language-php"><code class=" language-php">php artisan make<span class="token punctuation">:</span>controller PhotoController <span
                class="token operator">--</span>resource</code></pre>
<p>Эта команда сгенерирует контроллер в <code>app/Http/Controllers/PhotoController.php</code>. Контроллер будет
    содержать метод для каждой из доступных операций с ресурсами. Затем вы можете зарегистрировать маршрут ресурса,
    который указывает на контроллер:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>PhotoController</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">resource</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'photos'</span><span
                class="token punctuation">,</span> PhotoController<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Это объявление единого маршрута создает несколько маршрутов для обработки множества действий с ресурсом.
    Сгенерированный контроллер уже будет иметь заглушки для каждого из этих действий. Помните, что вы всегда можете
    получить быстрый обзор вашего приложения, выполнив команду <code>route:list</code> Artisan.</p>
<p>Вы даже можете зарегистрировать сразу несколько контроллеров ресурсов, передав массив <code>resources</code> методу:
</p>
<pre class=" language-php"><code class=" language-php">Route<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token function">resources</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'photos'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> PhotoController<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'posts'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> PostController<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="actions-handled-by-resource-controller"><a href="#actions-handled-by-resource-controller">Действия, выполняемые
        контроллером ресурсов</a></h4>
<table>
    <thead>
    <tr>
        <th>Глагол</th>
        <th>URI</th>
        <th>Действие</th>
        <th>Название маршрута</th>
    </tr>
    </thead>
    <tbody>

    <tr>
        <td>GET</td>
        <td><code>/photos</code></td>
        <td>index</td>
        <td>photos.index</td>
    </tr>
    <tr>
        <td>GET</td>
        <td><code>/photos/create</code></td>
        <td>create</td>
        <td>photos.create</td>
    </tr>
    <tr>
        <td>POST</td>
        <td><code>/photos</code></td>
        <td>store</td>
        <td>photos.store</td>
    </tr>
    <tr>
        <td>GET</td>
        <td><code>/photos/{literal}{photo}{/literal}</code></td>
        <td>show</td>
        <td>photos.show</td>
    </tr>
    <tr>
        <td>GET</td>
        <td><code>/photos/{literal}{photo}{/literal}/edit</code></td>
        <td>edit</td>
        <td>photos.edit</td>
    </tr>
    <tr>
        <td>PUT/PATCH</td>
        <td><code>/photos/{literal}{photo}{/literal}</code></td>
        <td>update</td>
        <td>photos.update</td>
    </tr>
    <tr>
        <td>DELETE</td>
        <td><code>/photos/{literal}{photo}{/literal}</code></td>
        <td>destroy</td>
        <td>photos.destroy</td>
    </tr>
    </tbody>
</table>
<p></p>
<h4 id="specifying-the-resource-model"><a href="#specifying-the-resource-model">Определение модели ресурсов</a></h4>
<p>Если вы используете <a href="routing#route-model-binding">привязку модели маршрута</a> и хотите, чтобы методы
    контроллера ресурсов указывали тип экземпляра модели, вы можете использовать эту <code>--model</code> опцию при
    создании контроллера:</p>
<pre class=" language-php"><code class=" language-php">php artisan make<span class="token punctuation">:</span>controller PhotoController <span
                class="token operator">--</span>resource <span class="token operator">--</span>model<span
                class="token operator">=</span>Photo</code></pre>
<p></p>
<h3 id="restful-partial-resource-routes"><a href="#restful-partial-resource-routes">Частичные маршруты ресурсов</a></h3>
<p>При объявлении маршрута ресурса вы можете указать подмножество действий, которые должен обрабатывать контроллер,
    вместо полного набора действий по умолчанию:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>PhotoController</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">resource</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'photos'</span><span
                class="token punctuation">,</span> PhotoController<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">only</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'index'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'show'</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">resource</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'photos'</span><span
                class="token punctuation">,</span> PhotoController<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">except</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'create'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'store'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'update'</span><span class="token punctuation">,</span> <span
                class="token single-quoted-string string">'destroy'</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h4 id="api-resource-routes"><a href="#api-resource-routes">Маршруты ресурсов API</a></h4>
<p>При объявлении маршрутов ресурсов, которые будут использоваться API, вы обычно хотите исключить маршруты, которые
    представляют шаблоны HTML, такие как <code>create</code> и <code>edit</code>. Для удобства вы можете использовать
    этот <code>apiResource</code> метод для автоматического исключения этих двух маршрутов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>PhotoController</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">apiResource</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'photos'</span><span
                class="token punctuation">,</span> PhotoController<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Вы можете зарегистрировать сразу несколько контроллеров ресурсов API, передав массив в <code>apiResources</code> метод:
</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>PhotoController</span><span
                class="token punctuation">;</span>
<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>PostController</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">apiResources</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'photos'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> PhotoController<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
    <span class="token single-quoted-string string">'posts'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> PostController<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Чтобы быстро сгенерировать контроллер ресурсов API, который не включает методы <code>create</code> или
    <code>edit</code>, используйте <code>--api</code> переключатель при выполнении <code>make:controller</code> команды:
</p>
<pre class=" language-php"><code class=" language-php">php artisan make<span class="token punctuation">:</span>controller PhotoController <span
                class="token operator">--</span>api</code></pre>
<p></p>
<h3 id="restful-nested-resources"><a href="#restful-nested-resources">Вложенные ресурсы</a></h3>
<p>Иногда вам может потребоваться определить маршруты к вложенному ресурсу. Например, фоторесурс может иметь несколько
    комментариев, которые могут быть прикреплены к фотографии. Чтобы вложить контроллеры ресурсов, вы можете
    использовать нотацию с точкой в объявлении маршрута:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>PhotoCommentController</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">resource</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'photos.comments'</span><span
                class="token punctuation">,</span> PhotoCommentController<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Этот маршрут зарегистрирует вложенный ресурс, к которому можно будет получить доступ с помощью URI, подобных
    следующим:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">/</span>photos<span
                class="token operator">/</span><span class="token punctuation">{literal}{{/literal}</span>photo<span
                class="token punctuation">}</span><span class="token operator">/</span>comments<span
                class="token operator">/</span><span class="token punctuation">{literal}{{/literal}</span>comment<span
                class="token punctuation">}</span></code></pre>
<p></p>
<h4 id="scoping-nested-resources"><a href="#scoping-nested-resources">Определение вложенных ресурсов</a></h4>
<p>Функция <a href="routing#implicit-model-binding-scoping">неявной привязки модели</a> Laravel может автоматически
    определять вложенные привязки, так что разрешенная дочерняя модель подтверждается принадлежностью к родительской
    модели. Используя этот <code>scoped</code> метод при определении вложенного ресурса, вы можете включить
    автоматическое определение области, а также указать Laravel, по какому полю должен быть извлечен дочерний ресурс.
    Для получения дополнительных сведений о том, как это сделать, см. Документацию по <a
            href="controllers#restful-scoping-resource-routes">определению маршрутов ресурсов</a>.</p>
<p></p>
<h4 id="shallow-nesting"><a href="#shallow-nesting">Неглубокое гнездование</a></h4>
<p>Часто нет необходимости иметь в URI и родительский, и дочерний идентификаторы, поскольку дочерний идентификатор уже
    является уникальным идентификатором. При использовании уникальных идентификаторов, таких как автоматически
    увеличивающиеся первичные ключи, для идентификации ваших моделей в сегментах URI, вы можете выбрать «неглубокую
    вложенность»:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>CommentController</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">resource</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'photos.comments'</span><span
                class="token punctuation">,</span> CommentController<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">shallow</span><span
                class="token punctuation">(</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Это определение маршрута будет определять следующие маршруты:</p>
<table>
    <thead>
    <tr>
        <th>Глагол</th>
        <th>URI</th>
        <th>Действие</th>
        <th>Название маршрута</th>
    </tr>
    </thead>
    <tbody>

    <tr>
        <td>GET</td>
        <td><code>/photos/{literal}{photo}{/literal}/comments</code></td>
        <td>index</td>
        <td>photos.comments.index</td>
    </tr>
    <tr>
        <td>GET</td>
        <td><code>/photos/{literal}{photo}{/literal}/comments/create</code></td>
        <td>create</td>
        <td>photos.comments.create</td>
    </tr>
    <tr>
        <td>POST</td>
        <td><code>/photos/{literal}{photo}{/literal}/comments</code></td>
        <td>store</td>
        <td>photos.comments.store</td>
    </tr>
    <tr>
        <td>GET</td>
        <td><code>/comments/{literal}{comment}{/literal}</code></td>
        <td>show</td>
        <td>comments.show</td>
    </tr>
    <tr>
        <td>GET</td>
        <td><code>/comments/{literal}{comment}{/literal}/edit</code></td>
        <td>edit</td>
        <td>comments.edit</td>
    </tr>
    <tr>
        <td>PUT/PATCH</td>
        <td><code>/comments/{literal}{comment}{/literal}</code></td>
        <td>update</td>
        <td>comments.update</td>
    </tr>
    <tr>
        <td>DELETE</td>
        <td><code>/comments/{literal}{comment}{/literal}</code></td>
        <td>destroy</td>
        <td>comments.destroy</td>
    </tr>
    </tbody>
</table>
<p></p>
<h3 id="restful-naming-resource-routes"><a href="#restful-naming-resource-routes">Именование маршрутов ресурсов</a></h3>
<p>По умолчанию все действия контроллера ресурсов имеют имя маршрута; однако вы можете переопределить эти имена, передав
    <code>names</code> массив с желаемыми именами маршрутов:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>PhotoController</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">resource</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'photos'</span><span
                class="token punctuation">,</span> PhotoController<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">names</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'create'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'photos.build'</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p></p>
<h3 id="restful-naming-resource-route-parameters"><a href="#restful-naming-resource-route-parameters">Именование
        параметров маршрута ресурса</a></h3>
<p>По умолчанию <code>Route::resource</code> параметры маршрута для маршрутов вашего ресурса будут созданы на основе
    «сингулярной» версии имени ресурса. Вы можете легко переопределить это для каждого ресурса, используя <code>parameters</code> метод.
    Массив, переданный в <code>parameters</code> метод, должен быть ассоциативным массивом имен ресурсов и имен
    параметров:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>AdminUserController</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">resource</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'users'</span><span
                class="token punctuation">,</span> AdminUserController<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">parameters</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'users'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'admin_user'</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>В приведенном выше примере создается следующий URI для <code>show</code> маршрута ресурса :</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">/</span>users<span
                class="token operator">/</span><span
                class="token punctuation">{literal}{{/literal}</span>admin_user<span class="token punctuation">}</span></code></pre>
<p></p>
<h3 id="restful-scoping-resource-routes"><a href="#restful-scoping-resource-routes">Обзор маршрутов ресурсов</a></h3>
<p>Функция <a href="routing#implicit-model-binding-scoping">неявной привязки модели</a> в области <a
            href="routing#implicit-model-binding-scoping">видимости</a> Laravel может автоматически ограничивать
    вложенные привязки, так что разрешенная дочерняя модель подтверждается принадлежностью к родительской модели.
    Используя этот <code>scoped</code> метод при определении вложенного ресурса, вы можете включить автоматическое
    определение области, а также указать Laravel, в каком поле дочерний ресурс должен быть получен:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>PhotoCommentController</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">resource</span><span
                class="token punctuation">(</span><span
                class="token single-quoted-string string">'photos.comments'</span><span
                class="token punctuation">,</span> PhotoCommentController<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token operator">-</span><span
                class="token operator">&gt;</span><span class="token function">scoped</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
    <span class="token single-quoted-string string">'comment'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'slug'</span><span
                class="token punctuation">,</span>
<span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<p>Этот маршрут зарегистрирует вложенный ресурс с ограниченной областью действия, к которому можно получить доступ с
    помощью таких URI, как следующие:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">/</span>photos<span
                class="token operator">/</span><span class="token punctuation">{literal}{{/literal}</span>photo<span
                class="token punctuation">}</span><span class="token operator">/</span>comments<span
                class="token operator">/</span><span class="token punctuation">{literal}{{/literal}</span>comment<span
                class="token punctuation">:</span>slug<span class="token punctuation">}</span></code></pre>
<p>При использовании настраиваемой неявной привязки с ключом в качестве параметра вложенного маршрута Laravel
    автоматически задает область запроса для получения вложенной модели своим родителем, используя соглашения, чтобы
    угадать имя отношения на родительском элементе. В этом случае предполагается, что <code>Photo</code> модель имеет
    указанное отношение <code>comments</code> (множественное число от имени параметра маршрута), которое можно
    использовать для получения <code>Comment</code> модели.</p>
<p></p>
<h3 id="restful-localizing-resource-uris"><a href="#restful-localizing-resource-uris">Локализация URI ресурсов</a></h3>
<p>По умолчанию <code>Route::resource</code> URI ресурсов будет создаваться с использованием английских глаголов. Если
    вам нужно локализовать глаголы действия <code>create</code> и <code>edit</code>, вы можете использовать этот <code>Route::resourceVerbs</code> метод.
    Это можно сделать в начале <code>boot</code> метода в вашем приложении
    <code>App\Providers\RouteServiceProvider</code> :</p>
<pre class=" language-php"><code class=" language-php"><span class="token comment">/**
 * Define your route model bindings, pattern filters, etc.
 *
 * @return void
 */</span>
<span class="token keyword">public</span> <span class="token keyword">function</span> <span
                class="token function">boot</span><span class="token punctuation">(</span><span
                class="token punctuation">)</span>
<span class="token punctuation">{literal}{{/literal}</span>
    Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">resourceVerbs</span><span
                class="token punctuation">(</span><span class="token punctuation">[</span>
        <span class="token single-quoted-string string">'create'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'crear'</span><span
                class="token punctuation">,</span>
        <span class="token single-quoted-string string">'edit'</span> <span class="token operator">=</span><span
                class="token operator">&gt;</span> <span class="token single-quoted-string string">'editar'</span><span
                class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
    
    <span class="token comment">//...</span>
<span class="token punctuation">}</span></code></pre>
<p>После того, как глаголы были настроены, регистрация маршрута ресурса, такая как,
    <code>Route::resource('fotos', PhotoController::class)</code> создаст следующие URI:</p>
<pre class=" language-php"><code class=" language-php"><span class="token operator">/</span>fotos<span
                class="token operator">/</span>crear

<span class="token operator">/</span>fotos<span class="token operator">/</span><span
                class="token punctuation">{literal}{{/literal}</span>foto<span class="token punctuation">}</span><span
                class="token operator">/</span>editar</code></pre>
<p></p>
<h3 id="restful-supplementing-resource-controllers"><a href="#restful-supplementing-resource-controllers">Дополнительные
        контроллеры ресурсов</a></h3>
<p>Если вам нужно добавить дополнительные маршруты к контроллеру ресурсов помимо набора маршрутов ресурсов по умолчанию,
    вы должны определить эти маршруты перед вызовом <code>Route::resource</code> метода; в противном случае маршруты,
    определенные <code>resource</code> методом, могут непреднамеренно иметь приоритет над дополнительными маршрутами:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Controller<span class="token punctuation">\</span>PhotoController</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">get</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/photos/popular'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>PhotoController<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'popular'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span>
Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span class="token function">resource</span><span
                class="token punctuation">(</span><span class="token single-quoted-string string">'photos'</span><span
                class="token punctuation">,</span> PhotoController<span class="token punctuation">:</span><span
                class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">)</span><span class="token punctuation">;</span></code></pre>
<blockquote>
    <div class="mb-10 max-w-2xl mx-auto px-4 py-8 shadow-lg lg:flex lg:items-center callout">
        <div class="w-20 h-20 mb-6 flex items-center justify-center flex-shrink-0 bg-purple-600 lg:mb-0"><img
                    src="/img/callouts/lightbulb.min.svg" class="opacity-75"></div>
        <p class="mb-0 lg:ml-6">
        <p>Не забудьте сосредоточить внимание ваших контроллеров. Если вам постоянно требуются методы, выходящие за
            рамки типичного набора действий с ресурсами, рассмотрите возможность разделения вашего контроллера на два
            меньших контроллера.</p></p></div>
</blockquote>
<p></p>
<h2 id="dependency-injection-and-controllers"><a href="#dependency-injection-and-controllers">Внедрение зависимостей и
        контроллеры</a></h2>
<p></p>
<h4 id="constructor-injection"><a href="#constructor-injection">Внедрение конструктора</a></h4>
<p><a href="container&amp;usg=ALkJrhhdEouCeRRgbwkNOAFudVq4e51kxQ">Сервисный контейнер</a> Laravel используется для
    разрешения всех контроллеров Laravel. В результате вы можете указать любые зависимости, которые могут понадобиться
    вашему контроллеру в его конструкторе. Объявленные зависимости будут автоматически разрешены и внедрены в экземпляр
    контроллера:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">App<span class="token punctuation">\</span>Repositories<span
                        class="token punctuation">\</span>UserRepository</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">UserController</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * The user repository instance.
    */</span>
    <span class="token keyword">protected</span> <span class="token variable">$users</span><span
                    class="token punctuation">;</span>

    <span class="token comment">/**
    * Create a new controller instance.
    *
    * @param  \App\Repositories\UserRepository  $users
    * @return void
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">__construct</span><span
                    class="token punctuation">(</span>UserRepository <span class="token variable">$users</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$this</span><span class="token operator">-</span><span
                    class="token operator">&gt;</span><span class="token property">users</span> <span
                    class="token operator">=</span> <span class="token variable">$users</span><span
                    class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p></p>
<h4 id="method-injection"><a href="#method-injection">Внедрение метода</a></h4>
<p>Помимо внедрения конструктора, вы также можете указать зависимости типа от методов вашего контроллера. Обычный
    вариант использования внедрения метода - это внедрение <code>Illuminate\Http\Request</code> экземпляра в методы
    вашего контроллера:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">UserController</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Store a new user.
    *
    * @param  Request  $request
    * @return Response
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">store</span><span
                    class="token punctuation">(</span>Request <span class="token variable">$request</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token variable">$name</span> <span class="token operator">=</span> <span class="token variable">$request</span><span
                    class="token operator">-</span><span class="token operator">&gt;</span><span class="token property">name</span><span
                    class="token punctuation">;</span>

        <span class="token comment">//</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
<p>Если ваш метод контроллера также ожидает ввода от параметра маршрута, укажите аргументы маршрута после других
    зависимостей. Например, если ваш маршрут определен так:</p>
<pre class=" language-php"><code class=" language-php"><span class="token keyword">use</span> <span
                class="token package">App<span class="token punctuation">\</span>Http<span
                    class="token punctuation">\</span>Controllers<span class="token punctuation">\</span>UserController</span><span
                class="token punctuation">;</span>

Route<span class="token punctuation">:</span><span class="token punctuation">:</span><span
                class="token function">put</span><span class="token punctuation">(</span><span
                class="token single-quoted-string string">'/user/{literal}{id}{/literal}'</span><span
                class="token punctuation">,</span> <span class="token punctuation">[</span>UserController<span
                class="token punctuation">:</span><span class="token punctuation">:</span><span class="token keyword">class</span><span
                class="token punctuation">,</span> <span class="token single-quoted-string string">'update'</span><span
                class="token punctuation">]</span><span class="token punctuation">)</span><span
                class="token punctuation">;</span></code></pre>
<p>Вы по-прежнему можете напечатать <code>Illuminate\Http\Request</code> и получить доступ к <code>id</code> параметру,
    определив свой метод контроллера следующим образом:</p>
<pre class=" language-php"><code class=" language-php"><span class="token php language-php"><span
                    class="token delimiter important">&lt;?php</span>

<span class="token keyword">namespace</span> <span class="token package">App<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Controllers</span><span class="token punctuation">;</span>

<span class="token keyword">use</span> <span class="token package">Illuminate<span class="token punctuation">\</span>Http<span
                        class="token punctuation">\</span>Request</span><span class="token punctuation">;</span>

<span class="token keyword">class</span> <span class="token class-name">UserController</span> <span
                    class="token keyword">extends</span> <span class="token class-name">Controller</span>
<span class="token punctuation">{literal}{{/literal}</span>
    <span class="token comment">/**
    * Update the given user.
    *
    * @param  \Illuminate\Http\Request  $request
    * @param  string  $id
    * @return \Illuminate\Http\Response
    */</span>
    <span class="token keyword">public</span> <span class="token keyword">function</span> <span class="token function">update</span><span
                    class="token punctuation">(</span>Request <span class="token variable">$request</span><span
                    class="token punctuation">,</span> <span class="token variable">$id</span><span
                    class="token punctuation">)</span>
    <span class="token punctuation">{literal}{{/literal}</span>
        <span class="token comment">//</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span></span></code></pre>
