{ezpagedata_set( show_path, false() )}
{ezpagedata_set( hide_header_searchbox, false() )}

{def $search=false()
	 $use_url_translation=false()}
{if $use_template_search}
    {set $page_limit=20}

    {def $activeFacetParameters = array()}
    {if ezhttp_hasvariable( 'activeFacets', 'get' )}
        {set $activeFacetParameters = ezhttp( 'activeFacets', 'get' )}
    {/if}

    {def $dateFilter=0}
    {if ezhttp_hasvariable( 'dateFilter', 'get' )}
        {set $dateFilter = ezhttp( 'dateFilter', 'get' )}
        {switch match=$dateFilter}
            {case match=1}
                {def $dateFilterLabel="Last day"|i18n("design/standard/content/search")}
            {/case}
            {case match=2}
                {def $dateFilterLabel="Last week"|i18n("design/standard/content/search")}
            {/case}
            {case match=3}
                {def $dateFilterLabel="Last month"|i18n("design/standard/content/search")}
            {/case}
            {case match=4}
                {def $dateFilterLabel="Last three months"|i18n("design/standard/content/search")}
            {/case}
            {case match=5}
                {def $dateFilterLabel="Last year"|i18n("design/standard/content/search")}
            {/case}
        {/switch}
    {/if}

    {def $filterParameters = fetch( 'ezfind', 'filterParameters' )
         $defaultSearchFacets = array(
                                       hash( 'field', 'class', 'name', 'Content type'|i18n("extension/ezfind/facets"), 'limit', 20 )
                                     )}
        
    {set $search=fetch( ezfind,search,
                        hash( 'query', $search_text,
                              'offset', $view_parameters.offset,
                              'limit', $page_limit,
                              'sort_by', hash( 'score', 'desc' ),
                              'facet', $defaultSearchFacets,
                              'filter', $filterParameters,
                              'publish_date', $dateFilter,
                              'spell_check', array( false() ),
                              'search_result_clustering', hash( 'clustering', false() ) )
                             )}
    {set $search_result=$search['SearchResult']}
    {set $search_count=$search['SearchCount']}
    {def $search_extras=$search['SearchExtras']}
    {set $stop_word_array=$search['StopWordArray']}
    {set $search_data=$search}
{/if}
{def $baseURI=concat( '/content/search?SearchText=', $search_text )}

{* Build the URI suffix, used throughout all URL generations in this page *}
{def $uriSuffix = ''}
{foreach $activeFacetParameters as $facetField => $facetValue}
    {set $uriSuffix = concat( $uriSuffix, '&activeFacets[', $facetField, ']=', $facetValue )}
{/foreach}

{foreach $filterParameters as $name => $value}
    {set $uriSuffix = concat( $uriSuffix, '&filter[]=', $name, ':', $value )}
{/foreach}

{if gt( $dateFilter, 0 )}
    {set $uriSuffix = concat( $uriSuffix, '&dateFilter=', $dateFilter )}
{/if}

{* Design Italia *}

