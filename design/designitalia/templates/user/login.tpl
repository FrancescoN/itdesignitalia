<div class='row'>
  <div class='col-sm-4 col-sm-offset-4'>
    <h1 class='text-center title u-text-h1'>{"Login"|i18n("design/ocbootstrap/user/login")}</h1>
    
    {if $User:warning.bad_login}
    <div class="alert alert-danger">
    <p><strong>{"Could not login"|i18n("design/ocbootstrap/user/login")}</strong></p>
    <p>{"A valid username and password is required to login."|i18n("design/ocbootstrap/user/login")}</p>
    </div>
    {/if}

    {if $site_access.allowed|not}
    <div class="alert alert-danger">
    <p><strong>{"Access not allowed"|i18n("design/ocbootstrap/user/login")}</strong></p>
    <p>{"You are not allowed to access %1."|i18n("design/ocbootstrap/user/login",,array($site_access.name))}</p>
    </div>
    {/if}
    
  </div>
</div>

<div class='row'>
  <div class='col-sm-4 col-sm-offset-4'>    
    <form class="validate-form" method="post" action={"/user/login/"|ezurl} name="loginform">
      {* <h3 class='text-center title'>Utente locale</h3> *}
      <div class='form-group'>
        <div class='controls with-icon-over-input'>          
          <input class="Form-input" type="text" autofocus="" autocomplete="off" name="Login" placeholder="{"Username"|i18n("design/ocbootstrap/user/login",'User name')}" class="form-control" data-rule-required="true" value="{$User:login|wash}">
          <i class='icon-user text-muted'></i>
        </div>
      </div>
      <div class='form-group'>
        <div class='controls with-icon-over-input'>          
          <input class="Form-input" type="password" autocomplete="off" name="Password" placeholder="{"Password"|i18n("design/ocbootstrap/user/login")}" class="form-control" data-rule-required="true" >
          <i class='icon-lock text-muted'></i>
        </div>
      </div>
      <div class='checkbox'>
        <label for='remember_me'>          
          <input id='remember_me' type="checkbox" tabindex="1" name="Cookie" id="id4" />{"Remember me"|i18n("design/ocbootstrap/user/login")}          
        </label>
      </div>
      <button class='btn btn-lg btn-primary center-block' name="LoginButton">{'Login'|i18n('design/ocbootstrap/user/login','Button')}</button>
      
      {if and( is_set( $User:post_data ), is_array( $User:post_data ) )}
        {foreach $User:post_data as $key => $postData}
           <input name="Last_{$key|wash}" value="{$postData|wash}" type="hidden" /><br/>
        {/foreach}
      {/if}
      <input type="hidden" name="RedirectURI" value="{$User:redirect_uri|wash}" />
      
    </form>
      <div class="text-center">
          <br/>
            <a href={'/user/forgotpassword'|ezurl}>
                <i class="fa fa-key"></i>
                {'Forgot your password?'|i18n( 'design/ocbootstrap/user/login' )}
            </a>
          <br/>
            <a href={'/user/register'|ezurl}>
                <i class="fa fa-user"></i>
                {'New user? Click here to register'|i18n( 'design/pat_base/user' )}
            </a>
      </div>
      
  </div>
</div>




