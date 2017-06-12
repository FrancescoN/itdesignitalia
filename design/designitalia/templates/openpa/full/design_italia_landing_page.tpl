{set-block scope=root variable=cache_ttl}0{/set-block}

{if $node.data_map.page.has_content}
    {attribute_view_gui attribute=$node.data_map.page}
{else}
    {include uri=$openpa.control_children.template}
{/if}