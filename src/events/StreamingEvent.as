/**
 * Created with IntelliJ IDEA.
 * User: rubenmorato
 * Date: 13/05/12
 * Time: 17:43
 * To change this template use File | Settings | File Templates.
 */
package events {

import flash.events.Event;

    public class StreamingEvent extends Event{

        public static const INIT_VIDEO:String = 'StreamingEvent.INIT_VIDEO';

        public function StreamingEvent(tipo:String) {
            super(tipo);
        }
    }
}
