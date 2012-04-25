/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 21/04/12
 * Time: 15:44
 * To change this template use File | Settings | File Templates.
 */
package mediators {
import com.hexagonstar.util.debug.Debug;

import events.ControlEvent;

import events.PreguntasEvent;

import flash.events.MouseEvent;

import org.robotlegs.mvcs.Mediator;

import views.CajaLoginView;

public class CajaLoginMediator extends Mediator {

    [Inject]
    public var vista:CajaLoginView;

    public function CajaLoginMediator() {
        super();
    }

    override public function onRegister():void
    {
        eventMap.mapListener(vista, PreguntasEvent.LOGIN, clicLogin);
        eventMap.mapListener(eventDispatcher, ControlEvent.LOADER_LOGIN, ocultaLogin);
        eventMap.mapListener(eventDispatcher, ControlEvent.FIN_LOADER_LOGIN, muestraCaja);
        eventMap.mapListener(eventDispatcher, PreguntasEvent.PREGUNTA_REGISTRADA, preguntaRegistrada);
        eventMap.mapListener(eventDispatcher, PreguntasEvent.PREGUNTA_ELEGIDA, ocultaLogin);
        eventMap.mapListener(eventDispatcher, PreguntasEvent.PIN_TWT, ocultaLogin);
        eventMap.mapListener(eventDispatcher, PreguntasEvent.TEXTO_CERRADO, volverLogin);
    }


    private function clicLogin(e:PreguntasEvent):void
    {
        var evento:PreguntasEvent = new PreguntasEvent(PreguntasEvent.LOGIN);

        if(e.datos.tipo == 'fb'){
           evento.datos.tipo = 'fb';
        } else {
           evento.datos.tipo = 'twt';
        }

        eventDispatcher.dispatchEvent(evento);
    }


    private function preguntaRegistrada(e:PreguntasEvent):void
    {
        vista.pintaRespuesta();
    }
    


    private function ocultaLogin(e:*):void
    {
        vista.ocultaLogin();
    }


    private function muestraCaja(e:ControlEvent):void
    {
        vista.pintaCaja(e.datos);
    }


    private function volverLogin(e:PreguntasEvent):void
    {
        vista.apareceLogin();
    }


}
}
