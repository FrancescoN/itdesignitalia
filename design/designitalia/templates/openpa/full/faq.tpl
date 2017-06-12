<div class="u-content class-{$node.class_identifier}">

    <div class="u-content-main u-content-main-side">
        <div class="u-content-title">
            <h1>{$node.name|wash()}</h1>
            
            {if $node|has_attribute( 'short_description' )}
            <div class="u-content-abstract">
                {attribute_view_gui attribute=$node|attribute( 'short_description' )}
            </div>
            {elseif $node|has_attribute( 'abstract' )}
            <div class="u-content-abstract">
                {attribute_view_gui attribute=$node|attribute( 'abstract' )}
            </div>
            {/if}
            
             {if $node|has_attribute( 'risposta' )}
                <div class="Prose">
                    {attribute_view_gui attribute=$node|attribute( 'risposta' )}
                </div>
            {/if}
            
            <div class="u-content-date">
                {include uri='design:openpa/parts/full/node_date.tpl'}
            </div>
        </div>
        
        {include uri='design:openpa/parts/full/tags.tpl'}

    </div>
    
    <div class="u-content-related">
        {include uri='design:openpa/parts/full/related-stampa.tpl' item=$node}
        
        {include uri='design:openpa/parts/full/related-share.tpl'}
    </div>
</div>

{if $node|has_attribute( 'description' )}
    {include uri='design:openpa/parts/script/time-to-read.tpl' text=$node|has_attribute( 'description' ) }
{/if}

