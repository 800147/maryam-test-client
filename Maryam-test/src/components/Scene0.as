package components {
	
	import events.CheckoutEvent;
	import flash.events.MouseEvent;
	
	public class Scene0 extends Scene0View {
		private var _users:Object = {};
		
		public function Scene0() {
			super();
			gotoAndStop(1);
			var i:int = 0;
			for (var userId:String in Main.store.users) {
				_users[userId] = new User();
				_users[userId].setName(Main.store.users[userId].initName);
				_users[userId].setStatus("не подключен");
				_users[userId].y = Main.store.users[userId].initNumber * 40;
				m_team.addChild(_users[userId]);
			}
			b_ready.addEventListener(MouseEvent.CLICK, _onReady);
			Main.addCheckoutListener(_checkout);
		}
		private function _onReady(e:MouseEvent):void {
			Main.post("ready");
		}
		private function _checkout(e:CheckoutEvent = null):void {
			if (Main.store.users[Main.userId].ready == true) {
				gotoAndStop(2);
			} else {
				gotoAndStop(1);
			}
			for (var userId:String in Main.store.users) {
				var status:String = "не подключен";
				if (Main.store.users[userId].connected == true) {
					status = "подключен, но не готов";
				}
				if (Main.store.users[userId].ready == true) {
					status = "готов";
				}
				_users[userId].setStatus(status);
			}			
		}
	}
}