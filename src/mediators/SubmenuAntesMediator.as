/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 13/05/12
 * Time: 13:14
 * To change this template use File | Settings | File Templates.
 */
package mediators {
import events.MenuEvent;

import org.robotlegs.mvcs.Mediator;

import views.SubmenuAntesView;

public class SubmenuAntesMediator extends Mediator {

    [Inject]
    public var vista:SubmenuAntesView;

    public function SubmenuAntesMediator() {
        super();
    }


    override public function onRegister():void
    {
        eventMap.mapListener(vista,  MenuEvent.CLICK_MENU, clicSub);
    }


    private function clicSub(e:MenuEvent):void
    {
        var evento:MenuEvent = new MenuEvent(MenuEvent.CLICK_MENU);
        evento.quien = e.quien;
        eventDispatcher.dispatchEvent(evento);
    }

}
}
