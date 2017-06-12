{* Nodo di destinazione di DEFAULT per questo repository *}
{def $defaultDestinationNodeID = $repository.definition.DefaultDestinationNodeID}


<div class="Grid FullSearch">
    <div class="Grid-cell u-sm-size2of3 u-md-size2of3 u-lg-size2of3 u-padding-all-xxxl">
        {* TITOLO*}
        <h1 class="u-color-50">
            {'Import content search'|i18n('designitalia/dashboard')}
        </h1>
        
	{if is_set( $repository.results.count )}
            {if $repository.results.count|gt(0)}
                <div class="SearchResult u-padding-top-s u-padding-bottom-xxl">
                    {if $repository.results.count|eq(1)}
                        {'Found %1 result.'|i18n('designitalia/dashboard',,array($repository.results.count))}
                    {else}
                        {'Found %1 results.'|i18n('designitalia/dashboard',,array($repository.results.count))}

                        {'Page'|i18n('designitalia/dashboard')}
                        {if ezhttp_hasvariable('offset', 'get')}
                          {ezhttp('offset', 'get')|div(10)|sum(1)}
                        {else}
                          1
                        {/if}
                        {'of'|i18n('designitalia/dashboard')}
                        {$repository.results.count|div(10)|ceil()}
                    {/if}
                </div>
                
                <p>
		  {foreach $repository.results.fields as $field}
			<span class="label label-primary">{$field.name}: {$field.value}</span>
		  {/foreach}
		</p>
  
		<table class="table table-striped">
		  <tr>
			<th>Titolo</th>	                        
                        {if $repository.ClassIdentifier|eq('image')}
                            <td>Thumbnail</th>
                        {else}
                            <th>Link</th>                          
                        {/if}
                        <th> </th>	
		  </tr>
		{foreach $repository.results.contents as $content}
                    {def $name = cond( is_set( $content.name_t ), $content.name_t, $content.name )
                          $installation_url = cond( is_set( $repository.definition.Url ), $repository.definition.Url, $content.installation_url )
                          $main_url_alias = cond( is_set( $content.main_url_alias_ms ), $content.main_url_alias_ms, $content.main_url_alias )
                          $url = concat( $installation_url, $main_url_alias )
                          $main_node_id = cond( is_set( $content.main_node_id_si ), $content.main_node_id_si, $content.main_node_id )
                          $remote_id = cond( is_set( $content.remote_id_ms ), $content.remote_id_ms, $content.remote_id )
                          $imported = fetch( 'content', 'object', hash( 'remote_id', $remote_id ))}      
                    <tr {if $imported}class="success"{/if} >
                        <td>
                            <small>{$name|wash()}</small>
                        </td>
                        {if $repository.ClassIdentifier|eq('image')}
                            <td>
                                <i class="fa fa-spinner fa-spin fa-2x" id="imgRemote_{$content.node_id[0]}"></i>
                                <img id="aRemote_{$content.node_id[0]}" src="" style="display:none;" width="100" 
                                    data-toggle="modal" data-target="#myModal{$content.node_id[0]}">
                                    <!-- Modal -->
                                    <div id="myModal{$content.node_id[0]}" 
                                         class="modal fade"
                                         tabindex="-1" role="dialog" 
                                        >
                                    <div class="modal-dialog">
                                      <div class="modal-content">                                      
                                            <img id="aRemoteFull_{$content.node_id[0]}" src="" width="900">
                                      </div>
                                       
                                    </div>
                                  </div>
                                </div>
                            </td>
                                
                        {else}
                        <td>
                            {if $repository.definition.OriginalDisabled|eq('true')}
                                
                                {if or( $repository.ClassIdentifier|eq('deliberazione') , $repository.ClassIdentifier|eq('determinazione'))}                                     
                                    <!-- Todo: spostare sotto --> 
                                    <a class="btn btn-sm btn-info" id="aRemote_{$remote_id}" target="_blank" href="" style="display:none;">                            
                                    <i class="fa fa-external-link"></i>
                                    Vai all'originale
                                    </a>                                   
                                    <i class="fa fa-spinner fa-spin fa-2x" id="iRemote_{$remote_id}"></i>                                    
                                {else}    
                                    <a class="btn btn-sm btn-info disabled" href="">
                                    <i class="fa fa-external-link"></i>
                                    Vai all'originale
                                    </a>
                                {/if}
                            {else}
                                <a class="btn btn-sm btn-info" target="_blank" href="{$url}">                            
                                <i class="fa fa-external-link"></i>
                                Vai all'originale
                                </a>
                            {/if}
                        </td>
                        {/if}
                        <td>			  
                            {if $imported}
                                {def $importedNode = $imported.main_node}
                                    <a class="btn btn-sm btn-success" href={$importedNode.url_alias|ezurl()}>
                                        <i class="fa fa-link"></i>
                                        Visualizza
                                    </a>
                                {undef $importedNode}
                            {else}
                                {def $import_url = concat( 'repository/import/', $repository.definition.Identifier, '/', $main_node_id )}
                                {if is_set($defaultDestinationNodeID)}
                                    {set $import_url = concat($import_url, '/', $defaultDestinationNodeID)}
                                {/if}
                                
                                <a class="btn btn-sm btn-danger" href={$import_url|ezurl()}>
                                    <i class="fa fa-download"></i>
                                    Importa
                                </a>
                                {undef $import_url}
                            {/if}			  
                        </td>
                   </tr>
                    {undef $name $installation_url $main_url_alias $url $main_node_id $remote_id $imported}
		{/foreach}
		</table>
                
                <hr>
                          
                {def $googleUrl = ''
                     $next_url = $repository.results.next
                     $prev_url = $repository.results.prev}
                {if $repository.results.next|eq(false)}
                {else}
                    {set $googleUrl = $repository.results.next}
                {/if}
           
                <div class="context-toolbar subitems-context-toolbar">
                    {include name=navigator
                        uri='design:navigator/google_like.tpl'
                        page_uri=$googleUrl
                        item_count=$repository.results.count
                        view_parameters=''
                        item_limit=10}
                </div>
                
            {else}
                <div class="SearchResult u-padding-top-s u-padding-bottom-xxl">
                    {'No results found.'|i18n('designitalia/dashboard')}
                </div>
                
                <p>
		  {foreach $repository.results.fields as $field}
			<span class="label label-primary">{$field.name}: {$field.value}</span>
		  {/foreach}
		</p>
            {/if}
        {else}
            <div class="SearchResult u-padding-top-s u-padding-bottom-xxl">
                {'Use panel on the right to search contents.'|i18n('designitalia/dashboard')}
            </div>
        {/if}
    </div>
    
    <div class="Grid-cell u-background-grey-10 u-sm-size1of3 u-md-size1of3 u-lg-size1of3 u-padding-all-xxl u-layout-centerContent hidden-xs">
        {$repository.form}
    </div>
    
