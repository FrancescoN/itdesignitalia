                
{* Script per la ricerca dei provvedimenti PAT *}
{literal}
<script>
    var siteURL = '{/literal}{ezini( 'SiteSettings', 'SiteURL'  )}{literal}';
    var class_identifier = "{/literal}{$classes}{literal}";
    var facet_attributes = "oggetto|figuraprofessionale";
    var node_id = '{/literal}{$node.node_id}{literal}';
    var show_datatable = false;

    // Imposta le faccette per le select options
    function setSelectFacet( facet, item, selected_item_value ){
        if(selected_item_value === ''){
            item.html('<option value="" selected>'+item.data("placeholder")+'</option>');
        }
        else{
            item.html('<option value="">'+item.data("placeholder")+'</option>');
        }
        
        if( facet !== null ){            
            $.each(facet.countList, function( _label, _count ){
                var _disabled = false;
                if(_count === 0){
                    _disabled = true;
                }

                /* DEBUG *
                if(_label === ''){
                    _label = '<N/D>';
                    _disabled = true;
                }
                /**/
        
                if(_label !== ''){
                    if(selected_item_value === _label){
                       item.append($('<option>', { 
                            value: _label,
                            text : _label + ' (' +  _count +  ')',
                            disabled: _disabled,
                            selected: ''
                        })); 
                    }
                    else{
                        item.append($('<option>', { 
                            value: _label,
                            text : _label + ' (' +  _count +  ')',
                            disabled: _disabled
                        }));
                    }
                }

            });
        }
    }
    
    // Se vero esegue una ricerca iniziale
    var do_search = true;
    
    console.log( "https://"+siteURL+"/vivoscuola/concorsi_search/" + class_identifier + "/" + facet_attributes + "/" + node_id);
    
    $(document).ready(function(){
        
        var dataTable = $("#prv_datatable_content").DataTable({
             "processing": true,
             "serverSide": true,
             "bFilter": false,
             "ajax": {
                 "type": "GET",
                 "url": "https://"+siteURL+"/vivoscuola/concorsi_search/" + class_identifier + "/" + facet_attributes + "/" + node_id,
                 "data": function( d ) {
                     // Select Options
                     $('#prv_search_form option:selected').each(function(){
                         var parent = $(this).parent();

                         d[ parent.attr('name') ] = $(this).val();
                     });
                     // Inputs
                     $('#prv_search_form :input').each(function(){
                         d[ $(this).attr('name') ] = $(this).val();
                     });
                 }
             },
             "language": {
                 sEmptyTable: "Nessun dato presente nella tabella",
                 sInfo: "Vista da _START_ a _END_ di _TOTAL_ elementi",
                 sInfoEmpty: "Vista da 0 a 0 di 0 elementi",
                 sInfoFiltered: "(filtrati da _MAX_ elementi totali)",
                 sInfoPostFix: "",
                 sInfoThousands: ".",
                 sLengthMenu: "Visualizza _MENU_ elementi",
                 sLoadingRecords: "Caricamento...",
                 sProcessing: "Elaborazione...",
                 sSearch: "Cerca:",
                 sZeroRecords: "La ricerca non ha portato alcun risultato.",
                 oPaginate: {
                     sFirst: "Inizio",
                     sPrevious: "<<",
                     sNext: ">>",
                     sLast: "Fine"
                 },
                 oAria: {
                     sSortAscending: ": attiva per ordinare la colonna in ordine crescente",
                     sSortDescending: ": attiva per ordinare la colonna in ordine decrescente"
                 },
                 buttons: {
                     print: "Stampa",
                     copy: "Copia"
                 }
             }, 
             "bLengthChange": false,
             "bInfo" : false // Nasconde il numero di righe visualizzate
        });

        $("#prv_datatable_content").on('xhr.dt', function(e, settings, result, xhr){
            // oggetto|figuraprofessionale|        
            setSelectFacet( (result.FacetFields !== null?result.FacetFields[0]:null), $("#oggetto"), result.GET['oggetto'] );
            setSelectFacet( (result.FacetFields !== null?result.FacetFields[1]:null), $("#figuraprofessionale"), result.GET['figuraprofessionale'] );

            // Lettura variabili persistenti
            if(localStorage.getItem('query') !== null){
                $("#query").val( localStorage.getItem('query') );
            }

            if(localStorage.getItem('oggetto') !== null){
                $("#oggetto").val( localStorage.getItem('oggetto') );
                $("#oggetto").hide();

                $("#oggetto_value").html( localStorage.getItem('oggetto') );
                $("#oggetto_choosen").show();
            }
            
            if(localStorage.getItem('figuraprofessionale') !== null){
                $("#figuraprofessionale").val( localStorage.getItem('figuraprofessionale') );
                $("#figuraprofessionale").hide();

                $("#figuraprofessionale_value").html( localStorage.getItem('figuraprofessionale') );
                $("#figuraprofessionale_choosen").show();
            }
            //

            // Visualizzo i dati caricati //
            $("#prv_loading").hide();
            $("#prv_search").show();
            if(show_datatable){
                $("#prv_datatable").show();
                
                if(result.recordsTotal === 1){
                    $("#numRows").html( result.recordsTotal + ' dipendente trovato' );
                }
                else{
                    $("#numRows").html( result.recordsTotal + ' dipendenti trovati' );
                }
            }
            else{
                $("#numRows").html( '' );
            }
            
            // Se ci sono variabili preimpostate esegue la ricerca
            if(do_search){
                search( null );
            }
        });
        
        // Aggiorna la ricerca //
        function search(event){
            show_datatable = true;
            do_search = false;
            
            // Numero elementi per pagina
            if(event !== null && event.target.id === 'show'){
                dataTable.page.len( $(event.target).val() );
            }
            
            // Sistema per togliere impostazione di una faccetta
            if(event !== null && $(event.target).attr("class") === "search-choice-close"){
                var id_reset = event.target.id;
                var parent_id = id_reset.replace('_reset', '');
                
                $("#"+parent_id).val( '' );
                $("#"+parent_id).show();
                
                $("#"+parent_id+"_value").html( '' );
                $("#"+parent_id+"_choosen").hide();
            }
            
            dataTable.ajax.reload();
            
            // Imposta il sistema per rimuovere la faccetta se è selezionato un valore
            if(event !== null){
                var value = $(event.target).val();
                var source_id = event.target.id;
                if(value !== '' && source_id !== 'query' && source_id !== 'numero'){
                    $(event.target).hide();

                    $("#"+source_id+"_value").html( value );
                    $("#"+source_id+"_choosen").show();
                }
            }
            
            $("#prv_reset_button").show();
            
            // persistenza variabili di ricerca
            if($("#query").val() !== ''){
                localStorage.setItem('query', $("#query").val());
            }
            else{
                localStorage.removeItem('query');
            }

            if($("#oggetto").val() !== ''){
                localStorage.setItem('oggetto', $("#oggetto").val());
            }
            else{
                localStorage.removeItem('oggetto');
            }
            
            if($("#figuraprofessionale").val() !== ''){
                localStorage.setItem('figuraprofessionale', $("#figuraprofessionale").val());
            }
            else{
                localStorage.removeItem('figuraprofessionale');
            }
            
            //
        }
        
        // Azzera la ricerca //
        $("#prv_reset_button").click(function(event){
            $("#query").val("");

            $("#oggetto").val("");
            $("#oggetto").show();
            $("#oggetto_choosen").hide("");
            
            $("#figuraprofessionale").val("");
            $("#figuraprofessionale").show();
            $("#figuraprofessionale_choosen").hide("");
            
            search(event);
            $(this).hide();
        });
        
        // Ricarica lanciata su invio //
        $("#query").keypress(function(event) {
            if (event.which === 13) {
                event.preventDefault();
                search(event);
            }
        });
        
        
        // Ricarica lanciata su select //
        $("#prv_search_form select").change(function(event){
            search(event);
        });
        
       // Reset di una faccetta //
       $(".search-choice-close").click(function(event){
            search(event);
       });
        
    });
</script>
{/literal}