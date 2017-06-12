
$(document).ready(function(){
    
    // Allineamento dei sottomenu
    $(".Megamenu-item a").mouseup(function(){
        var clickedMenu = $(this);
        var position = $(this).offset();
        var OFFSET = 52;
        
        // Se questo menu ha sottomenu
        if( $(this).attr('aria-haspopup') ){
            
            $(".Megamenu-subnav").each(function(){
                // Prendo il sottomenu
                if( clickedMenu.attr('id') ===  $(this).attr('aria-labelledby')){
                    var itemsSelector = '#' + $(this).attr('id') + ' ul li a';
                    
                    $(itemsSelector).css( 'margin-left', position.left + OFFSET );
                }
                
            });
            
        }
    });
    
});

