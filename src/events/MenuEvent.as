/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 20/04/12
 * Time: 00:46
 * To change this template use File | Settings | File Templates.
 */
package events {
import flash.events.Event;

public class MenuEvent extends Event {

    public static const PIDE_MENU:String = 'MenuEvent.PIDE_MENU';
    public static const LISTADO_MENU:String = 'MenuEvent.LISTADO_MENU';
    public static const PINTA_MENU:String = 'MenuEvent.PINTA_MENU';
    public static const CLICK_SOCIAL:String = 'MenuEvent.CLICK_SOCIAL';
    public static const CLICK_MENU:String = 'MenuEvent.CLICK_MENU';

    private var _secciones:Array = new Array();
    private var _quien:String;


    public function MenuEvent(tipo:String) {
        super(tipo);
    }

    public function get secciones():Array {
        return _secciones;
    }

    public function set secciones(value:Array):void {
        _secciones = value;
    }

    public function get quien():String {
        return _quien;
    }

    public function set quien(value:String):void {
        _quien = value;
    }
}
}
