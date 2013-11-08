Class {
	#name : #ROBLabElement,
	#superclass : #Object,
	#instVars : [
		'location',
		'icon',
		'image'
	],
	#category : #'RoboShop-Lab-Places'
}

{ #category : #accessing }
ROBLabElement >> asDump [

	^ '{1} new icon: ({2}); image: ({3}); location:({4})' format: { self class name . icon ifNil:[ 'nil' ] ifNotNil: ['ROBFileLibrary / #', icon path last ]. image  ifNil:[ 'nil' ] ifNotNil: ['ROBFileLibrary / #'. image path last ]. location asDump}.
]

{ #category : #accessing }
ROBLabElement >> icon: anIconURl [
	icon := anIconURl 
	
]

{ #category : #accessing }
ROBLabElement >> id [
	^ location id
]

{ #category : #accessing }
ROBLabElement >> image [
	^ image 
]

{ #category : #accessing }
ROBLabElement >> image: anImageURL [
	image:= anImageURL 
]

{ #category : #accessing }
ROBLabElement >> isFacility [
	^ false.
]

{ #category : #accessing }
ROBLabElement >> isOffice [
	^ false.
]

{ #category : #accessing }
ROBLabElement >> location [
	^ location
]

{ #category : #accessing }
ROBLabElement >> location: anUniquePose [
	location := anUniquePose
]

{ #category : #accessing }
ROBLabElement >> locationID [
	^ location id
]

{ #category : #accessing }
ROBLabElement >> position [
	^ location point.
]

{ #category : #accessing }
ROBLabElement >> renderWith: aRenderer [	
	self subclassResponsibility 
]

{ #category : #accessing }
ROBLabElement >> shortName [
	^ self name.
]
