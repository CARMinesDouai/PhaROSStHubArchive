Class {
	#name : #AfficheurMultiCapteurLaser,
	#superclass : #AfficheurMultiCapteur,
	#category : #'Pure-Deprecated'
}

{ #category : #'as yet unclassified' }
AfficheurMultiCapteurLaser >> initializeAfficheurs [
	| compteur anAfficheur pen |
	self morph: LaserMorph new.
	self afficheurs: Dictionary  new.
	compteur :=1.
	self morph afficheurMulti: self.
	self morph show.
	(service echoNumber) timesRepeat: [
		anAfficheur:= CapteurLaser new.
		anAfficheur numero: compteur.
		afficheurs at:compteur  put: anAfficheur.
		compteur := compteur+1.
		].
]

{ #category : #'as yet unclassified' }
AfficheurMultiCapteurLaser >> printScale [
	| pen compteur point string font canvas |
	pen:=Pen new.
		"Barre unitaire"
		pen color: (Color red).
		pen up.
		pen goto: (self xStandard )@(self yStandard ).
		pen down.
		pen goto: (self xStandard )@(self yStandard -self scale ).
		pen up.
		"Axe des abscisses"
		pen goto: (self xStandard )@(self yStandard ).
		pen down.
		pen goto: (self xStandard + (2*self service echoNumber) +20)@(self yStandard ).
		pen turn: 90.
		pen arrowHead .
		pen up.
		"Graduations"
		compteur:=0.
		((1+(self service echoNumber) /10 )asInteger  ) timesRepeat: [
			pen goto: (self xStandard+2+compteur )@(self yStandard).
			pen down.
			pen goto: (self xStandard+2+compteur )@(self yStandard+8).
			pen up.
			compteur := compteur+20.
		].
	
		"Unités"	
		pen color: (Color red).
		pen turn: 45.
		compteur:=0.
		((1+(self service echoNumber) /10 )asInteger ) timesRepeat: [
			(compteur+1<= ((service echoNumber)) )ifTrue:[
				point := (self xStandard+(compteur*2) )@(self yStandard+15).
				pen goto: point.
				pen down.
				string := ( ((((service echos at:(compteur+1)) angle*180/3.14)asInteger)asString),'°').
				font := StandardFonts defaultFont.
				"pen print: string withFont: font . "
				
				pen displayString: string
			from: 1 
			to: string size 
			at: point
			kern: font baseKern negated
			font: font .
				
				pen up.	 .
			].
				compteur := compteur+10.
		].
			
	




]

{ #category : #accessing }
AfficheurMultiCapteurLaser >> scale [
	^ 20
]

{ #category : #'as yet unclassified' }
AfficheurMultiCapteurLaser >> xStandard [
	^ -350
]

{ #category : #'as yet unclassified' }
AfficheurMultiCapteurLaser >> yStandard [
	^180
]
