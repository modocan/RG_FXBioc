/**
 * Created with IntelliJ IDEA.
 * User: rubenmorato
 * Date: 12/05/12
 * Time: 13:56
 * To change this template use File | Settings | File Templates.
 */
package mediators {
import com.hexagonstar.util.debug.Debug;

import events.ControlEvent;
import events.InicioEvent;

import flash.events.Event;

import flash.events.TimerEvent;

import flash.utils.Timer;

import org.robotlegs.mvcs.Mediator;

import views.SeccionStreamingView;

public class StreamingMediator extends Mediator{

    [Inject]
    public var vista:SeccionStreamingView;


    public function StreamingMediator() {
    }

    override public function onRegister():void{

        eventMap.mapListener(eventDispatcher, ControlEvent.APAGAR, apaga);
        eventMap.mapListener(vista, Event.ADDED_TO_STAGE, init);
        eventMap.mapListener(eventDispatcher, InicioEvent.ABRIR, visible);

    }

    private function visible(e:InicioEvent){
        Debug.trace('mediator', Debug.LEVEL_ERROR);
        contextView.addChild(vista);
        var evento:ControlEvent = new ControlEvent(ControlEvent.SECCION);
        evento.quien = vista.name;
        eventDispatcher.dispatchEvent(evento);

        vista.reinicio();
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
        {   var tim:Timer = new Timer(800, 1);
            tim.addEventListener(TimerEvent.TIMER_COMPLETE, borra);
            tim.start();
        }
    }

    private function borra(e:TimerEvent):void
    {
        //contextView.removeChild(contextView.getChildByName(vista.name));
        vista.visible = false;
    }
}
}
