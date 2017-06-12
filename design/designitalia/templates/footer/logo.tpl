{def $root_node = fetch(content, node, hash( node_id, ezini('NodeSettings', 'RootNode', 'content.ini')))}

<div class="u-cf">
    {if $root_node|attribute('logo').content.original.url}
        <img class="Footer-logo" src={$root_node|attribute('logo').content.original.url|ezroot()} alt="{$root_node.name}">
    {/if}
    
    <p class="Footer-siteName">
        {if $root_node|has_attribute('short_name')}
            {$root_node|attribute('short_name').data_text}
        {else}
            {$root_node.name}
        {/if}
    </p>
</div>
