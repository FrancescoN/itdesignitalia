
<div class="u-content-related-item">
    
    <h4>
        <i class="mdi mdi-information mdi-24px"></i>
        <span class="u-content-related-item-title">
            {'Informations'|i18n('designitalia/full')}
        </span>
    </h4>

    {def $curRiservato = $node.data_map.riservato.content}
    {if eq( $curRiservato , '1')}
        <div class="Prose Alert Alert--error Alert--withIcon" role="alert">
            <p class="u-text-p">
                {'Reserved document'|i18n('designitalia/full')}
            </p>
        </div>
    {/if} 

    {if $node|has_attribute('struttura_competente')}
        <strong>{'Competent organizational structure'|i18n('designitalia/full')}</strong>
        <div class="Prose">
            {def $curstruttura_competente = $node|attribute('struttura_competente').content}
            {def $relationcontentobject_id=0}
            {foreach $curstruttura_competente.relation_list as $relation}
                {set $relationcontentobject_id= $relation.contentobject_id}
                {def $objectSt=fetch( 'content', 'object', hash( 'object_id', $relationcontentobject_id ) )}
                {if ne( $objectSt.section_identifier, "provvedimenti_importati" )}
                    {attribute_view_gui attribute=$node|attribute('struttura_competente')}
                {else}
                    <strong>{$objectSt.name|wash}</strong>
                {/if}
            {/foreach}
        </div>
    {/if}

    {if $node|has_attribute('competenza')}
        <strong>{'Competence'|i18n('designitalia/full')}</strong>
        <div class="Prose">
            {attribute_view_gui attribute=$node|attribute('competenza')}
        </div>
    {/if}
    {if $node|has_attribute('numero')}
        <strong>{'Measure number'|i18n('designitalia/full')}</strong>
        <div class="Prose">
            {attribute_view_gui attribute=$node|attribute('numero')}
        </div>
    {/if}
    {if $node|has_attribute('anno')}
        <strong>{'Measure year'|i18n('designitalia/full')}</strong>
        <div class="Prose">
            {attribute_view_gui attribute=$node|attribute('anno')}
        </div>
    {/if}
    {if $node|has_attribute('data')}
        <strong>{'Adoption date'|i18n('designitalia/full')}</strong>
        <div class="Prose">
            {attribute_view_gui attribute=$node|attribute('data')}
        </div>
    {/if}
      {if $node|has_attribute('proponente')}
        <strong>{'Proponent'|i18n('designitalia/full')}</strong>
        <div class="Prose">
            {attribute_view_gui attribute=$node|attribute('proponente')}
        </div>
    {/if}
     {if $node|has_attribute('codice_struttura_competente')}
        <strong>{'Competent organizational structure code'|i18n('designitalia/full')}</strong>
        <div class="Prose">
            {attribute_view_gui attribute=$node|attribute('codice_struttura_competente')}
        </div>
    {/if}
    {if $node|has_attribute('riferimento')}
        <strong>{'Reference'|i18n('designitalia/full')}</strong>
        <div class="Prose">
            {attribute_view_gui attribute=$node|attribute('riferimento')}
        </div>
    {/if}
</div>
