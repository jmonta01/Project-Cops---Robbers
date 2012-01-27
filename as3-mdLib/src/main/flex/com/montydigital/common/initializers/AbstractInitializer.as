package com.montydigital.common.initializers{

	import com.montydigital.common.events.MDEvent;
	import com.montydigital.common.events.MDEventDispatcher;
	import com.montydigital.common.events.initializers.InitializerFaultEvent;
	import com.montydigital.common.events.initializers.InitializerSuccessEvent;
	
	public class AbstractInitializer implements IInitializer{
		
		
		private var name:String;
		private var successEventName:String;
		private var faultEventName:String;
		
		public function AbstractInitializer(name:String, successEventName:String="", faultEventName:String=""){
			this.name = name;
			this.successEventName = successEventName;
			this.faultEventName = faultEventName;
			
			if(this.successEventName!="")
				MDEventDispatcher.getInstance().addEventListener(this.successEventName, success);
			if(this.faultEventName!="")
				MDEventDispatcher.getInstance().addEventListener(this.faultEventName, fault);
		}
		
		protected function next():void{}
		
		
		public function execute():void{
			if(this.successEventName=="" && this.faultEventName=="")
				new InitializerSuccessEvent(this.name).dispatch();
		}
		
		public function success(event:MDEvent):void{
			this.removeListeners();	
			new InitializerSuccessEvent(this.name).dispatch();
		}
		
		public function fault(event:MDEvent):void{
			this.removeListeners();
			new InitializerFaultEvent(this.name).dispatch();
		}
		
		public function getName():String{
			return this.name;
		}

		
		
		private function removeListeners():void{
			MDEventDispatcher.getInstance().removeEventListener(this.successEventName, success);
			MDEventDispatcher.getInstance().removeEventListener(this.faultEventName, fault);
		}
	}
}