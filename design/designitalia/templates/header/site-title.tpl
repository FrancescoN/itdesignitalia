<div class="Header-title Grid-cell">
    <h1 class="Header-titleLink">
        <a href={"/"|ezurl}>
            {* TITOLO *}
            {if $root_node|has_attribute('short_name')}
                {$root_node|attribute('short_name').data_text}
            {else}
                {$root_node.name}
            {/if}
            <br>
            {* SOTTOTITOLO *}
            {if $root_node|has_attribute('short_name')}
                <small>{$root_node.name}</small>
            {/if}
          </a>
    </h1>
</div>