
/**
 * Dato un ObjectId ne modifica la descrizione
 * 
*/

function mod_object_description(ObjectId,inputId,modalId,siteURL){
    
    // Recupero del valore della input box
    var curDescrizione = document.getElementById(inputId).value;
    
    if ((curDescrizione != null) &&(curDescrizione != ''))
    {
        var curSiteURL = 'https://' + siteURL + '/vivoscuola/mod_object_description/' + ObjectId + '/' + curDescrizione;
        // Richima il servizio rest che modifica la descrizione
        $.ajax({
            dataType: "json",
            url: curSiteURL,
            success: function(result){

                $.each(result, function(key, curValue){ 

                    var restFault = curValue.RestFault;                     
                    if ((restFault != null) && (restFault != '')){
                        alert(restFault);
                    }
                    else{                
                        
                        // Aggiorna il nome dell'allegato
                        $('#labelobjectname'+ObjectId).text(curDescrizione);      
                        
                        // L'update è andata a buon fine
                        $('#'+modalId).modal('toggle');
                    }                
                } );
            },
            error: function(response) {                
                console.log(response);
            }
        });        
    }
    else
    {
        alert('Campo descrizione non valorizzato.');
    }  
}