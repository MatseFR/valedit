package valedit.ui;

/**
 * @author Matse
 */
interface IGroupUI 
{
	function addExposedControl(control:IValueUI):Void;
	function addExposedControlAfter(control:IValueUI, afterControl:IValueUI):Void;
	function addExposedControlBefore(control:IValueUI, beforeControl:IValueUI):Void;
	function removeExposedControl(control:IValueUI):Void;
	
}