{if $node|has_attribute('informazioni')}
    
<div class="u-content-related-item">
    <h4>
        <i class="mdi mdi-information mdi-24px"></i>
        <span class="u-content-related-item-title">
            {'Informations'|i18n('designitalia/full')}
        </span>
    </h4>

    {attribute_view_gui attribute=$node|attribute('informazioni')}
</div>
{/if}
