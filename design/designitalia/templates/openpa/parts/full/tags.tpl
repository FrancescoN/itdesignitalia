{if or($node|has_attribute('tematica'), $node|has_attribute('beneficiari'))} 

<div class="tags">
    <div class="tags-margin">
        {if $node|has_attribute('tematica')}
            <div class="u-margin-bottom-xl">
                <h3 class="u-margin-bottom-xs">
                    <span class="u-color-text">
                        <i class="mdi mdi-tag-multiple"></i>
                        {'Issues'|i18n('designitalia/full')}
                    </span>
                </h3>

                {attribute_view_gui attribute=$node|attribute( 'tematica' )}
            </div>
        {/if}

        {*if $node|has_attribute('argomento')}
            <div class="u-margin-bottom-xl">
                <h3 class="u-margin-bottom-xs">
                    <i class="mdi mdi-tag-multiple"></i>
                    {'Topics'|i18n('designitalia/full')}
                </h3>

                {attribute_view_gui attribute=$node|attribute( 'argomento' )}
            </div>
        {/if*}

        {if $node|has_attribute('beneficiari')}
            <div class="u-margin-bottom-xl">
                <h3 class="u-margin-bottom-xs">
                    <span class="u-color-text">
                        <i class="mdi mdi-tag-multiple"></i>
                        {'Users'|i18n('designitalia/full')}
                    </span>
                </h3>

                {attribute_view_gui attribute=$node|attribute( 'beneficiari' )}
            </div>
        {/if}
    </div>
</div>

{/if}

    
