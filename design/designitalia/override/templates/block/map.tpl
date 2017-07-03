
{def $root = ezini( 'NodeSettings', 'RootNode', 'content.ini' )}
{if is_set( $block.custom_attributes.parent_node_id )}
    {set $root = $block.custom_attributes.parent_node_id}
{/if}


<div class="u-flow-map hidden-xs hidden-sm">
    <section>
        <div class="u-map-title">
            <h2>
                {$block.name|wash()}
            </h2>
        </div>
            
        {* Mappa *}
        {include uri='design:parts/children/map.tpl' map_type="google" view='line' node=hash( node_id, $root) class_identifiers=$block.custom_attributes.includi_classi|explode(',')}
        
    </section>
</div>