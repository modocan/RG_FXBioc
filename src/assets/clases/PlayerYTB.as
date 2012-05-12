/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 25/04/12
 * Time: 00:26
 * To change this template use File | Settings | File Templates.
 */
package assets.clases {
import assets.clases.eventos.PlayerYTBEvent;

import com.greensock.TweenLite;

import com.hexagonstar.util.debug.Debug;

import com.hexagonstar.util.debug.Debug;

import flash.display.DisplayObject;
import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import flash.net.URLRequest;
import flash.system.Security;

public class PlayerYTB extends Sprite {

    private var _this:PlayerYTB;
    private var barra:Sprite;
    private var btn_play:Sprite;
    private var btn_pause:Sprite;
    private var ruta:String;
    private var tirador:MovieClip;
    private var fondo:MovieClip;
    private var flujo:MovieClip;
    private var reproductor:Sprite;
    private var fondo_video:Sprite;
    public var player:Object;
    private var loader:Loader;
    private var confPlayer:Object = new Object();


    public function PlayerYTB() {
        super();
        _this = this;

        Security.loadPolicyFile("http://i.ytimg.com/crossdomain.xml");
        Security.loadPolicyFile("http://i1.ytimg.com/crossdomain.xml");
        Security.loadPolicyFile("http://i2.ytimg.com/crossdomain.xml");
        Security.loadPolicyFile("http://i3.ytimg.com/crossdomain.xml");
        Security.loadPolicyFile("http://i4.ytimg.com/crossdomain.xml");
        Security.loadPolicyFile("http://s.ytimg.com/crossdomain.xml");
        Security.loadPolicyFile("http://www.youtube.com/crossdomain.xml");
    }

    public function init(_ruta:String, _barra:MovieClip, _play:DisplayObject, _pause:DisplayObject, playerX:Number=0, playerY:Number=0, anchoVideo:Number=0, altoVideo:Number = 0, encima:Boolean = true):void
    {
        ruta = _ruta;
        barra = new Sprite()
        barra.name = 'barra';
        tirador = MovieClip(_barra.getChildByName('tirador'));
        fondo = MovieClip(_barra.getChildByName('fondo'));
        flujo = MovieClip(_barra.getChildByName('flujo'));
        flujo.width = 0;
        barra.addChild(_barra);

        btn_play = new Sprite();
        btn_play.name = 'play';
        btn_play.addChild(_play);

        btn_pause = new Sprite();
        btn_pause.name = 'pause';
        btn_pause.addChild(_pause);

        confPlayer.playerX = playerX;
        confPlayer.playerY = playerY;
        confPlayer.ancho = anchoVideo;
        confPlayer.alto = altoVideo;
        confPlayer.encima = encima;

        fondo_video = new Sprite();
        fondo_video.graphics.beginFill(0);
        fondo_video.graphics.drawRect(0, 0, confPlayer.ancho, confPlayer.alto);
        fondo_video.graphics.endFill();
        fondo_video.addEventListener(Event.ADDED_TO_STAGE, inicio);
        addChild(fondo_video);

        function inicio(e:Event):void
        {
            fondo_video.removeEventListener(Event.ADDED_TO_STAGE, inicio);
           // _this.dispatchEvent(new PlayerYTBEvent(PlayerYTBEvent.INIT));

            _this.dispatchEvent(new PlayerYTBEvent(PlayerYTBEvent.INIT));

            loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.INIT, onLoaderInit);
            loader.load(new URLRequest("http://www.youtube.com/apiplayer?version=3"));
        }

        function onLoaderInit(event:Event):void {
            addChild(loader);
            loader.content.addEventListener("onReady", onPlayerReady);
            loader.content.addEventListener("onError", onPlayerError);
            loader.content.addEventListener("onStateChange", onPlayerStateChange);
            loader.content.addEventListener("onPlaybackQualityChange", onVideoPlaybackQualityChange);
        }

    }


    private function onPlayerReady(event:Event):void {
        // Event.data contains the event parameter, which is the Player API ID
        trace("player ready:", Object(event).data);

        // Once this event has been dispatched by the player, we can use
        // cueVideoById, loadVideoById, cueVideoByUrl and loadVideoByUrl
        // to load a particular YouTube video.
        player = loader.content;
        
        player.loadVideoById(ruta, 0, 'hd720');
        player.setSize(confPlayer.ancho, confPlayer.alto);
        player.playVideo();
        
        player.addEventListener(MouseEvent.MOUSE_MOVE, mueveRaton);
        
        reproductor = new Sprite();
        reproductor.name = 'reproductor';

        reproductor.y = 20;
        reproductor.addEventListener(Event.ADDED_TO_STAGE, configuraReproductor);
        _this.addChild(reproductor);

        _this.addEventListener(Event.ENTER_FRAME, controla);
        


        //_this.dispatchEvent(new PlayerYTBEvent(PlayerYTBEvent.INIT));
        
        tirador.addEventListener(MouseEvent.MOUSE_DOWN, cogeTirador);        
        
    }

    private function onPlayerError(event:Event):void {
        // Event.data contains the event parameter, which is the error code
        trace("player error:", Object(event).data);
    }

    private function onPlayerStateChange(event:Event):void {
        // Event.data contains the event parameter, which is the new player state
        //Debug.trace(Object(event).data);
    }

    private function onVideoPlaybackQualityChange(event:Event):void {
        // Event.data contains the event parameter, which is the new video quality
        trace("video quality:", Object(event).data);
    }



    private function mueveRaton(e:MouseEvent):void
    {
        _this.dispatchEvent(new PlayerYTBEvent(PlayerYTBEvent.MUEVE));
    }


    private function configuraReproductor(e:Event):void
    {
        reproductor.removeEventListener(Event.ADDED_TO_STAGE, configuraReproductor);

        btn_play.buttonMode = true;
        btn_play.visible = false;
        btn_play.alpha = 0;
        btn_play.addEventListener(MouseEvent.CLICK, clicControl);
        reproductor.addChild(btn_play);

        btn_pause.buttonMode = true;
        btn_pause.addEventListener(MouseEvent.CLICK, clicControl);
        btn_pause.addEventListener(Event.ADDED_TO_STAGE, _inst);
        reproductor.addChild(btn_pause);
        
        function _inst(e:Event):void
        {
            e.currentTarget.removeEventListener(Event.ADDED_TO_STAGE, _inst);
            
            barra.x = e.currentTarget.x + e.currentTarget.width + 15;
            barra.y = e.currentTarget.height/2;
            tirador.buttonMode = true;
            barra.addEventListener(Event.ADDED_TO_STAGE, ins_barra);
            reproductor.addChild(barra);

        }

        function ins_barra(e:Event):void
        {
            reproductor.x = (player.width / 2) - (reproductor.width/2);
            reproductor.y = 20;
            _this.dispatchEvent(new PlayerYTBEvent(PlayerYTBEvent.LISTO));
           // _this.dispatchEvent(new PlayerYTBEvent(PlayerYTBEvent.INIT));
        }

    }
    
    
    private function cogeTirador(e:MouseEvent):void
    {
        _this.removeEventListener(Event.ENTER_FRAME, controla);
        tirador.startDrag(false, new Rectangle(0, 0, fondo.width, 0));
        _this.stage.addEventListener(MouseEvent.MOUSE_MOVE, mueveTirador);
        _this.stage.addEventListener(MouseEvent.MOUSE_UP, sueltaTirador);
    }

    private function mueveTirador(e:MouseEvent):void
    {
        var porc:Number = (tirador.x * 100) / fondo.width;
        player.seekTo((player.getDuration() * porc) / 100);
        flujo.width = tirador.x;
    }

    private function sueltaTirador(e:MouseEvent):void
    {
        _this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mueveTirador);
        tirador.stopDrag();
        _this.stage.removeEventListener(MouseEvent.MOUSE_UP, sueltaTirador);

        _this.addEventListener(Event.ENTER_FRAME, controla);
    }

    private function controla(e:Event):void
    {
        /*if(flujo.width < fondo.width){
            var porc:Number = (player.getVideoBytesLoaded() * 100) / player.getVideoBytesTotal();
            flujo.width =  (fondo.width * porc) / 100;
        }*/
        
        if(player.getDuration() != 0)
        {
            var porcentaje_tiempo:Number = (player.getCurrentTime() * 100) / player.getDuration();
            tirador.x = (fondo.width * porcentaje_tiempo) / 100;
        } else {
            tirador.x = 0;
        }

        /*if(player.getPlayerState() == 2)
        {
           _this.dispatchEvent()
        }*/
        
        flujo.width = tirador.x;
        
        if(player.getPlayerState() == 0){
            player.seekTo(0);
            player.pauseVideo();

            TweenLite.to(btn_pause, 0.3, {alpha: 0, onComplete: function(){
                btn_pause.visible = false;
            }});

            btn_play.visible = true;
            TweenLite.to(btn_play, 0.3, {alpha: 1, delay: 0.1});
        }


    }


    private function clicControl(e:MouseEvent):void
    {
        if(e.currentTarget.name == 'play')
        {
            player.playVideo();
            
            TweenLite.to(btn_play, 0.3, {alpha: 0, onComplete: function(){
                btn_play.visible = false;
            }});
            
            btn_pause.visible = true;
            TweenLite.to(btn_pause, 0.3, {alpha: 1, delay: 0.1});
            
        }  else {
            player.pauseVideo();

            TweenLite.to(btn_pause, 0.3, {alpha: 0, onComplete: function(){
                btn_pause.visible = false;
            }});

            btn_play.visible = true;
            TweenLite.to(btn_play, 0.3, {alpha: 1, delay: 0.1});
        }
    }
    
    
    public function destruye():void
    {
        if(_this.hasEventListener(Event.ENTER_FRAME))
        {
            _this.removeEventListener(Event.ENTER_FRAME, controla);
        }

        player.stopVideo();
    }

    
    public function ajusta(_ancho, _alto):void
    {
        player.setSize(_ancho,  _alto);
        reproductor.x = (player.width / 2) - (reproductor.width/2);
        reproductor.y = 20;
    }
    
    public function ajustaMini(_ancho, _alto):void
    {
        if(_this.getChildByName('reproductor'))
        {
            player.setSize(_ancho,  _alto);
            reproductor.x = (player.width / 2) - (reproductor.width/2);
            reproductor.y = player.height + 10;
        }
        

    }

}
}
