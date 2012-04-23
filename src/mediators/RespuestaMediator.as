/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 22/04/12
 * Time: 20:13
 * To change this template use File | Settings | File Templates.
 */
package mediators {
import org.robotlegs.mvcs.Mediator;

import views.RespuestaView;

public class RespuestaMediator extends Mediator {

    [Inject]
    public var vista:RespuestaView;

    public function RespuestaMediator() {
        super();
    }

    override public function onRegister():void
    {

    }

}
}
