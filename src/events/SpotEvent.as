/**
 * Created by IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 25/04/12
 * Time: 04:41
 * To change this template use File | Settings | File Templates.
 */
package events {
import flash.events.Event;

public class SpotEvent extends Event {

    public static const ESTADO_PLAY:String = 'SpotEvent.ESTADO_PLAY';
    public static const ESTADO_STOP:String = 'SpotEvent.ESTADO_STOP';

    public function SpotEvent(tipo:String) {
        super(tipo);
    }
}
}
