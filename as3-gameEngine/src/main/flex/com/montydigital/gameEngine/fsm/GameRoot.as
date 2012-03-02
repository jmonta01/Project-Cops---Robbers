package com.montydigital.gameEngine.fsm{
	import flash.events.Event;
	
	import starling.display.StSprite;
	import starling.events.StEnterFrameEvent;
	
	public class GameRoot extends StSprite{
		
		private var _isPlaying:Boolean;
		public function get isPlaying():Boolean{ return _isPlaying; }
		
		public function GameRoot(autoPlay:Boolean=true){
			super();
			if(autoPlay){
				this.addEventListener(StEnterFrameEvent.ENTER_FRAME, loop);
				_isPlaying = true;
			}
		}
		
		public function play():void{
			if(!_isPlaying){
				this.addEventListener(Event.ENTER_FRAME, loop);
				_isPlaying = true;
			}
		}
		
		public function pause():void{
			if(_isPlaying){
				this.removeEventListener(Event.ENTER_FRAME, loop);
				_isPlaying = false;
			}
		}
		
		public function loop(e:StEnterFrameEvent):void{}
	}
}