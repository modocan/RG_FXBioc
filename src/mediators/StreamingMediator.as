/**
 * Created with IntelliJ IDEA.
 * User: rubenmorato
 * Date: 12/05/12
 * Time: 13:56
 * To change this template use File | Settings | File Templates.
 */
package mediators {
import org.robotlegs.mvcs.Mediator;

import views.SeccionStreamingView;

public class StreamingMediator extends Mediator{

    [Inject]
    public var vista:SeccionStreamingView;


    public function StreamingMediator() {
    }

    override public function onRegister():void{


    }
}
}
