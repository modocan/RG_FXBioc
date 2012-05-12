/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 21/04/12
 * Time: 12:04
 * To change this template use File | Settings | File Templates.
 */
package events {
import flash.events.Event;

public class PreguntasEvent extends Event {

    public static const LOGIN:String = 'PreguntasEvent.LOGIN';
    public static const ENVIA_PREGUNTA:String = 'PreguntasEvent.ENVIA_PREGUNTA';
    public static const PREGUNTA_REGISTRADA:String = 'PreguntasEvent.PREGUNTA_REGISTRADA';
    public static const PIDE_LUMINARIAS:String = 'PreguntasEvent.PIDE_LUMINARIAS';
    public static const LUMINARIAS_RECIBIDAS:String = 'PreguntasEvent.LUMINARIAS_RECIBIDAS';
    public static const TIRADOR_VISIBLE:String = 'PreguntasEvent.TIRADOR_VISIBLE';
    public static const TIRADOR_OCULTO:String = 'PreguntasEvent.TIRADOR_OCULTO';
    public static const TIRADOR_MOV:String = 'PreguntasEvent.TIRADOR_MOV';
    public static const TIRADOR_INVERSO:String = 'PreguntasEvent.TIRADOR_INVERSO';
    public static const PREGUNTA_ELEGIDA:String = 'PreguntasEvent.PREGUNTA_ELEGIDA';
    public static const TEXTO_CERRADO:String = 'PreguntasEvent.TEXTO_CERRADO';
    public static const PIN_TWT:String = 'PreguntasEvent.PIN_TWT';
    public static const ESCRIBE_PIN:String = 'PreguntasEvent.ESCRIBE_PIN';
    public static const CERRAR_CAJA:String = 'PreguntasEvent.CERRAR_CAJA';

    private var _datos:Object = new Object();

    public function PreguntasEvent(tipo:String) {
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
