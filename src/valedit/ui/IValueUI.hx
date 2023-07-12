package valedit.ui;
import valedit.value.base.ExposedValue;

/**
 * @author Matse
 */
interface IValueUI 
{
	var exposedValue(get, set):ExposedValue;
	function initExposedValue():Void;
	function updateExposedValue(exceptControl:IValueUI = null):Void;
	function pool():Void;
}