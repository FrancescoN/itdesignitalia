
{def $contacts = footer('footer_contacts')}
        
{if or(is_set($contacts.facebook), is_set($contacts.twitter), is_set($contacts.youtube))}
    <p>{'Follow us on'|i18n('designitalia')}:</p>
    <ul class="Header-socialIcons">
        {if is_set($contacts.facebook)}
        <li>
            <a href={$contacts.facebook} title="Facebook">
                <span class="Icon-facebook"></span>
                <span class="u-hiddenVisually">Facebook</span>
            </a>
        </li>
        {/if}

        {if is_set($contacts.twitter)}
        <li>
            <a href={$contacts.twitter} title="Twitter">
                <span class="Icon-twitter"></span>
                <span class="u-hiddenVisually">Twitter</span>
            </a>
        </li>
        {/if}

        {if is_set($contacts.youtube)}
        <li>
            <a href={$contacts.youtube} title="Youtube">
                <span class="Icon-youtube"></span>
                <span class="u-hiddenVisually">Youtube</span>
            </a>
        </li>
        {/if}

    </ul>
{/if}