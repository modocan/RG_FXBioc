/**
 * Created by IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 25/04/12
 * Time: 07:04
 * To change this template use File | Settings | File Templates.
 */
package views {
import assets.clases.PlayerYTB;
import assets.clases.eventos.PlayerYTBEvent;

import flash.display.Sprite;
import flash.events.Event;

public class VideoProductoView extends Sprite {

    private var _this:VideoProductoView;
    private var marco:MarcoVideo;
    private var ruta:String;
    private var video:PlayerYTB;

    public function VideoProductoView() {
        super();

        _this = this;

    }

    public function inicio(_ruta:String):void
    {
        ruta = _ruta;

        marco = new MarcoVideo();
        marco.addEventListener(Event.ADDED_TO_STAGE, init);
        addChild(marco);
    }


    private function init(e:Event):void
    {
        marco.removeEventListener(Event.ADDED_TO_STAGE, init);

        video = new PlayerYTB();
        video.x = video.y = 5;
        video.addEventListener(PlayerYTBEvent.INIT, init2);
        video.addEventListener(PlayerYTBEvent.LISTO, videoListo);
        video.addEventListener(Event.ADDED_TO_STAGE, ins_video);
        _this.addChild(video);
        
        function ins_video(e:Event):void
        {
            video.removeEventListener(Event.ADDED_TO_STAGE, ins_video);
            video.init(ruta, new BarraSeek(), new BtnPlay(), new BtnPause(), marco.width/2, marco.height + 12, marco.width-10, marco.height-10, true);
        }

        function init2(e:PlayerYTBEvent):void
        {
            _this.dispatchEvent(new PlayerYTBEvent(PlayerYTBEvent.INIT));
            _this.visible = true;

            //video.ajustaMini(marco.width-10, marco.height-10);

            //TweenLite.to(_this, 0.7, {alpha: 1});



        }

        function videoListo(e:PlayerYTBEvent):void
        {
            video.ajustaMini(marco.width-10, marco.height-10);
        }
    }


    public function destruye():void
    {
        video.destruye();
    }


}
}
