
{def $provvedimenti = fetch( 'content', 'reverse_related_objects', hash( 'object_id', $node.contentobject_id 
                                                                        , 'all_relations', true()
                                                                        , 'sort_by', array('published', true()) ) )}

{if $provvedimenti|count()|gt(0)}
    <div class="RelatedDatatable">
        <form id="prv_search_form" class="Form">
            <div class="Grid">
                <div class="Grid-cell u-size1of2 u-padding-bottom-s">
                    <b class="u-color-40">{'Regulations'|i18n('designitalia/full')}</b>
                </div>

                <div class="Grid-cell u-size1of2 u-padding-bottom-s">
                    <div id="prvNumRows" class="u-textRight u-textItalic">

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

        <table class="Table Table--striped Table--responsive" id="table-normativa">
            <thead>
                <tr>
                    <th>{'Published date'|i18n('designitalia/full')}</th>
                    <th>{'Number'|i18n('designitalia/full')}</th>
                    <th>{'Title'|i18n('designitalia/full')}</th>
                    {*<th>Proponente</th>*}
                </tr>
            </thead>
            <tbody>
                {foreach $provvedimenti as $provvedimento}
                    {* Viene esclusa la sezione Provvedimenti Importati (7)*}
                    {if and( $provvedimento.section_identifier|ne('provvedimenti_importati') ,
                            or($provvedimento.main_node.class_identifier|eq('deliberazione'),
                               $provvedimento.main_node.class_identifier|eq('determinazione'),
                               $provvedimento.main_node.class_identifier|eq('circolare')))
                    }
                    <tr>
                        <td> {$provvedimento.published|datetime( 'custom', '%d/%m/%Y')} </td>
                        <td> {attribute_view_gui attribute=$provvedimento|attribute('numero')}</td>
                        <td>
                            <a href="{$provvedimento.main_node.url|ezurl(no)}">
                            {if $provvedimento|has_attribute('titolo')}
                                {attribute_view_gui attribute=$provvedimento|attribute('titolo')}
                            {else}
                                {$provvedimento.name|wash}
                            {/if}
                            </a>
                        </td>
                        {*<td>{attribute_view_gui attribute=$provvedimento|attribute('proponente')}</td>*}
                    </tr>

                    {/if}
                {/foreach}
            </tbody>
        </table>
    </div>
                    
                    
   {literal}
        <script>
            $(document).ready(function() {
                var prvDatatable = $('#table-normativa').DataTable({
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
                    "columnDefs" : [
                        { type: 'date-euro', targets: 0 }
                    ],
                    "order": [[ 0, "desc" ]],
                    "bLengthChange": false,
                    "bInfo" : false // Nasconde il numero di righe visualizzate
                } );

                // Aggiorna la ricerca //
                function prvSearch(event){
                    // Numero elementi per pagina
                    if(event !== null && event.target.id === 'show'){
                        prvDatatable.page.len( $(event.target).val() );
                    }

                    prvDatatable.search( $("#query").val() ).draw();

                    var numElements = prvDatatable.data().count();

                    if(numElements === 1){
                        $("#prvNumRows").html( numElements + ' {/literal}{'element found'|i18n('designitalia/full')}{literal}' );
                    }
                    else{
                        $("#prvNumRows").html( numElements + ' {/literal}{'elements found'|i18n('designitalia/full')}{literal}' );
                    }
                }

                // Lancia la ricerca //
                $("#prv_search_form #query").keyup(function(event) {
                    prvDatatable.search( $(this).val() ).draw();
                });

                // Blocca la submit //
                $("#prv_search_form #query").keypress(function(event) {
                    if (event.which === 13) {
                        event.preventDefault();
                    }
                });

                // Ricarica lanciata su select //
                $("#prv_search_form select").change(function(event){
                    prvSearch(event);
                });

                prvSearch(null);
            });
        </script>
    {/literal}                 
{/if}
{undef $provvedimenti}