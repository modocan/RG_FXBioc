/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 21/04/12
 * Time: 12:06
 * To change this template use File | Settings | File Templates.
 */
package events {
import flash.events.Event;

public class ControlEvent extends Event {

    public static const SECCION:String = 'ControlEvent.SECCION';
    public static const APAGA:String = 'ControlEvent.APAGA';
    public static const APAGAR:String = 'ControlEvent.APAGAR';
    public static const LOADER_LOGIN:String = 'ControlEvent.LOADER_LOGIN';
    public static const FIN_LOADER_LOGIN:String = 'ControlEvent.FIN_LOADER_LOGIN';
    public static const ACTUALIZA_USUARIO:String = 'ControlEvent.ACTUALIZA_USUARIO';

    private var _quien:String;
    private var _datos:Object = new Object();

    public function ControlEvent(tipo:String) {
        super(tipo);
    }

    public function get quien():String {
        return _quien;
    }

    public function set quien(value:String):void {
        _quien = value;
    }

    public function get datos():Object {
        return _datos;
    }

    public function set datos(value:Object):void {
        _datos = value;
    }
}
}
