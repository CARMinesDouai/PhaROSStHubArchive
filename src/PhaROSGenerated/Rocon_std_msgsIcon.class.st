Class {
	#name : #'Rocon_std_msgsIcon',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_std_msgsIcon >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsIcon >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsIcon >> format [
	^ self getAt: #format. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsIcon >> format: aValue [
	^ self at: #format put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsIcon >> initialize [
	super initialize.
	 self resource_name: ''. 
	 self format: ''. 
	 self data: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsIcon >> resource_name [
	^ self getAt: #resource_name. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsIcon >> resource_name: aValue [
	^ self at: #resource_name put: aValue. 

]
