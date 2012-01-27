package com.montydigital.md2DGameEngine.initializers
{
	import com.montydigital.common.initializers.AbstractInitializer;
	import com.montydigital.common.initializers.IInitializer;
	import com.montydigital.md2DGameEngine.application.IApplication;
	
	public class MDGameAbstractInitializer extends AbstractInitializer implements IInitializer, IMDGameInitializer{
		
		private var _rootApplication:IApplication;
		
		public function MDGameAbstractInitializer(name:String, successEventName:String="", faultEventName:String=""){
			super(name, successEventName, faultEventName);
		}
		
		public function get rootApplication():IApplication{ return this._rootApplication; }
		public function set rootApplication(val:IApplication):void{ this._rootApplication = val; }
	}
}