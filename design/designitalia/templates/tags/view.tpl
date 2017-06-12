{def $limit = 24
     $class_filter = ezhttp('class_filter', 'get')
     $classes=$class_filter|explode(';')
     $nodes=array()
     $nodes_count=0}

<div class="u-content">
    <div class="u-content-main">
        <div class="u-content-title">
            <h1>
                <i class="mdi mdi-tag-multiple"></i> 
                {$tag.keyword|wash}
            </h1>
        </div>

        {if $class_filter|ne('')}
            {*Filtro sulle classi passato via get*}
            
            {set $nodes = fetch( content, tree, hash( parent_node_id, ezini( 'NodeSettings', 'RootNode', 'content.ini' ),
                                                      class_filter_type, 'include',
                                                      class_filter_array, $classes,
                                                      extended_attribute_filter,
                                                            hash( id, TagsAttributeFilter,
                                                            params, hash( tag_id, $tag.id, include_synonyms, true() ) ),
                                                      offset, first_set( $view_parameters.offset, 0 ),
                                                      limit, $limit,
                                                      main_node_only, true(),
                                                      sort_by, array( published, false() ) ) )
                $nodes_count = fetch( content, tree_count, hash( parent_node_id, ezini( 'NodeSettings', 'RootNode', 'content.ini' ),
                                                                 class_filter_type, 'include',
                                                                 class_filter_array, $classes,
                                                                 extended_attribute_filter,
                                                                        hash( id, TagsAttributeFilter,
                                                                        params, hash( tag_id, $tag.id, include_synonyms, true() ) ),
                                                                        main_node_only, true() ) )}
        {else}
            {set $nodes = fetch( content, tree, hash( parent_node_id, ezini( 'NodeSettings', 'RootNode', 'content.ini' ),
                                                      extended_attribute_filter,
                                                            hash( id, TagsAttributeFilter,
                                                            params, hash( tag_id, $tag.id, include_synonyms, true() ) ),
                                                      offset, first_set( $view_parameters.offset, 0 ),
                                                      limit, $limit,
                                                      main_node_only, true(),
                                                      sort_by, array( published, false() ) ) )
                $nodes_count = fetch( content, tree_count, hash( parent_node_id, ezini( 'NodeSettings', 'RootNode', 'content.ini' ),
                                                                  extended_attribute_filter,
                                                                        hash( id, TagsAttributeFilter,
                                                                        params, hash( tag_id, $tag.id, include_synonyms, true() ) ),
                                                                        main_node_only, true() ) )}
        {/if}

        {if $nodes|count}
            <div class="js-Masonry-container u-layout-medium" data-columns>
                {foreach $nodes as $child }
                    <div class="Masonry-item js-Masonry-item">
                        {node_view_gui content_node=$child view=panel image_class=widemedium}
                    </div>
                {/foreach}
            </div>

        {else}
            <ul class="list-inline list-tags">
                {def $all_tags = fetch( tags, list, hash( parent_tag_id, $tag.id ) )}
                {foreach $all_tags as $child_tag sequence array('bglight', 'bgdark') as $sequence}
                    {if not($child_tag.keyword|begins_with('#' ))}
                        <li class="label">
                            <a class="Button Button--info" href={concat("/tags/view/",$child_tag.url)|ezurl()}>
                                <i class="mdi mdi-tag"></i>
                                {$child_tag.keyword|wash}
                            </a>
                        </li>
                    {/if}
                {/foreach} 
            </ul>
        {/if}

        {include uri='design:navigator/google.tpl'
                 page_uri=concat( '/tags/view/', $tag.url )
                 item_count=$nodes_count
                 view_parameters=$view_parameters
                 item_limit=$limit}
    </div>
</div>

{undef $limit $nodes $nodes_count}
