package com.montydigital.common.control
{
	import com.montydigital.common.command.ICommand;
	import com.montydigital.common.events.*;
	
	import flash.utils.Dictionary;

	public class AbstractController
	{
		public var commands:Dictionary;
		protected var _enabled:Boolean;
		
		public function AbstractController()
		{
			this.commands = new Dictionary();
			this.enabled = true;
		}
		
		public function set enabled(val:Boolean) : void { this._enabled = val; }
		public function get enabled() : Boolean { return this._enabled; }
		
		public function addCommand(eventName:String, command:Class) : void {
			MDEventDispatcher.getInstance().addEventListener(eventName, handleEvent);
			this.commands[eventName] = command;
		}
		
		public function removeCommand(eventName:String, command:Class) : void {
			this.commands[eventName] = null;
			delete this.commands[eventName];
		}
		
		private function handleEvent(event:MDEvent) : void {
			if (this.enabled) {
				var commandClass:Class = this.commands[event.type];
				var command:ICommand = new commandClass();
				command.execute(event);
			}
		}
	}
}