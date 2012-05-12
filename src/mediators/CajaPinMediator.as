/**
 * Created by IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 03/05/12
 * Time: 20:10
 * To change this template use File | Settings | File Templates.
 */
package mediators {
import assets.rub.clases.CajaPin;

import com.hexagonstar.util.debug.Debug;

import events.InicioEvent;

import org.robotlegs.mvcs.Mediator;

import views.CajaPinView;

public class CajaPinMediator extends Mediator {

    [Inject]
    public var vista:CajaPinView;

    public function CajaPinMediator() {
    }

    override public function onRegister():void
    {
         eventMap.mapListener(vista, InicioEvent.TWTCERRARPIN, cerrar);
        eventMap.mapListener(vista, InicioEvent.TWTPIN, pin);
    }


    private function cerrar(e:InicioEvent):void
    {
        contextView.removeChild(vista);
    }

    private function pin(e:InicioEvent):void
    {
        Debug.trace('[1]');

        var evento:InicioEvent = new InicioEvent(InicioEvent.COGE_PIN);
        evento.quien = e.quien;
        eventDispatcher.dispatchEvent(evento);
    }
}
}
