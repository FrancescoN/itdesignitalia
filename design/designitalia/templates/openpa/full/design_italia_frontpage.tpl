{if $node.data_map.page.has_content}
    {attribute_view_gui attribute=$node.data_map.page}
{else}
    {include uri=$openpa.control_children.template}
{/if}