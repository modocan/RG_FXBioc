/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 22/04/12
 * Time: 14:05
 * To change this template use File | Settings | File Templates.
 */
package commands {
import com.hexagonstar.util.debug.Debug;

import events.ControlEvent;

import models.IMainModel;

import org.robotlegs.mvcs.Command;

public class ActualizaUsuarioCommand extends Command {

    [Inject]
    public var ev:ControlEvent;

    [Inject]
    public var modelo:IMainModel;

    public function ActualizaUsuarioCommand() {
        super();
    }


    override public function execute():void
    {
        Debug.traceObj(Object(ev.datos.usuario));
        modelo.usuarioLogin(ev.datos.usuario);
    }

}
}
