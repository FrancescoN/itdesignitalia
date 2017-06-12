
/**
*/

function get_proponenti_provvedimenti(currentDiv,tipoProvvedimneto,siteURL){

        $searchfordiv = "search-for-" + currentDiv;
      
        var mySiteURL = siteURL + tipoProvvedimneto;
        var selectedProp;
        
        //console.log(mySiteURL);
        
        if ($("#"+$searchfordiv) != null ) {
            selectedProp = $("#"+$searchfordiv).val();
            
            // Richima il servizio rest che restituisce i proponenti
            $.ajax({
                dataType: "json",
                url: mySiteURL,
                success: function(result){
                    $.each(result, function(key, curValue){                        
                        var restFault = curValue.RestFault;                     
                        if ((restFault != null) && (restFault != '')){
                            
                        }
                        else{
                            var select = $('<select name="options" class="form-control" style="margin-top:-14px;margin-bottom: 10px;" ><option></option></select>');
                            
                            var aryProponenti = (curValue["Proponenti"]);
                            aryProponenti.forEach(function(element) {
                                    var positionSelectedProp = element.indexOf(selectedProp);
                                    var option = $('<option></option>');
                                    option.attr('value', element);
                                    if ((selectedProp !='') && ( positionSelectedProp == 0)){
                                        option.attr('selected','selected');
                                    }
                                    option.text(element);
                                    
                                    select.append(option);
                            });
                            $('#div-select-for-' + currentDiv).empty().append(select); 
                            $('#div-select-for-' + currentDiv).bind('change', function(){                                   
                                var varSelected = $('#div-select-for-' + currentDiv +' option:selected').text();                               
                                $("#"+$searchfordiv).val( varSelected );                                
                            });
                        }
                    } );
                $("#"+$searchfordiv).hide();
               },
            error: function(response) {
                console.log(response);
            }
        });    
    }
	return null;
}


function get_link_al_provvedimento(remoteId,tipoProvvedimneto,siteURL){
    
    //siteURL = 'https://ez101-dev.infotn.it/pat_provvedimenti/getlinkalprovvedimento/';
    siteURL = siteURL + 'pat_provvedimenti/getlinkalprovvedimento/';
    var mySiteURL = siteURL + tipoProvvedimneto + '/' + remoteId ;
    
    //console.log(mySiteURL);
    
    // Richima il servizio rest che restituisce il link alla delibera
    $.ajax({
        dataType: "json",
        url: mySiteURL,
        success: function(result){
            
            $.each(result, function(key, curValue){ 
               
                var restFault = curValue.RestFault;                     
                if ((restFault != null) && (restFault != '')){
                   
                }
                else{
                    
                    var remoteURL = (curValue["URL"]);                               
                    $("#aRemote_"+remoteId).attr("href", remoteURL);
                    $("#aRemote_"+remoteId).show();
                    $("#iRemote_"+remoteId).hide();
                }                
            } );
        },
            error: function(response) {
                console.log(response);
            }
    });  
}

function get_imgThumbnail(remoteId,siteURL){
    
    
    // siteURL = 'https://ez002-dev.infotn.it/ufficiostampa/get_imgThumbnail/';
    
    var mySiteURL = siteURL + 'ufficiostampa/get_imgThumbnail/' + remoteId ;
    
    //console.log(mySiteURL);
    
    // Richima il servizio rest che restituisce il link all'immagine
    $.ajax({
        dataType: "json",
        url: mySiteURL,
        success: function(result){
            
            $.each(result, function(key, curValue){ 
               
                var restFault = curValue.RestFault;                     
                if ((restFault != null) && (restFault != '')){
                   
                }
                else{                    
                    //var remoteURL = 'https://ez002-dev.infotn.it/' + (curValue["fileSmallUrl"]);                     
                    var remoteURL = siteURL + (curValue["fileSmallUrl"]);   
                    
                    $("#aRemote_"+remoteId).attr("src", remoteURL);
                    $("#aRemoteFull_"+remoteId).attr("src", remoteURL);
                    $("#aRemote_"+remoteId).show();
                    $("#imgRemote_"+remoteId).hide();
                }                
            } );
        },
            error: function(response) {                
                console.log(response);
            }
    });  
}

