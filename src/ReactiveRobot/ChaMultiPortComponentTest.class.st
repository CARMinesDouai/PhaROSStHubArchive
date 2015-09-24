Class {
	#name : #ChaMultiPortComponentTest,
	#superclass : #TestCase,
	#instVars : [
		'component',
		'portSetters'
	],
	#category : #'ReactiveRobot-Experiments'
}

{ #category : #testing }
ChaMultiPortComponentTest >> componentClass [
	^ChaMultiPortComponent
]

{ #category : #testing }
ChaMultiPortComponentTest >> setUp [
	super setUp.
	portSetters := #(data1: data2: data3:).
	component := self componentClass portSetters: portSetters.

]

{ #category : #testing }
ChaMultiPortComponentTest >> testPortsAccess [
	portSetters do: [ : setter | 
		self shouldnt: [component portNamed: setter] raise: Exception.
		self assert: (component dataOnPort: setter) equals: nil
	].

]

{ #category : #testing }
ChaMultiPortComponentTest >> testWritingDataIntoPort [
	| writtenData |
	writtenData := 1 to: portSetters size.
	portSetters with: writtenData do: [ : setter : setterArg | 
		self shouldnt: [component perform: setter with: setterArg] raise: Exception.
		self assert: (component dataOnPort: setter) equals: setterArg
	].

]
