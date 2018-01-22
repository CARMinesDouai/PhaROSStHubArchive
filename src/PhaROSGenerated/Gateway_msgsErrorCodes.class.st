Class {
	#name : #'Gateway_msgsErrorCodes',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Gateway_msgsErrorCodes class >> advertisement_exists [
	^31

]

{ #category : #'as yet unclassified' }
Gateway_msgsErrorCodes class >> advertisement_not_found [
	^32

]

{ #category : #'as yet unclassified' }
Gateway_msgsErrorCodes class >> flip_pattern_alredy_exists [
	^23

]

{ #category : #'as yet unclassified' }
Gateway_msgsErrorCodes class >> flip_remote_gateway_firewalling [
	^24

]

{ #category : #'as yet unclassified' }
Gateway_msgsErrorCodes class >> flip_rule_already_exists [
	^22

]

{ #category : #'as yet unclassified' }
Gateway_msgsErrorCodes class >> hub_connection_already_exists [
	^11

]

{ #category : #'as yet unclassified' }
Gateway_msgsErrorCodes class >> hub_connection_blacklisted [
	^13

]

{ #category : #'as yet unclassified' }
Gateway_msgsErrorCodes class >> hub_connection_failed [
	^14

]

{ #category : #'as yet unclassified' }
Gateway_msgsErrorCodes class >> hub_connection_lost [
	^17

]

{ #category : #'as yet unclassified' }
Gateway_msgsErrorCodes class >> hub_connection_not_in_nonempty_whitelist [
	^15

]

{ #category : #'as yet unclassified' }
Gateway_msgsErrorCodes class >> hub_connection_unresolvable [
	^12

]

{ #category : #'as yet unclassified' }
Gateway_msgsErrorCodes class >> hub_name_not_found [
	^16

]

{ #category : #'as yet unclassified' }
Gateway_msgsErrorCodes class >> hub_unknown_error [
	^19

]

{ #category : #'as yet unclassified' }
Gateway_msgsErrorCodes class >> no_hub_connection [
	^1

]

{ #category : #'as yet unclassified' }
Gateway_msgsErrorCodes class >> pull_rule_already_exists [
	^41

]

{ #category : #'as yet unclassified' }
Gateway_msgsErrorCodes class >> remote_gateway_not_visible [
	^51

]

{ #category : #'as yet unclassified' }
Gateway_msgsErrorCodes class >> remote_gateway_self_is_not [
	^52

]

{ #category : #'as yet unclassified' }
Gateway_msgsErrorCodes class >> remote_gateway_target_has_multiple_matches [
	^53

]

{ #category : #'as yet unclassified' }
Gateway_msgsErrorCodes class >> rosTypeDefinition [ 
^' int8 SUCCESS=0
 int8 NO_HUB_CONNECTION=1
 int8 HUB_CONNECTION_ALREADY_EXISTS=11
 int8 HUB_CONNECTION_UNRESOLVABLE=12
 int8 HUB_CONNECTION_BLACKLISTED=13
 int8 HUB_CONNECTION_FAILED=14
 int8 HUB_CONNECTION_NOT_IN_NONEMPTY_WHITELIST=15
 int8 HUB_NAME_NOT_FOUND=16
 int8 HUB_CONNECTION_LOST=17
 int8 HUB_UNKNOWN_ERROR=19
 int8 FLIP_RULE_ALREADY_EXISTS=22
 int8 FLIP_PATTERN_ALREDY_EXISTS=23
 int8 FLIP_REMOTE_GATEWAY_FIREWALLING=24
 int8 ADVERTISEMENT_EXISTS=31
 int8 ADVERTISEMENT_NOT_FOUND=32
 int8 UNKNOWN_ADVERTISEMENT_ERROR=39
 int8 PULL_RULE_ALREADY_EXISTS=41
 int8 REMOTE_GATEWAY_NOT_VISIBLE=51
 int8 REMOTE_GATEWAY_SELF_IS_NOT=52
 int8 REMOTE_GATEWAY_TARGET_HAS_MULTIPLE_MATCHES=53
'
]

{ #category : #'as yet unclassified' }
Gateway_msgsErrorCodes class >> rosTypeName [ 
^'gateway_msgs/ErrorCodes'
]

{ #category : #'as yet unclassified' }
Gateway_msgsErrorCodes class >> success [
	^0

]

{ #category : #'as yet unclassified' }
Gateway_msgsErrorCodes class >> unknown_advertisement_error [
	^39

]

{ #category : #'as yet unclassified' }
Gateway_msgsErrorCodes >> initialize [
	super initialize.

]
