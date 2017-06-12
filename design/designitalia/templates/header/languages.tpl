{def $lang_selector = array()
     $avail_translation = array()
     $site_url = ezini('SiteSettings', 'SiteURL')}
     
{if and( is_set( $DesignKeys:used.url_alias ), $DesignKeys:used.url_alias|count|ge( 1 ) )}
    {set $avail_translation = language_switcher( $DesignKeys:used.url_alias )}
{else}
    {set $avail_translation = language_switcher( $site.uri.original_uri )}
{/if}

{if $avail_translation|count|gt( 1 )}
    <ul class="Header-socialIcons">
    {def $lang_uri=false()}
    
    {foreach $avail_translation as $siteaccess => $lang}
        {if is_set($lang.locale)}
            {if $siteaccess|eq( $access_type.name )}
                <li class="Language-select">
                    <a href="#"><b class="u-color-80">{$lang.text|wash()}</b></a>
                </li>
            {else}
                {set $lang_uri = $lang.text|downcase()}
                {if $lang_uri|eq('ita')}
                    {set $lang_uri = ''}
                {/if}
                
                <li class="Language-select">
                    <a href={concat('https://', $site_url, '/', $lang_uri)}>
                        <span class="u-color-text">{$lang.text|wash()}</span>
                    </a>
                </li>
            {/if}
        {/if}
    {/foreach}
    </ul>
{/if}
