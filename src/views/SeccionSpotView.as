/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 25/04/12
 * Time: 00:56
 * To change this template use File | Settings | File Templates.
 */
package views {
import assets.clases.PlayerYTB;
import assets.clases.eventos.PlayerYTBEvent;

import com.greensock.TweenLite;

import com.hexagonstar.util.debug.Debug;

import events.SpotEvent;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.utils.Timer;

public class SeccionSpotView extends Sprite {

    private var _this:SeccionSpotView;
    private var video:PlayerYTB;
    private var ruta:String;
    private var timer:Timer;

    public function SeccionSpotView(quien:String, ruta_video:String) {
        Debug.trace('[SECCION_SPOT]', Debug.LEVEL_ERROR);
        this.name = quien;
        _this = this;
        this.visible = false;
        _this.alpha = 0;
        ruta = ruta_video;
        this.addEventListener(Event.ADDED_TO_STAGE, init);        
    }


    private function init(e:Event):void
    {
        this.removeEventListener(Event.ADDED_TO_STAGE, init);

        _this.dispatchEvent(new PlayerYTBEvent(PlayerYTBEvent.INIT));

        video = new PlayerYTB();
        video.addEventListener(PlayerYTBEvent.INIT, inicio);
        video.addEventListener(PlayerYTBEvent.PLAY, valoraEstado);
        video.addEventListener(PlayerYTBEvent.PAUSE, valoraEstado);
        video.addEventListener(PlayerYTBEvent.MUEVE, mueveRaton);

        video.addEventListener(Event.ADDED_TO_STAGE, inst);
        _this.addChild(video);


        function inst(e:Event):void
        {
            video.removeEventListener(Event.ADDED_TO_STAGE, inst);
            video.init(ruta, new BarraSeek(), new BtnPlay(), new BtnPause(), 0, 0, _this.stage.stageWidth, _this.stage.stageHeight, true);
        }

        function inicio(e:PlayerYTBEvent):void
        {

            _this.visible = true;

            TweenLite.to(_this, 0.7, {alpha: 1});
            
            _this.stage.addEventListener(Event.RESIZE, cambia);
            
            timer = new Timer(3000);
            timer.addEventListener(TimerEvent.TIMER, tiempo);
            timer.start();


        }
    }


    private function tiempo(e:TimerEvent):void
    {
        _this.dispatchEvent(new SpotEvent(SpotEvent.ESTADO_PLAY));
        Debug.trace('[TIMER]', Debug.LEVEL_ERROR);
    }
    
    
    private function valoraEstado(e:PlayerYTBEvent):void
    {
        if(e.type == PlayerYTBEvent.PLAY)
        {
            //_this.dispatchEvent(new SpotEvent(SpotEvent.ESTADO_PLAY));
        } else {
            _this.dispatchEvent(new SpotEvent(SpotEvent.ESTADO_STOP));
        }
    }
    
    
    private function mueveRaton(e:PlayerYTBEvent):void
    {
        _this.dispatchEvent(new SpotEvent(SpotEvent.ESTADO_STOP));
        timer.stop();
        timer.reset();
        timer.start();

    }
    
    
    
    
    private function cambia(e:Event):void
    {
        video.ajusta(_this.stage.stageWidth, _this.stage.stageHeight);
    }


    public function destruye():void
    {
        timer.stop();
        timer.removeEventListener(TimerEvent.TIMER, tiempo);
        video.removeEventListener(PlayerYTBEvent.MUEVE, mueveRaton);
        video.destruye();
        _this.dispatchEvent(new SpotEvent(SpotEvent.ESTADO_STOP));
    }

}
}
