package com.montydigital.md2DGameEngine.controller{
	import com.montydigital.common.command.ICommand;
	import com.montydigital.common.events.MDEvent;
	import com.montydigital.common.events.MDEventDispatcher;
	import com.montydigital.md2DGameEngine.application.IApplication;
	import com.montydigital.md2DGameEngine.commands.IGameCommand;
	import com.montydigital.md2DGameEngine.view.world.MDWorld;
	
	import flash.utils.Dictionary;
	
	public class GameAbstractController{
	
		public var commands:Dictionary;
		protected var _enabled:Boolean;
		
		public function GameAbstractController(){
			this.commands = new Dictionary();
			this.enabled = true;
		}
		
		public function set enabled(val:Boolean) : void { this._enabled = val; }
		public function get enabled() : Boolean { return this._enabled; }
		
		public function addCommand(eventName:String, command:Class, application:IApplication) : void {
			MDEventDispatcher.getInstance().addEventListener(eventName, handleEvent);
			this.commands[eventName] = {'command':command, 'application':application}
		}
		
		public function removeCommand(eventName:String, command:Class) : void {
			this.commands[eventName] = null;
			delete this.commands[eventName];
		}
		
		private function handleEvent(event:MDEvent) : void {
			if (this.enabled) {
				var commandClass:Class = this.commands[event.type].command;
				var command:IGameCommand = new commandClass();
				command.application = this.commands[event.type].application;
				command.execute(event);
			}
		}
	}
}