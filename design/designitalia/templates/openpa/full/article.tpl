
{def $images = array()}

{if $node|has_attribute( 'immagini' )}
    {foreach $node.data_map.immagini.content.relation_list as $relation_item}
        {set $images = $images|append(fetch('content','node',hash('node_id',$relation_item.node_id)))}
    {/foreach}
{/if}

<div class="u-content class-{$node.class_identifier}">

    <div class="u-content-main u-content-main-side">
        <div class="u-content-title">
            <h1>{$node.name|wash()}</h1>
            
            {if $node|has_attribute( 'intro' )}
            <div class="u-content-abstract">
                {attribute_view_gui attribute=$node|attribute( 'intro' )}
            </div>
            {/if}
            
            <div class="u-content-date">
                {include uri='design:openpa/parts/full/node_date.tpl'}
            </div>
        </div>

        {if $node|has_attribute( 'body' )}
            <div class="Prose">
                {attribute_view_gui attribute=$node|attribute( 'body' )}
            </div>
        {/if}
        
        {if gt($images|count,0)}
            <div class="u-content-main-image">
                {include uri='design:atoms/image.tpl' item=$images[0] image_class=appini( 'ContentViewFull', 'DefaultImageClass', 'wide' ) caption=$images[0]|attribute( 'caption' ) alignment=center}
            </div>
        {/if}
        
        {include uri='design:openpa/parts/full/tags.tpl'}

    </div>
    
    <div class="u-content-related">
        {include uri='design:openpa/parts/full/related-immagini.tpl'}
        
        {include uri='design:openpa/parts/full/related-stampa.tpl' item=$node}
        
        {include uri='design:openpa/parts/full/related-share.tpl'}
    </div>
</div>

{if $node|has_attribute( 'description' )}
    {include uri='design:openpa/parts/script/time-to-read.tpl' text=$node|has_attribute( 'description' ) }
{/if}
