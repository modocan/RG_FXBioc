/**
 * Created with IntelliJ IDEA.
 * User: rubenmorato
 * Date: 25/04/12
 * Time: 05:06
 * To change this template use File | Settings | File Templates.
 */
package events {
    import flash.events.Event;

    public class InicioEvent extends Event {

        public static const ABRIR:String = 'InicioEvent.ABRIR';
        public static const ABRIR_TRAMO:String = 'InicioEvent.ABRIR_TRAMO';
        public static const CERRAR_TRAMO:String = 'InicioEvent.CERRAR_TRAMO';
        public static const COPY:String = 'InicioEvent.COPY';
        public static const MOJON:String = 'InicioEvent.MOJON';
        public static const FBMICRO:String = 'InicioEvent.FBMICRO';
        public static const TWTMICRO:String = 'InicioEvent.TWTMICRO';
        public static const TWTPIN:String = 'InicioEvent.TWTPIN';
        public static const TWTCERRARPIN:String = 'InicioEvent.TWTCERRARPIN';
        public static const COGE_PIN:String = 'InicioEvent.COGE_PIN';


        private var _secciones:Array = new Array();
        private var _quien:String;
        private var _datos:String;
        private var _user:Object = new Object();
		private var _numero:String;


        public function InicioEvent(tipo:String) {
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

        public function get datos():String {
            return _datos;
        }

        public function set datos(value:String):void {
            _datos = value;
        }

        public function get user():Object {
            return _user;
        }

        public function set user(value:Object):void {
            _user = value;
        }
		
		 public function get numero():String {
            return _numero;
        }

        public function set numero(value:String):void {
            _numero = value;
        }
    }
}
