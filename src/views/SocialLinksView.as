/**
 * Created with IntelliJ IDEA.
 * User: rubenmorato
 * Date: 20/04/12
 * Time: 14:46
 * To change this template use File | Settings | File Templates.
 */
package views {
import events.MenuEvent;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class SocialLinksView extends Sprite {

    private var clip:SocialLinks;

    public function SocialLinksView() {

        clip = new SocialLinks();
        clip.addEventListener(Event.ADDED_TO_STAGE, init);
        addChild(clip);
    }


    private function init(e:Event):void
    {
        clip.removeEventListener(Event.ADDED_TO_STAGE, init);

        for(var i:int=0; i < clip.numChildren; i++)
        {
            if(clip.getChildAt(i) is MovieClip)
            {
                MovieClip(clip.getChildAt(i)).buttonMode = true;
                MovieClip(clip.getChildAt(i)).addEventListener(MouseEvent.CLICK, clicSocial);
            }
        }
    }


    private function clicSocial(e:MouseEvent):void
    {
         var evento:MenuEvent = new MenuEvent(MenuEvent.CLICK_SOCIAL);
        evento.quien = e.currentTarget.name;
        this.dispatchEvent(evento);
    }

}
}
