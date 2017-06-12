{def $id = concat('search-for-',$input.id)}

<div class="Form-field Form-field--withPlaceholder Grid u-margin-bottom-s">
    <input name={$input.name} 
           id={$id} 
           type="text" 
           class="Form-input Grid-cell u-sizeFill u-text-r-s u-border-none" 
           {if ezhttp_hasvariable( $input.name, 'get' )}
             value={ezhttp( $input.name, 'get' )}
           {/if}
           >
    <label class="Form-label" for={$id} >{$input.class_attribute.name}</label>
</div>

{undef $id}