Class {
	#name : #'Visualization_msgsInteractiveMarkerPose',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerPose >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerPose >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerPose >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self pose: Geometry_msgsPose new. 
	 self name: ''. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerPose >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerPose >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerPose >> pose [
	^ self getAt: #pose. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerPose >> pose: aValue [
	^ self at: #pose put: aValue. 

]
