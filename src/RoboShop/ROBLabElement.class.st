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
ROBLabElement >> image: anImageURL [
	image:= anImageURL 
]

{ #category : #accessing }
ROBLabElement >> location: anUniquePose [
	location := anUniquePose
]

{ #category : #accessing }
ROBLabElement >> position [
	^ location point.
]
