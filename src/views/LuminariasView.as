/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 22/04/12
 * Time: 22:17
 * To change this template use File | Settings | File Templates.
 */
package views {
import com.greensock.TweenLite;
import com.greensock.TweenLite;
import com.greensock.easing.Circ;
import com.hexagonstar.util.debug.Debug;

import events.PreguntasEvent;

import flash.display.MovieClip;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.system.Security;

public class LuminariasView extends MovieClip {

    private var contenedor:Sprite;
    private var luminaria:Luminaria;
    private var mascara:MascaraLuminarias;
    private var lumis:Object;
    private var _this:LuminariasView;
    private var screen_anterior:Number = 0;

    public var lumi_seleccion:Luminaria;


    public function LuminariasView() {

        Security.loadPolicyFile('https://api.facebook.com/crossdomain.xml');
        Security.loadPolicyFile('https://profile.ak.fbcdn.net/crossdomain.xml');
        Security.allowDomain('http://profile.ak.fbcdn.net');
        Security.allowInsecureDomain('http://profile.ak.fbcdn.net');
        Security.loadPolicyFile('http://s.ytimg.com/crossdomain.xml');

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

        contenedor = new MovieClip();
        contenedor.name = 'contenedor';
        contenedor.cacheAsBitmap = true;
        contenedor.addEventListener(Event.ADDED_TO_STAGE, cont);
        addChild(contenedor);

        function cont(e:Event):void
        {
            contenedor.removeEventListener(Event.ADDED_TO_STAGE, cont);

            var ruta_lumi:String;
            for(var i:int = 0; i < lumis.length; i++)
            {
                ruta_lumi = lumis[i].foto;

                luminaria = new Luminaria();
                luminaria.clip.init(lumis[i], ruta_lumi);
                luminaria.clip.velo.visible = false;
                luminaria.clip.velo.alpha = 0;
                luminaria.buttonMode = true;
                luminaria.name = String(i);
                if(i > 0){
                   luminaria.x = (luminaria.width + luminaria.width/2) + (luminaria.width * i) + (Math.random() * 20);
                } else {
                    luminaria.x = luminaria.width;
                }
                luminaria.y = Math.random() * 300;
                luminaria.gotoAndStop(Math.round(Math.random() * (luminaria.totalFrames - 1)));
                luminaria.addEventListener(MouseEvent.CLICK, clicLuminaria);
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
                ajusta();
            });
            addChild(mascara);
            
            ajusta();
        }

    }


    public function apagaLumis():void
    {
        var _clip:Luminaria;
        for(var i:int = 0; i < contenedor.numChildren; i++)
        {
            if(contenedor.getChildAt(i) is Luminaria)
            {
                _clip = Luminaria(contenedor.getChildAt(i));
                _clip.clip.velo.visible = false;
                _clip.clip.velo.alpha = 0;
                _clip.buttonMode = true;
                _clip.addEventListener(MouseEvent.CLICK, clicLuminaria);
            }
        }
    }


    private function clicLuminaria(e:MouseEvent):void
    {
        var _clip:Luminaria;        
        for(var i:int = 0; i < contenedor.numChildren; i++)
        {
            if(contenedor.getChildAt(i) is Luminaria)
            {
                _clip = Luminaria(contenedor.getChildAt(i));
                _clip.clip.velo.visible = false;
                _clip.clip.velo.alpha = 0;
                _clip.buttonMode = true;
                _clip.addEventListener(MouseEvent.CLICK, clicLuminaria);                
            }
        }
        
        _clip = Luminaria(e.currentTarget);
        _clip.removeEventListener(MouseEvent.CLICK, clicLuminaria);
        _clip.buttonMode = false;
        _clip.clip.velo.visible = true;
        TweenLite.to(_clip.clip.velo, 0.3, {alpha: 1});

        lumi_seleccion = _clip;
        _this.dispatchEvent(new PreguntasEvent(PreguntasEvent.PREGUNTA_ELEGIDA));

    }


    public function mueveLuminarias(movimiento:Number = 0):void
    {
        var recorrido:Number = ((contenedor.width - mascara.width) * movimiento) / 100;
        var _freno:Number = 0;
        
        for(var j:int = 0; j < contenedor.numChildren; j++){
            if(contenedor.getChildAt(j) is Luminaria){
                _freno = -7 + (Math.random() * 14);
               TweenLite.to(Luminaria(contenedor.getChildAt(j)), 0.5, {delay: Math.random() * 0.2, x:Luminaria(contenedor.getChildAt(j)).x + _freno, onCompleteParams:[Luminaria(contenedor.getChildAt(j)), _freno], onComplete:function(_item:Luminaria, _punto:Number=0){
                   TweenLite.to(_item, 0.5, {delay: Math.random() * 0.2, x: _item.x - _punto, onComplete: function(){
                       ajusta();
                   }});
               }});
            }
        }
        
        TweenLite.to(contenedor, 1.3, {x: -recorrido, ease: Circ.easeOut, onComplete:function(){
            ajusta();
        }});
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
