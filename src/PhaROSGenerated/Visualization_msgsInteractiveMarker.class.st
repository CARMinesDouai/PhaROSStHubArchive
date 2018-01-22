Class {
	#name : #'Visualization_msgsInteractiveMarker',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarker >> controls [
	^ self getAt: #controls. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarker >> controls: aValue [
	^ self at: #controls put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarker >> description [
	^ self getAt: #description. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarker >> description: aValue [
	^ self at: #description put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarker >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarker >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarker >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self pose: Geometry_msgsPose new. 
	 self name: ''. 
	 self description: ''. 
	 self scale: 0.0. 
	 self menu_entries: OrderedCollection new . 
	 self controls: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarker >> menu_entries [
	^ self getAt: #menu_entries. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarker >> menu_entries: aValue [
	^ self at: #menu_entries put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarker >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarker >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarker >> pose [
	^ self getAt: #pose. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarker >> pose: aValue [
	^ self at: #pose put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarker >> scale [
	^ self getAt: #scale. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarker >> scale: aValue [
	^ self at: #scale put: aValue. 

]
