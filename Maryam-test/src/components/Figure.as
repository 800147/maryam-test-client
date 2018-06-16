package components {
	public class Figure extends FiguresView {
		public function Figure() {
			super();
			clear();
		}
		public function setName(name:String = ""):void {
			t_name.text = name;
			if (name == "") {
				t_name.visible = false;
			} else {
				t_name.visible = true;
			}
		}
		public function setType(type:String = ""):void {
			gotoAndStop(type);
			if (figure != null) {
				figure.gotoAndStop(2);
			}
		}
		public function setColor(color:int):void {
			if (figure != null) {
				figure.m.gotoAndStop(color + 2);
			}
		}
		public function setAll(user:Object):void {
			if (user.id == Main.userId) {
				setName(user.initName + " (вы)");
			} else {
				setName(user.initName);
			}
			if (user.figure == null) {
				setType("unknown");
				setColor( -1);
				return;
			}
			setType(user.figure.type);
			if (user.figure.color != null) {
				setColor(user.figure.color);
			} else {
				setColor(-1);
			}
		}
		public function clear():void {
			setName();
			setType("unknown");
			setColor(-1);
		}
	}
}