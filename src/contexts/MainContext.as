/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 19/04/12
 * Time: 22:15
 * To change this template use File | Settings | File Templates.
 */
package contexts {
import assets.rub.clases.CajaPin;
import assets.rub.clases.Microfono;

import commands.ActualizaUsuarioCommand;
import commands.CambiaSeccionCommand;
import commands.CreaPinCommand;
import commands.CreacionCommand;
import commands.EnviarPreguntaCommand;
import commands.LoginCommand;
import commands.LuminariasCommand;
import commands.PideMenuCommand;
import commands.PidePreguntasCommand;
import commands.PinCommand;
import commands.SubeMarcoCommand;

import events.ControlEvent;
import events.InicioEvent;

import events.MenuEvent;
import events.PreguntasEvent;

import flash.display.DisplayObjectContainer;

import mediators.CajaLoginMediator;
import mediators.CajaPinMediator;
import mediators.CajaTextoMediator;
import mediators.ContenedorElegidosMediator;
import mediators.LuminariasMediator;

import mediators.MainMediator;
import mediators.MenuMediator;
import mediators.RespuestaMediator;
import mediators.SeccionInicioMediator;
import mediators.SeccionPreguntasMediator;
import mediators.SeccionProductoMediator;
import mediators.SeccionRespondeMediator;
import mediators.SeccionSpotMediator;
import mediators.SlideMediator;
import mediators.SocialLinksMediator;
import mediators.VideoProductoMediator;


import models.IMainModel;
import models.IPreguntasModel;
import models.ITWTConnection;
import models.MainModel;
import models.PreguntasModel;
import models.TWTConnection;

import org.robotlegs.base.ContextEvent;
import org.robotlegs.mvcs.Context;

import models.FBConnection;

import models.IFBConnection;

import views.CajaLoginView;
import views.CajaPinView;
import views.CajaTextoView;
import views.ContenedorElegidosView;
import views.LuminariasView;

import views.MainView;
import views.MenuView;
import views.RespuestaView;
import views.SeccionInicioView;
import views.SeccionPreguntaView;
import views.SeccionProductoView;
import views.SeccionRespondeView;
import views.SeccionSpotView;
import views.SlideView;
import views.SocialLinksView;
import views.VideoProductoView;

public class MainContext extends Context {

    public function MainContext(contextView:DisplayObjectContainer=null) {
        super(contextView);
    }

    override public function startup():void
    {
        mapCommands();
        mapModels();
        mapViews();

        super.startup();
    }




    private function mapCommands():void
    {
        commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, CreacionCommand, ContextEvent);
        commandMap.mapEvent(MenuEvent.PIDE_MENU, PideMenuCommand, MenuEvent);
        commandMap.mapEvent(MenuEvent.CLICK_MENU, CambiaSeccionCommand, MenuEvent);
        commandMap.mapEvent(ControlEvent.SECCION, SubeMarcoCommand, ControlEvent);
        commandMap.mapEvent(PreguntasEvent.LOGIN, LoginCommand, PreguntasEvent);
        commandMap.mapEvent(PreguntasEvent.ENVIA_PREGUNTA, EnviarPreguntaCommand, PreguntasEvent);
        commandMap.mapEvent(ControlEvent.ACTUALIZA_USUARIO, ActualizaUsuarioCommand, ControlEvent);
        commandMap.mapEvent(PreguntasEvent.PIDE_LUMINARIAS, LuminariasCommand, PreguntasEvent);
        commandMap.mapEvent(PreguntasEvent.ESCRIBE_PIN, PinCommand, PreguntasEvent);
        commandMap.mapEvent(InicioEvent.TWTPIN, CreaPinCommand, InicioEvent);
        commandMap.mapEvent(PreguntasEvent.PIDE_RESPUESTAS, PidePreguntasCommand, PreguntasEvent);
    }


    private function mapModels():void
    {
        injector.mapSingletonOf(IMainModel, MainModel);
        injector.mapSingletonOf(IFBConnection, FBConnection);
        injector.mapSingletonOf(ITWTConnection, TWTConnection);
        injector.mapSingletonOf(IPreguntasModel, PreguntasModel);
    }

    private function mapViews():void
    {
        mediatorMap.mapView(MenuView, MenuMediator);
        mediatorMap.mapView(MainView, MainMediator);
        mediatorMap.mapView(SocialLinksView, SocialLinksMediator);
        mediatorMap.mapView(SeccionPreguntaView, SeccionPreguntasMediator);
        mediatorMap.mapView(SeccionProductoView, SeccionProductoMediator);
        mediatorMap.mapView(CajaLoginView, CajaLoginMediator);
        mediatorMap.mapView(CajaTextoView, CajaTextoMediator);
        mediatorMap.mapView(RespuestaView, RespuestaMediator);
        mediatorMap.mapView(LuminariasView, LuminariasMediator);
        mediatorMap.mapView(SeccionInicioView, SeccionInicioMediator);
        mediatorMap.mapView(SlideView, SlideMediator);
        mediatorMap.mapView(SeccionSpotView, SeccionSpotMediator);
        mediatorMap.mapView(VideoProductoView, VideoProductoMediator);
        mediatorMap.mapView(CajaPinView, CajaPinMediator);
        mediatorMap.mapView(SeccionRespondeView, SeccionRespondeMediator);
        mediatorMap.mapView(ContenedorElegidosView, ContenedorElegidosMediator);
    }


}
}
