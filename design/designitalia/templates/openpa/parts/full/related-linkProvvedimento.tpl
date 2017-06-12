
<div class="u-content-related-item">
    <h4>
        <i class="mdi mdi-book-multiple mdi-24px"></i>
        <span class="u-content-related-item-title">
            {'Regulations'|i18n('designitalia/full')}
        </span>
    </h4>
        
    <div class="Prose">
        <ul>
            {if $node|has_attribute('link_al_provvedimento')}
                <li>     
                    <a target="_blank" href="{$node|attribute('link_al_provvedimento').content}" >
                        <i class="mdi mdi-link-variant"></i>
                        {'Original measure'|i18n('designitalia/full')}
                    </a>
                </li>
            {/if}
            {if $node|has_attribute('link_al_pdf')}
                 <li>
                    <a target="_blank" href="{$node|attribute('link_al_pdf').content}" >
                        <i class="mdi mdi-file-pdf"></i>
                        {'Measure text'|i18n('designitalia/full')}
                    </a>
                </li>
            {/if}
            {if $node|has_attribute('allegati')}
                 <li>
                    {def $curAllegati = $node|attribute('allegati').content}
                    {def $curList=$curAllegati|explode('$')}
                    {foreach $curList as $object}
                        {if $object}
                            {def $curHref=$object|explode('|')}
                            <a href="{$curHref[1]}" >
                                <i class="mdi mdi-file-pdf"></i>
                                {$curHref[0]}
                            </a>
                         {/if}
                         {delimiter} <br/> {/delimiter}
                    {/foreach}
                 </li>
            {/if}
        </ul>
   </div>
</div>
