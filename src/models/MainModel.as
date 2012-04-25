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

    private var seccionesFase1:Array = ['INICIO', 'SPOT', 'PREGUNTA A CONTADOR', 'PRODUCTO'];
    private var _usuarioLogin:Object = new Object();
    private var video_spot:String = 'rZPAWyPO2vQ';

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
}
}
