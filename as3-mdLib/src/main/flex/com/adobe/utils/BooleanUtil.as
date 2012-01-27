package com.adobe.utils {
	
	public class BooleanUtil {
		
		public static function parseString(string:String):Boolean {
			if (string == "true") {
				return true
			} else {
				return false;
			}
		}
	}
}