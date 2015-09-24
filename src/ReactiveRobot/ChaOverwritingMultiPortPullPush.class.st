Class {
	#name : #ChaOverwritingMultiPortPullPush,
	#superclass : #ChaMultiPortPullPush,
	#instVars : [
		'dataDict',
		'dataDictLock'
	],
	#category : #'ReactiveRobot-Experiments'
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
	| oldDataDict |
	dataDictLock critical: [
		oldDataDict := dataDict.
		self resetDataDict
	]. 
	oldDataDict keysAndValuesDo: [ : port : newData | 
		port set: newData
	].

]

{ #category : #acting }
ChaOverwritingMultiPortPullPush >> resetDataDict [
	dataDict := IdentityDictionary new
]
