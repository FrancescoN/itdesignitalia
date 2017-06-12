{if is_set($node)}
    {def $image = false()
         $image_url = false()}

    {if $node|has_attribute( 'immagini' )}
      {foreach $node.data_map.immagini.content.relation_list as $relation_item}
        {set $image = fetch('content','node',hash('node_id',$relation_item.node_id)).data_map.image.content['imagefullwide']}
        {break}
      {/foreach}
    {/if}

    {if $image}
        {set $image_url = concat('"', 'https://', ezini('SiteSettings','SiteURL'), $image.url|ezroot(no), '"')}
    {/if}

    {* Open Graph *}
    <meta property="fb:app_id" content="130986460798178" />

    <meta property="og:site_name" content="{ezini('SiteSettings', 'SiteName')}" />
    <meta property="og:url" content="{concat('https://', ezini('SiteSettings','SiteURL'), $node.url_alias|ezroot(no))}" />
    <meta property="og:country-name" content="Italy" />
    <meta property="og:type" content="article" />
    <meta property="og:title" content="{$node.name|wash()}" />

    {if $node|has_attribute('abstract')}
        <meta property="og:description" content="{$node.data_map.abstract.content|wash()}" />
    {/if}

    {if $image_url}
        <meta property="og:image" content={$image_url} />
    {/if}

    {* Twitter *}

    {* Se c'è un immagine creo una summary_large_card altrimenti no *}
    {if $image_url}
        <meta name="twitter:card" content="summary_large_image">
        <meta name="twitter:site" content="@{ezini('SiteSettings','SiteURL')}">
        <meta name="twitter:creator" content="@{ezini('SiteSettings','SiteURL')}">
        <meta name="twitter:title" content="{$node.name|wash()}">

        {if $node|has_attribute('abstract')}
            <meta name="twitter:description" content="{$node.data_map.abstract.content|wash()}">
        {/if}

        <meta name="twitter:image" content="{$image_url}">
    {else}
        <meta name="twitter:card" content="summary" />
        <meta name="twitter:site" content="@{ezini('SiteSettings','SiteURL')}" />
        <meta name="twitter:title" content="{$node.name|wash()}" />

        {if $node|has_attribute('abstract')}
            <meta name="twitter:description" content="{$node.data_map.abstract.content|wash()}">
        {/if}
    {/if}

    {undef $image
           $image_url}
{/if}