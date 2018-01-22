Class {
	#name : #'Dynamic_reconfigureConfigDescription',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Dynamic_reconfigureConfigDescription >> dflt [
	^ self getAt: #dflt. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureConfigDescription >> dflt: aValue [
	^ self at: #dflt put: aValue. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureConfigDescription >> groups [
	^ self getAt: #groups. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureConfigDescription >> groups: aValue [
	^ self at: #groups put: aValue. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureConfigDescription >> initialize [
	super initialize.
	 self groups: OrderedCollection new . 
	 self max: Dynamic_reconfigureConfig new. 
	 self min: Dynamic_reconfigureConfig new. 
	 self dflt: Dynamic_reconfigureConfig new. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureConfigDescription >> max [
	^ self getAt: #max. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureConfigDescription >> max: aValue [
	^ self at: #max put: aValue. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureConfigDescription >> min [
	^ self getAt: #min. 

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureConfigDescription >> min: aValue [
	^ self at: #min put: aValue. 

]
