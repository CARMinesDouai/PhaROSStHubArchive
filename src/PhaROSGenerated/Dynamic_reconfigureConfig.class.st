Class {
	#name : #'Dynamic_reconfigureConfig',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Dynamic_reconfigureConfig class >> rosMd5Sum [ 
^'958f16a05573709014982821e6822580'
]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureConfig class >> rosTypeDefinition [ 
^' dynamic_reconfigure/BoolParameter[] bools
 dynamic_reconfigure/IntParameter[] ints
 dynamic_reconfigure/StrParameter[] strs
 dynamic_reconfigure/DoubleParameter[] doubles
 dynamic_reconfigure/GroupState[] groups
'
]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureConfig class >> rosTypeName [ 
^'dynamic_reconfigure/Config'
]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureConfig >> bools [
	^ self getAt: #bools. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureConfig >> bools: aValue [
	^ self at: #bools put: aValue. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureConfig >> doubles [
	^ self getAt: #doubles. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureConfig >> doubles: aValue [
	^ self at: #doubles put: aValue. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureConfig >> groups [
	^ self getAt: #groups. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureConfig >> groups: aValue [
	^ self at: #groups put: aValue. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureConfig >> initialize [
	super initialize.
	 self bools: OrderedCollection new . 
	 self ints: OrderedCollection new . 
	 self strs: OrderedCollection new . 
	 self doubles: OrderedCollection new . 
	 self groups: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureConfig >> ints [
	^ self getAt: #ints. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureConfig >> ints: aValue [
	^ self at: #ints put: aValue. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureConfig >> strs [
	^ self getAt: #strs. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureConfig >> strs: aValue [
	^ self at: #strs put: aValue. 

]
