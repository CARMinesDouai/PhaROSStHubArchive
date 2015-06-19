Class {
	#name : #ChaOverwritingMultiPortPullPush,
	#superclass : #ChaMultiPortPullPush,
	#instVars : [
		'dataDict',
		'dataDictLock'
	],
	#category : #'ReactiveRobot-EmergencyStop'
}

{ #category : #'reflective operations' }
ChaOverwritingMultiPortPullPush >> doesNotUnderstand: aMessage [
	| port |
	port := self portNamed: aMessage selector ifAbsent: [^ super doesNotUnderstand: aMessage].
	^dataDictLock critical: [dataDict at: port put: aMessage argument]
]

{ #category : #'initialize-release' }
ChaOverwritingMultiPortPullPush >> initialize [
	super initialize.
	dataDictLock := Mutex new.
	self resetDataDict
]

{ #category : #acting }
ChaOverwritingMultiPortPullPush >> pullPush [
	| dataDictCopy |
	dataDictLock critical: [
		dataDictCopy := dataDict.
		self resetDataDict
	]. 
	dataDictCopy keysAndValuesDo: [ : port : newData | 
		port set: newData
	].

]

{ #category : #acting }
ChaOverwritingMultiPortPullPush >> resetDataDict [
	dataDict := IdentityDictionary new
]
