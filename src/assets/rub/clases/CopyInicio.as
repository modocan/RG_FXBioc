/**
 * Created with IntelliJ IDEA.
 * User: rubenmorato
 * Date: 26/04/12
 * Time: 00:33
 * To change this template use File | Settings | File Templates.
 */
package assets.rub.clases {
import com.hexagonstar.util.debug.Debug;

import events.InicioEvent;

import flash.display.MovieClip;
import flash.events.Event;
import flash.text.TextField;

import gs.TweenMax;

public class CopyInicio extends MovieClip{

    public var _texto:String;
    public var texto_txt:TextField;
    public var flecha_izq:MovieClip;
    public var flecha_der:MovieClip;
    public var _this:CopyInicio;

    public function CopyInicio() {

        this.addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e:Event):void
    {
        _this = this;
        _this.removeEventListener(Event.ADDED_TO_STAGE, init);
        _this.mouseChildren = false;
        _this.mouseEnabled = false;


        // CONNFIG
        _this.visible = false;
        _this.flecha_der.alpha = 0;
        _this.texto_txt.alpha = 0;
        _this.flecha_izq.visible = false;
        _this.flecha_der.visible = false;
        _this.texto_txt.visible = false;
        ajustar();
        stage.addEventListener(Event.RESIZE, ajustar);
    }

    public function set texto(_valor:String){
        Debug.trace('SET TEXTO');
        _this.texto_txt.text = _valor.toUpperCase();
        _this.visible = true;
        TweenMax.to(this, 0.7, {alpha: 1});
    }

    public function mostrar(){
        Debug.trace('mostramos');
        _this.texto_txt.visible = true;
        _this.flecha_izq.visible = true;
        _this.flecha_der.visible = true;
        TweenMax.to( _this.flecha_izq, 0.7, {alpha: 1});
        TweenMax.to( _this.flecha_der, 0.7, {alpha: 1});
        TweenMax.to( _this.texto_txt, 0.7, {alpha: 1});
        Debug.trace('mostrado');
    }

    public function ocultar(){
        TweenMax.to( _this.flecha_izq, 0.7, {alpha: 0, onComplete:function(){_this.flecha_izq.visible = false;}});
        TweenMax.to( _this.flecha_der, 0.7, {alpha: 0, onComplete:function(){_this.flecha_der.visible = false;}});
    }

    public function salir(){
        TweenMax.to( _this, 0.7, {alpha: 0, onComplete:function(){_this.visible = false;}});
    }

    private function ajustar(e:Event=null):void
    {
        Debug.trace('ajustar');
        _this.x = _this.stage.stageWidth/2;
        _this.y = _this.stage.stageHeight - 55;
    }


}
}
