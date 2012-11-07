"
Cette classe contient toutes les constantes du Robulab:
Les constantes en variable de classe sont communes à tout les robots (codes d'actions, d'erreurs et de services).
Les constantes en variable d'instance sont propre à un robot, et sont initialisées lors de la connexion au robot.

Instance Variables:
	services	<ProtoObject | PseudoContext>
		Liste les services disponibles sur le robot. key= instance number, value= type code.

Class Instance Variables:
	codesErreurs	<ProtoObject | PseudoContext>
	codesActions	<ProtoObject | PseudoContext>
	codesServices	<ProtoObject | PseudoContext>
"
Class {
	#name : #ConstantesRobulab,
	#superclass : #Object,
	#instVars : [
		'services'
	],
	#classInstVars : [
		'codesErreurs',
		'codesActions',
		'codesServices'
	],
	#category : #'Pure-Robulab'
}

{ #category : #'as yet unclassified' }
ConstantesRobulab class >> codesActions [
	"Dictionnaire donnant la correspondance entre un code d'action et une action"
	^ {   '00' -> 'GET'.
		  '01'-> 'QUERY'.
		  '02'->'REPLACE'.
		  '03'->'UPDATE'.
		  '04'->'INSERT'.
		  '05'->'DELETE'.
		  '06'->'SUBMIT'	 } asDictionary.
]

{ #category : #accessing }
ConstantesRobulab class >> codesErreurs [
	"Dictionnaire établissant la correspondance entre un code d'erreur et le libéllé d'une erreur"
	^ {   '00' -> 'Success'.
		  '01'->'Target does not exist'.
		  '02'->'Action is not supported'.
		  '03'->'Unknown action'.
		  '04'->'Invalid length'.
		  '05'->'Invalid data' } asDictionary.
]

{ #category : #'as yet unclassified' }
ConstantesRobulab class >> codesServices [
	"Dictionnaire faisant la correspondance entre le nom n'un service et son numéro de type"
	^ {   '0000' -> 'DIRECTORY'.
		  '0001'-> 'NOTIFICATION MANAGER'.
		  '4001'->'I/O'.
		  '4005'->'DIFFERENTIAL DRIVE'.
		  '4004'->'LASER'.
		  '8002'->'LOCALIZATION'.
		  '4008'->'TELEMETER'	 } asDictionary.
]
