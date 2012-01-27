package com.montydigital.gameEngine.core.stateMachine{
	import com.montydigital.gameEngine.core.states.IState;
	
	import flash.utils.Dictionary;
	
	public class StateMachine{
		
		private var availableStates:Dictionary;
		
		private var currentState:String;
		private var prevState:String;
		private var nextState:String;		
		
		public function StateMachine(){
			availableStates = new Dictionary(true);
		}		
		
		/**
		 * @param name:Strng -  Name of the state
		 * @param state:IState - Class of the state 
		 */
		public function addState(name:String, state:IState):void{
			availableStates[name] = state;
		}
		
		
		public function setState(name:String):void{
			if(currentState == null){
				currentState = name;
				availableStates[currentState].enter();
				return;
			}else{
				if(currentState != name){
					availableStates[currentState].exit();
					prevState = currentState;
					currentState = name;
					availableStates[currentState].enter();
					return;
				}else{
					return;
				}
			}
		}
		
		public function goToPreviousState():void{
			setState(prevState);
		}
		
		public function update():void{
			availableStates[currentState].update();			
		}
	}
}