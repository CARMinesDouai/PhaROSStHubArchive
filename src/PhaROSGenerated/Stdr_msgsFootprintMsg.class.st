Class {
	#name : #'Stdr_msgsFootprintMsg',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsFootprintMsg >> initialize [
	super initialize.
	 self points: OrderedCollection new . 
	 self radius: 0.0. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsFootprintMsg >> points [
	^ self getAt: #points. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsFootprintMsg >> points: aValue [
	^ self at: #points put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsFootprintMsg >> radius [
	^ self getAt: #radius. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsFootprintMsg >> radius: aValue [
	^ self at: #radius put: aValue. 

]
