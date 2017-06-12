{def $content_class = false()}

{foreach $node.children as $child}
    {set $content_class = $child.object.class_identifier}
    {break}
{/foreach}

{include uri=concat('design:parts/children/facetdatatable/', $content_class, '.tpl')}