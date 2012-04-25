/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 22/04/12
 * Time: 02:20
 * To change this template use File | Settings | File Templates.
 */
package views {
import com.greensock.TweenLite;
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

    public function CajaTextoView() {
        _this = this;
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
        addChild(clip);
    }


    public function init(datos:Object):void
    {
        usuario = new Object();
        usuario = datos;
    }

    public function reinicia():void
    {
        Debug.inspect(usuario);

        clip.cerrar.visible = false;
        clip.nombre_txt.text = usuario.nombre + ' ' + usuario.apellidos;
        clip.texto_txt.selectable = true;
        clip.texto_txt.text = TEXTO_ENVIO;
        clip.ciudad_txt.text = usuario.ciudad;
        clip.enviar.visible = true;

        addClip();
    }

    private function addClip():void
    {
        //clip.removeEventListener(Event.ADDED_TO_STAGE, addClip);

        foto = new Loader();
        foto.name = 'cargador';
        foto.contentLoaderInfo.addEventListener(Event.COMPLETE, fotoCargada);
        foto.load(new URLRequest(usuario.foto as String));
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
        TweenLite.to(_this,  0.4, {alpha: 0, onComplete: function(){
            _this.visible = false;
            _this.dispatchEvent(new PreguntasEvent(PreguntasEvent.TEXTO_CERRADO));
        }});
    }


    public function cambiaEscribir():void
    {
        clip.foto.visible = true;
        clip.nombre_txt.visible = true;
        clip.ciudad_txt.visible = true;
        clip.cerrar.visible = false;
        clip.texto_txt.selectable = true;
        clip.texto_txt.text = TEXTO_ENVIO;
        clip.enviar.visible = true;
    }


    public function cambiaPin():void
    {
        if(_this.visible)
        {
            TweenLite.to(_this, 0.4, {alpha: 0, onComplete: function(){
                pinta();
            }});
        } else {
            pinta();
        }
        
        function pinta():void
        {
            Debug.trace('[QUÉ PINTOOOOOOOOOOO]');
            
            clip.foto.visible = false;
            clip.nombre_txt.visible = false;
            clip.ciudad_txt.visible = false;
            clip.cerrar.visible = false;
            clip.texto_txt.selectable = false;
            clip.texto_txt.text = 'PIN';
            clip.enviar.visible = true;
            clip.enviar.removeEventListener(MouseEvent.CLICK, clicEnvio);
            clip.enviar.addEventListener(MouseEvent.CLICK, clicPin);
            _this.visible = true;
            TweenLite.to(_this,  0.4, {alpha: 1});
        }
        
        function clicPin(e:MouseEvent):void
        {
            if(clip.texto_txt.text != 'PIN' && clip.texto_txt.text != '' && clip.texto_txt.text != ' ')
            {
                clip.enviar.addEventListener(MouseEvent.CLICK, clicPin);
                
                var evento:PreguntasEvent = new PreguntasEvent(PreguntasEvent.ESCRIBE_PIN);
                evento.datos.pin = clip.texto_txt.text;
                _this.dispatchEvent(evento);

                TweenLite.to(_this,  0.4, {alpha: 0, onComplete: function(){
                    clip.enviar.removeEventListener(MouseEvent.CLICK, clicPin);

                    clip.enviar.addEventListener(MouseEvent.CLICK, clicEnvio);
                    cambiaEscribir();

                    TweenLite.to(_this, 0.4, {alpha: 1});

                }}); 
            }
            
        }
        
        
    }


    public function cambiaLeer(_datos:Object):void
    {
        if(_this.visible){
            TweenLite.to(_this, 0.4, {alpha: 0, onComplete: function(){
                pinta();
            }});            
        } else {
            pinta();
        }

        function pinta():void
        {
            clip.foto.visible = true;
            clip.nombre_txt.visible = true;
            clip.ciudad_txt.visible = true;
            clip.cerrar.visible = true;
            clip.texto_txt.selectable = false;
            clip.enviar.visible = false;

            clip.nombre_txt.text = _datos.nombre + ' ' + _datos.apellidos;
            clip.texto_txt.text = _datos.pregunta as String;
            clip.ciudad_txt.text = _datos.ciudad;
            
            if(clip.foto.getChildByName('cargador'))
            {
                clip.foto.removeChild(clip.foto.getChildByName('cargador'));
            }

            foto = new Loader();
            foto.name = 'cargador';
            foto.contentLoaderInfo.addEventListener(Event.COMPLETE, fotoCargada);
            foto.load(new URLRequest(_datos.foto));
            
            _this.visible = true;
            TweenLite.to(_this,  0.4, {alpha: 1});

        }

    }

}
}
