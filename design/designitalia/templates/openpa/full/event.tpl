{def $images = array()}
{if $node|has_attribute( 'immagini' )}
    {foreach $node.data_map.immagini.content.relation_list as $relation_item}
        {set $images = $images|append(fetch('content','node',hash('node_id',$relation_item.node_id)))}
    {/foreach}
{/if}

{def $allegatiArray = array()}
{if $node|has_attribute( 'allegati' )}
    {foreach $node.data_map.allegati.content.relation_list as $relation_itemAllegati}
        {set $allegatiArray = $allegatiArray|append(fetch('content','node',hash('node_id',$relation_itemAllegati.node_id)))}
    {/foreach}
{/if}

<div class="u-content class-{$node.class_identifier}">

    <div class="u-content-main u-content-main-side">
        <div class="u-content-title">
            <h1>{$node.name|wash()}</h1>
            
            {if $node|has_attribute( 'short_title' )}
            <div class="u-content-abstract">
                {attribute_view_gui attribute=$node|attribute( 'short_title' )}
            </div>
            {/if}
            
            <h3>
                {if $node|has_attribute( 'short_description' )}
                {attribute_view_gui attribute=$node|attribute( 'short_description' )}
                {/if}
            </h3>
            
            <div class="u-content-date">
                {include uri='design:openpa/parts/full/node_date.tpl'}
            </div>
        </div>

        {if $node|has_attribute( 'abstract' )}
            <div class="Prose">
                {attribute_view_gui attribute=$node|attribute( 'abstract' )}
            </div>
        {/if}
        
        {if $node|has_attribute( 'informazioni' )}
          <div class="Prose">
            {attribute_view_gui attribute=$node|attribute( 'informazioni' )}
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
        {include uri='design:openpa/parts/full/related-date.tpl'}
        {include uri='design:openpa/parts/full/related-immagini.tpl'}
        {include uri='design:openpa/parts/full/related-link.tpl' attribute_name='url'}
        {include uri='design:openpa/parts/full/related-allegati.tpl'}
        {include uri='design:openpa/parts/full/related-geo.tpl'}
        {*include uri='design:openpa/parts/full/related-contatti.tpl'*}
        
        {include uri='design:openpa/parts/full/related-stampa.tpl' item=$node}
        
        {include uri='design:openpa/parts/full/related-share.tpl'}
    </div>
</div>

{if $node|has_attribute( 'description' )}
    {include uri='design:openpa/parts/script/time-to-read.tpl' text=$node|has_attribute( 'description' ) }
{/if}
