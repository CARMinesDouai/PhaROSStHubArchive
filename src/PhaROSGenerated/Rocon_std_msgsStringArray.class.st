Class {
	#name : #'Rocon_std_msgsStringArray',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringArray >> initialize [
	super initialize.
	 self strings: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringArray >> strings [
	^ self getAt: #strings. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringArray >> strings: aValue [
	^ self at: #strings put: aValue. 

]
