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

        switch(e.quien)
        {
            case 'fb':
                navigateToURL(new URLRequest(encodeURI("http://www.facebook.com/sharer.php?s=100&p[url]=http://www.tourflex.es&p[images][0]=http://www.tourflex.es/imgs/tourflex_90x90.jpg&p[title]=Alberto Contador correrá la etapa reina del Tour que le quitaron.&p[summary]=¡Dale ánimos! Lo escuchará en directo durante la carrera.")), '_blank');
                break;

            case 'twt':
                var _url_twitter:String = "http://twitter.com/home?status="+encodeURI("Alberto Contador correrá la etapa reina del Tour que le quitaron. ¡Anímale! Lo escuchará en directo durante la carrera. http://www.tourflex.es");
                navigateToURL(new URLRequest(_url_twitter),'_blank');
                break;

            case 'tnt':
                navigateToURL(new URLRequest(encodeURI("http://www.tuenti.com/?m=Share&url=http://www.tourflex.es&referer=&suggested-text=Alberto Contador correrá la etapa reina del Tour que le quitaron. http://www.tourflex.es")), "_blank");
                break;
        }

    }

}
}