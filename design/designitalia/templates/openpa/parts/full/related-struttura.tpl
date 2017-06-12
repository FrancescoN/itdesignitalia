{if $node|has_attribute( 'struttura' )}
    <div class="u-content-related-item">
        <h4>
            <i class="mdi mdi-file-tree mdi-24px"></i>
            <span class="u-content-related-item-title">
                {'Reference'|i18n('designitalia/full')}
            </span>
        </h4>

        {attribute_view_gui attribute=$node|attribute( 'struttura' ) show_link=true()}
    </div>
{/if}