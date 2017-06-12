
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
        {def $file = $node.object.data_map.file}
        <a href={concat("content/download/", $file.contentobject_id, "/", $file.id, "/file/", $file.content.original_filename)|ezurl} target="_blank">
            <b>{$node.name|wash()}</b>
        </a>
        {undef $file}
    </div>
    {if $node|has_attribute('description')}
        <div class="subtitle">
            {attribute_view_gui attribute=$node|attribute('description')}
        </div>
    {/if}
</div>