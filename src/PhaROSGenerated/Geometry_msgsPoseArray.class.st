Class {
	#name : #'Geometry_msgsPoseArray',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsPoseArray >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseArray >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseArray >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self poses: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseArray >> poses [
	^ self getAt: #poses. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseArray >> poses: aValue [
	^ self at: #poses put: aValue. 

]
