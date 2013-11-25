Class {
	#name : #PhaROSNamedLeafElement,
	#superclass : #PhaROSAbstractElement,
	#instVars : [
		'name',
		'nodeName'
	],
	#category : #'PhaROSInfrastructure-ROSLaunch'
}

{ #category : #'as yet unclassified' }
PhaROSNamedLeafElement class >> parameter [
	^ self new nodeName: 'param'; yourself.
]

{ #category : #'as yet unclassified' }
PhaROSNamedLeafElement class >> remap [
	^ self new nodeName: 'remap'; yourself.
]

{ #category : #'as yet unclassified' }
PhaROSNamedLeafElement class >> rosparameter [ 
	^ self new nodeName: 'rosparam'; yourself.
]

{ #category : #rosparam }
PhaROSNamedLeafElement >> command: aCommand [
	self at: #command put: aCommand ofType: String.
]

{ #category : #rosparam }
PhaROSNamedLeafElement >> file: aFileString [
	self at: #file put: aFileString ofType: String.
]

{ #category : #remap }
PhaROSNamedLeafElement >> from: aString [
	self at: #from put: aString ofType: String.
]

{ #category : #parameter }
PhaROSNamedLeafElement >> name: aParamName [
	^ self at: #name put: aParamName ofType: String.
]

{ #category : #'as yet unclassified' }
PhaROSNamedLeafElement >> nodeName [
	^ nodeName
]

{ #category : #'as yet unclassified' }
PhaROSNamedLeafElement >> nodeName: aName [
	nodeName := aName 
]

{ #category : #rosparam }
PhaROSNamedLeafElement >> ns: aNameSpace [
	self at: #ns put: aNameSpace ofType: String.
]

{ #category : #remap }
PhaROSNamedLeafElement >> to: aString [
	self at: #to put: aString ofType: String.
]

{ #category : #parameter }
PhaROSNamedLeafElement >> value: aParamValue [
	^ self at: #value put: aParamValue ofType: String.
]

{ #category : #'as yet unclassified' }
PhaROSNamedLeafElement >> xml [
	^( properties keys inject:( '<{1} ' format: {self nodeName} ) into: [ :acc :prop | acc,  prop asString, '="', (properties at: prop) asString, '" ' ]), '/>', String crlf.
]

{ #category : #'as yet unclassified' }
PhaROSNamedLeafElement >> xmlBody [ 
^''.
]
