{if $item.children|count()}
    <ul class="Linklist Linklist--padded Treeview Treeview--ez js-Treeview u-text-r-xs">
        {foreach $item.children as $child }
            {if $path_array|contains($child.node_id)}
            <li aria-expanded="true">
            {else}
            <li>
            {/if}
                {node_view_gui content_node=$child view=treeview level=1 root_node=$item classi_filtro=array('struttura_organizzativa') topic_path_array=$path_array}
            </li>
        {/foreach}
    </ul>
{/if}