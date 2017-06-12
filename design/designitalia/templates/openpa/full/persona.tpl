<div class="u-content class-{$node.class_identifier}">

    <div class="u-content-main u-content-main-side">
        <div class="u-content-title">
            <h1>{$node.name|wash()}</h1>
            
            <div class="u-content-date">
                {*include uri='design:openpa/parts/full/node_date.tpl'*}
            </div>
        </div>

        <div class="Grid Prose u-padding-top-xxl">
            <div class="Grid-cell u-size1of3 u-color-80 u-textItalic">
                {'Last Name'|i18n('designitalia/full')}
            </div>
            <div class="Grid-cell u-size2of3">
                {attribute_view_gui attribute=$node|attribute('cognome')}
            </div>
            
            <div class="Grid-cell u-size1of3 u-color-80 u-textItalic">
                {'First Name'|i18n('designitalia/full')}
            </div>
            <div class="Grid-cell u-size2of3">
                {attribute_view_gui attribute=$node|attribute('nome')}
            </div>
            
            <div class="Grid-cell u-size1of3 u-margin-top-s u-color-80 u-textItalic">
                {'Phone'|i18n('designitalia/full')}
            </div>
            <div class="Grid-cell u-size2of3 u-margin-top-s">
                {attribute_view_gui attribute=$node|attribute('telefono')}
            </div>
            
            <div class="Grid-cell u-size1of3 u-color-80 u-textItalic">
                Fax
            </div>
            <div class="Grid-cell u-size2of3">
                {attribute_view_gui attribute=$node|attribute('fax')}
            </div>
            
            <div class="Grid-cell u-size1of3 u-margin-top-s u-color-80 u-textItalic">
                Email
            </div>
            <div class="Grid-cell u-size2of3 u-margin-top-s">
                <a href="mailto:{attribute_view_gui attribute=$node|attribute('email')}">
                    {attribute_view_gui attribute=$node|attribute('email')}
                </a>
            </div>
        </div>     
        
        {*include uri='design:openpa/parts/full/tags.tpl'*}

    </div>
    
    <div class="u-content-related">
        {include uri='design:openpa/parts/full/related-servizio.tpl'}
        
        {include uri='design:openpa/parts/full/related-stampa.tpl' item=$node}
        
        {include uri='design:openpa/parts/full/related-share.tpl'}
    </div>
</div>

{if $node|has_attribute( 'description' )}
    {include uri='design:openpa/parts/script/time-to-read.tpl' text=$node|has_attribute( 'description' ) }
{/if}
