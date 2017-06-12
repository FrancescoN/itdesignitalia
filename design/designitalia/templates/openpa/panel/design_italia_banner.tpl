<div class="Card Card--withBorder u-color-grey-30 u-margin-all-xxs">
    
    {if or($node|has_attribute( 'immagini' ), $node|has_attribute( 'image' ))} 
        <div class="Card-image">
            <a href={$node.url_alias|ezurl()} title="{$node.name|wash()}">
                {if $node|has_attribute( 'immagini' )}
                    {def $com_img = fetch('content','node',hash('node_id',$node.data_map.immagini.content.relation_list[0].node_id))}
                    {def $com_img_url = $com_img|attribute('image').content['imagefull_cutwide']}

                    <figure style="background: url( {$com_img_url.url|ezroot(no)} )"></figure>

                    {undef $com_img
                           $com_img_url}
                {else}
                    {def $com_img_url = $node|attribute('image').content['imagefull_cutwide']}

                    <figure style="background: url( {$node|attribute('image').content.original.full_path|ezroot(no)} )"></figure>

                    {undef $com_img_url}
                {/if}
            </a>
        </div>
    {/if}
  
    
    <div class="Card-content u-padding-r-all"> 
        <h3 class="Card-title">
            {def $target_url = $node.data_map.url.content
                 $external_url = true()}

            {if gt($node.data_map.internal_link.content.relation_list|count(),0)}
                {def $obj = fetch('content','object',hash('object_id',$node.data_map.internal_link.content.relation_list[0].contentobject_id))}
                {set $target_url = $obj.main_node.url_alias|ezurl(no)
                     $external_url = false()}
            {/if}
            
            <a href="{$target_url}" {if $external_url}target="_blank"{/if} title="{$node.name|wash()}">
                {$node.name|openpa_shorten(60)|wash()}
            </a>
        </h3>

        <div class="Card-text">
        {if $node|has_attribute('short_description')}
            {attribute_view_gui attribute=$node|attribute('short_description')}
        {/if}
        </div>
    </div>
    
</div>