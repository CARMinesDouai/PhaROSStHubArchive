Class {
	#name : #'Rosgraph_msgsClock',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rosgraph_msgsClock >> clock [
	^ self getAt: #clock. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsClock >> clock: aValue [
	^ self at: #clock put: aValue. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsClock >> initialize [
	super initialize.
	 self clock:  PhaROSTimestamp now. 

]
