/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 19/04/12
 * Time: 23:57
 * To change this template use File | Settings | File Templates.
 */
package models {

import events.ControlEvent;

import org.robotlegs.mvcs.Actor;

public class MainModel extends Actor implements IMainModel {

    private var seccionesFase1:Array = ['INICIO', 'SPOT', 'HABLA CON CONTADOR', 'WELLNESS BIOCERAMICS ®'];
    private var _usuarioLogin:Object = new Object();
    private var enlace_producto:String = 'http://www.flex.es/flex-bioceramics.html';
    private var video_spot:String = '633STUHKSWs';
    private var video_producto:String = 'oImj9E8IDjo';
    private var enlace_web:String = 'http://www.flex.es';
    private var enlace_bioceramics:String = 'http://www.flex.es/flex-bioceramics.html';

    public function MainModel() {
        super();
    }


    public function dameSecciones():Array
    {
        return seccionesFase1;
    }

    public function dameUsuarioLogin():Object {
        return _usuarioLogin;
    }

    public function usuarioLogin(value:Object):void {
        _usuarioLogin = value;

        var evento:ControlEvent = new ControlEvent(ControlEvent.FIN_LOADER_LOGIN);
        evento.datos = _usuarioLogin;
        eventDispatcher.dispatchEvent(evento);
    }

    public function dameVideoSpot():String
    {
        return video_spot;
    }

    public function dameVideoProducto():String
    {
        return video_producto;
    }

    public function dameEnlaceProducto():String
    {
        return enlace_producto;
    }

    public function dameEnlaceWeb():String
    {
        return enlace_web;
    }

    public function dameEnlaceBioceramics():String
    {
        return enlace_bioceramics;
    }
}
}
