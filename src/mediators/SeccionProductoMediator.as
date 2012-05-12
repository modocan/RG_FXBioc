/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 21/04/12
 * Time: 13:34
 * To change this template use File | Settings | File Templates.
 */
package mediators {
import com.hexagonstar.util.debug.Debug;

import events.ControlEvent;

import flash.events.Event;
import flash.events.TimerEvent;
import flash.utils.Timer;

import org.robotlegs.mvcs.Mediator;

import views.SeccionProductoView;

public class SeccionProductoMediator extends Mediator {

    [Inject]
    public var vista:SeccionProductoView;

    public function SeccionProductoMediator() {
        super();
    }

    override public function onRegister():void
    {
        eventMap.mapListener(vista, Event.ADDED_TO_STAGE, init);
        eventMap.mapListener(eventDispatcher, ControlEvent.APAGAR, apaga);
    }


    private function init(e:Event):void
    {
        var evento:ControlEvent = new ControlEvent(ControlEvent.SECCION);
        evento.quien = vista.name;
        eventDispatcher.dispatchEvent(evento);
    }






    private function apaga(e:ControlEvent):void
    {
        if(e.quien != vista.name)
        {
            vista.destruye();
            var tim:Timer = new Timer(800, 1);
            tim.addEventListener(TimerEvent.TIMER_COMPLETE, borra);
            tim.start();
        }
    }

    private function borra(e:TimerEvent):void
    {
        Debug.trace('[FUNCION BORRAR]', Debug.LEVEL_ERROR);

        if(contextView.getChildByName(vista.name))
        {
            contextView.removeChild(contextView.getChildByName(vista.name));
        }

    }
}
}
