{if $node|has_attribute( 'allegati' )}
    
<div class="u-content-related-item">
    <h4>
        <i class="mdi mdi-paperclip mdi-24px"></i>
        <span class="u-content-related-item-title">
            {'Attachments'|i18n('designitalia/full')}
        </span>
    </h4>

    {def $rel = null}
    <div class="Prose">
    <ul>
        {foreach $node|attribute( 'allegati' ).content.relation_list as $i}
        {set $rel=fetch('content' , 'node' , hash( 'node_id' , $i.node_id))}
        {if $rel}
            <li>
                <a href="{concat( 'content/download/', $rel.data_map.file.contentobject_id, '/', $rel.data_map.file.id,'/version/', $rel.data_map.file.version , '/file/', $rel.data_map.file.content.original_filename|urlencode )|ezurl( 'no' )}" target="_blank">
                    <i class="mdi mdi-download"></i>

                    {$rel.name}
                </a>
            </li>
        {/if}

        {/foreach}
        </ul>
    </div>
    {undef $rel}

</div>
{/if}
