/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 20/04/12
 * Time: 17:58
 * To change this template use File | Settings | File Templates.
 */
package commands {
import com.hexagonstar.util.debug.Debug;
import com.hexagonstar.util.debug.Debug;

import events.MenuEvent;

import flash.display.Sprite;

import models.IMainModel;

import org.robotlegs.mvcs.Command;

import views.SeccionPreguntaView;
import views.SeccionProductoView;
import views.SeccionSpotView;

public class CambiaSeccionCommand extends Command {

    [Inject]
    public var ev:MenuEvent;

    [Inject]
    public var modelo:IMainModel;

    public function CambiaSeccionCommand() {
        super();
    }


    override public function execute():void
    {
        Debug.trace(ev.quien);

        switch(ev.quien)
        {
            case 'PREGUNTA A CONTADOR':
                contextView.addChild(new SeccionPreguntaView(ev.quien));
                break;

            case 'PRODUCTO':
                contextView.addChild(new SeccionProductoView(ev.quien));
                break;

            case 'SPOT':
                contextView.addChild(new SeccionSpotView(ev.quien, modelo.dameVideoSpot()));
                break;

            case 'INICIO':
                break;
        }
    }
}
}
