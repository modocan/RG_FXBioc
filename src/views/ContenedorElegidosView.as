/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 12/05/12
 * Time: 19:11
 * To change this template use File | Settings | File Templates.
 */
package views {
import com.greensock.TweenLite;
import com.greensock.TweenLite;

import events.PreguntasEvent;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class ContenedorElegidosView extends Sprite {

    private var elementos:Object;
    private var _this:ContenedorElegidosView;
    private var cara:CaraUser;

    public function ContenedorElegidosView(_elems:Object) {
        _this = this;
        elementos = new Object();
        elementos = _elems;
        _this.addEventListener(Event.ADDED_TO_STAGE, init);
    }


    private function init(e:Event):void
    {
        _this.removeEventListener(Event.ADDED_TO_STAGE, init);
        _this.stage.addEventListener(Event.RESIZE, ajusta);

        for(var i:int=0; i < elementos.length; i++)
        {
            cara = new CaraUser();
            cara.datos = elementos[i];
            cara.scaleX = cara.scaleY = 0.6;
            cara.x = (cara.width/2) + ((cara.width + 11) * i);
            cara.y = cara.height/2;
            cara.buttonMode = true;
            cara.addEventListener(MouseEvent.CLICK, clicCara);
            cara.addEventListener(Event.ADDED_TO_STAGE, creado);
            addChild(cara);

        }

        function creado(e:Event):void
        {
            CaraUser(e.currentTarget).removeEventListener(Event.ADDED_TO_STAGE, creado);
            CaraUser(e.currentTarget).cargaFoto();
            ajusta();
        }
    }

    private function clicCara(e:MouseEvent):void
    {
         for(var j:int=0; j < elementos.length; j++)
         {
             CaraUser(_this.getChildAt(j)).buttonMode = true;
             TweenLite.to(CaraUser(_this.getChildAt(j)), 0.3, {alpha: 1});
             CaraUser(_this.getChildAt(j)).addEventListener(MouseEvent.CLICK, clicCara);
             TweenLite.to(CaraUser(_this.getChildAt(j)), 0.3, {alpha: 1});
         }

        CaraUser(e.currentTarget).buttonMode = false;
        CaraUser(e.currentTarget).removeEventListener(MouseEvent.CLICK, clicCara);
        TweenLite.to(CaraUser(e.currentTarget), 0.3, {alpha: 0.6});

        var evento:PreguntasEvent = new PreguntasEvent(PreguntasEvent.CLIC_RESPUESTA);
        evento.datos =  CaraUser(e.currentTarget).datos;
        _this.dispatchEvent(evento);
    }


    private function ajusta(e:Event = null):void
    {
        _this.x =  (_this.stage.stageWidth/2) - (_this.width/2);
        _this.y = (_this.stage.stageHeight - (_this.height + 35));

    }

}
}
