Class {
	#name : #'Nav_msgsOccupancyGrid',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Nav_msgsOccupancyGrid >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Nav_msgsOccupancyGrid >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Nav_msgsOccupancyGrid >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Nav_msgsOccupancyGrid >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Nav_msgsOccupancyGrid >> info [
	^ self getAt: #info. 

]

{ #category : #'as yet unclassified' }
Nav_msgsOccupancyGrid >> info: aValue [
	^ self at: #info put: aValue. 

]

{ #category : #'as yet unclassified' }
Nav_msgsOccupancyGrid >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self info: Nav_msgsMapMetaData new. 
	 self data: OrderedCollection new . 

]
