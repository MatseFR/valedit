package valedit.ui;
import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;

/**
 * ...
 * @author Matse
 */
class UICollection 
{
	static private var _POOL:Array<UICollection> = new Array<UICollection>();
	
	static public function disposePool():Void
	{
		_POOL.resize(0);
	}
	
	static public function fromPool():UICollection
	{
		if (_POOL.length != 0) return _POOL.pop();
		return new UICollection();
	}
	
	public var uiContainer(get, set):DisplayObjectContainer;
	
	private var _uiContainer:DisplayObjectContainer;
	private function get_uiContainer():DisplayObjectContainer { return _uiContainer; }
	private function set_uiContainer(value:DisplayObjectContainer):DisplayObjectContainer
	{
		if (this._uiContainer == value) return value;
		
		if (this._uiGroup != null)
		{
			this._uiGroup.removeAllExposedControls();
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
				this._uiGroup.addExposedControls(this._uiList);
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
	
	public function clear():Void
	{
		this.uiContainer = null;
		for (control in this._uiList)
		{
			control.pool();
		}
		this._uiList.resize(0);
		this._displayList.resize(0);
	}
	
	public function pool():Void
	{
		clear();
		_POOL[_POOL.length] = this;
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