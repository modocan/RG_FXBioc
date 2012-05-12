package assets.rub.clases  {
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	
	public class Video_mc extends Sprite{
		
		private var _videoRot:VideoRotator;
		
		public function Video_mc():void 
		{
			_videoRot = new VideoRotator("../embed/footage2.flv");
			_videoRot.addEventListener(Event.COMPLETE, videoLoaded);
			_videoRot.addEventListener(ProgressEvent.PROGRESS, videoPreloader);
		}
		
		private function videoPreloader(e:ProgressEvent):void 
		{
			//update the textfield with the preloading info
			//_loaderText.text = VideoRotator(e.target).percentLoaded.toString() + "% loaded";
		}
		
		private function videoLoaded(e:Event):void 
		{
			//_videoRot.removeEventListener(ProgressEvent.PROGRESS, videoPreloader);
			//stage.addEventListener(Event.ENTER_FRAME, mover);
			addChild(_videoRot);
		}
		
		public function mover(valor:int):void 
		{
			//_videoRot.rotateObject((mouseX -stage.stageWidth / 2) / 2000);
			//_videoRot.rotateObject(44);
			trace('valor: '+valor);
			//_videoRot.netStreamSeek(valor);
			_videoRot.rotateObject(valor);
			//_videoRot.rotateObject((mouseX -stage.stageWidth / 2) / 2000);
		}
	}
	
}
