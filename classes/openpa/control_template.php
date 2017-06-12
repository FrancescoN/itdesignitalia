<?php

/**
 * Aggiungo alle possibile viste la vista flowpanel che serve per i pannelli
 * dentro ezflow
 */
class DesignItaliaObjectHandlerServiceControlTemplate extends ObjectHandlerServiceControlTemplate
{
    function run()
    {
        $this->data['full'] = $this->getViewTemplate( 'full' );
        $this->data['line'] = $this->getViewTemplate( 'line' );
        $this->data['panel'] = $this->getViewTemplate( 'panel' );
        $this->data['carousel'] = $this->getViewTemplate( 'carousel' );
        $this->data['carousel_simple'] = $this->getViewTemplate( 'carousel_simple' );
        $this->data['mail_ezsubtreenotification'] = $this->getViewTemplate( 'mail_ezsubtreenotification' );
        $this->data['flowpanel'] = $this->getViewTemplate( 'flowpanel' );
        $this->data['socialmetatags'] = $this->getViewTemplate( 'socialmetatags' );
    }
    
}

