package valedit.data.valeditor;
import juggler.animation.Transitions;
import valedit.ExposedCollection;
import valedit.value.ExposedBool;
import valedit.value.ExposedColor;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedFunctionExternal;
import valedit.value.ExposedIntDrag;
import valedit.value.ExposedObject;
import valedit.value.ExposedSelect;
import valedit.value.ExposedSelectCombo;
import valedit.value.ExposedString;
#if (desktop || air)
import valedit.value.ExposedPath;
#end
#if valeditor
import valeditor.ValEditor;
#end
import valedit.value.base.ExposedValue;
import valeditor.ValEditorClass;
import valeditor.ValEditorObject;
import valeditor.container.ITimeLineContainerEditable;

/**
 * ...
 * @author Matse
 */
class SettingsData 
{
	#if valeditor
	static public function exposeEditorSettings(?collection:ExposedCollection):ExposedCollection
	{
		var bool:ExposedBool;
		var funcExternal:ExposedFunctionExternal;
		var intDrag:ExposedIntDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		#if (desktop || air)
		if (!collection.hasValue("autoSave"))
		{
			bool = new ExposedBool("autoSave", "auto save");
			collection.addValue(bool);
		}
		
		if (!collection.hasValue("autoSaveInterval"))
		{
			intDrag = new ExposedIntDrag("autoSaveInterval", "auto save interval (mins)", 1, 120);
			collection.addValue(intDrag);
		}
		#end
		
		if (!collection.hasValue("releaseUIFocusOnValidation"))
		{
			bool = new ExposedBool("releaseUIFocusOnValidation", "release UI focus");
			collection.addValue(bool);
		}
		
		if (!collection.hasValue("undoLevels"))
		{
			intDrag = new ExposedIntDrag("undoLevels", "undo levels", 10, 99999);
			collection.addValue(intDrag);
		}
		
		if (!collection.hasValue("uiDarkMode"))
		{
			bool = new ExposedBool("uiDarkMode", "UI dark mode");
			collection.addValue(bool);
		}
		
		if (!collection.hasValue("editClassVisibilitiesEditor"))
		{
			funcExternal = new ExposedFunctionExternal("editClassVisibilitiesEditor", "edit class visibilities", ValEditor);
			collection.addValue(funcExternal);
		}
		
		if (!collection.hasValue("editUITheme"))
		{
			funcExternal = new ExposedFunctionExternal("editUITheme", "edit UI theme", ValEditor);
			collection.addValue(funcExternal);
		}
		
		return collection;
	}
	#end
	
	static public function exposeExportSettings(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		#if (desktop || air)
		var path:ExposedPath;
		#end
		var str:ExposedString;
		
		if (collection == null) collection = new ExposedCollection();
		
		#if (desktop || air)
		if (!collection.hasValue("filePath"))
		{
			path = new ExposedPath("filePath", "export path");
			path.dialogTitle = "export path";
			collection.addValue(path, groupName);
		}
		#end
		
		if (!collection.hasValue("fileName"))
		{
			str = new ExposedString("fileName", "file name", 0);// , "a-z A-Z 0-9 éèêàâôçùü.-_()");
			collection.addValue(str, groupName);
		}
		
		if (!collection.hasValue("compress"))
		{
			bool = new ExposedBool("compress");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("exportAssets"))
		{
			bool = new ExposedBool("exportAssets", "include assets");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("useSimpleJSON"))
		{
			bool = new ExposedBool("useSimpleJSON", "simple JSON");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("useZip"))
		{
			bool = new ExposedBool("useZip", "ZIP");
			#if !(desktop || air)
			bool.isEditable = false;
			#end
			collection.addValue(bool, groupName);
		}
		
		return collection;
	}
	
	static public function exposeFileSettings(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var combo:ExposedSelectCombo;
		var floatDrag:ExposedFloatDrag;
		var funcExternal:ExposedFunctionExternal;
		var intDrag:ExposedIntDrag;
		var object:ExposedObject;
		#if (desktop || air)
		var path:ExposedPath;
		#end
		var select:ExposedSelect;
		var str:ExposedString;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("rootContainerClass"))
		{
			combo = new ExposedSelectCombo("rootContainerClass", "root container class", ValEditor.rootContainerClassNames, ValEditor.rootContainerClasses);
			combo.iconFromValueProperty = "iconBitmapData";
			combo.defaultValue = "undefined";
			combo.value = "undefined";
			combo.isMandatory = true;
			collection.addValue(combo, groupName);
			//select = new ExposedSelect("rootContainerClass", "root container class", ValEditor.rootContainerClassNames, ValEditor.rootContainerClasses);
			//select.iconFromValueProperty = "iconBitmapData";
			//select.defaultValue = "undefined";
			//select.value = "undefined";
			//select.isMandatory = true;
			//collection.addValue(select, groupName);
			collection.registerForValueChangeExternal("rootContainerClass", rootContainerClassChange);
		}
		
