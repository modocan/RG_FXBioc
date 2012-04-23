/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 21/04/12
 * Time: 13:29
 * To change this template use File | Settings | File Templates.
 */
package views {
import alternativa.engine3d.core.Debug;

import com.greensock.TweenMax;
import com.hexagonstar.util.debug.Debug;

import flash.display.Sprite;
import flash.events.Event;

public class SeccionProductoView extends Sprite {

    private var _this:SeccionProductoView;
    private var fondo_producto:FondoProducto;
    private var anchoActual:Number = 0;
    private var altoActual:Number = 0;

    public function SeccionProductoView(quien:String) {
        this.name = quien;
        _this = this;
        this.visible = false;
        _this.alpha = 0;
        this.addEventListener(Event.ADDED_TO_STAGE, init);
    }


    private function init(e:Event):void
    {
        com.hexagonstar.util.debug.Debug.trace('eooooo');

        this.removeEventListener(Event.ADDED_TO_STAGE, init);

        fondo_producto = new FondoProducto();
        fondo_producto.name = 'fondo';
        fondo_producto.addEventListener(Event.ADDED_TO_STAGE, function(e:Event){
            _this.stage.addEventListener(Event.RESIZE, ajusta);
            anchoActual = fondo_producto.width;
            altoActual = fondo_producto.height;
            ajusta();
            _this.visible = true;
            TweenMax.to(_this, 0.7, {alpha: 1, onComplete:function(){
                // _this.dispatchEvent(new ControlEvent(ControlEvent.APAGAR));
            }});
        });
        addChild(fondo_producto);
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

            FondoProducto(this.getChildByName('fondo')).x = (this.stage.stageWidth/2);
            FondoProducto(this.getChildByName('fondo')).y = this.stage.stageHeight/2;
        }
    }

}
}
