{def $currentUser = fetch( 'user', 'current_user' )}
{def $classes = 'concorso'}


<div class="u-facet">

    <div class="u-facet-title">
        <div class="Grid">
            <div class="u-facet-heading">
                <h1>{$node.name|wash()}</h1>
            </div>
            <div id="numRows" class="u-facet-result-count">
                
            </div>
        </div>
    </div>

    <div id="prv_loading" class="Grid-cell u-textCenter">
        <i class="fa fa-spin fa-circle-o-notch fa-3x"></i>
    </div>

    <div id='prv_search' class="u-facet-form" style="display: none;">

        <form id="prv_search_form" class="Form">

            <div class="Grid">
                
                <div class="u-facet-form-cell-half">
                    <div class="Form-field Form-field--withPlaceholder Grid" role="search">
                        <input class="Form-input Grid-cell u-sizeFill u-text-r-s u-border-none" 
                               type="text"
                               id="query" 
                               name="query"
                               placeholder="{'Search'|i18n('designitalia')}...">
                        
                        <button class="Grid-cell u-sizeFit u-background-60 u-color-white u-padding-all-s u-textWeight-700 mdi mdi-magnify mdi-24px" 
                                title="Start searching" aria-label="Start searching">
                        </button>
                    </div>
                </div>

                <div class="u-facet-form-cell-half">
                    <div class="Form-field Form-field--withPlaceholder Grid">
                        <select class="Form-input Grid-cell u-sizeFill u-text-r-s u-border-none" 
                                id="figuraprofessionale" 
                                name="figuraprofessionale"
                                data-placeholder="{'Job title'|i18n('vivoscuoladi/concorsi')}">
                            <option value="" selected>{'Job title'|i18n('vivoscuoladi/concorsi')}</option>
                        </select>

                        <div class="Form-input Grid-cell u-sizeFill u-text-r-s u-border-none chosen-container chosen-container-single" 
                             style="width: 100%; display: none;" 
                             id="figuraprofessionale_choosen">
                            <a class="chosen-single chosen-single-with-deselect"
                               style="background-image: none; border: none; box-shadow: none; padding: 0 0 0 4px;">
                                <span id="figuraprofessionalee_value"></span>
                                <abbr id="figuraprofessionale_reset" class="search-choice-close"></abbr>
                            </a>
                        </div>
                    </div>
                </div>

                <div class="u-facet-form-cell-half">
                    <label for="show">{'Show'|i18n('designitalia/full')}</label>
                    
                    <select class="Form-input Form-input-inline u-text-r-s u-border-none" 
                            id="show" 
                            name="show">
                        <option value="10" selected>10</option>
                        <option value="25">25</option>
                        <option value="50">50</option>
                        <option value="100">100</option>
                    </select>
                </div>
                
                <div class="u-facet-form-cell-half">
                    
                    <a id="prv_reset_button" class="pull-right" style="display: none; cursor: pointer;">
                        {'Reset Filters'|i18n('designitalia/full')}
                    </a>
                </div>
            </div>

        </form>
    </div>

    <div id='prv_datatable' class="u-facet-table" style="display: none;">
        <table class="Table Table--striped Table--responsive" id="prv_datatable_content" width="100%">
            <thead>
                <tr>
                    <th>{'Job title'|i18n('vivoscuoladi/concorsi')}</th>
                    <th>{'Object'|i18n('vivoscuoladi/concorsi')}</th>
                    <th>{'Subscription start date'|i18n('vivoscuoladi/concorsi')}</th>
                    <th>{'Subscription end date'|i18n('vivoscuoladi/concorsi')}</th>
                    <th>{'Contest status'|i18n('vivoscuoladi/concorsi')}</th>                
                </tr>
            </thead>
        </table>
    </div>
</div>
 
{include uri="design:parts/children/concorso/concorso_script.tpl"}