Class {
	#name : #BondStatus,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
BondStatus class >> rosMd5Sum [ 
^'eacc84bf5d65b6777d4c50f463dfb9c8'
]

{ #category : #'as yet unclassified' }
BondStatus class >> rosTypeDefinition [ 
^' std_msgs/Header header
 string id
 string instance_id
 bool active
 float32 heartbeat_timeout
 float32 heartbeat_period
'
]

{ #category : #'as yet unclassified' }
BondStatus class >> rosTypeName [ 
^'bond/Status'
]

{ #category : #'as yet unclassified' }
BondStatus >> active [
	^ self getAt: #active. 

]

{ #category : #'as yet unclassified' }
BondStatus >> active: aValue [
	^ self at: #active put: aValue. 

]

{ #category : #'as yet unclassified' }
BondStatus >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
BondStatus >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
BondStatus >> heartbeat_period [
	^ self getAt: #heartbeat_period. 

]

{ #category : #'as yet unclassified' }
BondStatus >> heartbeat_period: aValue [
	^ self at: #heartbeat_period put: aValue. 

]

{ #category : #'as yet unclassified' }
BondStatus >> heartbeat_timeout [
	^ self getAt: #heartbeat_timeout. 

]

{ #category : #'as yet unclassified' }
BondStatus >> heartbeat_timeout: aValue [
	^ self at: #heartbeat_timeout put: aValue. 

]

{ #category : #'as yet unclassified' }
BondStatus >> id [
	^ self getAt: #id. 

]

{ #category : #'as yet unclassified' }
BondStatus >> id: aValue [
	^ self at: #id put: aValue. 

]

{ #category : #'as yet unclassified' }
BondStatus >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self id: ''. 
	 self instance_id: ''. 
	 self active: false. 
	 self heartbeat_timeout: 0.0. 
	 self heartbeat_period: 0.0. 

]

{ #category : #'as yet unclassified' }
BondStatus >> instance_id [
	^ self getAt: #instance_id. 

]

{ #category : #'as yet unclassified' }
BondStatus >> instance_id: aValue [
	^ self at: #instance_id put: aValue. 

]
