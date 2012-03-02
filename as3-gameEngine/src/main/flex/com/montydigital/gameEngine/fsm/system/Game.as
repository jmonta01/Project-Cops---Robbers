package com.montydigital.gameEngine.fsm.system{
	
	public class Game{
		
		private var systems:Vector.<ISystem>;
		
		public var updating:Boolean;
		
		public function Game(){
			systems = new Vector.<ISystem>();
		}
		
		public function addSystem(system:ISystem):void{
			systems.push(system);
		}
		
		public function removeSystem(system:ISystem):void{
			systems.splice(systems.indexOf(system), 1);
		}
		
		public function update():void{
			updating = true;
			for each(var system:ISystem in systems)
				system.update();
			updating = false;
		}
	}
}