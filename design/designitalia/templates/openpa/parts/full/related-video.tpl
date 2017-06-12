{if gt($video|count,0)} 
    <div class="u-content-related-item">
        <h4>
            <i class="mdi mdi-video mdi-24px"></i>
            <span class="u-content-related-item-title">
                {'Video'|i18n('designitalia/full')}
            </span>
        </h4>
        
        {include uri='design:atoms/video.tpl' items=$video}        
    </div>
{/if}