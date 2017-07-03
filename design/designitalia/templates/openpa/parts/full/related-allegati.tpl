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
                    {def $icon = "mdi-file"
                         $name_array = $rel.data_map.file.content.original_filename|explode('.')
                         $name_size = count($name_array)
                         $extension = $name_array[$name_size|sub(1)]}
                    
                    {if $extension|eq('pdf')}
                        {set $icon = "mdi-file-pdf"}
                    {elseif or($extension|eq('doc'), $extension|eq('docx'))}
                        {set $icon = "mdi-file-word"}
                    {elseif or($extension|eq('xls'), $extension|eq('xlsx'))}
                        {set $icon = "mdi-file-excel"}
                    {/if}
                    
                    <i class="mdi {$icon}"></i>
                    
                    {$rel.name}
                    
                    {undef $icon}
                </a>
            </li>
        {/if}

        {/foreach}
        </ul>
    </div>
    {undef $rel}

</div>
{/if}
