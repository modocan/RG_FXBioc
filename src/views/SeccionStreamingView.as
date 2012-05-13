/**
 * Created with IntelliJ IDEA.
 * User: rubenmorato
 * Date: 12/05/12
 * Time: 13:55
 * To change this template use File | Settings | File Templates.
 */
package views {


import com.hexagonstar.util.debug.Debug;

import events.StreamingEvent;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.AsyncErrorEvent;
import flash.events.Event;
import flash.events.NetStatusEvent;
import flash.events.SecurityErrorEvent;
import flash.media.Video;
import flash.net.NetConnection;
import flash.net.NetStream;
import flash.system.Security;
import flash.net.Responder;

import com.greensock.TweenLite;
import com.greensock.TweenMax;

import flash.text.engine.Kerning;


public class SeccionStreamingView extends Sprite{


        // AMFPHP
        private const GATEWAY:String = 'http://www.flex.es/tourflex/amfphp/gateway.php';
        private var _cn:NetConnection;

        private var _this:SeccionStreamingView;

        // VIDEO - RED5
        private var _video:Video;
        private var _conexion:NetConnection;
        private var _stream:NetStream;
        private var _videoURL:String = "rtmp://77.73.82.193/oflaDemo";
        private var _list_videos:Array = new Array('video_1.flv','video_2.flv','video_3.flv','video_4.flv','video_5.flv','video_6.flv','video_7.flv');

        // Vistas
        private var _loading:LoadingView;
        private var _km:KmView;
        private var _recorrido:RecorridoView;
        private var _reflexiones:ReflexionesView;
        private var _crono:CronoView;
        /////////

        private var _ancho:Number = 1000;
        private var _alto:Number = 564;

        // POS VIDEO
        private const TIME_TOTAL:int = 25200;   // TIEMPO TOTAL EN SEGUNDOS DE TODOS LOS VIDEOS
        private var _time_total:int;
        private var _seek:int;
        private var _seg:int = 3600;
        private var _total:int;
        private var _video_actual:int;

        // CRONO
        private var _dia:String;
        private var _hora:String;
        private var _minuto:String;

        public function SeccionStreamingView(param:String) {

            Security.allowDomain('http://profile.ak.fbcdn.net');

            this.name = param;
            _this = this;
            _this.visible = false;
            _this.alpha = 0;
            _this.addEventListener(Event.ADDED_TO_STAGE, init);
        }

        private function init(e:Event):void
        {
            _this.removeEventListener(Event.ADDED_TO_STAGE, init);
            _this.stage.addEventListener(Event.RESIZE, ajusta);
            cargarVideo();
        }

        private function cargarVideo(){

            _cn = new NetConnection();
            _cn.connect(GATEWAY);
            _cn.call('ContactService.dameTiempo', new Responder(respuesta));
        }

        private function respuesta(datos:Object):void
        {
            Debug.inspect(datos);
            if(!(datos is Number)){
                Debug.trace('QUEDA POR LLEGAR');
                var _res:Array;
                _res = datos.date.split(' ');
                var _fecha:Array;
                _fecha = _res[0].split('-');
                var _hora:Array;
                _hora = _res[1].split(':');
                _crono = new CronoView();
                _crono.addEventListener(StreamingEvent.INIT_VIDEO,initVideo);
                _crono.startCrono(_fecha[0],_fecha[2],_fecha[1],_hora[0],_hora[1]);
                addChild(_crono);
                _this.visible = true;
                TweenMax.to(_this, 1, {alpha: 1});
            } else {
                // Defino el vídeo a cargar
                _video_actual = Math.floor(int(datos)/_seg);
                _seek = int(datos) - (_video_actual * _seg);
                Debug.trace('video actual: '+_video_actual);
                Debug.trace('videos: '+_list_videos.length);
                if(_video_actual > _list_videos.length){
                    // RETRANSMISION ACABADA
                    finalVideo();
                    _this.visible = true;
                    TweenMax.to(_this, 1, {alpha: 1});
                } else {
                   initVideo();
                }

            }
        }

        private function finalVideo(){
            _reflexiones = new ReflexionesView();
            addChild(_reflexiones);
        }

        public function reinicio(){
            trace('[REINICIA PUTAAAAAA]');
            _this.alpha = 0;
            _this.visible = true;
            TweenMax.to(_this, 0.7, {alpha: 1});
        }

        private function initVideo(e:StreamingEvent = null){

            _conexion = new NetConnection();
            _conexion.addEventListener(NetStatusEvent.NET_STATUS,estadoConexion);
            _conexion.addEventListener(SecurityErrorEvent.SECURITY_ERROR,errorConexion);
            _conexion.connect(_videoURL,true);

            var client :Object = new Object();
            //client.onBWCheck = onBWCheck;
            client.onBWDone = onBWDone;

            _conexion.client = client;
            _conexion.call("checkBandwidth", null);
        }

        private function onBWDone(kbitDown:String = null, deltaDown:String = null, deltaTime:String = null, latency:String = null):void
        {
            if (kbitDown!=null)
            {

            }
        }

        private function estadoConexion(event:NetStatusEvent):void
        {
             trace("netStatusHandler",event.info.code);
             switch (event.info.code)
             {
                 case "NetConnection.Connect.Success" :
                     conectarStream();
                     break;
                 case "NetStream.Play.StreamNotFound" :
                     trace(("Stream not found: " + _videoURL));
                     break;
                 case "NetStream.Play.Start" :
                     _loading.ocultar();
                     break;
                 case "NetStream.Play.Stop" :
                     _loading.mostrar();
                     break;
             }
        }

        private function errorConexion(event:SecurityErrorEvent):void
        {
            trace(("securityErrorHandler: " + event));
        }

        private function conectarStream():void
        {
            _stream = new NetStream(_conexion);
            _stream.addEventListener(NetStatusEvent.NET_STATUS,estadoConexion);
            _stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR,errorConexion);
            _stream.client = _this;

            _video = new Video();
            _video.width = _ancho;
            _video.height = _alto;
            _video.attachNetStream(_stream);
            Debug.trace('REPRO - VIDEO: '+_video_actual);
            _stream.play(_list_videos[_video_actual]);
            _stream.seek(_seek);

            //Añado vistas a la escena
            addChild(_video);
            _recorrido = new RecorridoView();
            addChild(_recorrido);
            _km = new KmView();
            _this.addChild(_km);
            _loading = new LoadingView();
            addChild(_loading);
            _recorrido.total = TIME_TOTAL;
            _km.total = TIME_TOTAL;
            _this.visible = true;
            TweenMax.to(_this, 1, {alpha: 1});

            this.addEventListener(Event.ENTER_FRAME, actualizar);
            ajusta();
        }

        // Función encargada de cambiar de video
        public function onPlayStatus(info:Object):void {
            Debug.trace('FIN DEL VIDEO');
            _video_actual += 1;
            if(_video_actual > _list_videos.length){
                // RETRANSMISION ACABADA
                Debug.trace('CERRAMOS VIDEO');
                this.removeEventListener(Event.ENTER_FRAME, actualizar);
                finalVideo();
            } else {
                Debug.trace('muestro Login');
                _seek = 0;
                _stream.play(_list_videos[_video_actual]);
            }
        }

        public function onMetaData(info:Object):void
        {
            // _recorrido.total = info.duration;
            // _km.total = info.duration;
            trace(((((((("metadata: duration=" + info.duration) + " width=") + info.width) + " height=") + info.height) + " framerate=") + info.framerate));
        }
        public function onCuePoint(info:Object):void
        {
            trace(((((("cuepoint: time=" + info.time) + " name=") + info.name) + " type=") + info.type));
        }

        public function onXMPData(infoObject:Object):void
        {

        }

        private function actualizar(e:Event){

            var _tiempo:int = int(_stream.time + (_seg * (_video_actual)));
            if(_tiempo == TIME_TOTAL){
                this.removeEventListener(Event.ENTER_FRAME, actualizar);
                finalVideo();
            } else {
                _recorrido.actualizarPos(_tiempo);
                _km.actualizar(_tiempo);
            }

        }

        private function ajusta(e:Event = null)
        {

            var stageAspectRatio = stage.stageWidth / stage.stageHeight;

            var imageAspectRatio = _ancho / _alto;

            if (stageAspectRatio >= imageAspectRatio)
            {
                _video.width = stage.stageWidth;
                _video.height = stage.stageWidth / imageAspectRatio;
            }
            else
            {
                _video.height = stage.stageHeight;
                _video.width = stage.stageHeight * imageAspectRatio;
            }

        }

    }

}
