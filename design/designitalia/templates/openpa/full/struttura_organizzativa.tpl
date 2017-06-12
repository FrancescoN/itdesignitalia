<div class="u-content class-{$node.class_identifier}">
    
    {def $main_strut_orgs = fetch('content', 'list', hash('parent_node_id', ezini('StrutturaOrganizzativa', 'RootNodeID', 'itdesignitalia.ini'),
                                                          'class_filter_type', 'include',
                                                          'class_filter_array', array('struttura_organizzativa') ) )
         $main_strut_org_name = false()
         $main_strut_org = false()}
    
    {foreach $main_strut_orgs as $strut}
        {if $node.path_string|contains($strut.node_id)}
            {set $main_strut_org_name = $strut.name|wash()
                 $main_strut_org = $strut}
            {break}
        {/if}
    {/foreach}
    
    <div class="u-content-main-parent">
        <h1>
            <a href={$main_strut_org.url|ezurl}>{$main_strut_org_name|wash()}</a>
        </h1>
    </div>
    
    <div class="u-content-treeview">
        {include uri='design:openpa/parts/full/related-treeview.tpl' item=$main_strut_org path_array=$node.path_array}
    </div>
    
    <div class="u-content-main u-content-main-side">
        <div class="u-content-title">
            <h1>{$node.name|wash()}</h1>
            
            <div class="u-content-date">
                {*include uri='design:openpa/parts/full/node_date.tpl'*}
            </div>
        </div>
            
        {if $node|has_attribute( 'orari' )}
        <div class="Prose u-padding-top-xxl">
            {attribute_view_gui attribute=$node|attribute( 'orari' )}
        </div>
        {/if}
        
       
        <div class="Grid Prose u-padding-top-xxl">
            {if $node|has_attribute( 'telefono' )}
                <div class="Grid-cell u-size1of3 u-color-80 u-textItalic">
                    {'Phone'|i18n('designitalia/full')}
                </div>
                <div class="Grid-cell u-size2of3">
                    {attribute_view_gui attribute=$node|attribute('telefono')}
                </div>
            {/if}
            
            {if $node|has_attribute( 'fax' )}
                <div class="Grid-cell u-size1of3 u-color-80 u-textItalic">
                    Fax
                </div>
                <div class="Grid-cell u-size2of3">
                    {attribute_view_gui attribute=$node|attribute('fax')}
                </div>
            {/if}
            
            {if $node|has_attribute( 'email' )}
                <div class="Grid-cell u-size1of3 u-margin-top-s u-color-80 u-textItalic">
                    Email
                </div>
                <div class="Grid-cell u-size2of3 u-margin-top-s">
                    <a href="mailto:{attribute_view_gui attribute=$node|attribute('email')}">
                        {attribute_view_gui attribute=$node|attribute('email')}
                    </a>
                </div>
            {/if}
            
            {if $node|has_attribute( 'indirizzo' )}
                <div class="Grid-cell u-size1of3 u-margin-top-s u-color-80 u-textItalic">
                    {'Address'|i18n('designitalia/full')}
                </div>
                <div class="Grid-cell u-size2of3 u-margin-top-s">
                    {attribute_view_gui attribute=$node|attribute('indirizzo')}
                </div>
            {/if}
            
            {if $node|has_attribute( 'responsabile' )}
                <div class="Grid-cell u-size1of3 u-margin-top-s u-color-80 u-textItalic">
                    {'Person in charge'|i18n('designitalia/full')}
                </div>
                <div class="Grid-cell u-size2of3 u-margin-top-s">
                    {attribute_view_gui attribute=$node|attribute('responsabile')}
                </div>
            {/if}
        </div>
        
        {if $node|has_attribute( 'declaratoria' )}

            <div class="Prose u-padding-top-xxl">
                <b class="u-color-40">{'Declaratory'|i18n('designitalia/full')}</b>
                {attribute_view_gui attribute=$node|attribute('declaratoria')}
            </div>
        {/if}
        
        {include uri='design:openpa/parts/full/related-dipendenti-strut.tpl'}
        
        {include uri='design:openpa/parts/full/related-normativa-strut.tpl'}
        
    </div>
    
    <div class="u-content-related">
        {include uri='design:openpa/parts/full/related-geo.tpl'}
        
        {include uri='design:openpa/parts/full/related-share.tpl'}
    </div>
</div>

{if $node|has_attribute( 'description' )}
    {include uri='design:openpa/parts/script/time-to-read.tpl' text=$node|has_attribute( 'description' ) }
{/if}
