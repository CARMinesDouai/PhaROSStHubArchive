Class {
	#name : #'Controller_manager_msgsControllersStatistics',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Controller_manager_msgsControllersStatistics >> controller [
	^ self getAt: #controller. 

]

{ #category : #'as yet unclassified' }
Controller_manager_msgsControllersStatistics >> controller: aValue [
	^ self at: #controller put: aValue. 

]

{ #category : #'as yet unclassified' }
Controller_manager_msgsControllersStatistics >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Controller_manager_msgsControllersStatistics >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Controller_manager_msgsControllersStatistics >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self controller: OrderedCollection new . 

]
