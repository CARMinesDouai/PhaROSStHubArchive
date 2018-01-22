Class {
	#name : #'Gateway_msgsRemoteRuleWithStatus',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Gateway_msgsRemoteRuleWithStatus class >> accepted [
	^'accepted'

]

{ #category : #'as yet unclassified' }
Gateway_msgsRemoteRuleWithStatus class >> blocked [
	^'blocked'

]

{ #category : #'as yet unclassified' }
Gateway_msgsRemoteRuleWithStatus class >> pending [
	^'pending'

]

{ #category : #'as yet unclassified' }
Gateway_msgsRemoteRuleWithStatus class >> resend [
	^'resend'

]

{ #category : #'as yet unclassified' }
Gateway_msgsRemoteRuleWithStatus class >> unknown [
	^'unknown'

]

{ #category : #'as yet unclassified' }
Gateway_msgsRemoteRuleWithStatus >> initialize [
	super initialize.
	 self remote_rule: Gateway_msgsRemoteRule new. 
	 self status: ''. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsRemoteRuleWithStatus >> remote_rule [
	^ self getAt: #remote_rule. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsRemoteRuleWithStatus >> remote_rule: aValue [
	^ self at: #remote_rule put: aValue. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsRemoteRuleWithStatus >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsRemoteRuleWithStatus >> status: aValue [
	^ self at: #status put: aValue. 

]
