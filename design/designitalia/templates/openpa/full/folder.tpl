
{*set-block scope=root variable=cache_ttl}0{/set-block*}

{def $children_view=$node.data_map.children_view.class_content.options[$node.data_map.children_view.value[0]].name|downcase()
     $col_width=6
     $modulo=2
     $classi_filtro=array()}

{if $children_view|eq('facetdatatable')}
    {* Se devo visualizzare una ricerca a faccette devo reimplementare l'intera pagina *}
    
    {include uri=concat('design:parts/children/', $children_view, '.tpl')}
    
{else}
    <div class="u-content class-{$node.class_identifier}">

        <div class="u-content-main">
            <div class="u-content-title">
                <h1>{$node.name|wash()}</h1>


                {if $node|has_attribute( 'short_description' )}
                <div class="u-content-abstract">
                    {attribute_view_gui attribute=$node|attribute( 'short_description' )}
                </div>
                {/if}

                <div class="u-content-date">
                    {include uri='design:openpa/parts/full/node_date.tpl'}
                </div>
            </div>

            {*def $show_image=true()}
            {if $node.data_map.show_image.content|eq(0) }
                {set $show_image=false()}
            {/if}
            {if and($node|has_attribute( 'image' ), $show_image)}
                {include uri='design:atoms/image.tpl' item=$node image_class=appini( 'ContentViewFull', 'DefaultImageClass', 'wide' ) css_classes="image-main"}
            {/if}
            {*undef $show_image*}

            {if $node|has_attribute( 'description' )}
                <div class="description">
                    {attribute_view_gui attribute=$node|attribute( 'description' )}
                </div>
            {/if}

            {if $node|has_attribute( 'show_children' )}
                {set $classi_filtro=$node.data_map.classi_filtro.data_text|explode(',')}
                
                {include uri=concat('design:parts/children/', $children_view, '.tpl') col_width=$col_width modulo=$modulo classi_filtro=$classi_filtro}

                {undef $children_view}
            {/if}

            {include uri='design:openpa/parts/full/tags.tpl'}
        </div>

     </div>

    {if $node|has_attribute( 'testo' )}
        {include uri='design:openpa/parts/script/time-to-read.tpl' text=$node|attribute( 'description' )}
    {/if}

{/if}


