Class {
	#name : #TurtlesimColor,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
TurtlesimColor >> b [
	^ self getAt: #b. 

]

{ #category : #'as yet unclassified' }
TurtlesimColor >> b: aValue [
	^ self at: #b put: aValue. 

]

{ #category : #'as yet unclassified' }
TurtlesimColor >> g [
	^ self getAt: #g. 

]

{ #category : #'as yet unclassified' }
TurtlesimColor >> g: aValue [
	^ self at: #g put: aValue. 

]

{ #category : #'as yet unclassified' }
TurtlesimColor >> initialize [
	super initialize.
	 self r: 0. 
	 self g: 0. 
	 self b: 0. 

]

{ #category : #'as yet unclassified' }
TurtlesimColor >> r [
	^ self getAt: #r. 

]

{ #category : #'as yet unclassified' }
TurtlesimColor >> r: aValue [
	^ self at: #r put: aValue. 

]
