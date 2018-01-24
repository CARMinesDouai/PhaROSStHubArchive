Class {
	#name : #'Nav_msgsGridCells',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Nav_msgsGridCells class >> rosMd5Sum [ 
^'b9e4f5df6d28e272ebde00a3994830f5'
]

{ #category : #'as yet unclassified' }
Nav_msgsGridCells class >> rosTypeDefinition [ 
^' std_msgs/Header header
 float32 cell_width
 float32 cell_height
 geometry_msgs/Point[] cells
'
]

{ #category : #'as yet unclassified' }
Nav_msgsGridCells class >> rosTypeName [ 
^'nav_msgs/GridCells'
]

{ #category : #'as yet unclassified' }
Nav_msgsGridCells >> cell_height [
	^ self getAt: #cell_height. 

]

{ #category : #'as yet unclassified' }
Nav_msgsGridCells >> cell_height: aValue [
	^ self at: #cell_height put: aValue. 

]

{ #category : #'as yet unclassified' }
Nav_msgsGridCells >> cell_width [
	^ self getAt: #cell_width. 

]

{ #category : #'as yet unclassified' }
Nav_msgsGridCells >> cell_width: aValue [
	^ self at: #cell_width put: aValue. 

]

{ #category : #'as yet unclassified' }
Nav_msgsGridCells >> cells [
	^ self getAt: #cells. 

]

{ #category : #'as yet unclassified' }
Nav_msgsGridCells >> cells: aValue [
	^ self at: #cells put: aValue. 

]

{ #category : #'as yet unclassified' }
Nav_msgsGridCells >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Nav_msgsGridCells >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Nav_msgsGridCells >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self cell_width: 0.0. 
	 self cell_height: 0.0. 
	 self cells: OrderedCollection new . 

]
