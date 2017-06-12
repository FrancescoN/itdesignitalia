{def $objects = fetch( 'content', 'reverse_related_objects', hash( 'object_id', $node.contentobject_id 
                                                                  , 'all_relations', true()
                                                                  , 'sort_by', array('class_identifier', true()) ) )}

<div class="u-content-related-item">
    <h4>
        <i class="mdi mdi-domain mdi-24px"></i>
        <span class="u-content-related-item-title">
            {'Organization Structure'|i18n('designitalia/full')}
        </span>
    </h4>
    
    <ul class="list-unstyled">
    {foreach $objects as $object}
        {if $object.main_node.class_identifier|eq('struttura_organizzativa')}
            <li><a href={$object.main_node.url|ezurl()}>{$object.name|wash}</a><br></li>
        {/if}
    {/foreach}
    </ul>
</div>