Class {
	#name : #'Gazebo_msgsWorldState',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Gazebo_msgsWorldState >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsWorldState >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsWorldState >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self name: OrderedCollection new . 
	 self pose: OrderedCollection new . 
	 self twist: OrderedCollection new . 
	 self wrench: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsWorldState >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsWorldState >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsWorldState >> pose [
	^ self getAt: #pose. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsWorldState >> pose: aValue [
	^ self at: #pose put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsWorldState >> twist [
	^ self getAt: #twist. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsWorldState >> twist: aValue [
	^ self at: #twist put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsWorldState >> wrench [
	^ self getAt: #wrench. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsWorldState >> wrench: aValue [
	^ self at: #wrench put: aValue. 

]
