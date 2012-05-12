/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 12/05/12
 * Time: 16:07
 * To change this template use File | Settings | File Templates.
 */
package views {
import com.greensock.TweenLite;
import com.hexagonstar.util.debug.Debug;

import flash.display.Sprite;
import flash.events.Event;

public class SeccionRespondeView extends  Sprite {

    private var _this:SeccionRespondeView;
    private var fondo:FondoResponde;
    private var titulo:TituloResponde;
    private var contenedor:ContenedorElegidosView;
    private var cartel:CajaTexto;
    private var video:SeccionSpotView;

    public function SeccionRespondeView(param:String) {
        this.name = param;
        _this = this;

        this.alpha = 0;
        this.visible = false;

        _this.addEventListener(Event.ADDED_TO_STAGE, init);
    }


    private function init(e:Event):void
    {
        _this.removeEventListener(Event.ADDED_TO_STAGE, init);

        fondo = new FondoResponde();
        fondo.name = 'fondo';
        fondo.addEventListener(Event.ADDED_TO_STAGE, fondoCreado);
        addChild(fondo);

        function fondoCreado(e:Event):void
        {
            fondo.removeEventListener(Event.ADDED_TO_STAGE, fondoCreado);
            _this.stage.addEventListener(Event.RESIZE, ajusta);

            ajusta();

            _this.visible = true;

            titulo = new TituloResponde();
            titulo.x = 40;
            titulo.y = 140;
            addChild(titulo);

            TweenLite.to(_this, 0.4, {alpha: 1});
        }
    }




    public function pintaSeleccionadas(_datos:Object):void
    {
        contenedor = new ContenedorElegidosView(_datos);
        addChild(contenedor);
    }


    public function muestraRespuesta(_dato:Object):void
    {
        TweenLite.to(titulo, 0.3, {alpha: 0, onComplete: function(){
            titulo.visible = false;

             if(_this.getChildByName('cartel'))
             {
                 _this.removeChild(cartel);
             }

            crea();
        }});

        function crea():void
        {
            cartel = new CajaTexto();
            cartel.name = 'cartel';
            cartel.x = titulo.x;
            cartel.y = titulo.y;
            cartel.alpha = 0;
            cartel.foto.datos = _dato;
            cartel.foto.cargaFoto();
            cartel.cerrar.visible = false;
            cartel.enviar.visible = false;
            cartel.ciudad_txt.text = _dato.ciudad as String;
            cartel.nombre_txt.text = _dato.nombre + ' ' + _dato.apellidos as String;
            cartel.texto_txt.text = _dato.pregunta as String;
            cartel.texto_txt.selectable = false;
            cartel.addEventListener(Event.ADDED_TO_STAGE, pintado);
            _this.addChild(cartel);
        }

        function pintado(e:Event):void
        {
            cartel.removeEventListener(Event.ADDED_TO_STAGE, pintado);

            TweenLite.to(cartel, 0.3, {alpha: 1});

            pintaVideo();
        }

        function pintaVideo():void
        {
             if(_this.getChildByName('__video'))
             {    video.destruyeMini();
                 //video.addEventListener(Event.REMOVED_FROM_STAGE, borrado);
                 _this.removeChild(video);
             }

                 video = new SeccionSpotView('__video', _dato.video as String);
                 _this.addChildAt(video, _this.getChildIndex(fondo) + 1);

        }

        function borrado(e:Event):void
        {
            //video.removeEventListener(Event.REMOVED_FROM_STAGE, borrado);
        }
    }


    private function ajusta(e:Event = null):void
    {
        if(_this.getChildByName('fondo')){

            var stageAspectRatio = _this.stage.stageWidth / _this.stage.stageHeight;
            var imageAspectRatio = FondoResponde(_this.getChildByName('fondo')).width / FondoResponde(_this.getChildByName('fondo')).height;

            if (stageAspectRatio >= imageAspectRatio)
            {
                FondoResponde(_this.getChildByName('fondo')).width = _this.stage.stageWidth;
                FondoResponde(_this.getChildByName('fondo')).height = _this.stage.stageWidth / imageAspectRatio;
            }
            else
            {
                FondoResponde(_this.getChildByName('fondo')).height = _this.stage.stageHeight;
                FondoResponde(_this.getChildByName('fondo')).width = _this.stage.stageHeight * imageAspectRatio;
            }

            FondoResponde(this.getChildByName('fondo')).x = (_this.stage.stageWidth/2);
            FondoResponde(this.getChildByName('fondo')).y = _this.stage.stageHeight/2;
        }
    }




}
}
