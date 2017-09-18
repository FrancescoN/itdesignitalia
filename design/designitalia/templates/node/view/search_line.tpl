<div class="Grid SearchItem">
    <div class="Grid-Cell u-padding-all-m content-view-search_line">
        <h4>
            <a class="text-contrast" href="{$node.url_alias|ezurl('no')}" title="{$node.name|wash()}">{$node.name|wash()}</a>
        </h4>
        
        <div class="SearchItemDate u-padding-top-xs">
            {'Published on'|i18n('designitalia/searchpage')}
            {$node.object.published|l10n(date)} - {$node.class_name}
        </div>
        
        <div class="SearchItemLink u-padding-top-xs">
            <a href={$node.url_alias|ezurl()}> 
                    {$node.path_with_names}
            </a>
        </div>
            
        <p class="SearchItemText u-padding-top-xs">
            {$node.highlight}
        </p>
    </div>
</div>