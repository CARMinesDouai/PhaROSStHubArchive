Class {
	#name : #'Rocon_app_manager_msgsPublishedInterface',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsPublishedInterface >> initialize [
	super initialize.
	 self interface: Rocon_app_manager_msgsPublicInterface new. 
	 self name: ''. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsPublishedInterface >> interface [
	^ self getAt: #interface. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsPublishedInterface >> interface: aValue [
	^ self at: #interface put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsPublishedInterface >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsPublishedInterface >> name: aValue [
	^ self at: #name put: aValue. 

]
