/**
 * Created by IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 23/04/12
 * Time: 21:31
 * To change this template use File | Settings | File Templates.
 */
package assets.clases.eventos {
import flash.events.Event;

public class SlideLumiEvent extends Event {

    public static const MOVIMIENTO:String = 'SlideLumiEvent.MOVIMIENTO';

    private var _datos:Object = new Object();

    public function SlideLumiEvent(tipo:String) {
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
