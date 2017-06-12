{def $persone = fetch( 'content', 'related_objects', hash( 'object_id', $node.contentobject_id 
                                                          , 'all_relations', true()
                                                          , 'attribute_filter', array( array( 'class_identifier', '=', 'persona' )) 
                                                          , 'sort_by', array('published', true()) ) )}

{if $persone|count()|gt(0)}
    <div class="RelatedDatatable">
        <form id="dip_search_form" class="Form">
            <div class="Grid">
                <div class="Grid-cell u-size1of2 u-padding-bottom-s">
                    <b class="u-color-40">{'Employees'|i18n('designitalia/full')}</b>
                </div>

                <div class="Grid-cell u-size1of2 u-padding-bottom-s">
                    <div id="dipNumRows" class="u-textRight u-textItalic">

                    </div>
                </div>

                <div class="Grid-cell u-size2of3 u-padding-bottom-s">
                    <label for="show">{'Show'|i18n('designitalia/full')}</label>

                    <select class="Form-input Form-input-inline u-text-r-s u-border-none u-background-grey-10" 
                            id="show" 
                            name="show">
                        <option value="10" selected>10</option>
                        <option value="25">25</option>
                        <option value="50">50</option>
                        <option value="100">100</option>
                    </select>
                </div>

                <div class="Grid-cell u-size1of3 u-padding-bottom-s">
                    <div class="Form-field Form-field--withPlaceholder Grid" role="search">
                        <input class="Form-input Grid-cell u-sizeFill u-text-r-s u-border-none u-background-grey-10" 
                               type="text"
                               id="query" 
                               name="query"
                               placeholder="{'Search'|i18n('designitalia')}...">

                        <button class="Grid-cell u-sizeFit u-background-60 u-color-white u-padding-all-s u-textWeight-700 mdi mdi-magnify mdi-24px" 
                                title="Start searching" aria-label="Start searching">
                        </button>
                    </div>
                </div>
            </div>
        </form>

        <table class="Table Table--striped Table--responsive" id="table-dipendenti">
            <thead>
              <tr>
                <th>{'First Name'|i18n('designitalia/full')}</th>
                <th>{'Last Name'|i18n('designitalia/full')}</th>
                <th>Email</th>
                <th>{'Phone'|i18n('designitalia/full')}</th>
            </tr>
            </thead>
            <tbody>
                {foreach $persone as $persona}   

                    {if $persona.main_node.class_identifier|eq('persona')}
                    <tr>
                        <td>
                            <a href="{$persona.main_node.url|ezurl(no)}">
                                {attribute_view_gui attribute=$persona|attribute('nome')}
                            </a>
                        </td>
                        <td> 
                            <a href="{$persona.main_node.url|ezurl(no)}">
                                {if $persona|has_attribute('titolo')}
                                    {attribute_view_gui attribute=$persona|attribute('titolo')}
                                {/if}
                                {attribute_view_gui attribute=$persona|attribute('cognome')} 
                            </a>
                        </td>
                        <td>
                             {attribute_view_gui attribute=$persona|attribute('email')}
                        </td>
                        <td>
                             {attribute_view_gui attribute=$persona|attribute('telefono')}
                        </td>
                    </tr>
                    {/if}
                {/foreach}
            </tbody>
        </table>
    </div>

    {literal}
        <script>
            $(document).ready(function() {
                var dipDatatable = $('#table-dipendenti').DataTable({
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
                } );

                // Aggiorna la ricerca //
                function dipSearch(event){
                    // Numero elementi per pagina
                    if(event !== null && event.target.id === 'show'){
                        dipDatatable.page.len( $(event.target).val() );
                    }

                    dipDatatable.search( $("#query").val() ).draw();

                    var numElements = dipDatatable.data().count();

                    if(numElements === 1){
                        $("#dipNumRows").html( numElements + ' {/literal}{'element found'|i18n('designitalia/full')}{literal}' );
                    }
                    else{
                        $("#dipNumRows").html( numElements + ' {/literal}{'elements found'|i18n('designitalia/full')}{literal}' );
                    }
                }

                // Lancia la ricerca //
                $("#dip_search_form #query").keyup(function(event) {
                    // dipSearch(event);
                    dipDatatable.search( $(this).val() ).draw();
                });

                // Blocca la submit //
                $("#dip_search_form #query").keypress(function(event) {
                    if (event.which === 13) {
                        event.preventDefault();
                    }
                });

                // Ricarica lanciata su select //
                $("#dip_search_form select").change(function(event){
                    dipSearch(event);
                });

                dipSearch(null);
            });
        </script>
    {/literal}
{/if}