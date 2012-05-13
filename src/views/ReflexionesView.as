/**
 * Created with IntelliJ IDEA.
 * User: rubenmorato
 * Date: 13/05/12
 * Time: 13:16
 * To change this template use File | Settings | File Templates.
 */
package views {


import flash.display.MovieClip;
import flash.events.Event;

import com.greensock.TweenLite;
import com.greensock.TweenMax;

public class ReflexionesView extends MovieClip{

        private var _this:ReflexionesView;
        private var _reflexiones:CartelReflexiones_mc;

        public function ReflexionesView() {
            _this = this;
            _this.visible = false;
            _this.alpha = 0;
            _this.addEventListener(Event.ADDED_TO_STAGE, init);

        }

        private function init(e:Event):void
        {
            _reflexiones = new CartelReflexiones_mc();
            _this.removeEventListener(Event.ADDED_TO_STAGE, init);
            _this.stage.addEventListener(Event.RESIZE, ajusta);
            _this.addChild(_reflexiones);
            _this.visible = true;
            TweenMax.to(_this, 1, {alpha:1, delay:2});

            ajusta();

        }

        private function ajusta(e:Event = null){

            _this.x = stage.stageWidth/2;
            _this.y = stage.stageHeight/2;

            var stageAspectRatio = stage.stageWidth / stage.stageHeight;

            var imageAspectRatio = _reflexiones.fondo_mc.width / _reflexiones.fondo_mc.height;

            if (stageAspectRatio >= imageAspectRatio)
            {
                _reflexiones.fondo_mc.width = stage.stageWidth;
                _reflexiones.fondo_mc.height = stage.stageWidth / imageAspectRatio;
            }
            else
            {
                _reflexiones.fondo_mc.height = stage.stageHeight;
                _reflexiones.fondo_mc.width = stage.stageHeight * imageAspectRatio;
            }
        }
    }
}
