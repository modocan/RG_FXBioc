/**
 * Created by IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 23/04/12
 * Time: 18:00
 * To change this template use File | Settings | File Templates.
 */
package mediators {
import com.hexagonstar.util.debug.Debug;

import events.PreguntasEvent;

import org.robotlegs.mvcs.Mediator;

import views.SlideView;

public class SlideMediator extends Mediator {

    [Inject]
    public var vista:SlideView;

    public function SlideMediator() {
        super();
    }

    override public function onRegister():void
    {
        eventMap.mapListener(vista, PreguntasEvent.TIRADOR_MOV, mueve);
        eventMap.mapListener(eventDispatcher, PreguntasEvent.TIRADOR_INVERSO, movimiento);
    }
    
    
    private function mueve(e:PreguntasEvent):void
    {
        var evento:PreguntasEvent = new PreguntasEvent(PreguntasEvent.TIRADOR_MOV);
        evento.datos.movimiento = e.datos.movimiento;
        eventDispatcher.dispatchEvent(evento);
    }
    
    private function movimiento(e:PreguntasEvent):void
    {
        vista.mueveInverso(e.datos.movimiento);
    }

}
}
