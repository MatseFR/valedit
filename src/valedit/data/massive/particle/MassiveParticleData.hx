package valedit.data.massive.particle;
//#if massive-starling
import massive.data.MassiveConstants;
import massive.particle.AngleRelativeTo;
import massive.particle.EmitterType;
import massive.particle.OscillationFrequencyMode;
import massive.particle.OscillationFrequencyStart;
import valedit.ExposedCollection;
import valedit.data.massive.display.MassiveDisplayData;
import valedit.value.ExposedBool;
import valedit.value.ExposedFloatDrag;
import valedit.value.ExposedFunction;
import valedit.value.ExposedGroup;
import valedit.value.ExposedIntDrag;
import valedit.value.ExposedObject;
import valedit.value.ExposedSelect;
import valedit.value.base.ExposedValue;

/**
 * ...
 * @author Matse
 */
class MassiveParticleData 
{
	
	static public function exposeParticle(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		
		
		return collection;
	}
	
	static public function exposeParticleEmitter(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		if (collection == null) collection = new ExposedCollection();
		
		
		
		return collection;
	}

	static public function exposeParticleSystem(?collection:ExposedCollection, ?groupName:String):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var func:ExposedFunction;
		var group:ExposedGroup;
		var intDrag:ExposedIntDrag;
		var obj:ExposedObject;
		var select:ExposedSelect;
		var subGroup:ExposedGroup;
		
		if (collection == null) collection = new ExposedCollection();
		
		if (!collection.hasValue("start"))
		{
			func = new ExposedFunction("start");
			floatDrag = new ExposedFloatDrag("duration", null, -1, null, 0.01);
			func.addParameter(floatDrag);
			collection.addValue(func, groupName);
		}
		
		if (!collection.hasValue("stop"))
		{
			func = new ExposedFunction("stop");
			bool = new ExposedBool("clear");
			func.addParameter(bool);
			collection.addValue(func, groupName);
		}
		
		// Emitter
		if (!collection.hasGroup("Emitter"))
		{
			group = new ExposedGroup("Emitter");
			group.isUIOpen = true;
			collection.addValue(group, groupName);
		}
		else
		{
			group = collection.getGroup("Emitter");
		}
		
		if (!group.hasValue("emitterType"))
		{
			select = new ExposedSelect("emitterType");
			select.add("gravity", EmitterType.GRAVITY);
			select.add("radial", EmitterType.RADIAL);
			group.addValue(select);
		}
		
		if (!group.hasValue("maxNumParticles"))
		{
			intDrag = new ExposedIntDrag("maxNumParticles", null, 0, MassiveConstants.MAX_QUADS);
			group.addValue(intDrag);
		}
		
		if (!group.hasValue("particleAmount"))
		{
			intDrag = new ExposedIntDrag("particleAmount", null, 0);
			group.addValue(intDrag);
		}
		
		if (!group.hasValue("autoSetEmissionRate"))
		{
			bool = new ExposedBool("autoSetEmissionRate");
			group.addValue(bool);
			
			collection.registerForValueChangeExternal("autoSetEmissionRate", autoSetEmissionRateChange);
		}
		
		if (!group.hasValue("emissionRate"))
		{
			floatDrag = new ExposedFloatDrag("emissionRate", null, 0.0);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("emissionRatio"))
		{
			floatDrag = new ExposedFloatDrag("emissionRatio", null, 0.0, 1.0, 0.01);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("emitterX"))
		{
			floatDrag = new ExposedFloatDrag("emitterX");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("emitterY"))
		{
			floatDrag = new ExposedFloatDrag("emitterY");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("emitterXVariance"))
		{
			floatDrag = new ExposedFloatDrag("emitterXVariance");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("emitterYVariance"))
		{
			floatDrag = new ExposedFloatDrag("emitterYVariance");
			group.addValue(floatDrag);
		}
		
		if (!group.hasGroup("Radius"))
		{
			subGroup = new ExposedGroup("Radius");
			group.addValue(subGroup);
		}
		else
		{
			subGroup = group.getGroup("Radius");
		}
		
		if (!subGroup.hasValue("emitterRadiusMin"))
		{
			floatDrag = new ExposedFloatDrag("emitterRadiusMin", "min");
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("emitterRadiusMinVariance"))
		{
			floatDrag = new ExposedFloatDrag("emitterRadiusMinVariance", "min variance");
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("emitterRadiusMax"))
		{
			floatDrag = new ExposedFloatDrag("emitterRadiusMax", "max");
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("emitterRadiusMaxVariance"))
		{
			floatDrag = new ExposedFloatDrag("emitterRadiusMaxVariance", "max variance");
			subGroup.addValue(floatDrag);
		}
		
		if (!group.hasValue("emitAngle"))
		{
			floatDrag = new ExposedFloatDrag("emitAngle", null, null, null, 0.005, 0.005);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("emitAngleVariance"))
		{
			floatDrag = new ExposedFloatDrag("emitAngleVariance", null, null, null, 0.005, 0.005);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("emitAngleAlignedRotation"))
		{
			bool = new ExposedBool("emitAngleAlignedRotation");
			group.addValue(bool);
		}
		
		if (!group.hasValue("useDisplayRect"))
		{
			bool = new ExposedBool("useDisplayRect");
			group.addValue(bool);
		}
		
		if (!group.hasValue("displayRect"))
		{
			obj = new ExposedObject("displayRect");
			group.addValue(obj);
		}
		
		// Particle
		if (!collection.hasGroup("Particle"))
		{
			group = new ExposedGroup("Particle");
			collection.addValue(group, groupName);
		}
		else
		{
			group = collection.getGroup("Particle");
		}
		
		if (!group.hasValue("useAnimationLifeSpan"))
		{
			bool = new ExposedBool("useAnimationLifeSpan");
			group.addValue(bool);
			
			collection.registerForValueChangeExternal("useAnimationLifeSpan", useAnimationLifeSpanChange);
		}
		
		if (!group.hasValue("lifeSpan"))
		{
			floatDrag = new ExposedFloatDrag("lifeSpan", null, 0.05, null, 0.05);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("lifeSpanVariance"))
		{
			floatDrag = new ExposedFloatDrag("lifeSpanVariance", null, 0.0, null, 0.05);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("fadeInTime"))
		{
			floatDrag = new ExposedFloatDrag("fadeInTime", null, 0.0, null, 0.005, 0.005);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("fadeOutTime"))
		{
			floatDrag = new ExposedFloatDrag("fadeOutTime", null, 0.0, null, 0.005, 0.005);
			group.addValue(floatDrag);
		}
		
		if (!group.hasGroup("Size"))
		{
			subGroup = new ExposedGroup("Size");
			group.addValue(subGroup);
		}
		else
		{
			subGroup = group.getGroup("Size");
		}
		
		if (!subGroup.hasValue("sizeXStart"))
		{
			floatDrag = new ExposedFloatDrag("sizeXStart", "x start");
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("sizeXStartVariance"))
		{
			floatDrag = new ExposedFloatDrag("sizeXStartVariance", "x start variance");
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("sizeYStart"))
		{
			floatDrag = new ExposedFloatDrag("sizeYStart", "y start");
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("sizeYStartVariance"))
		{
			floatDrag = new ExposedFloatDrag("sizeYStartVariance", "y start variance");
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("sizeXEnd"))
		{
			floatDrag = new ExposedFloatDrag("sizeXEnd", "x end");
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("sizeXEndVariance"))
		{
			floatDrag = new ExposedFloatDrag("sizeXEndVariance", "x end variance");
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("sizeYEnd"))
		{
			floatDrag = new ExposedFloatDrag("sizeYEnd", "y end");
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("sizeYEndVariance"))
		{
			floatDrag = new ExposedFloatDrag("sizeYEndVariance", "y end variance");
			subGroup.addValue(floatDrag);
		}
		
