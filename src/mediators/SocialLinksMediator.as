/**
 * Created with IntelliJ IDEA.
 * User: rubenmorato
 * Date: 20/04/12
 * Time: 14:48
 * To change this template use File | Settings | File Templates.
 */
package mediators {
import events.MenuEvent;

import flash.net.URLRequest;
import flash.net.navigateToURL;

import org.robotlegs.mvcs.Mediator;

import views.SocialLinksView;

public class SocialLinksMediator extends Mediator {

    [Inject]
    public var vista:SocialLinksView;

    public function SocialLinksMediator() {
        super();
    }

    override public function onRegister():void
    {
        eventMap.mapListener(vista,  MenuEvent.CLICK_SOCIAL, clicSocial) ;
    }



    private function clicSocial(e:MenuEvent):void
    {
        var url:String;

        switch(e.quien)
        {
            case 'fb':
                url = '';
                break;

            case 'twt':
                url = '';
                break;

            case 'tnt':
                url = '';
                break;
        }


        navigateToURL(new URLRequest(url), '_blank');
    }

}
}
