package utils {
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.utils.Timer;
	
	public class WSBridge {
		private var _ready:Boolean = false;
		private var _readyTimer:Timer;
		private const READY_TIME:int = 250;
		private const HTTP_TIME:int = 250;
		
		private var _callback:Function;
		
		public function WSBridge(callback:Function) {
			_callback = callback;
			if (ExternalInterface.available) {
				_readyTimer = new Timer(READY_TIME);
				_readyTimer.addEventListener(TimerEvent.TIMER, _readyCheck);
				_readyTimer.start();
				_readyCheck();
			} else {
				_httpCheckout();
			}
			return;
		}
		private function _readyCheck(e:TimerEvent = null):void {
			if (ExternalInterface.call("asBridge.isLoaded") != true) {
				return;
			}
			ExternalInterface.addCallback('wsCallback', _callback);
			if (ExternalInterface.call("asBridge.check", ExternalInterface.objectID) == false) {
				return;
			}
			_readyTimer.removeEventListener(TimerEvent.TIMER, _readyCheck);
			_readyTimer.stop();
			_readyTimer = null;
			_ready = true;
		}
		private function _httpCheckout(e:Event = null):void {
			new SimpleRequest("http://localhost:8080/api/checkout", { id: Main.urlParams.id, key: Main.urlParams.key }, "POST", _httpCheckoutReady);
		}
		private function _httpCheckoutReady(s:String):void {
			_callback(s);
			var timer:Timer = new Timer(HTTP_TIME, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, _httpCheckout);
			timer.start();
		}
	}
}