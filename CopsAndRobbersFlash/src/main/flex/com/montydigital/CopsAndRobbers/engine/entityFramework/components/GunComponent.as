package com.montydigital.CopsAndRobbers.engine.entityFramework.components{
	import flash.geom.Point;

	public class GunComponent{
		
		public var shooting:Boolean = false;
		public var offsetFromParent:Point = new Point();
		
		public var timeSinceLastShot:Number = 0;
		public var minimumShotInterval:Number = 0;
		public var bulletLifeTime:Number = 0;
		
		public var currentBulletsInClip:Number = 0;
		public var totalBulletsInClip:Number = 0;
		
		public var gunType:String;
		
		public function GunComponent(){}
	}
}