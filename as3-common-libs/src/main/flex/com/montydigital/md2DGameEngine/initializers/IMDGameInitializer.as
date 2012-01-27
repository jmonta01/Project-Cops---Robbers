package com.montydigital.md2DGameEngine.initializers
{
	import com.montydigital.md2DGameEngine.application.IApplication;

	public interface IMDGameInitializer
	{
		function get rootApplication():IApplication;
		function set rootApplication(val:IApplication):void;
	}
}