package com.montydigital.CopsAndRobbers.data{
	import com.montydigital.CopsAndRobbers.data.vo.MenuCityVO;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	[Event(name=COMPLETE, type="flash.events.Event")]
	public class LevelData extends EventDispatcher{
		
		public static const COMPLETE:String = "gameDataLoadcomplete";		
		public static var MenuData:Array;
		public static var CityLevelsHash:Dictionary;
		private var loader:URLLoader;
		
		public function loadMenuData():void{
			loader.addEventListener(Event.COMPLETE, handleMenuDataComplete);	
			loader.load(new URLRequest("data/MenuData.json"));
		}
		
		private function handleIOError(e:IOErrorEvent):void{
			trace("cant load something");
		}
		
		private function handleMenuDataComplete(event:Event):void{
			loader.removeEventListener(Event.COMPLETE, handleMenuDataComplete);
			var result:Object = JSON.parse(loader.data as String);
			MenuData = [];
			CityLevelsHash = new Dictionary();
			var cityVO:MenuCityVO;
			for each(var city:Object in result.cities){
				cityVO = MenuCityVO.deserialize(city)
				MenuData.push(cityVO);
				CityLevelsHash[cityVO] = cityVO.levels;
			}
			this.dispatchEvent(new Event(COMPLETE));
		}		
		
		/* Singleton Implementation */
		private static var instance:LevelData;
		public static function getInstance():LevelData{
			if(!LevelData.instance)
				LevelData.instance = new LevelData(new Enforcer());
			return LevelData.instance;
		}
		
		public function LevelData(enforcer:Enforcer):void{
			loader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(IOErrorEvent.IO_ERROR, handleIOError);
			trace("FIX-ME: (com.montydigital.CopsAndRobbers.data.GameData) This needs to use a service that can dictate where the source json comes from");
		}

	}
}
class Enforcer{}