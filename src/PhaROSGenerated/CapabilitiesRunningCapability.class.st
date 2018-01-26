Class {
	#name : #CapabilitiesRunningCapability,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
CapabilitiesRunningCapability class >> rosMd5Sum [ 
^'f97e2b23f907893008679ba2ff64fafc'
]

{ #category : #'as yet unclassified' }
CapabilitiesRunningCapability class >> rosTypeDefinition [ 
^' capabilities/Capability capability
 capabilities/Capability[] dependent_capabilities
 string started_by
 int32 pid
'
]

{ #category : #'as yet unclassified' }
CapabilitiesRunningCapability class >> rosTypeName [ 
^'capabilities/RunningCapability'
]

{ #category : #'as yet unclassified' }
CapabilitiesRunningCapability class >> typeCreationOrder [ 
^52
]

{ #category : #'as yet unclassified' }
CapabilitiesRunningCapability >> capability [
	^ self getAt: #capability. 

]

{ #category : #'as yet unclassified' }
CapabilitiesRunningCapability >> capability: aValue [
	^ self at: #capability put: aValue. 

]

{ #category : #'as yet unclassified' }
CapabilitiesRunningCapability >> dependent_capabilities [
	^ self getAt: #dependent_capabilities. 

]

{ #category : #'as yet unclassified' }
CapabilitiesRunningCapability >> dependent_capabilities: aValue [
	^ self at: #dependent_capabilities put: aValue. 

]

{ #category : #'as yet unclassified' }
CapabilitiesRunningCapability >> initialize [
	super initialize.
	 self capability: CapabilitiesCapability new. 
	 self dependent_capabilities: OrderedCollection new . 
	 self started_by: ''. 
	 self pid: 0. 

]

{ #category : #'as yet unclassified' }
CapabilitiesRunningCapability >> pid [
	^ self getAt: #pid. 

]

{ #category : #'as yet unclassified' }
CapabilitiesRunningCapability >> pid: aValue [
	^ self at: #pid put: aValue. 

]

{ #category : #'as yet unclassified' }
CapabilitiesRunningCapability >> started_by [
	^ self getAt: #started_by. 

]

{ #category : #'as yet unclassified' }
CapabilitiesRunningCapability >> started_by: aValue [
	^ self at: #started_by put: aValue. 

]