		if (!group.hasGroup("Rotation"))
		{
			subGroup = new ExposedGroup("Rotation");
			group.addValue(subGroup);
		}
		else
		{
			subGroup = group.getGroup("Rotation");
		}
		
		if (!subGroup.hasValue("rotationStart"))
		{
			floatDrag = new ExposedFloatDrag("rotationStart", "start", null, null, 0.005, 0.005);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("rotationStartVariance"))
		{
			floatDrag = new ExposedFloatDrag("rotationStartVariance", "start variance", null, null, 0.005, 0.005);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("rotationEnd"))
		{
			floatDrag = new ExposedFloatDrag("rotationEnd", "end", null, null, 0.005, 0.005);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("rotationEndVariance"))
		{
			floatDrag = new ExposedFloatDrag("rotationEndVariance", "end variance", null, null, 0.005, 0.005);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("rotationEndRelativeToStart"))
		{
			bool = new ExposedBool("rotationEndRelativeToStart", "relative to start");
			subGroup.addValue(bool);
		}
		
		// Animation
		if (!collection.hasGroup("Animation"))
		{
			group = new ExposedGroup("Animation");
			collection.addValue(group, groupName);
		}
		else
		{
			group = collection.getGroup("Animation");
		}
		
		//if (!group.hasValue("animate"))
		//{
			//bool = new ExposedBool("animate");
			//group.addValue(bool);
		//}
		
		//if (!group.hasValue("textureAnimation"))
		//{
			//bool = new ExposedBool("textureAnimation");
			//group.addValue(bool);
		//}
		
		//if (!group.hasValue("frameRate"))
		//{
			//floatDrag = new ExposedFloatDrag("frameRate", null, 1);
			//group.addValue(floatDrag);
		//}
		
		if (!group.hasValue("frameDelta"))
		{
			floatDrag = new ExposedFloatDrag("frameDelta", null, 0.0, null, 0.01);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("frameDeltaVariance"))
		{
			floatDrag = new ExposedFloatDrag("frameDeltaVariance", null, 0.0, null, 0.01);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("loopAnimation"))
		{
			bool = new ExposedBool("loopAnimation");
			group.addValue(bool);
		}
		
		if (!group.hasValue("animationLoops"))
		{
			intDrag = new ExposedIntDrag("animationLoops");
			group.addValue(intDrag);
		}
		
		if (!group.hasValue("randomStartFrame"))
		{
			bool = new ExposedBool("randomStartFrame");
			group.addValue(bool);
		}
		
		// gravity config
		if (!collection.hasGroup("Gravity config"))
		{
			group = new ExposedGroup("Gravity config");
			collection.addValue(group, groupName);
		}
		else
		{
			group = collection.getGroup("Gravity config");
		}
		
		if (!group.hasValue("speed"))
		{
			floatDrag = new ExposedFloatDrag("speed");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("speedVariance"))
		{
			floatDrag = new ExposedFloatDrag("speedVariance");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("adjustLifeSpanToSpeed"))
		{
			bool = new ExposedBool("adjustLifeSpanToSpeed");
			group.addValue(bool);
		}
		
		if (!group.hasValue("gravityX"))
		{
			floatDrag = new ExposedFloatDrag("gravityX");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("gravityY"))
		{
			floatDrag = new ExposedFloatDrag("gravityY");
			group.addValue(floatDrag);
		}
		
		if (!group.hasGroup("Acceleration"))
		{
			subGroup = new ExposedGroup("Acceleration");
			group.addValue(subGroup);
		}
		else
		{
			subGroup = group.getGroup("Acceleration");
		}
		
		if (!subGroup.hasValue("radialAcceleration"))
		{
			floatDrag = new ExposedFloatDrag("radialAcceleration", "radial");
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("radialAccelerationVariance"))
		{
			floatDrag = new ExposedFloatDrag("radialAccelerationVariance", "radial variance");
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("tangentialAcceleration"))
		{
			floatDrag = new ExposedFloatDrag("tangentialAcceleration", "tangential");
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("tangentialAccelerationVariance"))
		{
			floatDrag = new ExposedFloatDrag("tangentialAccelerationVariance", "tangential variance");
			subGroup.addValue(floatDrag);
		}
		
		if (!group.hasValue("drag"))
		{
			floatDrag = new ExposedFloatDrag("drag", null, null, null, 0.01, 0.01);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("dragVariance"))
		{
			floatDrag = new ExposedFloatDrag("dragVariance", null, null, null, 0.01, 0.01);
			group.addValue(floatDrag);
		}
		
		//if (!group.hasValue("repellentForce"))
		//{
			//floatDrag = new ExposedFloatDrag("repellentForce");// , null, null, null, 0.001, 0.001);
			//group.addValue(floatDrag);
		//}
		
		// radial config
		if (!collection.hasGroup("Radial config"))
		{
			group = new ExposedGroup("Radial config");
			collection.addValue(group, groupName);
		}
		else
		{
			group = collection.getGroup("Radial config");
		}
		
		if (!group.hasValue("radiusMin"))
		{
			floatDrag = new ExposedFloatDrag("radiusMin");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("radiusMinVariance"))
		{
			floatDrag = new ExposedFloatDrag("radiusMinVariance");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("radiusMax"))
		{
			floatDrag = new ExposedFloatDrag("radiusMax");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("radiusMaxVariance"))
		{
			floatDrag = new ExposedFloatDrag("radiusMaxVariance");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("rotatePerSecond"))
		{
			floatDrag = new ExposedFloatDrag("rotatePerSecond", null, null, null, 0.05);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("rotatePerSecondVariance"))
		{
			floatDrag = new ExposedFloatDrag("rotatePerSecondVariance", null, null, null, 0.05);
			group.addValue(floatDrag);
		}
		
		// color
		if (!collection.hasGroup("Color"))
		{
			group = new ExposedGroup("Color");
			collection.addValue(group, groupName);
		}
		else
		{
			group = collection.getGroup("Color");
		}
		
		if (!group.hasValue("colorStart"))
		{
			obj = new ExposedObject("colorStart");
			obj.isUIOpen = true;
			group.addValue(obj);
		}
		
		if (!group.hasValue("colorStartVariance"))
		{
			obj = new ExposedObject("colorStartVariance");
			//obj.isUIOpen = true;
			group.addValue(obj);
		}
		
		if (!group.hasValue("colorEnd"))
		{
			obj = new ExposedObject("colorEnd");
			obj.isUIOpen = true;
			group.addValue(obj);
		}
		
		if (!group.hasValue("colorEndVariance"))
		{
			obj = new ExposedObject("colorEndVariance");
			//obj.isUIOpen = true;
			group.addValue(obj);
		}
		
		if (!group.hasValue("colorEndRelativeToStart"))
		{
			bool = new ExposedBool("colorEndRelativeToStart", "end relative to start");
			group.addValue(bool);
			
			collection.registerForValueChangeExternal("colorEndRelativeToStart", colorEndRelativeToStartChange);
		}
		
		if (!group.hasValue("colorEndIsMultiplier"))
		{
			bool = new ExposedBool("colorEndIsMultiplier", "end is multiplier");
			group.addValue(bool);
		}
		
		// Velocity
		if (!collection.hasGroup("Velocity"))
		{
			group = new ExposedGroup("Velocity");
			collection.addValue(group, groupName);
		}
		else
		{
			group = collection.getGroup("Velocity");
		}
		
		if (!group.hasGroup("Inheritance"))
		{
			subGroup = new ExposedGroup("Inheritance");
			group.addValue(subGroup);
		}
		else
		{
			subGroup = group.getGroup("Inheritance");
		}
		
