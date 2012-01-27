package com.montydigital.common.services
{
	
	import com.montydigital.common.events.services.MD_HTTServiceFaultEvent;
	import com.montydigital.common.vo.services.MD_ServiceVO;
	
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.messaging.messages.HTTPRequestMessage;
	import mx.rpc.AbstractOperation;
	import mx.rpc.AsyncResponder;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class MD_HttpServiceOrchestrator extends EventDispatcher{
		
		public static const GET:String = "GET";
		public static const POST:String = "POST";
		public static const PUT:String = "PUT";
		public static const DELETE:String = "DELETE";
		
		public static const CONTENT_TYPE_JSON:String = "application/json";	
		public static const CONTENT_TYPE_FORM:String = "application/x-www-form-urlencoded";
		public static const CONTENT_TYPE_XML:String = "application/xml";
		
		public static const RESULT_FORMAT_XML:String = "xml";
		public static const RESULT_FORMAT_TEXT:String = "text";
		public static const RESULT_FORMAT_ARRAY:String = "array";
		public static const RESULT_FORMAT_OBJECT:String = "object";
		
		private const MAX_FAULTS:int = 3;
		
		private var serviceHash:Dictionary;
		private var serviceHashCount:int = 0;
		
		private static var logger:ILogger = Log.getLogger("com.banddigital.ngp.services.BD_HttpServiceOrchestrator");
		
		
		public function initService(url:String, contentType:String, resultFormat:String, method:String, resultFunction:Function, faultFunction:Function, request:*=null, bypassFaultChecking:Boolean=false):void{ //returns hash key
			var service:MD_HTTPService = new MD_HTTPService();
			service.showBusyCursor = false;
			service.addEventListener(ResultEvent.RESULT, onResult);
			service.addEventListener(FaultEvent.FAULT, onFault);
			service.name = "";
			service.url = url;
			service.contentType = contentType;
			service.resultFormat = resultFormat; 
			service.method = method;
			service.request = request;
			
			serviceHash[url] = new MD_ServiceVO(service, new AsyncResponder(resultFunction, faultFunction), bypassFaultChecking);
			serviceHashCount += 1;
			service.send();			
		}
		
		private function onResult(e:ResultEvent):void{
			var url:String = (e.token.message as HTTPRequestMessage).url;
			var serviceVO:MD_ServiceVO = serviceHash[url] as MD_ServiceVO;
			if(serviceVO)
				serviceVO.responder.result(e);
			clearService(url);
		}
		
		private function onFault(e:FaultEvent):void{
			var url:String = (e.token.message as HTTPRequestMessage).url;
			var serviceVO:MD_ServiceVO = serviceHash[url] as MD_ServiceVO;
			if(!serviceVO.bypassFaultChecking){
				if(serviceVO.faultCounter < MAX_FAULTS){
					logger.error("Service Fault Attempt ("+(serviceVO.faultCounter+1).toString()+") - "+url);
					serviceVO.service.send();
					serviceVO.faultCounter += 1;
				}else{
					logger.fatal("Service Fault Failed Max Times", url);
					serviceVO.responder.fault(e);
					clearService(url);
					new MD_HTTServiceFaultEvent(url).dispatch();
				}
			}else{
				serviceVO.responder.fault(e);
			}
		}
		
		private function clearService(key:String):void{
			var serviceVO:MD_ServiceVO = serviceHash[key] as MD_ServiceVO;
			if(serviceVO){
				serviceVO.service.removeEventListener(ResultEvent.RESULT, onResult);
				serviceVO.service.removeEventListener(FaultEvent.FAULT, onFault);
				serviceVO = null;
				delete serviceHash[key];
				serviceHashCount -= 1;
			}
		}		
		
		
		
		
		public static var instance:MD_HttpServiceOrchestrator;
		
		public static function getInstance():MD_HttpServiceOrchestrator{
			if(MD_HttpServiceOrchestrator.instance == null){
				MD_HttpServiceOrchestrator.instance = new MD_HttpServiceOrchestrator(new SingletonEnforcer());
			}
			return MD_HttpServiceOrchestrator.instance;
		}
		
		
		public function MD_HttpServiceOrchestrator(singletonEnforcer:SingletonEnforcer){
			if(singletonEnforcer){
				serviceHash = new Dictionary(true);
			}else{
				throw new Error("This is a singleton, use the getInstance method!!");
			}
		}
	}
}
class SingletonEnforcer{}