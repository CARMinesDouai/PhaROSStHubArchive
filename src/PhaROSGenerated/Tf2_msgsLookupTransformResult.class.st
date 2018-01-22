Class {
	#name : #'Tf2_msgsLookupTransformResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformResult >> error [
	^ self getAt: #error. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformResult >> error: aValue [
	^ self at: #error put: aValue. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformResult >> initialize [
	super initialize.
	 self transform: Geometry_msgsTransformStamped new. 
	 self error: Tf2_msgsTF2Error new. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformResult >> transform [
	^ self getAt: #transform. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformResult >> transform: aValue [
	^ self at: #transform put: aValue. 

]
