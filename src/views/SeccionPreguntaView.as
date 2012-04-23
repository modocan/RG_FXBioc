/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 20/04/12
 * Time: 21:21
 * To change this template use File | Settings | File Templates.
 */
package views {
import com.greensock.TweenLite;
import com.greensock.TweenMax;
import com.hexagonstar.util.debug.Debug;

import events.ControlEvent;

import flash.display.Sprite;
import flash.events.Event;

public class SeccionPreguntaView extends Sprite {

    private var fondo:FondoPregunta;
    private var _this:SeccionPreguntaView;
    private var anchoActual:Number = 0;
    private var altoActual:Number = 0;
    private var login:CajaLoginView;
    private var preguntas:LuminariasView;
    private var slide:SlideView;

    public function SeccionPreguntaView(_quien:String) {
        this.name = _quien;
        _this = this;
        this.visible = false;
        _this.alpha = 0;
        this.addEventListener(Event.ADDED_TO_STAGE, init);

    }


    private function init(e:Event):void
    {
        Debug.trace('inicio');

        this.removeEventListener(Event.ADDED_TO_STAGE, init);

        fondo = new FondoPregunta();
        fondo.name = 'fondo';
        fondo.addEventListener(Event.ADDED_TO_STAGE, function(e:Event){
            _this.stage.addEventListener(Event.RESIZE, ajusta);
            anchoActual = fondo.width;
            altoActual = fondo.height;
            ajusta();
            _this.visible = true;
            TweenMax.to(_this, 0.7, {alpha: 1, onComplete:function(){
               // _this.dispatchEvent(new ControlEvent(ControlEvent.APAGAR));
            }});
        });
        addChild(fondo);

        login = new CajaLoginView();
        login.name = 'login';
        login.x = 50;
        login.y = 110;
        login.addEventListener(Event.ADDED_TO_STAGE, aded);
        addChild(login);

        slide = new SlideView();
        slide.name = 'slide';
        slide.x = (_this.stage.stageWidth/2) - (slide.width/2);
        slide.y = _this.stage.stageHeight - 60;
        addChild(slide);

        function aded(e:Event):void
        {
            login.removeEventListener(Event.ADDED_TO_STAGE, aded);

            preguntas = new LuminariasView();
            preguntas.x = login.x + login.width + 50;
            preguntas.y = login.y + 10;
            _this.addChild(preguntas);
        }
    }
    
    
    public function gestionaSlider(accion:Boolean=false):void
    {
        if(_this.getChildByName('slide'))
        {
            if(accion)
            {
                slide.visible = true;
                TweenLite.to(slide,  0.3, {alpha: 1});
            } else {
                
                TweenLite.to(slide,  0.3, {alpha: 0, onComplete:function(){
                    slide.visible = false;
                }});
            }
        }
    }



    private function ajusta(e:Event=null):void
    {
        //var porcentaje:Number = 0;

        if(_this.getChildByName('fondo')){

            var stageAspectRatio = stage.stageWidth / stage.stageHeight;
            var imageAspectRatio = FondoPregunta(_this.getChildByName('fondo')).width / FondoPregunta(_this.getChildByName('fondo')).height;

            if (stageAspectRatio >= imageAspectRatio)
            {
                FondoPregunta(_this.getChildByName('fondo')).width = stage.stageWidth;
                FondoPregunta(_this.getChildByName('fondo')).height = stage.stageWidth / imageAspectRatio;
            }
            else
            {
                FondoPregunta(_this.getChildByName('fondo')).height = stage.stageHeight;
                FondoPregunta(_this.getChildByName('fondo')).width = stage.stageHeight * imageAspectRatio;
            }

            FondoPregunta(this.getChildByName('fondo')).x = (this.stage.stageWidth/2);
            FondoPregunta(this.getChildByName('fondo')).y = this.stage.stageHeight/2;
        }

        if(_this.getChildByName('login'))
        {
            CajaLoginView(this.getChildByName('login')).x = 50;
            CajaLoginView(this.getChildByName('login')).y = 110;
        }
        
        if(_this.getChildByName('slide'))
        {
            slide.x = (_this.stage.stageWidth/2) - (slide.width/2);
            slide.y = _this.stage.stageHeight - 60;
        }

    }


}
}
