{if is_unset( $load_css_file_list )}
    {def $load_css_file_list = true()}
{/if}

{if $load_css_file_list}
  {ezcss_load( array( 'build.css',
                      'custom.css',
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

<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro" rel="stylesheet">