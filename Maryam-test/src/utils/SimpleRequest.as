package utils {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	public class SimpleRequest {
		public var loader:URLLoader;
		public var urlRequest:URLRequest;
		public var okFunction:Function;
		public var errorFunction:Function;

		public function SimpleRequest(url:String, parameters:Object = null, method:String = 'GET', okFunction:Function = null, errorFunction:Function = null, autoload:Boolean = true) {
			var vars:URLVariables = new URLVariables();
			for (var key:String in parameters) {
				vars[key] = parameters[key];
			}
			
			urlRequest = new URLRequest(url);
			urlRequest.data = vars;
			if (method && method.toUpperCase() == 'POST') {
				urlRequest.method = URLRequestMethod.POST;
			} else {
				urlRequest.method = URLRequestMethod.GET;
			}
			
			this.okFunction = okFunction;
			this.errorFunction = errorFunction;
			
			loader = new URLLoader();
			if (autoload) {
				loadRequest();
			}
		}
		
		public function loadRequest():void {
			if (okFunction != null) {
				loader.addEventListener(Event.COMPLETE, ok);
			}
			if (errorFunction != null) {
				loader.addEventListener(IOErrorEvent.IO_ERROR, error);
			}
			loader.load(urlRequest);
		}
		
		private function ok(event:Event):void {
			removeEventListeners();
			if (okFunction != null) {
				okFunction(loader.data);
			}
		}
		private function error(event:Object):void {
			removeEventListeners();
			if (errorFunction != null) {
				errorFunction(event);
			}
		}
		
		private function removeEventListeners():void {
			if (okFunction != null) {
				loader.removeEventListener(Event.COMPLETE, ok);
			}
			if (errorFunction != null) {
				loader.removeEventListener(IOErrorEvent.IO_ERROR, error);
			}
		}
	}
}