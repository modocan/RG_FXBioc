/**
 * Created with IntelliJ IDEA.
 * User: rubenmorato
 * Date: 22/04/12
 * Time: 19:35
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

import views.SeccionInicioView;

public class SeccionInicioMediator extends Mediator{

    [Inject]
    public var vista:SeccionInicioView;

    public function SeccionInicioMediator() {
        super();
    }

    override public function onRegister():void
    {
        eventMap.mapListener(vista, Event.ADDED_TO_STAGE, init);
       // eventMap.mapListener(vista, InicioEvent.XML, cargaXML);
        eventMap.mapListener(eventDispatcher, ControlEvent.APAGAR, apaga);
        eventMap.mapListener(eventDispatcher, InicioEvent.ABRIR, visible);
        eventMap.mapListener(eventDispatcher, InicioEvent.COGE_PIN, pintaPin);
        eventMap.mapListener(vista, InicioEvent.TWTPIN, creaPin);
    }
    
    
    private function pintaPin(e:InicioEvent):void
    {
        Debug.trace('[2]');
        vista.pintaPin(e.quien);
    }


    private function creaPin(e:InicioEvent):void
    {
        eventDispatcher.dispatchEvent(new InicioEvent(InicioEvent.TWTPIN));
    }


    private function cargaXML(e:InicioEvent):void
    {
         /*var evento:InicioEvent = new InicioEvent(InicioEvent.XML);
        evento.contador = vista.contador_xml;
        eventDispatcher.dispatchEvent(evento);*/
    }

    private function init(e:Event):void
    {
        var evento:ControlEvent = new ControlEvent(ControlEvent.SECCION);
        evento.quien = vista.name;
        eventDispatcher.dispatchEvent(evento);
    }

    private function visible(e:InicioEvent){
        Debug.trace('mediator', Debug.LEVEL_ERROR);
        contextView.addChild(vista);
        var evento:ControlEvent = new ControlEvent(ControlEvent.SECCION);
        evento.quien = vista.name;
        eventDispatcher.dispatchEvent(evento);

        vista.reinicio();
    }

    private function apaga(e:ControlEvent):void
    {
        if(e.quien != vista.name)
        {   var tim:Timer = new Timer(800, 1);
            tim.addEventListener(TimerEvent.TIMER_COMPLETE, borra);

        }
    }

    private function borra(e:TimerEvent):void
    {
       // contextView.removeChild(contextView.getChildByName(vista.name));
        vista.visible = false;
    }
}
}
