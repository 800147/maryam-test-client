package components.scenes {
	
	import components.User;
	import events.CheckoutEvent;
	import flash.events.MouseEvent;
	
	public class Scene1 extends Scene1View {		
		public function Scene1() {
			super();
			gotoAndStop(1);
			Main.addCheckoutListener(_checkout);
		}
		private function _checkout(e:CheckoutEvent = null):void {
		}
	}
}