Class {
	#name : #'Rocon_std_msgsConnectionsDiff',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnectionsDiff >> added [
	^ self getAt: #added. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnectionsDiff >> added: aValue [
	^ self at: #added put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnectionsDiff >> initialize [
	super initialize.
	 self added: OrderedCollection new . 
	 self lost: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnectionsDiff >> lost [
	^ self getAt: #lost. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnectionsDiff >> lost: aValue [
	^ self at: #lost put: aValue. 

]
