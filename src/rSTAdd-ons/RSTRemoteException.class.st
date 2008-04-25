"
I represent a remote exception
"
Class {
	#name : #RSTRemoteException,
	#superclass : #RSTException,
	#category : #'rSTAdd-ons'
}

{ #category : #'instance creation' }
RSTRemoteException class >> on: anException [
	^ self new initializeOn: anException
]

{ #category : #initialization }
RSTRemoteException >> initializeOn: anException [
	self messageText: anException asString
]
