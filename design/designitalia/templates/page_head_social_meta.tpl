<!-- Condivisione social meta tags -->
{def $node = fetch('content', 'node', hash('node_id', $pagedata.node_id))
     $openpa = object_handler($node)}

{include uri=$openpa.control_template.socialmetatags}

{undef $node}
<!-- / -->