package assets.rub.clases
{
	import flash.display.DisplayObjectContainer;
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	/**
	 * ...
	 * @author Andy Saia
	 */
	public class VideoRotator extends Video
	{
		static public const MIN_SPEED:Number = .02;
		static public const MAX_SPEED:Number = .4;
		
		private var _nc:NetConnection;
		private var _num:Number = 0;
		
		private var _ns:NetStream;		
		private var _clipDuration:Number = 0;
		private var _speed:Number = 0;
		private var _percentLoaded:Number = 0;
		
		public function VideoRotator(videoURL:String):void 
		{
			initVideo();
			connectVideo(videoURL);
			
			this.addEventListener(Event.REMOVED_FROM_STAGE, removeVideo);
		}	
		
		/*******************************Getter and Setters***********************************
		=====================================================================================*/
				public function get clipDuration():Number { return _clipDuration; }
				
				public function get speed():Number { return _speed; }
				
				public function get percentLoaded():Number { return _percentLoaded; }
				
				public function get ns():NetStream { return _ns; }

		
		public function rotateObject(rotateSpeed:Number):void
		{
			
			trace('roto: '+rotateSpeed* 0.1);
			/*if (Math.abs(rotateSpeed) >= MAX_SPEED)
				rotateSpeed = MAX_SPEED;
			if (Math.abs(rotateSpeed) <= MIN_SPEED)
				rotateSpeed = MIN_SPEED;
			
			_speed = rotateSpeed;
			_num += _speed;
			*/
			//_ns.seek(_num);
			//_ns.play();
			//makeClipLoop();
		}
		
		private function initVideo():void 
		{
			_nc = new NetConnection();
			_nc.connect(null);
			_ns = new NetStream(_nc);
		}

		private function connectVideo(url:String):void
		{
			this.attachNetStream(_ns);
			_ns.play(url);
			_ns.addEventListener(AsyncErrorEvent.ASYNC_ERROR, errorCatch);
			
			var customClient:Object = new Object();
			customClient.onMetaData = metaDataHandler;
			_ns.client = customClient;
			_ns.bufferTime = 0;
			
			addEventListener(Event.ENTER_FRAME, updatePreloader);
			function Ahora(event){
			   trace(_ns.time);
			}
			this.addEventListener (Event.ENTER_FRAME, Ahora);

		}
		
		///loops clip based on whether the video is moving forward or reverse
		private function makeClipLoop():void
		{	
			if (_ns.time <= (Math.abs(_speed)))
			{
				_num = _clipDuration - (Math.abs(_speed) * 1.75) - .005;
			} 
			if (_ns.time > (_clipDuration) - (Math.abs(_speed) * 1.75) - .05)
			{
				_num = (Math.abs(_speed)) + .005;
			}
		}
		
		
		private function errorCatch(e:AsyncErrorEvent):void{}
		
		///grabs video meta data containing the duration, width, and height of video
		private function metaDataHandler(infoObject:Object):void 
		{ 			
			_clipDuration = infoObject.duration; 
			var vidWidth:int = infoObject.width;
			var vidHeight:int = infoObject.height;
			
			this.width = vidWidth;
			this.height = vidHeight;
		}
		
		private function updatePreloader(e:Event):void 
		{
			if (_percentLoaded >= 100)
			{
				if (_clipDuration != 0)
				{
					dispatchEvent(new Event(Event.COMPLETE));
					_ns.pause();
					this.removeEventListener(Event.ENTER_FRAME, updatePreloader);
				}
			}
			else
			{
				_percentLoaded = Math.floor((_ns.bytesLoaded * 100) / _ns.bytesTotal);
				dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS));
			}
		}
		
		private function removeVideo(e:Event):void
		{
			_nc.connect(null);
			_ns.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, errorCatch);
			_nc = null;
			_ns = null;
			
			this.removeEventListener(Event.REMOVED_FROM_STAGE, removeVideo);
		}		
	}
}