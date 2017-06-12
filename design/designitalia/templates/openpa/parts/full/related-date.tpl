{if $node|has_attribute( 'from_time' )}
    <div class="u-content-related-item">
        <h4>
            <i class="mdi mdi-calendar-range mdi-24px"></i>
            <span class="u-content-related-item-title">
                {'Dates'|i18n('designitalia/full')}
            </span>
        </h4>

        <small>
            da <b>{$node|attribute( 'from_time' ).content.timestamp|l10n(date)}</b>
            <br/>
            {if $node.data_map.to_time.has_content}
                a <b>{$node|attribute( 'to_time' ).content.timestamp|l10n(date)}</b>
            {/if}
        </small>
        {if $node|has_attribute('note_orario')}
            <p>
                <small>
                    {attribute_view_gui attribute=$node|attribute( 'note_orario' )}
                </small>
            </p>
        {/if}
    </div>
{/if}
