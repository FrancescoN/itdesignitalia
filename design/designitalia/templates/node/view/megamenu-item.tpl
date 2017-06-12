
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
        
        {if $node|has_attribute( 'menu_show_subitems' )}
            {def $sub_menu_class_filter = appini( 'MenuContentSettings', 'MegaMenuIdentifierList', array() )
                 $sub_menu_items = fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id,
                                          'sort_by', $node.sort_array,
                                          'class_filter_type', 'include',
                                          'class_filter_array', $sub_menu_class_filter ) )
                 $sub_menu_items_count = $sub_menu_items|count()}
            
            {if $sub_menu_items}
                <div class="Megamenu-subnav u-jsDisplayNone">
                    <ul class="Megamenu-subnavItem">
                        
                        {foreach $sub_menu_items as $key => $item}
                            {if $item.priority|ne(1000)}
                                <li>
                                    <a style="color: white !important;" href={$item.url_alias|ezurl}>{$item.name}</a>
                                </li>
                            {/if}
                        {/foreach}
                    </ul>
                </div>
            {/if}
            {undef $sub_menu_class_filter
                   $sub_menu_items
                   $sub_menu_items_count}
        {/if}
    {/if}
</li>