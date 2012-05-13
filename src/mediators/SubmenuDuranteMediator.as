/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 13/05/12
 * Time: 17:54
 * To change this template use File | Settings | File Templates.
 */
package mediators {
import events.MenuEvent;

import org.robotlegs.mvcs.Mediator;

import views.SubmenuDuranteView;

public class SubmenuDuranteMediator extends Mediator {

    [Inject]
    public var vista:SubmenuDuranteView;

    public function SubmenuDuranteMediator() {
        super();
    }

    override public function onRegister():void
    {
        eventMap.mapListener(vista, MenuEvent.CLICK_MENU, clicSub);
    }

    private function clicSub(e:MenuEvent):void
    {
        var evento:MenuEvent = new MenuEvent(MenuEvent.CLICK_MENU);
        evento.quien = e.quien;
        eventDispatcher.dispatchEvent(evento);
    }


}
}
