package com.montydigital.gameEngine.entityFramework.input{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import starling.core.Starling;
	import starling.display.StImage;
	import starling.display.StSprite;
	import starling.events.StTouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	
	public class UserIntentCapture extends StSprite{
		
		private var container:StSprite;
		private var touchDownStates:Array = [TouchPhase.BEGAN, TouchPhase.MOVED, TouchPhase.STATIONARY];
		
		private var lastTouchState:String;
		public var firing:Boolean = false;
		public var targetCoords:Point = new Point();
		
		public var cameraPositionDelta:Point = new Point();		
		public var zoomOrigin:Point = new Point();
		public var zoomFactor:Number = 0;
		
		public var zoomingOrPanning:Boolean = false;
		public var touching:Boolean = false;
		
		
		public function UserIntentCapture(viewportWidth:Number, viewportHeight:Number){
			
			Starling.current.simulateMultitouch = true;
			
			this.touchable = true;			
			var fillBmpData:BitmapData = new BitmapData(viewportWidth, viewportHeight, false, 0xFF0000);
			var fill:StImage = StImage.fromBitmap(new Bitmap(fillBmpData));
			fill.alpha = 0;
			this.addChild(fill);
			
			this.addEventListener(StTouchEvent.TOUCH, handleTouch);
		}
		
		private function handleTouch(e:StTouchEvent):void{		
			var touches:Vector.<Touch> = e.getTouches(this);
			if(touches.length > 0 && touches[0].phase != TouchPhase.HOVER){
				if(touches.length == 1){ //single touch
					if(Starling.multitouchEnabled){
						handleAimAndShoot(touches[0]);
					}else{
						handleAimAndShoot(touches[0]);
					}
				}else{ // two fingers touching -> pan and zoom					
					handleZoomAndPan(touches[0], touches[1]);
				}
				touching = (touchDownStates.indexOf(touches[0].phase) > -1) ? true : false;
			}		
		}
		
		private function handleAimAndShoot(touch:Touch):void{
			if(touch){		
				zoomingOrPanning = false;
				targetCoords.x = touch.globalX;
				targetCoords.y = touch.globalY;
				if(touch.phase == TouchPhase.ENDED && touchDownStates.indexOf(lastTouchState) > -1)
					firing = true;
				lastTouchState = touch.phase;
			}
		}
		
		private function handleZoomAndPan(touchA:Touch, touchB:Touch):void{
			zoomingOrPanning = true;
			var currentPosA:Point  = touchA.getLocation(parent);
			var previousPosA:Point = touchA.getPreviousLocation(parent);
			var currentPosB:Point  = touchB.getLocation(parent);
			var previousPosB:Point = touchB.getPreviousLocation(parent);
			
			var currentVector:Point  = currentPosA.subtract(currentPosB);
			var previousVector:Point = previousPosA.subtract(previousPosB);
			
			var currentOrgin:Point = new Point(); 
			currentOrgin.x = (currentPosA.x + currentPosB.x) / 2;
			currentOrgin.y = (currentPosA.y + currentPosB.y) / 2;
			
			var prevOrgin:Point = new Point();
			prevOrgin.x = (previousPosA.x + previousPosB.x) / 2;
			prevOrgin.y = (previousPosA.y + previousPosB.y) / 2;
			
			zoomFactor = currentVector.length/previousVector.length;	
			zoomOrigin = currentOrgin;
			
			cameraPositionDelta = currentOrgin.subtract(prevOrgin);
		}
	}
}