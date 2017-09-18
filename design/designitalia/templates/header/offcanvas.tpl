{def $current_node = fetch( 'content', 'node', hash( 'node_id', $current_node_id ) )
     $root_node = fetch( 'content', 'node', hash( 'node_id', $pagedata.root_node ) )}

<section class="Offcanvas Offcanvas--left Offcanvas--modal js-fr-offcanvas u-jsVisibilityHidden u-nojsDisplayNone u-hiddenPrint" id="menu">
    <h2 class="u-hiddenVisually">{'Navigation menu'|i18n('designitalia/offcanvas')}</h2>
    <div class="Offcanvas-content">
        <div class="Offcanvas-toggleContainer u-jsHidden">
            <a class="Hamburger-toggleContainer u-block u-padding-bottom-xxl u-padding-left-s u-padding-top-xxl js-fr-offcanvas-close" 
               aria-controls="menu" 
               aria-label="{'exit from navigation'|i18n('designitalia/offcanvas')}" 
               title="{'exit from navigation'|i18n('designitalia/offcanvas')}" href="#">
                <span class="Hamburger-toggle is-active u-color-white" aria-hidden="true"></span>
                
                <span class="u-margin-left-xxxl">
                    {'Navigation by user class'|i18n('designitalia/offcanvas')}
                </span>
            </a>
        </div>
        <nav>
            {def $side_menu_class_filter = appini( 'MenuContentSettings', 'OffCanvasIdentifierList', array() )
                 $side_menu_items = fetch( 'content', 'list', hash( 'parent_node_id', $root_node.node_id,
                                           'sort_by', $root_node.sort_array,
                                           'class_filter_type', 'include',
                                           'class_filter_array', $side_menu_class_filter ) )
                 $side_menu_items_count = $side_menu_items|count()}

            {if $side_menu_items_count}
                <ul class="Linklist Linklist--padded Treeview Treeview--default js-Treeview u-text-r-xs">
                    {foreach $side_menu_items as $key => $item}
                        {node_view_gui content_node=$item view='offcanvas-item'  level=1 current_node=$current_node}
                    {/foreach}
                </ul>
            {/if}
        </nav>
    </div>
</section>
              
{undef $current_node
       $root_node
       $side_menu_class_filter
       $side_menu_items
       $side_menu_items_count}