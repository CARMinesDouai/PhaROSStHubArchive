Class {
	#name : #'Geometry_msgsTransformStamped',
	#superclass : #PhaROSValue,
	#category : #'PureROS-PhaROSTypes'
}

{ #category : #'as yet unclassified' }
Geometry_msgsTransformStamped >> child_frame_id [
	^ self getAt: #child_frame_id. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTransformStamped >> child_frame_id: aValue [
	^ self at: #child_frame_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTransformStamped >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTransformStamped >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTransformStamped >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self child_frame_id: ''. 
	 self transform: Geometry_msgsTransform new. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTransformStamped >> transform [
	^ self getAt: #transform. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTransformStamped >> transform: aValue [
	^ self at: #transform put: aValue. 

]
