/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 22/04/12
 * Time: 23:46
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
import flash.system.Security;

public class ItemLuminaria extends MovieClip {

    private var cargador:Loader;
    private var _datos:Object = new Object();
    private var ruta:String;
    private var _this:ItemLuminaria;

    public var mascara:MovieClip;

    public function ItemLuminaria() {

        Security.loadPolicyFile('http://a0.twimg.com/crossdomain.xml');

        this.buttonMode = true;
        _this = this;
        _this.visible = false;
        _this.alpha = 0;
        super();
    }

    public function init(__datos:Object, _ruta:String):void
    {
        _datos =  __datos;
        ruta = _ruta;

        cargador = new Loader();
        cargador.contentLoaderInfo.addEventListener(Event.COMPLETE, fotoCargada);
        cargador.load(new URLRequest(ruta));
        addChild(cargador);
    }

    private function fotoCargada(e:Event):void
    {
        Bitmap(e.currentTarget.content).smoothing = true;

        var stageAspectRatio = mascara.width / mascara.height;
        var imageAspectRatio = cargador.width / cargador.height;

        if (stageAspectRatio >= imageAspectRatio)
        {
            cargador.width = mascara.width;
            cargador.height = mascara.width / imageAspectRatio;
        }
        else
        {
            cargador.height = mascara.height;
            cargador.width = mascara.height * imageAspectRatio;
        }

        cargador.x = (mascara.width/2);
        cargador.y = mascara.height/2;

        cargador.mask = _this.mascara;
        cargador.x = -(cargador.width/2);
        cargador.y = -(cargador.height/2);
        
        _this.visible = true;
        TweenLite.to(_this, 0.5, {alpha: 1});
    }

    public function get datos():Object {
        return _datos;
    }

    public function set datos(value:Object):void {
        _datos = value;
    }
}
}
