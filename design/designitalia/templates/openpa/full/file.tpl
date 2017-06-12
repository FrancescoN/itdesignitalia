<div class="u-content class-{$node.class_identifier}">

    <div class="u-content-main u-content-main-side">
        <div class="u-content-title">
            <h1>{$node.name|wash()}</h1>
            
            {if $node|has_attribute( 'short_description' )}
            <div class="u-content-abstract">
                {attribute_view_gui attribute=$node|attribute( 'short_description' )}
            </div>
            {elseif $node|has_attribute( 'abstract' )}
            <div class="u-content-abstract">
                {attribute_view_gui attribute=$node|attribute( 'abstract' )}
            </div>
            {/if}
            
            <div class="u-content-date">
                {include uri='design:openpa/parts/full/node_date.tpl'}
            </div>
        </div>

        {if $node|has_attribute( 'descrizione' )}
            <div class="Prose">
                {attribute_view_gui attribute=$node|attribute( 'descrizione' )}
            </div>
        {elseif $node|has_attribute( 'description' )}
             <div class="Prose">
                {attribute_view_gui attribute=$node|attribute( 'description' )}
            </div>   
        {/if}
        
        {def $file = $node|attribute( 'file' )}
        <a class="Button Button--default u-text-r-xs" href={concat("content/download/",$file.contentobject_id,"/",$file.id,"/file/",$file.content.original_filename)|ezurl}>
            <span class="u-color-white">
                <i class="mdi mdi-download mdi-36px"></i>
                {'Download file'|i18n('designitalia/full')}
            </span>
        </a>
        {undef $file}
        
        {include uri='design:openpa/parts/full/tags.tpl'}

    </div>
    
    <div class="u-content-related">
        {include uri='design:openpa/parts/full/related-share.tpl'}
    </div>
</div>

{if $node|has_attribute( 'description' )}
    {include uri='design:openpa/parts/script/time-to-read.tpl' text=$node|has_attribute( 'description' ) }
{/if}
