/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 20/04/12
 * Time: 12:33
 * To change this template use File | Settings | File Templates.
 */
package views {


import com.greensock.TweenLite;
import com.greensock.TweenMax;
import com.greensock.easing.Circ;
import com.hexagonstar.util.debug.Debug;

import events.MenuEvent;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextFieldAutoSize;



public class MenuView extends Sprite {

    private var item:BtnMenu;
    private var bici:BiciMenu;
    private var _this;

    public function MenuView() {
          _this = this;
    }

    public function creaItems(listado:Array):void
    {
        for(var i:int = 0; i < listado.length; i++)
        {
            item = new BtnMenu();
            item.name = String(listado[i]);
            item.mouseChildren = false;
            item.buttonMode = true;
            item.texto_txt.text = listado[i];
            item.texto_txt.autoSize = TextFieldAutoSize.CENTER;
            item.texto_txt.x = -(item.texto_txt.width/2);
            item.addEventListener(MouseEvent.CLICK, clicMenu);
            if(i > 0)
            {
                item.x = this.getChildAt(i-1).x + this.getChildAt(i-1).width + (item.width/2) + 20;
            }
            addChild(item);
        }


        bici = new BiciMenu();
        bici.y = -5;
        addChild(bici);
    }


    private function clicMenu(e:MouseEvent):void
    {
        trace('click');

        Debug.trace('click');

        var evento:MenuEvent = new MenuEvent(MenuEvent.CLICK_MENU);
        evento.quien = e.currentTarget.name;
        _this.dispatchEvent(evento);

        mueveBici(e.currentTarget.name);
    }


    private function mueveBici(_cual:String):void
    {
        var cual:BtnMenu = BtnMenu(this.getChildByName(_cual));
        TweenLite.to(bici,  1, {x: cual.x, ease:Circ.easeOut});
    }


}
}
