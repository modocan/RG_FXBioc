/**
 * Created with IntelliJ IDEA.
 * User: rubenmorato
 * Date: 24/04/12
 * Time: 01:27
 * To change this template use File | Settings | File Templates.
 */
package assets.rub.clases {

import gs.TweenMax;
import com.hexagonstar.util.debug.Debug;
import com.zehfernando.display.drawPlane;

import events.InicioEvent;

import flash.display.BitmapData;
import flash.display.BlendMode;
import flash.display.Graphics;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.IEventDispatcher;
import flash.events.EventDispatcher;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.net.URLLoader;
import flash.net.URLRequest;


public class BotonTRack extends MovieClip{



    protected var sourceBitmapOriginal : BitmapData;
    protected var sourceBitmap : BitmapData;

    protected var container : Sprite;

    protected var frameNum : int = 900;

    protected var pt1 : Point;
    protected var pt2 : Point;
    protected var pt3 : Point;
    protected var pt4 : Point;
    protected var g : Graphics;

    public var p1X : Vector.<Number>;
    protected var p1Y : Vector.<Number>;
    protected var p2X : Vector.<Number>;
    protected var p2Y : Vector.<Number>;
    protected var p3X : Vector.<Number>;
    protected var p3Y : Vector.<Number>;
    protected var p4X : Vector.<Number>;
    protected var p4Y : Vector.<Number>;

    private var _url:String;
    private var XmlExterno:XML;

    private var _track1:Array = new Array();
    private var _track2:Array = new Array();
    private var _track3:Array = new Array();
    private var _track4:Array = new Array();
    private var _array:Array =  new Array();
    private var _texto:String;

    private var _p1:Array = new Array();
    private var _p2:Array = new Array();
    private var _p3:Array = new Array();
    private var _p4:Array = new Array();

    private var _duplicado:Picture1;


    public function BotonTRack() {
        _duplicado  = new Picture1();
    }

    public function init(_ruta:String){

        _url = "xml/"+_ruta+'.xml';
        this.alpha = 0;
        this.visible = false;
        this.addEventListener(MouseEvent.ROLL_OVER, sobre);
        this.addEventListener(MouseEvent.ROLL_OUT, fuera);
        this.addEventListener(MouseEvent.CLICK, cargar);
        addContainers();
        setProperties();
        setMotionTrackingData();
    }

    public function mostrar(){

        this.visible = true;
        TweenMax.to(this, 0.7, {alpha: 1});
    }

    protected function addContainers() : void {
        addChild(_duplicado);
        container = new Sprite();
        addChild(container);
    }

    protected function setProperties() : void {

        // Points reference
        pt1 = new Point(0.0, 0.0);
        pt2 = new Point(0.0, 0.0);
        pt3 = new Point(0.0, 0.0);
        pt4 = new Point(0.0, 0.0);

        // Graphic reference
        g = container.graphics;
    }

    private function cargar(evt:MouseEvent){
        Debug.trace('Cargar tramo: '+evt.currentTarget.name);
        var evento:InicioEvent = new InicioEvent(InicioEvent.ABRIR_TRAMO);
        evento.quien = evt.currentTarget.name;
        dispatchEvent(evento);
    }

    private function sobre(evt:MouseEvent){

        _duplicado.gotoAndPlay('entrada');
    }

    private function fuera(evt:MouseEvent){

        _duplicado.gotoAndPlay('salida');
    }

    protected function setMotionTrackingData() : void {

        p1X = new Vector.<Number>(frameNum + 1, true);
        p1Y = new Vector.<Number>(frameNum + 1, true);
        p2X = new Vector.<Number>(frameNum + 1, true);
        p2Y = new Vector.<Number>(frameNum + 1, true);
        p3X = new Vector.<Number>(frameNum + 1, true);
        p3Y = new Vector.<Number>(frameNum + 1, true);
        p4X = new Vector.<Number>(frameNum + 1, true);
        p4Y = new Vector.<Number>(frameNum + 1, true);

        function CargarXML()
        {
            var loader:URLLoader = new URLLoader();
            ponerListeners(loader);
            var peticion:URLRequest = new URLRequest(_url);
            loader.load(peticion);
        }

        function ponerListeners(dispatcher:IEventDispatcher):void
        {
            dispatcher.addEventListener(Event.COMPLETE, completeHandler);
        }

        function completeHandler(event:Event):void
        {

            XML.ignoreWhitespace = true;
            var puntos:XML = new XML(event.target.data);

            for (var i:int = 300; i < (puntos.coords.coord.length()+300); i++)
            {
                _array =  new Array();
                _texto = String(puntos.coords.coord[i-300]);
                _array = _texto.split(";");
                _track1.push(_array[0]);
                _track2.push(_array[1]);
                _track3.push(_array[2]);
                _track4.push(_array[3]);

                if (i< frameNum)
                {
                    _p1 = _array[0].split(',');
                    p1X[i] = _p1[0];
                    p1Y[i] = _p1[1];
                    _p2 = _array[1].split(',');
                    p2X[i] = _p2[0];
                    p2Y[i] = _p2[1];
                    _p3 = _array[2].split(',');
                    p3X[i] = _p3[0];
                    p3Y[i] = _p3[1];
                    _p4 = _array[3].split(',');
                    p4X[i] = _p4[0];
                    p4Y[i] = _p4[1];
                }
                else
                {
                    p1X[0] = p1Y[0] = 0.0;
                    p2X[0] = p2Y[0] = 0.0;
                    p3X[0] = p3Y[0] = 0.0;
                    p4X[0] = p4Y[0] = 0.0;
                }
            }

        }

        CargarXML();

    }

    public function render(_frame:Number = 0) : void {



        /*var myBitmapData:BitmapData = new BitmapData(_duplicado.width, _duplicado.height);
        myBitmapData.draw(_duplicado);

        if (Boolean(sourceBitmap)) sourceBitmap.dispose();
        sourceBitmap = myBitmapData.clone();   */

        // Update triangles
        pt1.x = p1X[_frame];
        pt1.y = p1Y[_frame];
        pt2.x = p2X[_frame];
        pt2.y = p2Y[_frame];
        pt3.x = p3X[_frame];
        pt3.y = p3Y[_frame];
        pt4.x = p4X[_frame];
        pt4.y = p4Y[_frame];

        _duplicado.x = p1X[_frame];
        _duplicado.y = p1Y[_frame];

        //drawPlane(g, sourceBitmap, pt1, pt2, pt3, pt4);
    }

}
}
