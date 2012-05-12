/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 12/05/12
 * Time: 17:36
 * To change this template use File | Settings | File Templates.
 */
package commands {
import models.IPreguntasModel;

import org.robotlegs.mvcs.Command;

public class PidePreguntasCommand extends Command {

    [Inject]
    public var modelo:IPreguntasModel;

    public function PidePreguntasCommand() {


    }

    override public function execute():void
    {
        modelo.pideSeleccionadas();
    }

}
}
