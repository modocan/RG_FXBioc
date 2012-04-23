/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 22/04/12
 * Time: 22:30
 * To change this template use File | Settings | File Templates.
 */
package commands {
import models.IPreguntasModel;

import org.robotlegs.mvcs.Command;

public class LuminariasCommand extends Command {

    [Inject]
    public var modelo:IPreguntasModel;

    public function LuminariasCommand() {
        super();
    }


    override public function execute():void
    {
        modelo.damePreguntas();
    }

}
}
