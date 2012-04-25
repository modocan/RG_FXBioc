/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 21/04/12
 * Time: 16:34
 * To change this template use File | Settings | File Templates.
 */
package models {

import com.facebook.graph.Facebook;
import com.hexagonstar.util.debug.Debug;

import events.ControlEvent;

import flash.system.Security;

import org.robotlegs.mvcs.Actor;

public class FBConnection extends Actor implements IFBConnection {

    private const APP_ID:String = '379870635390403';
    private var usuario:Object;

    public function FBConnection() {
        super();

        Security.loadPolicyFile('http://api.facebook.com/crossdomain.xml');
        Security.loadPolicyFile('http://profile.ak.fbcdn.net/crossdomain.xml');
        Security.allowDomain('http://profile.ak.fbcdn.net');
        Security.allowInsecureDomain('http://profile.ak.fbcdn.net');

    }

    public function init():void
    {
        eventDispatcher.dispatchEvent(new ControlEvent(ControlEvent.LOADER_LOGIN));
        Facebook.init(APP_ID, respInit);
        Facebook.login(handleLogin, {perms: 'publish_stream, user_hometown'});

    }


    private function respInit(success:Object, fail:Object):void
    {
        if(success)
        {
           Debug.traceObj(success);
        }

        if(fail){
            Debug.traceObj(fail);
        }
    }


    private function handleLogin(response:Object, fail:Object):void
    {
        if(response)
        {
            Facebook.api('me', function(success:Object, fail:Object){
                if(success){
                   usuario = new Object();
                   usuario.nombre = success.first_name;
                   usuario.apellidos = success.last_name;
                   usuario.id = success.id;
                   usuario.ciudad = Array(String(success.hometown.name).split(','))[0][0];
                   usuario.red_social = 0;
                   usuario.aprobado = 0;
                   usuario.seleccionado = 0;
                   usuario.foto = 'http://graph.facebook.com/' + success.id + '/picture?type=large';

                   var evento:ControlEvent = new ControlEvent(ControlEvent.ACTUALIZA_USUARIO);
                   evento.datos.usuario = usuario;
                   eventDispatcher.dispatchEvent(evento);
                }
            });
        }

        if(fail){
            Debug.traceObj(fail);
        }
    }

}
}
