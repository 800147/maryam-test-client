package components {
	import events.CheckoutEvent;

	public class Field extends FieldView {
		private var _users:Object = {};
		
		public function Field() {
			super();
			for (var userId:String in Main.store.users) {
				_users[userId] = new User();
				_users[userId].setName(Main.store.users[userId].initName);
				_users[userId].setStatus("не подключен");
				_users[userId].y = Main.store.users[userId].initNumber * 40;
				m_team.addChild(_users[userId]);
			}
			Main.addCheckoutListener(_checkout);
		}
		private function _checkout(e:CheckoutEvent = null):void {
			for (var userId:String in Main.store.users) {
				_users[userId].setAll(Main.store.users[userId]);
			}			
		}
	}
}