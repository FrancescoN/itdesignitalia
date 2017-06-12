
<div class="Form-field Form-field--withPlaceholder Grid u-margin-bottom-s" role="search">
    <input class="Form-input Grid-cell u-sizeFill u-text-r-s u-border-none"
           type="text" 
           
           id="{$id}" 
           name="{$input_name}"
           value="{$value|wash()}">

    {if is_set($label)}<label class="Form-label" for="{$id}">{$label}</label>{/if}
    
    {*
    <button class="Grid-cell u-sizeFit u-background-60 u-color-white u-padding-all-s u-textWeight-700 mdi mdi-magnify mdi-18px" 
            title="Start searching" aria-label="Start searching">
    </button>
    *}
</div>