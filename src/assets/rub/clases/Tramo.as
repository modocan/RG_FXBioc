/**
 * Created with IntelliJ IDEA.
 * User: rubenmorato
 * Date: 25/04/12
 * Time: 00:32
 * To change this template use File | Settings | File Templates.
 */
package assets.rub.clases {
import com.hexagonstar.util.debug.Debug;

import events.InicioEvent;

import flash.display.MovieClip;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;

import gs.TweenMax;
import gs.easing.*;

public class Tramo extends MovieClip{

    private var _mensajes:int = 18;
    private var _mojones:int = 6;

    public var numero:int;

    // Clips de pelicula
    public var tramos_mc:MovieClip;
    public var microfono_mc:MovieClip;

    private var _this:Tramo;
    public var _mensaje:String;

    public function Tramo() {

        _this = this;
        _this.visible = false;
        _this.tramos_mc.area_mc.mouseEnabled = false;
        _this.tramos_mc.microfono_mc.alpha = 0;
        _this.tramos_mc.microfono_mc.visible = false;
        _this.tramos_mc.microfono_mc.addEventListener(InicioEvent.TWTPIN, creaPin);
      //  _this.addEventListener(InicioEvent.MOJON, eventos);

    }

    private function creaPin(e:InicioEvent):void
    {
        _this.dispatchEvent(new InicioEvent(InicioEvent.TWTPIN));
    }

    public function init(_tramo:int):void
    {
        Debug.trace('tramo a cargar: '+_tramo);
        numero = _tramo;
        if(_this.tramos_mc.microfono_mc.currentFrame > 1){
            _this.tramos_mc.microfono_mc.gotoAndPlay('salida');
        }
        _this.tramos_mc.gotoAndStop(1);
        _this.visible = true;
		 if(numero == 30){
            _this.tramos_mc.zepelin_mc.numero_txt.visible = true;
            TweenMax.to(_this.tramos_mc.zepelin_mc.numero_txt, 0.4, {alpha: 1});
            _this.tramos_mc.gotoAndPlay('zepelin');
            _this.tramos_mc.zepelin_mc.gotoAndPlay('entrada');

        } else {
             
             if(_this.tramos_mc.zepelin_mc.currentFrame > 1){
                 TweenMax.to(_this.tramos_mc.zepelin_mc.numero_txt, 0.4, {alpha: 0, onComplete:function(){ _this.tramos_mc.zepelin_mc.numero_txt.visible = true; }});
                 _this.tramos_mc.zepelin_mc.gotoAndPlay('salida');
             }

             _this.tramos_mc.microfono_mc.init();

			for(var i:int = 0; i < MovieClip(_this.tramos_mc).numChildren; i++){
			   if(MovieClip(_this.tramos_mc).getChildAt(i).name.substring(0 , 7) == 'mensaje'){
				   var _mensaje:String = String(i-8 + _mensajes * (numero-1));
				   MovieClip(MovieClip(_this.tramos_mc).getChildAt(i)).mensaje = _mensaje;
				   MovieClip(MovieClip(_this.tramos_mc).getChildAt(i)).mojon = String(i-7 + _mojones * (numero-1));
				   MovieClip(MovieClip(_this.tramos_mc).getChildAt(i)).addEventListener(InicioEvent.MOJON, eventos);
				   MovieClip(MovieClip(_this.tramos_mc).getChildAt(i)).consultaEstado(_mensaje);
				   Debug.trace('mensaje: '+String(i-8 + _mensajes * (numero-1)));
			   } else if(MovieClip(_this.tramos_mc).getChildAt(i).name.substring(0 , 5) == 'mojon'){
				   MovieClip(MovieClip(_this.tramos_mc).getChildAt(i)).km_txt.text = String(i-2 + _mojones * (numero-1));
			   }  else if(MovieClip(_this.tramos_mc).getChildAt(i).name == 'bandera_mc'){
				   MovieClip(MovieClip(_this.tramos_mc).getChildAt(i)).numero_txt.text = String(numero);
			   }
			}
			_this.tramos_mc.gotoAndPlay('entrada');
		}
    }

    public function eventos(e:InicioEvent){

        Debug.trace('ESCUCHO EVENTO: '+e.quien);
        _mensaje = String(e.datos);
        _this.tramos_mc.mojon1.km_txt.text = String(e.quien);
        _this.tramos_mc.gotoAndPlay('grabar');
        _this.tramos_mc.microfono_mc.visible = true;
        TweenMax.to(_this.tramos_mc.microfono_mc, 0.7, {alpha: 1});
    }

    private function mostrarMensaje(evt:MouseEvent){
        Debug.trace('mensaje');
    }

    public function pintaPin(_dato:String):void
    {
        Debug.trace('[4]');
        _this.tramos_mc.microfono_mc.pintaPin(_dato);
    }
}
}
