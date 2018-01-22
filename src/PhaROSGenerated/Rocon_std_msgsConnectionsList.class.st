Class {
	#name : #'Rocon_std_msgsConnectionsList',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnectionsList >> connections [
	^ self getAt: #connections. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnectionsList >> connections: aValue [
	^ self at: #connections put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnectionsList >> initialize [
	super initialize.
	 self connections: OrderedCollection new . 

]
