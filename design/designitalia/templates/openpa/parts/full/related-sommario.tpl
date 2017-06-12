{if $node|has_attribute('sommario')}
    <div class="u-content-related-item">
        <h4>
            <i class="mdi mdi-note-text mdi-24px"></i>
            <span class="u-content-related-item-title">
                {'Summary'|i18n('designitalia/full')}
            </span>
        </h4>
            
        {def $fileSommario = $node|attribute('sommario')}
        
        <a href={concat("content/download/",$fileSommario.contentobject_id,"/",$fileSommario.id,"/file/",$fileSommario.content.original_filename)|ezurl} target="_blank">
        
        {if $node|has_attribute('descrizione_link_sommario')}
            {attribute_view_gui attribute=$node|attribute('descrizione_link_sommario')}
        {else}
            Download
        {/if}
        </a>

    </div>
{/if}