{if $node|has_attribute( 'audio' )}
    <div class="u-content-related-item">
        <h4>
            <i class="mdi mdi-speaker mdi-24px"></i>
            <span class="u-content-related-item-title">
                {'Audio'|i18n('designitalia/full')}
            </span>
        </h4>

        {attribute_view_gui attribute=$node|attribute( 'audio' )}
    </div>
{/if}