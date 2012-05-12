/**
 * Created with IntelliJ IDEA.
 * User: rubenmorato
 * Date: 22/04/12
 * Time: 21:11
 * To change this template use File | Settings | File Templates.
 */
package assets.rub.clases {
public class TrackingVideo {
    public function TrackingVideo() {
    }

    protected var footage : Footage;

    protected var sourceBitmapOriginal : BitmapData;
    protected var sourceBitmap : BitmapData;

    protected var container : Sprite;

    protected var frameNum : int = 15;
    protected var frame : int;

    protected var pt1 : Point;
    protected var pt2 : Point;
    protected var pt3 : Point;
    protected var pt4 : Point;
    protected var g : Graphics;

    protected var p1X : Vector.<Number>;
    protected var p1Y : Vector.<Number>;
    protected var p2X : Vector.<Number>;
    protected var p2Y : Vector.<Number>;
    protected var p3X : Vector.<Number>;
    protected var p3Y : Vector.<Number>;
    protected var p4X : Vector.<Number>;
    protected var p4Y : Vector.<Number>;

    private var url:String = "xml/test.xml";

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

    protected var scale : Number = 1;

    private var _sms:SMS = new SMS();

    private var _seekBar:Seekbar_mc;

    //private var _video:Video_mc = new Video_mc();


    public function Main() {
        addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
    }

    //
    // PRIVATE, PROTECTED
    //______________________________________________________________________

    private function crearSeekBar(){
        _seekBar = new Seekbar_mc();
        _seekBar.boton_mc.addEventListener("mouseDown", md);
        _seekBar.boton_mc.addEventListener("mouseUp", mu);

        _seekBar.x = 200;
        _seekBar.y = 400;
        addChild(_seekBar);

        this.addEventListener(Event.ENTER_FRAME, mover);

        function mover(evt:Event)
        {
            var porcen_barra:int = (_seekBar.boton_mc.x* 100)/_seekBar.linea_mc.width;
            footage.gotoAndStop(Math.round((footage.totalFrames* porcen_barra)/100));

            /*var dato:int = (Math.round((15* porcen_barra)/100));
             _video.mover(dato);
             trace(dato);*/
        }

        function md(evt:*):void
        {
            _seekBar.boton_mc.startDrag(false, new Rectangle(_seekBar.linea_mc.x, _seekBar.linea_mc.y, _seekBar.linea_mc.width, 0));
        }

        function mu(evt:*):void
        {
            _seekBar.boton_mc.stopDrag();
        }
    }

    protected function addedToStageHandler(e : Event) : void {
        removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);

        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;

        init();
    }

    protected function init() : void {
        addContainers();
        setProperties();
        setMotionTrackingData();
        crearSeekBar();
        trace('ENTRO');
        // Render on change of frame
        addEventListener(Event.EXIT_FRAME, exitFrameHandler);
    }

    protected function addContainers() : void {
        footage = new Footage();
        //_video = new Video_mc();
        addChild(footage);
        _sms.visible = false;
        addChild(_sms);
        container = new Sprite();
        addChild(container);
        container.addEventListener(MouseEvent.CLICK, clickHandler);
        container.buttonMode = true;
        container.blendMode = BlendMode.MULTIPLY;

        // Set scale
        footage.scaleX = footage.scaleY = scale;
        container.scaleX = container.scaleY = scale;


        // Debug
        var stats : Stats = new Stats();
        addChild(stats);
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
            var peticion:URLRequest = new URLRequest(url);
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
            for (var i:int = 0; i < puntos.coords.coord.length(); i++)
            {
                _array =  new Array();
                _texto = String(puntos.coords.coord[i]);
                _array = _texto.split(";");
                _track1.push(_array[0]);
                _track2.push(_array[1]);
                _track3.push(_array[2]);
                _track4.push(_array[3]);

                if (i > 0 && i< frameNum)
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

    protected function exitFrameHandler(event : Event) : void {
        frame = footage.currentFrame - 1;
        render();
    }

    protected function render() : void {

        var caca:Picture1 = new Picture1();
        var myBitmapData:BitmapData = new BitmapData(caca.width, caca.height);
        myBitmapData.draw(caca);


        if (Boolean(sourceBitmap)) sourceBitmap.dispose();
        sourceBitmap = myBitmapData.clone();

        // Update triangles
        pt1.x = p1X[frame];
        pt1.y = p1Y[frame];
        pt2.x = p2X[frame];
        pt2.y = p2Y[frame];
        pt3.x = p3X[frame];
        pt3.y = p3Y[frame];
        pt4.x = p4X[frame];
        pt4.y = p4Y[frame];

        // SEGUIMIENTO MENU
        _sms.x = p4X[frame] + 50;
        _sms.y = p1Y[frame];


        drawPlane(g, sourceBitmap, pt1, pt2, pt3, pt4);
    }

    protected function clickHandler(e : MouseEvent) : void {
        if(_sms.visible == true){
            _sms.visible = false;
        } else {
            _sms.visible = true;
        }
    }

}
}
