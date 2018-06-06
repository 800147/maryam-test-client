package events {
	import flash.events.Event;

	public class CheckoutEvent extends Event {
		
		static public const CHECKOUT:String = 'checkout';
		
		public function CheckoutEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event {
			return new CheckoutEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String {
			return formatToString("CheckoutEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
	}
}
