<div class="u-content-related-item">
    <h4>
        <i class="mdi mdi-printer mdi-24px"></i>
        <span class="u-content-related-item-title">
            <a href={concat('/content/view/pdf/', $node.node_id)|ezurl()} class="u-color-40">
                {'Print'|i18n('designitalia/full')}
            </a>
        </span>
    </h4>
    {*
    <a title="{'Export'|i18n('design/standard/parts/website_toolbar')}"
        href={concat('/content/view/pdf/', $node.node_id)|ezurl()}
        >{'Printable Version'|i18n('designitalia/full')}
    </a>
    *}
</div>
