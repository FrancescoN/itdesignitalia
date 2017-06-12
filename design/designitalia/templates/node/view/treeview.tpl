{set_defaults( hash(
  'children', array(),
  'node_url', '""',
  'topic_path_array', array(),
  'tag', false(),
  'tree_limit', 3,
  'target', '_self'
))}

{if $level|lt($tree_limit)}
    {if $tag}
        {set $children = fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id,
                                                         'class_filter_type', 'include',
                                                         'class_filter_array', $classi_filtro,
                                                         'sort_by', $node.sort_array,
                                                         'depth', 1,
                                                         'extended_attribute_filter', hash(
                                                            'id', 'TagsAttributeFilter',
                                                            'params', hash(
                                                                'tag_id', array( $tag.id ),
                                                                'include_synonyms', true()
                                                            )
                                                        ) ) ) }
    {elseif and( $classi_filtro|is_array(), $classi_filtro|count()|gt(0) )}
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
{/if}

{if $node.object.class_identifier|eq('file')}
    {def $file = $node.object.data_map.file}
    {set $node_url = concat("content/download/", $file.contentobject_id, "/", $file.id, "/file/", $file.content.original_filename)|ezurl
         $target = '_blank'}
    {undef $file}
{elseif $node.object.class_identifier|eq('link')}
  {set $node_url = $node.data_map.location.content|ezurl
       $target = '_blank'}
{else}
    {set $node_url = $node.url|ezurl()}
{/if}

<a href={$node_url} target={$target}>
    <span class="Treeview-Item"> 
        {$node.name|wash()}
    </span>
    {if $node|has_attribute('abstract')}
        <span class="Treeview-Item Treeview-Item-Abstract hidden-xs hidden-sm">
            {attribute_view_gui attribute=$node|attribute('abstract')}
        </span>
    {/if}
</a>
{if $children|count()}
    <ul>
    {foreach $children as $child}
        {if $topic_path_array|contains($child.node_id)}
        <li aria-expanded="true">
        {else}
        <li>
        {/if}
            {node_view_gui content_node=$child view=treeview level=$level|sum(1) root_node=$root_node topic_path_array=$topic_path_array classi_filtro=$classi_filtro tag=$tag tree_limit=$tree_limit}
        </li>
    {/foreach}
    </ul>
{/if}