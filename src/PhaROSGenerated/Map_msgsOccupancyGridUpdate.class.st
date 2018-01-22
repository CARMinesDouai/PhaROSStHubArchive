Class {
	#name : #'Map_msgsOccupancyGridUpdate',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Map_msgsOccupancyGridUpdate >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Map_msgsOccupancyGridUpdate >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Map_msgsOccupancyGridUpdate >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Map_msgsOccupancyGridUpdate >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Map_msgsOccupancyGridUpdate >> height [
	^ self getAt: #height. 

]

{ #category : #'as yet unclassified' }
Map_msgsOccupancyGridUpdate >> height: aValue [
	^ self at: #height put: aValue. 

]

{ #category : #'as yet unclassified' }
Map_msgsOccupancyGridUpdate >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self x: 0. 
	 self y: 0. 
	 self width: 0. 
	 self height: 0. 
	 self data: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Map_msgsOccupancyGridUpdate >> width [
	^ self getAt: #width. 

]

{ #category : #'as yet unclassified' }
Map_msgsOccupancyGridUpdate >> width: aValue [
	^ self at: #width put: aValue. 

]

{ #category : #'as yet unclassified' }
Map_msgsOccupancyGridUpdate >> x [
	^ self getAt: #x. 

]

{ #category : #'as yet unclassified' }
Map_msgsOccupancyGridUpdate >> x: aValue [
	^ self at: #x put: aValue. 

]

{ #category : #'as yet unclassified' }
Map_msgsOccupancyGridUpdate >> y [
	^ self getAt: #y. 

]

{ #category : #'as yet unclassified' }
Map_msgsOccupancyGridUpdate >> y: aValue [
	^ self at: #y put: aValue. 

]
