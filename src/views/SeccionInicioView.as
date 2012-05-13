/**
 * Created with IntelliJ IDEA.
 * User: rubenmorato
 * Date: 22/04/12
 * Time: 19:33
 * To change this template use File | Settings | File Templates.
 */
package views {

import assets.rub.clases.VideoInfografia;


import com.hexagonstar.util.debug.Debug;

import events.InicioEvent;

import flash.display.Sprite;
import flash.events.Event;

import gs.TweenMax;


public class SeccionInicioView extends Sprite{

    private var _copy:copy_inicio;
    private var _infografia:video_infografia;
    private var _this:SeccionInicioView;
    private var anchoActual:Number = 0;
    private var altoActual:Number = 0;
    private var _tramo:GestorTramos;

    public function SeccionInicioView(param:String) {

        this.name = param;
        _this = this;
        this.visible = false;
        _this.alpha = 0;
        this.addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e:Event):void
    {
        this.removeEventListener(Event.ADDED_TO_STAGE, init);
         Debug.trace('CARGO INICIO');
        _tramo = new GestorTramos();
        _tramo.addEventListener(InicioEvent.TWTPIN, creaPin)  ;
        _copy = new copy_inicio();
        _infografia = new video_infografia();
        _infografia.addEventListener(InicioEvent.COPY, abrirCopy);
        _infografia.addEventListener(InicioEvent.ABRIR_TRAMO, abrirTramo);
        _infografia.name = 'infografia';
        _infografia.addEventListener(Event.ADDED_TO_STAGE, function(e:Event){
            _this.stage.addEventListener(Event.RESIZE, ajusta);
            anchoActual = _infografia.width;
            altoActual = _infografia.height;
            ajusta();
            _this.visible = true;
            TweenMax.to(_this, 0.7, {alpha: 1, onComplete:function(){
                // _this.dispatchEvent(new ControlEvent(ControlEvent.APAGAR));
            }});
        });
        _this.addChild(_infografia);
        _this.addChild(_tramo);
        _this.addChild(_copy);

    }
    
    
    private function creaPin(e:InicioEvent):void
    {
        _this.dispatchEvent(new InicioEvent(InicioEvent.TWTPIN));
    }
    

    public function reinicio(){
        _this.alpha = 0;
        _this.visible = true;
        TweenMax.to(_this, 0.7, {alpha: 1});
    }

    public function abrirTramo(e:InicioEvent){
        
        if(e.quien == '30'){
            _tramo.tramos_mc.zepelin_mc.numero_txt.text = String(e.numero);
            _copy.ocultar();
            _copy.texto = 'MANDA TU APOYO PARA QUE CONTADOR COMIENCE LA CARRERA CON LA FUERZA DE TODOS';
        }  else {
			_copy.salir();
        }
        Debug.trace('cargo: '+String(e.quien));
        _tramo.init(int(e.quien));
    }

    public function abrirCopy(e:InicioEvent){
        Debug.trace('copy: '+e.quien);
        switch(e.quien){
            case 'ini':
                _copy.mostrar();
                _copy.texto = 'SELECCIONA EL PUNTO EXACTO DE LA ETAPA DONDE QUIERES DAR ÁNIMOS A ALBERTO CONTADOR';
               break;
            case 'tramos':
                _copy.ocultar();
                _copy.texto = 'SELECCIONA EL PUNTO EXACTO DE LA ETAPA DONDE QUIERES DAR ÁNIMOS A ALBERTO CONTADOR';
                break;
        }
    }


    public function pintaPin(_dato:String):void
    {
        Debug.trace('[3]');
        _tramo.pintaPin(_dato);
    }


    private function ajusta(e:Event=null):void
    {

        if(_this.getChildByName('infografia')){

            var stageAspectRatio = stage.stageWidth / stage.stageHeight;
            var imageAspectRatio = VideoInfografia(_this.getChildByName('infografia')).width / VideoInfografia(_this.getChildByName('infografia')).height;

            if (stageAspectRatio >= imageAspectRatio)
            {
                VideoInfografia(_this.getChildByName('infografia')).width = stage.stageWidth;
                VideoInfografia(_this.getChildByName('infografia')).height = stage.stageWidth / imageAspectRatio;
            }
            else
            {
                VideoInfografia(_this.getChildByName('infografia')).height = stage.stageHeight;
                VideoInfografia(_this.getChildByName('infografia')).width = stage.stageHeight * imageAspectRatio;
            }

            VideoInfografia(this.getChildByName('infografia')).x = (this.stage.stageWidth/2);
            VideoInfografia(this.getChildByName('infografia')).y = this.stage.stageHeight/2;
        }

        _tramo.x = this.stage.stageWidth/2;
        _tramo.y = this.stage.stageHeight - 80;

    }


}
}
