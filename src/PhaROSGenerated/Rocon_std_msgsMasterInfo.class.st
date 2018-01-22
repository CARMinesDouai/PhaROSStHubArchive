Class {
	#name : #'Rocon_std_msgsMasterInfo',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_std_msgsMasterInfo >> description [
	^ self getAt: #description. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsMasterInfo >> description: aValue [
	^ self at: #description put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsMasterInfo >> icon [
	^ self getAt: #icon. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsMasterInfo >> icon: aValue [
	^ self at: #icon put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsMasterInfo >> initialize [
	super initialize.
	 self name: ''. 
	 self rocon_uri: ''. 
	 self description: ''. 
	 self icon: Rocon_std_msgsIcon new. 
	 self version: ''. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsMasterInfo >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsMasterInfo >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsMasterInfo >> rocon_uri [
	^ self getAt: #rocon_uri. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsMasterInfo >> rocon_uri: aValue [
	^ self at: #rocon_uri put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsMasterInfo >> version [
	^ self getAt: #version. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsMasterInfo >> version: aValue [
	^ self at: #version put: aValue. 

]
