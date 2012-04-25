/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 25/04/12
 * Time: 01:00
 * To change this template use File | Settings | File Templates.
 */
package mediators {
import assets.clases.eventos.PlayerYTBEvent;

import events.ControlEvent;
import events.SpotEvent;

import flash.events.Event;

import org.robotlegs.mvcs.Mediator;

import views.SeccionSpotView;

public class SeccionSpotMediator extends Mediator {

    [Inject]
    public var vista:SeccionSpotView;

    public function SeccionSpotMediator() {
        super();
    }

    override public function onRegister():void
    {
        eventMap.mapListener(vista, PlayerYTBEvent.INIT, init);
        eventMap.mapListener(vista, SpotEvent.ESTADO_PLAY, lanzaPlay);
        eventMap.mapListener(vista, SpotEvent.ESTADO_STOP, lanzaPlay);
    }


    private function init(e:Event):void
    {
        var evento:ControlEvent = new ControlEvent(ControlEvent.SECCION);
        evento.quien = vista.name;
        eventDispatcher.dispatchEvent(evento);
    }
    
    private function lanzaPlay(e:SpotEvent):void
    {
        if(e.type == SpotEvent.ESTADO_PLAY)
        {
            eventDispatcher.dispatchEvent(new SpotEvent(SpotEvent.ESTADO_PLAY));
        } else {
            eventDispatcher.dispatchEvent(new SpotEvent(SpotEvent.ESTADO_STOP));
        }

    }

}
}
