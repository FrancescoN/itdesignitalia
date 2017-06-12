
<div class="u-flow-event u-flow-panel-{$node.object.class_identifier}">

    <div class="u-event-when">
        <div class="u-event-monthday">
            {$node|attribute( 'from_time' ).content.timestamp|datetime('custom', '%d')}
        </div>
        <div class="u-event-month">
            {$node|attribute( 'from_time' ).content.timestamp|datetime('custom', '%F')|upcase()}
        </div>
    </div>

    <div class="u-event-what">
        <div class="u-event-title">
            <a href={$node.url|ezurl}>
                {$node.name|openpa_shorten(60)|wash()}
            </a>
        </div>
        <div class="u-event-subtitle">
            {if $node|has_attribute( 'short_title' )}
                {attribute_view_gui attribute=$node|attribute( 'short_title' )}
            {/if}
        </div>
        <div class="u-event-where">
            {if $node|has_attribute( 'comune' )}
                {attribute_view_gui attribute=$node|attribute( 'comune' )}
            {/if}
        </div>
    </div>
</div>