</div>
    
{def $nomeClient =concat( 'Client_', $client.class.identifier )}
{def $siteURL = ezini($nomeClient, 'Url', 'ocrepository.ini')} 


{literal}
    <script type='text/javascript'>
    var $tipoProvvedimento = '{/literal}{$repository.ClassIdentifier}{literal}';
    //alert($tipoProvvedimento);
    switch($tipoProvvedimento) {
        case 'deliberazione':
        case 'determinazione':
        $(document).ready(function(){            
            var $siteURL = '{/literal}{$siteURL}{literal}';        
            $arrayElement = $("a[id^='aRemote_']");
            $arrayElement.each(function(n , val) {
                var $currentId = val.id;
                var $remoteId = $currentId.replace('aRemote_', '');
                get_link_al_provvedimento($remoteId , $tipoProvvedimento , $siteURL);             
            });        
        });        
        break;
        case 'image':
            $(document).ready(function(){           
            var $siteURL = '{/literal}{ezini('Client_immagini', 'Url', 'ocrepository.ini')}{literal}'; 
            alert($siteURL);
            $arrayElement = $("i[id^='imgRemote_']");
             $arrayElement.each(function(n , val) {
                var $currentId = val.id;
                var $remoteId = $currentId.replace('imgRemote_', '');
                get_imgThumbnail($remoteId , $siteURL);       
                });        
            }); 
            break;
    }
    </script> 
 {/literal}
