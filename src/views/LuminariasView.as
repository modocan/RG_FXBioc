/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 22/04/12
 * Time: 22:17
 * To change this template use File | Settings | File Templates.
 */
package views {
import com.hexagonstar.util.debug.Debug;

import events.PreguntasEvent;

import flash.display.Sprite;
import flash.events.Event;

public class LuminariasView extends Sprite {

    private var contenedor:Sprite;
    private var luminaria:Luminaria;
    private var mascara:MascaraLuminarias;
    private var lumis:Object;
    private var _this:LuminariasView;


    public function LuminariasView() {

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

        Debug.trace('[Ancho Escenario] -> ' + this.stage.stageWidth, Debug.LEVEL_ERROR);
        Debug.trace('[Mi posicion] -> ' + this.x, Debug.LEVEL_ERROR);

        contenedor = new Sprite();
        contenedor.cacheAsBitmap = true;
        contenedor.addEventListener(Event.ADDED_TO_STAGE, cont);
        addChild(contenedor);

        function cont(e:Event):void
        {
            contenedor.removeEventListener(Event.ADDED_TO_STAGE, cont);

            var ruta_lumi:String;
            for(var i:int = 0; i < lumis.length; i++)
            {
                // TODO pasar datos cuando no es FB (!=0)
                if(lumis[i].red_social == 0){
                     ruta_lumi = 'http://graph.facebook.com/' + lumis[i].id_social + '/picture';
                }  else {

                }

                luminaria = new Luminaria();
                luminaria.clip.init(lumis[i], ruta_lumi);
                luminaria.name = String(i);
                if(i > 0){
                   luminaria.x = (luminaria.width + luminaria.width/2) + (luminaria.width * i) + (Math.random() * 20);
                } else {
                    luminaria.x = luminaria.width;
                }
                luminaria.y = Math.random() * 300;
                luminaria.gotoAndStop(Math.round(Math.random() * (luminaria.totalFrames - 1)));
                // TODO registrar el click de la Luminaria
                luminaria.addEventListener(Event.ADDED_TO_STAGE, function(e:Event){
                    Luminaria(e.currentTarget).play();
                });
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
            });
            addChild(mascara);
        }

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
    }


}
}
