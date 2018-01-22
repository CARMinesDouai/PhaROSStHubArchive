Class {
	#name : #'Rocon_std_msgsFloat32Stamped',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_std_msgsFloat32Stamped >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsFloat32Stamped >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsFloat32Stamped >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsFloat32Stamped >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsFloat32Stamped >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self data: 0.0. 

]
