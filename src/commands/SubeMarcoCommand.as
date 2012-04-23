/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 21/04/12
 * Time: 12:35
 * To change this template use File | Settings | File Templates.
 */
package commands {
import events.ControlEvent;

import org.robotlegs.mvcs.Command;

public class SubeMarcoCommand extends Command {

    [Inject]
    public var e:ControlEvent;

    public function SubeMarcoCommand() {
        super();
    }


    override public function execute():void
    {
        contextView.addChild(contextView.getChildByName('marco'));

        var evento:ControlEvent = new ControlEvent(ControlEvent.APAGAR);
        evento.quien = e.quien;
        eventDispatcher.dispatchEvent(evento);
    }

}
}
