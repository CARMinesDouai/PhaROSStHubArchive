Class {
	#name : #PureClientUsesExamples,
	#superclass : #Object,
	#category : #'Pure-Examples'
}

{ #category : #'as yet unclassified' }
PureClientUsesExamples class >> affichagePadClavier: unRobulab [
	| pad pdr conducteurDeRobulab trajectoireSimple|
	pad := AfficheurDirectionClavier new.
	pad robulab: unRobulab.
	pad position: (1000 @ 100).
	pad openInWorld.
	conducteurDeRobulab:=RobulabDrive new.
	conducteurDeRobulab robulab: unRobulab.
	pad robulabDrive:conducteurDeRobulab.
	
]

{ #category : #'as yet unclassified' }
PureClientUsesExamples >> workspaceBrowsingServices [
| pdr |


pdr := Robulab newWith: #[192 168 1 2] and: 60000.


"NotificationManager".
pdr with: NotificationManagerService do: [
	: service |
	service getData.
	
	pdr with: LaserService do: [
		:laser |
"		service deleteNotificationRecordFromService: laser."
		service addNotificationRecordToInstance: laser withPeriod:  20.
		
	].
].


"IO Service"
pdr with: IOService do: [
	: service |
	service getData .
].



"Differential Drive"
pdr with: DifferentialDriveService do: [
	: service |
	service getData .
	service printCurrentAndTargetValues. 
	service setTargetLinearSpeed: 0.0 andTargetAngularSpeed: 0.4.	
].



"Service Laser"
pdr with: LaserService do: [
	: service |
	service getData .
	service printEchos .
	service startPrettyPrint .
	service stopPrettyPrint .	
].

Smalltalk garbageCollect .

LaserService allInstances.
Robulab allInstances


]

{ #category : #'as yet unclassified' }
PureClientUsesExamples >> workspaceKillingProcess [

	Process allInstances "allSubInstances" select: [:aProcess | aProcess priority = 30] thenDo: [:p| p terminate ]
]

{ #category : #'as yet unclassified' }
PureClientUsesExamples >> workspaceMovingRobot [
| pdr pdrDrive |

"Cree un Robulab, lui associe un RobulabDrive et un Pad"

pdr := Robulab new.
PureClientUsesExamples affichagePadClavier: pdr.
pdrDrive:= RobulabDrive new.
pdrDrive robulab:pdr.

"Permet de faire avancer tout droite le robulab pendant 2 secondes"
pdrDrive avance:8 pendant:2000 avecUneVitesse:2 etUneVitesseAngulaire:2.

"Permet de faire un cercle"
pdrDrive cercle.

"Permet de faire tourner le robulab d'un angle de 90° vers la droite"
pdrDrive rotationDroite.

"Permet de faire faire un cercle"
pdrDrive cercle:1 and:1.

"Permet de faire avancer le robulab de 1 metre (buggué)"
pdrDrive avanceDe: 1 avecUneVitesseDe: 1.

"Permet de faire faire un carré au robull"
pdrDrive carreAvecUneVitesse:2.

"Permet d'afficher la position du robulab"
(pdr directoryService services at:'0005') printPosition.




]
