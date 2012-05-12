/**
 * Created with IntelliJ IDEA.
 * User: rubenmorato
 * Date: 22/04/12
 * Time: 19:44
 * To change this template use File | Settings | File Templates.
 */
package assets.rub.clases {
import com.hexagonstar.util.debug.Debug;
import com.zehfernando.display.drawPlane;

import events.InicioEvent;

import flash.display.BitmapData;
import flash.display.BlendMode;
import flash.display.Graphics;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.IEventDispatcher;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundMixer;
import flash.net.URLLoader;
import flash.net.URLRequest;

public class VideoInfografia extends MovieClip {

    public var btn_izquierda:MovieClip;
    public var btn_derecha:MovieClip;
    public var videos_mc:MovieClip;
    private var _this:VideoInfografia;

    private var _ini:Boolean;
    protected var frame : int;

    private var _texto:String;

    private var _seleccion:String = 'btn_izquierda';
    private var _track:BotonTRack;
	private var _zepeling:ZepelingTrack;


    //  BANDERAS
    private var _banderas:int = 31;


    public function VideoInfografia() {

        super();
        this.addEventListener(Event.ADDED_TO_STAGE, init);
        _this = this;
    }

    private function init(e:Event):void {

        this.removeEventListener(Event.ADDED_TO_STAGE, init);

        //CONFIGURO
        btn_izquierda.visible = false;
        btn_derecha.visible = false;
        btn_derecha.mouseEnabled = false;
        btn_derecha.alpha = 0.5;

        btn_izquierda.addEventListener(MouseEvent.MOUSE_OVER, sobre);
        btn_derecha.addEventListener(MouseEvent.MOUSE_OVER, sobre);
        btn_izquierda.addEventListener(MouseEvent.MOUSE_OUT, parar);
        btn_derecha.addEventListener(MouseEvent.MOUSE_OUT, parar);

        addContainers();
        addEventListener(Event.EXIT_FRAME, exitFrameHandler);
    }

    private function mover(e:Event = null)
    {

        if(videos_mc.currentFrame == 600){
            btn_izquierda.alpha = 0.5;
            parar();
        } else if (videos_mc.currentFrame == 301 || videos_mc.currentFrame == videos_mc.totalFrames-1){
            btn_derecha.alpha = 0.5;
            parar();
        }

        if(videos_mc.currentFrame > 301 && videos_mc.currentFrame < videos_mc.totalFrames-1){
            btn_derecha.alpha = 1;
        }

        if(videos_mc.currentFrame > 600){
            btn_izquierda.alpha = 1;
        }
    }

    private function parar(e:MouseEvent = null)
    {
        if(e != null){
            e.currentTarget.gotoAndPlay('salida');
        }
        removeEventListener(Event.ENTER_FRAME,mover);
        videos_mc.stop();
    }

    private function sobre(e:MouseEvent)
    {
       if(e.currentTarget.alpha == 1){
           addEventListener(Event.ENTER_FRAME,mover);
           e.currentTarget.gotoAndPlay('entrada');
           if(_seleccion == e.currentTarget.name){
               videos_mc.play();
           } else {
               videos_mc.gotoAndPlay((videos_mc.totalFrames +300) - videos_mc.currentFrame);
           }
            _seleccion = e.currentTarget.name;
       } else {
           parar();
       }
    }


    protected function addContainers() : void {

        for(var i:int = 1; i<_banderas; i++){
			 if(i == 30){
                videos_mc['track'+i] = new ZepelingTrack();
            } else {
                videos_mc['track'+i] = new BotonTRack();
            }
            videos_mc['track'+i].x = videos_mc.width/2;
            videos_mc['track'+i].y = videos_mc.height/2;
            videos_mc['track'+i].name = String(i);
            videos_mc['track'+i].init('track'+i);
            videos_mc['track'+i].addEventListener(InicioEvent.ABRIR_TRAMO, abrirTramo);
            videos_mc.addChild(videos_mc['track'+i]);
        }

    }

    private function mostrarBotones(){

        for(var i:int = 1; i<_banderas; i++){
            videos_mc['track'+i].mostrar();
        }
    }

    private function abrirTramo(e:InicioEvent){
        Debug.trace('tramo: '+e.quien);
        var evento:InicioEvent = new InicioEvent(InicioEvent.ABRIR_TRAMO);
        evento.quien = e.quien;
        evento.numero = e.numero;
        dispatchEvent(evento);
    }

    protected function exitFrameHandler(event : Event) : void {
        frame = videos_mc.currentFrame - 1;
        render();
    }

    protected function render() : void {

        if(frame == 300 && _ini == false){
            mostrarBotones();
            var _evento:InicioEvent = new InicioEvent(InicioEvent.COPY);
            _evento.quien = 'ini';
            dispatchEvent(_evento);
            _ini = true;
        }
        for(var i:int = 1; i<_banderas; i++){
            videos_mc['track'+i].render(frame);
        }
    }

    public function activarBotones(){
        btn_izquierda.visible = true;
        btn_derecha.visible = true;
    }


}
}
