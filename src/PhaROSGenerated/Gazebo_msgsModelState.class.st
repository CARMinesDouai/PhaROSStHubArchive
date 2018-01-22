Class {
	#name : #'Gazebo_msgsModelState',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Gazebo_msgsModelState >> initialize [
	super initialize.
	 self model_name: ''. 
	 self pose: Geometry_msgsPose new. 
	 self twist: Geometry_msgsTwist new. 
	 self reference_frame: ''. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsModelState >> model_name [
	^ self getAt: #model_name. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsModelState >> model_name: aValue [
	^ self at: #model_name put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsModelState >> pose [
	^ self getAt: #pose. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsModelState >> pose: aValue [
	^ self at: #pose put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsModelState >> reference_frame [
	^ self getAt: #reference_frame. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsModelState >> reference_frame: aValue [
	^ self at: #reference_frame put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsModelState >> twist [
	^ self getAt: #twist. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsModelState >> twist: aValue [
	^ self at: #twist put: aValue. 

]
