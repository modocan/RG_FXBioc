/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 21/04/12
 * Time: 15:43
 * To change this template use File | Settings | File Templates.
 */
package views {
import com.greensock.TweenLite;
import com.hexagonstar.util.debug.Debug;
import com.hexagonstar.util.debug.Debug;

import events.PreguntasEvent;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.utils.Timer;

public class CajaLoginView extends Sprite {

    private var titulo:TituloSeccionPreguntas;
    public var login:CajaLogin;
    private var _this:CajaLoginView;
    private var caja_texto:CajaTextoView;
    private var caja_respuesta:RespuestaView;

    public function CajaLoginView() {
        _this = this;
        this.addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e:Event):void
    {
        this.removeEventListener(Event.ADDED_TO_STAGE, init);

        titulo = new TituloSeccionPreguntas();
        titulo.name = 'titulo';
        titulo.addEventListener(Event.ADDED_TO_STAGE, pintaLogin);
        addChild(titulo);
    }


    private function pintaLogin(e:Event):void
    {

        var evento:PreguntasEvent;
        titulo.removeEventListener(Event.ADDED_TO_STAGE, pintaLogin);

        login = new CajaLogin();
        login.x = (titulo.width/2) - (login.width/2);
        login.y = titulo.height + 15;
        login.fb.buttonMode = login.twt.buttonMode = true;
        login.fb.addEventListener(MouseEvent.CLICK, function(e:MouseEvent){
            evento = new PreguntasEvent(PreguntasEvent.LOGIN);
            evento.datos.tipo = 'fb';
            _this.dispatchEvent(evento);
        });
        login.twt.addEventListener(MouseEvent.CLICK, function(e:MouseEvent){
            evento = new PreguntasEvent(PreguntasEvent.LOGIN);
            evento.datos.tipo = 'twt';
            _this.dispatchEvent(evento);
        });
        addChild(login);

        caja_texto = new CajaTextoView();
        caja_texto.visible = false;
        caja_texto.alpha = 0;
        caja_texto.y = titulo.y + titulo.height + 15;
        caja_texto.addEventListener(Event.ADDED_TO_STAGE, function(e:Event){
            caja_texto.x = (titulo.x + (titulo.width/2)) - (caja_texto.width/2);
        });
        addChild(caja_texto);
    }


    public function ocultaLogin():void
    {
        TweenLite.to(login,  0.4, {alpha: 0, onComplete:function(){
            login.visible = false;
        }});
    }


    public function apareceLogin():void
    {
        login.visible = true;
        TweenLite.to(login,  0.4, {alpha: 1});
    }


    public function pintaCaja(datos:Object):void
    {
        caja_texto.init(datos);
        caja_texto.visible = true;
        caja_texto.reinicia();
        TweenLite.to(caja_texto, 0.5, {alpha: 1});
    }


    public function pintaRespuesta():void
    {
        var tiempo:Timer;

        TweenLite.to(caja_texto, 0.6, {alpha: 0, onComplete:function(){

            pinta();

        }});

        function pinta():void
        {
           // _this.removeChild(caja_texto);
            caja_texto.visible = false;

            caja_respuesta = new RespuestaView();
            caja_respuesta.y =  titulo.y + titulo.height + 15;

            caja_respuesta.addEventListener(Event.ADDED_TO_STAGE, controlaRespuesta);
            _this.addChild(caja_respuesta);
        }

        function controlaRespuesta(e:Event):void
        {
            caja_respuesta.removeEventListener(Event.ADDED_TO_STAGE, controlaRespuesta);

            caja_respuesta.x =  (titulo.x + (titulo.width/2)) - (caja_respuesta.width/2);

            tiempo = new Timer(5000, 1);
            tiempo.addEventListener(TimerEvent.TIMER_COMPLETE, borraRespuesta);
            tiempo.start();
        }

        function borraRespuesta(e:TimerEvent):void
        {
            tiempo.removeEventListener(TimerEvent.TIMER_COMPLETE, borraRespuesta);

            TweenLite.to(caja_respuesta, 0.5, {alpha: 0, onComplete:function(){
                _this.removeChild(caja_respuesta);
                apareceLogin();
            }});
        }


    }


}
}
