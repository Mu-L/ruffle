// The initial version of this file was autogenerated from the official AS3 reference at
// https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/events/NativeWindowDisplayStateEvent.html
// by https://github.com/golfinq/ActionScript_Event_Builder
// It won't be regenerated in the future, so feel free to edit and/or fix

package flash.events
{
  [API("661")]
  public class NativeWindowDisplayStateEvent extends Event
  {
    public static const DISPLAY_STATE_CHANGING:String = "displayStateChanging";
    public static const DISPLAY_STATE_CHANGE:String = "displayStateChange";

    // The display state of the NativeWindow before the change.
    private var _beforeDisplayState:String;

    // The display state of the NativeWindow after the change.
    private var _afterDisplayState:String;

    public function NativeWindowDisplayStateEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false, beforeDisplayState:String = "", afterDisplayState:String = "")
    {
      super(type, bubbles, cancelable);
      this._beforeDisplayState = beforeDisplayState;
      this._afterDisplayState = afterDisplayState;
    }

    // [override] Creates a copy of the NativeWindowDisplayStateEvent object and sets the value of each property to match that of the original.
    override public function clone():Event
    {
      return new NativeWindowDisplayStateEvent(this.type, this.bubbles, this.cancelable, this.beforeDisplayState, this.afterDisplayState);
    }

    // [override] Returns a string that contains all the properties of the NativeWindowDisplayStateEvent object.
    override public function toString():String
    {
      return this.formatToString("NativeWindowDisplayStateEvent", "type", "bubbles", "cancelable", "beforeDisplayState", "afterDisplayState");
    }

    public function get beforeDisplayState():String
    {
      return this._beforeDisplayState;
    }

    public function get afterDisplayState():String
    {
      return this._afterDisplayState;
    }

  }
}