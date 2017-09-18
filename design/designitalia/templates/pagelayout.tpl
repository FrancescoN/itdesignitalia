<!DOCTYPE html>
<!--[if IE 8]><html class="no-js ie89 ie8" lang="it"><![endif]-->
<!--[if IE 9]><html class="no-js ie89 ie9" lang="it"><![endif]-->
<!--[if (gte IE 9)|!(IE)]><!-->
<html class="no-js" lang="{$site.http_equiv.Content-language|wash}">
<!--<![endif]-->

{http_header('X-UA-Compatible: IE=Edge')}

<head>
    {def $basket_is_empty   = cond( $current_user.is_logged_in, fetch( shop, basket ).is_empty, 1 )
         $user_hash         = concat( $current_user.role_id_list|implode( ',' ), ',', $current_user.limited_assignment_value_list|implode( ',' ) )}

    {if is_set( $extra_cache_key )|not}
        {def $extra_cache_key = ''}
    {/if}

{cache-block keys=array( $module_result.uri, $basket_is_empty, $current_user.contentobject_id, $extra_cache_key )}

    {def $pagedata        = ezpagedata()}

    {def $pagestyle        = $pagedata.css_classes
         $locales          = fetch( 'content', 'translation_list' )
         $current_node_id  = $pagedata.node_id}

    
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Site: {ezsys( 'hostname' )} -->

    {include uri='design:page_head.tpl'}
    {include uri='design:page_head_style.tpl'}
    {include uri='design:page_head_script.tpl'}
</head>
<body class="t-Pac" style="padding-top: 256px;">

{*<div id="page">*}

    {include uri='design:page_header.tpl'}
{/cache-block}
{cache-block keys=array( $module_result.uri, $user_hash, $extra_cache_key )}

    {*include uri='design:nav/nav-main.tpl'*}

    {if and( $pagedata.website_toolbar, $pagedata.is_edit|not)}
        {include uri='design:page_toolbar.tpl'}
    {/if}

    {*if and( $pagedata.node_id|ne( ezini( 'NodeSettings', 'RootNode', 'content.ini' ) ), $pagedata.show_path, array( 'edit', 'browse' )|contains( $ui_context )|not() )}
      {include uri='design:breadcrumb.tpl'}
    {/if*}

    <div class="MainContent">
        
{/cache-block}

      {$module_result.content}

{cache-block keys=array( $module_result.uri, $user_hash, $access_type.name, $extra_cache_key )}

    </div>

    {include uri='design:page_footer.tpl'}

{*</div>*}

{include uri='design:page_footer_script.tpl'}

{* Codice extra usato da plugin javascript *}
{include uri='design:page_extra.tpl'}

{/cache-block}

{* This comment will be replaced with actual debug report (if debug is on). *}
<!--DEBUG_REPORT-->
</body>
</html>
