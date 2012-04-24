package assets.clases
{

import assets.clases.eventos.SlideLumiEvent;

import com.hexagonstar.util.debug.Debug;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;

public class SlideLuminaria extends Sprite
{
    private var _this:SlideLuminaria;

    public var tirador:MovieClip;
    public var barra:MovieClip;

    public function SlideLuminaria()
    {
        _this = this;
        tirador.buttonMode = true;
        tirador.addEventListener(MouseEvent.MOUSE_DOWN, down);
    }

    private function down(e:MouseEvent):void
    {
        tirador.startDrag(false, new Rectangle(0, 0, barra.width, 0));
        _this.stage.addEventListener(MouseEvent.MOUSE_MOVE, mueve);
        _this.stage.addEventListener(MouseEvent.MOUSE_UP, suelta);
    }

    private function suelta(e:MouseEvent):void
    {
        _this.stage.removeEventListener(MouseEvent.MOUSE_UP, suelta);
        _this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mueve);

        tirador.stopDrag();
    }

    private function mueve(e:MouseEvent):void
    {
        var porcentaje:Number = (tirador.x * 100) / barra.width;
        var evento:SlideLumiEvent = new SlideLumiEvent(SlideLumiEvent.MOVIMIENTO);
        evento.datos.posicion = porcentaje;
        _this.dispatchEvent(evento);
    }

    public function mueveInverso(movimiento:Number = 0):void
    {
        tirador.x = barra.width - (barra.width * movimiento) / 100;
    }
}

}