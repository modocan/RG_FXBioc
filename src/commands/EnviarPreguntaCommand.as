/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 22/04/12
 * Time: 13:47
 * To change this template use File | Settings | File Templates.
 */
package commands {
import com.hexagonstar.util.debug.Debug;

import events.PreguntasEvent;

import models.IMainModel;
import models.IPreguntasModel;

import org.robotlegs.mvcs.Command;

public class EnviarPreguntaCommand extends Command {

    [Inject]
    public var ev:PreguntasEvent;

    [Inject]
    public var datosMain:IMainModel;

    [Inject]
    public var preguntas:IPreguntasModel;

    public function EnviarPreguntaCommand() {
        super();
    }

    override public function execute():void
    {
        preguntas.enviaPregunta(Object(datosMain.dameUsuarioLogin()), String(ev.datos.pregunta));
    }

}
}
