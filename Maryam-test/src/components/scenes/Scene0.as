package components.scenes {
	
	import events.CheckoutEvent;
	import flash.events.MouseEvent;
	
	public class Scene0 extends Scene0View {
		public function Scene0() {
			super();
			gotoAndStop(1);
			b_ready.addEventListener(MouseEvent.CLICK, _onReady);
			Main.addCheckoutListener(_checkout);
		}
		private function _onReady(e:MouseEvent):void {
			Main.post("ready");
		}
		private function _checkout(e:CheckoutEvent = null):void {
			if (Main.store.state.scene !== 0) {
				return;
			}
			if (Main.store.users[Main.userId].ready != true) {
				gotoAndStop(1);
				Main.instance.instructionsGo(1);
			} else {
				gotoAndStop(2);
				Main.instance.instructionsClear();
			}
		}
	}
}

/*
package components.scenes {
	import events.CheckoutEvent;
	
	public class SceneN extends SceneNView {		
		public function SceneN() {
			super();
			gotoAndStop(1);
			Main.addCheckoutListener(_checkout);
		}
		private function _checkout(e:CheckoutEvent = null):void {
			if (Main.store.state.scene !== N) {
				return;
			}
		}
	}
}
*/