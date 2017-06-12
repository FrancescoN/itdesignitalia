{if gt($images|count,1)}
    <div class="u-content-related-item">
        <h4>
            <i class="mdi mdi-image-multiple mdi-24px"></i>
            <span class="u-content-related-item-title">
                {'Images'|i18n('designitalia/full')}
            </span>
        </h4>
        {include uri='design:atoms/gallery.tpl' items=$images thumbnail_class='relatedthumb' can_edit=$can_edit node_id=$node.node_id url_alias=$node.url_alias|ezurl(no)}
    </div>
{/if}