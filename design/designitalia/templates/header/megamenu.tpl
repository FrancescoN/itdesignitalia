{def $current_node = false()}

{if is_set($current_node_id)}
    {set $current_node = fetch( 'content', 'node', hash( 'node_id', $current_node_id ) )}
{/if}

{* Attiva/Disattiva Menù *}
{def $top_menu=true()}

{if and($current_node, $current_node.object.state_identifier_array|contains('top_menu/inactive'))}
    {set $top_menu=false()}
{/if}
      
{if $top_menu}

    {def $root_node = fetch( 'content', 'node', hash( 'node_id', $pagedata.root_node ) )}
    <div class="u-textCenter u-hidden u-sm-hidden u-md-block u-lg-block">

        <nav class="Megamenu Megamenu--default js-megamenu">
            {def $top_menu_class_filter = appini( 'MenuContentSettings', 'MegaMenuIdentifierList', array() )
                 $top_menu_items = fetch( 'content', 'list', hash( 'parent_node_id', $root_node.node_id,
                                          'sort_by', $root_node.sort_array,
                                          'class_filter_type', 'include',
                                          'class_filter_array', $top_menu_class_filter ) )
                 $top_menu_items_count = $top_menu_items|count()}

            {if $top_menu_items_count}
                
                <ul class="Megamenu-list">
                    {foreach $top_menu_items as $key => $item}
                        {if $item.priority|ne(1000)}
                            {node_view_gui content_node=$item view='megamenu-item'}
                        {/if}
                    {/foreach}
                </ul>
            
            {/if}
        </nav>

    </div>
    
{/if}

{undef $current_node
       $top_menu
       $root_node
       $top_menu_class_filter
       $top_menu_items
       $top_menu_items_count}