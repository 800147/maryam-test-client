package {
	import components.Field;
	import components.scenes.Scene0;
	import components.scenes.Scene1;
	import events.CheckoutEvent;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import utils.SimpleRequest;
	import utils.WSBridge;
	
	public class Main extends Sprite {
		public static var urlParams:Object;
		
		public static var userId:String;
		public static var previousStore:Object;
		public static var store:Object;
		
		private var _field:Field;
		private var _scene:DisplayObject;
		private static var instance:Sprite;
		private static var apiUrl:String;
		
		public function Main() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			Main.instance = this;
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			Main.instance.addEventListener(CheckoutEvent.CHECKOUT, _start);
			if (ExternalInterface.available) {
				urlParams = ExternalInterface.call("getUrlParams");
				apiUrl = "./api/";
			} else {
				urlParams = { id: "user0", key: "key0" };
				apiUrl = "http://localhost:8080/api/";
			}
			userId = urlParams.id;
			new utils.WSBridge(_wsCallback);
		}
		private function _start(e:CheckoutEvent):void {
			Main.instance.removeEventListener(CheckoutEvent.CHECKOUT, _start);
			
			_field = new Field();
			_scene = new Scene0();
			stage.addChild(_scene);
			stage.addChild(_field);
			
			addCheckoutListener(_checkout);
		}
		private function _wsCallback(s:String):void {
			Main.previousStore = Main.store;
			Main.store = JSON.parse(s);
			Main.instance.dispatchEvent(new CheckoutEvent(CheckoutEvent.CHECKOUT));
		}
		public static function addCheckoutListener(handler:Function):void {
			Main.instance.addEventListener(CheckoutEvent.CHECKOUT, handler, false, 0, true);
			handler(null);
		}
		public static function post(method:String, message:Object = null):void {
			if (message == null) {
				message = {};
			}
			message.id = Main.urlParams.id;
			message.key = Main.urlParams.key;
			new SimpleRequest(apiUrl + method, message, "POST");
		}
		private function _checkout(e:CheckoutEvent):void {
			if (Main.previousStore == null || Main.store.state.scene != Main.previousStore.state.scene) {
				stage.removeChild(_scene);
				switch (Main.store.state.scene) {
					case 0:
						_scene = new Scene0();
						break;
					case 1:
						_scene = new Scene1();
						break;
				}
				stage.addChild(_scene);
				stage.addChild(_field);
			}
		}
	}
	
}