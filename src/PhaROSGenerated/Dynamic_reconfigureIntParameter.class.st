Class {
	#name : #'Dynamic_reconfigureIntParameter',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Dynamic_reconfigureIntParameter >> initialize [
	super initialize.
	 self name: ''. 
	 self value: 0. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureIntParameter >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureIntParameter >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureIntParameter >> value [
	^ self getAt: #value. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureIntParameter >> value: aValue [
	^ self at: #value put: aValue. 

]
