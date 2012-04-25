/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 22/04/12
 * Time: 14:13
 * To change this template use File | Settings | File Templates.
 */
package models {
import com.hexagonstar.util.debug.Debug;

import events.PreguntasEvent;

import flash.net.NetConnection;
import flash.net.Responder;

import org.robotlegs.mvcs.Actor;

public class PreguntasModel extends Actor implements IPreguntasModel {

    private const GATEWAY:String = 'http://www.tourflex.es/amfphp/gateway.php';
    private var cn:NetConnection;

    private var preguntas:Object = new Object();

    public function PreguntasModel() {
        super();
    }


    public function enviaPregunta(usuario:Object, pregunta:String):void
    {
        Debug.trace('[model]');

        var envio:Object = new Object();
        envio.nombre = usuario.nombre;
        envio.apellidos = usuario.apellidos;
        envio.pregunta = pregunta;
        envio.id_social = usuario.id;
        envio.foto = usuario.foto;
        envio.red_social = usuario.red_social;
        envio.aprobado = 0;
        envio.seleccionado = 0;
        envio.ciudad = usuario.ciudad;

        Debug.traceObj(usuario);
        Debug.inspect(envio);

        cn = new NetConnection();
        cn.connect(GATEWAY);
        cn.call('ContactService.registraPregunta', new Responder(respuestaPregunta), envio);
    }

    private function respuestaPregunta(datos:Object):void
    {
        if(datos == 'OK')
        {
            eventDispatcher.dispatchEvent(new PreguntasEvent(PreguntasEvent.PREGUNTA_REGISTRADA));
            // TODO generar post en Facebook
        }
    }


    public function damePreguntas():void
    {
        cn = new NetConnection();
        cn.connect(GATEWAY);
        cn.call('ContactService.damePreguntas', new Responder(respuesta));

        function respuesta(datos:Object):void
        {
            if(datos != 'KO'){
                preguntas = datos;

                var evento:PreguntasEvent = new PreguntasEvent(PreguntasEvent.LUMINARIAS_RECIBIDAS);
                evento.datos = preguntas;
                eventDispatcher.dispatchEvent(evento);
            }

        }
    }


}
}
