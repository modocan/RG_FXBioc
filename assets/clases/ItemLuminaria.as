/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 22/04/12
 * Time: 23:46
 * To change this template use File | Settings | File Templates.
 */
package assets.clases {
import flash.display.Bitmap;
import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.net.URLRequest;

public class ItemLuminaria extends Sprite {

    private var cargador:Loader;
    private var _datos:Object = new Object();
    private var ruta:String;
    private var _this:ItemLuminaria;

    public var mascara:MovieClip;

    public function ItemLuminaria() {
        this.buttonMode = true;
        _this = this;
        super();
    }

    public function init(__datos:Object, _ruta:String):void
    {
        _datos =  __datos;
        ruta = _ruta;

        cargador = new Loader();
        cargador.contentLoaderInfo.addEventListener(Event.COMPLETE, fotoCargada);
        cargador.load(new URLRequest(ruta));
        addChild(cargador)
    }

    private function fotoCargada(e:Event):void
    {
        Bitmap(e.currentTarget.content).smoothing = true;

        // TODO ajustar el tamaño de la foto

        cargador.mask = _this.mascara;
        cargador.x = -(cargador.width/2);
        cargador.y = -(cargador.height/2);
    }

    public function get datos():Object {
        return _datos;
    }

    public function set datos(value:Object):void {
        _datos = value;
    }
}
}
