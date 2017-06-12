{def $currentClass = false()}
    {if is_set( $classes )}
        {def $__classes = array()}
        {foreach $classes as $class_id}
            {set $__classes = $__classes | append( fetch( 'content', 'class', hash( 'class_id', $class_id) ) )}
        {/foreach}
    {elseif is_set( $self.content_virtual.folder.classes )}
      {def $__classes = fetch( 'class', 'list', hash( 'class_filter', $self.content_virtual.folder.classes ) )}
    {else}
      {def $__classes = fetch( 'ocbtools', 'children_classes', hash( 'parent_node_id', $node.node_id ) )}
    {/if}
    
    {if and(is_set($data), $data.is_search_request)}	
      {set $currentClass = cond( is_set( $data.fetch_parameters.class_id ), $data.fetch_parameters.class_id, $__classes[0].id )}  
    {elseif count( $__classes )|eq(1)}
      {set $currentClass = $__classes[0].id}  	
    {/if}

    {if $currentClass|not()}
      {set $currentClass = $__classes[0].id}
    {/if}
    
    {def $form_action = concat('tags/view/', $tag.keyword)|ezurl('no')}
    
    {if $tag.parent}
        {set $form_action = concat('tags/view/', $tag.parent.keyword, '/', $tag.keyword)|ezurl('no')}
    {/if}
 
    {if count( $__classes )|gt(0)}
        <div class="searchform">
            <div class="searchform-content">

              {if count( $__classes )|gt(1)}
              <ul class="nav nav-tabs" role="tablist">	  
                    {foreach $__classes as $class}
                    <li{if $currentClass|eq( $class.id )} class="active"{/if}><a href="#{$class.identifier}" role="tab" data-toggle="tab">{$class.name|wash()}</a></li>
                    {/foreach}	  
              </ul>      
              {/if}

              <div class="tab-content">
                    {def $redirect_node_id = hash( 'RedirectNodeID', 2 )}

                    {if is_set($node)}
                        {set $redirect_node_id = hash( 'RedirectNodeID', $node.node_id )}
                    {/if}
                    
                    {foreach $__classes as $class}
                    <div class="tab-pane{if $currentClass|eq( $class.id )} active{/if}" id="{$class.identifier}">
                        {class_search_form( $class.identifier, $redirect_node_id )}
                    </div>
                    {/foreach}
              </div>

            </div>
        </div>
    {/if}
    
    {literal}
        <script>
            $(document).ready(function(){
                $(".Form-label").each(function(){
                    console.log( $(this).attr('for') + ": " + $("#"+$(this).attr('for')).val() );
                    
                    if( $("#"+$(this).attr('for')).val() === '' ){
                        $(this).css('opacity', 1);
                    } 
                });
                
                // Toglie la label sul focus
                $(".Form-input").focusin(function(){
                    var label = $("label[for='"+$(this).attr('id')+"']");
                    label.css('opacity', 0);
                });
                
                // Mette la label sulla perdita del focus se non è valorizzato
                $(".Form-input").focusout(function(){
                    if($(this).val() === ''){
                        var label = $("label[for='"+$(this).attr('id')+"']");
                        label.css('opacity', 1);
                    }
                });
            });
        </script>
    {/literal}