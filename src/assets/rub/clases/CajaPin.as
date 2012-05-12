/**
 * Created by IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 03/05/12
 * Time: 12:20
 * To change this template use File | Settings | File Templates.
 */
package assets.rub.clases {

import com.demonsters.debugger.MonsterDebugger;
import com.hexagonstar.util.debug.Debug;

import events.InicioEvent;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.FocusEvent;
import flash.events.MouseEvent;
import flash.text.TextField;

import gs.TweenMax;
import gs.easing.*;

public class CajaPin extends Sprite{
    
    private var _this:CajaPin;
    public var enviar:MovieClip;
    public var cerrar:MovieClip;
    public var texto_txt:TextField;
    private var fondo:Sprite;
    
    public function CajaPin() {

        _this = this;
        _this.addEventListener(Event.ADDED_TO_STAGE, init);
        _this.visible = false;
        _this.alpha = 0;
        _this.enviar.buttonMode = true;
        _this.cerrar.buttonMode = true;
        _this.enviar.addEventListener(MouseEvent.CLICK, enviarPin);
        _this.cerrar.addEventListener(MouseEvent.CLICK, cerrarPin);
        _this.texto_txt.addEventListener(FocusEvent.FOCUS_IN, control);
        _this.texto_txt.addEventListener(FocusEvent.FOCUS_OUT, control);
        _this.texto_txt.text = 'PIN';

        MonsterDebugger.initialize(this);
    }
    
    public function init(e:Event){

        var fondo = new Sprite();
        fondo.graphics.beginFill(0, 0.25);
        fondo.graphics.drawRect(-(_this.stage.stageWidth/2), -(_this.stage.stageHeight/2), _this.stage.stageWidth, _this.stage.stageHeight);
        fondo.graphics.endFill();
        fondo.name = 'fondo';
        _this.addChildAt(fondo,  0);
        _this.stage.addEventListener(Event.RESIZE, ajusta);
        _this.visible = true;
        
        _this.x = _this.stage.stageWidth/2;
        _this.y = _this.stage.stageHeight/2;
        
        TweenMax.to(_this, 0.7, {alpha: 1});

        Debug.trace('[CAJAPIN_INIT]', Debug.LEVEL_ERROR);
    
    }

    private function enviarPin(evt:MouseEvent){
        if(texto_txt.text != '' && texto_txt.text != ' ' && texto_txt.text != 'PIN'){

            Debug.trace('[PIIIIIIN]');

            /*var evento:InicioEvent = new InicioEvent(InicioEvent.TWTPIN);
            evento.quien = texto_txt.text;
            dispatchEvent(evento);*/
            cerrarPin();
        }
    }

    private function cerrarPin(evt:MouseEvent=null){

        TweenMax.to(_this, 0.7, {alpha: 0, onComplete:function(){
            _this.visible = false;
            dispatchEvent(new InicioEvent(InicioEvent.TWTCERRARPIN));
        }});
    }
    
    private function control(e:FocusEvent):void
    {
        if(e.type == FocusEvent.FOCUS_IN)
        {
            _this.texto_txt.text = '';
        } else {
            if(_this.texto_txt.text == '' || _this.texto_txt.text == ' ')
            {
                _this.texto_txt.text = 'PIN';
            }
        }
    }
    
    
    public function ajusta(e:Event):void
    {
        if(_this.getChildByName('fondo'))
        {
            fondo.width = _this.stage.stageWidth;
            fondo.height = _this.stage.stageHeight;
            fondo.x = fondo.y = 0;

            _this.x = _this.stage.stageWidth/2;
            _this.y = _this.stage.stageHeight/2;
        }
    }
    
    
}
}
