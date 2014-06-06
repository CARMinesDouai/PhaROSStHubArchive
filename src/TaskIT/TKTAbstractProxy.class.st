Class {
	#name : #TKTAbstractProxy,
	#superclass : #GHTargetBasedProxy,
	#category : #'TaskIT-Sugar'
}

{ #category : #'accessing instances and variables' }
TKTAbstractProxy class >> allInstances [
	"Answer a collection of all current instances of the receiver."

	| all inst next |
	all := OrderedCollection new.
	inst := self someInstance.
	[inst == nil]
		whileFalse: [
		next := inst tktNextInstance.
		inst == all ifFalse: [all add: inst].
		inst := next].
	^ all asArray
]

{ #category : #enumerating }
TKTAbstractProxy class >> allInstancesDo: aBlock [ 
	"Evaluate the argument, aBlock, for each of the current instances of the 
	receiver.
	
	Because aBlock might change the class of inst (for example, using become:),
	it is essential to compute next before aBlock value: inst."
	| inst next |
	inst := self someInstance.
	[inst == nil]
		whileFalse:
		[
		next := inst tktNextInstance.
		aBlock value: inst.
		inst := next]
]

{ #category : #proxies }
TKTAbstractProxy class >> tktAllInstalledProxies [
	^ self allInstances select: [:each | each tktIsProxyInstalled ]
 

]

{ #category : #proxies }
TKTAbstractProxy class >> tktAllInstalledProxiesCount [
	^ self tktAllInstalledProxies size
	
]

{ #category : #enumerating }
TKTAbstractProxy >> nextObject [
	"Primitive. Answer the next object after the receiver in the 
	enumeration of all objects. Return 0 when all objects have been 
	enumerated."

	<primitive: 139>
	self primitiveFailed.
]

{ #category : #enumerating }
TKTAbstractProxy >> tktClass [
	"Primitive. Answer the object which is the receiver's class. Essential. See 
	Object documentation whatIsAPrimitive."

	<primitive: 111>
	self primitiveFailed
]

{ #category : #enumerating }
TKTAbstractProxy >> tktIsProxyInstalled [
	^ target notNil
]

{ #category : #enumerating }
TKTAbstractProxy >> tktNextInstance [
	"Primitive. Answer the next instance after the receiver in the 
	enumeration of all instances of this class. Fails if all instances have been 
	enumerated. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 78>
	^nil
]

{ #category : #enumerating }
TKTAbstractProxy >> tktprintString: aString [
	
	^ 'This is the print of a proxy of class: ',  self tktClass name asString.
]
