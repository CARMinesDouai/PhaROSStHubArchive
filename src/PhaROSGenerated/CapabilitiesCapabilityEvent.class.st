Class {
	#name : #CapabilitiesCapabilityEvent,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
CapabilitiesCapabilityEvent class >> launched [
	^'"launched"'

]

{ #category : #'as yet unclassified' }
CapabilitiesCapabilityEvent class >> rosMd5Sum [ 
^'5a0d82ee1a8e7a5d0b058f0b20305b18'
]

{ #category : #'as yet unclassified' }
CapabilitiesCapabilityEvent class >> rosTypeDefinition [ 
^' string LAUNCHED=''"launched"''
 string STOPPED=''"stopped"''
 string TERMINATED=''"terminated"''
 string SERVER_READY=''"server_ready"''
 std_msgs/Header header
 string capability
 string provider
 string type
 int32 pid
'
]

{ #category : #'as yet unclassified' }
CapabilitiesCapabilityEvent class >> rosTypeName [ 
^'capabilities/CapabilityEvent'
]

{ #category : #'as yet unclassified' }
CapabilitiesCapabilityEvent class >> server_ready [
	^'"server_ready"'

]

{ #category : #'as yet unclassified' }
CapabilitiesCapabilityEvent class >> stopped [
	^'"stopped"'

]

{ #category : #'as yet unclassified' }
CapabilitiesCapabilityEvent class >> terminated [
	^'"terminated"'

]

{ #category : #'as yet unclassified' }
CapabilitiesCapabilityEvent class >> typeCreationOrder [ 
^49
]

{ #category : #'as yet unclassified' }
CapabilitiesCapabilityEvent >> capability [
	^ self getAt: #capability. 

]

{ #category : #'as yet unclassified' }
CapabilitiesCapabilityEvent >> capability: aValue [
	^ self at: #capability put: aValue. 

]

{ #category : #'as yet unclassified' }
CapabilitiesCapabilityEvent >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
CapabilitiesCapabilityEvent >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
CapabilitiesCapabilityEvent >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self capability: ''. 
	 self provider: ''. 
	 self type: ''. 
	 self pid: 0. 

]

{ #category : #'as yet unclassified' }
CapabilitiesCapabilityEvent >> pid [
	^ self getAt: #pid. 

]

{ #category : #'as yet unclassified' }
CapabilitiesCapabilityEvent >> pid: aValue [
	^ self at: #pid put: aValue. 

]

{ #category : #'as yet unclassified' }
CapabilitiesCapabilityEvent >> provider [
	^ self getAt: #provider. 

]

{ #category : #'as yet unclassified' }
CapabilitiesCapabilityEvent >> provider: aValue [
	^ self at: #provider put: aValue. 

]

{ #category : #'as yet unclassified' }
CapabilitiesCapabilityEvent >> type [
	^ self getAt: #type. 

]

{ #category : #'as yet unclassified' }
CapabilitiesCapabilityEvent >> type: aValue [
	^ self at: #type put: aValue. 

]
