
<li class="Megamenu-item">
    {if eq( $node.class_identifier, 'link')}
        <a href={$node.data_map.location.content|ezurl}
           {if and( is_set( $node.data_map.open_in_new_window ), $node.data_map.open_in_new_window.data_int )} target="_blank"{/if}>
            {$node.name}
        </a>
    {else}
        <a href={$node.url_alias|ezurl}>
            {$node.name}
        </a>
    {/if}
</li>