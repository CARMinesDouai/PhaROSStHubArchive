Class {
	#name : #'Rocon_app_manager_msgsIncompatibleRappList',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsIncompatibleRappList class >> rosTypeDefinition [ 
^' string[] blacklisted_rapps
 string[] non_whitelisted_rapps
 string[] platform_incompatible_rapps
 string[] capabilities_incompatible_rapps
'
]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsIncompatibleRappList class >> rosTypeName [ 
^'rocon_app_manager_msgs/IncompatibleRappList'
]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsIncompatibleRappList >> blacklisted_rapps [
	^ self getAt: #blacklisted_rapps. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsIncompatibleRappList >> blacklisted_rapps: aValue [
	^ self at: #blacklisted_rapps put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsIncompatibleRappList >> capabilities_incompatible_rapps [
	^ self getAt: #capabilities_incompatible_rapps. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsIncompatibleRappList >> capabilities_incompatible_rapps: aValue [
	^ self at: #capabilities_incompatible_rapps put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsIncompatibleRappList >> initialize [
	super initialize.
	 self blacklisted_rapps: OrderedCollection new . 
	 self non_whitelisted_rapps: OrderedCollection new . 
	 self platform_incompatible_rapps: OrderedCollection new . 
	 self capabilities_incompatible_rapps: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsIncompatibleRappList >> non_whitelisted_rapps [
	^ self getAt: #non_whitelisted_rapps. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsIncompatibleRappList >> non_whitelisted_rapps: aValue [
	^ self at: #non_whitelisted_rapps put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsIncompatibleRappList >> platform_incompatible_rapps [
	^ self getAt: #platform_incompatible_rapps. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsIncompatibleRappList >> platform_incompatible_rapps: aValue [
	^ self at: #platform_incompatible_rapps put: aValue. 

]
