/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 12/05/12
 * Time: 19:15
 * To change this template use File | Settings | File Templates.
 */
package mediators {
import events.PreguntasEvent;

import org.robotlegs.mvcs.Mediator;

import views.ContenedorElegidosView;

public class ContenedorElegidosMediator extends Mediator {

    [Inject]
    public var vista:ContenedorElegidosView;

    public function ContenedorElegidosMediator() {
        super();
    }


    override public function onRegister():void
    {
        eventMap.mapListener(vista, PreguntasEvent.CLIC_RESPUESTA, clic);
    }


    private function clic(e:PreguntasEvent):void
    {
        var evento:PreguntasEvent = new PreguntasEvent(PreguntasEvent.CLIC_RESPUESTA);
        evento.datos =  e.datos;
        eventDispatcher.dispatchEvent(evento);
    }

}
}
