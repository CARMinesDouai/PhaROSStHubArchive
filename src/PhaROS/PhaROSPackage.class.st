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

{ #category : #abstract }
PhaROSPackage class >> author [
	self subclassResponsibility 
]

{ #category : #accessing }
PhaROSPackage class >> definedNodelets [
	^ {}
]

{ #category : #abstract }
PhaROSPackage class >> dependencies [
	^ { }
]

{ #category : #abstract }
PhaROSPackage class >> packageName [
	self subclassResponsibility 
]

{ #category : #abstract }
PhaROSPackage class >> version [ 
	self subclassResponsibility.
]

{ #category : #'helper thread' }
PhaROSPackage >> clock [
	^ PhaROSTickingClock new
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
	self stdout nextPutAll: (aString, String lf).
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
	^  FileStream stdin.
]

{ #category : #stdio }
PhaROSPackage >> stdout [ 
	^  FileStream stdout.
]
