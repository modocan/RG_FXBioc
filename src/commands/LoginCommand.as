/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 21/04/12
 * Time: 16:09
 * To change this template use File | Settings | File Templates.
 */
package commands {
import com.hexagonstar.util.debug.Debug;

import events.PreguntasEvent;

import models.IFBConnection;
import models.ITWTConnection;

import org.robotlegs.mvcs.Command;

public class LoginCommand extends Command {

    [Inject]
    public var e:PreguntasEvent;

    [Inject]
    public var fb:IFBConnection;
    
    [Inject]
    public var twt:ITWTConnection;

    public function LoginCommand() {
        super();
    }


    override public function execute():void
    {
        Debug.trace('Ahora si!!')
        if(e.datos.tipo == 'fb')
        {
            fb.init();
        } else {
            
            twt.init();

        }
    }

}
}
