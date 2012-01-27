package com.montydigital.common.vo.services
{
	
	import com.montydigital.common.services.MD_HTTPService;
	import com.montydigital.common.vo.IValueObject;
	
	import mx.rpc.AsyncResponder;
	import mx.rpc.http.HTTPService;
	
	public class MD_ServiceVO implements IValueObject
	{
		
		public var service:MD_HTTPService;
		public var responder:AsyncResponder;
		public var bypassFaultChecking:Boolean;
		public var faultCounter:int = 0;
		
		public function MD_ServiceVO(service:MD_HTTPService, responder:AsyncResponder, bypassFaultChecking:Boolean=false){
			this.service = service;
			this.responder = responder;
			this.bypassFaultChecking = bypassFaultChecking;
		}
	}
}