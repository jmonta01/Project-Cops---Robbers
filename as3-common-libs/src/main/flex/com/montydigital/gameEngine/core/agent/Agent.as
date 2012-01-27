package com.montydigital.gameEngine.core.agent{
	import com.montydigital.gameEngine.core.stateMachine.StateMachine;
	
	public class Agent{
		
		private var fsm:StateMachine;
		
		public function Agent(){
			fsm = new StateMachine();
		}
		
		public function update():void{
			fsm.update();
		}
		
		public function getStateMachine():StateMachine{
			return fsm;
		}
	}
}