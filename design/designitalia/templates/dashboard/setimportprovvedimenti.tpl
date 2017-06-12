<header>
        <h2>
            <i class="fa fa-cogs"></i>
            Setting Import Provvedimenti
        </h2>
</header>
<hr>
<p>


<table class="table table-striped">
    <thead>
    <tr>
        <th class="header" style="cursor: pointer;">Tipo</th>
        <th class="header" style="cursor: pointer;">Parametro</th>
        <th class="header" style="cursor: pointer;">Valore</th>
    </tr>
    </thead>
    
    {def $repository_list = ezini( 'Client' , 'AvailableRepositories' , 'ocrepository.ini' ) }

    {if count( $repository_list )|gt(0)}
        {foreach $repository_list as $repository}
            {def $curClient = concat('Client_' , $repository)} 
            {def $curRepo = concat('WsImportFilter_' , ezini( $curClient , 'Name' , 'ocrepository.ini' )) }
            {def $iniSetdeliName = ezini( $curRepo , 'AttributeName' , 'ddwWSRuntimeSettings.ini' ) }
            {def $iniSetdeliValue = ezini( $curRepo , 'AttributeValue' , 'ddwWSRuntimeSettings.ini' ) }            
            {def $countParameters = $iniSetdeliName|count()}            
            {if  $countParameters|gt(0)}
            <tbody>          
            {for 0 to $iniSetdeliName|count()|sub(1) as $counter}
                <tr>
                <td>
                    <i class="fa fa-file-text-o"></i>
                    {ezini( $curClient , 'Name' , 'ocrepository.ini' )}
                </td>
                <td> {$iniSetdeliName[$counter]}</td>
                <td> {$iniSetdeliValue[$counter]|explode(',')|implode(' - ')}</td>
            {/for}
            </tbody>
            {/if}
        {/foreach}
    {/if}
</table>


    