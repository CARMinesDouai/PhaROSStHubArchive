Class {
	#name : #Exemple,
	#superclass : #Object,
	#category : #'Pure-Examples'
}

{ #category : #'as yet unclassified' }
Exemple class >> affichagePadClavier: unRobulab [
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
Exemple >> workspaceBrowsingServices [
| pdr |

pdr := Robulab newWith: #[192 168 1 2] and: 60000.

"NotificationManager".
(pdr directoryService services at:'0001')getData .
(pdr directoryService services at:'0001')addNotificationRecordToInstance: '0400' withPeriod: 20.
(pdr directoryService services at:'0001')deleteNotificationRecordFromService: '0500'.

"IO Service"

(pdr directoryService services at:'0002')getData .

"Differential Drive"
(pdr directoryService services at:'0003')getData .
(pdr directoryService services at:'0003') printCurrentAndTargetValues. 
(pdr directoryService services at:'0003') setTargetLinearSpeed: 0.0 andTargetAngularSpeed: 0.4.

"Service Laser"
(pdr directoryService services at:'0004')getData .
(pdr directoryService services at:'0004')printEchos .
(pdr directoryService services at:'0004')startPrettyPrint .
(pdr directoryService services at:'0004')stopPrettyPrint .

]

{ #category : #'as yet unclassified' }
Exemple >> workspaceKillingProcess [

	Process allInstances "allSubInstances" select: [:aProcess | aProcess priority = 30] thenDo: [:p| p terminate ]
]

{ #category : #'as yet unclassified' }
Exemple >> workspaceMovingRobot [
| pdr pdrDrive |

"Cree un Robulab, lui associe un RobulabDrive et un Pad"

pdr := Robulab new.
Exemple affichagePadClavier: pdr.
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
