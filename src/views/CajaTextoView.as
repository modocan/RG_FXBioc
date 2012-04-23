/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 22/04/12
 * Time: 02:20
 * To change this template use File | Settings | File Templates.
 */
package views {
import com.hexagonstar.util.debug.Debug;

import events.PreguntasEvent;

import flash.display.Bitmap;
import flash.display.Loader;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.net.URLRequest;

public class CajaTextoView extends Sprite {

    private var clip:CajaTexto;
    private var usuario:Object;
    private var foto:Loader;
    private var _this:CajaTextoView;

    private const TEXTO_ENVIO:String = 'INTRODUCE TU PREGUNTA';

    public function CajaTextoView(datos:Object) {

        usuario = new Object();
        usuario = datos;

        _this = this;

        this.addEventListener(Event.ADDED_TO_STAGE, init);

    }


    private function init(e:Event):void
    {
        this.removeEventListener(Event.ADDED_TO_STAGE, init);

        pintaEscribir();
    }


    private function pintaEscribir():void
    {
        clip = new CajaTexto();
        clip.cerrar.visible = false;
        clip.texto_txt.selectable = true;
        clip.texto_txt.text = TEXTO_ENVIO;
        clip.enviar.visible = true;
        clip.enviar.buttonMode = true;
        clip.cerrar.buttonMode = true;
        clip.enviar.addEventListener(MouseEvent.CLICK, clicEnvio);
        clip.cerrar.addEventListener(MouseEvent.CLICK, clicCerrar);
        clip.texto_txt.addEventListener(MouseEvent.CLICK, clicTexto);
        clip.addEventListener(Event.ADDED_TO_STAGE, addClip);
        addChild(clip);

    }

    private function addClip(e:Event):void
    {
        clip.removeEventListener(Event.ADDED_TO_STAGE, addClip);

        foto = new Loader();
        foto.name = 'cargador';
        foto.contentLoaderInfo.addEventListener(Event.COMPLETE, fotoCargada);
        foto.load(new URLRequest('http://graph.facebook.com/' + usuario.id + '/picture?type=large'));

    }


    private function clicTexto(e:MouseEvent):void
    {
        if(clip.texto_txt.text == TEXTO_ENVIO && clip.texto_txt.selectable){
            clip.texto_txt.text = '';
        } else if(clip.texto_txt.selectable && clip.texto_txt.text == ''){
            clip.texto_txt.text = TEXTO_ENVIO;
        }
    }


    private function fotoCargada(e:Event):void
    {
        /*if(clip.foto.getChildByName('cargador')){
            clip.foto.removeChild(clip.foto.getChildByName('cargador'));
        }*/

        Bitmap(e.currentTarget.content).smoothing = true;
        ajustaFoto(Bitmap(e.currentTarget.content)) ;

        foto.x = -(foto.width/2);
        foto.y = -(foto.height/2);

        foto.addEventListener(Event.ADDED_TO_STAGE, function(e:Event){
            var _clip:Loader = Loader(clip.foto.getChildByName('cargador'));
            _clip.mask = clip.foto.mascara;
        })  ;
        clip.foto.addChild(foto);

    }


    private function ajustaFoto(_foto:Bitmap):void
    {
        var stageAspectRatio = clip.foto.width / clip.foto.height;
        var imageAspectRatio = _foto.width / _foto.height;

        if (stageAspectRatio >= imageAspectRatio)
        {
            _foto.width = clip.foto.width;
            _foto.height = clip.foto.width / imageAspectRatio;
        }
        else
        {
            _foto.height = clip.foto.height;
            _foto.width = clip.foto.height * imageAspectRatio;
        }
    }


    private function clicEnvio(e:MouseEvent):void
    {
       if(clip.texto_txt.text != '' && clip.texto_txt.text != TEXTO_ENVIO && clip.texto_txt.text != ' '){
           var evento:PreguntasEvent = new PreguntasEvent(PreguntasEvent.ENVIA_PREGUNTA);
           evento.datos.pregunta = clip.texto_txt.text;
           _this.dispatchEvent(evento);
       }
    }


    private function clicCerrar(e:MouseEvent):void
    {

    }


    public function cambiaEscribir():void
    {
        clip.cerrar.visible = false;
        clip.texto_txt.selectable = true;
        clip.enviar.visible = true;
    }


    public function cambiaLeer():void
    {
        clip.cerrar.visible = true;
        clip.texto_txt.selectable = false;
        clip.enviar.visible = false;
    }

}
}
