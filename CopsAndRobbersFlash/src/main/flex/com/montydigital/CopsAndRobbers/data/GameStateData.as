package com.montydigital.CopsAndRobbers.data
{
	import com.montydigital.CopsAndRobbers.data.vo.MenuCityVO;
	import com.montydigital.CopsAndRobbers.data.vo.MenuLevelVO;

	public class GameStateData{
		
		private static var _selectedCity:MenuCityVO;
		public static function set selectedCity(val:MenuCityVO):void{ _selectedCity = val; }
		public static function get selectedCity():MenuCityVO{ return _selectedCity; }
		
		private static var _selectedLevel:MenuLevelVO;
		public static function set selectedLevel(val:MenuLevelVO):void{ _selectedLevel = val; }
		public static function get selectedLevel():MenuLevelVO{ return _selectedLevel; }	
		
		public static function advanceToNextLevel():void{
			var levels:Array = LevelData.CityLevelsHash[selectedCity] as Array;
			var counter:int=0;
			for each(var level:MenuLevelVO in levels){
				if(level == selectedLevel) 
					break;
				counter += 1;
			}
			if(counter+1 < levels.length){
				selectedLevel = levels[counter+1];
			}
		}
		
		
		private static var _mute:Boolean;
		public static function get mute():Boolean{ return _mute; }
		public static function set mute(val:Boolean):void{
			_mute = val;
		}
	}
}