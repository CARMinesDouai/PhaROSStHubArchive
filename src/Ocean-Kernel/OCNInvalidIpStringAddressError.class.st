Class {
	#name : #OCNInvalidIpStringAddressError,
	#superclass : #OCNError,
	#instVars : [
		'invalidStringAddress'
	],
	#category : #'Ocean-Kernel'
}

{ #category : #accessing }
OCNInvalidIpStringAddressError >> invalidStringAddress [
	^ invalidStringAddress
]

{ #category : #accessing }
OCNInvalidIpStringAddressError >> invalidStringAddress: anObject [
	invalidStringAddress := anObject
]
