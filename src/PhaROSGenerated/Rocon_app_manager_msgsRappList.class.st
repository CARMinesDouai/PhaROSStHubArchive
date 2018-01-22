Class {
	#name : #'Rocon_app_manager_msgsRappList',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsRappList >> available_rapps [
	^ self getAt: #available_rapps. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsRappList >> available_rapps: aValue [
	^ self at: #available_rapps put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsRappList >> initialize [
	super initialize.
	 self available_rapps: OrderedCollection new . 

]
