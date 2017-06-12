<li {if and(is_set($current_node), $current_node.node_id|eq($node.node_id))} class="active" {/if} >
    {if eq( $node.class_identifier, 'link')}
        <a href={$node.data_map.location.content|ezurl} {if and( is_set( $node.data_map.open_in_new_window ), $node.data_map.open_in_new_window.data_int )} target="_blank"{/if}>
            <span class="u-margin-left-xxxl">{$node.name}</span>
        </a>
    {else}
        <a href={$node.url_alias|ezurl}>
            <span class="u-margin-left-xxxl">{$node.name}</span>
        </a>
        
        {* mi fermo ad 1 livello *}
        {if $level|le(1)}
            {* SOTTO-ELEMENTI (di qualsiasi classe) *}
            {def $side_menu_class_filter = appini( 'MenuContentSettings', 'OffCanvasIdentifierList', array() )
                 $sub_side_menu_items = fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id,
                                                                        'sort_by', $node.sort_array,
                                                                        'class_filter_type', 'include',
                                                                        'class_filter_array', $side_menu_class_filter  ))
                 $sub_side_menu_items_count = $sub_side_menu_items|count()}
                 
            {*$sub_side_menu_items|attribute('show')*}
            
            {if $sub_side_menu_items_count}
                <ul>
                    {foreach $sub_side_menu_items as $key => $item}
                        {node_view_gui content_node=$item view='offcanvas-item' level=$level|sum(1) current_node=$current_node}
                    {/foreach}
                </ul>
            {/if}

            {undef $sub_side_menu_items
                   $sub_side_menu_items_count}
        {/if}
    {/if}
</li>
