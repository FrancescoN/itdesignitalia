
{def $can_edit=fetch( 'content', 'access', hash( 'access', 'edit',
                                                 'contentobject', $node ) )}


<div class="u-flow-banner">
    
    {def $background='#83b81a'}
    
    
    {switch match=$node|attribute('color').data_text}
        {case match='0'}
            {set $background='#83b81a'}
        {/case}
        {case match='1'}
            {set $background='#0092d0'}
        {/case}
        {case match='2'}
            {set $background='#cbd300'}
        {/case}
        {case match='3'}
            {set $background='#006390'}
        {/case}
    {/switch}
    
    <div class="u-banner-icon" style="background-color: {$background}">
        <i class="mdi mdi-{$node|attribute('icon_name').data_text}"></i>
    </div>
    {undef $background}
    
    <div class="u-banner-content">
        <div class="u-banner-title">
            {def $target_url = $node.data_map.url.content
                 $external_url = true()}

            {if gt($node.data_map.internal_link.content.relation_list|count(),0)}
                {def $obj = fetch('content','object',hash('object_id',$node.data_map.internal_link.content.relation_list[0].contentobject_id))}
                {set $target_url = $obj.main_node.url_alias|ezurl(no)
                     $external_url = false()}
            {/if}
            
            
            <a href="{$target_url}" {if $external_url}target="_blank"{/if}>
                {$node.name}
            </a>
        </div>
        {if $node|has_attribute('subtitle')}
            <div class="u-banner-subtitle">
                {attribute_view_gui attribute=$node|attribute('subtitle')}
            </div>
        {/if}
        
    </div>
    {if $can_edit}
        <div>
          <a style="float: right;
                    margin-right: 5px;
                    margin-top: -40px;
                    padding-top: 8px;
                    padding-bottom: 8px;
                    padding-left: 10px;
                    padding-right: 10px;
                    color: white;
                    background-color: rgba(0,0,0,0.8);"

                    href={$node.url_alias|ezurl} >
              <h3 style="margin-bottom: 0px; 
                         margin-top: 0px;">
                  <i class="fa fa-pencil"></i>
              </h3>
          </a>
        </div>
    {/if}
   
    
</div>