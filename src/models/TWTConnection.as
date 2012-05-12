/**
 * Created by IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 24/04/12
 * Time: 02:57
 * To change this template use File | Settings | File Templates.
 */
package models {
import com.hexagonstar.util.debug.Debug;
import com.swfjunkie.tweetr.Tweetr;
import com.swfjunkie.tweetr.events.TweetEvent;
import com.swfjunkie.tweetr.oauth.OAuth;
import com.swfjunkie.tweetr.oauth.events.OAuthEvent;

import events.ControlEvent;
import events.PreguntasEvent;

import flash.system.Security;

import org.robotlegs.mvcs.Actor;

public class TWTConnection extends Actor implements ITWTConnection {

    private var oauth:OAuth;
    private var usuario:Tweetr;
    private var user:Object;
    private var _link:String = 'http://www.tourflex.es';
    private var _texto:String = 'He por escrito mi mensaje de ánimo a Alberto Contador para completar la etapa reina del Tour que le quitaron';

    public function TWTConnection() {
        super();
    }
    public function init():void
    {
        Security.loadPolicyFile('http://a0.twimg.com/crossdomain.xml');

        eventDispatcher.dispatchEvent(new PreguntasEvent(PreguntasEvent.PIN_TWT));

        usuario = new Tweetr();
        usuario.serviceHost = "http://tweetr.swfjunkie.com/proxy";
        usuario.addEventListener(TweetEvent.COMPLETE, estado);
        usuario.addEventListener(TweetEvent.FAILED, estado);

        oauth = new OAuth();
        oauth.consumerKey = "GKDQc7U82yCMFLOUtKQ";
        oauth.consumerSecret = "e4SAdCRt2jYNfAizZCjf3N9Jocs1SGbH9O8exQRBorQ";
        oauth.serviceHost = "http://tweetr.swfjunkie.com/proxy";
        oauth.pinlessAuth = true;
        oauth.addEventListener(OAuthEvent.COMPLETE, handleOAuthEvent);
        oauth.addEventListener(OAuthEvent.ERROR, handleOAuthEvent);

        oauth.getAuthorizationRequest();
    }


    public function pintaPin(code:String):void
    {
        eventDispatcher.dispatchEvent(new ControlEvent(ControlEvent.LOADER_LOGIN));
        oauth.requestAccessToken(code);
    }


    private function handleOAuthEvent(event:OAuthEvent):void
    {

        if (event.type == OAuthEvent.COMPLETE){
            Debug.inspect(event);
            usuario.oAuth = oauth;
            
            usuario.getUserDetails(oauth.userId);

        } else {
            Debug.inspect(event);
        }
    }


    public function comparte():void
    {
        usuario.removeEventListener(TweetEvent.COMPLETE, estado);
        usuario.removeEventListener(TweetEvent.FAILED, estado);
        

        usuario.updateStatus(_texto + ' ' + _link);
    }


    private function estado(e:TweetEvent):void
    {
        //usuario.removeEventListener(TweetEvent.COMPLETE, estado);
        
        Debug.traceObj(Object(e.responseArray)[0]);
        
        var resp:Object = new Object();
        resp = Object(e.responseArray)[0];
        
        user = new Object();
        user.nombre =  Array(String(resp.name).split(' '))[0][0];
        
        if(Array(String(resp.name).split(' '))[0][1] == undefined || Array(String(resp.name).split(' '))[0][1] == 'undefined' || Array(String(resp.name).split(' '))[0][1] == null || Array(String(resp.name).split(' '))[0][1] == 'null'){
            user.apellidos = '';
        } else {
            user.apellidos =  Array(String(resp.name).split(' '))[0][1];
        }

        user.ciudad = resp.location;
        user.id = resp.id;
        user.red_social = 1;
        user.aprobado = 0;
        user.seleccionado = 0;
        user.foto = resp.profileImageUrl;

        var evento:ControlEvent = new ControlEvent(ControlEvent.ACTUALIZA_USUARIO);
        evento.datos.usuario = user;
        //evento.datos.tipo = 'twt';
        eventDispatcher.dispatchEvent(evento);

    }

}
}
