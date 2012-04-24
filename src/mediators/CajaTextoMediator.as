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
        eventMap.mapListener(vista, PreguntasEvent.ENVIA_PREGUNTA, enviaPregunta);
        eventMap.mapListener(eventDispatcher, PreguntasEvent.PREGUNTA_ELEGIDA, pintaElegida);
        eventMap.mapListener(vista, PreguntasEvent.TEXTO_CERRADO, textoCerrado);
    }


    private function enviaPregunta(e:PreguntasEvent):void
    {
        Debug.trace('[click]');

        var evento:PreguntasEvent = new PreguntasEvent(PreguntasEvent.ENVIA_PREGUNTA);
        evento.datos.pregunta = e.datos.pregunta;
        eventDispatcher.dispatchEvent(evento);
    }
    
    
    private function pintaElegida(e:PreguntasEvent):void
    {
        vista.cambiaLeer(e.datos);
    }


    private function textoCerrado(e:PreguntasEvent):void
    {
        eventDispatcher.dispatchEvent(new PreguntasEvent(PreguntasEvent.TEXTO_CERRADO));
    }


}
}
