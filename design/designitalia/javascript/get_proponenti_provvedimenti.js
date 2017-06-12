
/**
*/

function get_proponenti_provvedimenti(currentDiv,tipoProvvedimneto,siteURL){

        $searchfordiv = "search-for-" + currentDiv;
      
        var mySiteURL = siteURL + tipoProvvedimneto;
        var selectedProp;
        
        console.log(mySiteURL);
        
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