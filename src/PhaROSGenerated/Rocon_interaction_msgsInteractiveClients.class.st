Class {
	#name : #'Rocon_interaction_msgsInteractiveClients',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteractiveClients >> idle_clients [
	^ self getAt: #idle_clients. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteractiveClients >> idle_clients: aValue [
	^ self at: #idle_clients put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteractiveClients >> initialize [
	super initialize.
	 self idle_clients: OrderedCollection new . 
	 self running_clients: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteractiveClients >> running_clients [
	^ self getAt: #running_clients. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteractiveClients >> running_clients: aValue [
	^ self at: #running_clients put: aValue. 

]
