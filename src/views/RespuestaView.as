/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 22/04/12
 * Time: 20:13
 * To change this template use File | Settings | File Templates.
 */
package views {
import com.greensock.TweenLite;

import flash.display.Sprite;
import flash.events.Event;

public class RespuestaView extends Sprite {

    private var clip:RespuestaPregunta;

    public function RespuestaView() {
        this.addEventListener(Event.ADDED_TO_STAGE, init);
    }


    private function init(e:Event):void
    {
        clip = new RespuestaPregunta();
        clip.aprobacion.alpha = 0;
        clip.addEventListener(Event.ADDED_TO_STAGE, initClip);
        addChild(clip);
    }

    private function initClip(e:Event):void
    {
        clip.removeEventListener(Event.ADDED_TO_STAGE, init);

        TweenLite.to(clip.aprobacion, 0.5, {delay:0.8, alpha: 1});
    }
}
}
