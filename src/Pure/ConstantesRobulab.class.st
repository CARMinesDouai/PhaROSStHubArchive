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
	#category : #'Pure-Kernel'
}

{ #category : #'as yet unclassified' }
ConstantesRobulab class >> actionCodes [ 
	"Dictionnaire donnant la correspondance entre un code d'action et une action"
	^ { 
		'GET'		-> '00'.
		'QUERY'		-> '01'.
		'REPLACE'	-> '02'.
		'UPDATE'	-> '03'.
		'INSERT'		-> '04'.
		'DELETE'	-> '05'.
		'SUBMIT' 	-> '06'.
	} asDictionary.
]

{ #category : #'as yet unclassified' }
ConstantesRobulab class >> codesServices [
	"Dictionnaire faisant la correspondance entre le nom n'un service et son numéro de type"
	^ {   
		16r0000 -> 'DIRECTORY'.
		16r0001-> 'NOTIFICATION MANAGER'.
		16r4001->'I/O'.
		16r4005->'DIFFERENTIAL DRIVE'.
		16r4004->'LASER'.
		16r8002->'LOCALIZATION'.
		16r4008->'TELEMETER'.
		16r4009 -> 'DRIVE SERVICE'.
		16r0002 -> 'DIAGNOSTIC SERVICE'.
		16r400D -> 'BATTERY SERVICE'.
		16r8001 -> 'TRAJECTORY SERVICE'
	} asDictionary.
]

{ #category : #accessing }
ConstantesRobulab class >> errorMessages [
	"Dictionnaire établissant la correspondance entre un code d'erreur et le libéllé d'une erreur"
	^ {   16r0 -> 'Success'.
		  16r1->'Target does not exist'.
		  16r2 ->'Action is not supported'.
		  16r3 ->'Unknown action'.
		  16r4 ->'Invalid length'.
		  16r5 ->'Invalid data' .
		16r10 -> 'Notification limit reached'.  
		16r11 -> 'Already bound to this notification'
		
		} asDictionary.
]

{ #category : #accessing }
ConstantesRobulab class >> serviceClassPerType [
	^	{
		16r0000 -> DirectoryService .
	      16r0001 -> NotificationManagerService  .
		16r4001 -> IOService . 
		16r4005 -> DifferentialDriveService .
		16r4004 -> LaserService .
		16r8002 -> LocalizationService .
		16r4008 -> TelemeterService .
		16r8001 -> TrajectoryService .	
	} asDictionary.
]
