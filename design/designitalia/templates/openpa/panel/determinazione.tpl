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
            <a href="{$openpa.content_link.full_link}" title="{$node.name|wash()}">
                {$node.name|openpa_shorten(60)|wash()}
            </a>
        </h3>

        <div class="Card-text">
        {if $node|has_attribute('oggetto')}
            {$node.data_map.oggetto.content|openpa_shorten(270)}
        {/if}
        </div>
    </div>
    
</div>