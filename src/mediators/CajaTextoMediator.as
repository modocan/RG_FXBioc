/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 22/04/12
 * Time: 02:22
 * To change this template use File | Settings | File Templates.
 */
package mediators {
import com.hexagonstar.util.debug.Debug;

import events.PreguntasEvent;

import org.robotlegs.mvcs.Mediator;

import views.CajaTextoView;

public class CajaTextoMediator extends Mediator {

    [Inject]
    public var vista:CajaTextoView;

    public function CajaTextoMediator() {
        super();
    }


    override public function onRegister():void
    {
        eventMap.mapListener(vista, PreguntasEvent.ENVIA_PREGUNTA, enviaPregunta)
    }


    private function enviaPregunta(e:PreguntasEvent):void
    {
        Debug.trace('[click]');

        var evento:PreguntasEvent = new PreguntasEvent(PreguntasEvent.ENVIA_PREGUNTA);
        evento.datos.pregunta = e.datos.pregunta;
        eventDispatcher.dispatchEvent(evento);
    }


}
}
