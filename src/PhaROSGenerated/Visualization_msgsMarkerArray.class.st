Class {
	#name : #'Visualization_msgsMarkerArray',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Visualization_msgsMarkerArray >> initialize [
	super initialize.
	 self markers: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarkerArray >> markers [
	^ self getAt: #markers. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarkerArray >> markers: aValue [
	^ self at: #markers put: aValue. 

]
