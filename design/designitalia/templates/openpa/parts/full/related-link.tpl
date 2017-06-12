{set_defaults( hash(
    'attribute_name', 'link',
    'matrix_link_has_content', false()
))}

{if $node|has_attribute( $attribute_name )}
    
    {if $node|attribute( $attribute_name ).data_type_string|eq('ezmatrix')}
        {foreach $node|attribute( $attribute_name ).content.rows.sequential as $row}
            {foreach $row.columns as $index => $column}
                {if $column|ne('')}
                    {set $matrix_link_has_content = true()}
                {/if}
            {/foreach}
        {/foreach}
    {/if}
    
    {if or($matrix_link_has_content, $node|attribute( $attribute_name ).data_type_string|eq('ezurl'))}
        <div class="u-content-related-item">
            <h4>
                <i class="mdi mdi-link mdi-24px"></i>
                <span class="u-content-related-item-title">
                    {'Link'|i18n('designitalia/full')}
                </span>
            </h4>
            
            {attribute_view_gui attribute=$node|attribute( $attribute_name )}
        </div>
    {/if}
{/if}