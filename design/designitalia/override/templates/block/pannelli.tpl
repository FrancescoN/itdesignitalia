{set_defaults( hash(
    'block_background', 'u-background-white',
    'block_rows', 1,
    'row_index', 0,
    'block_columns', 1,
    'column_index', 0,
    'sort', 'name',
    'block_node', false(),
    'items', array(),
    'sticky_items', array(),

    'depth', 1,
    'limit', 1
) ) }

{set $block_background = $block.custom_attributes.background
     $block_rows = $block.custom_attributes.rows
     $block_columns = $block.custom_attributes.columns
     $limit = $block_rows|mul($block_columns)}

{if $block.type|eq('DesignItaliaList')}
    {if is_set($block.custom_attributes.livello_profondita)}
        {set $depth = $block.custom_attributes.livello_profondita}
    {/if}

    {def $block_include_classes = $block.custom_attributes.includi_classi
         $classes = $block_include_classes|explode(',')}

    {def $sort_array = array( 'name', true())}
    {if $block.custom_attributes.ordinamento}
        {set $sort = $block.custom_attributes.ordinamento}

        {switch match=$sort}
            {case match='name'}
                {set $sort_array = array( 'name', true())}
            {/case}
            {case match='pubblicato'}
                {set $sort_array = array( 'published', false())}
            {/case}
            {case match='modificato'}
                {set $sort_array = array( 'modified', false())}
            {/case}
            {case match='priority'}
                {set $sort_array = array( 'priority', true())}
            {/case}
        {/switch}
    {/if}

    {set $block_node =  fetch('content', 'node', hash( 'node_id', $block.custom_attributes.node_id))}

    {if $block_include_classes|eq('event')}
        {* 
            Se la classe da estrarre è un evento allora filtra estrae tutti quelli
            dell'anno a partire da oggi 
        *}

        {def $timestamp = maketime()
             $current = gettime($timestamp)
             $start = maketime( 0, 0, 0, $current.month, $current.day, $current.year )
             $end = maketime( 23, 59, 59, $current.month, $current.day|sum( 365 ), $current.year )}

        {set $items = fetch('content', 'list', hash( 'parent_node_id', $block.custom_attributes.node_id,
                                                     'sort_by', $sort_array,
                                                     'class_filter_type', 'include',
                                                     'class_filter_array', $classes,
                                                     'attribute_filter', array(
                                                                                    'or',
                                                                                    array( 'event/from_time', 'between', array( $start, $end ) ),
                                                                                    array( 'event/to_time', 'between', array( $start, $end ) )
                                                                               ),
                                                     'limit', $limit,
                                                     'depth', $depth ) ) }

        {undef $timestamp
               $current
               $start
               $end}
    {else}
        {if and(is_set($block.custom_attributes.rilevanza), $block.custom_attributes.rilevanza|eq('yes'))}
            {set $items = fetch('content', 'list', hash( 'parent_node_id', $block.custom_attributes.node_id,
                                                         'sort_by', $sort_array,
                                                         'class_filter_type', 'include',
                                                         'class_filter_array', $classes,
                                                         'attribute_filter', array( array('state', '=', ezini('StateRilevanza','Home','itdesignitalia.ini')) ),
                                                         'limit', $limit,
                                                         'depth', $depth ) )
                 $sticky_items = fetch('content', 'list', hash( 'parent_node_id', $block.custom_attributes.node_id,
                                                                'sort_by', $sort_array,
                                                                'class_filter_type', 'include',
                                                                'class_filter_array', $classes,
                                                                'attribute_filter', array( array('state', '=', ezini('StateRilevanza','Sticky','itdesignitalia.ini')) ),
                                                                'limit', $limit,
                                                                'depth', $depth ) )}
        {else}
            {set $items = fetch('content', 'list', hash( 'parent_node_id', $block.custom_attributes.node_id,
                                                         'sort_by', $sort_array,
                                                         'class_filter_type', 'include',
                                                         'class_filter_array', $classes,
                                                         'limit', $limit,
                                                         'depth', $depth ) )}
        {/if}
        {set $items = $sticky_items|merge($items)}
    {/if}
{else}
    {set $items = $block.valid_nodes}
{/if}
 

<div class="u-flow-panels {$block_background}">
    <section>
        
        <div class="Grid">
            <div class="Grid-cell u-size1of2">
                <h2>
                    {$block.name|wash()}
                </h2>
            </div>

            {if $block_node}
                <div class="Grid-cell u-size1of2 u-textRight">
                    <div class="u-flow-panels-link">
                        {if $block.custom_attributes.see_all_tags|eq('yes')}
                            {if $block.custom_attributes.rilevanza|eq('yes')}
                                {def $states = concat(ezini('StateRilevanza','Home','itdesignitalia.ini'), ';', ezini('StateRilevanza','Sticky','itdesignitalia.ini'))}
                                
                                <a href={concat('tags/view/Vedi tutto?class_filter=',$classes|implode(';'), '&states=',$states)|ezurl}>
                                    {'see all'|i18n('designitalia')}
                                </a>
                                {undef $states}
                            {else}
                                <a href={concat('tags/view/Vedi tutto?class_filter=',$classes|implode(';'))|ezurl}>
                                    {'see all'|i18n('designitalia')}
                                </a>
                            {/if}
                        {else}
                            <a href={$block_node.url_alias|ezurl}>
                                {'see all'|i18n('designitalia')}
                            </a>
                        {/if}
                    </div>
                </div>
            {/if}
        </div>
            
        {def $column_class='Grid-cell'}
        {switch match=$block_columns}
            {case match=1}
                {set $column_class='Grid-cell'}
            {/case}
            {case match=2}
                {set $column_class='Grid-cell u-md-size1of2 u-lg-size1of2'}
            {/case}
            {case match=3}
                {set $column_class='Grid-cell u-sm-size1of2 u-md-size1of2 u-lg-size4of12'}
            {/case}
            {case match=4}
                {set $column_class='Grid-cell u-sm-size1of2 u-md-size4of12 u-lg-size3of12'}
            {/case}
        {/switch}
        
        <div class="Grid">
        {foreach $items as $index => $item max $limit}
            <div class="u-flow-item {$column_class}">
                {node_view_gui view='flowpanel' content_node=$item}
            </div>
        {/foreach}
        </div>

    </section>
</div>

{undef $block_node
       $block_background
       $block_rows
       $row_index
       $block_columns
       $column_index
       $column_class
       $items
       $sticky_items
       $block_include_classes
       $classes
       $sort
       $sort_array}