package valedit.ui;
import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;

/**
 * ...
 * @author Matse
 */
class UICollection 
{
	public var uiContainer(get, set):DisplayObjectContainer;
	
	private var _uiContainer:DisplayObjectContainer;
	private function get_uiContainer():DisplayObjectContainer { return _uiContainer; }
	private function set_uiContainer(value:DisplayObjectContainer):DisplayObjectContainer
	{
		if (this._uiContainer == value) return value;
		
		if (this._uiGroup != null)
		{
			for (control in this._uiList)
			{
				this._uiGroup.removeExposedControl(control);
			}
			this._uiGroup = null;
		}
		else if (this._uiContainer != null)
		{
			for (control in this._displayList)
			{
				this._uiContainer.removeChild(control);
			}
		}
		
		if (value != null)
		{
			if (Std.isOfType(value, IGroupUI))
			{
				this._uiGroup = cast value;
				for (control in this._uiList)
				{
					this._uiGroup.addExposedControl(control);
				}
			}
			else
			{
				for (control in this._displayList)
				{
					value.addChild(control);
				}
			}
		}
		
		return this._uiContainer = value;
	}
	
	private var _uiGroup:IGroupUI;
	private var _displayList:Array<DisplayObject> = new Array<DisplayObject>();
	private var _uiList:Array<IValueUI> = new Array<IValueUI>();
	
	/**
	   
	**/
	public function new() 
	{
		
	}
	
	/**
	   
	   @param	control
	**/
	public function addUI(control:IValueUI):Void
	{
		this._displayList.push(cast control);
		this._uiList.push(control);
	}
	
}