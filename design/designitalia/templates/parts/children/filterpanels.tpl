{set_defaults(hash(
  'page_limit', 12
))}

{def $root_nodes = array( $node.node_id )
    $self = object_handler( $node )}
{if is_set( $self.content_virtual.folder.subtree )}
 {set $root_nodes = $self.content_virtual.folder.subtree}
{/if}

{def $data = class_search_result(  hash( 'subtree_array', $root_nodes,
                    'sort_by', hash( 'published', 'desc' ),
                    'limit', $page_limit ),
                  $view_parameters )}
           
<div class="Grid FullSearch u-margin-top-m">
    <div class="Grid-cell u-size2of3 u-padding-right-xl">
        {if and( $data.is_search_request, is_set( $view_parameters.class_id ) )}

            <h2>{"SearchResult"|i18n('design/pat_base/generic')}</h2>
            <p class="navigation">
                {foreach $data.fields as $field}
                    <a class="Button Button--info Button--xs" href={concat( $node.url_alias, $field.remove_view_parameters )|ezurl()}>
                    <i class="mdi mdi-close"></i> <strong>{$field.name}:</strong> {$field.value}
                    </a>
                {/foreach}
                <a class="Button Button--danger Button--xs" href={$node.url_alias|ezurl()}>{"CancelSearch"|i18n('design/pat_base/generic')} </a>
            </p>

            {if $data.count}	  
                <div class="Grid Grid--withGutter">
                    {foreach $data.contents as $child }
                         <div class="Grid-cell u-sm-size1of2 u-md-size1of2 u-lg-size1of2" id="content-related-folder">
                             {node_view_gui content_node=$child view=panel image_class=widemedium}
                         </div>
                     {/foreach}
                </div>

                {include name=navigator
                     uri='design:navigator/google.tpl'
                     page_uri=$node.url_alias
                     item_count=$data.count
                     view_parameters=$view_parameters
                     item_limit=$page_limit}
            {else}
                <div class="Prose Alert Alert--warning u-layout-prose u-padding-r-bottom u-padding-r-right u-margin-r-bottom" role="alert">
                    <p class="u-text-p">
                        {"NoResult"|i18n('design/pat_base/generic')}
                    </p>
                </div>
            {/if}	
        {else}
            {include uri='design:parts/children/panels.tpl' filterpanels=true()}
        {/if}
    </div>

    <div class="Grid-cell u-background-grey-10 u-size1of3 u-padding-all-xl u-layout-centerContent hidden-xs">
        {include uri='design:parts/searchform.tpl'}
    </div>
</div>
