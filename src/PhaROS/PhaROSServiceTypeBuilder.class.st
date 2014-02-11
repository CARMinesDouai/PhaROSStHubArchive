"
PhaROSServiceTypeBuilder service named: #bla package: #lala request:{
		UInt8 named: #bla .
		String named: #sarasa .
		FixedArray named: #lala sized: 30 ofType: UInt16.
	} response: { 
		UInt8 named: #bla .
		String named: #sarasa .
		FixedArray named: #lala sized: 30 ofType: UInt16.
	}.
	
Is in charge of generating Ros definition of a service type, Pharo definition of the service type, and generate the related class in pharo. 

"
Class {
	#name : #PhaROSServiceTypeBuilder,
	#superclass : #Object,
	#instVars : [
		'request',
		'response',
		'package',
		'name'
	],
	#category : #'PhaROS-Types-DSL'
}

{ #category : #'as yet unclassified' }
PhaROSServiceTypeBuilder class >> named: aTypeName package: aPackageName request: aRequestDefinition response: aResponseDefinition [
	
	|response request|
	
	request := PhaROSMessageTypeBuilder named: (aTypeName,'Request') 
											  package: aPackageName 
											  defined: aRequestDefinition .
	response := PhaROSMessageTypeBuilder named: (aTypeName,'Response') 
											    package: aPackageName 
											    defined: aResponseDefinition .
	
	^ self new request: request; response: response; name: aTypeName; package: aPackageName; yourself.
]

{ #category : #'as yet unclassified' }
PhaROSServiceTypeBuilder class >> named: aTypeName  request: aDefinition response: otherDefinition [
	| packageTypeName |
	
	packageTypeName := '/' split: aTypeName.
	^ 
	self new request: aDefinition; response: otherDefinition; name: (packageTypeName at:1); package: (packageTypeName at:2); yourself.

]

{ #category : #accessing }
PhaROSServiceTypeBuilder >> build [
	^ PhaROSServiceType new request: request build ; response: response build; typeName: (package, '/', name); yourself.
]

{ #category : #dependencies }
PhaROSServiceTypeBuilder >> dependencies [
	^ request dependencies, response dependencies.
]

{ #category : #testing }
PhaROSServiceTypeBuilder >> isServiceType [
	^ true
]

{ #category : #accessing }
PhaROSServiceTypeBuilder >> name: anObject [
	name := anObject
]

{ #category : #accessing }
PhaROSServiceTypeBuilder >> package: anObject [
	package := anObject
]

{ #category : #accessing }
PhaROSServiceTypeBuilder >> request: anObject [
	request := anObject
]

{ #category : #accessing }
PhaROSServiceTypeBuilder >> response: anObject [
	response := anObject
]

{ #category : #accessing }
PhaROSServiceTypeBuilder >> rosdefinition [
	^ 
'
{1}
---
{2}
' format:{
	request rosdefinition . 
 	response rosdefinition
} .
]

{ #category : #accessing }
PhaROSServiceTypeBuilder >> shortName [
	^ name
]
