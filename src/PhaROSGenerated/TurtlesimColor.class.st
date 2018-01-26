Class {
	#name : #TurtlesimColor,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
TurtlesimColor class >> rosMd5Sum [ 
^'353891e354491c51aabe32df673fb446'
]

{ #category : #'as yet unclassified' }
TurtlesimColor class >> rosTypeDefinition [ 
^' int8 r
 int8 g
 int8 b
'
]

{ #category : #'as yet unclassified' }
TurtlesimColor class >> rosTypeName [ 
^'turtlesim/Color'
]

{ #category : #'as yet unclassified' }
TurtlesimColor class >> typeCreationOrder [ 
^406
]

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
