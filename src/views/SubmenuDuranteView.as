/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 13/05/12
 * Time: 17:53
 * To change this template use File | Settings | File Templates.
 */
package views {
import assets.clases.Banderita;

import events.MenuEvent;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class SubmenuDuranteView extends Sprite {

    private var _this:SubmenuDuranteView;
    private var _clip:SubmenuDurante;

    public function SubmenuDuranteView() {
        _this = this;
        _this.addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e:Event):void {
        _this.removeEventListener(Event.ADDED_TO_STAGE, init);

        _clip = new SubmenuDurante();
        for(var i:int=0; i < _clip.numChildren; i++)
        {
            if(_clip.getChildAt(i) is Banderita)
            {
                if(Banderita(_clip.getChildAt(i)).name != 'momentos')
                {
                    Banderita(_clip.getChildAt(i)).init(i);
                    Banderita(_clip.getChildAt(i)).addEventListener(MouseEvent.CLICK, clicBandera);
                } else {
                    Banderita(_clip.getChildAt(i)).init(i);
                    Banderita(_clip.getChildAt(i)).elegido();
                }

            }
        }
        addChild(_clip);
    }

    private function clicBandera(e:MouseEvent):void {
        for(var i:int=0; i < _clip.numChildren; i++)
        {
            if(_clip.getChildAt(i) is Banderita)
            {
                Banderita(_clip.getChildAt(i)).libre();
                Banderita(_clip.getChildAt(i)).addEventListener(MouseEvent.CLICK, clicBandera);
            }
        }
        Banderita(e.currentTarget).elegido();
        Banderita(e.currentTarget).removeEventListener(MouseEvent.CLICK, clicBandera);

        var evento:MenuEvent = new MenuEvent(MenuEvent.CLICK_MENU);
        evento.quien = e.currentTarget.name;
        _this.dispatchEvent(evento);

        trace('[PIDO] -> ' + e.currentTarget.name);
    }

}
}
