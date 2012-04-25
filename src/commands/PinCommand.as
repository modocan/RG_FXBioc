/**
 * Created by IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 24/04/12
 * Time: 04:04
 * To change this template use File | Settings | File Templates.
 */
package commands {
import events.PreguntasEvent;

import models.ITWTConnection;

import org.robotlegs.mvcs.Command;

public class PinCommand extends Command {

    [Inject]
    public var ev:PreguntasEvent;

    [Inject]
    public var twt:ITWTConnection;

    public function PinCommand() {
        super();
    }

    override public function execute():void
    {
        twt.pintaPin(ev.datos.pin);
    }

}
}
