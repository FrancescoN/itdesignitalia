{*
  client OCRepositoryContentClassClient
  class eZContentClass
  sort_form html tpl @todo
  published_form html tpl @todo
*}
{def $myResult = ''}



<div class="repository_search">
    
    {def $nomeClient =concat( 'Client_', $client.class.identifier )}
    {def $classidentifier = $client.class.identifier}
    {def $idProponenti = ezini($nomeClient, 'AttributeIdProponenti', 'ocrepository.ini')} 
    
    <form name="{concat('class_search_form_',$client.class.identifier)}" method="get" action="{$form_action}">

        {*include uri='design:class_search_form/query.tpl' client=$client input=$client.query_field*}
        <h4>
            {"Search"|i18n('design/pat_base/generic')} <small>{$client.class.identifier}</small>
        </h4>

        {foreach $attribute_fields as $field}           
            {if $field|contains('search-for-')}                 
                {set $myResult = $field|explode('search-for-')[1]}
                {set $myResult = $myResult|explode('>')[0]}
                {set $myResult = $myResult|trim()}
            {/if}
            <div id='div-search-for-{$myResult}'>{$field}
                 <div id='div-select-for-{$myResult}'></div>
            </div>
        {/foreach}

        {*include uri='design:class_search_form/sort.tpl' client=$client input=$client.sort_field}

        {include uri='design:class_search_form/publish_date.tpl' client=$client input=$client.published_field*}

        {foreach $parameters as $key => $value}
              <input type="hidden" name="{$key}" value="{$value}" />
        {/foreach}

        <input type="hidden" name="class_id" value="{$remote_class_id}" />  

        <button class="defaultbutton" type="submit">
            <i class="fa fa-search"></i>
            {'Search'|i18n('design/pat_base/generic')}
        </button>
    </form>
</div>
        
        
{literal}
    <script type='text/javascript'>
    $(document).ready(function(){
        var siteURL = '{/literal}{ezini(concat( 'Client_', $client.class.identifier ), 'RemoteUrlProponenti', 'ocrepository.ini')}{literal}';        
        get_proponenti_provvedimenti('{/literal}{$idProponenti}{literal}','{/literal}{$classidentifier}{literal}',siteURL);
    });
    </script> 
 {/literal}  
 {undef $nomeClient
        $classidentifier
        $idProponenti} 