
<div class="u-flow-panel u-flow-panel-{$node.object.class_identifier}">
    <div class="u-flow-icon">
        {def $icon=ezini('BlockClassIcon', '_Default', 'itdesignitalia.ini')}

        {if ezini_hasvariable('BlockClassIcon', $node.object.content_class.identifier, 'itdesignitalia.ini')}
            {set $icon=ezini('BlockClassIcon', $node.object.content_class.identifier, 'itdesignitalia.ini')}
        {/if}

        <i class="mdi mdi-24px mdi-{$icon}"></i>
        {undef $icon}
    </div>

    <div class="title">
        <a href={$node.url|ezurl}>
            <b>{$node.name|wash()}</b>
        </a>
    </div>
    {*
    {if $node|has_attribute('abstract')}
        <div class="subtitle">
            {attribute_view_gui attribute=$node|attribute('abstract')}
        </div>
    {elseif $node|has_attribute('intro')}
        <div class="subtitle">
            {attribute_view_gui attribute=$node|attribute('intro')}
        </div>
    {elseif $node|has_attribute('sottotitolo')}
        <div class="subtitle">
            {attribute_view_gui attribute=$node|attribute('sottotitolo')}
        </div>
    {/if}
    *}
</div>