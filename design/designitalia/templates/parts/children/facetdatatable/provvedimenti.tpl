{def $currentUser = fetch( 'user', 'current_user' )}
{def $sectionidentifier = $node.object.section_identifier}

{*Calcolo giorni dal 1/1/2015*}
{def $dayYearFirst = currentdate()|datetime( 'custom', '%z' )}
{def $numDays = 0}
{def $numDaysFrom2015 = 1}
{for 2015 to sum( currentdate()|datetime( 'custom', '%Y' ), -1) as $currentYear}
    {set $numDays =  concat( '31-12-', $currentYear )}
    {set $numDays =  $numDays|strtotime()|datetime( 'custom', '%z' )}   
    {set $numDaysFrom2015 = sum($numDaysFrom2015,$numDays)}   
{/for}
{*Calcolo giorni dal 1/1/annoCorrente*}
{def $dayYearFirst = currentdate()|datetime( 'custom', '%z' )}
{set $numDaysFrom2015 = sum($numDaysFrom2015,$dayYearFirst,1)}   
  

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
                
                <div class="u-facet-form-cell">
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
                               
                <div class="u-facet-form-cell">
                    <div class="Form-field Form-field--withPlaceholder Grid">
                        <select class="Form-input Grid-cell u-sizeFill u-text-r-s u-border-none"
                                id="anno"
                                name="anno"
                                data-placeholder="{'All years'|i18n('designitalia/full')}">
                            <option value="" selected>{'All years'|i18n('designitalia/full')}</option>
                        </select>

                        <div class="Form-input Grid-cell u-sizeFill u-text-r-s u-border-none chosen-container chosen-container-single" 
                             style="width: 100%; display: none;" 
                             id="anno_choosen">
                            <a class="chosen-single chosen-single-with-deselect"
                               style="background-image: none; border: none; box-shadow: none; padding: 0 0 0 4px;">
                                <span id="anno_value"></span>
                                <abbr id="anno_reset" class="search-choice-close"></abbr>
                            </a>
                        </div>
                    </div>
                </div>
                 
                <div class="u-facet-form-cell">
                    <div class="Form-field Form-field--withPlaceholder Grid">
                        <div id="reportrange" class="Form-input Grid-cell u-sizeFill u-text-r-s u-border-none" style="cursor: pointer;">
                            <span></span> <i class="mdi mdi-chevron-down mdi-24px u-color-60 pull-right"></i>
                        </div>

                        <button id="reportrange_btn" class="Grid-cell u-sizeFit u-background-60 u-color-white u-padding-all-s u-textWeight-700 mdi mdi-calendar mdi-24px" 
                                title="Date range" aria-label="Date range">
                        </button>
                    </div>
                        
                    <input type="hidden" id="daterange" name="daterange"/>
                </div>
                
                <div class="u-facet-form-cell">
                    <div class="Form-field Form-field--withPlaceholder Grid">
                        <input type="number" 
                               class="Form-input Grid-cell u-sizeFill u-text-r-s u-border-none" 
                               id="numero" 
                               name="numero" 
                               placeholder="{'Number'|i18n('designitalia/full')}">
                    </div>
                </div>
                
                <div class="u-facet-form-cell">
                    <div class="Form-field Form-field--withPlaceholder Grid">
                        <select class="Form-input Grid-cell u-sizeFill u-text-r-s u-border-none" 
                                id="proponente" 
                                name="proponente"
                                data-placeholder="{'Proponent'|i18n('designitalia/full')}">
                            <option value="" selected>{'Proponent'|i18n('designitalia/full')}</option>
                        </select>

                        <div class="Form-input Grid-cell u-sizeFill u-text-r-s u-border-none chosen-container chosen-container-single" 
                             style="width: 100%; display: none;" 
                             id="proponente_choosen">
                            <a class="chosen-single chosen-single-with-deselect"
                               style="background-image: none; border: none; box-shadow: none; padding: 0 0 0 4px;">
                                <span id="proponente_value"></span>
                                <abbr id="proponente_reset" class="search-choice-close"></abbr>
                            </a>
                        </div>
                    </div>
                </div>

                <div class="u-facet-form-cell">
                    <div class="Form-field Form-field--withPlaceholder Grid">
                        <select class="Form-input Grid-cell u-sizeFill u-text-r-s u-border-none" 
                                id="struttura_competente" 
                                name="struttura_competente"
                                data-placeholder="{'Competent structure'|i18n('designitalia/full')}">
                            <option value="" selected>{'Competent structure'|i18n('designitalia/full')}</option>
                        </select>

                        <div class="Form-input Grid-cell u-sizeFill u-text-r-s u-border-none chosen-container chosen-container-single" 
                             style="width: 100%; display: none;" 
                             id="struttura_competente_choosen">
                            <a class="chosen-single chosen-single-with-deselect"
                               style="background-image: none; border: none; box-shadow: none; padding: 0 0 0 4px;">
                                <span id="struttura_competente_value"></span>
                                <abbr id="struttura_competente_reset" class="search-choice-close"></abbr>
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

            </div> <!-- .Grid -->
        </form> <!-- .Form -->
     </div> <!-- .u-facet-form -->

    <div id='prv_datatable' class="u-facet-table" style="display: none;">
        <table class="Table Table--striped Table--responsive" id="prv_datatable_content" width="100%">
            <thead>
                <tr>
                    <th>
                    {if ne( $sectionidentifier, "provvedimenti_importati" )}
                        {'Adoption date'|i18n('designitalia/full')}
                    {else}
                        {'Adoption date'|i18n('designitalia/full')}
                    {/if}
                    </th>
                    <th>{'Number'|i18n('designitalia/full')}</th>
                    <th>{'Title'|i18n('designitalia/full')}</th>
                    <th>{'Subtitle'|i18n('designitalia/full')}</th>
                    <th>{'Proponent'|i18n('designitalia/full')}</th>
                    {if $currentUser.login|ne("anonymous")}
                        <th style="color: red;">{'Published'|i18n('designitalia/full')}</th>
                        <th style="color: red;">{'Expiry'|i18n('designitalia/full')}</th>
                        <th>{'Visible'|i18n('designitalia/full')}</th>
                    {/if}
                </tr>
            </thead>
        </table>
    </div>
</div>

{include uri="design:parts/children/provvedimenti/provvedimenti_script.tpl"}