<form action="{"/content/search/"|ezurl(no)}" method="get">
    <input type="hidden" name="SearchText" value="{$search_text|wash}" />
    
    <div class="Grid FullSearch">
        <div class="Grid-cell u-sm-size2of3 u-md-size2of3 u-lg-size2of3 u-padding-all-xxxl">

            {* TITOLO*}
            <h1 class="u-color-50">
                {'Searched text'|i18n('designitalia/searchpage')}
            </h1>
            {if $search_text|ne('')}
                <div class="SearchResult u-padding-top-s u-padding-bottom-xxl">
                    {switch name=Sw match=$search_count}
                        {case match=0}
                            {'No results were found when searching for "%1".'|i18n("design/ezwebin/content/search",,array($search_text|wash))}
                            {if $search_extras.hasError}
                                {$search_extras.error|wash}
                            {/if}	
                        {/case}
                        {case}
                            {if $search_text|ne('')}
                                {'Search for "%1" returned %2 matches'|i18n("design/ezwebin/content/search",,array($search_text|wash,$search_count))}
                            {else}
                                {$search_count} {"Results"|i18n("design/base")|downcase()}
                            {/if}
                        {/case}
                  {/switch}
                </div>
            {/if}

            {* RISULTATI *}
            {foreach $search_result as $result sequence array(bglight,bgdark) as $bgColor}
                {node_view_gui view='search_line' sequence=$bgColor use_url_translation=$use_url_translation content_node=$result}
            {/foreach}
            
            {include name=Navigator
                     uri='design:navigator/google.tpl'
                     page_uri='/content/search'
                     page_uri_suffix=concat('?SearchText=',$search_text|urlencode,$search_timestamp|gt(0)|choose('',concat('&SearchTimestamp=',$search_timestamp)), $uriSuffix )
                     item_count=$search_count
                     view_parameters=$view_parameters
                     item_limit=$page_limit}
            
        </div>

        <div class="Grid-cell u-background-grey-10 u-sm-size1of3 u-md-size1of3 u-lg-size1of3 u-padding-all-xxl u-layout-centerContent hidden-xs">
            
            
            <ul class="list-unstyled u-margin-left-xxl u-margin-top-xl" id="facet-list">
                {* FACCETTE RICERCATE *}
                {def $activeFacetsCount=0}
                <li class="u-margin-bottom-m">
                    <h3>
                        <i class="mdi mdi-filter-outline mdi-24px"></i>
                        <span class="u-color-50 u-margin-left-s">
                            {'Selected filters'|i18n('designitalia/searchpage')}
                        </span>
                    </h3>
                    <ul class="list-unstyled u-margin-top-m" id="active-facets-list">
                    {foreach $defaultSearchFacets as $key => $defaultFacet}
                        {if array_keys( $activeFacetParameters )|contains( concat( $defaultFacet['field'], ':', $defaultFacet['name']  ) )}
                            {def $facetData=$search_extras.facet_fields.$key}

                            {foreach $facetData.nameList as $key2 => $facetName}
                                {if eq( $activeFacetParameters[concat( $defaultFacet['field'], ':', $defaultFacet['name'] )], $facetName )}
                                    {set $activeFacetsCount=sum( $key, 1 )}
                                    {def $suffix=$uriSuffix
                                                                                            |explode( concat( '&filter[]=', $facetData.queryLimit[$key2] ) )
                                                                                            |implode( '' )
                                                                                            |explode( concat( '&activeFacets[', $defaultFacet['field'], ':', $defaultFacet['name'], ']=', $facetName ) )
                                                                                            |implode( '' )}
                                    <li class="u-margin-left-m">
                                        <a class="btn btn-primary btn-xs u-color-white" 
                                            href={concat( $baseURI, $suffix )|ezurl} 
                                            title="{'Remove filter on '|i18n( 'design/ezwebin/content/search' )}'{$facetName|trim('"')|wash}'">
                                            
                                            <i class="remover mdi mdi-close"></i>
                                            <span>
                                                <strong>{$defaultFacet['name']}</strong>&nbsp;{$facetName|trim('"')|shorten(20)|wash}
                                            </span>
                                        </a>
                                    </li>						  
                                {/if}
                            {/foreach}                  
                        {/if}
                    {/foreach}

                    {* handle date filter here, manually for now. Should be a facet later on *}
                    {if gt( $dateFilter, 0 )}
                        <li class="u-margin-left-m">
                           {def $activeFacetsCount=$activeFacetsCount|inc}
                           {def $suffix=$uriSuffix|explode( concat( '&dateFilter=', $dateFilter ) )|implode( '' )}
                            <a class="btn btn-primary btn-xs u-color-white" href={concat( $baseURI, $suffix )|ezurl} title="{'Remove filter on '|i18n( 'design/ezwebin/content/search' )}'{$dateFilterLabel}'">
                                <i class="remover mdi mdi-close"></i>
                                <span>
                                    <strong>{'Creation time'|i18n( 'extension/ezfind/facets' )}</strong>&nbsp;{$dateFilterLabel}
                                </span>
                            </a> 
                        </li>
                    {/if}

                    {if $activeFacetsCount|eq(0)}
                        
                        <li class="u-margin-left-m">
                            {'No filters selected'|i18n('designitalia/searchpage')}
                        </li>
                    {/if}
                    </ul>
                </li>
                
                {* FACCETTE *}
                {foreach $defaultSearchFacets as $key => $defaultFacet}
                    {if array_keys( $activeFacetParameters )|contains( concat( $defaultFacet['field'], ':', $defaultFacet['name']  ) )|not}
                      {def $facetData=$search_extras.facet_fields.$key}
                      <li>
                          <h3>
                              <i class="mdi mdi-magnify mdi-24px"></i>
                              <span class="u-color-50 u-margin-left-s">
                                  {'Class'|i18n('designitalia/searchpage')}
                              </span>
                          </h3>
                          
                          <ul class="list-unstyled u-margin-top-l u-text-xxs">
                            {foreach $facetData.nameList as $key2 => $facetName}
                                {if ne( $key2, '' )}
                                <li class="Grid u-padding-all-xs">
                                    <div class="Grid-Cell u-size1of12 facet-count">
                                        <a href={concat(
                                            $baseURI, '&filter[]=', $facetData.queryLimit[$key2],
                                            '&activeFacets[', $defaultFacet['field'], ':', $defaultFacet['name'], ']=',
                                            $facetName|rawurlencode,
                                            $uriSuffix )|ezurl}>
                                            
                                            <b>{$facetData.countList[$key2]}</b>
                                        </a>
                                    </div>
                                    <div class="Grid-Cell u-size11of12">
                                        <a href={concat(
                                            $baseURI, '&filter[]=', $facetData.queryLimit[$key2],
                                            '&activeFacets[', $defaultFacet['field'], ':', $defaultFacet['name'], ']=',
                                            $facetName|rawurlencode,
                                            $uriSuffix )|ezurl}>
                                            
                                            <span class="u-padding-all-xxs u-color-white u-background-30">
                                                {$facetName|shorten(20)|wash}
                                            </span>
                                        </a>
                                    </div>
                                </li>
                                {/if}
                            {/foreach}
                          </ul>                    
                      </li>
                      {/if}
                      {undef $facetData }              
                {/foreach}
                
                {* DATE *}
                {if eq( $dateFilter, 0 )}
                    <li class="u-margin-top-m">
                        <h3>
                            <i class="mdi mdi-calendar mdi-24px"></i>
                            <span class="u-color-50 u-margin-left-s">
                                {'Creation time'|i18n( 'extension/ezfind/facets' )}
                            </span>
                        </h3>
                        <ul class="list-unstyled u-margin-top-l u-text-xxs">
                          <li class="Grid u-padding-all-xs">
                              <a href={concat( $baseURI, '&dateFilter=1', $uriSuffix )|ezurl}>
                                  <span class="u-padding-all-xxs u-color-white u-background-30">
                                      {"Last day"|i18n("design/standard/content/search")}
                                  </span>
                              </a>
                          </li>
                          <li class="Grid u-padding-all-xs">
                              <a href={concat( $baseURI, '&dateFilter=2', $uriSuffix )|ezurl}>
                                  <span class="u-padding-all-xxs u-color-white u-background-30">{"Last week"|i18n("design/standard/content/search")}</span>
                              </a>
                          </li>
                          <li class="Grid u-padding-all-xs">
                              <a href={concat( $baseURI, '&dateFilter=3', $uriSuffix )|ezurl}>
                                  <span class="u-padding-all-xxs u-color-white u-background-30">{"Last month"|i18n("design/standard/content/search")}</span>
                              </a>
                          </li>
                          <li class="Grid u-padding-all-xs">
                              <a href={concat( $baseURI, '&dateFilter=4', $uriSuffix )|ezurl}>
                                  <span class="u-padding-all-xxs u-color-white u-background-30">{"Last three months"|i18n("design/standard/content/search")}</span>
                              </a>
                          </li>
                          <li class="Grid u-padding-all-xs">
                              <a href={concat( $baseURI, '&dateFilter=5', $uriSuffix )|ezurl}>
                                  <span class="u-padding-all-xxs u-color-white u-background-30">{"Last year"|i18n("design/standard/content/search")}</span>
                              </a>
                          </li>
                        </ul>
                    </li>
                {/if}
            </ul>
        </div>
    </div>
</form>