<div class="u-content">
     <div class="u-content-main">
        <div class="u-content-title">
            <h1>
                {'Dashboard'|i18n('designitalia')}
            </h1>
            
            <div class="Grid">
                
                {foreach $blocks as $block}
                    <div class="Grid-cell u-size1of2 u-padding-all-s u-backgroun-grey-10">
                        <div style="max-height: 500px; overflow-y: scroll;">
                            {if $block.template}
                                {include uri=concat( 'design:', $block.template )}
                            {else}
                                {include uri=concat( 'design:dashboard/', $block.identifier, '.tpl' )}
                            {/if}
                        </div>
                    </div>
                {/foreach}
                
            </div>
        </div>
</div>