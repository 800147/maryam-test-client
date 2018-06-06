package components {
	import flash.events.MouseEvent;
	public class User extends UserView {
		private var _buttonHandler:Function = null;
		
		public function User() {
			super();
			t_name.text = "";
			t_status.text = "";
			t_button.text = "";
			t_button.mouseEnabled = false;
			b_button.addEventListener(MouseEvent.CLICK, _onClick);
			b_button.visible = false;
			t_button.visible = false;
		}
		public function setName(name:String = ""):void {
			t_name.text = name;
		}
		public function setStatus(status:String = ""):void {
			t_status.text = status;
		}
		public function setButton(text:String = "", handler:Function = null):void {
			t_button.text = text;
			_buttonHandler = handler;
			if (text == "") {
				t_button.visible = false;
				b_button.visible = false;
				return;
			}
			t_button.visible = true;
			b_button.visible = true;
		}
		private function _onClick(e:MouseEvent):void {
			if (_buttonHandler != null) {
				_buttonHandler();
			}
		}
	}
}