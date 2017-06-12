{def $can_edit=fetch( 'content', 'access', hash( 'access', 'edit',
                                                 'contentobject', $node ) )}

{def $images = array()}
{def $video = array()}
{def $argomenti = array()}
{if $node|has_attribute( 'immagini' )}
    {foreach $node.data_map.immagini.content.relation_list as $relation_item}
        {set $images = $images|append(fetch('content','node',hash('node_id',$relation_item.node_id)))}
    {/foreach}
{/if}

{if $node|has_attribute( 'video' )}
    {foreach $node.data_map.video.content.relation_list as $relation_item}
        {set $video = $video|append(fetch('content','node',hash('node_id',$relation_item.node_id)))}
    {/foreach}
{/if}

{def $matrix_link_has_content = false()}
{if $node|has_attribute( 'link' )}
    {foreach $node|attribute( 'link' ).content.rows.sequential as $row}
        {foreach $row.columns as $index => $column}
            {if $column|ne('')}
                {set $matrix_link_has_content = true()}
            {/if}
        {/foreach}
    {/foreach}
{/if}

<div class="u-content class-{$node.class_identifier}">

    <div class="u-content-main u-content-main-side">
        <div class="u-content-title">
            <h1>{$node.name|wash()}</h1>
            
            {if $node|has_attribute( 'occhiello' )}
            <div class="u-content-abstract">
                {attribute_view_gui attribute=$node|attribute( 'occhiello' )}
            </div>
            {/if}
            
            {if $node|has_attribute( 'sottotitolo' )}
                <h3>
                    {attribute_view_gui attribute=$node|attribute( 'sottotitolo' )}
                </h3>
            {/if}
            
            <div class="u-content-info">
                {if $node|has_attribute( 'numero' )}
                {if and($node|has_attribute( 'numero' ), $node|attribute( 'numero' ).data_int|ne(0) ) }
                    <span class="date">comunicato stampa n.  {attribute_view_gui attribute=$node|attribute( 'numero' )}</span>
                {/if}
                {/if}
                {if $node|has_attribute( 'published' )}
                   <span class="date"> di {$node|attribute( 'published' ).content.timestamp|l10n( 'date' )} </span>
                {/if}
            </div>
            
            <div class="u-content-date">
                {include uri='design:openpa/parts/full/node_date.tpl'}
            </div>
        </div>
            
        {if $node|has_attribute( 'abstract' )}
            <div class="Prose">
                {attribute_view_gui attribute=$node|attribute( 'abstract' )}
            </div>
        {/if}
            
        {if $node|has_attribute( 'testo_completo' )}
            <div class="Prose">
                {attribute_view_gui attribute=$node|attribute( 'testo_completo' )}
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
        
        {include uri='design:openpa/parts/full/related-struttura.tpl'}
        {include uri='design:openpa/parts/full/related-allegati.tpl'}
        {include uri='design:openpa/parts/full/related-audio.tpl'}
        {include uri='design:openpa/parts/full/related-immagini.tpl'}
        {include uri='design:openpa/parts/full/related-video.tpl'}
        {include uri='design:openpa/parts/full/related-link.tpl'}
        {include uri='design:openpa/parts/full/related-geo.tpl'}
        
        {include uri='design:openpa/parts/full/related-stampa.tpl' item=$node}
        
        {include uri='design:openpa/parts/full/related-share.tpl'}
    </div>
</div>

{if $node|has_attribute( 'description' )}
    {include uri='design:openpa/parts/script/time-to-read.tpl' text=$node|has_attribute( 'description' ) }
{/if}
