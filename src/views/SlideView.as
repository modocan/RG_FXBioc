/**
 * Created by IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 23/04/12
 * Time: 17:26
 * To change this template use File | Settings | File Templates.
 */
package views {
import assets.clases.eventos.SlideLumiEvent;

import com.greensock.TweenLite;
import com.hexagonstar.util.debug.Debug;

import events.PreguntasEvent;

import flash.display.Sprite;
import flash.events.Event;

public class SlideView extends Sprite {

    private var clip:SliderLuminarias;
    private var _this:SlideView;

    public function SlideView() {
        _this = this;
        this.alpha = 0;
        this.addEventListener(Event.ADDED_TO_STAGE, init);
    }
    
    private function init(e:Event):void
    {
        _this.removeEventListener(Event.ADDED_TO_STAGE, init);
        
        clip = new SliderLuminarias();
        clip.name = 'clip';
        clip.addEventListener(SlideLumiEvent.MOVIMIENTO, movimiento);
        clip.addEventListener(Event.ADDED_TO_STAGE, slide_add);
        addChild(clip);
    }
    
    private function slide_add(e:Event):void
    {
        clip.removeEventListener(Event.ADDED_TO_STAGE, slide_add);
        TweenLite.to(_this,  0.8, {alpha: 1});
    }
    
    private function movimiento(e:SlideLumiEvent):void
    {
        var evento:PreguntasEvent = new PreguntasEvent(PreguntasEvent.TIRADOR_MOV);
        evento.datos.movimiento = e.datos.posicion;
        _this.dispatchEvent(evento);
    }
    
    
    public function mueveInverso(movimiento:Number = 0):void
    {
        if(_this.getChildByName('clip'))
        {
            clip.mueveInverso(movimiento);
        }
    }
    
}
}
