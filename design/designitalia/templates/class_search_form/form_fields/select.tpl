<div class="Form-field Form-field--withPlaceholder Grid u-margin-bottom-s">
    
  <select class="Form-input Grid-cell u-sizeFill u-text-r-s u-border-none"  name="{$input_name}" id="{$id}">
	<option value=""></option>
	{foreach $values as $value}	  
	  <option value="{$value.query}" {if $value.active}selected="selected"{/if}>{$value.name}</option>
	{/foreach}
  </select>
  
  {if is_set($label)}<label class="Form-label" for="{$id}">{$label}</label>{/if}
</div>