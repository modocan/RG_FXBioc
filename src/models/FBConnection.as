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

import flash.external.ExternalInterface;

import flash.system.Security;

import org.robotlegs.mvcs.Actor;

public class FBConnection extends Actor implements IFBConnection {

    private const APP_ID:String = '379870635390403';
    private var usuario:Object;
    private var _caption:String = 'www.tourflex.es';
    private var _description:String = '¡Dale ánimos! Lo escuchará en directo durante la carrera.';
    private var _name:String = 'Alberto Contador correrá la etapa reina del Tour que le quitaron.';
    private var _link:String = 'http://www.tourflex.es';
    private var _picture:String = 'http://www.flex.es/tourflex/imgs/tourflex_90x90.jpg';
    private var _texto:String = 'Acabo de dejar por escrito mi mensaje de ánimo a Alberto Contador. ¡Dale fuerzas para completar la etapa reina del Tour que le quitaron tú también!';
    private var caption_post:String = 'www.tourflex.es';

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
        /*Facebook.init(APP_ID, handleLogin);
        Facebook.login(handleLogin, {perms: 'publish_stream, user_hometown'});*/

        ExternalInterface.addCallback('reciboDatos', recibeUsuario) ;

        ExternalInterface.call('conectaFB');

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

                   Debug.traceObj(success);

                   usuario = new Object();

                   usuario.nombre = success.first_name;
                   usuario.apellidos = success.last_name;
                   usuario.id = success.id;
                    if(success.hometown)
                    {
                        usuario.ciudad = Array(String(success.hometown.name).split(','))[0][0]; 
                    } else {
                        usuario.ciudad = '';
                    }
                   
                   usuario.red_social = 0;
                   usuario.aprobado = 0;
                   usuario.seleccionado = 0;
                   usuario.foto = 'http://graph.facebook.com/' + success.id + '/picture?type=large';

                   var evento:ControlEvent = new ControlEvent(ControlEvent.ACTUALIZA_USUARIO);
                   evento.datos.usuario = usuario;
                   eventDispatcher.dispatchEvent(evento);
                }
            });
        }else{

            Facebook.init(APP_ID, handleLogin);
        }
    }


    private function recibeUsuario(success:Object):void
    {
        usuario = new Object();

        usuario.nombre = success.first_name;
        usuario.apellidos = success.last_name;
        usuario.id = success.id;
        if(success.hometown)
        {
            usuario.ciudad = Array(String(success.hometown.name).split(','))[0][0];
        } else {
            usuario.ciudad = '';
        }

        usuario.red_social = 0;
        usuario.aprobado = 0;
        usuario.seleccionado = 0;
        usuario.foto = 'http://graph.facebook.com/' + success.id + '/picture?type=large';

        var evento:ControlEvent = new ControlEvent(ControlEvent.ACTUALIZA_USUARIO);
        evento.datos.usuario = usuario;
        eventDispatcher.dispatchEvent(evento);
    }


    public function comparte(texto:String):void
    {
        var datos:Object = new Object();
        datos.caption = caption_post;
        datos.description = _description;
        datos.name = _name;
        datos.link = _link;
        datos.picture = _picture;
        datos.message = _texto;

        ExternalInterface.call('compartePregunta', datos);


        
        //Facebook.api('feed', function(success:Object, fail:Object){}, {message: _texto, picture: _picture, caption: caption_post, link: _link, name: _name, description: _description}, 'POST');
    }

}
}
