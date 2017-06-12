{if is_set($text)}
    

    {literal}
    <script>
        $(document).ready(function() {
            
            var text_words = {/literal}{$text.data_text|count_words()}{literal};
            var MAX_TEXT_WORDS = 5000;
            
            //var content_size = $("body").height() - ($("header").height() + $("footer").height() + $(".debug").height());
            var content_size = $(".u-content").height() + 300;
            var content_timetoread = (text_words/MAX_TEXT_WORDS) * content_size;
            
            console.log('size: ' + content_size);
            $(".u-content-length").height( content_size );
            
            console.log('len: ' + content_timetoread);
            $(".u-content-timetoread").height( content_timetoread );
            
            $(".u-content-length").show();
        });
    </script>
    {/literal}
{/if}