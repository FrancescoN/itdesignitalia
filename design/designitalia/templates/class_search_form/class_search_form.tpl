{*
  helper OCClassSearchFormHelper
  class eZContentClass
  sort_form html tpl @todo
  published_form html tpl @todo
*}

{if is_set($form_action)|not}
    {def $form_action = '/ocsearch/action'|ezurl( 'no' )}
{/if}

<form name="{concat('class_search_form_',$helper.class.identifier)}" method="get" action="{$form_action}">
    
  {include uri='design:class_search_form/query.tpl' helper=$helper input=$helper.query_field}
  
  {foreach $helper.attribute_fields as $input}	
	{attribute_search_form( $helper, $input )}
  {/foreach}
  
  {include uri='design:class_search_form/sort.tpl' helper=$helper input=$helper.sort_field}
  
  {include uri='design:class_search_form/publish_date.tpl' helper=$helper input=$helper.published_field}

  {foreach $parameters as $key => $value}
	<input type="hidden" name="{$key}" value="{$value}" />
  {/foreach}
  
  <input type="hidden" name="class_id" value="{$helper.class.id}" />  
  
  {if is_set($class_filter)}
    <input type="hidden" name="class_filter" value="{$class_filter}" />  
  {/if}
  
  <button class="Button Button--default" type="submit">
      <i class="mdi mdi-magnify mdi-24px"></i>
      {'Search'|i18n('design/ocbootstrap/pagelayout')}
  </button>
</form>
