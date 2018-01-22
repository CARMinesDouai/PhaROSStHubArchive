Class {
	#name : #'Controller_manager_msgsControllerState',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Controller_manager_msgsControllerState >> claimed_resources [
	^ self getAt: #claimed_resources. 

]

{ #category : #'as yet unclassified' }
Controller_manager_msgsControllerState >> claimed_resources: aValue [
	^ self at: #claimed_resources put: aValue. 

]

{ #category : #'as yet unclassified' }
Controller_manager_msgsControllerState >> initialize [
	super initialize.
	 self name: ''. 
	 self state: ''. 
	 self type: ''. 
	 self claimed_resources: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Controller_manager_msgsControllerState >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Controller_manager_msgsControllerState >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Controller_manager_msgsControllerState >> state [
	^ self getAt: #state. 

]

{ #category : #'as yet unclassified' }
Controller_manager_msgsControllerState >> state: aValue [
	^ self at: #state put: aValue. 

]

{ #category : #'as yet unclassified' }
Controller_manager_msgsControllerState >> type [
	^ self getAt: #type. 

]

{ #category : #'as yet unclassified' }
Controller_manager_msgsControllerState >> type: aValue [
	^ self at: #type put: aValue. 

]
