Class {
	#name : #'Zeroconf_msgsPublishedService',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Zeroconf_msgsPublishedService class >> rosMd5Sum [ 
^'a1b00555a59ffeb95091f591a6ba849a'
]

{ #category : #'as yet unclassified' }
Zeroconf_msgsPublishedService class >> rosTypeDefinition [ 
^' string name
 string type
 string domain
 int32 port
 string description
'
]

{ #category : #'as yet unclassified' }
Zeroconf_msgsPublishedService class >> rosTypeName [ 
^'zeroconf_msgs/PublishedService'
]

{ #category : #'as yet unclassified' }
Zeroconf_msgsPublishedService class >> typeCreationOrder [ 
^461
]

{ #category : #'as yet unclassified' }
Zeroconf_msgsPublishedService >> description [
	^ self getAt: #description. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsPublishedService >> description: aValue [
	^ self at: #description put: aValue. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsPublishedService >> domain [
	^ self getAt: #domain. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsPublishedService >> domain: aValue [
	^ self at: #domain put: aValue. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsPublishedService >> initialize [
	super initialize.
	 self name: ''. 
	 self type: ''. 
	 self domain: ''. 
	 self port: 0. 
	 self description: ''. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsPublishedService >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsPublishedService >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsPublishedService >> port [
	^ self getAt: #port. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsPublishedService >> port: aValue [
	^ self at: #port put: aValue. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsPublishedService >> type [
	^ self getAt: #type. 

]

{ #category : #'as yet unclassified' }
Zeroconf_msgsPublishedService >> type: aValue [
	^ self at: #type put: aValue. 

]
