/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 22/04/12
 * Time: 22:17
 * To change this template use File | Settings | File Templates.
 */
package views {
import com.greensock.TweenLite;
import com.greensock.easing.Circ;
import com.hexagonstar.util.debug.Debug;

import events.PreguntasEvent;

import flash.display.MovieClip;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class LuminariasView extends Sprite {

    private var contenedor:Sprite;
    private var luminaria:Luminaria;
    private var mascara:MascaraLuminarias;
    private var lumis:Object;
    private var _this:LuminariasView;
    private var screen_anterior:Number = 0;

    public var lumi_seleccion:Luminaria;


    public function LuminariasView() {

        _this = this;
        this.addEventListener(Event.ADDED_TO_STAGE, init);
    }
    
    private function init(e:Event):void
    {
        _this.removeEventListener(Event.ADDED_TO_STAGE, init);
        _this.stage.addEventListener(Event.RESIZE, ajusta);        
    }


    public function pintaLuminarias(_lumis:Object):void
    {
        lumis = new Object();
        lumis = _lumis;

        Debug.trace('[Ancho Escenario] -> ' + this.stage.stageWidth, Debug.LEVEL_ERROR);
        Debug.trace('[Mi posicion] -> ' + this.x, Debug.LEVEL_ERROR);

        contenedor = new MovieClip();
        contenedor.name = 'contenedor';
        contenedor.cacheAsBitmap = true;
        contenedor.addEventListener(Event.ADDED_TO_STAGE, cont);
        addChild(contenedor);

        function cont(e:Event):void
        {
            contenedor.removeEventListener(Event.ADDED_TO_STAGE, cont);

            Debug.inspect(lumis);

            var ruta_lumi:String;
            for(var i:int = 0; i < lumis.length; i++)
            {
                ruta_lumi = lumis[i].foto;

                luminaria = new Luminaria();
                luminaria.clip.init(lumis[i], ruta_lumi);
                luminaria.name = String(i);
                if(i > 0){
                   luminaria.x = (luminaria.width + luminaria.width/2) + (luminaria.width * i) + (Math.random() * 20);
                } else {
                    luminaria.x = luminaria.width;
                }
                luminaria.y = Math.random() * 300;
                Debug.trace('[FRAMES] -> ' + luminaria.totalFrames);
                //luminaria.gotoAndStop(Math.round(Math.random() * (luminaria.totalFrames - 1)));
                luminaria.addEventListener(MouseEvent.CLICK, clicLuminaria);
                luminaria.addEventListener(Event.ADDED_TO_STAGE, function(e:Event){
                    //Luminaria(e.currentTarget).play();
                });
                ajusta();
                contenedor.addChild(luminaria);
            }

            mascara = new MascaraLuminarias();
            mascara.name = 'mascara';
            mascara.cacheAsBitmap = true;
            mascara.y = -(luminaria.height/2);
            mascara.width =  _this.stage.stageWidth - (_this.x + 40);
            mascara.height = 300 + luminaria.height;
            mascara.addEventListener(Event.ADDED_TO_STAGE, function(e:Event){
                contenedor.mask = mascara;
            });
            addChild(mascara);
        }

    }


    private function clicLuminaria(e:MouseEvent):void
    {
        lumi_seleccion = Luminaria(e.currentTarget);
        //lumi_seleccion.stop();
        lumi_seleccion.alpha = 0.2;

        _this.dispatchEvent(new PreguntasEvent(PreguntasEvent.PREGUNTA_ELEGIDA));

    }


    public function mueveLuminarias(movimiento:Number = 0):void
    {
        var recorrido:Number = ((contenedor.width - mascara.width) * movimiento) / 100;
        TweenLite.to(contenedor, 0.7, {x: -recorrido, ease: Circ.easeOut});
    }
    
    
    
    private function ajusta(e:Event=null):void
    {
        if(_this.getChildByName('mascara'))
        {
            mascara.width =  _this.stage.stageWidth - (_this.x + 40);

            if(mascara.width >= contenedor.width)
            {
                _this.dispatchEvent(new PreguntasEvent(PreguntasEvent.TIRADOR_OCULTO)) ;
            } else {
                _this.dispatchEvent(new PreguntasEvent(PreguntasEvent.TIRADOR_VISIBLE)) ;
            }
        }
        
        if(_this.getChildByName('contenedor') && _this.getChildByName('contenedor').x < 0)
        {
            if(_this.stage.stageWidth > screen_anterior)
            {
                contenedor.x += _this.stage.stageWidth - screen_anterior;
                var porcentaje_nuevo:Number = (((contenedor.width - mascara.width) - Math.abs(contenedor.x)) * 100) / (contenedor.width - mascara.width);
                var evento:PreguntasEvent = new PreguntasEvent(PreguntasEvent.TIRADOR_INVERSO);
                evento.datos.movimiento = porcentaje_nuevo;
                _this.dispatchEvent(evento);
            }
        }

        screen_anterior = _this.stage.stageWidth;
    }


}
}
