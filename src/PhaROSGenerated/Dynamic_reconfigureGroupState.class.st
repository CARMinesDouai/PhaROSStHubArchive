Class {
	#name : #'Dynamic_reconfigureGroupState',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Dynamic_reconfigureGroupState class >> rosMd5Sum [ 
^'a2d87f51dc22930325041a2f8b1571f8'
]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureGroupState class >> rosTypeDefinition [ 
^' string name
 bool state
 int32 id
 int32 parent
'
]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureGroupState class >> rosTypeName [ 
^'dynamic_reconfigure/GroupState'
]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureGroupState >> id [
	^ self getAt: #id. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureGroupState >> id: aValue [
	^ self at: #id put: aValue. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureGroupState >> initialize [
	super initialize.
	 self name: ''. 
	 self state: false. 
	 self id: 0. 
	 self parent: 0. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureGroupState >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureGroupState >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureGroupState >> parent [
	^ self getAt: #parent. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureGroupState >> parent: aValue [
	^ self at: #parent put: aValue. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureGroupState >> state [
	^ self getAt: #state. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureGroupState >> state: aValue [
	^ self at: #state put: aValue. 

]
