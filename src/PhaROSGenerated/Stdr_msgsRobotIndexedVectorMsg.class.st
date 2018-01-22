Class {
	#name : #'Stdr_msgsRobotIndexedVectorMsg',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsRobotIndexedVectorMsg >> initialize [
	super initialize.
	 self robots: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRobotIndexedVectorMsg >> robots [
	^ self getAt: #robots. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRobotIndexedVectorMsg >> robots: aValue [
	^ self at: #robots put: aValue. 

]
