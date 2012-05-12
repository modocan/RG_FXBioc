/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 12/05/12
 * Time: 17:53
 * To change this template use File | Settings | File Templates.
 */
package assets.clases {
import com.greensock.TweenLite;
import com.hexagonstar.util.debug.Debug;

import flash.display.Bitmap;
import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.net.URLRequest;

public class Cara_User extends Sprite {

    public var datos:Object = new Object();
    private var cargador:Loader;
    private var _this:Cara_User;

    public var mascara:MovieClip;

    public function Cara_User() {
        super();
        _this = this;
    }


    public function cargaFoto():void
    {
        mascara.visible = false;
        mascara.alpha = 0;

        cargador = new Loader();
        cargador.contentLoaderInfo.addEventListener(Event.COMPLETE, cargado);
        cargador.addEventListener(Event.ADDED_TO_STAGE, function(e:Event){
            Loader(e.currentTarget).mask = mascara;
        });
        cargador.load(new URLRequest(datos.foto as String));
        addChild(cargador);
    }


    private function cargado(e:Event):void
    {
        Debug.trace('[CARGADOOOOO]', Debug.LEVEL_ERROR);

        var _clip:Bitmap = Bitmap(e.currentTarget.content);
        _clip.smoothing = true;

        ajusta(_clip);

        _clip.x = -(_clip.width/2);
        _clip.y = -(_clip.height/2);

        cargador.mask = mascara;

        mascara.visible = true;
        TweenLite.to(mascara, 0.4, {alpha: 1});

    }


    private function ajusta(_clip:Bitmap):void
    {
        var stageAspectRatio = mascara.width / mascara.height;
        var imageAspectRatio = _clip.width / _clip.height;

        if (stageAspectRatio >= imageAspectRatio)
        {
            _clip.width = mascara.width;
            _clip.height = mascara.width / imageAspectRatio;
        }
        else
        {
            _clip.height = mascara.height;
            _clip.width = mascara.height * imageAspectRatio;
        }

    }


}
}
