/**
 * Created by IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 01/05/12
 * Time: 21:24
 * To change this template use File | Settings | File Templates.
 */
package assets.rub.clases {

import com.hexagonstar.util.debug.Debug;
import com.swfjunkie.tweetr.Tweetr;
import com.swfjunkie.tweetr.events.TweetEvent;
import com.swfjunkie.tweetr.oauth.OAuth;
import com.swfjunkie.tweetr.oauth.events.OAuthEvent;

import events.ControlEvent;
import events.InicioEvent;
import events.PreguntasEvent;

import flash.events.EventDispatcher;

import flash.system.Security;

public class TwTMicrofono extends EventDispatcher{

    private var oauth:OAuth;
    private var usuario:Tweetr;
    private var user:Object;
    private var _link:String = 'http://www.tourflex.es';
    private var _texto:String = 'He grabado mi mensaje de ánimo a Alberto Contador para completar la etapa reina del Tour que le quitaron';

    public function TwTMicrofono() {
    }


    public function init():void
    {
        Security.loadPolicyFile('http://a0.twimg.com/crossdomain.xml');

        dispatchEvent(new PreguntasEvent(PreguntasEvent.PIN_TWT));

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
        Debug.trace('[PINTO_PIN]', Debug.LEVEL_ERROR);
        
        dispatchEvent(new ControlEvent(ControlEvent.LOADER_LOGIN));
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
        usuario.removeEventListener(TweetEvent.COMPLETE, estado);

        Debug.traceObj(Object(e.responseArray)[0]);

        var resp:Object = new Object();
        resp = Object(e.responseArray)[0];

        user = new Object();
		var _ds:Array = new Array();
		_ds = String(resp.name).split(' ') ;
        user.nombre =  _ds[0];

        if(_ds[1] == undefined || _ds[1] == 'undefined' || _ds[1] == null || _ds[1] == 'null'){
            user.apellidos = '';
        } else {
            user.apellidos =  _ds[1];
        }

        user.ciudad = resp.location;
        user.id = resp.id;
        user.red_social = 1;
        user.aprobado = 0;
        user.seleccionado = 0;
        user.foto = resp.profileImageUrl;
        user.tipo = 'twt';
        

        Debug.traceObj(user);


        var _evento:InicioEvent = new InicioEvent(InicioEvent.TWTMICRO);
        _evento.user = user;
        dispatchEvent(_evento);

    }
}
}
