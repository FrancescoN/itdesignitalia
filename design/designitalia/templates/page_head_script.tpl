{* Load JavaScript dependencys + JavaScriptList *}
{ezscript_load( array(
    'vendor/modernizr.js',
    'ezjsc::jquery',
    ezini( 'JavaScriptSettings', 'JavaScriptList', 'design.ini' ),
    ezini( 'JavaScriptSettings', 'FrontendJavaScriptList', 'design.ini' )
))}

<!-- <link rel="preload" href="{"javascript/IWT.min.js"|ezdesign()}" as="script"> -->

{*
{literal}
    <script type="text/javascript">
        WebFontConfig = {
          google: {
            families: ['Titillium+Web:400,600,700,400italic:latin']
          }
        };
        (function() {
          var wf = document.createElement('script');
          wf.src = 'https://ajax.googleapis.com/ajax/libs/webfont/1/webfont.js';
          wf.type = 'text/javascript';
          wf.async = 'true';
          var s = document.getElementsByTagName('script')[0];
          s.parentNode.insertBefore(wf, s);
        })();
    </script>
{/literal}
*}

<!--[if IE 8]>
<script type="text/javascript" src={"javascript/vendor/respond.min.js"|ezdesign()} ></script>
<script type="text/javascript" src={"javascript/vendor/rem.min.js"|ezdesign()} ></script>
<script type="text/javascript" src={"javascript/vendor/selectivizr.js"|ezdesign()} ></script>
<script type="text/javascript" src={"javascript/vendor/slice.js"|ezdesign()} ></script>
<![endif]-->

<!--[if lt IE 9]>
<script type="text/javascript" src={"javascript/vendor/polyfill.min.js"|ezdesign()} ></script>
<![endif]-->