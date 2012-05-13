/**
 * Created with IntelliJ IDEA.
 * User: rubenmorato
 * Date: 12/05/12
 * Time: 17:59
 * To change this template use File | Settings | File Templates.
 */
package views {


import com.hexagonstar.util.debug.Debug;

import flash.display.MovieClip;
import flash.events.Event;

import com.greensock.TweenLite;
import com.greensock.TweenMax;


public class RecorridoView extends MovieClip{

    private var _recorrido:Recorrido_mc;
    private var _this:RecorridoView;
    private var _porcentaje:int;
    private var _total:int;




    public function RecorridoView() {

        _this = this;
        _this.visible = false;
        _this.alpha = 0;
        _this.addEventListener(Event.ADDED_TO_STAGE, init);

    }

    private function init(e:Event):void
    {
        _recorrido = new Recorrido_mc();
        _this.removeEventListener(Event.ADDED_TO_STAGE, init);
        _this.stage.addEventListener(Event.RESIZE, ajusta);
        _this.addChild(_recorrido);
        _this.visible = true;
        TweenMax.to(_this, 1, {alpha:1, delay:2});

        ajusta();

    }

    public function actualizarPos(_valor:int){

        _porcentaje = Math.floor((_valor*100)/_total);
        _recorrido.gotoAndStop(_porcentaje);
    }

    private function ajusta(e:Event = null){
        _this.x = this.width/2 + 40;
        _this.y = stage.stageHeight - this.height/2 - 40;
    }

    // GETTER & SETTER

    public function set total(_valor:int):void{
        _total = _valor;
        Debug.trace('TOTAL: '+_total);
    }

}
}
