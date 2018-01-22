Class {
	#name : #'Tf2_msgsTF2Error',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Tf2_msgsTF2Error class >> connectivity_error [
	^2

]

{ #category : #'as yet unclassified' }
Tf2_msgsTF2Error class >> extrapolation_error [
	^3

]

{ #category : #'as yet unclassified' }
Tf2_msgsTF2Error class >> invalid_argument_error [
	^4

]

{ #category : #'as yet unclassified' }
Tf2_msgsTF2Error class >> lookup_error [
	^1

]

{ #category : #'as yet unclassified' }
Tf2_msgsTF2Error class >> no_error [
	^0

]

{ #category : #'as yet unclassified' }
Tf2_msgsTF2Error class >> timeout_error [
	^5

]

{ #category : #'as yet unclassified' }
Tf2_msgsTF2Error class >> transform_error [
	^6

]

{ #category : #'as yet unclassified' }
Tf2_msgsTF2Error >> error [
	^ self getAt: #error. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsTF2Error >> error: aValue [
	^ self at: #error put: aValue. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsTF2Error >> error_string [
	^ self getAt: #error_string. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsTF2Error >> error_string: aValue [
	^ self at: #error_string put: aValue. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsTF2Error >> initialize [
	super initialize.
	 self error: 0. 
	 self error_string: ''. 

]
