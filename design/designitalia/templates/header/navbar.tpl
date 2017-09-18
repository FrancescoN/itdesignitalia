{def $root_node = fetch(content, node, hash( node_id, ezini('NodeSettings', 'RootNode', 'content.ini')))}
{def $node = fetch(content, node, hash( node_id, $pagedata.node_id))}

<div class="Header-navbar Grid Grid--alignMiddle">
    <div class="Header-toggle Grid-cell">
        <a class="Hamburger-toggleContainer js-fr-offcanvas-open u-nojsDisplayInlineBlock" 
           href="#menu" 
           aria-controls="menu" 
           aria-label="{'menu access'|i18n('designitalia')}" 
           title="{'menu access'|i18n('designitalia')}">
            <span class="Hamburger-toggle" role="presentation"></span>
            <span class="Header-toggleText" role="presentation">Menu</span>
        </a>
    </div>

    <div class="Header-logo Grid-cell" aria-hidden="true">
        {if $root_node|attribute('logo').content.original.url}
            <a href={"/"|ezurl} tabindex="-1">
                <img src={$root_node|attribute('logo').content.original.url|ezroot()} alt="{$root_node.name}" />
            </a>
        {/if}
    </div>

    {include uri='design:header/site-title.tpl'}

    {* CERCA *}
    <div class="Header-searchTrigger Grid-cell">
        <button aria-controls="header-search" 
                class="js-Header-search-trigger mdi mdi-magnify mdi-18px"
                title="{'enable search form'|i18n('designitalia')}"
                aria-label="{'enable search form'|i18n('designitalia')}" 
                aria-hidden="false">
        </button>
        <button aria-controls="header-search" 
                class="js-Header-search-trigger u-hidden mdi mdi-close mdi-18px" 
                title="{'disable search form'|i18n('designitalia')}" 
                aria-label="{'disable search form'|i18n('designitalia')}" 
                aria-hidden="true">
        </button>
    </div>

    <div class="Header-utils Grid-cell">
        
        
        <div class="Header-social Headroom-hideme">
            {* SOCIAL *}
            {*include uri='design:header/social.tpl'*}
            
            {* SELEZIONE LINGUA *}
            {include uri='design:header/languages.tpl'}
        </div>
            
        {* CERCA *}
        <div class="Header-search" id="header-search">
            <form class="Form" action="/content/search">
                <div class="Form-field Form-field--withPlaceholder Grid" role="search">
                    <input class="Form-input Grid-cell u-sizeFill u-text-r-s" 
                           required id="cerca" 
                           name="SearchText" 
                           value="{$search_text|wash}">
                    <label class="Form-label" for="cerca">{'Search'|i18n('designitalia')}...</label>
                    <button class="Grid-cell u-sizeFit u-background-60 u-color-white u-padding-all-s u-textWeight-700 mdi mdi-magnify mdi-18px" 
                            title="{'Start searching'|i18n('designitalia')}" a
                            ria-label="{'Start searching'|i18n('designitalia')}">
                    </button>
                </div>
            </form>

        </div>
    </div>
</div>