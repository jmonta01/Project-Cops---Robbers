package com.montydigital.CopsAndRobbers.engine.entityFramework.node{
	import org.osflash.signals.Signal;

	public class GameState{
		
		public var signal:Signal;
		
		public var maxTime:Number;
		private var _time:Number;
		public function get time():Number{ return _time; }
		public function set time(val:Number):void{
			 _time = val;
			 signal.dispatch();
		}
		
		public var totalRounds:int;
		private var _roundsInClip:int;
		public function get roundsInClip():int{ return _roundsInClip; }
		public function set roundsInClip(val:int):void{
			_roundsInClip = val;
			signal.dispatch();
		}
		
		private var _score:int;
		public function get score():int{ return _score; }
		public function set score(val:int):void{
			_score = val;
			signal.dispatch();
		}
		
		public var enemies:int = 0;
		public var destrucitbleProps:int = 0;
		
		public var levelEnded:Boolean=false;
		public var levelPassed:Boolean=false;
		public var systemNotifiedOfEnding:Boolean=false;
		
		public function GameState(){
			signal = new Signal();
		}
		
		public function reset():void{
			levelEnded = false; 
			levelPassed = false;
			systemNotifiedOfEnding = false;
		}
	}
}