/**
 * Created with IntelliJ IDEA.
 * User: rubenmorato
 * Date: 12/05/12
 * Time: 20:11
 * To change this template use File | Settings | File Templates.
 */
package views {


import flash.display.MovieClip;
import flash.events.Event;

import com.greensock.TweenLite;
import com.greensock.TweenMax;

    public class LoadingView extends MovieClip{

        private var _this:LoadingView;
        private var _loading:Loading_mc;


        public function LoadingView() {
            _this = this;
            _this.visible = false;
            _this.alpha = 0;
            _this.addEventListener(Event.ADDED_TO_STAGE, init);

        }

        private function init(e:Event):void
        {
            _loading = new Loading_mc();
            _this.removeEventListener(Event.ADDED_TO_STAGE, init);
            _this.stage.addEventListener(Event.RESIZE, ajusta);
            _this.addChild(_loading);
            ajusta();
        }

        public function mostrar(){
            _this.visible = true;
            TweenMax.to(_this, 0.5, {alpha:1});
        }

        public function ocultar(){
            _this.visible = true;
            TweenMax.to(_this, 0.5, {alpha:0,onComplete:function(){_this.visible = false;}});
        }

        private function ajusta(e:Event = null){
            _this.x = stage.stageWidth/2;
            _this.y = stage.stageHeight/2;
        }
    }
}
