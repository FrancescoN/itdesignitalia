{if $node|has_attribute( 'file' )}
    <div class="u-content-related-item">
        <h4>
            <i class="mdi mdi-download mdi-24px"></i>
            <span class="u-content-related-item-title">
                Download
            </span>
        </h4>
            
        {attribute_view_gui attribute=$node|attribute( 'file' )}
    </div>
{/if}