		#if (desktop || air)
		if (!collection.hasValue("filePath"))
		{
			path = new ExposedPath("filePath", "file path");
			path.dialogTitle = "file path";
			collection.addValue(path, groupName);
		}
		#end
		
		if (!collection.hasValue("fileName"))
		{
			str = new ExposedString("fileName", "file name", 0);// , "a-z A-Z 0-9 éèêàâôçùü.-_()");
			collection.addValue(str, groupName);
		}
		
		if (!collection.hasValue("compress"))
		{
			bool = new ExposedBool("compress");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("frameRateDefault"))
		{
			floatDrag = new ExposedFloatDrag("frameRateDefault", "default frame rate", 0, 300);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("numFramesDefault"))
		{
			intDrag = new ExposedIntDrag("numFramesDefault", "default num frames", 1, 6000);
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("numFramesAutoIncrease"))
		{
			bool = new ExposedBool("numFramesAutoIncrease", "auto increase num frames");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("tweenTransitionDefault"))
		{
			select = new ExposedSelect("tweenTransitionDefault", "default tween transition", Transitions.transitionNames, Transitions.transitionNames);
			collection.addValue(select, groupName);
		}
		
		if (!collection.hasValue("editClassVisibilitiesFile"))
		{
			funcExternal = new ExposedFunctionExternal("editClassVisibilitiesFile", "edit class visibilities", ValEditor);
			collection.addValue(funcExternal, groupName);
		}
		
		#if starling
		if (!collection.hasValue("starlingSettings"))
		{
			object = new ExposedObject("starlingSettings", "starling settings");
			collection.addValue(object, groupName);
		}
		#end
		
		return collection;
	}
	
	static private function rootContainerClassChange(classValue:ExposedValue):Void
	{
		var clss:ValEditorClass = classValue.value;
		var obj:ValEditorObject = null;
		var value:ExposedValue;
		
		if (clss != null)
		{
			obj = ValEditor.createObjectWithClassName(clss.className, "rootContainerClassChange", null, null, "rootContainerClassChange");
		}
		
		if (obj != null && Std.isOfType(obj.object, ITimeLineContainerEditable))
		{
			value = classValue.collection.getValue("frameRateDefault");
			value.isReadOnly = false;
			
			value = classValue.collection.getValue("numFramesDefault");
			value.isReadOnly = false;
			
			value = classValue.collection.getValue("numFramesAutoIncrease");
			value.isReadOnly = false;
			
			value = classValue.collection.getValue("tweenTransitionDefault");
			value.isReadOnly = false;
		}
		else
		{
			value = classValue.collection.getValue("frameRateDefault");
			value.isReadOnly = true;
			
			value = classValue.collection.getValue("numFramesDefault");
			value.isReadOnly = true;
			
			value = classValue.collection.getValue("numFramesAutoIncrease");
			value.isReadOnly = true;
			
			value = classValue.collection.getValue("tweenTransitionDefault");
			value.isReadOnly = true;
		}
		
		if (obj != null)
		{
			ValEditor.destroyObject(obj);
		}
	}
	
	static public function exposeInteractiveObjectController(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var color:ExposedColor;
		var floatDrag:ExposedFloatDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("debug"))
		{
			bool = new ExposedBool("debug");
			collection.addValue(bool, groupName);
		}
		
		if (!collection.hasValue("debugAlpha"))
		{
			floatDrag = new ExposedFloatDrag("debugAlpha", null, 0.0, 1.0, 0.01, 0.01);
			collection.addValue(floatDrag, groupName);
		}
		
		if (!collection.hasValue("debugColor"))
		{
			color = new ExposedColor("debugColor");
			collection.addValue(color, groupName);
		}
		
		return collection;
	}
	
	static public function exposeStarlingSettings(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var floatDrag:ExposedFloatDrag;
		var intDrag:ExposedIntDrag;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("antiAliasing"))
		{
			intDrag = new ExposedIntDrag("antiAliasing", null, 0, 16);
			collection.addValue(intDrag, groupName);
		}
		
		if (!collection.hasValue("fieldOfView"))
		{
			floatDrag = new ExposedFloatDrag("fieldOfView", null, 0, 3.10, 0.05);
			floatDrag.toolTip = "This only affects Sprite3D instances and their children";
			collection.addValue(floatDrag, groupName);
		}
		
		return collection;
	}
	
}