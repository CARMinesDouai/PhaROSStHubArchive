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
