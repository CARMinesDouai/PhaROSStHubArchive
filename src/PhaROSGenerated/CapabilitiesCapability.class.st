Class {
	#name : #CapabilitiesCapability,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
CapabilitiesCapability class >> rosTypeDefinition [ 
^' string capability
 string provider
'
]

{ #category : #'as yet unclassified' }
CapabilitiesCapability class >> rosTypeName [ 
^'capabilities/Capability'
]

{ #category : #'as yet unclassified' }
CapabilitiesCapability >> capability [
	^ self getAt: #capability. 

]

{ #category : #'as yet unclassified' }
CapabilitiesCapability >> capability: aValue [
	^ self at: #capability put: aValue. 

]

{ #category : #'as yet unclassified' }
CapabilitiesCapability >> initialize [
	super initialize.
	 self capability: ''. 
	 self provider: ''. 

]

{ #category : #'as yet unclassified' }
CapabilitiesCapability >> provider [
	^ self getAt: #provider. 

]

{ #category : #'as yet unclassified' }
CapabilitiesCapability >> provider: aValue [
	^ self at: #provider put: aValue. 

]
