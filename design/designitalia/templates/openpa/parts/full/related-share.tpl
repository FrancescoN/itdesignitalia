{def $page_url = concat('https://', ezini('SiteSettings','SiteURL'), $node.url_alias|ezroot(no))}

<div class="u-content-related-item">
    <h4>
        <i class="mdi mdi-share-variant mdi-24px"></i>
        <span class="u-content-related-item-title">
            {'Share'|i18n('designitalia/full')}
        </span>
    </h4>

    <a class="share-btn fb-share-btn" href="#" target="_blank"><span class="mdi mdi-facebook"></span></a>
    <a class="share-btn tw-share-btn" href="#" target="_blank"><span class="mdi mdi-twitter"></span></a>
    <a class="share-btn gp-share-btn" href="#" target="_blank"><span class="mdi mdi-google-plus"></span></a>
    <a class="share-btn ln-share-btn" href="#" target="_blank"><span class="mdi mdi-linkedin"></span></a>
    <a class="share-btn lk-share-btn" href="#"><span class="mdi mdi-link-variant"></span></a>
</div>

{literal}
<script>
    $(document).ready(function(){
        console.log(encodeURIComponent("{/literal}{$page_url}{literal}"));
        
        $(".fb-share-btn").attr( 
            "href", 
            "https://www.facebook.com/sharer/sharer.php?u=" + encodeURIComponent("{/literal}{$page_url}{literal}") + "&title=" + "{/literal}{$node.name|wash()}{literal}"
        );
        
        $(".tw-share-btn").attr( 
                "href", 
                "http://twitter.com/intent/tweet?status=" + "{/literal}{$node.name|wash()}{literal}" + "+" + encodeURIComponent("{/literal}{$page_url}{literal}")
        );
        
        $(".gp-share-btn").attr( 
            "href", 
            "https://plus.google.com/share?url=" + encodeURIComponent("{/literal}{$page_url}{literal}")
        );

        $(".ln-share-btn").attr( 
            "href", 
            "http://www.linkedin.com/shareArticle?mini=true&url=" + encodeURIComponent("{/literal}{$page_url}{literal}") + "&title=" + "{/literal}{$node.name|wash()}{literal}" + "&source=" + "{/literal}{ezini('SiteSettings','SiteURL')}{literal}"
        );
    });
</script>

{/literal}
       
{undef $page_url}
