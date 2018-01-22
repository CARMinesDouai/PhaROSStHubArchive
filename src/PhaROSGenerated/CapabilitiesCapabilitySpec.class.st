Class {
	#name : #CapabilitiesCapabilitySpec,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
CapabilitiesCapabilitySpec >> content [
	^ self getAt: #content. 

]

{ #category : #'as yet unclassified' }
CapabilitiesCapabilitySpec >> content: aValue [
	^ self at: #content put: aValue. 

]

{ #category : #'as yet unclassified' }
CapabilitiesCapabilitySpec >> default_provider [
	^ self getAt: #default_provider. 

]

{ #category : #'as yet unclassified' }
CapabilitiesCapabilitySpec >> default_provider: aValue [
	^ self at: #default_provider put: aValue. 

]

{ #category : #'as yet unclassified' }
CapabilitiesCapabilitySpec >> initialize [
	super initialize.
	 self package: ''. 
	 self type: ''. 
	 self content: ''. 
	 self default_provider: ''. 

]

{ #category : #'as yet unclassified' }
CapabilitiesCapabilitySpec >> package [
	^ self getAt: #package. 

]

{ #category : #'as yet unclassified' }
CapabilitiesCapabilitySpec >> package: aValue [
	^ self at: #package put: aValue. 

]

{ #category : #'as yet unclassified' }
CapabilitiesCapabilitySpec >> type [
	^ self getAt: #type. 

]

{ #category : #'as yet unclassified' }
CapabilitiesCapabilitySpec >> type: aValue [
	^ self at: #type put: aValue. 

]
