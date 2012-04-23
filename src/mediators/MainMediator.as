/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 19/04/12
 * Time: 22:26
 * To change this template use File | Settings | File Templates.
 */
package mediators {
import events.ControlEvent;
import events.MenuEvent;

import org.robotlegs.mvcs.Mediator;

import views.MainView;

public class MainMediator extends Mediator {

    [Inject]
    public var vista:MainView;

    public function MainMediator() {
        super();
    }

    override public function onRegister():void
    {
        eventMap.mapListener(eventDispatcher, MenuEvent.PINTA_MENU, pintaMenu);
        eventMap.mapListener(eventDispatcher, ControlEvent.LOADER_LOGIN, pintaLoaderLogin);
        eventMap.mapListener(eventDispatcher, ControlEvent.FIN_LOADER_LOGIN, borraLoaderLogin);
    }


    private function pintaMenu(e:MenuEvent):void
    {
         vista.pintaMenu();
    }

    private function pintaLoaderLogin(e:ControlEvent):void
    {
        vista.creaCargandoLogin();
    }

    private function borraLoaderLogin(e:ControlEvent):void
    {
        vista.borrarCargandoLogin();
    }


}
}
