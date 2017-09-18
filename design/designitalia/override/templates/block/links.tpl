{set_defaults( hash(
    'block_background', 'u-background-white',
    'block_rows', 1,
    'row_index', 0,
    'block_columns', 1,
    'column_index', 0,
    'sort', 'name',
    
    'depth', 1
) ) }

{if is_set($block.custom_attributes.livello_profondita)}
    {set $depth = $block.custom_attributes.livello_profondita}
{/if}

{set $block_background = $block.custom_attributes.background
     $block_rows = $block.custom_attributes.rows
     $block_columns = $block.custom_attributes.columns}
     
{def $limit = $block_rows|mul($block_columns)
     $block_include_classes = $block.custom_attributes.includi_classi
     $classes = $block_include_classes|explode(',')}
     
{def $sort_array = array( 'name', true())}
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

{def $items = fetch('content', 'list', hash( 'parent_node_id', $block.custom_attributes.node_id,
                                             'sort_by', $sort_array,
                                             'class_filter_type', 'include',
                                             'class_filter_array', $classes,
                                             'limit', $limit,
                                             'depth', $depth ) ) }

<div class="Links {$block_background} u-layout-centerContent u-padding-r-top">
    <section class="u-layout-wide u-layout-r-withGutter u-text-r-s u-padding-r-top u-padding-r-bottom">
        
        <h2 class="u-layout-centerLeft u-text-r-s">
            <a class="u-color-50 u-textClean u-text-h3" href={$block_node.url_alias|ezurl}>
                {$block.name|wash()}
            </a>
        </h2>

            
        {def $column_class='Grid-cell'}
        {switch match=$block_columns}
            {case match=1}
                {set $column_class='Grid-cell'}
            {/case}
            {case match=2}
                {set $column_class='Grid-cell u-md-size1of2 u-lg-size1of2'}
            {/case}
            {case match=3}
                {set $column_class='Grid-cell u-md-size4of12 u-lg-size4of12'}
            {/case}
            {case match=4}
                {set $column_class='Grid-cell u-md-size3of12 u-lg-size3of12'}
            {/case}
        {/switch}
        
        <div class="Grid">
        {foreach $items as $index => $item}
            <div class="Item {$column_class}">
                <div class="Link u-margin-all-l">
                    <div class="title">
                        <a href={$item.url|ezurl}>
                            <b>{$item.name}</b>
                        </a>
                    </div>
                    {if $item|has_attribute('abstract')}
                        <div class="subtitle">
                            {attribute_view_gui attribute=$item|attribute('abstract')}
                        </div>
                    {elseif $item|has_attribute('intro')}
                        <div class="subtitle">
                            {attribute_view_gui attribute=$item|attribute('intro')}
                        </div>
                    {elseif $item|has_attribute('sottotitolo')}
                        <div class="subtitle">
                            {attribute_view_gui attribute=$item|attribute('sottotitolo')}
                        </div>
                    {/if}
                </div>
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
       $length
       $items
       $block_include_classes
       $classes
       $sort
       $sort_array}