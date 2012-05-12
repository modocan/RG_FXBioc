/**
 * Created by IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 25/04/12
 * Time: 07:17
 * To change this template use File | Settings | File Templates.
 */
package mediators {
import org.robotlegs.mvcs.Mediator;

import views.VideoProductoView;

public class VideoProductoMediator extends Mediator {

    [Inject]
    public var vista:VideoProductoView;

    public function VideoProductoMediator() {
        super();
    }

    override public function onRegister():void
    {

    }
}
}
