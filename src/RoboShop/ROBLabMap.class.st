Class {
	#name : #ROBLabMap,
	#superclass : #Object,
	#instVars : [
		'hash',
		'places',
		'robot'
	],
	#category : #'RoboShop-Lab-Places'
}

{ #category : #'as yet unclassified' }
ROBLabMap class >> ma9358: aRobot [ 
	ROBLabMap new mapHash: #526909358; places: {ROBToilet new icon: (nil); image: (nil); genre: #male .(ROBOffice new icon: (nil); image: (nil); number: 3111; employees: { ROBEmployee new charge: 'Enseignant - chercheur'; name: 'Frederic KLOPCIC' ; titles: 'Frederic KLOPCIC ; Frederic ; KLOPCIC ; Doctor ; PhD'; work: '' .}).(ROBOffice new icon: (nil); image: (nil); number: 3126; employees: { ROBEmployee new charge: 'Enseignant - chercheur'; name: 'Noury BOURAQUADI' ; titles: 'Noury BOURAQUADI ; Nourradine ; Noury ; BOURAQUADI'; work: '' .}).ROBToilet new icon: (nil); image: (nil); genre: #female .(ROBOffice new icon: (nil); image: (nil); number: 3145; employees: { ROBEmployee new charge: 'Enseignant - chercheur '; name: 'Jannik Laval' ; titles: 'Jannik Laval ; Jannik ; Laval  '; work: '' .}).(ROBOffice new icon: (nil); image: (nil); number: 3143; employees: { ROBEmployee new charge: 'Chef du Department'; name: 'Philippe HASBROUCQ' ; titles: 'Philippe HASBROUCQ; Philippe ; HASBROUCQ; Chef ; '; work: '' .}).(ROBOffice new icon: (nil); image: (nil); number: 3112; employees: { ROBEmployee new charge: 'Enseignant - chercheur'; name: 'Gabriel HOUSSAYE' ; titles: 'Gabriel HOUSSAYE; Gabriel ;HOUSSAYE; Doctor ; PhD'; work: '' .}).(ROBOffice new icon: (nil); image: (nil); number: 3127; employees: { ROBEmployee new charge: 'PhD Student'; name: 'Houari TOUBAKH' ; titles: 'Houari TOUBAKH; Houari ; TOUBAKH '; work: '' . ROBEmployee new charge: 'PhD Student'; name: 'Antoine CHAMMAS' ; titles: 'Antoine CHAMMAS ; Antoine ; CHAMMAS '; work: '' .}).(ROBOffice new icon: (nil); image: (nil); number: 3114; employees: { ROBEmployee new charge: 'Ingeneur de recherche'; name: 'Lala RAJAOARISOA' ; titles: 'Lala RAJAOARISOA;Lala ;RAJAOARISOA'; work: '' .}).(ROBOffice new icon: (nil); image: (nil); number: 3139; employees: {}).(ROBOffice new icon: (nil); image: (nil); number: 3122; employees: {}).(ROBOffice new icon: (nil); image: (nil); number: 3119; employees: {}).(ROBOffice new icon: (nil); image: (nil); number: 3113; employees: { ROBEmployee new charge: 'Technicien'; name: 'Francois CORTE' ; titles: 'Francois CORTE; Francois ; CORTE'; work: '' .}).(ROBOffice new icon: (nil); image: (nil); number: 3130; employees: {}).(ROBOffice new icon: (nil); image: (nil); number: 3117; employees: {}).(ROBOffice new icon: (nil); image: (nil); number: 3118; employees: {}).(ROBOffice new icon: (nil); image: (nil); number: 3110; employees: { ROBEmployee new charge: 'Enseignant - chercheur'; name: 'Cecile LABARRE' ; titles: 'Cecile LABARRE ; Cecile ; LABARRE ; Doctor ; PhD'; work: '' .}).ROBStairs new icon: (nil); image: (nil).(ROBOffice new icon: (nil); image: (nil); number: 3102; employees: { ROBEmployee new charge: 'Adjoint, Charge de l enseignement productique '; name: 'Jacques BOONAERT' ; titles: 'Jacques BOONAERT;Jacques ; BOONAERT'; work: '' .}).ROBStairs new icon: (nil); image: (nil).(ROBOffice new icon: (nil); image: (nil); number: 3137; employees: { ROBEmployee new charge: 'Enseignant - chercheur'; name: 'Arnaud DONIEC' ; titles: 'Arnaud DONIEC; Arnaud ; DONIEC ; Doctor ; PhD'; work: '' .}).(ROBOffice new icon: (nil); image: (nil); number: 3134; employees: { ROBEmployee new charge: 'Enseignant - chercheur'; name: 'Eric DUVIELLA' ; titles: 'Eric DUVIELLA ; Eric ; DUVIELLA '; work: '' .}).ROBElevator new icon: (nil); image: (nil).(ROBOffice new icon: (nil); image: (nil); number: 3128; employees: { ROBEmployee new charge: 'PhD Student'; name: 'Antoine SYLVAIN' ; titles: 'Antoine SYLVAIN ; Antoine ; SYLVAIN'; work: '' . ROBEmployee new charge: 'Post-DOC'; name: 'Blaise GUEPIE' ; titles: 'Blaise GUEPIE ; Blaise; GUEPIE'; work: '' .}).ROBToilet new icon: (nil); image: (nil); genre: #female .(ROBOffice new icon: (nil); image: (nil); number: 3103; employees: {}).(ROBOffice new icon: (nil); image: (nil); number: 3101; employees: {}).(ROBOffice new icon: (nil); image: (nil); number: 3105; employees: {}).(ROBOffice new icon: (nil); image: (nil); number: 3142; employees: { ROBEmployee new charge: 'Gestionnaire Administrative'; name: 'Muriel MORGAN' ; titles: 'Muriel MORGAN; Muriel ; MORGAN'; work: '' .}).(ROBOffice new icon: (nil); image: (nil); number: 3131; employees: { ROBEmployee new charge: 'Post-DOC'; name: 'Klaudia HORVATH' ; titles: 'Klaudia ; Doctor Klaudia ; Doctor Horvath ; Klaudia Horvath ; Doctor KlaudiaHorvath'; work: '' . ROBEmployee new charge: 'Post-DOC'; name: 'Blaise GUEPIE' ; titles: 'Blaise GUEPIE ; Blaise; GUEPIE'; work: '' .}).(ROBOffice new icon: (nil); image: (nil); number: 3144; employees: { ROBEmployee new charge: 'Secretariat'; name: 'Christine DELILLE' ; titles: 'Christine DELILLE ; Christine ; DELILLE '; work: '' .}).(ROBOffice new icon: (nil); image: (nil); number: 3108; employees: { ROBEmployee new charge: 'Enseignant - chercheur'; name: 'Moamar SAYED MOUCHAWEH' ; titles: 'Moamar SAYED MOUCHAWEH ; Moamar ; SAYED ; MOUCHAWEH'; work: '' .}).ROBToilet new icon: (nil); image: (nil); genre: #male .(ROBOffice new icon: (nil); image: (nil); number: 3125; employees: { ROBEmployee new charge: 'PhD Student '; name: 'Guillermo POLITO' ; titles: 'Guillermo POLITO; Guillermo ; POLITO'; work: '' . ROBEmployee new charge: 'Post-DOC '; name: 'Zhi YAN' ; titles: 'Zhi YAN; Zhi ; YAN'; work: '' . ROBEmployee new charge: 'PhD Student'; name: 'Nickolaos PAPOULIAS' ; titles: 'Nickolaos PAPOULIAS; Nickolaos ; PAPOULIAS'; work: '' .}).(ROBOffice new icon: (nil); image: (nil); number: 3109; employees: { ROBEmployee new charge: 'Ingenieur'; name: 'Ines Yanyun LU' ; titles: 'Ines Yanyun LU ; Ines ; Yanyun ; LU '; work: '' .}).(ROBOffice new icon: (nil); image: (nil); number: 3140; employees: {}).(ROBOffice new icon: (nil); image: (nil); number: 3136; employees: { ROBEmployee new charge: 'Enseignant - chercheur'; name: 'Anthony FLEURY' ; titles: 'Anthony FLEURY ; Anthony ; FLEURY ; Doctor ; PhD'; work: '' .}).}; robot: aRobot; yourself. 
]

{ #category : #'as yet unclassified' }
ROBLabMap class >> map526909358: aRobot [ 
	ROBLabMap new mapHash: #526909358; places: {ROBToilet new icon: (nil); image: (nil); location:( ROBUniquePose point: ((-1.53@0.1836)) orientation: 1.5188000000000001 id: 3); genre: #male .ROBOffice office3111.ROBOffice office3126.ROBToilet new icon: (nil); image: (nil); location:( ROBUniquePose point: ((-7.3500000000000005@ -29.2821)) orientation: -1.1793 id: 12); genre: #female .ROBOffice office3145.ROBOffice office3143.ROBOffice office3112.ROBOffice office3127.ROBOffice office3114.ROBOffice office3139.ROBOffice office3122.ROBOffice office3119.ROBOffice office3113.ROBOffice office3130.ROBOffice office3117.ROBOffice office3118.ROBOffice office3110.ROBStairs new icon: (nil); image: (nil); location:( ROBUniquePose point: ((-1.54@ -49.2066)) orientation: 0.0238 id: 22).ROBOffice office3102.ROBStairs new icon: (nil); image: (nil); location:( ROBUniquePose point: ((-6.916@ -15.4106)) orientation: -2.4292000000000002 id: 28).ROBOffice office3137.ROBOffice office3134.ROBElevator new icon: (nil); image: (nil); location:( ROBUniquePose point: ((-0.065@0.1854)) orientation: 1.48 id: 5).ROBOffice office3128.ROBToilet new icon: (nil); image: (nil); location:( ROBUniquePose point: ((-5.535@0.37570000000000003)) orientation: 1.5401 id: 1); genre: #female .ROBOffice office3103.ROBOffice office3101.ROBOffice office3105.ROBOffice office3142.ROBOffice office3131 .ROBOffice office3144.ROBOffice office3108.ROBToilet new icon: (nil); image: (nil); location:( ROBUniquePose point: ((-2.787@ -25.1441)) orientation: -0.8189000000000001 id: 11); genre: #male .ROBOffice office3125.ROBOffice office3109.ROBOffice office3140.ROBOffice office3136.}; robot: aRobot; yourself. 
]

{ #category : #'as yet unclassified' }
ROBLabMap >> checkHash [
	hash ifNil: [ 
		hash  := robot mapHash.
	].

]

{ #category : #'as yet unclassified' }
ROBLabMap >> encode [
	| ps code |
	"Save points as constructor map{HASH}"
	ps := (places inject:'{' into: [ :acc : mr | acc, mr asDump , '.']), '}'.
	code := 'map{1}: aRobot 
	ROBLabMap new mapHash: #{1}; places: {2}; robot: aRobot; yourself. ' format: { hash asString . ps }.
	self class class compile: code.
	
]

{ #category : #'as yet unclassified' }
ROBLabMap >> initialize [
	places := Set new.
	
]

{ #category : #'as yet unclassified' }
ROBLabMap >> isValid [
	^ robot mapHash = hash
]

{ #category : #'as yet unclassified' }
ROBLabMap >> mapHash: aHash [
	hash := aHash asString asSymbol.
]

{ #category : #'as yet unclassified' }
ROBLabMap >> places: aSet [
	places := aSet asSet
]

{ #category : #'as yet unclassified' }
ROBLabMap >> register: aPlace [
	places add: aPlace.
	self checkHash.
]

{ #category : #'as yet unclassified' }
ROBLabMap >> robot: aRobot [
	robot := aRobot.
	self register: (ROBRobot name: robot robotName pose: [ robot currentPosition ] ).
]
