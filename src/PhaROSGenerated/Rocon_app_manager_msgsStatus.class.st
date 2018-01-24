Class {
	#name : #'Rocon_app_manager_msgsStatus',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsStatus class >> rapp_running [
	^'running'

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsStatus class >> rapp_stopped [
	^'stopped'

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsStatus class >> rosMd5Sum [ 
^'845a2087bbeabf6770c4fda9fcc80442'
]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsStatus class >> rosTypeDefinition [ 
^' string RAPP_STOPPED=''stopped''
 string RAPP_RUNNING=''running''
 string application_namespace
 string remote_controller
 string rapp_status
 rocon_app_manager_msgs/Rapp rapp
 rocon_app_manager_msgs/PublishedInterface[] published_interfaces
 rocon_std_msgs/KeyValue[] published_parameters
'
]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsStatus class >> rosTypeName [ 
^'rocon_app_manager_msgs/Status'
]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsStatus >> application_namespace [
	^ self getAt: #application_namespace. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsStatus >> application_namespace: aValue [
	^ self at: #application_namespace put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsStatus >> initialize [
	super initialize.
	 self application_namespace: ''. 
	 self remote_controller: ''. 
	 self rapp_status: ''. 
	 self rapp: Rocon_app_manager_msgsRapp new. 
	 self published_interfaces: OrderedCollection new . 
	 self published_parameters: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsStatus >> published_interfaces [
	^ self getAt: #published_interfaces. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsStatus >> published_interfaces: aValue [
	^ self at: #published_interfaces put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsStatus >> published_parameters [
	^ self getAt: #published_parameters. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsStatus >> published_parameters: aValue [
	^ self at: #published_parameters put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsStatus >> rapp [
	^ self getAt: #rapp. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsStatus >> rapp: aValue [
	^ self at: #rapp put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsStatus >> rapp_status [
	^ self getAt: #rapp_status. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsStatus >> rapp_status: aValue [
	^ self at: #rapp_status put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsStatus >> remote_controller [
	^ self getAt: #remote_controller. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsStatus >> remote_controller: aValue [
	^ self at: #remote_controller put: aValue. 

]
