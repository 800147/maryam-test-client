package components.scenes {
	import com.adobe.tvsdk.mediacore.events.TimedEvent;
	import com.greensock.TweenLite;
	import com.greensock.easing.BackInOut;
	import com.greensock.easing.SineInOut;
	import components.Figure;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import events.CheckoutEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Scene1 extends Scene1View {
		private var _figures:Array;
		private var _chosenFigure:MovieClip;
		private var _animationStart:Boolean = false;
		private var _animationComplete:Boolean = false;
		
		public function Scene1() {
			super();
			gotoAndStop(1);
			Main.addCheckoutListener(_checkout);
		}
		private function _checkout(e:CheckoutEvent = null):void {
			if (_animationStart && !_animationComplete) {
				return;
			}
			var i:int;
			if (Main.store.state.scene !== 1) {
				return;
			}
			if (Main.store.state.step == 0) {
				_figures = [
					{ figure: c0, type:"c", circle: "0" },
					{ figure: r0, type:"r", circle: "0" },
					{ figure: s0, type:"s", circle: "0" },
					{ figure: t0, type:"t", circle: "0" },
					{ figure: z0, type:"z", circle: "0" },
					{ figure: c1, type:"c", circle: "1" },
					{ figure: r1, type:"r", circle: "1" },
					{ figure: s1, type:"s", circle: "1" },
					{ figure: t1, type:"t", circle: "1" },
					{ figure: z1, type:"z", circle: "1" },
					{ figure: c2, type:"c", circle: "2" },
					{ figure: r2, type:"r", circle: "2" },
					{ figure: s2, type:"s", circle: "2" },
					{ figure: t2, type:"t", circle: "2" },
					{ figure: z2, type:"z", circle: "2" },
					{ figure: c3, type:"c", circle: "3" },
					{ figure: r3, type:"r", circle: "3" },
					{ figure: s3, type:"s", circle: "3" },
					{ figure: t3, type:"t", circle: "3" },
					{ figure: z3, type:"z", circle: "3" }
				];
				if (Main.store.users[Main.userId].figure == undefined) {
					gotoAndStop(1);
					Main.instance.instructionsGo(2);
					for (i = 0; i < _figures.length; i++) {
						_figures[i].figure.figureType = _figures[i].type;
						_figures[i].figure.figureCircle = _figures[i].circle;
						_figures[i].figure.addEventListener(MouseEvent.CLICK, choose, false, 0, true);
					}
				} else if (_animationStart == false) {
					_animationStart = true;
					gotoAndStop(1);
					Main.instance.instructionsClear();
					_chosenFigure = this[Main.store.users[Main.userId].figure.type + Main.store.users[Main.userId].figure.circle];
					_chosenFigure.gotoAndStop(2);
					_chosenFigure.m.gotoAndStop(1);
					for (i = 0; i < _figures.length; i++) {
						if (_figures[i].figure.currentFrame == 1) {
							_figures[i].figure.gotoAndPlay(5 + Math.round(Math.random() * 40));
							_figures[i].figure.m.gotoAndStop(1);
						}
					}
					var t:Timer = new Timer(2000, 1);
					t.addEventListener(TimerEvent.TIMER_COMPLETE, animationComplete, false, 0, true);
					t.start();
				}
			}
			if (Main.store.state.step == 1) {
				gotoAndStop(4);
				t_apply.mouseEnabled = false;
				Main.instance.instructionsGo(3);
				if (userFigure == null) {
					var userFigure:Figure = new Figure();
					userFigure.x = 160;
					userFigure.y = 90;
					userFigure.setAll(Main.store.users[Main.userId]);
				}
				addChild(userFigure);
			}
		}
		private function choose(e:MouseEvent):void {
			Main.post("chooseFigure", { type: e.target.parent.figureType, circle: e.target.parent.figureCircle });
		}
		private function animationComplete(e:TimerEvent):void {
			gotoAndStop(2);
			var userFigure:Figure = new Figure();
			userFigure.x = _chosenFigure.x;
			userFigure.y = _chosenFigure.y;
			userFigure.setAll(Main.store.users[Main.userId]);
			addChild(userFigure);
			new TweenLite(userFigure, 1, { x: 160, y: 90, ease: new SineInOut(), onComplete: animation1Complete });
		}
		private function animation1Complete():void {
			var t:Timer = new Timer(1000, 1);
			t.addEventListener(TimerEvent.TIMER_COMPLETE, animation1Complete1, false, 0, true);
			t.start();
		}
		private function animation1Complete1(e:TimerEvent):void {
			_animationComplete = true;
			_checkout();
		}
	}
}