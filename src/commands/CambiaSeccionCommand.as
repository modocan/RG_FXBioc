/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 20/04/12
 * Time: 17:58
 * To change this template use File | Settings | File Templates.
 */
package commands {
import com.hexagonstar.util.debug.Debug;
import com.hexagonstar.util.debug.Debug;

import events.InicioEvent;

import events.MenuEvent;

import flash.display.Sprite;

import models.IMainModel;

import org.robotlegs.mvcs.Command;

import views.SeccionInicioView;

import views.SeccionPreguntaView;
import views.SeccionProductoView;
import views.SeccionRespondeView;
import views.SeccionSpotView;

public class CambiaSeccionCommand extends Command {

    [Inject]
    public var ev:MenuEvent;

    [Inject]
    public var modelo:IMainModel;

    public function CambiaSeccionCommand() {
        super();
    }


    override public function execute():void
    {
        Debug.trace(ev.quien);

        switch(ev.quien)
        {
            case 'HABLA CON CONTADOR':
                contextView.addChild(new SeccionPreguntaView(ev.quien));
                break;

            case 'habla':
                contextView.addChild(new SeccionPreguntaView(ev.quien, true));
                break;

            case 'WELLNESS BIOCERAMICS ®':
                contextView.addChild(new SeccionProductoView(ev.quien, modelo.dameVideoProducto(), modelo.dameEnlaceProducto()));
                break;

            case 'SPOT':
                contextView.addChild(new SeccionSpotView(ev.quien, modelo.dameVideoSpot()));
                break;

            case 'spot':
                contextView.addChild(new SeccionSpotView(ev.quien, modelo.dameVideoSpot()));
                break;

            case 'reflexiones':
                    trace('entro en reflexiones');
                contextView.addChild(new SeccionSpotView(ev.quien, modelo.dameReflexiones()));
                break;


            case 'CONTADOR RESPONDE':
                contextView.addChild(new SeccionRespondeView(ev.quien));
                break;


            case 'momentos':
                contextView.addChild(new SeccionRespondeView('RESPONDE_SUB', true));
                break;


            case 'ANTES DE LA CARRERA':
                if(contextView.getChildByName('INICIO')){
                    Debug.trace('ya estaba', Debug.LEVEL_ERROR);
                    var mi_evento:InicioEvent = new InicioEvent(InicioEvent.ABRIR);
                    mi_evento.quien = 'INICIO';
                    eventDispatcher.dispatchEvent(mi_evento);
                }  else {

                    contextView.addChild(new SeccionInicioView(ev.quien));

                }

                var evento:MenuEvent = new MenuEvent(MenuEvent.SUBMENU);
                evento.quien = 'antes';
                eventDispatcher.dispatchEvent(evento);

                break;

                case 'EL DÍA DE LA CARRERA':
                    contextView.addChild(new SeccionRespondeView('RESPONDE_SUB', true));

                    var evento:MenuEvent = new MenuEvent(MenuEvent.SUBMENU);
                    evento.quien = 'durante';
                    eventDispatcher.dispatchEvent(evento);

                break;

            case 'INICIO':

                if(contextView.getChildByName(ev.quien)){
                    Debug.trace('ya estaba', Debug.LEVEL_ERROR);
                    var mi_evento:InicioEvent = new InicioEvent(InicioEvent.ABRIR);
                    mi_evento.quien = ev.quien;
                    eventDispatcher.dispatchEvent(mi_evento);
                }  else {

                    contextView.addChild(new SeccionInicioView(ev.quien));

                }
                break;
        }
    }
}
}
