Class {
	#name : #'Dynamic_reconfigureStrParameter',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Dynamic_reconfigureStrParameter >> initialize [
	super initialize.
	 self name: ''. 
	 self value: ''. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureStrParameter >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureStrParameter >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureStrParameter >> value [
	^ self getAt: #value. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureStrParameter >> value: aValue [
	^ self at: #value put: aValue. 

]
