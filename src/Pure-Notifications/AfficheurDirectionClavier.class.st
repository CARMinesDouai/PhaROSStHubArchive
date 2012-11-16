Class {
	#name : #AfficheurDirectionClavier,
	#superclass : #AfficheurBoutonPad,
	#instVars : [
		'RobulabDrive'
	],
	#category : #'Pure-Deprecated'
}

{ #category : #'events-processing' }
AfficheurDirectionClavier >> handleKeystroke: evt [
	"comment stating purpose of message"

	| unSet vitesseLineaireCourante vitesseAngulaireCourante attente|
	RobulabDrive anEvent:evt.
	RobulabDrive reprend.
	
		
]

{ #category : #'event handling' }
AfficheurDirectionClavier >> handlesMouseDown: evt [
	^true.
]

{ #category : #'event handling' }
AfficheurDirectionClavier >> handlesMouseOver: evt [
	"comment stating purpose of message"

	| temporary variable names |
	^true.
]

{ #category : #'events-processing' }
AfficheurDirectionClavier >> keyDown: anEvent [
	"comment stating purpose of message"

	| unSet vitesseAngulaireCourante vitesseLineaireCourante |


]

{ #category : #'event handling' }
AfficheurDirectionClavier >> mouseEnter: anEvent [
	"comment stating purpose of message"

	| temporary variable names |
	anEvent hand newKeyboardFocus: self.
]

{ #category : #'event handling' }
AfficheurDirectionClavier >> mouseLeave: anEvent [
	"comment stating purpose of message"

	| temporary variable names |
	anEvent hand newKeyboardFocus: nil.
	RobulabDrive arrete.
]

{ #category : #accessing }
AfficheurDirectionClavier >> robulabDrive [
	^ RobulabDrive
]

{ #category : #accessing }
AfficheurDirectionClavier >> robulabDrive: anObject [
	RobulabDrive := anObject
]
