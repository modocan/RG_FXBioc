/**
 * Created with IntelliJ IDEA.
 * User: rubenmorato
 * Date: 25/04/12
 * Time: 00:37
 * To change this template use File | Settings | File Templates.
 */
package assets.rub.clases
{

	import com.hexagonstar.util.debug.Debug;

    import events.InicioEvent;

    import flash.display.MovieClip;
	import flash.events.MouseEvent;
    import gs.TweenMax;
	import gs.easing.Expo;
	import gs.events.TweenEvent;
    import flash.net.NetConnection;
    import flash.net.Responder;

	public class BotonSimple extends MovieClip
	{

        private const GATEWAY:String = 'http://www.flex.es/tourflex/amfphp/gateway.php';
        private var cn:NetConnection;

        private var _this:BotonSimple;
        public var bola_mc:MovieClip;
        private var _mojon:String;
        private var _mensaje:String;
        private var _grabar:String;

		public function BotonSimple()
		{
            _this = this;
            _this.buttonMode = true;
            _this.addEventListener(MouseEvent.ROLL_OVER, sobre);
            _this.addEventListener(MouseEvent.ROLL_OUT, fuera);
            _this.addEventListener(MouseEvent.CLICK, cargarMensaje);
		}

		private function sobre(evt:MouseEvent)
		{
            if(_this.buttonMode == true){
                _this.gotoAndPlay('entrada');
            }
		}

		private function fuera(evt:MouseEvent)
		{
            if(_this.buttonMode == true){
                _this.gotoAndPlay('salida');
            }
		}

		private function cargarMensaje(evt:MouseEvent)
		{
            if(evt.currentTarget.buttonMode == true){
                var _evento:InicioEvent = new InicioEvent(InicioEvent.MOJON);
                _evento.quien = _mojon;
                _evento.datos = _mensaje;
                dispatchEvent(_evento);
            }
		}

        public function consultaEstado(id_clip:String):void
        {
            _grabar = id_clip;
            cn = new NetConnection();
            cn.connect(GATEWAY);
            cn.call('ContactService.comprobarEstado', new Responder(respuesta), _grabar);
        }

        private function respuesta(datos:Object):void
        {
            if(datos == 'KO'){
                _this.buttonMode = true;
                TweenMax.to(_this.bola_mc.color_mc, 0.3, {tint: 0x8CD0CF});
            }  else {
                _this.buttonMode = false;
                TweenMax.to(_this.bola_mc.color_mc, 0.3, {tint: 0xD34D4A});
            }
        }

        public function set mojon(valor:String){

            _mojon = valor;
        }

        public function set mensaje(valor:String){

            _mensaje = valor;
        }

	}
}