/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 21/04/12
 * Time: 13:00
 * To change this template use File | Settings | File Templates.
 */
package commands {
import events.ControlEvent;

import org.robotlegs.mvcs.Command;

public class ApagaSeccionesCommand extends Command {

    [Inject]
    public var e:ControlEvent;

    public function ApagaSeccionesCommand() {
        super();
    }


    override public function execute():void
    {
        var evento:ControlEvent = new ControlEvent(ControlEvent.APAGA);
        evento.quien = e.quien;
        eventDispatcher.dispatchEvent(evento);
    }

}
}
