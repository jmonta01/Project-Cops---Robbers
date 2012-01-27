package com.montydigital.common.services
{
	import mx.rpc.http.HTTPService;
	
	public class MD_HTTPService extends HTTPService
	{
		
		public var name:String;
		
		public function MD_HTTPService(rootURL:String=null, destination:String=null)
		{
			super(rootURL, destination);
		}
	}
}