Class {
	#name : #ROBScripts,
	#superclass : #Object,
	#category : #RoboShop
}

{ #category : #scripts }
ROBScripts >> scriptShrinkAndEncodeImages [
	
	self halt: 'Encoding images into methods is not implemented yet!'.
	((Smalltalk image imageDirectory / 'productsImages') filesMatching: '*.jpg;*.png') do: [ :file |
		|img scaledimage|
		img := ImageReadWriter formFromFileNamed: file.
		scaledimage := img scaledToSize: 200@200.
		scaledimage writeJPEGfileNamed: 'productsImagesShrinked/', file basename.
	].
]

{ #category : #scripts }
ROBScripts >> scriptStartROBApp [

	ROBApp stop.
	ROBProduct reset.
	ROBApp initialize; start.


]
