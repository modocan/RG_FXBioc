/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 20/04/12
 * Time: 12:43
 * To change this template use File | Settings | File Templates.
 */
package commands {
import events.MenuEvent;

import models.IMainModel;

import org.robotlegs.mvcs.Command;

public class PideMenuCommand extends Command {

    [Inject]
    public var modelo:IMainModel;

    public function PideMenuCommand() {
        super();
    }

    override public function execute():void
    {
        var evento:MenuEvent = new MenuEvent(MenuEvent.LISTADO_MENU);
        evento.secciones = modelo.dameSecciones();
        eventDispatcher.dispatchEvent(evento);
    }

}
}
