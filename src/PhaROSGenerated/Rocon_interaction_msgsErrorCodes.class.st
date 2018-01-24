Class {
	#name : #'Rocon_interaction_msgsErrorCodes',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsErrorCodes class >> already_pairing [
	^32

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsErrorCodes class >> different_rapp_is_running [
	^34

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsErrorCodes class >> interaction_quota_reached [
	^21

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsErrorCodes class >> interaction_unavailable [
	^20

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsErrorCodes class >> msg_already_pairing [
	^'"Already pairing, cannot start another pairing."'

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsErrorCodes class >> msg_different_rapp_is_running [
	^'"A different rapp to that required is already running."'

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsErrorCodes class >> msg_interaction_quota_reached [
	^'"More connections of this type not permitted."'

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsErrorCodes class >> msg_interaction_unavailable [
	^'"This interaction is not available for use."'

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsErrorCodes class >> msg_not_pairing [
	^'"This interaction manager is not managing paired interactions."'

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsErrorCodes class >> msg_pairing_unavailable [
	^'"The specified pairing does not exist."'

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsErrorCodes class >> msg_required_rapp_is_not_running [
	^'"No rapp is running and this pairing interaction requires one to be."'

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsErrorCodes class >> msg_start_pairing_failed [
	^'"Failed to start the pairing (rapp)."'

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsErrorCodes class >> msg_stop_pairing_failed [
	^'"Failed to stop a pairing (rapp)"'

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsErrorCodes class >> not_pairing [
	^35

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsErrorCodes class >> pairing_unavailable [
	^30

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsErrorCodes class >> required_rapp_is_not_running [
	^33

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsErrorCodes class >> rosMd5Sum [ 
^'07ff328fec8e7125b6dba36ae1479350'
]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsErrorCodes class >> rosTypeDefinition [ 
^' int8 SUCCESS=0
 int8 INTERACTION_UNAVAILABLE=20
 int8 INTERACTION_QUOTA_REACHED=21
 int8 PAIRING_UNAVAILABLE=30
 int8 START_PAIRING_FAILED=31
 int8 ALREADY_PAIRING=32
 int8 REQUIRED_RAPP_IS_NOT_RUNNING=33
 int8 DIFFERENT_RAPP_IS_RUNNING=34
 int8 NOT_PAIRING=35
 int8 STOP_PAIRING_FAILED=36
 string MSG_INTERACTION_UNAVAILABLE=''"This interaction is not available for use."''
 string MSG_PAIRING_UNAVAILABLE=''"The specified pairing does not exist."''
 string MSG_INTERACTION_QUOTA_REACHED=''"More connections of this type not permitted."''
 string MSG_REQUIRED_RAPP_IS_NOT_RUNNING=''"No rapp is running and this pairing interaction requires one to be."''
 string MSG_DIFFERENT_RAPP_IS_RUNNING=''"A different rapp to that required is already running."''
 string MSG_START_PAIRING_FAILED=''"Failed to start the pairing (rapp)."''
 string MSG_STOP_PAIRING_FAILED=''"Failed to stop a pairing (rapp)"''
 string MSG_ALREADY_PAIRING=''"Already pairing, cannot start another pairing."''
 string MSG_NOT_PAIRING=''"This interaction manager is not managing paired interactions."''
'
]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsErrorCodes class >> rosTypeName [ 
^'rocon_interaction_msgs/ErrorCodes'
]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsErrorCodes class >> start_pairing_failed [
	^31

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsErrorCodes class >> stop_pairing_failed [
	^36

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsErrorCodes class >> success [
	^0

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsErrorCodes >> initialize [
	super initialize.

]
