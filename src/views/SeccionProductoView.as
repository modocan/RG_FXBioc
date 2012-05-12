/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 21/04/12
 * Time: 13:29
 * To change this template use File | Settings | File Templates.
 */
package views {

import assets.clases.eventos.PlayerYTBEvent;

import com.greensock.TweenLite;

import com.greensock.TweenMax;
import com.hexagonstar.util.debug.Debug;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.net.URLRequest;
import flash.net.navigateToURL;

import gs.TweenMax;

public class SeccionProductoView extends Sprite {

    private var _this:SeccionProductoView;
    private var fondo_producto:FondoProducto;
    private var anchoActual:Number = 0;
    private var altoActual:Number = 0;
    private var titulo:TituloProducto;
    private var video:VideoProductoView;
    private var ruta_video:String;
    private var enlace_producto:String;

    public function SeccionProductoView(quien:String, _ruta_video:String, _producto:String) {
        this.name = quien;
        _this = this;
        this.visible = false;
        _this.alpha = 0;
        enlace_producto = _producto;
        ruta_video = _ruta_video;
        this.addEventListener(Event.ADDED_TO_STAGE, init);
    }


    private function init(e:Event):void
    {
        this.removeEventListener(Event.ADDED_TO_STAGE, init);

        fondo_producto = new FondoProducto();
        fondo_producto.name = 'fondo';
        fondo_producto.addEventListener(Event.ADDED_TO_STAGE, function(e:Event){
            _this.stage.addEventListener(Event.RESIZE, ajusta);
            anchoActual = fondo_producto.width;
            altoActual = fondo_producto.height;
            ajusta();
            _this.visible = true;

            TweenLite.to(_this, 0.7, {alpha: 1, onComplete:function(){
                // _this.dispatchEvent(new ControlEvent(ControlEvent.APAGAR));
            }});
        });
        addChild(fondo_producto);

        titulo = new TituloProducto();
        titulo.name = 'titulo';
        titulo.x = 50;
        titulo.y = 110;
        titulo.enlace.buttonMode = true;
        titulo.enlace.addEventListener(MouseEvent.CLICK, clicEnlace);
        titulo.addEventListener(Event.ADDED_TO_STAGE, ad_titulo);
        _this.addChild(titulo);
        
        function ad_titulo(e:Event):void
        {
            titulo.removeEventListener(Event.ADDED_TO_STAGE, ad_titulo);

            video = new VideoProductoView();
            video.name = 'video';
            video.x = titulo.x;
            video.y = titulo.y + titulo.height + 12;
            video.addEventListener(Event.ADDED_TO_STAGE, ad_video);
            _this.addChild(video);
        }

        function ad_video(e:Event):void
        {
            video.removeEventListener(Event.ADDED_TO_STAGE, ad_video);
            video.inicio(ruta_video);
        }


        function clicEnlace(e:MouseEvent):void
        {
            navigateToURL(new URLRequest(enlace_producto), '_blank');
        }


    }


    public function destruye():void
    {
        video.destruye();
    }



    private function ajusta(e:Event=null):void
    {
        //var porcentaje:Number = 0;

        if(_this.getChildByName('fondo')){

            var stageAspectRatio = stage.stageWidth / stage.stageHeight;
            var imageAspectRatio = FondoProducto(_this.getChildByName('fondo')).width / FondoProducto(_this.getChildByName('fondo')).height;

            if (stageAspectRatio >= imageAspectRatio)
            {
                FondoProducto(_this.getChildByName('fondo')).width = stage.stageWidth;
                FondoProducto(_this.getChildByName('fondo')).height = stage.stageWidth / imageAspectRatio;
            }
            else
            {
                FondoProducto(_this.getChildByName('fondo')).height = stage.stageHeight;
                FondoProducto(_this.getChildByName('fondo')).width = stage.stageHeight * imageAspectRatio;
            }

            /*FondoProducto(this.getChildByName('fondo')).x = (this.stage.stageWidth/2);
            FondoProducto(this.getChildByName('fondo')).y = this.stage.stageHeight/2;*/

            FondoProducto(_this.getChildByName('fondo')).x = (stage.stageWidth) - (FondoProducto(_this.getChildByName('fondo')).width / 2);
            FondoProducto(_this.getChildByName('fondo')).y = (FondoProducto(_this.getChildByName('fondo')).height / 2);
        }
    }

}
}
