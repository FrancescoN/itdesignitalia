                       
{* Script per la ricerca dei provvedimenti PAT *}
{literal}
<script>
    var siteURL = '{/literal}{ezini( 'SiteSettings', 'SiteURL'  )}{literal}';
    var class_identifier = "circolare";
    var facet_attributes = "numero|tematica|beneficiari|struttura_competente";
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
    
    $(document).ready(function(){
        var urlAjax = "https://"+siteURL+"/vivoscuola/provvedimenti_search/" + class_identifier + "/" + facet_attributes + "/" + node_id;
        console.log(urlAjax);
        var dataTable = $("#prv_datatable_content").DataTable({
             "processing": true,
             "serverSide": true,
             "bFilter": false,
             "ajax": {
                 "type": "GET",
                 "url": "https://"+siteURL+"/vivoscuola/provvedimenti_search/" + class_identifier + "/" + facet_attributes + "/" + node_id,
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
             "order": [[ 0, "desc" ]],
             "bLengthChange": false,
             "bInfo" : false // Nasconde il numero di righe visualizzate
        });

        $("#prv_datatable_content").on('xhr.dt', function(e, settings, result, xhr){
            // numero|tematica|beneficiari|struttura_competente
            // Parto dall'indice 1 poiché lo 0 è usato solo in ricerca ma non è visualizzata la faccetta
            setSelectFacet( (result.FacetFields !== null?result.FacetFields[1]:null), $("#tematica"), result.GET['tematica'] );
            setSelectFacet( (result.FacetFields !== null?result.FacetFields[2]:null), $("#beneficiari"), result.GET['beneficiari'] );
            setSelectFacet( (result.FacetFields !== null?result.FacetFields[3]:null), $("#struttura_competente"), result.GET['struttura_competente'] );

            // Lettura variabili persistenti
            if(localStorage.getItem('query') !== null){
                $("#query").val( localStorage.getItem('query') );
            }
            if(localStorage.getItem('numero') !== null){
                $("#numero").val( localStorage.getItem('numero') );
            }
            if(localStorage.getItem('tematica') !== null){
                $("#tematica").val( localStorage.getItem('tematica') );
                $("#tematica").hide();

                $("#tematica_value").html( localStorage.getItem('tematica') );
                $("#tematica_choosen").show();
            }
            if(localStorage.getItem('beneficiari') !== null){
                $("#beneficiari").val( localStorage.getItem('beneficiari') );
                $("#beneficiari").hide();

                $("#beneficiari_value").html( localStorage.getItem('beneficiari') );
                $("#beneficiari_choosen").show();
            }
            if(localStorage.getItem('struttura_competente') !== null){
                $("#struttura_competente").val( localStorage.getItem('struttura_competente') );
                $("#struttura_competente").hide();

                $("#struttura_competente_value").html( localStorage.getItem('struttura_competente') );
                $("#struttura_competente_choosen").show();
            }
            //

            // Visualizzo i dati caricati //
            $("#prv_loading").hide();
            $("#prv_search").show();
            if(show_datatable){
                $("#prv_datatable").show();
                
                if(result.recordsTotal === 1){
                    $("#numRows").html( result.recordsTotal + ' provvedimento trovato' );
                }
                else{
                    $("#numRows").html( result.recordsTotal + ' provvedimenti trovati' );
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
            
            if($("#numero").val() !== ''){
                localStorage.setItem('numero', $("#numero").val());
            }
            else{
                localStorage.removeItem('numero');
            }
            
            if($("#tematica").val() !== ''){
                localStorage.setItem('tematica', $("#tematica").val());
            }
            else{
                localStorage.removeItem('tematica');
            }
            
            if($("#beneficiari").val() !== ''){
                localStorage.setItem('beneficiari', $("#beneficiari").val());
            }
            else{
                localStorage.removeItem('beneficiari');
            }
            
            if($("#struttura_competente").val() !== ''){
                localStorage.setItem('struttura_competente', $("#struttura_competente").val());
            }
            else{
                localStorage.removeItem('struttura_competente');
            }
            
            //
        }
        
        // Azzera la ricerca //
        $("#prv_reset_button").click(function(event){
            $("#query").val("");
            
            $("#numero").val("");
            
            $("#tematica").val("");
            $("#tematica").show();
            $("#tematica_choosen").hide("");
            
            $("#beneficiari").val("");
            $("#beneficiari").show();
            $("#beneficiari_choosen").hide("");
            
            $("#struttura_competente").val("");
            $("#struttura_competente").show();
            $("#struttura_competente_choosen").hide("");
            
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
        
        // Ricarica lanciata su invio //
        $("#numero").keypress(function(event) {
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
       
       // Daterange
        $(function() {
            var days = 'Dom_Lun_Mar_Mer_Gio_Ven_Sab'.split('_');
            var months = 'Gen_Feb_Mar_Apr_Mag_Giu_Lug_Ago_Set_Ott_Nov_Dic'.split('_');

            var end = moment();
            var start = moment().add(-{/literal}{$numDaysFrom2015}{literal}, 'days');

            function cb(start, end) {
                $('#reportrange span').html(start.format('DD/MM/YYYY') + ' - ' + end.format('DD/MM/YYYY'));
                $('#daterange').val( start.format('YYYY-MM-DD') + ' - ' + end.format('YYYY-MM-DD') );

                search( null );
            }

            $('#reportrange').daterangepicker({
                startDate: start,
                endDate: end,
                format: 'DD/MM/YYYY',
                locale: {     
                    opens: 'center',            
                    firstDay: 1,
                    daysOfWeek: days,
                    monthNames: months,
                    applyLabel: 'Applica',
                    cancelLabel: 'Annulla',
                    fromLabel: 'Dal',
                    toLabel: 'Al',
                    weekLabel: 'W',
                    customRangeLabel: 'Seleziona date',
                    format: 'DD/MM/YYYY'
                },
                ranges: {
                   'Oggi': [moment(), moment()],
                   'Ieri': [moment().add(-1, 'days'), moment().add(-1, 'days')],
                   '7 Giorni Precedenti': [ moment().add(-7, 'days') , moment()],
                   '30 Giorni Precedenti': [moment().add(-30, 'days') , moment()],
                   'Anno in corso': [moment().add(-{/literal}{$dayYearFirst}{literal}, 'days') , moment()],
                   'Dal 1° Gennaio 2015': [moment().add(-{/literal}{$numDaysFrom2015}{literal}, 'days') , moment()]
                }
            }, cb);

            cb(start, end);
        });
        
    });
</script>
{/literal}