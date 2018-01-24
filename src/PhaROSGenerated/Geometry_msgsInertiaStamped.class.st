Class {
	#name : #'Geometry_msgsInertiaStamped',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsInertiaStamped class >> rosMd5Sum [ 
^'ddee48caeab5a966c5e8d166654a9ac7'
]

{ #category : #'as yet unclassified' }
Geometry_msgsInertiaStamped class >> rosTypeDefinition [ 
^' std_msgs/Header header
 geometry_msgs/Inertia inertia
'
]

{ #category : #'as yet unclassified' }
Geometry_msgsInertiaStamped class >> rosTypeName [ 
^'geometry_msgs/InertiaStamped'
]

{ #category : #'as yet unclassified' }
Geometry_msgsInertiaStamped >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsInertiaStamped >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsInertiaStamped >> inertia [
	^ self getAt: #inertia. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsInertiaStamped >> inertia: aValue [
	^ self at: #inertia put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsInertiaStamped >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self inertia: Geometry_msgsInertia new. 

]
