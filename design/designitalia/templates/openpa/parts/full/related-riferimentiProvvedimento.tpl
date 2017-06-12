{if $node|has_attribute('scheda_informativa')}
<div class="u-content-related-item">
    <h4>
        <i class="mdi mdi-link mdi-24px"></i>
        <span class="u-content-related-item-title">
            {'References'|i18n('designitalia/full')}
        </span>
    </h4>
    
    <div class="Prose">
        {attribute_view_gui attribute=$node|attribute('scheda_informativa')}
    </div>
</div>
 {/if}