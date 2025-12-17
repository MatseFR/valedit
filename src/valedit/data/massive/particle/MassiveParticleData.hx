package valedit.data.massive.particle;
//#if massive-starling
import massive.data.MassiveConstants;
import massive.particle.EmitterType;
import massive.particle.ParticleSystem;
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
		
		if (!group.hasGroup("Position"))
		{
			subGroup = new ExposedGroup("Position");
			group.addValue(subGroup);
		}
		else
		{
			subGroup = group.getGroup("Position");
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
		
		if (!subGroup.hasValue("oscillationPositionFrequencyVariance"))
		{
			floatDrag = new ExposedFloatDrag("oscillationPositionFrequencyVariance", "frequency variance", null, null, 0.1);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationPositionFrequencyRandomized"))
		{
			bool = new ExposedBool("oscillationPositionFrequencyRandomized");
			subGroup.addValue(bool);
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
		
		if (!subGroup.hasValue("oscillationPosition2FrequencyVariance"))
		{
			floatDrag = new ExposedFloatDrag("oscillationPosition2FrequencyVariance", "frequency variance", null, null, 0.1);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationPosition2FrequencyRandomized"))
		{
			bool = new ExposedBool("oscillationPosition2FrequencyRandomized");
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
		
		if (!subGroup.hasValue("oscillationRotationFrequencyVariance"))
		{
			floatDrag = new ExposedFloatDrag("oscillationRotationFrequencyVariance", "frequency variance", null, null, 0.1);
			subGroup.addValue(floatDrag);
		}
		
		if (!group.hasGroup("Scale"))
		{
			subGroup = new ExposedGroup("Scale");
			group.addValue(subGroup);
		}
		else
		{
			subGroup = group.getGroup("Scale");
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
		
		if (!subGroup.hasValue("oscillationScaleXFrequencyVariance"))
		{
			floatDrag = new ExposedFloatDrag("oscillationScaleXFrequencyVariance", "x frequency variance", null, null, 0.1);
			subGroup.addValue(floatDrag);
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
		
		if (!subGroup.hasValue("oscillationScaleYFrequencyVariance"))
		{
			floatDrag = new ExposedFloatDrag("oscillationScaleYFrequencyVariance", "y frequency variance", null, null, 0.1);
			subGroup.addValue(floatDrag);
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
		
		if (!subGroup.hasValue("oscillationColorRed"))
		{
			floatDrag = new ExposedFloatDrag("oscillationColorRed", "red", -1.0, 1.0, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationColorGreen"))
		{
			floatDrag = new ExposedFloatDrag("oscillationColorGreen", "green", -1.0, 1.0, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationColorBlue"))
		{
			floatDrag = new ExposedFloatDrag("oscillationColorBlue", "blue", -1.0, 1.0, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationColorAlpha"))
		{
			floatDrag = new ExposedFloatDrag("oscillationColorAlpha", "alpha", -1.0, 1.0, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationColorRedVariance"))
		{
			floatDrag = new ExposedFloatDrag("oscillationColorRedVariance", "red variance", 0.0, 1.0, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationColorGreenVariance"))
		{
			floatDrag = new ExposedFloatDrag("oscillationColorGreenVariance", "green variance", 0.0, 1.0, 0.01);
			subGroup.addValue(floatDrag);
		}
		
		if (!subGroup.hasValue("oscillationColorBlueVariance"))
		{
			floatDrag = new ExposedFloatDrag("oscillationColorBlueVariance", "blue variance", 0.0, 1.0, 0.01);
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
		
		if (!subGroup.hasValue("oscillationColorFrequencyVariance"))
		{
			floatDrag = new ExposedFloatDrag("oscillationColorFrequencyVariance", "frequency variance", null, null, 0.1);
			subGroup.addValue(floatDrag);
		}
		
		MassiveDisplayData.exposeMassiveImageLayer(collection, groupName);
		
		return collection;
	}
	
	static private function useAnimationLifeSpanChange(useValue:ExposedValue):Void
	{
		var enabled:Bool = useValue.value;
		var value:ExposedValue;
		
		value = useValue.collection.getValue("lifeSpan");
		value.isReadOnly = enabled;
		
		value = useValue.collection.getValue("lifeSpanVariance");
		value.isReadOnly = enabled;
	}
	
	static private function linkRotationToVelocityChange(linkValue:ExposedValue):Void
	{
		var enabled:Bool = linkValue.value;
		var value:ExposedValue;
		
		value = linkValue.collection.getValue("velocityRotationOffset");
		value.isReadOnly = !enabled;
		
		value = linkValue.collection.getValue("rotationStart");
		value.isReadOnly = enabled;
		
		value = linkValue.collection.getValue("rotationStartVariance");
		value.isReadOnly = enabled;
		
		value = linkValue.collection.getValue("rotationEnd");
		value.isReadOnly = enabled;
		
		value = linkValue.collection.getValue("rotationEndVariance");
		value.isReadOnly = enabled;
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