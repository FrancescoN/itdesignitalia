{set_defaults( hash(
    'sort_array', array( 'priority', true())
) ) }


{def $classi_filtro = $block.custom_attributes.includi_classi|explode(',')
     $block_node =  fetch('content', 'node', hash( 'node_id', $block.custom_attributes.node_id))
     $items = fetch('content', 'list', hash( 'parent_node_id', $block.custom_attributes.node_id,
                                             'sort_by', $sort_array,
                                             'class_filter_type', 'include',
                                             'class_filter_array', $classi_filtro,
                                             'depth', 1 ) ) }

<div class="u-flow-treeview">
    <section>
        {if $items|count()}
            <ul class="Linklist Linklist--padded Treeview Treeview--ez js-Treeview u-text-r-xs">
                {foreach $items as $item }
                    <li>
                        {node_view_gui content_node=$item view=treeview level=1 root_node=$block_node.node_id classi_filtro=$classi_filtro}
                    </li>
                {/foreach}
            </ul>
        {/if}
    </section>
    
</div>