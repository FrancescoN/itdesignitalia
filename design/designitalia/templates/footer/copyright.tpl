{def $root_node = fetch(content, node, hash( node_id, ezini('NodeSettings', 'RootNode', 'content.ini')))}
<div class="container">
    {if $root_node|has_attribute('copyright')}
        <i class="fa fa-copyright"></i>
        {attribute_view_gui attribute=$root_node|attribute('copyright')}
    {/if}
</div>