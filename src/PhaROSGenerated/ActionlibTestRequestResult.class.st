Class {
	#name : #ActionlibTestRequestResult,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
ActionlibTestRequestResult >> initialize [
	super initialize.
	 self the_result: 0. 
	 self is_simple_server: false. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestResult >> is_simple_server [
	^ self getAt: #is_simple_server. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestResult >> is_simple_server: aValue [
	^ self at: #is_simple_server put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestResult >> the_result [
	^ self getAt: #the_result. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestResult >> the_result: aValue [
	^ self at: #the_result put: aValue. 

]
