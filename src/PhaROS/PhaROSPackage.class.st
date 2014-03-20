"
A PhaROSPackage class is the representation of a set of behaviors 
"
Class {
	#name : #PhaROSPackage,
	#superclass : #Object,
	#instVars : [
		'__ctrl'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'PhaROS-Package'
}

{ #category : #types }
PhaROSPackage class >> types [
	^ {  }
]

{ #category : #stdio }
PhaROSPackage >> askUserFor: aString [
	^ self nodelets io askUserFor: aString.
]

{ #category : #scripts }
PhaROSPackage >> controller [
	^ __ctrl ifNil: [ __ctrl := self buildController ].
]

{ #category : #scripts }
PhaROSPackage >> exit: aCode [
	Smalltalk exit: aCode.
]

{ #category : #log }
PhaROSPackage >> log: aString [
	self nodelets io stdout nextPutAll: (aString, String lf).
]

{ #category : #accessing }
PhaROSPackage >> node [
	^ self controller node.
]

{ #category : #accessing }
PhaROSPackage >> nodelets [
	^ self controller nodelets
]

{ #category : #stdio }
PhaROSPackage >> stdin [
	^ self nodelets io stdin
]

{ #category : #stdio }
PhaROSPackage >> stdout [
	^ self nodelets io stdout
]
