{set_defaults( hash(
  'topic_path_array', array(),
  'children', array()
))}


{if and( $classi_filtro|is_array(), $classi_filtro|count()|gt(0) )}
    {set $children = fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id,
                                                     'class_filter_type', 'include',
                                                     'class_filter_array', $classi_filtro,
                                                     'sort_by', $node.sort_array,
                                                     'depth', 1 ) ) }
{else}
    {set $children = fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id,
                                                     'sort_by', $node.sort_array,
                                                     'depth', 1 ) ) }
{/if}

{if $children|count()}
    <ul class="Linklist Linklist--padded Treeview Treeview--ez js-Treeview u-text-r-xs">
        {foreach $children as $child }
            {if $topic_path_array|contains($child.node_id)}
            <li aria-expanded="true">
            {else}
            <li>
            {/if}
            
                {node_view_gui content_node=$child view=treeview level=1 root_node=$node.node_id topic_path_array=$topic_path_array classi_filtro=$classi_filtro}
            </li>
        {/foreach}
    </ul>
{/if}

{literal}
<script>    
    $(document).ready(function(){
        $("li").mouseenter(function(){
            if($(this).hasClass("Treeview-parent") && $(this).attr('aria-expanded') === 'false'){
                console.log('Enter');
               $(this).children().first().children( ".Treeview-handler--standalone").css('background-image', "url('data:image/svg+xml;charset=utf-8,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20xmlns%3Axlink%3D%22http%3A%2F%2Fwww.w3.org%2F1999%2Fxlink%22%20version%3D%221.1%22%20width%3D%2232%22%20height%3D%2232%22%3E%3Crect%20id%3D%22backgroundrect%22%20width%3D%22100%25%22%20height%3D%22100%25%22%20x%3D%220%22%20y%3D%220%22%20fill%3D%22none%22%20stroke%3D%22none%22%2F%3E%0D%0A%0D%0A%3Cg%20class%3D%22currentLayer%22%3E%3Ctitle%3ELayer%201%3C%2Ftitle%3E%3Cpath%20d%3D%22M3.733%206.133l-3.733%203.733%2016%2016%2016-16-3.733-3.733-12.267%2012.267-12.267-12.267z%22%20id%3D%22svg_1%22%20class%3D%22selected%22%20fill%3D%22%23ffffff%22%20fill-opacity%3D%221%22%2F%3E%3C%2Fg%3E%3C%2Fsvg%3E')");
            }
        });
        
        $("li").mouseleave(function(){
            if($(this).hasClass("Treeview-parent") && $(this).attr('aria-expanded') === 'false'){
                console.log('Leave');
                $(this).children().first().children( ".Treeview-handler--standalone" ).css('background-image', '');
            }
        });
        
    });
</script>
{/literal}