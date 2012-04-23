/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 19/04/12
 * Time: 22:25
 * To change this template use File | Settings | File Templates.
 */
package views {
import com.greensock.TweenLite;

import flash.display.Sprite;
import flash.events.Event;

public class MainView extends Sprite {

    private var marco:Marco;
    private var bisel:BiselMenu;
    private var logo:Logo;
    private var logo_flex:LogoFlex;
    private var menu:MenuView;
    private var social:SocialLinksView;
    private var login_loader:CargandoLogin;

    public function MainView() {
        this.name = 'marco';
        this.addEventListener(Event.ADDED_TO_STAGE, init);
    }


    private function init(e:Event):void
    {
        this.removeEventListener(Event.ADDED_TO_STAGE, init);
        this.stage.addEventListener(Event.RESIZE, ajusta);

        marco = new Marco();
        marco.name = 'marco';
        marco.width = this.stage.stageWidth - 40;
        marco.height = this.stage.stageHeight - 100;
        marco.x = 20;
        marco.y = this.stage.stageHeight - (marco.height + 40);
        addChild(marco);

        logo = new Logo();
        logo.name = 'logo';
        logo.x = marco.x + marco.width - ((logo.width/2) + 10);
        logo.y = marco.y - 15;
        addChild(logo);

        logo_flex = new LogoFlex();
        logo_flex.name = 'logo_flex';
        logo_flex.x = logo.x + (logo_flex.width/2);
        logo_flex.y = marco.y + marco.height + 3;
        addChild(logo_flex);

        menu = new MenuView();
        menu.name = 'menu';
        addChild(menu);

        social = new SocialLinksView();
        social.name = 'social';
        social.x = marco.x - 8;
        social.y = marco.y + marco.height + 6;
        addChild(social);

        bisel = new BiselMenu();
        bisel.name = 'bisel';
        bisel.x = marco.x - 5;
        bisel.y = marco.y - (bisel.height/2);
        bisel.width = marco.width + 10;
        addChild(bisel);
    }


    public function pintaMenu():void
    {
        menu.x = marco.x + 50;
        menu.y = marco.y - 15;

    }


    public function creaCargandoLogin():void
    {
        login_loader = new CargandoLogin();
        login_loader.name = 'login_loader';
        login_loader.alpha = 0;
        login_loader.fondo.width = marco.width;
        login_loader.fondo.height = marco.height;
        login_loader.texto.x =  (login_loader.fondo.width/2) - (login_loader.texto.width/2);
        login_loader.texto.y =  (login_loader.fondo.height/2) - (login_loader.texto.height/2);
        login_loader.x = marco.x;
        login_loader.y = marco.y;
        login_loader.addEventListener(Event.ADDED_TO_STAGE, function(e:Event){
            TweenLite.to(login_loader, 0.4, {alpha: 1});
        }) ;
        addChild(login_loader);
    }


    public function borrarCargandoLogin():void
    {
        TweenLite.to(login_loader, 0.4, {alpha: 0, onComplete:function(){
            removeChild(login_loader);
        }});
    }



    private function ajusta(e:Event):void
    {
         if(this.getChildByName('marco')){
             marco.width = this.stage.stageWidth - 40;
             marco.height = this.stage.stageHeight - 100;
             marco.x = 20;
             marco.y = this.stage.stageHeight - (marco.height + 40);
         }

         if(this.getChildByName('bisel'))
         {
             bisel.x = marco.x - 10;
             bisel.y = marco.y - (bisel.height/2);
             bisel.width = marco.width + 20;
         }

         if(this.getChildByName('logo'))
         {
             logo.x = marco.x + marco.width - ((logo.width/2) + 10);
             logo.y = marco.y - 15;
         }

         if(this.getChildByName('logo_flex'))
         {
             logo_flex.x = logo.x + (logo_flex.width/2);
             logo_flex.y = marco.y + marco.height + 3;
         }

         if(this.getChildByName('menu'))
         {
             menu.x = marco.x + 50;
             menu.y = marco.y - 15;
         }

         if(this.getChildByName('social'))
         {
             social.x = marco.x - 8;
             social.y = marco.y + marco.height + 4;
         }

         if(this.getChildByName('login_loader'))
         {
             login_loader.fondo.width = marco.width;
             login_loader.fondo.height = marco.height;
             login_loader.texto.x =  (login_loader.fondo.width/2) - (login_loader.texto.width/2);
             login_loader.texto.y =  (login_loader.fondo.height/2) - (login_loader.texto.height/2);
             login_loader.x = marco.x;
             login_loader.y = marco.y;
         }
    }

}
}
