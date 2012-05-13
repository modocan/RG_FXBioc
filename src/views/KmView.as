/**
 * Created with IntelliJ IDEA.
 * User: rubenmorato
 * Date: 12/05/12
 * Time: 17:34
 * To change this template use File | Settings | File Templates.
 */
package views {


import com.hexagonstar.util.debug.Debug;

import flash.display.MovieClip;
import flash.events.Event;

import com.greensock.TweenLite;
import com.greensock.TweenMax;

public class KmView extends MovieClip{

        private var _km:Kilometraje_mc;
        private var _this:KmView;
        private var _total:int;
        private var _porcentaje:int;

        public function KmView() {

            _this = this;
            _this.visible = false;
            _this.alpha = 0;
            _this.addEventListener(Event.ADDED_TO_STAGE, init);

        }

        private function init(e:Event):void
        {
            _km = new Kilometraje_mc();
            _this.removeEventListener(Event.ADDED_TO_STAGE, init);
            _this.stage.addEventListener(Event.RESIZE, ajusta);
            _this.addChild(_km);
            _this.visible = true;
            TweenMax.to(_this, 1, {alpha:1, delay:2});
            ajusta();

        }

        public function actualizar(_valor:int){

            _porcentaje = Math.floor((_valor * 174)/_total);
            _km.km_txt.text = String(_porcentaje);
        }

        private function ajusta(e:Event = null){
            _this.x = stage.stageWidth - _this.width/2 - 10;
            _this.y = stage.stageHeight/2;
        }

        // GETTER & SETTER

        public function set total(_valor:int):void{
            _total = _valor;
        }

    }
}
