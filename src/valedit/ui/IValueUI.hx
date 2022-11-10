package valedit.ui;
import valedit.ExposedValue;

/**
 * @author Matse
 */
interface IValueUI 
{
	var exposedValue(get,set):ExposedValue;
	function updateExposedValue(exceptControl:IValueUI = null):Void;
}