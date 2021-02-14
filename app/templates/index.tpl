{$_name = $name|default:"installation"}
{$_title = $title|default:"Laravel 8.x"}
{$_fixed_navigation = $fixed_navigation|default:false}
{$_show_translated_with = $show_translated_with|default:false}

<!DOCTYPE html>
<html lang="en">

{include "common/header.tpl" title="{$_title}"}

<body class="language-php h-full w-full font-sans text-gray-900 antialiased">

<div class="relative overflow-auto" id="docsScreen">
    <div class="relative lg:flex lg:items-start">

        {include "common/navigation-bar.tpl" uri=$_name fixed_navigation=$_fixed_navigation}

        <section class="flex-1 pl-20 lg:pl-0">
            <div class="max-w-screen-lg px-4 sm:px-16 lg:px-24">
                <section class="mt-8 md:mt-16">
                    <section class="docs_main max-w-prose">

                        {if $_show_translated_with}
                            {include "common/translated-with.tpl"}
                        {/if}

                        {include "docs/{$_name}.tpl"}

                    </section>
                </section>
            </div>
        </section>

    </div>
</div>

{include "common/footer.tpl"}

</body>
</html>