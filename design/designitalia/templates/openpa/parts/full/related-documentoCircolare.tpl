{if $node|has_attribute( 'documento' )}
    
<div class="u-content-related-item">
    <h4>
        <i class="mdi mdi-paperclip mdi-24px"></i>
        <span class="u-content-related-item-title">
            {'Main document'|i18n('designitalia/full')}
        </span>
    </h4>
        
    {def $file = $node|attribute( 'documento' )}
    <div class="Prose">
    <ul>
        <li>
            <a href={concat("content/download/",$file.contentobject_id,"/",$file.id,"/file/",$file.content.original_filename)|ezurl} target="_blank">
                <i class="mdi mdi-download"></i>
                {'Download internal measure'|i18n('designitalia/full')}
            </a>
        </li>
    </ul>
    </div>
    {undef $file}
</div>
        
{/if}