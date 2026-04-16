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
import valedit.value.ExposedNote;
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
		var note:ExposedNote;
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
		
		if (!subGroup.hasValue("emitterRadiusOverridesParticleAngle"))
		{
			bool = new ExposedBool("emitterRadiusOverridesParticleAngle", "override particle angle");
			subGroup.addValue(bool);
			
			collection.registerForValueChangeExternal("emitterRadiusOverridesParticleAngle", emitterRadiusOverridesParticleAngleChange);
		}
		
		if (!subGroup.hasValue("emitterRadiusParticleAngleOffset"))
		{
			floatDrag = new ExposedFloatDrag("emitterRadiusParticleAngleOffset", "angle offset", null, null, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("emitterRadiusParticleAngleOffsetVariance"))
		{
			floatDrag = new ExposedFloatDrag("emitterRadiusParticleAngleOffsetVariance", "angle offset variance", null, null, 0.01);
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
			
			collection.registerForValueChangeExternal("emitAngleAlignedRotation", emitAngleAlignedRotationChange);
		}
		
		if (!group.hasValue("emitAngleAlignedRotationOffset"))
		{
			floatDrag = new ExposedFloatDrag("emitAngleAlignedRotationOffset", "aligned rotation offset", null, null, 0.01);
			group.addValue(floatDrag);
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
		
		if (!subGroup.hasValue("sizeXEndRelativeToStart"))
		{
			bool = new ExposedBool("sizeXEndRelativeToStart", "relative to start");
			subGroup.addValue(bool);
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
		
		if (!subGroup.hasValue("sizeYEndRelativeToStart"))
		{
			bool = new ExposedBool("sizeYEndRelativeToStart", "relative to start");
			subGroup.addValue(bool);
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
		
		if (!group.hasGroup("Skew"))
		{
			subGroup = new ExposedGroup("Skew");
			group.addValue(subGroup);
		}
		else
		{
			subGroup = group.getGroup("Skew");
		}
		
		if (!subGroup.hasValue("skewXStart"))
		{
			floatDrag = new ExposedFloatDrag("skewXStart", "x start", null, null, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("skewXStartVariance"))
		{
			floatDrag = new ExposedFloatDrag("skewXStartVariance", "x start variance", null, null, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("skewYStart"))
		{
			floatDrag = new ExposedFloatDrag("skewYStart", "y start", null, null, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("skewYStartVariance"))
		{
			floatDrag = new ExposedFloatDrag("skewYStartVariance", "y start variance", null, null, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("skewXEnd"))
		{
			floatDrag = new ExposedFloatDrag("skewXEnd", "x end", null, null, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("skewXEndVariance"))
		{
			floatDrag = new ExposedFloatDrag("skewXEndVariance", "x end variance", null, null, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("skewXEndRelativeToStart"))
		{
			bool = new ExposedBool("skewXEndRelativeToStart", "relative to start");
			subGroup.addValue(bool);
		}
		
		if (!subGroup.hasValue("skewYEnd"))
		{
			floatDrag = new ExposedFloatDrag("skewYEnd", "y end", null, null, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("skewYEndVariance"))
		{
			floatDrag = new ExposedFloatDrag("skewYEndVariance", "y end variance", null, null, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("skewYEndRelativeToStart"))
		{
			bool = new ExposedBool("skewYEndRelativeToStart", "relative to start");
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
			floatDrag = new ExposedFloatDrag("radialAcceleration", "radial", null, null, 1.0);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("radialAccelerationVariance"))
		{
			floatDrag = new ExposedFloatDrag("radialAccelerationVariance", "radial variance", null, null, 1.0);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("tangentialAcceleration"))
		{
			floatDrag = new ExposedFloatDrag("tangentialAcceleration", "tangential", null, null, 1.0);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("tangentialAccelerationVariance"))
		{
			floatDrag = new ExposedFloatDrag("tangentialAccelerationVariance", "tangential variance", null, null, 1.0);
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
		
		if (!group.hasValue("alignRadialRotation"))
		{
			bool = new ExposedBool("alignRadialRotation");
			group.addValue(bool);
			
			collection.registerForValueChangeExternal("alignRadialRotation", alignRadialRotationChange);
		}
		
		if (!group.hasValue("alignRadialRotationOffset"))
		{
			floatDrag = new ExposedFloatDrag("alignRadialRotationOffset", null, null, null, 0.01);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("alignRadialRotationOffsetVariance"))
		{
			floatDrag = new ExposedFloatDrag("alignRadialRotationOffsetVariance", null, null, null, 0.01);
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
		
		if (!group.hasValue("ColorNote"))
		{
			note = new ExposedNote("ColorNote", "note that this won't have any effect if Display's colorMode is set to 'none' or 'display'");
			group.addValue(note);
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
		
		// color offset
		if (!collection.hasGroup("ColorOffset"))
		{
			group = new ExposedGroup("ColorOffset", "Color Offset");
			collection.addValue(group);
		}
		else
		{
			group = collection.getGroup("ColorOffset");
		}
		
		if (!group.hasValue("ColorOffsetNote"))
		{
			note = new ExposedNote("ColorOffsetNote", "note that this won't have any effect unless Display's colorOffsetMode is set to 'object' or 'display_and_object'");
			group.addValue(note);
		}
		
		if (!group.hasValue("colorOffsetStart"))
		{
			obj = new ExposedObject("colorOffsetStart");
			group.addValue(obj);
		}
		
		if (!group.hasValue("colorOffsetStartVariance"))
		{
			obj = new ExposedObject("colorOffsetStartVariance");
			group.addValue(obj);
		}
		
		if (!group.hasValue("colorOffsetEnd"))
		{
			obj = new ExposedObject("colorOffsetEnd");
			group.addValue(obj);
		}
		
		if (!group.hasValue("colorOffsetEndVariance"))
		{
			obj = new ExposedObject("colorOffsetEndVariance");
			group.addValue(obj);
		}
		
		if (!group.hasValue("colorOffsetEndRelativeToStart"))
		{
			bool = new ExposedBool("colorOffsetEndRelativeToStart", "end relative to start");
			group.addValue(bool);
			
			collection.registerForValueChangeExternal("colorOffsetEndRelativeToStart", colorOffsetEndRelativeToStartChange);
		}
		
		if (!group.hasValue("colorOffsetEndIsMultiplier"))
		{
			bool = new ExposedBool("colorOffsetEndIsMultiplier", "end is multiplier");
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
		
		if (!subGroup.hasValue("velocityX"))
		{
			floatDrag = new ExposedFloatDrag("velocityX");
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("velocityY"))
		{
			floatDrag = new ExposedFloatDrag("velocityY");
			subGroup.addValue(floatDrag);
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
		
		if (!group.hasValue("velocityRotationFactor"))
		{
			floatDrag = new ExposedFloatDrag("velocityRotationFactor", null, null, null, 0.0001, 0.0001);
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
		
		if (!group.hasValue("velocitySkewFactorX"))
		{
			floatDrag = new ExposedFloatDrag("velocitySkewFactorX", null, null, null, 0.0001, 0.0001);
			group.addValue(floatDrag);
		}
		
		if (!group.hasValue("velocitySkewFactorY"))
		{
			floatDrag = new ExposedFloatDrag("velocitySkewFactorY", null, null, null, 0.0001, 0.0001);
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
		
		if (!subGroup.hasValue("positionOscillationFrequencyMode"))
		{
			select = new ExposedSelect("positionOscillationFrequencyMode", "frequency mode");
			select.choiceListFunction = OscillationFrequencyMode.getValues;
			select.valueListFunction = OscillationFrequencyMode.getValues;
			subGroup.addValue(select);
			
			collection.registerForValueChangeExternal("positionOscillationFrequencyMode", positionOscillationFrequencyModeChange);
		}
		
		if (!subGroup.hasValue("positionOscillationGroupStartStep"))
		{
			floatDrag = new ExposedFloatDrag("positionOscillationGroupStartStep", "group start step", null, null, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("positionOscillationAngle"))
		{
			floatDrag = new ExposedFloatDrag("positionOscillationAngle", "angle", null, null, 0.005, 0.005);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("positionOscillationAngleVariance"))
		{
			floatDrag = new ExposedFloatDrag("positionOscillationAngleVariance", "angle variance", null, null, 0.005, 0.005);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("positionOscillationAngleRelativeTo"))
		{
			select = new ExposedSelect("positionOscillationAngleRelativeTo", "angle relative to");
			select.choiceListFunction = AngleRelativeTo.getValues;
			select.valueListFunction = AngleRelativeTo.getValues;
			subGroup.addValue(select);
		}
		
		if (!subGroup.hasValue("positionOscillationRadius"))
		{
			floatDrag = new ExposedFloatDrag("positionOscillationRadius", "radius");
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("positionOscillationRadiusVariance"))
		{
			floatDrag = new ExposedFloatDrag("positionOscillationRadiusVariance", "radius variance");
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("positionOscillationFrequency"))
		{
			floatDrag = new ExposedFloatDrag("positionOscillationFrequency", "frequency", null, null, 0.1);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("positionOscillationUnifiedFrequencyVariance"))
		{
			bool = new ExposedBool("positionOscillationUnifiedFrequencyVariance", "unified frequency variance");
			subGroup.addValue(bool);
			
			collection.registerForValueChangeExternal("positionOscillationUnifiedFrequencyVariance", positionOscillationUnifiedFrequencyVarianceChange);
		}
		
		if (!subGroup.hasValue("positionOscillationFrequencyVariance"))
		{
			floatDrag = new ExposedFloatDrag("positionOscillationFrequencyVariance", "frequency variance", null, null, 0.1);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("positionOscillationFrequencyInverted"))
		{
			bool = new ExposedBool("positionOscillationFrequencyInverted", "invert frequency");
			subGroup.addValue(bool);
		}
		
		if (!subGroup.hasValue("positionOscillationFrequencyStart"))
		{
			select = new ExposedSelect("positionOscillationFrequencyStart", "frequency start");
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
		
		if (!subGroup.hasValue("position2OscillationFrequencyMode"))
		{
			select = new ExposedSelect("position2OscillationFrequencyMode", "frequency mode");
			select.choiceListFunction = OscillationFrequencyMode.getValues;
			select.valueListFunction = OscillationFrequencyMode.getValues;
			subGroup.addValue(select);
			
			collection.registerForValueChangeExternal("position2OscillationFrequencyMode", position2OscillationFrequencyModeChange);
		}
		
		if (!subGroup.hasValue("position2OscillationGroupStartStep"))
		{
			floatDrag = new ExposedFloatDrag("position2OscillationGroupStartStep", "group start step", null, null, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("position2OscillationAngle"))
		{
			floatDrag = new ExposedFloatDrag("position2OscillationAngle", "angle", null, null, 0.005, 0.005);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("position2OscillationAngleVariance"))
		{
			floatDrag = new ExposedFloatDrag("position2OscillationAngleVariance", "angle variance", null, null, 0.005, 0.005);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("position2OscillationAngleRelativeTo"))
		{
			select = new ExposedSelect("position2OscillationAngleRelativeTo", "angle relative to");
			select.choiceListFunction = AngleRelativeTo.getValues;
			select.valueListFunction = AngleRelativeTo.getValues;
			subGroup.addValue(select);
		}
		
		if (!subGroup.hasValue("position2OscillationRadius"))
		{
			floatDrag = new ExposedFloatDrag("position2OscillationRadius", "radius");
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("position2OscillationRadiusVariance"))
		{
			floatDrag = new ExposedFloatDrag("position2OscillationRadiusVariance", "radius variance");
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("position2OscillationFrequency"))
		{
			floatDrag = new ExposedFloatDrag("position2OscillationFrequency", "frequency", null, null, 0.1);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("position2OscillationUnifiedFrequencyVariance"))
		{
			bool = new ExposedBool("position2OscillationUnifiedFrequencyVariance", "unified frequency variance");
			subGroup.addValue(bool);
			
			collection.registerForValueChangeExternal("position2OscillationUnifiedFrequencyVariance", position2OscillationUnifiedFrequencyVarianceChange);
		}
		
		if (!subGroup.hasValue("position2OscillationFrequencyVariance"))
		{
			floatDrag = new ExposedFloatDrag("position2OscillationFrequencyVariance", "frequency variance", null, null, 0.1);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("position2OscillationFrequencyInverted"))
		{
			bool = new ExposedBool("position2OscillationFrequencyInverted", "invert frequency");
			subGroup.addValue(bool);
		}
		
		if (!subGroup.hasValue("position2OscillationFrequencyStart"))
		{
			select = new ExposedSelect("position2OscillationFrequencyStart", "frequency start");
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
		
		if (!subGroup.hasValue("rotationOscillationFrequencyMode"))
		{
			select = new ExposedSelect("rotationOscillationFrequencyMode", "frequency mode");
			select.choiceListFunction = OscillationFrequencyMode.getValues;
			select.valueListFunction = OscillationFrequencyMode.getValues;
			subGroup.addValue(select);
			
			collection.registerForValueChangeExternal("rotationOscillationFrequencyMode", rotationOscillationFrequencyModeChange);
		}
		
		if (!subGroup.hasValue("rotationOscillationGroupStartStep"))
		{
			floatDrag = new ExposedFloatDrag("rotationOscillationGroupStartStep", "group start step", null, null, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("rotationOscillationAngle"))
		{
			floatDrag = new ExposedFloatDrag("rotationOscillationAngle", "angle", null, null, 0.005, 0.005);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("rotationOscillationAngleVariance"))
		{
			floatDrag = new ExposedFloatDrag("rotationOscillationAngleVariance", "angle variance", null, null, 0.005, 0.005);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("rotationOscillationFrequency"))
		{
			floatDrag = new ExposedFloatDrag("rotationOscillationFrequency", "frequency", null, null, 0.1);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("rotationOscillationUnifiedFrequencyVariance"))
		{
			bool = new ExposedBool("rotationOscillationUnifiedFrequencyVariance", "unified frequency variance");
			subGroup.addValue(bool);
			
			collection.registerForValueChangeExternal("rotationOscillationUnifiedFrequencyVariance", rotationOscillationUnifiedFrequencyVarianceChange);
		}
		
		if (!subGroup.hasValue("rotationOscillationFrequencyVariance"))
		{
			floatDrag = new ExposedFloatDrag("rotationOscillationFrequencyVariance", "frequency variance", null, null, 0.1);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("rotationOscillationFrequencyInverted"))
		{
			bool = new ExposedBool("rotationOscillationFrequencyInverted", "invert frequency");
			subGroup.addValue(bool);
		}
		
		if (!subGroup.hasValue("rotationOscillationFrequencyStart"))
		{
			select = new ExposedSelect("rotationOscillationFrequencyStart", "frequency start");
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
		
		if (!subGroup.hasValue("scaleXOscillationFrequencyMode"))
		{
			select = new ExposedSelect("scaleXOscillationFrequencyMode", "frequency mode");
			select.choiceListFunction = OscillationFrequencyMode.getValues;
			select.valueListFunction = OscillationFrequencyMode.getValues;
			subGroup.addValue(select);
			
			collection.registerForValueChangeExternal("scaleXOscillationFrequencyMode", scaleXOscillationFrequencyModeChange);
		}
		
		if (!subGroup.hasValue("scaleXOscillationGroupStartStep"))
		{
			floatDrag = new ExposedFloatDrag("scaleXOscillationGroupStartStep", "group start step", null, null, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("scaleXOscillation"))
		{
			floatDrag = new ExposedFloatDrag("scaleXOscillation", "x", null, null, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("scaleXOscillationVariance"))
		{
			floatDrag = new ExposedFloatDrag("scaleXOscillationVariance", "x variance", null, null, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("scaleXOscillationFrequency"))
		{
			floatDrag = new ExposedFloatDrag("scaleXOscillationFrequency", "x frequency", null, null, 0.1);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("scaleXOscillationUnifiedFrequencyVariance"))
		{
			bool = new ExposedBool("scaleXOscillationUnifiedFrequencyVariance", "unified frequency variance");
			subGroup.addValue(bool);
			
			collection.registerForValueChangeExternal("scaleXOscillationUnifiedFrequencyVariance", scaleXOscillationUnifiedFrequencyVarianceChange);
		}
		
		if (!subGroup.hasValue("scaleXOscillationFrequencyVariance"))
		{
			floatDrag = new ExposedFloatDrag("scaleXOscillationFrequencyVariance", "x frequency variance", null, null, 0.1);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("scaleXOscillationFrequencyInverted"))
		{
			bool = new ExposedBool("scaleXOscillationFrequencyInverted", "invert x frequency");
			subGroup.addValue(bool);
		}
		
		if (!subGroup.hasValue("scaleXOscillationFrequencyStart"))
		{
			select = new ExposedSelect("scaleXOscillationFrequencyStart", "frequency start");
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
		
		if (!subGroup.hasValue("scaleYOscillationFrequencyMode"))
		{
			select = new ExposedSelect("scaleYOscillationFrequencyMode", "frequency mode");
			select.choiceListFunction = OscillationFrequencyMode.getValues;
			select.valueListFunction = OscillationFrequencyMode.getValues;
			subGroup.addValue(select);
			
			collection.registerForValueChangeExternal("scaleYOscillationFrequencyMode", scaleYOscillationFrequencyModeChange);
		}
		
		if (!subGroup.hasValue("scaleYOscillationGroupStartStep"))
		{
			floatDrag = new ExposedFloatDrag("scaleYOscillationGroupStartStep", "group start step", null, null, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("scaleYOscillation"))
		{
			floatDrag = new ExposedFloatDrag("scaleYOscillation", "y", null, null, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("scaleYOscillationVariance"))
		{
			floatDrag = new ExposedFloatDrag("scaleYOscillationVariance", "y variance", null, null, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("scaleYOscillationFrequency"))
		{
			floatDrag = new ExposedFloatDrag("scaleYOscillationFrequency", "y frequency", null, null, 0.1);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("scaleYOscillationUnifiedFrequencyVariance"))
		{
			bool = new ExposedBool("scaleYOscillationUnifiedFrequencyVariance", "unified frequency variance");
			subGroup.addValue(bool);
			
			collection.registerForValueChangeExternal("scaleYOscillationUnifiedFrequencyVariance", scaleYOscillationUnifiedFrequencyVarianceChange);
		}
		
		if (!subGroup.hasValue("scaleYOscillationFrequencyVariance"))
		{
			floatDrag = new ExposedFloatDrag("scaleYOscillationFrequencyVariance", "y frequency variance", null, null, 0.1);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("scaleYOscillationFrequencyInverted"))
		{
			bool = new ExposedBool("scaleYOscillationFrequencyInverted", "invert y frequency");
			subGroup.addValue(bool);
		}
		
		if (!subGroup.hasValue("scaleYOscillationFrequencyStart"))
		{
			select = new ExposedSelect("scaleYOscillationFrequencyStart", "frequency start");
			select.choiceListFunction = OscillationFrequencyStart.getValues;
			select.valueListFunction = OscillationFrequencyStart.getValues;
			subGroup.addValue(select);
		}
		
		if (!group.hasGroup("SkewX"))
		{
			subGroup = new ExposedGroup("SkewX");
			group.addValue(subGroup);
		}
		else
		{
			subGroup = group.getGroup("SkewX");
		}
		
		if (!subGroup.hasValue("skewXOscillationFrequencyMode"))
		{
			select = new ExposedSelect("skewXOscillationFrequencyMode", "frequency mode");
			select.choiceListFunction = OscillationFrequencyMode.getValues;
			select.valueListFunction = OscillationFrequencyMode.getValues;
			subGroup.addValue(select);
			
			collection.registerForValueChangeExternal("skewXOscillationFrequencyMode", skewXOscillationFrequencyModeChange);
		}
		
		if (!subGroup.hasValue("skewXOscillationGroupStartStep"))
		{
			floatDrag = new ExposedFloatDrag("skewXOscillationGroupStartStep", "group start step", null, null, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("skewXOscillation"))
		{
			floatDrag = new ExposedFloatDrag("skewXOscillation", "x", null, null, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("skewXOscillationVariance"))
		{
			floatDrag = new ExposedFloatDrag("skewXOscillationVariance", "x variance", null, null, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("skewXOscillationFrequency"))
		{
			floatDrag = new ExposedFloatDrag("skewXOscillationFrequency", "x frequency", null, null, 0.1);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("skewXOscillationUnifiedFrequencyVariance"))
		{
			bool = new ExposedBool("skewXOscillationUnifiedFrequencyVariance", "unified frequency variance");
			subGroup.addValue(bool);
			
			collection.registerForValueChangeExternal("skewXOscillationUnifiedFrequencyVariance", skewXOscillationUnifiedFrequencyVarianceChange);
		}
		
		if (!subGroup.hasValue("skewXOscillationFrequencyVariance"))
		{
			floatDrag = new ExposedFloatDrag("skewXOscillationFrequencyVariance", "x frequency variance", null, null, 0.1);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("skewXOscillationFrequencyInverted"))
		{
			bool = new ExposedBool("skewXOscillationFrequencyInverted", "invert x frequency");
			subGroup.addValue(bool);
		}
		
		if (!subGroup.hasValue("skewXOscillationFrequencyStart"))
		{
			select = new ExposedSelect("skewXOscillationFrequencyStart", "frequency start");
			select.choiceListFunction = OscillationFrequencyStart.getValues;
			select.valueListFunction = OscillationFrequencyStart.getValues;
			subGroup.addValue(select);
		}
		
		if (!group.hasGroup("SkewY"))
		{
			subGroup = new ExposedGroup("SkewY");
			group.addValue(subGroup);
		}
		else
		{
			subGroup = group.getGroup("SkewY");
		}
		
		if (!subGroup.hasValue("skewYOscillationFrequencyMode"))
		{
			select = new ExposedSelect("skewYOscillationFrequencyMode", "frequency mode");
			select.choiceListFunction = OscillationFrequencyMode.getValues;
			select.valueListFunction = OscillationFrequencyMode.getValues;
			subGroup.addValue(select);
			
			collection.registerForValueChangeExternal("skewYOscillationFrequencyMode", skewYOscillationFrequencyModeChange);
		}
		
		if (!subGroup.hasValue("skewYOscillationGroupStartStep"))
		{
			floatDrag = new ExposedFloatDrag("skewYOscillationGroupStartStep", "group start step", null, null, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("skewYOscillation"))
		{
			floatDrag = new ExposedFloatDrag("skewYOscillation", "y", null, null, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("skewYOscillationVariance"))
		{
			floatDrag = new ExposedFloatDrag("skewYOscillationVariance", "y variance", null, null, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("skewYOscillationFrequency"))
		{
			floatDrag = new ExposedFloatDrag("skewYOscillationFrequency", "y frequency", null, null, 0.1);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("skewYOscillationUnifiedFrequencyVariance"))
		{
			bool = new ExposedBool("skewYOscillationUnifiedFrequencyVariance", "unified frequency variance");
			subGroup.addValue(bool);
			
			collection.registerForValueChangeExternal("skewYOscillationUnifiedFrequencyVariance", skewYOscillationUnifiedFrequencyVarianceChange);
		}
		
		if (!subGroup.hasValue("skewYOscillationFrequencyVariance"))
		{
			floatDrag = new ExposedFloatDrag("skewYOscillationFrequencyVariance", "y frequency variance", null, null, 0.1);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("skewYOscillationFrequencyInverted"))
		{
			bool = new ExposedBool("skewYOscillationFrequencyInverted", "invert y frequency");
			subGroup.addValue(bool);
		}
		
		if (!subGroup.hasValue("skewYOscillationFrequencyStart"))
		{
			select = new ExposedSelect("skewYOscillationFrequencyStart", "frequency start");
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
		
		if (!subGroup.hasValue("ColorNote"))
		{
			note = new ExposedNote("ColorNote", "note that this won't have any effect if Display's colorMode is set to 'none' or 'display'");
			subGroup.addValue(note);
		}
		
		if (!subGroup.hasValue("colorOscillationFrequencyMode"))
		{
			select = new ExposedSelect("colorOscillationFrequencyMode", "frequency mode");
			select.choiceListFunction = OscillationFrequencyMode.getValues;
			select.valueListFunction = OscillationFrequencyMode.getValues;
			subGroup.addValue(select);
			
			collection.registerForValueChangeExternal("colorOscillationFrequencyMode", oscillationColorFrequencyModeChange);
		}
		
		if (!subGroup.hasValue("colorOscillationGroupStartStep"))
		{
			floatDrag = new ExposedFloatDrag("colorOscillationGroupStartStep", "group start step", null, null, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("colorOscillation"))
		{
			obj = new ExposedObject("colorOscillation", "color");
			subGroup.addValue(obj);
		}
		
		if (!subGroup.hasValue("colorOscillationVariance"))
		{
			obj = new ExposedObject("colorOscillationVariance", "color variance");
			subGroup.addValue(obj);
		}
		
		if (!subGroup.hasValue("colorOscillationFrequency"))
		{
			floatDrag = new ExposedFloatDrag("colorOscillationFrequency", "frequency", null, null, 0.1);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("colorOscillationUnifiedFrequencyVariance"))
		{
			bool = new ExposedBool("colorOscillationUnifiedFrequencyVariance", "unified frequency variance");
			subGroup.addValue(bool);
			
			collection.registerForValueChangeExternal("colorOscillationUnifiedFrequencyVariance", colorOscillationUnifiedFrequencyVarianceChange);
		}
		
		if (!subGroup.hasValue("colorOscillationFrequencyVariance"))
		{
			floatDrag = new ExposedFloatDrag("colorOscillationFrequencyVariance", "frequency variance", null, null, 0.1);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("colorOscillationFrequencyInverted"))
		{
			bool = new ExposedBool("colorOscillationFrequencyInverted", "invert frequency");
			subGroup.addValue(bool);
		}
		
		if (!subGroup.hasValue("colorOscillationFrequencyStart"))
		{
			select = new ExposedSelect("colorOscillationFrequencyStart", "frequency start");
			select.choiceListFunction = OscillationFrequencyStart.getValues;
			select.valueListFunction = OscillationFrequencyStart.getValues;
			subGroup.addValue(select);
		}
		
		if (!group.hasGroup("ColorOffset"))
		{
			subGroup = new ExposedGroup("ColorOffset", "Color Offset");
			group.addValue(subGroup);
		}
		else
		{
			subGroup = group.getGroup("ColorOffset");
		}
		
		if (!subGroup.hasValue("ColorOffsetNote"))
		{
			note = new ExposedNote("ColorOffsetNote", "note that this won't have any effect unless Display's colorOffsetMode is set to 'object' or 'display_and_object'");
			subGroup.addValue(note);
		}
		
		if (!subGroup.hasValue("colorOffsetOscillationFrequencyMode"))
		{
			select = new ExposedSelect("colorOffsetOscillationFrequencyMode", "frequency mode");
			select.choiceListFunction = OscillationFrequencyMode.getValues;
			select.valueListFunction = OscillationFrequencyMode.getValues;
			subGroup.addValue(select);
			
			collection.registerForValueChangeExternal("colorOffsetOscillationFrequencyMode", oscillationColorOffsetFrequencyModeChange);
		}
		
		if (!subGroup.hasValue("colorOffsetOscillationGroupStartStep"))
		{
			floatDrag = new ExposedFloatDrag("colorOffsetOscillationGroupStartStep", "group start step", null, null, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("colorOffsetOscillation"))
		{
			obj = new ExposedObject("colorOffsetOscillation", "color");
			subGroup.addValue(obj);
		}
		
		if (!subGroup.hasValue("colorOffsetOscillationVariance"))
		{
			obj = new ExposedObject("colorOffsetOscillationVariance", "color variance");
			subGroup.addValue(obj);
		}
		
		if (!subGroup.hasValue("colorOffsetOscillationFrequency"))
		{
			floatDrag = new ExposedFloatDrag("colorOffsetOscillationFrequency", "frequency", null, null, 0.1);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("colorOffsetOscillationUnifiedFrequencyVariance"))
		{
			bool = new ExposedBool("colorOffsetOscillationUnifiedFrequencyVariance", "unified frequency variance");
			subGroup.addValue(bool);
			
			collection.registerForValueChangeExternal("colorOffsetOscillationUnifiedFrequencyVariance", colorOffsetOscillationUnifiedFrequencyVarianceChange);
		}
		
		if (!subGroup.hasValue("colorOffsetOscillationFrequencyVariance"))
		{
			floatDrag = new ExposedFloatDrag("colorOffsetOscillationFrequencyVariance", "frequency variance", null, null, 0.1);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("colorOffsetOscillationFrequencyInverted"))
		{
			bool = new ExposedBool("colorOffsetOscillationFrequencyInverted", "invert frequency");
			subGroup.addValue(bool);
		}
		
		if (!subGroup.hasValue("colorOffsetOscillationFrequencyStart"))
		{
			select = new ExposedSelect("colorOffsetOscillationFrequencyStart", "frequency start");
			select.choiceListFunction = OscillationFrequencyStart.getValues;
			select.valueListFunction = OscillationFrequencyStart.getValues;
			subGroup.addValue(select);
		}
		
		MassiveDisplayData.exposeMassiveImageLayer(collection, groupName);
		
		return collection;
	}
	
	static private function alignRadialRotationChange(alignValue:ExposedValue):Void
	{
		var collection:ExposedCollection = alignValue.collection;
		var value:ExposedValue;
		if (alignValue.value == true)
		{
			value = collection.getValue("alignRadialRotationOffset");
			value.isReadOnly = false;
			value = collection.getValue("alignRadialRotationOffsetVariance");
			value.isReadOnly = false;
		}
		else
		{
			value = collection.getValue("alignRadialRotationOffset");
			value.isReadOnly = true;
			value = collection.getValue("alignRadialRotationOffsetVariance");
			value.isReadOnly = true;
		}
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
	
	static private function emitterRadiusOverridesParticleAngleChange(overrideValue:ExposedValue):Void
	{
		var collection:ExposedCollection = overrideValue.collection;
		var enabled:Bool = overrideValue.value;
		var value:ExposedValue;
		
		value = collection.getValue("emitterRadiusParticleAngleOffset");
		value.isReadOnly = !enabled;
		
		value = collection.getValue("emitterRadiusParticleAngleOffsetVariance");
		value.isReadOnly = !enabled;
	}
	
	static private function emitAngleAlignedRotationChange(alignedRotationValue:ExposedValue):Void
	{
		var value:ExposedValue = alignedRotationValue.collection.getValue("emitAngleAlignedRotationOffset");
		if (alignedRotationValue.value == true)
		{
			value.isReadOnly = false;
		}
		else
		{
			value.isReadOnly = true;
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
	
	static private function colorOffsetEndRelativeToStartChange(offsetEndValue:ExposedValue):Void
	{
		var value:ExposedValue = offsetEndValue.collection.getValue("colorOffsetEndIsMultiplier");
		if (offsetEndValue.value == true)
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
	
	static private function positionOscillationFrequencyModeChange(frequencyModeValue:ExposedValue):Void
	{
		var collection:ExposedCollection = frequencyModeValue.collection;
		var value:ExposedValue;
		
		if (frequencyModeValue.value == OscillationFrequencyMode.GLOBAL)
		{
			value = collection.getValue("positionOscillationGroupStartStep");
			value.isReadOnly = true;
			
			value = collection.getValue("positionOscillationFrequency");
			value.isReadOnly = true;
			
			value = collection.getValue("positionOscillationUnifiedFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("positionOscillationFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("positionOscillationFrequencyStart");
			value.isReadOnly = true;
		}
		else if (frequencyModeValue.value == OscillationFrequencyMode.GROUP)
		{
			value = collection.getValue("positionOscillationGroupStartStep");
			value.isReadOnly = false;
			
			value = collection.getValue("positionOscillationFrequency");
			value.isReadOnly = false;
			
			value = collection.getValue("positionOscillationUnifiedFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("positionOscillationFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("positionOscillationFrequencyStart");
			value.isReadOnly = true;
		}
		else
		{
			value = collection.getValue("positionOscillationGroupStartStep");
			value.isReadOnly = true;
			
			value = collection.getValue("positionOscillationFrequency");
			value.isReadOnly = false;
			
			value = collection.getValue("positionOscillationUnifiedFrequencyVariance");
			value.isReadOnly = false;
			
			if (value.value == true)
			{
				value = collection.getValue("positionOscillationFrequencyVariance");
				value.isReadOnly = true;
			}
			else
			{
				value = collection.getValue("positionOscillationFrequencyVariance");
				value.isReadOnly = false;
			}
			
			value = collection.getValue("positionOscillationFrequencyStart");
			value.isReadOnly = false;
		}
	}
	
	static private function position2OscillationFrequencyModeChange(frequencyModeValue:ExposedValue):Void
	{
		var collection:ExposedCollection = frequencyModeValue.collection;
		var value:ExposedValue;
		
		if (frequencyModeValue.value == OscillationFrequencyMode.GLOBAL)
		{
			value = collection.getValue("position2OscillationGroupStartStep");
			value.isReadOnly = true;
			
			value = collection.getValue("position2OscillationFrequency");
			value.isReadOnly = true;
			
			value = collection.getValue("position2OscillationUnifiedFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("position2OscillationFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("position2OscillationFrequencyStart");
			value.isReadOnly = true;
		}
		else if (frequencyModeValue.value == OscillationFrequencyMode.GROUP)
		{
			value = collection.getValue("position2OscillationGroupStartStep");
			value.isReadOnly = false;
			
			value = collection.getValue("position2OscillationFrequency");
			value.isReadOnly = false;
			
			value = collection.getValue("position2OscillationUnifiedFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("position2OscillationFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("position2OscillationFrequencyStart");
			value.isReadOnly = true;
		}
		else
		{
			value = collection.getValue("position2OscillationGroupStartStep");
			value.isReadOnly = true;
			
			value = collection.getValue("position2OscillationFrequency");
			value.isReadOnly = false;
			
			value = collection.getValue("position2OscillationUnifiedFrequencyVariance");
			value.isReadOnly = false;
			
			if (value.value == true)
			{
				value = collection.getValue("position2OscillationFrequencyVariance");
				value.isReadOnly = true;
			}
			else
			{
				value = collection.getValue("position2OscillationFrequencyVariance");
				value.isReadOnly = false;
			}
			
			value = collection.getValue("position2OscillationFrequencyStart");
			value.isReadOnly = false;
		}
	}
	
	static private function rotationOscillationFrequencyModeChange(frequencyModeValue:ExposedValue):Void
	{
		var collection:ExposedCollection = frequencyModeValue.collection;
		var value:ExposedValue;
		
		if (frequencyModeValue.value == OscillationFrequencyMode.GLOBAL)
		{
			value = collection.getValue("rotationOscillationGroupStartStep");
			value.isReadOnly = true;
			
			value = collection.getValue("rotationOscillationFrequency");
			value.isReadOnly = true;
			
			value = collection.getValue("rotationOscillationUnifiedFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("rotationOscillationFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("rotationOscillationFrequencyStart");
			value.isReadOnly = true;
		}
		else if (frequencyModeValue.value == OscillationFrequencyMode.GROUP)
		{
			value = collection.getValue("rotationOscillationGroupStartStep");
			value.isReadOnly = false;
			
			value = collection.getValue("rotationOscillationFrequency");
			value.isReadOnly = false;
			
			value = collection.getValue("rotationOscillationUnifiedFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("rotationOscillationFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("rotationOscillationFrequencyStart");
			value.isReadOnly = true;
		}
		else
		{
			value = collection.getValue("rotationOscillationGroupStartStep");
			value.isReadOnly = true;
			
			value = collection.getValue("rotationOscillationFrequency");
			value.isReadOnly = false;
			
			value = collection.getValue("rotationOscillationUnifiedFrequencyVariance");
			value.isReadOnly = false;
			
			if (value.value == true)
			{
				value = collection.getValue("rotationOscillationFrequencyVariance");
				value.isReadOnly = true;
			}
			else
			{
				value = collection.getValue("rotationOscillationFrequencyVariance");
				value.isReadOnly = false;
			}
			
			value = collection.getValue("rotationOscillationFrequencyStart");
			value.isReadOnly = false;
		}
	}
	
	static private function scaleXOscillationFrequencyModeChange(frequencyModeValue:ExposedValue):Void
	{
		var collection:ExposedCollection = frequencyModeValue.collection;
		var value:ExposedValue;
		
		if (frequencyModeValue.value == OscillationFrequencyMode.GLOBAL)
		{
			value = collection.getValue("scaleXOscillationGroupStartStep");
			value.isReadOnly = true;
			
			value = collection.getValue("scaleXOscillationFrequency");
			value.isReadOnly = true;
			
			value = collection.getValue("scaleXOscillationUnifiedFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("scaleXOscillationFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("scaleXOscillationFrequencyStart");
			value.isReadOnly = true;
		}
		else if (frequencyModeValue.value == OscillationFrequencyMode.GROUP)
		{
			value = collection.getValue("scaleXOscillationGroupStartStep");
			value.isReadOnly = false;
			
			value = collection.getValue("scaleXOscillationFrequency");
			value.isReadOnly = false;
			
			value = collection.getValue("scaleXOscillationUnifiedFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("scaleXOscillationFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("scaleXOscillationFrequencyStart");
			value.isReadOnly = true;
		}
		else
		{
			value = collection.getValue("scaleXOscillationGroupStartStep");
			value.isReadOnly = true;
			
			value = collection.getValue("scaleXOscillationFrequency");
			value.isReadOnly = false;
			
			value = collection.getValue("scaleXOscillationUnifiedFrequencyVariance");
			value.isReadOnly = false;
			
			if (value.value == true)
			{
				value = collection.getValue("scaleXOscillationFrequencyVariance");
				value.isReadOnly = true;
			}
			else
			{
				value = collection.getValue("scaleXOscillationFrequencyVariance");
				value.isReadOnly = false;
			}
			
			value = collection.getValue("scaleXOscillationFrequencyStart");
			value.isReadOnly = false;
		}
	}
	
	static private function scaleYOscillationFrequencyModeChange(frequencyModeValue:ExposedValue):Void
	{
		var collection:ExposedCollection = frequencyModeValue.collection;
		var value:ExposedValue;
		
		if (frequencyModeValue.value == OscillationFrequencyMode.GLOBAL)
		{
			value = collection.getValue("scaleYOscillationGroupStartStep");
			value.isReadOnly = true;
			
			value = collection.getValue("scaleYOscillationFrequency");
			value.isReadOnly = true;
			
			value = collection.getValue("scaleYOscillationUnifiedFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("scaleYOscillationFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("scaleYOscillationFrequencyStart");
			value.isReadOnly = true;
		}
		else if (frequencyModeValue.value == OscillationFrequencyMode.GROUP)
		{
			value = collection.getValue("scaleYOscillationGroupStartStep");
			value.isReadOnly = false;
			
			value = collection.getValue("scaleYOscillationFrequency");
			value.isReadOnly = false;
			
			value = collection.getValue("scaleYOscillationUnifiedFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("scaleYOscillationFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("scaleYOscillationFrequencyStart");
			value.isReadOnly = true;
		}
		else
		{
			value = collection.getValue("scaleYOscillationGroupStartStep");
			value.isReadOnly = true;
			
			value = collection.getValue("scaleYOscillationFrequency");
			value.isReadOnly = false;
			
			value = collection.getValue("scaleYOscillationUnifiedFrequencyVariance");
			value.isReadOnly = false;
			
			if (value.value == true)
			{
				value = collection.getValue("scaleYOscillationFrequencyVariance");
				value.isReadOnly = true;
			}
			else
			{
				value = collection.getValue("scaleYOscillationFrequencyVariance");
				value.isReadOnly = false;
			}
			
			value = collection.getValue("scaleYOscillationFrequencyStart");
			value.isReadOnly = false;
		}
	}
	
	static private function skewXOscillationFrequencyModeChange(frequencyModeValue:ExposedValue):Void
	{
		var collection:ExposedCollection = frequencyModeValue.collection;
		var value:ExposedValue;
		
		if (frequencyModeValue.value == OscillationFrequencyMode.GLOBAL)
		{
			value = collection.getValue("skewXOscillationGroupStartStep");
			value.isReadOnly = true;
			
			value = collection.getValue("skewXOscillationFrequency");
			value.isReadOnly = true;
			
			value = collection.getValue("skewXOscillationUnifiedFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("skewXOscillationFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("skewXOscillationFrequencyStart");
			value.isReadOnly = true;
		}
		else if (frequencyModeValue.value == OscillationFrequencyMode.GROUP)
		{
			value = collection.getValue("skewXOscillationGroupStartStep");
			value.isReadOnly = false;
			
			value = collection.getValue("skewXOscillationFrequency");
			value.isReadOnly = false;
			
			value = collection.getValue("skewXOscillationUnifiedFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("skewXOscillationFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("skewXOscillationFrequencyStart");
			value.isReadOnly = true;
		}
		else
		{
			value = collection.getValue("skewXOscillationGroupStartStep");
			value.isReadOnly = true;
			
			value = collection.getValue("skewXOscillationFrequency");
			value.isReadOnly = false;
			
			value = collection.getValue("skewXOscillationUnifiedFrequencyVariance");
			value.isReadOnly = false;
			
			if (value.value == true)
			{
				value = collection.getValue("skewXOscillationFrequencyVariance");
				value.isReadOnly = true;
			}
			else
			{
				value = collection.getValue("skewXOscillationFrequencyVariance");
				value.isReadOnly = false;
			}
			
			value = collection.getValue("skewXOscillationFrequencyStart");
			value.isReadOnly = false;
		}
	}
	
	static private function skewYOscillationFrequencyModeChange(frequencyModeValue:ExposedValue):Void
	{
		var collection:ExposedCollection = frequencyModeValue.collection;
		var value:ExposedValue;
		
		if (frequencyModeValue.value == OscillationFrequencyMode.GLOBAL)
		{
			value = collection.getValue("skewYOscillationGroupStartStep");
			value.isReadOnly = true;
			
			value = collection.getValue("skewYOscillationFrequency");
			value.isReadOnly = true;
			
			value = collection.getValue("skewYOscillationUnifiedFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("skewYOscillationFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("skewYOscillationFrequencyStart");
			value.isReadOnly = true;
		}
		else if (frequencyModeValue.value == OscillationFrequencyMode.GROUP)
		{
			value = collection.getValue("skewYOscillationGroupStartStep");
			value.isReadOnly = false;
			
			value = collection.getValue("skewYOscillationFrequency");
			value.isReadOnly = false;
			
			value = collection.getValue("skewYOscillationUnifiedFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("skewYOscillationFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("skewYOscillationFrequencyStart");
			value.isReadOnly = true;
		}
		else
		{
			value = collection.getValue("skewYOscillationGroupStartStep");
			value.isReadOnly = true;
			
			value = collection.getValue("skewYOscillationFrequency");
			value.isReadOnly = false;
			
			value = collection.getValue("skewYOscillationUnifiedFrequencyVariance");
			value.isReadOnly = false;
			
			if (value.value == true)
			{
				value = collection.getValue("skewYOscillationFrequencyVariance");
				value.isReadOnly = true;
			}
			else
			{
				value = collection.getValue("skewYOscillationFrequencyVariance");
				value.isReadOnly = false;
			}
			
			value = collection.getValue("skewYOscillationFrequencyStart");
			value.isReadOnly = false;
		}
	}
	
	static private function oscillationColorFrequencyModeChange(frequencyModeValue:ExposedValue):Void
	{
		var collection:ExposedCollection = frequencyModeValue.collection;
		var value:ExposedValue;
		
		if (frequencyModeValue.value == OscillationFrequencyMode.GLOBAL)
		{
			value = collection.getValue("colorOscillationGroupStartStep");
			value.isReadOnly = true;
			
			value = collection.getValue("colorOscillationFrequency");
			value.isReadOnly = true;
			
			value = collection.getValue("colorOscillationUnifiedFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("colorOscillationFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("colorOscillationFrequencyStart");
			value.isReadOnly = true;
		}
		else if (frequencyModeValue.value == OscillationFrequencyMode.GROUP)
		{
			value = collection.getValue("colorOscillationGroupStartStep");
			value.isReadOnly = false;
			
			value = collection.getValue("colorOscillationFrequency");
			value.isReadOnly = false;
			
			value = collection.getValue("colorOscillationUnifiedFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("colorOscillationFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("colorOscillationFrequencyStart");
			value.isReadOnly = true;
		}
		else
		{
			value = collection.getValue("colorOscillationGroupStartStep");
			value.isReadOnly = true;
			
			value = collection.getValue("colorOscillationFrequency");
			value.isReadOnly = false;
			
			value = collection.getValue("colorOscillationUnifiedFrequencyVariance");
			value.isReadOnly = false;
			
			if (value.value == true)
			{
				value = collection.getValue("colorOscillationFrequencyVariance");
				value.isReadOnly = true;
			}
			else
			{
				value = collection.getValue("colorOscillationFrequencyVariance");
				value.isReadOnly = false;
			}
			
			value = collection.getValue("colorOscillationFrequencyStart");
			value.isReadOnly = false;
		}
	}
	
	static private function oscillationColorOffsetFrequencyModeChange(frequencyModeValue:ExposedValue):Void
	{
		var collection:ExposedCollection = frequencyModeValue.collection;
		var value:ExposedValue;
		
		if (frequencyModeValue.value == OscillationFrequencyMode.GLOBAL)
		{
			value = collection.getValue("colorOffsetOscillationGroupStartStep");
			value.isReadOnly = true;
			
			value = collection.getValue("colorOffsetOscillationFrequency");
			value.isReadOnly = true;
			
			value = collection.getValue("colorOffsetOscillationUnifiedFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("colorOffsetOscillationFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("colorOffsetOscillationFrequencyStart");
			value.isReadOnly = true;
		}
		else if (frequencyModeValue.value == OscillationFrequencyMode.GROUP)
		{
			value = collection.getValue("colorOffsetOscillationGroupStartStep");
			value.isReadOnly = false;
			
			value = collection.getValue("colorOffsetOscillationFrequency");
			value.isReadOnly = false;
			
			value = collection.getValue("colorOffsetOscillationUnifiedFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("colorOffsetOscillationFrequencyVariance");
			value.isReadOnly = true;
			
			value = collection.getValue("colorOffsetOscillationFrequencyStart");
			value.isReadOnly = true;
		}
		else
		{
			value = collection.getValue("colorOffsetOscillationGroupStartStep");
			value.isReadOnly = true;
			
			value = collection.getValue("colorOffsetOscillationFrequency");
			value.isReadOnly = false;
			
			value = collection.getValue("colorOffsetOscillationUnifiedFrequencyVariance");
			value.isReadOnly = false;
			
			if (value.value == true)
			{
				value = collection.getValue("colorOffsetOscillationFrequencyVariance");
				value.isReadOnly = true;
			}
			else
			{
				value = collection.getValue("colorOffsetOscillationFrequencyVariance");
				value.isReadOnly = false;
			}
			
			value = collection.getValue("colorOffsetOscillationFrequencyStart");
			value.isReadOnly = false;
		}
	}
	
	static private function positionOscillationUnifiedFrequencyVarianceChange(unifiedFrequencyVarianceValue:ExposedValue):Void
	{
		if (unifiedFrequencyVarianceValue.isReadOnly) return;
		
		var collection:ExposedCollection = unifiedFrequencyVarianceValue.collection;
		var value:ExposedValue;
		
		if (unifiedFrequencyVarianceValue.value == true)
		{
			value = collection.getValue("positionOscillationFrequencyVariance");
			value.isReadOnly = true;
		}
		else
		{
			value = collection.getValue("positionOscillationFrequencyVariance");
			value.isReadOnly = false;
		}
	}
	
	static private function position2OscillationUnifiedFrequencyVarianceChange(unifiedFrequencyVarianceValue:ExposedValue):Void
	{
		if (unifiedFrequencyVarianceValue.isReadOnly) return;
		
		var collection:ExposedCollection = unifiedFrequencyVarianceValue.collection;
		var value:ExposedValue;
		
		if (unifiedFrequencyVarianceValue.value == true)
		{
			value = collection.getValue("position2OscillationFrequencyVariance");
			value.isReadOnly = true;
		}
		else
		{
			value = collection.getValue("position2OscillationFrequencyVariance");
			value.isReadOnly = false;
		}
	}
	
	static private function rotationOscillationUnifiedFrequencyVarianceChange(unifiedFrequencyVarianceValue:ExposedValue):Void
	{
		if (unifiedFrequencyVarianceValue.isReadOnly) return;
		
		var collection:ExposedCollection = unifiedFrequencyVarianceValue.collection;
		var value:ExposedValue;
		
		if (unifiedFrequencyVarianceValue.value == true)
		{
			value = collection.getValue("rotationOscillationFrequencyVariance");
			value.isReadOnly = true;
		}
		else
		{
			value = collection.getValue("rotationOscillationFrequencyVariance");
			value.isReadOnly = false;
		}
	}
	
	static private function scaleXOscillationUnifiedFrequencyVarianceChange(unifiedFrequencyVarianceValue:ExposedValue):Void
	{
		if (unifiedFrequencyVarianceValue.isReadOnly) return;
		
		var collection:ExposedCollection = unifiedFrequencyVarianceValue.collection;
		var value:ExposedValue;
		
		if (unifiedFrequencyVarianceValue.value == true)
		{
			value = collection.getValue("scaleXOscillationFrequencyVariance");
			value.isReadOnly = true;
		}
		else
		{
			value = collection.getValue("scaleXOscillationFrequencyVariance");
			value.isReadOnly = false;
		}
	}
	
	static private function scaleYOscillationUnifiedFrequencyVarianceChange(unifiedFrequencyVarianceValue:ExposedValue):Void
	{
		if (unifiedFrequencyVarianceValue.isReadOnly) return;
		
		var collection:ExposedCollection = unifiedFrequencyVarianceValue.collection;
		var value:ExposedValue;
		
		if (unifiedFrequencyVarianceValue.value == true)
		{
			value = collection.getValue("scaleYOscillationFrequencyVariance");
			value.isReadOnly = true;
		}
		else
		{
			value = collection.getValue("scaleYOscillationFrequencyVariance");
			value.isReadOnly = false;
		}
	}
	
	static private function skewXOscillationUnifiedFrequencyVarianceChange(unifiedFrequencyVarianceValue:ExposedValue):Void
	{
		if (unifiedFrequencyVarianceValue.isReadOnly) return;
		
		var collection:ExposedCollection = unifiedFrequencyVarianceValue.collection;
		var value:ExposedValue;
		
		if (unifiedFrequencyVarianceValue.value == true)
		{
			value = collection.getValue("skewXOscillationFrequencyVariance");
			value.isReadOnly = true;
		}
		else
		{
			value = collection.getValue("skewXOscillationFrequencyVariance");
			value.isReadOnly = false;
		}
	}
	
	static private function skewYOscillationUnifiedFrequencyVarianceChange(unifiedFrequencyVarianceValue:ExposedValue):Void
	{
		if (unifiedFrequencyVarianceValue.isReadOnly) return;
		
		var collection:ExposedCollection = unifiedFrequencyVarianceValue.collection;
		var value:ExposedValue;
		
		if (unifiedFrequencyVarianceValue.value == true)
		{
			value = collection.getValue("skewYOscillationFrequencyVariance");
			value.isReadOnly = true;
		}
		else
		{
			value = collection.getValue("skewYOscillationFrequencyVariance");
			value.isReadOnly = false;
		}
	}
	
	static private function colorOscillationUnifiedFrequencyVarianceChange(unifiedFrequencyVarianceValue:ExposedValue):Void
	{
		if (unifiedFrequencyVarianceValue.isReadOnly) return;
		
		var collection:ExposedCollection = unifiedFrequencyVarianceValue.collection;
		var value:ExposedValue;
		
		if (unifiedFrequencyVarianceValue.value == true)
		{
			value = collection.getValue("colorOscillationFrequencyVariance");
			value.isReadOnly = true;
		}
		else
		{
			value = collection.getValue("colorOscillationFrequencyVariance");
			value.isReadOnly = false;
		}
	}
	
	static private function colorOffsetOscillationUnifiedFrequencyVarianceChange(unifiedFrequencyVarianceValue:ExposedValue):Void
	{
		if (unifiedFrequencyVarianceValue.isReadOnly) return;
		
		var collection:ExposedCollection = unifiedFrequencyVarianceValue.collection;
		var value:ExposedValue;
		
		if (unifiedFrequencyVarianceValue.value == true)
		{
			value = collection.getValue("colorOffsetOscillationFrequencyVariance");
			value.isReadOnly = true;
		}
		else
		{
			value = collection.getValue("colorOffsetOscillationFrequencyVariance");
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
//#end