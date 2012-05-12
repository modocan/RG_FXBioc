/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 12/05/12
 * Time: 16:36
 * To change this template use File | Settings | File Templates.
 */
package mediators {
import events.ControlEvent;
import events.PreguntasEvent;

import flash.events.Event;

import org.robotlegs.mvcs.Mediator;

import views.SeccionRespondeView;

public class SeccionRespondeMediator extends Mediator {

    [Inject]
    public var vista:SeccionRespondeView;

    public function SeccionRespondeMediator() {
        super();
    }

    override public function onRegister():void
    {
        eventMap.mapListener(vista, Event.ADDED_TO_STAGE, init);
        eventMap.mapListener(eventDispatcher, PreguntasEvent.SELECCIONADAS, seleccionadas);
        eventMap.mapListener(eventDispatcher, PreguntasEvent.CLIC_RESPUESTA, muestraRespuesta);
    }


    private function init(e:Event):void
    {
        var evento:ControlEvent = new ControlEvent(ControlEvent.SECCION);
        evento.quien = vista.name;
        eventDispatcher.dispatchEvent(evento);

        eventDispatcher.dispatchEvent(new PreguntasEvent(PreguntasEvent.PIDE_RESPUESTAS));
    }


    private function seleccionadas(e:PreguntasEvent):void
    {
        vista.pintaSeleccionadas(e.datos);
    }


    private function muestraRespuesta(e:PreguntasEvent):void
    {
        vista.muestraRespuesta(e.datos);
    }

}
}
