package components {

	public class InstructionsContainer extends InstructionsContainerView {
		private var _currentFrame:Object;
		
		public function InstructionsContainer() {
			super();
			clear();
		}
		public function go(frame:Object, withAnimation:Boolean = true):void {
			if (frame == _currentFrame) {
				return;
			}
			_currentFrame = frame;
			instructions.gotoAndStop(frame);
			instructions.visible = true;
			if (withAnimation) {
				play();
			}
		}
		public function clear():void {
			gotoAndStop(1);
			instructions.visible = false;
		}
	}
}