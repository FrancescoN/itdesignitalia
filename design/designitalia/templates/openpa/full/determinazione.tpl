<div class="u-content class-{$node.class_identifier}">

    <div class="u-content-main u-content-main-side">
        <div class="u-content-title">
            <h1>{$node.name|wash()}</h1>
            
            {if $node|has_attribute( 'sottotitolo' )}
            <div class="u-content-abstract">
                {attribute_view_gui attribute=$node|attribute( 'sottotitolo' )}
            </div>
            {/if}
            
            <div class="u-content-date">
                {include uri='design:openpa/parts/full/node_date.tpl'}
            </div>
        </div>
            
        {if $node|has_attribute( 'oggetto' )}
            <div class="Prose">
                {attribute_view_gui attribute=$node|attribute( 'oggetto' )}
            </div>
        {/if}

        {if $node|has_attribute( 'testo' )}
            <div class="Accordion fr-accordion js-fr-accordion u-margin-top-m" id="accordion-1">
                <h2 class="Accordion-header js-fr-accordion__header fr-accordion__header" id="accordion-header-0">
                    <span class="Accordion-link u-text-r-s">
                        {'Show measure text'|i18n('designitalia/full')}
                    </span>
                </h2>
                <div id="accordion-panel-0" class="Accordion-panel fr-accordion__panel js-fr-accordion__panel">
                    <div class="Prose  u-text-p u-padding-r-all" style="text-align: justify">
                        {attribute_view_gui attribute=$node|attribute( 'testo' )}
                    </div>
                </div>
            </div>
        {/if}
        
        {include uri='design:openpa/parts/full/tags.tpl'}

    </div>
    
    <div class="u-content-related">
        
        {include uri='design:openpa/parts/full/related-riferimentiProvvedimento.tpl'}
        
        {include uri='design:openpa/parts/full/related-infoProvvedimento.tpl'}
       
        {include uri='design:openpa/parts/full/related-linkProvvedimento.tpl'}
        
        {include uri='design:openpa/parts/full/related-stampa.tpl' item=$node}
        
        {include uri='design:openpa/parts/full/related-share.tpl'}
    </div>
</div>

{if $node|has_attribute( 'testo' )}
    {include uri='design:openpa/parts/script/time-to-read.tpl' text=$node|attribute( 'testo' )}
{/if}
