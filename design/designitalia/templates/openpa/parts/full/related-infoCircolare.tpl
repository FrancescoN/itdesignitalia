<div class="u-content-related-item">
    
    <h4>
        <i class="mdi mdi-file-document-box mdi-24px"></i>
        <span class="u-content-related-item-title">
            {'Card'|i18n('designitalia/full')}
        </span>
    </h4>
        
    {if $node|has_attribute('struttura_competente')}
        <strong>{'Competent organizational structure'|i18n('designitalia/full')}</strong>
        <div class="Prose">
            {attribute_view_gui attribute=$node|attribute('struttura_competente')}
        </div>
    {/if}

    {if $node|has_attribute('numero')}
        <strong>{'Protocol number'|i18n('designitalia/full')}</strong>
        <div class="Prose">
            {attribute_view_gui attribute=$node|attribute('numero')}
        </div>
    {/if}
    
    {if $node|has_attribute('data')}
        <strong>{'Protocol date'|i18n('designitalia/full')}</strong>
        <div class="Prose">
            {attribute_view_gui attribute=$node|attribute('data')}
        </div>
    {/if}
    
    {if $node|has_attribute('settore_riferimento')}
        <strong>{'Office/Sector'|i18n('designitalia/full')}</strong>
        
        <div class="Prose">
            {attribute_view_gui attribute=$node|attribute('settore_riferimento')}
        </div>
    {/if}  
</div>
