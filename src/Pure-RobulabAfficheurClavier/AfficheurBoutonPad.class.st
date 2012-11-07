Class {
	#name : #AfficheurBoutonPad,
	#superclass : #RectangleMorph,
	#instVars : [
		'direction',
		'robulabDrive'
	],
	#category : #'Pure-RobulabAfficheurClavier'
}

{ #category : #accessing }
AfficheurBoutonPad class >> longeurCoteParDefaut [
	^300
]

{ #category : #initialization }
AfficheurBoutonPad >> defaultBounds [
	^50@50 corner: self class longeurCoteParDefaut @ self class longeurCoteParDefaut
]

{ #category : #accessing }
AfficheurBoutonPad >> direction [
	^direction.
]

{ #category : #accessing }
AfficheurBoutonPad >> direction: uneDirection [
	direction := uneDirection
]

{ #category : #'event handling' }
AfficheurBoutonPad >> handlesKeyboard:evt [
	^true.
]

{ #category : #'event handling' }
AfficheurBoutonPad >> handlesMouseDown: evt [
	^true
]

{ #category : #'event handling' }
AfficheurBoutonPad >> handlesMouseStillDown: evt [
	^true
]

{ #category : #'events-processing' }
AfficheurBoutonPad >> mouseDown: anEvent [
	 ^self
]

{ #category : #'event handling' }
AfficheurBoutonPad >> mouseEnter: anEvent [
	"comment stating purpose of message"

	| temporary variable names |
	anEvent hand keyboardFocus: self 
]

{ #category : #'event handling' }
AfficheurBoutonPad >> mouseLeave: anEvent [
	"comment stating purpose of message"

	| temporary variable names |
	anEvent hand releaseKeyboardFocus: self
]

{ #category : #'events-processing' }
AfficheurBoutonPad >> mouseStillDown:  anEvent [
	^self.
]

{ #category : #'events-processing' }
AfficheurBoutonPad >> mouseUp: anEvent [
	^self
]

{ #category : #accessing }
AfficheurBoutonPad >> robulab [
	^robulab.
]

{ #category : #accessing }
AfficheurBoutonPad >> robulab:aRobulab [
	robulab:=aRobulab.
]
