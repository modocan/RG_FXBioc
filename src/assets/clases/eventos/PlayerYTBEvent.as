/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 25/04/12
 * Time: 00:51
 * To change this template use File | Settings | File Templates.
 */
package assets.clases.eventos {
import flash.events.Event;

public class PlayerYTBEvent extends Event {

    public static const INIT:String = 'PlayerYTBEvent.INIT';
    public static const PLAY:String = 'PlayerYTBEvent.PLAY';
    public static const PAUSE:String = 'PlayerYTBEvent.PAUSE';
    public static const MUEVE:String = 'PlayerYTBEvent.MUEVE';
    public static const LISTO:String = 'PlayerYTBEvent.LISTO';

    private var _datos:Object = new Object();

    public function PlayerYTBEvent(tipo:String) {
        super(tipo);
    }

    public function get datos():Object {
        return _datos;
    }

    public function set datos(value:Object):void {
        _datos = value;
    }
}
}
