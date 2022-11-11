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
		if (_uiContainer == value) return value;
		
		if (_uiGroup != null)
		{
			for (control in _uiList)
			{
				_uiGroup.removeExposedControl(control);
			}
			_uiGroup = null;
		}
		else if (_uiContainer != null)
		{
			for (control in _displayList)
			{
				_uiContainer.removeChild(control);
			}
		}
		
		if (value != null)
		{
			if (Std.isOfType(value, IGroupUI))
			{
				_uiGroup = cast value;
				for (control in _uiList)
				{
					_uiGroup.addExposedControl(control);
				}
			}
			else
			{
				for (control in _displayList)
				{
					value.addChild(control);
				}
			}
		}
		
		return _uiContainer = value;
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
		_displayList.push(cast control);
		_uiList.push(control);
	}
	
	/**
	   
	   @param	exceptControl
	**/
	public function update(exceptControl:IValueUI = null):Void
	{
		for (control in _uiList)
		{
			if (control == exceptControl) continue;
			control.updateExposedValue(exceptControl);
		}
	}
	
}