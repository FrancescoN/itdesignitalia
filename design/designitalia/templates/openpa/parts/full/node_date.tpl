{* Mev per visibilità data pubblicazione e/o data modifica*}
{def $resultSplit = ''
     $array_state_identifier = $node.object.state_identifier_array}
         
{foreach $array_state_identifier as $state_identifiert}         
    {set $resultSplit = $state_identifiert|explode( '/' )}
    {if eq($resultSplit[0] , 'publish_date_visibility')}
        {switch match=$resultSplit[1]}
            {case match='show_published'}
                {'Published'|i18n('designitalia/full')}
                {$node.object.published|datetime( 'custom', '%d/%m/%Y')}
            {/case}
            {case match='show_modify'}
                {'Updated'|i18n('designitalia/full')}
                {$node.object.modified|datetime( 'custom', '%d/%m/%Y')}
                </div>
            {/case}
            {case match='show_all'}
                 {'Published'|i18n('designitalia/full')}
                {$node.object.published|datetime( 'custom', '%d/%m/%Y')}
                - {'Updated'|i18n('designitalia/full')}
                {$node.object.modified|datetime( 'custom', '%d/%m/%Y')}
            {/case}
            {case}
                {* Default senza date *}
            {/case}
        {/switch}
   {/if}
{/foreach}

{undef $resultSplit
       $array_state_identifier}