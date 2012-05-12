/**
 * Created with IntelliJ IDEA.
 * User: rubenmorato
 * Date: 24/04/12
 * Time: 16:40
 * To change this template use File | Settings | File Templates.
 */
package assets.rub.clases {

    import com.hexagonstar.util.debug.Debug;

    import events.InicioEvent;

    import flash.display.MovieClip;
    import flash.net.NetConnection;
    import flash.net.NetStream;
    import flash.net.Responder;
    import flash.net.ObjectEncoding;
    import flash.media.Microphone;
    import flash.events.NetStatusEvent;
    import flash.events.StatusEvent
    import flash.events.TimerEvent;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import flash.utils.Timer;
    import flash.system.Security;
    import flash.system.SecurityPanel;

    import gs.TweenMax;
    import gs.easing.*;


    public class Microfono extends MovieClip {

        // SERVIDOR RED5

        private const GATEWAY:String = 'http://www.flex.es/tourflex/amfphp/gateway.php';
        private var cn:NetConnection;

        private var _servidor:String = 'rtmp://77.73.82.193/oflaDemo';

        // clips de película
        public var fondo_mc:MovieClip;
        public var registro_mc:MovieClip;
        public var btn_play:MovieClip;
        public var equaliza_mc:MovieClip;
        public var continue_mc:MovieClip;
        public var atras_mc:MovieClip;
        public var crono_txt:TextField;
        public var texto_txt:TextField;

        private var ns:NetStream;
        private var myTimer:Timer;
        private var myTimer2:Timer;
        private var nc:NetConnection = new NetConnection();
        private var red5:Object = new Object();
        private var delay:uint = 1000;
        private var repeat:uint = 11;
        private var m:Microphone;
        //m.rate(44);
        private var recording:Boolean=false;
        private var seg:int = 10;
        private var _this:Microfono;
        private var _mensaje:String;
        
        private var _fb:FBMicrofono;
        private var _twt:TwTMicrofono;
        private var _cajapin:Pin_mc;



     public function Microfono():void {

         _this = this;
     }

     public function init(){

         // CONGIF INI

         TweenMax.to(_this.fondo_mc.color_mc, 0.7, {tint: 0x98CACE});
         _this.btn_play.alpha = 0;
         _this.btn_play.visible = false;
         _this.continue_mc.alpha = 0;
         _this.continue_mc.visible = false;
         _this.atras_mc.alpha = 0;
         _this.atras_mc.visible = false;
         _this.equaliza_mc.alpha = 0;
         _this.equaliza_mc.visible = false;
         _this.crono_txt.alpha = 0;
         _this.crono_txt.visible = false;
         _this.texto_txt.alpha = 0;
         _this.texto_txt.visible = false;
         _this.texto_txt.text = '';
         _this.registro_mc.alpha = 0;
         _this.registro_mc.visible = false;

         _this.registro_mc.btn_fb.buttonMode = true;
         _this.registro_mc.btn_twitter.buttonMode = true;
         _this.registro_mc.btn_fb.addEventListener(MouseEvent.CLICK, registrar);
         _this.registro_mc.btn_twitter.addEventListener(MouseEvent.CLICK, registrar);

         _this.continue_mc.addEventListener(MouseEvent.CLICK, registrar);
         _this.continue_mc.buttonMode = true;
         _this.atras_mc.addEventListener(MouseEvent.CLICK, repetir);
         _this.atras_mc.buttonMode = true;
         _this.btn_play.addEventListener(MouseEvent.CLICK, previo);
         _this.btn_play.buttonMode = true;
         
         _this.stage.addEventListener(Event.RESIZE, ajusta);

     }

     private function repetir(evt:MouseEvent){
         TweenMax.to(_this.btn_play, 0.7, {alpha: 0, onComplete:function(){_this.btn_play.visible = false;}});
         TweenMax.to(_this.texto_txt, 0.7, {alpha: 0, onComplete:function(){_this.texto_txt.visible = false;}});
         TweenMax.to(_this.continue_mc, 0.7, {alpha: 0, onComplete:function(){_this.continue_mc.visible = false;}});
         TweenMax.to(_this.atras_mc, 0.7, {alpha: 0, onComplete:function(){
             _this.atras_mc.visible = false;
             _this.gotoAndPlay('entrada');
         }});
     }

     private function registrar(evt:MouseEvent){

         switch(evt.currentTarget.name){

             case 'continue_mc':
                 _this.texto_txt.visible = true;
                 TweenMax.to(_this.texto_txt, 0.7, {alpha: 1});
                 _this.texto_txt.htmlText = 'REGISTRA\n TU MENSAJE';
                 TweenMax.to(_this.btn_play, 0.7, {alpha: 0, onComplete:function(){_this.btn_play.visible = false;}});
                 TweenMax.to(_this.continue_mc, 0.7, {alpha: 0, onComplete:function(){_this.continue_mc.visible = false;}});
                 TweenMax.to(_this.atras_mc, 0.7, {alpha: 0, onComplete:function(){_this.atras_mc.visible = false;}});
                 _this.registro_mc.visible = true;
                 TweenMax.to(_this.registro_mc, 0.7, {alpha: 1});
                 break;
             case 'btn_fb':
                 _fb = new FBMicrofono();
                 _fb.addEventListener(InicioEvent.FBMICRO,registroFBCompletado);
                 _fb.init();
                 Debug.trace('Registro FB');
                 break;
             case 'btn_twitter':
                /* _cajapin = new Pin_mc();
                 _cajapin.name = 'cajapin';

                 _cajapin.addEventListener(Event.ADDED_TO_STAGE, initPin);
                 _cajapin.addEventListener(InicioEvent.TWTPIN, compruebaPin);
                 _cajapin.addEventListener(InicioEvent.TWTCERRARPIN, cerrarPin);
                 _this.addChild(_cajapin);*/
                     
                 _this.dispatchEvent(new InicioEvent(InicioEvent.TWTPIN));
                     
                 _twt = new TwTMicrofono();
                 _twt.addEventListener(InicioEvent.TWTMICRO,registroTWTCompletado);
                 _twt.init();
                 break;

         }

         function initPin(e:Event){
            _cajapin.removeEventListener(Event.ADDED_TO_STAGE, initPin);
             //_cajapin.init(_this.stage.stageWidth,_this.stage.stageHeight);
             Debug.trace(MovieClip(parent));
             _cajapin.x = 0;
             _cajapin.y = - MovieClip(parent).y + (_this.stage.stageHeight/2);
             
             trace(_this.stage.stageWidth,_this.stage.stageHeight);
             
             Debug.trace('[CAJAPIN]', Debug.LEVEL_ERROR);
         }

         function compruebaPin(e:InicioEvent){
             _twt.pintaPin(_cajapin.texto_txt.text);
         }

         function cerrarPin(e:InicioEvent){
             _cajapin.removeEventListener(InicioEvent.TWTCERRARPIN, cerrarPin);
            removeChild(_cajapin);
         }
     }

     private function registroFBCompletado(e:InicioEvent){
         Debug.trace('Registro FB completado: '+e.user);
         _fb.comparte();
         Debug.trace('************************************', Debug.LEVEL_ERROR);
         Debug.traceObj(e.user);
         Debug.trace('************************************', Debug.LEVEL_ERROR);
         registrarAudio(e.user);
     }

     private function registroTWTCompletado(e:InicioEvent){
         Debug.trace('Registro TWT completado: '+e.user);
         _twt.comparte();
         registrarAudio(e.user);
     }

     public function onMicro(){

         // Configuro el micrófono
         Debug.trace('GRABO: '+_mensaje);
         m = Microphone.getMicrophone();
         m.rate = 44;
         m.setUseEchoSuppression(true);
         m.setSilenceLevel(5, 1000);
         seg = 10;
         nc.client = { onBWDone: function():void{} };
         //nc.objectEncoding = ObjectEncoding.AMF3;
         nc.addEventListener( NetStatusEvent.NET_STATUS , netStatus);
         nc.connect( _servidor , true);
     }


    public function pintaPin(_dato:String):void
    {
        Debug.trace('[5]');
        _twt.pintaPin(_dato);
    }


    public function equalizar(){
        _this.equaliza_mc.visible = true;
        TweenMax.to(_this.equaliza_mc, 0.7, {alpha: 1});
        _this.crono_txt.visible = true;
        TweenMax.to(_this.crono_txt, 0.7, {alpha: 1});
        myTimer2 = new Timer(50);
        myTimer2.addEventListener("timer",timerHandler);
        myTimer2.start(); // start timer
    }

    private function timerHandler(e:TimerEvent):void{
        _this.equaliza_mc.azul_mc.rotation = m.activityLevel;
        _this.equaliza_mc.rojo_mc.rotation = -m.activityLevel;
        _this.equaliza_mc.verde_mc.rotation = -m.activityLevel;
        _this.equaliza_mc.crema_mc.rotation = m.activityLevel;
    }

    private function netStatus(event:NetStatusEvent)
    {
        if (event.info.code == "NetConnection.Connect.Success")
        {
            Debug.trace('INIT GRABACION');
            equalizar();
            myTimer = new Timer(delay,repeat);
            myTimer.start();
            myTimer.addEventListener(TimerEvent.TIMER, crono);
            myTimer.addEventListener(TimerEvent.TIMER_COMPLETE, grabacionCompleta);
            ns = new NetStream(nc);
            ns.client = red5;
            ns.attachAudio(m);
            ns.publish("km_"+_mensaje,"record");
            recording = true;

            red5.onPlayStatus = function(myPBstatus:Object):void{
                trace(myPBstatus["code"]);
            };

            red5.onMetaData = function(myMeta:Object):void{

            };
        } else {
            trace(event.info.application);
        }
    }

     private function crono(e:TimerEvent)
     {
        if (seg != -1)
        {
            _this.crono_txt.text = String(seg)+'s';
        }
        seg--;
     }

    private function grabacionCompleta(e:TimerEvent=null)
    {
       if (ns)
       {
           ns.close();
           myTimer.stop();
           myTimer.removeEventListener(TimerEvent.TIMER, crono);
           myTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, grabacionCompleta);
           myTimer2.removeEventListener("timer",timerHandler);
           _this.texto_txt.htmlText = 'ESCUCHA\n TU MENSAJE';
           _this.texto_txt.visible = true;
           _this.continue_mc.visible = true;
           _this.atras_mc.visible = true;
           _this.btn_play.visible = true;
           TweenMax.to(_this.btn_play, 0.7, {alpha: 1});
           TweenMax.to(_this.texto_txt, 0.7, {alpha: 1});
           TweenMax.to(_this.continue_mc, 0.7, {alpha: 1});
           TweenMax.to(_this.atras_mc, 0.7, {alpha: 1});
           TweenMax.to(_this.equaliza_mc, 0.7, {alpha: 0, onComplete:function(){_this.equaliza_mc.visible = false;}});
           TweenMax.to(_this.crono_txt, 0.7, {alpha: 0, onComplete:function(){_this.crono_txt.visible = false;}});
        }
        recording = false;
    }

    private function previo(evt:MouseEvent)
    {

        _this.btn_play.icono_mc.gotoAndStop(2);
        nc = new NetConnection();
        nc.client = { onBWDone: function():void{} };
        //nc.objectEncoding = ObjectEncoding.AMF3;
        nc.addEventListener( NetStatusEvent.NET_STATUS , netStatus);
        nc.connect(_servidor, false);

        function netStatus(event:NetStatusEvent)
        {
            if (event.info.code == "NetConnection.Connect.Success")
            {
                ns = new NetStream(nc);
                ns.client = red5;

                ns.play("km_"+_mensaje+".flv");

                red5.onPlayStatus = function(myPBstatus:Object):void{
                    if(myPBstatus["code"] == "NetStream.Play.Complete"){
                        _this.btn_play.icono_mc.gotoAndStop(1);
                    }
                };
                red5.onMetaData = function(myMeta:Object):void{

                };
            }
        }
    }

    public function set mensaje(valor:String){
        _mensaje = valor;
    }

    public function get mensaje():String{
        return _mensaje;
    }


    public function registrarAudio(usuario:Object):void
    {
        if(_twt){
            _twt.removeEventListener(InicioEvent.TWTMICRO,registroTWTCompletado);
        } else if(_fb){
            _fb.removeEventListener(InicioEvent.FBMICRO,registroFBCompletado);
        }

        var envio:Object = new Object();

        if(usuario.tipo == 'fb'){
            envio.id_clip = _mensaje;
            envio.nombre = usuario.nombre;
            envio.apellidos = usuario.apellidos;
            envio.id_social = usuario.id;
            envio.red_social = usuario.red_social;
            envio.aprobado = 0;
        } else if(usuario.tipo == 'twt'){
            envio.id_clip = _mensaje;
            envio.nombre = usuario.nombre;
            envio.apellidos = usuario.apellidos;
            envio.id_social = usuario.id;
            envio.red_social = usuario.red_social;
            envio.aprobado = 0;
        }

        Debug.traceObj(Object(envio));
        cn = new NetConnection();
        cn.connect(GATEWAY);
        cn.call('ContactService.registraAudio', new Responder(respuestaAudio), envio);
    }

    private function respuestaAudio(datos:Object):void
    {
        Debug.trace(datos, Debug.LEVEL_ERROR);
        _this.texto_txt.htmlText = 'MENSAJE\nGRABADO\nCORRECTAMENTE';
        TweenMax.to(_this.fondo_mc.color_mc, 0.7, {tint: 0xD34D4A});
    }
        
    private function ajusta(e:Event):void
    {
        if(_this.getChildByName('cajapin'))
        {
           // _cajapin.ajusta(_this.stage.stageWidth, _this.stage.stageHeight);
            _cajapin.x = 0;
            _cajapin.y = - MovieClip(parent).y + (_this.stage.stageHeight/2);
        }
    }

  }

}
