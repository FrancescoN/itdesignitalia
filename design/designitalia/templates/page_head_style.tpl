{if is_unset( $load_css_file_list )}
    {def $load_css_file_list = true()}
{/if}

{if $load_css_file_list}
  {ezcss_load( array( 'custom.css',
                      'build.css',
                      'fonts.css',
                      'materialdesignicons.min.css',
                      'debug.css',
                      'websitetoolbar.css',
                      ezini( 'StylesheetSettings', 'CSSFileList', 'design.ini' ),
                      ezini( 'StylesheetSettings', 'FrontendCSSFileList', 'design.ini' ) ) )}
{else}
  {ezcss_load( array( 'build.css',
                      'debug.css',
                      'websitetoolbar.css' ) )}
{/if}

{*<link rel="stylesheet" type="text/css" href="/extension/itdesignitalia/design/designitalia/stylesheets/build.css" />*}

{*<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro" rel="stylesheet">*}
{*<link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Titillium+Web:400,200,200italic,300,300italic,400italic,600,600italic,700,700italic,900" media="all" />*}