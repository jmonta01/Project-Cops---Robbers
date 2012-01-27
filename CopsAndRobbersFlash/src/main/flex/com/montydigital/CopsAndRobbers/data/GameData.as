package com.montydigital.CopsAndRobbers.data{
	import com.montydigital.CopsAndRobbers.data.vo.MenuCityVO;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;

	[Event(name=COMPLETE, type="flash.events.Event")]
	public class GameData extends EventDispatcher{
		
		public static const COMPLETE:String = "gameDataLoadcomplete";
		
		public static var MenuData:Array;
		
		private var loader:URLLoader;
		
		public function GameData():void{
			loader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(IOErrorEvent.IO_ERROR, handleIOError);
			trace("FIX-ME: (com.montydigital.CopsAndRobbers.data.GameData) This needs to use a service that can dictate where the source json comes from");
		}
		
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
			for each(var city:Object in result.cities){
				MenuData.push(MenuCityVO.deserialize(city));
			}
			this.dispatchEvent(new Event(COMPLETE));
		}		
		
		
	}
}