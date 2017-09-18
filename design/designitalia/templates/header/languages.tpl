{def $lang_selector = array()
     $avail_translation = array()}
     
{if and( is_set( $DesignKeys:used.url_alias ), $DesignKeys:used.url_alias|count|ge( 1 ) )}
    {set $avail_translation = language_switcher( $DesignKeys:used.url_alias )}
{else}
    {set $avail_translation = language_switcher( $site.uri.original_uri )}
{/if}

{if $avail_translation|count|gt( 1 )}
    <ul class="Header-socialIcons">
    {foreach $avail_translation as $siteaccess => $lang}
        {if is_set($lang.locale)}
            {if $siteaccess|eq( $access_type.name )}
                <li class="Language-select">
                    <a href="#"><b>{$lang.text|wash()}</b></a>
                </li>
            {else}
                <li class="Language-select">
                    <a href={$lang.url|ezurl}>{$lang.text|wash()}</a>
                </li>
            {/if}
        {/if}
    {/foreach}
    </ul>
{/if}
