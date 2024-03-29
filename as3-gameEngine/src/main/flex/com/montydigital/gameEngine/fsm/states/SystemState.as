package com.montydigital.gameEngine.fsm.states
{
	import com.montydigital.gameEngine.fsm.system.ISystem;

	public class SystemState implements IState
	{
		protected var system:ISystem;
		
		public function SystemState(system:ISystem){
			this.system = system;
		}
		
		public function enter():void
		{
			system.enter();
		}
		
		public function update():void
		{
			system.update();
		}
		
		public function exit():void
		{
			system.exit();
		}
	}
}