Class {
	#name : #ActionlibTestRequestGoal,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
ActionlibTestRequestGoal class >> rosMd5Sum [ 
^'db5d00ba98302d6c6dd3737e9a03ceea'
]

{ #category : #'as yet unclassified' }
ActionlibTestRequestGoal class >> rosTypeDefinition [ 
^' int32 TERMINATE_SUCCESS=0
 int32 TERMINATE_ABORTED=1
 int32 TERMINATE_REJECTED=2
 int32 TERMINATE_LOSE=3
 int32 TERMINATE_DROP=4
 int32 TERMINATE_EXCEPTION=5
 int32 terminate_status
 bool ignore_cancel
 string result_text
 int32 the_result
 bool is_simple_client
 duration delay_accept
 duration delay_terminate
 duration pause_status
'
]

{ #category : #'as yet unclassified' }
ActionlibTestRequestGoal class >> rosTypeName [ 
^'actionlib/TestRequestGoal'
]

{ #category : #'as yet unclassified' }
ActionlibTestRequestGoal class >> terminate_aborted [
	^1

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestGoal class >> terminate_drop [
	^4

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestGoal class >> terminate_exception [
	^5

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestGoal class >> terminate_lose [
	^3

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestGoal class >> terminate_rejected [
	^2

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestGoal class >> terminate_success [
	^0

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestGoal >> delay_accept [
	^ self getAt: #delay_accept. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestGoal >> delay_accept: aValue [
	^ self at: #delay_accept put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestGoal >> delay_terminate [
	^ self getAt: #delay_terminate. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestGoal >> delay_terminate: aValue [
	^ self at: #delay_terminate put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestGoal >> ignore_cancel [
	^ self getAt: #ignore_cancel. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestGoal >> ignore_cancel: aValue [
	^ self at: #ignore_cancel put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestGoal >> initialize [
	super initialize.
	 self terminate_status: 0. 
	 self ignore_cancel: false. 
	 self result_text: ''. 
	 self the_result: 0. 
	 self is_simple_client: false. 
	 self delay_accept:  Duration seconds: 0. 
	 self delay_terminate:  Duration seconds: 0. 
	 self pause_status:  Duration seconds: 0. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestGoal >> is_simple_client [
	^ self getAt: #is_simple_client. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestGoal >> is_simple_client: aValue [
	^ self at: #is_simple_client put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestGoal >> pause_status [
	^ self getAt: #pause_status. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestGoal >> pause_status: aValue [
	^ self at: #pause_status put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestGoal >> result_text [
	^ self getAt: #result_text. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestGoal >> result_text: aValue [
	^ self at: #result_text put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestGoal >> terminate_status [
	^ self getAt: #terminate_status. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestGoal >> terminate_status: aValue [
	^ self at: #terminate_status put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestGoal >> the_result [
	^ self getAt: #the_result. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestGoal >> the_result: aValue [
	^ self at: #the_result put: aValue. 

]
