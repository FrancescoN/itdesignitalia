{* Barra lingua usata per gestione utente *}

<div class="Header-banner">
    <div class="Header-owner Headroom-hideme">
        <a href="http://www.provincia.tn.it"><span>Provincia Autonoma di Trento</span></a>

        <div class="Header-languages">
            <span>
                <img class="LogoTrentino" src={'images/trentino.png'|ezdesign()}>
            </span>
            
            {if ezini('DesignItaliaHeader', 'HasNewsletter', 'itdesignitalia.ini')|eq('TRUE')}
                <a class="Header-language u-hidden u-md-inlineBlock u-lg-inlineBlock u-background-60" href={"/notification/settings"|ezurl}>
                    <abbr title="Newsletter">
                        <i class="mdi mdi-email mdi-24px"></i>
                    </abbr>
                </a>
            {/if}
            
            {if $current_user.is_logged_in}
                {if fetch( 'user', 'has_access_to', hash( 'module', 'content', 'function', 'dashboard' ) )}   
                    <a class="Header-language u-hidden u-md-inlineBlock u-lg-inlineBlock" href={"/content/dashboard/"|ezurl} >
                        <abbr title="{'Dashboard'|i18n('designitalia')}">
                            <i class="mdi mdi-view-dashboard mdi-24px"></i>
                        </abbr>
                    </a>
                {/if}

                {if fetch( 'user', 'has_access_to', hash( 'module', 'user', 'function', 'selfedit' ) )}
                    <a class="Header-language u-hidden u-md-inlineBlock u-lg-inlineBlock" href={"/user/edit/"|ezurl} >
                        <abbr title="{'Profile'|i18n('designitalia')}">
                            <i class="mdi mdi-account mdi-24px"></i>
                        </abbr>
                    </a>
                {/if}

                <a class="Header-language u-hidden u-md-inlineBlock u-lg-inlineBlock" href={"/user/logout"|ezurl}>
                    <abbr title="Logout">
                        <i class="mdi mdi-lock-open mdi-24px"></i>
                    </abbr>
                </a>
            {else}
                <a class="Header-language u-hidden u-md-inlineBlock u-lg-inlineBlock" href={"/user/login"|ezurl}>
                    <abbr title="Login">
                        <i class="mdi mdi-lock mdi-24px"></i>
                    </abbr>
                </a>
            {/if}
            
        </div>

    </div>
</div>