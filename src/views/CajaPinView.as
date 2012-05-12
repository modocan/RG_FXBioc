/**
 * Created by IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 03/05/12
 * Time: 20:28
 * To change this template use File | Settings | File Templates.
 */
package views {
import assets.rub.clases.CajaPin;

import com.hexagonstar.util.debug.Debug;

import events.InicioEvent;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class CajaPinView extends Sprite {
    
    private var _clip:Pin_mc;
    private var _this:CajaPinView;
    
    public function CajaPinView() {
        
        _this = this;
        
        _this.addEventListener(Event.ADDED_TO_STAGE, init);
        
    }


    private function init(e:Event):void
    {
        _this.removeEventListener(Event.ADDED_TO_STAGE, init);

        _clip = new Pin_mc();
        _clip.addEventListener(InicioEvent.TWTCERRARPIN, cerrar);
        _clip.enviar.addEventListener(MouseEvent.CLICK, pin);
        addChild(_clip);
    }
    
    
    private function cerrar(e:InicioEvent):void
    {
        _this.dispatchEvent(new InicioEvent(InicioEvent.TWTCERRARPIN));
    }


    private function pin(e:MouseEvent):void
    {
        Debug.trace('Te oigo');

        var evento:InicioEvent = new InicioEvent(InicioEvent.TWTPIN);
        evento.quien = _clip.texto_txt.text;
        
        _this.dispatchEvent(evento);
    }

}
}
