Class {
	#name : #'Tf2_msgsLookupTransformActionResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionResult >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionResult >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionResult >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self result: Tf2_msgsLookupTransformResult new. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionResult >> result [
	^ self getAt: #result. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionResult >> result: aValue [
	^ self at: #result put: aValue. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionResult >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionResult >> status: aValue [
	^ self at: #status put: aValue. 

]
