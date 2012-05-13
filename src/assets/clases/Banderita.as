/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 13/05/12
 * Time: 14:11
 * To change this template use File | Settings | File Templates.
 */
package assets.clases {
import com.greensock.TweenLite;
import com.greensock.TweenMax;

import flash.display.MovieClip;
import flash.display.Sprite;

public class Banderita extends Sprite {

    private var _this:Banderita;

    public var fondo:MovieClip;
    public var cont:MovieClip;

    public function Banderita() {
        super();

        _this = this;

        _this.buttonMode = true;
        cont.x -= 8;
        cont.alpha = 0;
    }

    public function init(_del:Number = 0):void
    {
        TweenLite.to(cont, 0.4, {delay: 0.1 * _del, x: cont.x + 8, alpha: 1});
    }

    public function elegido():void
    {
        _this.buttonMode = false;
        TweenMax.to(cont.fondo,  0.3, {tint: 0xDF3B38});
    }

    public function libre():void
    {
        _this.buttonMode = true;
        TweenMax.to(cont.fondo,  0.3, {tint: null});
    }

}
}
