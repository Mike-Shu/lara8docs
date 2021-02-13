{$_name = $name|default:"installation"}
{$_title = $title|default:"Laravel 8.x"}

<!DOCTYPE html>
<html lang="en">
{include "common/head.tpl" title="{$_title}"}
<body class="language-php h-full w-full font-sans text-gray-900 antialiased">

<div class="relative overflow-auto" id="docsScreen">
    <div class="relative lg:flex lg:items-start">

        {include "common/navigation-bar.tpl" uri=$_name}

        <section class="flex-1 pl-20 lg:pl-0">
            <div class="max-w-screen-lg px-4 sm:px-16 lg:px-24">
                <section class="mt-8 md:mt-16">
                    <section class="docs_main max-w-prose">
                        {include "docs/{$_name}.tpl"}
                    </section>
                </section>
            </div>
        </section>

    </div>
</div>

{include "common/footer.tpl"}

<script>
    var algolia_app_id = 'BH4D9OD16A';
    var algolia_search_key = '7dc4fe97e150304d1bf34f5043f178c4';
    var version = '8.x';
</script>

<script src="js/app.js"></script>

</body>
</html>