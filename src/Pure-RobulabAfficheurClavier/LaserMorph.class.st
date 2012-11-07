Class {
	#name : #LaserMorph,
	#superclass : #Morph,
	#instVars : [
		'afficheurMulti'
	],
	#category : #'Pure-RobulabAfficheur'
}

{ #category : #accessing }
LaserMorph >> afficheurMulti [
	^ afficheurMulti
]

{ #category : #accessing }
LaserMorph >> afficheurMulti: anObject [
	afficheurMulti := anObject
]

{ #category : #'as yet unclassified' }
LaserMorph >> drawOn: aCanvas [
  | position centre compteur  point string numero angle |
	"super drawOn: aCanvas." 	
	position := self positionInWorld. 
	centre:= (position x +400)@(position y+275). 
	"Barre unitaire"
	aCanvas line: (centre x +self afficheurMulti xStandard )@(centre y+self afficheurMulti yStandard ) 
	to:(centre x+self afficheurMulti xStandard )@(centre y+self afficheurMulti yStandard -self afficheurMulti scale )
	color: Color red. 
	"Axe des abscisses"
	aCanvas line: (centre x +self afficheurMulti xStandard )@(centre y+self afficheurMulti yStandard ) 
	to:(centre x+self afficheurMulti xStandard + (2*self afficheurMulti service echoNumber) +20)@(centre y+self afficheurMulti yStandard )
	color: Color red. 
	"Graduations"
	compteur:=0.
	((1+(self afficheurMulti service echoNumber) /10 )asInteger  ) timesRepeat: [
		aCanvas line:(centre x +self afficheurMulti xStandard+2+compteur )@(centre y +self afficheurMulti yStandard)
		to:(centre x+self afficheurMulti xStandard+2+compteur )@(centre y +self afficheurMulti yStandard+8)
		color: Color red. 
		compteur := compteur+20.
	].
	"Unités"	
	compteur:=0.
	((1+(self afficheurMulti service echoNumber)  )asInteger ) timesRepeat: [
			(compteur+1<= ((self afficheurMulti service echoNumber)) )ifTrue:[
				
				angle:=(((self afficheurMulti service echos at:(compteur+1)) angle*180/3.14)asInteger).
				point := (centre x +self afficheurMulti xStandard+(compteur*2) )@(centre y +self afficheurMulti yStandard+10).
				string := ( ((((self afficheurMulti service echos at:(compteur+1)) angle*180/3.14)asInteger)asString),'°').
				(angle=0)ifTrue:[string:=' ',string].
				
				((angle rem:20)=0)ifTrue:["On n'affiche que les graduations multiples de 20"
					aCanvas drawString: string at: point. 
					
				].
			compteur := compteur+1.
			].
	].
	"Valeurs"
	numero:=1.
	self afficheurMulti afficheurs do: [:aff|
		(aff numero isNil)ifFalse:[ 
			aff valeur: (self afficheurMulti service echos at: numero) distance.
			aCanvas line:(centre x +self afficheurMulti xStandard+(2*numero) )@(centre y +self afficheurMulti yStandard)
			to:(centre x+self afficheurMulti xStandard+(2*numero) )@(centre y +self afficheurMulti yStandard- ((self afficheurMulti scale)*(aff valeur) ))
			color: Color black. 
		numero:=numero+1.
		]
		].
	
	
	
	
	

]

{ #category : #'as yet unclassified' }
LaserMorph >> show [
	"LaserMorph new show"
	| s |
	s := SystemWindow new.
	s addMorph: self.
	s setLabel: 'Champ de profondeur de robulab'.
	s openInWorld
]
