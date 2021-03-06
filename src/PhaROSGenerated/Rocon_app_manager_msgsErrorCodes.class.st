Class {
	#name : #'Rocon_app_manager_msgsErrorCodes',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsErrorCodes class >> already_remote_controlled [
	^32

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsErrorCodes class >> client_connection_disrupted [
	^36

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsErrorCodes class >> inviting_controller_blacklisted [
	^35

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsErrorCodes class >> inviting_controller_not_whitelisted [
	^34

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsErrorCodes class >> local_invitations_only [
	^30

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsErrorCodes class >> multi_rapp_not_supported [
	^10

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsErrorCodes class >> no_local_gateway [
	^31

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsErrorCodes class >> not_current_remote_controller [
	^33

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsErrorCodes class >> rapp_is_not_available [
	^21

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsErrorCodes class >> rapp_is_not_running [
	^20

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsErrorCodes class >> rosMd5Sum [ 
^'cec38b743e8d5698477f7be4d8bfebb8'
]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsErrorCodes class >> rosTypeDefinition [ 
^' int8 SUCCESS=0
 int8 UNKNOWN=1
 int8 MULTI_RAPP_NOT_SUPPORTED=10
 int8 RAPP_IS_NOT_RUNNING=20
 int8 RAPP_IS_NOT_AVAILABLE=21
 int8 LOCAL_INVITATIONS_ONLY=30
 int8 NO_LOCAL_GATEWAY=31
 int8 ALREADY_REMOTE_CONTROLLED=32
 int8 NOT_CURRENT_REMOTE_CONTROLLER=33
 int8 INVITING_CONTROLLER_NOT_WHITELISTED=34
 int8 INVITING_CONTROLLER_BLACKLISTED=35
 int8 CLIENT_CONNECTION_DISRUPTED=36
'
]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsErrorCodes class >> rosTypeName [ 
^'rocon_app_manager_msgs/ErrorCodes'
]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsErrorCodes class >> success [
	^0

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsErrorCodes class >> typeCreationOrder [ 
^214
]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsErrorCodes class >> unknown [
	^1

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsErrorCodes >> initialize [
	super initialize.

]
