{if $node|has_attribute( 'persone' )}
    
<div class="u-content-related-item">
    <h4>
        <i class="mdi mdi-account-multiple mdi-24px"></i>
        <span class="u-content-related-item-title">
            {'People'|i18n('designitalia/full')}
        </span>
    </h4>
    
    {def $rel = null}
    <div class="Prose">
        <ul>
            {foreach $node|attribute( 'persone' ).content.relation_list as $i}
            {set $rel=fetch('content' , 'node' , hash( 'node_id' , $i.node_id))}
            {if $rel}
                <li>
                    <a href={$rel.url_alias|ezurl()}>
                        <i class="mdi mdi-account"></i>
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