		if (!subGroup.hasValue("velocityXInheritRatio"))
		{
			floatDrag = new ExposedFloatDrag("velocityXInheritRatio", "x ratio", null, null, 0.01, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("velocityXInheritRatioVariance"))
		{
			floatDrag = new ExposedFloatDrag("velocityXInheritRatioVariance", "x ratio variance", null, null, 0.01, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("velocityYInheritRatio"))
		{
			floatDrag = new ExposedFloatDrag("velocityYInheritRatio", "y ratio", null, null, 0.01, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("velocityYInheritRatioVariance"))
		{
			floatDrag = new ExposedFloatDrag("velocityYInheritRatioVariance", "y ratio variance", null, null, 0.01, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!group.hasValue("velocityX"))
		{
			floatDrag = new ExposedFloatDrag("velocityX");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("velocityY"))
		{
			floatDrag = new ExposedFloatDrag("velocityY");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("velocityScaleFactorX"))
		{
			floatDrag = new ExposedFloatDrag("velocityScaleFactorX", null, null, null, 0.0001, 0.0001);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("velocityScaleFactorY"))
		{
			floatDrag = new ExposedFloatDrag("velocityScaleFactorY", null, null, null, 0.0001, 0.0001);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("linkRotationToVelocity"))
		{
			bool = new ExposedBool("linkRotationToVelocity");
			group.addValue(bool);
		}
		
		collection.registerForValueChangeExternal("linkRotationToVelocity", linkRotationToVelocityChange);
		
		if (!group.hasValue("velocityRotationOffset"))
		{
			floatDrag = new ExposedFloatDrag("velocityRotationOffset", null, null, null, 0.005, 0.005);
			group.addValue(floatDrag);
		}
		
		// oscillation
		if (!collection.hasGroup("Oscillation"))
		{
			group = new ExposedGroup("Oscillation");
			collection.addValue(group, groupName);
		}
		else
		{
			group = collection.getGroup("Oscillation");
		}
		
		if (!group.hasValue("oscillationGlobalFrequency"))
		{
			floatDrag = new ExposedFloatDrag("oscillationGlobalFrequency", "global frequency", null, null, 0.1);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("oscillationUnifiedFrequencyVariance"))
		{
			floatDrag = new ExposedFloatDrag("oscillationUnifiedFrequencyVariance", "unified frequency variance", null, null, 0.1);
			group.addValue(floatDrag);
		}
		
		if (!group.hasGroup("Position"))
		{
			subGroup = new ExposedGroup("Position");
			group.addValue(subGroup);
		}
		else
		{
			subGroup = group.getGroup("Position");
		}
		
		if (!subGroup.hasValue("oscillationPositionFrequencyMode"))
		{
			select = new ExposedSelect("oscillationPositionFrequencyMode", "frequency mode");
			select.choiceListFunction = OscillationFrequencyMode.getValues;
			select.valueListFunction = OscillationFrequencyMode.getValues;
			subGroup.addValue(select);
			
			collection.registerForValueChangeExternal("oscillationPositionFrequencyMode", oscillationPositionFrequencyModeChange);
		}
		
		if (!subGroup.hasValue("oscillationPositionAngle"))
		{
			floatDrag = new ExposedFloatDrag("oscillationPositionAngle", "angle", null, null, 0.005, 0.005);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationPositionAngleVariance"))
		{
			floatDrag = new ExposedFloatDrag("oscillationPositionAngleVariance", "angle variance", null, null, 0.005, 0.005);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationPositionAngleRelativeTo"))
		{
			select = new ExposedSelect("oscillationPositionAngleRelativeTo", "angle relative to");
			select.choiceListFunction = AngleRelativeTo.getValues;
			select.valueListFunction = AngleRelativeTo.getValues;
			subGroup.addValue(select);
		}
		
		if (!subGroup.hasValue("oscillationPositionRadius"))
		{
			floatDrag = new ExposedFloatDrag("oscillationPositionRadius", "radius");
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationPositionRadiusVariance"))
		{
			floatDrag = new ExposedFloatDrag("oscillationPositionRadiusVariance", "radius variance");
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationPositionFrequency"))
		{
			floatDrag = new ExposedFloatDrag("oscillationPositionFrequency", "frequency", null, null, 0.1);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationPositionUnifiedFrequencyVariance"))
		{
			bool = new ExposedBool("oscillationPositionUnifiedFrequencyVariance", "unified frequency variance");
			subGroup.addValue(bool);
			
			collection.registerForValueChangeExternal("oscillationPositionUnifiedFrequencyVariance", oscillationPositionUnifiedFrequencyVarianceChange);
		}
		
		if (!subGroup.hasValue("oscillationPositionFrequencyVariance"))
		{
			floatDrag = new ExposedFloatDrag("oscillationPositionFrequencyVariance", "frequency variance", null, null, 0.1);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationPositionFrequencyInverted"))
		{
			bool = new ExposedBool("oscillationPositionFrequencyInverted", "invert frequency");
			subGroup.addValue(bool);
		}
		
		if (!subGroup.hasValue("oscillationPositionFrequencyStart"))
		{
			select = new ExposedSelect("oscillationPositionFrequencyStart", "frequency start");
			select.choiceListFunction = OscillationFrequencyStart.getValues;
			select.valueListFunction = OscillationFrequencyStart.getValues;
			subGroup.addValue(select);
		}
		
		if (!group.hasGroup("Position2"))
		{
			subGroup = new ExposedGroup("Position2");
			group.addValue(subGroup);
		}
		else
		{
			subGroup = group.getGroup("Position2");
		}
		
		if (!subGroup.hasValue("oscillationPosition2FrequencyMode"))
		{
			select = new ExposedSelect("oscillationPosition2FrequencyMode", "frequency mode");
			select.choiceListFunction = OscillationFrequencyMode.getValues;
			select.valueListFunction = OscillationFrequencyMode.getValues;
			subGroup.addValue(select);
			
			collection.registerForValueChangeExternal("oscillationPosition2FrequencyMode", oscillationPosition2FrequencyModeChange);
		}
		
		if (!subGroup.hasValue("oscillationPosition2Angle"))
		{
			floatDrag = new ExposedFloatDrag("oscillationPosition2Angle", "angle", null, null, 0.005, 0.005);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationPosition2AngleVariance"))
		{
			floatDrag = new ExposedFloatDrag("oscillationPosition2AngleVariance", "angle variance", null, null, 0.005, 0.005);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationPosition2AngleRelativeTo"))
		{
			select = new ExposedSelect("oscillationPosition2AngleRelativeTo", "angle relative to");
			select.choiceListFunction = AngleRelativeTo.getValues;
			select.valueListFunction = AngleRelativeTo.getValues;
			subGroup.addValue(select);
		}
		
		if (!subGroup.hasValue("oscillationPosition2Radius"))
		{
			floatDrag = new ExposedFloatDrag("oscillationPosition2Radius", "radius");
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationPosition2RadiusVariance"))
		{
			floatDrag = new ExposedFloatDrag("oscillationPosition2RadiusVariance", "radius variance");
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationPosition2Frequency"))
		{
			floatDrag = new ExposedFloatDrag("oscillationPosition2Frequency", "frequency", null, null, 0.1);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationPosition2UnifiedFrequencyVariance"))
		{
			bool = new ExposedBool("oscillationPosition2UnifiedFrequencyVariance", "unified frequency variance");
			subGroup.addValue(bool);
			
			collection.registerForValueChangeExternal("oscillationPosition2UnifiedFrequencyVariance", oscillationPosition2UnifiedFrequencyVarianceChange);
		}
		
		if (!subGroup.hasValue("oscillationPosition2FrequencyVariance"))
		{
			floatDrag = new ExposedFloatDrag("oscillationPosition2FrequencyVariance", "frequency variance", null, null, 0.1);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationPosition2FrequencyInverted"))
		{
			bool = new ExposedBool("oscillationPosition2FrequencyInverted", "invert frequency");
			subGroup.addValue(bool);
		}
		
		if (!subGroup.hasValue("oscillationPosition2FrequencyStart"))
		{
			select = new ExposedSelect("oscillationPosition2FrequencyStart", "frequency start");
			select.choiceListFunction = OscillationFrequencyStart.getValues;
			select.valueListFunction = OscillationFrequencyStart.getValues;
			subGroup.addValue(select);
		}
		
		if (!group.hasGroup("Rotation"))
		{
			subGroup = new ExposedGroup("Rotation");
			group.addValue(subGroup);
		}
		else
		{
			subGroup = group.getGroup("Rotation");
		}
		
		if (!subGroup.hasValue("oscillationRotationFrequencyMode"))
		{
			select = new ExposedSelect("oscillationRotationFrequencyMode", "frequency mode");
			select.choiceListFunction = OscillationFrequencyMode.getValues;
			select.valueListFunction = OscillationFrequencyMode.getValues;
			subGroup.addValue(select);
			
			collection.registerForValueChangeExternal("oscillationRotationFrequencyMode", oscillationRotationFrequencyModeChange);
		}
		
		if (!subGroup.hasValue("oscillationRotationAngle"))
		{
			floatDrag = new ExposedFloatDrag("oscillationRotationAngle", "angle", null, null, 0.005, 0.005);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationRotationAngleVariance"))
		{
			floatDrag = new ExposedFloatDrag("oscillationRotationAngleVariance", "angle variance", null, null, 0.005, 0.005);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationRotationFrequency"))
		{
			floatDrag = new ExposedFloatDrag("oscillationRotationFrequency", "frequency", null, null, 0.1);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationRotationUnifiedFrequencyVariance"))
		{
			bool = new ExposedBool("oscillationRotationUnifiedFrequencyVariance", "unified frequency variance");
			subGroup.addValue(bool);
			
			collection.registerForValueChangeExternal("oscillationRotationUnifiedFrequencyVariance", oscillationRotationUnifiedFrequencyVarianceChange);
		}
		
		if (!subGroup.hasValue("oscillationRotationFrequencyVariance"))
		{
			floatDrag = new ExposedFloatDrag("oscillationRotationFrequencyVariance", "frequency variance", null, null, 0.1);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationRotationFrequencyInverted"))
		{
			bool = new ExposedBool("oscillationRotationFrequencyInverted", "invert frequency");
			subGroup.addValue(bool);
		}
		
		if (!subGroup.hasValue("oscillationRotationFrequencyStart"))
		{
			select = new ExposedSelect("oscillationRotationFrequencyStart", "frequency start");
			select.choiceListFunction = OscillationFrequencyStart.getValues;
			select.valueListFunction = OscillationFrequencyStart.getValues;
			subGroup.addValue(select);
		}
		
		if (!group.hasGroup("ScaleX"))
		{
			subGroup = new ExposedGroup("ScaleX");
			group.addValue(subGroup);
		}
		else
		{
			subGroup = group.getGroup("ScaleX");
		}
		
		if (!subGroup.hasValue("oscillationScaleXFrequencyMode"))
		{
			select = new ExposedSelect("oscillationScaleXFrequencyMode", "frequency mode");
			select.choiceListFunction = OscillationFrequencyMode.getValues;
			select.valueListFunction = OscillationFrequencyMode.getValues;
			subGroup.addValue(select);
			
			collection.registerForValueChangeExternal("oscillationScaleXFrequencyMode", oscillationScaleXFrequencyModeChange);
		}
		
		if (!subGroup.hasValue("oscillationScaleX"))
		{
			floatDrag = new ExposedFloatDrag("oscillationScaleX", "x", null, null, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationScaleXVariance"))
		{
			floatDrag = new ExposedFloatDrag("oscillationScaleXVariance", "x variance", null, null, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationScaleXFrequency"))
		{
			floatDrag = new ExposedFloatDrag("oscillationScaleXFrequency", "x frequency", null, null, 0.1);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationScaleXUnifiedFrequencyVariance"))
		{
			bool = new ExposedBool("oscillationScaleXUnifiedFrequencyVariance", "unified frequency variance");
			subGroup.addValue(bool);
			
			collection.registerForValueChangeExternal("oscillationScaleXUnifiedFrequencyVariance", oscillationScaleXUnifiedFrequencyVarianceChange);
		}
		
		if (!subGroup.hasValue("oscillationScaleXFrequencyVariance"))
		{
			floatDrag = new ExposedFloatDrag("oscillationScaleXFrequencyVariance", "x frequency variance", null, null, 0.1);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationScaleXFrequencyInverted"))
		{
			bool = new ExposedBool("oscillationScaleXFrequencyInverted", "invert x frequency");
			subGroup.addValue(bool);
		}
		
		if (!subGroup.hasValue("oscillationScaleXFrequencyStart"))
		{
			select = new ExposedSelect("oscillationScaleXFrequencyStart", "frequency start");
			select.choiceListFunction = OscillationFrequencyStart.getValues;
			select.valueListFunction = OscillationFrequencyStart.getValues;
			subGroup.addValue(select);
		}
		
		if (!group.hasGroup("ScaleY"))
		{
			subGroup = new ExposedGroup("ScaleY");
			group.addValue(subGroup);
		}
		else
		{
			subGroup = group.getGroup("ScaleY");
		}
		
		if (!subGroup.hasValue("oscillationScaleYFrequencyMode"))
		{
			select = new ExposedSelect("oscillationScaleYFrequencyMode", "frequency mode");
			select.choiceListFunction = OscillationFrequencyMode.getValues;
			select.valueListFunction = OscillationFrequencyMode.getValues;
			subGroup.addValue(select);
			
			collection.registerForValueChangeExternal("oscillationScaleYFrequencyMode", oscillationScaleYFrequencyModeChange);
		}
		
		if (!subGroup.hasValue("oscillationScaleY"))
		{
			floatDrag = new ExposedFloatDrag("oscillationScaleY", "y", null, null, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationScaleYVariance"))
		{
			floatDrag = new ExposedFloatDrag("oscillationScaleYVariance", "y variance", null, null, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationScaleYFrequency"))
		{
			floatDrag = new ExposedFloatDrag("oscillationScaleYFrequency", "y frequency", null, null, 0.1);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationScaleYUnifiedFrequencyVariance"))
		{
			bool = new ExposedBool("oscillationScaleYUnifiedFrequencyVariance", "unified frequency variance");
			subGroup.addValue(bool);
			
			collection.registerForValueChangeExternal("oscillationScaleYUnifiedFrequencyVariance", oscillationScaleYUnifiedFrequencyVarianceChange);
		}
		
		if (!subGroup.hasValue("oscillationScaleYFrequencyVariance"))
		{
			floatDrag = new ExposedFloatDrag("oscillationScaleYFrequencyVariance", "y frequency variance", null, null, 0.1);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationScaleYFrequencyInverted"))
		{
			bool = new ExposedBool("oscillationScaleYFrequencyInverted", "invert y frequency");
			subGroup.addValue(bool);
		}
		
		if (!subGroup.hasValue("oscillationScaleYFrequencyStart"))
		{
			select = new ExposedSelect("oscillationScaleYFrequencyStart", "frequency start");
			select.choiceListFunction = OscillationFrequencyStart.getValues;
			select.valueListFunction = OscillationFrequencyStart.getValues;
			subGroup.addValue(select);
		}
		
		if (!group.hasGroup("Color"))
		{
			subGroup = new ExposedGroup("Color");
			group.addValue(subGroup);
		}
		else
		{
			subGroup = group.getGroup("Color");
		}
		
		if (!subGroup.hasValue("oscillationColorFrequencyMode"))
		{
			select = new ExposedSelect("oscillationColorFrequencyMode", "frequency mode");
			select.choiceListFunction = OscillationFrequencyMode.getValues;
			select.valueListFunction = OscillationFrequencyMode.getValues;
			subGroup.addValue(select);
			
			collection.registerForValueChangeExternal("oscillationColorFrequencyMode", oscillationColorFrequencyModeChange);
		}
		
		if (!subGroup.hasValue("oscillationColorRed"))
		{
			floatDrag = new ExposedFloatDrag("oscillationColorRed", "red", -1.0, 10.0, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationColorGreen"))
		{
			floatDrag = new ExposedFloatDrag("oscillationColorGreen", "green", -1.0, 10.0, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationColorBlue"))
		{
			floatDrag = new ExposedFloatDrag("oscillationColorBlue", "blue", -1.0, 10.0, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationColorAlpha"))
		{
			floatDrag = new ExposedFloatDrag("oscillationColorAlpha", "alpha", -1.0, 10.0, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationColorRedVariance"))
		{
			floatDrag = new ExposedFloatDrag("oscillationColorRedVariance", "red variance", 0.0, 10.0, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationColorGreenVariance"))
		{
			floatDrag = new ExposedFloatDrag("oscillationColorGreenVariance", "green variance", 0.0, 10.0, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationColorBlueVariance"))
		{
			floatDrag = new ExposedFloatDrag("oscillationColorBlueVariance", "blue variance", 0.0, 10.0, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationColorAlphaVariance"))
		{
			floatDrag = new ExposedFloatDrag("oscillationColorAlphaVariance", "alpha variance", 0.0, 1.0, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationColorFrequency"))
		{
			floatDrag = new ExposedFloatDrag("oscillationColorFrequency", "frequency", null, null, 0.1);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationColorUnifiedFrequencyVariance"))
		{
			bool = new ExposedBool("oscillationColorUnifiedFrequencyVariance", "unified frequency variance");
			subGroup.addValue(bool);
			
			collection.registerForValueChangeExternal("oscillationColorUnifiedFrequencyVariance", oscillationColorUnifiedFrequencyVarianceChange);
		}
		
		if (!subGroup.hasValue("oscillationColorFrequencyVariance"))
		{
			floatDrag = new ExposedFloatDrag("oscillationColorFrequencyVariance", "frequency variance", null, null, 0.1);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationColorFrequencyInverted"))
		{
			bool = new ExposedBool("oscillationColorFrequencyInverted", "invert frequency");
			subGroup.addValue(bool);
		}
		
		if (!subGroup.hasValue("oscillationColorFrequencyStart"))
		{
			select = new ExposedSelect("oscillationColorFrequencyStart", "frequency start");
			select.choiceListFunction = OscillationFrequencyStart.getValues;
			select.valueListFunction = OscillationFrequencyStart.getValues;
			subGroup.addValue(select);
		}
		
		MassiveDisplayData.exposeMassiveImageLayer(collection, groupName);
		
		return collection;
	}
	
	static private function autoSetEmissionRateChange(autoSetValue:ExposedValue):Void
	{
		var value:ExposedValue = autoSetValue.collection.getValue("emissionRate");
		if (autoSetValue.value == true)
		{
			value.isReadOnly = true;
		}
		else
		{
			value.isReadOnly = false;
		}
	}
	
	static private function useAnimationLifeSpanChange(useValue:ExposedValue):Void
	{
		var collection:ExposedCollection = useValue.collection;
		var enabled:Bool = useValue.value;
		var value:ExposedValue;
		
		value = collection.getValue("lifeSpan");
		value.isReadOnly = enabled;
		
		value = collection.getValue("lifeSpanVariance");
		value.isReadOnly = enabled;
	}
	
	static private function colorEndRelativeToStartChange(colorEndValue:ExposedValue):Void
	{
		var value:ExposedValue = colorEndValue.collection.getValue("colorEndIsMultiplier");
		if (colorEndValue.value == true)
		{
			value.isReadOnly = false;
		}
		else
		{
			value.isReadOnly = true;
		}
	}
	
	static private function linkRotationToVelocityChange(linkValue:ExposedValue):Void
	{
		var collection:ExposedCollection = linkValue.collection;
		var enabled:Bool = linkValue.value;
		var value:ExposedValue;
		
		value = collection.getValue("velocityRotationOffset");
		value.isReadOnly = !enabled;
		
		value = collection.getValue("rotationStart");
		value.isReadOnly = enabled;
		
		value = collection.getValue("rotationStartVariance");
		value.isReadOnly = enabled;
		
		value = collection.getValue("rotationEnd");
		value.isReadOnly = enabled;
		
		value = collection.getValue("rotationEndVariance");
		value.isReadOnly = enabled;
	}
	
	static private function oscillationPositionFrequencyModeChange(frequencyModeValue:ExposedValue):Void
	{
		var collection:ExposedCollection = frequencyModeValue.collection;
		var value:ExposedValue;
		
		if (frequencyModeValue.value == OscillationFrequencyMode.GLOBAL)
		{
			value = collection.getValue("oscillationPositionFrequency");
			value.isReadOnly = true;
			
			value = collection.getValue("oscillationPositionUnifiedFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("oscillationPositionFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("oscillationPositionFrequencyStart");
			value.isReadOnly = true;
		}
		else if (frequencyModeValue.value == OscillationFrequencyMode.GROUP)
		{
			value = collection.getValue("oscillationPositionFrequency");
			value.isReadOnly = false;
			
			value = collection.getValue("oscillationPositionUnifiedFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("oscillationPositionFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("oscillationPositionFrequencyStart");
			value.isReadOnly = true;
		}
		else
		{
			value = collection.getValue("oscillationPositionFrequency");
			value.isReadOnly = false;
			
			value = collection.getValue("oscillationPositionUnifiedFrequencyVariance");
			value.isReadOnly = false;
			
			if (value.value == true)
			{
				value = collection.getValue("oscillationPositionFrequencyVariance");
				value.isReadOnly = true;
			}
			else
			{
				value = collection.getValue("oscillationPositionFrequencyVariance");
				value.isReadOnly = false;
			}
			
			value = collection.getValue("oscillationPositionFrequencyStart");
			value.isReadOnly = false;
		}
	}
	
	static private function oscillationPosition2FrequencyModeChange(frequencyModeValue:ExposedValue):Void
	{
		var collection:ExposedCollection = frequencyModeValue.collection;
		var value:ExposedValue;
		
		if (frequencyModeValue.value == OscillationFrequencyMode.GLOBAL)
		{
			value = collection.getValue("oscillationPosition2Frequency");
			value.isReadOnly = true;
			
			value = collection.getValue("oscillationPosition2UnifiedFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("oscillationPosition2FrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("oscillationPosition2FrequencyStart");
			value.isReadOnly = true;
		}
		else if (frequencyModeValue.value == OscillationFrequencyMode.GROUP)
		{
			value = collection.getValue("oscillationPosition2Frequency");
			value.isReadOnly = false;
			
			value = collection.getValue("oscillationPosition2UnifiedFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("oscillationPosition2FrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("oscillationPosition2FrequencyStart");
			value.isReadOnly = true;
		}
		else
		{
			value = collection.getValue("oscillationPosition2Frequency");
			value.isReadOnly = false;
			
			value = collection.getValue("oscillationPosition2UnifiedFrequencyVariance");
			value.isReadOnly = false;
			
			if (value.value == true)
			{
				value = collection.getValue("oscillationPosition2FrequencyVariance");
				value.isReadOnly = true;
			}
			else
			{
				value = collection.getValue("oscillationPosition2FrequencyVariance");
				value.isReadOnly = false;
			}
			
			value = collection.getValue("oscillationPosition2FrequencyStart");
			value.isReadOnly = false;
		}
	}
	
	static private function oscillationRotationFrequencyModeChange(frequencyModeValue:ExposedValue):Void
	{
		var collection:ExposedCollection = frequencyModeValue.collection;
		var value:ExposedValue;
		
		if (frequencyModeValue.value == OscillationFrequencyMode.GLOBAL)
		{
			value = collection.getValue("oscillationRotationFrequency");
			value.isReadOnly = true;
			
			value = collection.getValue("oscillationRotationUnifiedFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("oscillationRotationFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("oscillationRotationFrequencyStart");
			value.isReadOnly = true;
		}
		else if (frequencyModeValue.value == OscillationFrequencyMode.GROUP)
		{
			value = collection.getValue("oscillationRotationFrequency");
			value.isReadOnly = false;
			
			value = collection.getValue("oscillationRotationUnifiedFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("oscillationRotationFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("oscillationRotationFrequencyStart");
			value.isReadOnly = true;
		}
		else
		{
			value = collection.getValue("oscillationRotationFrequency");
			value.isReadOnly = false;
			
			value = collection.getValue("oscillationRotationUnifiedFrequencyVariance");
			value.isReadOnly = false;
			
			if (value.value == true)
			{
				value = collection.getValue("oscillationRotationFrequencyVariance");
				value.isReadOnly = true;
			}
			else
			{
				value = collection.getValue("oscillationRotationFrequencyVariance");
				value.isReadOnly = false;
			}
			
			value = collection.getValue("oscillationRotationFrequencyStart");
			value.isReadOnly = false;
		}
	}
	
	static private function oscillationScaleXFrequencyModeChange(frequencyModeValue:ExposedValue):Void
	{
		var collection:ExposedCollection = frequencyModeValue.collection;
		var value:ExposedValue;
		
		if (frequencyModeValue.value == OscillationFrequencyMode.GLOBAL)
		{
			value = collection.getValue("oscillationScaleXFrequency");
			value.isReadOnly = true;
			
			value = collection.getValue("oscillationScaleXUnifiedFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("oscillationScaleXFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("oscillationScaleXFrequencyStart");
			value.isReadOnly = true;
		}
		else if (frequencyModeValue.value == OscillationFrequencyMode.GROUP)
		{
			value = collection.getValue("oscillationScaleXFrequency");
			value.isReadOnly = false;
			
			value = collection.getValue("oscillationScaleXUnifiedFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("oscillationScaleXFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("oscillationScaleXFrequencyStart");
			value.isReadOnly = true;
		}
		else
		{
			value = collection.getValue("oscillationScaleXFrequency");
			value.isReadOnly = false;
			
			value = collection.getValue("oscillationScaleXUnifiedFrequencyVariance");
			value.isReadOnly = false;
			
			if (value.value == true)
			{
				value = collection.getValue("oscillationScaleXFrequencyVariance");
				value.isReadOnly = true;
			}
			else
			{
				value = collection.getValue("oscillationScaleXFrequencyVariance");
				value.isReadOnly = false;
			}
			
			value = collection.getValue("oscillationScaleXFrequencyStart");
			value.isReadOnly = false;
		}
	}
	
	static private function oscillationScaleYFrequencyModeChange(frequencyModeValue:ExposedValue):Void
	{
		var collection:ExposedCollection = frequencyModeValue.collection;
		var value:ExposedValue;
		
		if (frequencyModeValue.value == OscillationFrequencyMode.GLOBAL)
		{
			value = collection.getValue("oscillationScaleYFrequency");
			value.isReadOnly = true;
			
			value = collection.getValue("oscillationScaleYUnifiedFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("oscillationScaleYFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("oscillationScaleYFrequencyStart");
			value.isReadOnly = true;
		}
		else if (frequencyModeValue.value == OscillationFrequencyMode.GROUP)
		{
			value = collection.getValue("oscillationScaleYFrequency");
			value.isReadOnly = false;
			
			value = collection.getValue("oscillationScaleYUnifiedFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("oscillationScaleYFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("oscillationScaleYFrequencyStart");
			value.isReadOnly = true;
		}
		else
		{
			value = collection.getValue("oscillationScaleYFrequency");
			value.isReadOnly = false;
			
			value = collection.getValue("oscillationScaleYUnifiedFrequencyVariance");
			value.isReadOnly = false;
			
			if (value.value == true)
			{
				value = collection.getValue("oscillationScaleYFrequencyVariance");
				value.isReadOnly = true;
			}
			else
			{
				value = collection.getValue("oscillationScaleYFrequencyVariance");
				value.isReadOnly = false;
			}
			
			value = collection.getValue("oscillationScaleYFrequencyStart");
			value.isReadOnly = false;
		}
	}
	
	static private function oscillationColorFrequencyModeChange(frequencyModeValue:ExposedValue):Void
	{
		var collection:ExposedCollection = frequencyModeValue.collection;
		var value:ExposedValue;
		
		if (frequencyModeValue.value == OscillationFrequencyMode.GLOBAL)
		{
			value = collection.getValue("oscillationColorFrequency");
			value.isReadOnly = true;
			
			value = collection.getValue("oscillationColorUnifiedFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("oscillationColorFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("oscillationColorFrequencyStart");
			value.isReadOnly = true;
		}
		else if (frequencyModeValue.value == OscillationFrequencyMode.GROUP)
		{
			value = collection.getValue("oscillationColorFrequency");
			value.isReadOnly = false;
			
			value = collection.getValue("oscillationColorUnifiedFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("oscillationColorFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("oscillationColorFrequencyStart");
			value.isReadOnly = true;
		}
		else
		{
			value = collection.getValue("oscillationColorFrequency");
			value.isReadOnly = false;
			
			value = collection.getValue("oscillationColorUnifiedFrequencyVariance");
			value.isReadOnly = false;
			
			if (value.value == true)
			{
				value = collection.getValue("oscillationColorFrequencyVariance");
				value.isReadOnly = true;
			}
			else
			{
				value = collection.getValue("oscillationColorFrequencyVariance");
				value.isReadOnly = false;
			}
			
			value = collection.getValue("oscillationColorFrequencyStart");
			value.isReadOnly = false;
		}
	}
	
	static private function oscillationPositionUnifiedFrequencyVarianceChange(unifiedFrequencyVarianceValue:ExposedValue):Void
	{
		if (unifiedFrequencyVarianceValue.isReadOnly) return;
		
		var collection:ExposedCollection = unifiedFrequencyVarianceValue.collection;
		var value:ExposedValue;
		
		if (unifiedFrequencyVarianceValue.value == true)
		{
			value = collection.getValue("oscillationPositionFrequencyVariance");
			value.isReadOnly = true;
		}
		else
		{
			value = collection.getValue("oscillationPositionFrequencyVariance");
			value.isReadOnly = false;
		}
	}
	
	static private function oscillationPosition2UnifiedFrequencyVarianceChange(unifiedFrequencyVarianceValue:ExposedValue):Void
	{
		if (unifiedFrequencyVarianceValue.isReadOnly) return;
		
		var collection:ExposedCollection = unifiedFrequencyVarianceValue.collection;
		var value:ExposedValue;
		
		if (unifiedFrequencyVarianceValue.value == true)
		{
			value = collection.getValue("oscillationPosition2FrequencyVariance");
			value.isReadOnly = true;
		}
		else
		{
			value = collection.getValue("oscillationPosition2FrequencyVariance");
			value.isReadOnly = false;
		}
	}
	
	static private function oscillationRotationUnifiedFrequencyVarianceChange(unifiedFrequencyVarianceValue:ExposedValue):Void
	{
		if (unifiedFrequencyVarianceValue.isReadOnly) return;
		
		var collection:ExposedCollection = unifiedFrequencyVarianceValue.collection;
		var value:ExposedValue;
		
		if (unifiedFrequencyVarianceValue.value == true)
		{
			value = collection.getValue("oscillationRotationFrequencyVariance");
			value.isReadOnly = true;
		}
		else
		{
			value = collection.getValue("oscillationRotationFrequencyVariance");
			value.isReadOnly = false;
		}
	}
	
	static private function oscillationScaleXUnifiedFrequencyVarianceChange(unifiedFrequencyVarianceValue:ExposedValue):Void
	{
		if (unifiedFrequencyVarianceValue.isReadOnly) return;
		
		var collection:ExposedCollection = unifiedFrequencyVarianceValue.collection;
		var value:ExposedValue;
		
		if (unifiedFrequencyVarianceValue.value == true)
		{
			value = collection.getValue("oscillationScaleXFrequencyVariance");
			value.isReadOnly = true;
		}
		else
		{
			value = collection.getValue("oscillationScaleXFrequencyVariance");
			value.isReadOnly = false;
		}
	}
	
	static private function oscillationScaleYUnifiedFrequencyVarianceChange(unifiedFrequencyVarianceValue:ExposedValue):Void
	{
		if (unifiedFrequencyVarianceValue.isReadOnly) return;
		
		var collection:ExposedCollection = unifiedFrequencyVarianceValue.collection;
		var value:ExposedValue;
		
		if (unifiedFrequencyVarianceValue.value == true)
		{
			value = collection.getValue("oscillationScaleYFrequencyVariance");
			value.isReadOnly = true;
		}
		else
		{
			value = collection.getValue("oscillationScaleYFrequencyVariance");
			value.isReadOnly = false;
		}
	}
	
	static private function oscillationColorUnifiedFrequencyVarianceChange(unifiedFrequencyVarianceValue:ExposedValue):Void
	{
		if (unifiedFrequencyVarianceValue.isReadOnly) return;
		
		var collection:ExposedCollection = unifiedFrequencyVarianceValue.collection;
		var value:ExposedValue;
		
		if (unifiedFrequencyVarianceValue.value == true)
		{
			value = collection.getValue("oscillationColorFrequencyVariance");
			value.isReadOnly = true;
		}
		else
		{
			value = collection.getValue("oscillationColorFrequencyVariance");
			value.isReadOnly = false;
		}
	}
	
	static public function exposeParticleSystemOptions(collection:ExposedCollection = null, groupName:String = null):ExposedCollection
	{
		var bool:ExposedBool;
		var floatDrag:ExposedFloatDrag;
		var group:ExposedGroup;
		var intDrag:ExposedIntDrag;
		var obj:ExposedObject;
		var select:ExposedSelect;
		
		if (collection == null) collection = new ExposedCollection();
		
		// Emitter
		if (!collection.hasGroup("Emitter"))
		{
			group = new ExposedGroup("Emitter");
			group.isUIOpen = true;
			collection.addValue(group, groupName);
		}
		else
		{
			group = collection.getGroup("Emitter");
		}
		
		if (!group.hasValue("emitterType"))
		{
			select = new ExposedSelect("emitterType");
			select.add("gravity", EmitterType.GRAVITY);
			select.add("radial", EmitterType.RADIAL);
			group.addValue(select);
		}
		
		if (!group.hasValue("maxNumParticles"))
		{
			intDrag = new ExposedIntDrag("maxNumParticles", null, 0, MassiveConstants.MAX_QUADS);
			group.addValue(intDrag);
		}
		
		if (!group.hasValue("particleAmount"))
		{
			intDrag = new ExposedIntDrag("particleAmount", null, 0);
			group.addValue(intDrag);
		}
		
		if (!group.hasValue("autoSetEmissionRate"))
		{
			bool = new ExposedBool("autoSetEmissionRate");
			group.addValue(bool);
		}
		
		if (!group.hasValue("emissionRate"))
		{
			floatDrag = new ExposedFloatDrag("emissionRate", null, 0.0);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("emissionRatio"))
		{
			floatDrag = new ExposedFloatDrag("emissionRatio", null, 0.0, 1.0, 0.01);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("emitterX"))
		{
			floatDrag = new ExposedFloatDrag("emitterX");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("emitterY"))
		{
			floatDrag = new ExposedFloatDrag("emitterY");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("emitterXVariance"))
		{
			floatDrag = new ExposedFloatDrag("emitterXVariance");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("emitterYVariance"))
		{
			floatDrag = new ExposedFloatDrag("emitterYVariance");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("emitterRadiusMin"))
		{
			floatDrag = new ExposedFloatDrag("emitterRadiusMin");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("emitterRadiusMinVariance"))
		{
			floatDrag = new ExposedFloatDrag("emitterRadiusMinVariance");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("emitterRadiusMax"))
		{
			floatDrag = new ExposedFloatDrag("emitterRadiusMax");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("emitterRadiusMaxVariance"))
		{
			floatDrag = new ExposedFloatDrag("emitterRadiusMaxVariance");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("emitAngle"))
		{
			floatDrag = new ExposedFloatDrag("emitAngle", null, null, null, 0.005, 0.005);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("emitAngleVariance"))
		{
			floatDrag = new ExposedFloatDrag("emitAngleVariance", null, null, null, 0.005, 0.005);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("emitRotation"))
		{
			floatDrag = new ExposedFloatDrag("emitRotation", null, null, null, 0.005, 0.005);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("emitAngleAlignedRotation"))
		{
			bool = new ExposedBool("emitAngleAlignedRotation");
			group.addValue(bool);
		}
		
		if (!group.hasValue("useDisplayRect"))
		{
			bool = new ExposedBool("useDisplayRect");
			group.addValue(bool);
		}
		
		if (!group.hasValue("displayRect"))
		{
			obj = new ExposedObject("displayRect");
			group.addValue(obj);
		}
		
		// Particle
		if (!collection.hasGroup("Particle"))
		{
			group = new ExposedGroup("Particle");
			collection.addValue(group, groupName);
		}
		else
		{
			group = collection.getGroup("Particle");
		}
		
		if (!group.hasValue("useAnimationLifeSpan"))
		{
			bool = new ExposedBool("useAnimationLifeSpan");
			group.addValue(bool);
		}
		
		collection.registerForValueChangeExternal("useAnimationLifeSpan", useAnimationLifeSpanChange);
		
		if (!group.hasValue("lifeSpan"))
		{
			floatDrag = new ExposedFloatDrag("lifeSpan", null, 0.05, null, 0.05);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("lifeSpanVariance"))
		{
			floatDrag = new ExposedFloatDrag("lifeSpanVariance", null, 0.0, null, 0.05);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("fadeInTime"))
		{
			floatDrag = new ExposedFloatDrag("fadeInTime", null, 0.0, null, 0.005, 0.005);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("fadeOutTime"))
		{
			floatDrag = new ExposedFloatDrag("fadeOutTime", null, 0.0, null, 0.005, 0.005);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("sizeXStart"))
		{
			floatDrag = new ExposedFloatDrag("sizeXStart");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("sizeYStart"))
		{
			floatDrag = new ExposedFloatDrag("sizeYStart");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("sizeXStartVariance"))
		{
			floatDrag = new ExposedFloatDrag("sizeXStartVariance");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("sizeYStartVariance"))
		{
			floatDrag = new ExposedFloatDrag("sizeYStartVariance");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("sizeXEnd"))
		{
			floatDrag = new ExposedFloatDrag("sizeXEnd");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("sizeYEnd"))
		{
			floatDrag = new ExposedFloatDrag("sizeYEnd");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("sizeXEndVariance"))
		{
			floatDrag = new ExposedFloatDrag("sizeXEndVariance");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("sizeYEndVariance"))
		{
			floatDrag = new ExposedFloatDrag("sizeYEndVariance");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("rotationStart"))
		{
			floatDrag = new ExposedFloatDrag("rotationStart", null, null, null, 0.005, 0.005);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("rotationStartVariance"))
		{
			floatDrag = new ExposedFloatDrag("rotationStartVariance", null, null, null, 0.005, 0.005);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("rotationEnd"))
		{
			floatDrag = new ExposedFloatDrag("rotationEnd", null, null, null, 0.005, 0.005);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("rotationEndVariance"))
		{
			floatDrag = new ExposedFloatDrag("rotationEndVariance", null, null, null, 0.005, 0.005);
			group.addValue(floatDrag);
		}
		
		// Animation
		if (!collection.hasGroup("Animation"))
		{
			group = new ExposedGroup("Animation");
			collection.addValue(group, groupName);
		}
		else
		{
			group = collection.getGroup("Animation");
		}
		
		if (!group.hasValue("animate"))
		{
			bool = new ExposedBool("animate");
			group.addValue(bool);
		}
		
		if (!group.hasValue("textureAnimation"))
		{
			bool = new ExposedBool("textureAnimation");
			group.addValue(bool);
		}
		
		if (!group.hasValue("frameRate"))
		{
			floatDrag = new ExposedFloatDrag("frameRate", null, 0);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("loopAnimation"))
		{
			bool = new ExposedBool("loopAnimation");
			group.addValue(bool);
		}
		
		if (!group.hasValue("animationLoops"))
		{
			intDrag = new ExposedIntDrag("animationLoops");
			group.addValue(intDrag);
		}
		
		if (!group.hasValue("randomStartFrame"))
		{
			bool = new ExposedBool("randomStartFrame");
			group.addValue(bool);
		}
		
		// gravity config
		if (!collection.hasGroup("Gravity config"))
		{
			group = new ExposedGroup("Gravity config");
			collection.addValue(group, groupName);
		}
		else
		{
			group = collection.getGroup("Gravity config");
		}
		
		if (!group.hasValue("speed"))
		{
			floatDrag = new ExposedFloatDrag("speed");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("speedVariance"))
		{
			floatDrag = new ExposedFloatDrag("speedVariance");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("adjustLifeSpanToSpeed"))
		{
			bool = new ExposedBool("adjustLifeSpanToSpeed");
			group.addValue(bool);
		}
		
		if (!group.hasValue("gravityX"))
		{
			floatDrag = new ExposedFloatDrag("gravityX");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("gravityY"))
		{
			floatDrag = new ExposedFloatDrag("gravityY");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("radialAcceleration"))
		{
			floatDrag = new ExposedFloatDrag("radialAcceleration");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("radialAccelerationVariance"))
		{
			floatDrag = new ExposedFloatDrag("radialAccelerationVariance");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("tangentialAcceleration"))
		{
			floatDrag = new ExposedFloatDrag("tangentialAcceleration");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("tangentialAccelerationVariance"))
		{
			floatDrag = new ExposedFloatDrag("tangentialAccelerationVariance");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("drag"))
		{
			floatDrag = new ExposedFloatDrag("drag", null, null, null, 0.01, 0.01);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("dragVariance"))
		{
			floatDrag = new ExposedFloatDrag("dragVariance", null, null, null, 0.01, 0.01);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("repellentForce"))
		{
			floatDrag = new ExposedFloatDrag("repellentForce");// , null, null, null, 0.001, 0.001);
			group.addValue(floatDrag);
		}
		
		// radial config
		if (!collection.hasGroup("Radial config"))
		{
			group = new ExposedGroup("Radial config");
			collection.addValue(group, groupName);
		}
		else
		{
			group = collection.getGroup("Radial config");
		}
		
		if (!group.hasValue("radiusMin"))
		{
			floatDrag = new ExposedFloatDrag("radiusMin");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("radiusMinVariance"))
		{
			floatDrag = new ExposedFloatDrag("radiusMinVariance");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("radiusMax"))
		{
			floatDrag = new ExposedFloatDrag("radiusMax");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("radiusMaxVariance"))
		{
			floatDrag = new ExposedFloatDrag("radiusMaxVariance");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("rotatePerSecond"))
		{
			floatDrag = new ExposedFloatDrag("rotatePerSecond");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("rotatePerSecondVariance"))
		{
			floatDrag = new ExposedFloatDrag("rotatePerSecondVariance");
			group.addValue(floatDrag);
		}
		
		// color
		if (!collection.hasGroup("Color"))
		{
			group = new ExposedGroup("Color");
			collection.addValue(group, groupName);
		}
		else
		{
			group = collection.getGroup("Color");
		}
		
		if (!group.hasValue("colorStart"))
		{
			obj = new ExposedObject("colorStart");
			obj.isUIOpen = true;
			group.addValue(obj);
		}
		
		if (!group.hasValue("colorStartVariance"))
		{
			obj = new ExposedObject("colorStartVariance");
			obj.isUIOpen = true;
			group.addValue(obj);
		}
		
		if (!group.hasValue("colorEnd"))
		{
			obj = new ExposedObject("colorEnd");
			obj.isUIOpen = true;
			group.addValue(obj);
		}
		
		if (!group.hasValue("colorEndVariance"))
		{
			obj = new ExposedObject("colorEndVariance");
			obj.isUIOpen = true;
			group.addValue(obj);
		}
		
		// Velocity
		if (!collection.hasGroup("Velocity"))
		{
			group = new ExposedGroup("Velocity");
			collection.addValue(group, groupName);
		}
		else
		{
			group = collection.getGroup("Velocity");
		}
		
		if (!group.hasValue("velocityXInheritRatio"))
		{
			floatDrag = new ExposedFloatDrag("velocityXInheritRatio", null, null, null, 0.01, 0.01);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("velocityXInheritRatioVariance"))
		{
			floatDrag = new ExposedFloatDrag("velocityXInheritRatioVariance", null, null, null, 0.01, 0.01);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("velocityYInheritRatio"))
		{
			floatDrag = new ExposedFloatDrag("velocityYInheritRatio", null, null, null, 0.01, 0.01);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("velocityYInheritRatioVariance"))
		{
			floatDrag = new ExposedFloatDrag("velocityYInheritRatioVariance", null, null, null, 0.01, 0.01);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("velocityX"))
		{
			floatDrag = new ExposedFloatDrag("velocityX");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("velocityY"))
		{
			floatDrag = new ExposedFloatDrag("velocityY");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("velocityScaleFactorX"))
		{
			floatDrag = new ExposedFloatDrag("velocityScaleFactorX", null, null, null, 0.0001, 0.0001);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("velocityScaleFactorY"))
		{
			floatDrag = new ExposedFloatDrag("velocityScaleFactorY", null, null, null, 0.0001, 0.0001);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("linkRotationToVelocity"))
		{
			bool = new ExposedBool("linkRotationToVelocity");
			group.addValue(bool);
		}
		
		collection.registerForValueChangeExternal("linkRotationToVelocity", linkRotationToVelocityChange);
		
		if (!group.hasValue("velocityRotationOffset"))
		{
			floatDrag = new ExposedFloatDrag("velocityRotationOffset", null, null, 0.005, 0.005);
			group.addValue(floatDrag);
		}
		
		// oscillation
		if (!collection.hasGroup("Oscillation"))
		{
			group = new ExposedGroup("Oscillation");
			collection.addValue(group, groupName);
		}
		else
		{
			group = collection.getGroup("Oscillation");
		}
		
		if (!group.hasValue("oscillationScaleX"))
		{
			floatDrag = new ExposedFloatDrag("oscillationScaleX", null, null, null, 0.01);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("oscillationScaleXVariance"))
		{
			floatDrag = new ExposedFloatDrag("oscillationScaleXVariance", null, null, 0.01);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("oscillationScaleY"))
		{
			floatDrag = new ExposedFloatDrag("oscillationScaleY", null, null, null, 0.01);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("oscillationScaleYVariance"))
		{
			floatDrag = new ExposedFloatDrag("oscillationScaleYVariance", null, null, null, 0.01);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("oscillationScaleXFrequency"))
		{
			floatDrag = new ExposedFloatDrag("oscillationScaleXFrequency");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("oscillationScaleXFrequencyVariance"))
		{
			floatDrag = new ExposedFloatDrag("oscillationScaleXFrequencyVariance");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("oscillationScaleYFrequency"))
		{
			floatDrag = new ExposedFloatDrag("oscillationScaleYFrequency");
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("oscillationScaleYFrequencyVariance"))
		{
			floatDrag = new ExposedFloatDrag("oscillationScaleYFrequencyVariance");
			group.addValue(floatDrag);
		}
		
		return collection;
	}
	
}
//#end