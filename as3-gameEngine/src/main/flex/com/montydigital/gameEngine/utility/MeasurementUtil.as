package com.montydigital.gameEngine.utility{
	public class MeasurementUtil{
		
		
		
		public static function convertFtToMeters(val:Number):Number{
			return val*.3048; //1ft in meters // multiply this by the box2d ratio to get pixels per foot
		}
		
		public static function getScaleFrom(current:Number, target:Number):Number{
			return target/current;
		}
		
	}
}