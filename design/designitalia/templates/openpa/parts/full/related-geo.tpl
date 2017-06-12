{if $node|has_attribute( 'geo' )}
    <div class="u-content-related-item">
        <div class="Grid">
            <div class="Grid-Cell u-size1of2">
                <h4>
                    <i class="mdi mdi-map-marker mdi-24px"></i>
                    <span class="u-content-related-item-title">
                        {'Location'|i18n('designitalia/full')}
                    </span>
                </h4>
            </div>
            <div class="Grid-Cell u-size1of2 u-textRight">
                <a target="_blank" href="https://www.google.com/maps/dir//'{$node.data_map.geo.content.latitude},{$node.data_map.geo.content.longitude}'/@{$node.data_map.geo.content.latitude},{$node.data_map.geo.content.longitude},15z?hl=it">
                    {'How to get'|i18n('designitalia/full')}
                </a>
            </div>
        </div>
        
        {*if $node|has_attribute( 'indirizzo' )}
            <small>
                {attribute_view_gui attribute=$node|attribute('indirizzo')}
            </small>
        {/if*}
        {attribute_view_gui attribute=$node.data_map.geo zoom=3}
    </div>
{/if}