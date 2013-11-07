Class {
	#name : #ROBOffice,
	#superclass : #ROBLabElement,
	#instVars : [
		'description',
		'number',
		'employees'
	],
	#category : #'RoboShop-Lab-Places'
}

{ #category : #constructor }
ROBOffice class >> number: aNumber [	
	^ self new number: aNumber; yourself
]

{ #category : #offices }
ROBOffice class >> office3101 [
	^ ROBOffice new icon: nil;
		 image: nil;
		
		location: (ROBUniquePose
				point: -7.534 @ -14.795200000000001
				orientation: -2.4184
				id: 26);
		 number: 3101;
		 employees: {}
]

{ #category : #offices }
ROBOffice class >> office3102 [
	^ ROBOffice new
		icon: nil;
		image: nil;
		location: (ROBUniquePose point: -6.916 @ -15.4106 orientation: -2.4292000000000002 id: 27);
		number: 3102;
		employees:
				{(ROBEmployee new
						charge: 'Adjoint, Charge de l enseignement productique ';
						name: 'Jacques BOONAERT';
						titles: 'Jacques BOONAERT;Jacques ; BOONAERT';
						work: '')}
]

{ #category : #offices }
ROBOffice class >> office3103 [
	^ ROBOffice new
		icon: nil;
		image: nil;
		location: (ROBUniquePose point: -4.708 @ -15.108400000000001 orientation: -0.1442 id: 25);
		number: 3103;
		employees: {}
]

{ #category : #offices }
ROBOffice class >> office3105 [
	^ ROBOffice new
		icon: nil;
		image: nil;
		location: (ROBUniquePose point: -5.506 @ -17.867900000000002 orientation: -0.1333 id: 24);
		number: 3105;
		employees: {}
]

{ #category : #offices }
ROBOffice class >> office3108 [
	^ ROBOffice new
		icon: nil;
		image: nil;
		location: (ROBUniquePose point: -6.203 @ -23.0306 orientation: 3.045 id: 23);
		number: 3108;
		employees:
				{(ROBEmployee new
						charge: 'Enseignant - chercheur';
						name: 'Moamar SAYED MOUCHAWEH';
						titles: 'Moamar SAYED MOUCHAWEH ; Moamar ; SAYED ; MOUCHAWEH';
						work: '')}
]

{ #category : #offices }
ROBOffice class >> office3109 [
	^ ROBOffice new
		icon: nil;
		image: nil;
		location: (ROBUniquePose point: -8.218 @ -30.2638 orientation: -3.1249000000000002 id: 13);
		number: 3109;
		employees:
				{(ROBEmployee new
						charge: 'Ingenieur';
						name: 'Ines Yanyun LU';
						titles: 'Ines Yanyun LU ; Ines ; Yanyun ; LU ';
						work: '')}
]

{ #category : #offices }
ROBOffice class >> office3110 [
	^ ROBOffice new
		icon: nil;
		image: nil;
		location: (ROBUniquePose point: -8.27 @ -32.1255 orientation: 3.093 id: 14);
		number: 3110;
		employees:
				{(ROBEmployee new
						charge: 'Enseignant - chercheur';
						name: 'Cecile LABARRE';
						titles: 'Cecile LABARRE ; Cecile ; LABARRE ; Doctor ; PhD';
						work: '')}
]

{ #category : #offices }
ROBOffice class >> office3111 [
	^ ROBOffice new
		icon: nil;
		image: nil;
		location: (ROBUniquePose point: -8.364 @ -36.7016 orientation: 3.0789 id: 16);
		number: 3111;
		employees:
				{(ROBEmployee new
						charge: 'Enseignant - chercheur';
						name: 'Frederic KLOPCIC';
						titles: 'Frederic KLOPCIC ; Frederic ; KLOPCIC ; Doctor ; PhD';
						work: '')}
]

{ #category : #offices }
ROBOffice class >> office3112 [
	^ ROBOffice new
		icon: nil;
		image: nil;
		location: (ROBUniquePose point: -8.381 @ -37.9609 orientation: -3.0702000000000003 id: 17);
		number: 3112;
		employees:
				{(ROBEmployee new
						charge: 'Enseignant - chercheur';
						name: 'Gabriel HOUSSAYE';
						titles: 'Gabriel HOUSSAYE; Gabriel ;HOUSSAYE; Doctor ; PhD';
						work: '')}
]

{ #category : #offices }
ROBOffice class >> office3113 [
	^ ROBOffice new
		icon: nil;
		image: nil;
		location: (ROBUniquePose point: -8.444 @ -41.3251 orientation: 3.0483000000000002 id: 18);
		number: 3113;
		employees:
				{(ROBEmployee new
						charge: 'Technicien';
						name: 'Francois CORTE';
						titles: 'Francois CORTE; Francois ; CORTE';
						work: '')}
]

{ #category : #offices }
ROBOffice class >> office3114 [
	^ ROBOffice new
		icon: nil;
		image: nil;
		location: (ROBUniquePose point: -8.697000000000001 @ -45.937400000000004 orientation: 3.0515000000000003 id: 21);
		number: 3114;
		employees:
				{(ROBEmployee new
						charge: 'Ingeneur de recherche';
						name: 'Lala RAJAOARISOA';
						titles: 'Lala RAJAOARISOA;Lala ;RAJAOARISOA';
						work: '')}
]

{ #category : #offices }
ROBOffice class >> office3117 [
	^ ROBOffice new
		icon: nil;
		image: nil;
		location: (ROBUniquePose point: -8.512 @ -45.867000000000004 orientation: -0.09280000000000001 id: 20);
		number: 3117;
		employees: {}
]

{ #category : #offices }
ROBOffice class >> office3118 [
	^ ROBOffice new
		icon: nil;
		image: nil;
		location: (ROBUniquePose point: -8.465 @ -43.971900000000005 orientation: 0.0367 id: 19);
		number: 3118;
		employees: {}
]

{ #category : #offices }
ROBOffice class >> office3119 [
	^ ROBOffice new
		icon: nil;
		image: nil;
		location: (ROBUniquePose point: -8.182 @ -35.1878 orientation: -0.13240000000000002 id: 15);
		number: 3119;
		employees: {}
]

{ #category : #offices }
ROBOffice class >> office3122 [
	^ ROBOffice new
		icon: nil;
		image: nil;
		location: (ROBUniquePose point: -1.173 @ -24.840700000000002 orientation: -0.9472 id: 10);
		number: 3122;
		employees: {}
]

{ #category : #offices }
ROBOffice class >> office3125 [
	^ ROBOffice new
		icon: nil;
		image: nil;
		location: (ROBUniquePose point: 4.316 @ -15.744100000000001 orientation: -0.24780000000000002 id: 9);
		number: 3125;
		employees:
				{(ROBEmployee new
						charge: 'PhD Student ';
						name: 'Guillermo POLITO';
						titles: 'Guillermo POLITO; Guillermo ; POLITO';
						work: '').
					(ROBEmployee new
						charge: 'Post-DOC ';
						name: 'Zhi YAN';
						titles: 'Zhi YAN; Zhi ; YAN';
						work: '').
					(ROBEmployee new
						charge: 'PhD Student';
						name: 'Nickolaos PAPOULIAS';
						titles: 'Nickolaos PAPOULIAS; Nickolaos ; PAPOULIAS';
						work: '')}
]

{ #category : #offices }
ROBOffice class >> office3126 [
	^ ROBOffice new icon: nil;
		 image: nil;
		
		location: (ROBUniquePose
				point: 5.011 @ -2.2592000000000003
				orientation: -0.1198
				id: 8);
		 number: 3126;
		 employees: {ROBEmployee new charge: 'Enseignant - chercheur';
			 name: 'Noury BOURAQUADI';
			 titles: 'Noury BOURAQUADI ; Nourradine ; Noury ; BOURAQUADI';
			 work: ''}
]

{ #category : #offices }
ROBOffice class >> office3127 [
	^ ROBOffice new
		icon: nil;
		image: nil;
		location: (ROBUniquePose point: 5.011 @ -2.2592000000000003 orientation: -0.1198 id: 7);
		number: 3127;
		employees:
				{(ROBEmployee new
						charge: 'PhD Student';
						name: 'Houari TOUBAKH';
						titles: 'Houari TOUBAKH; Houari ; TOUBAKH ';
						work: '').
					(ROBEmployee new
						charge: 'PhD Student';
						name: 'Antoine CHAMMAS';
						titles: 'Antoine CHAMMAS ; Antoine ; CHAMMAS ';
						work: '')}
]

{ #category : #offices }
ROBOffice class >> office3128 [
	^ ROBOffice new
		icon: nil;
		image: nil;
		location: (ROBUniquePose point: 4.726 @ -1.1745 orientation: -0.0442 id: 6);
		number: 3128;
		employees:
				{(ROBEmployee new
						charge: 'PhD Student';
						name: 'Antoine SYLVAIN';
						titles: 'Antoine SYLVAIN ; Antoine ; SYLVAIN';
						work: '').
					(ROBEmployee new
						charge: 'Post-DOC';
						name: 'Blaise GUEPIE';
						titles: 'Blaise GUEPIE ; Blaise; GUEPIE';
						work: '')}
]

{ #category : #offices }
ROBOffice class >> office3130 [
	^ ROBOffice new
		icon: nil;
		image: nil;
		location: (ROBUniquePose point: -1.613 @ -0.0019 orientation: -1.631 id: 4);
		number: 3130;
		employees: {}
]

{ #category : #offices }
ROBOffice class >> office3131 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point: ((-2.588@ -0.038400000000000004)) orientation: -1.6426 id: 2); number: 3131; employees: { ROBEmployee new charge: 'Post-DOC'; name: 'Klaudia HORVATH' ; titles: 'Klaudia ; Doctor Klaudia ; Doctor Horvath ; Klaudia Horvath ; Doctor KlaudiaHorvath'; work: '' . ROBEmployee new charge: 'Post-DOC'; name: 'Blaise GUEPIE' ; titles: 'Blaise GUEPIE ; Blaise; GUEPIE'; work: '' .})
]

{ #category : #offices }
ROBOffice class >> office3134 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point: ((-7.266@ -4.8585)) orientation: -3.1267 id: 29); number: 3134; employees: { ROBEmployee new charge: 'Enseignant - chercheur'; name: 'Eric DUVIELLA' ; titles: 'Eric DUVIELLA ; Eric ; DUVIELLA '; work: '' .})
]

{ #category : #offices }
ROBOffice class >> office3136 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point: ((-7.104@1.2035)) orientation: 3.1271 id: 30); number: 3136; employees: { ROBEmployee new charge: 'Enseignant - chercheur'; name: 'Anthony FLEURY' ; titles: 'Anthony FLEURY ; Anthony ; FLEURY ; Doctor ; PhD'; work: '' .})
]

{ #category : #offices }
ROBOffice class >> office3137 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point: ((-7.014@2.4237)) orientation: -3.0921000000000003 id: 31); number: 3137; employees: { ROBEmployee new charge: 'Enseignant - chercheur'; name: 'Arnaud DONIEC' ; titles: 'Arnaud DONIEC; Arnaud ; DONIEC ; Doctor ; PhD'; work: '' .})
]

{ #category : #offices }
ROBOffice class >> office3139 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point: ((-6.746@7.2129)) orientation: -0.0344 id: 33); number: 3139; employees: {})
]

{ #category : #offices }
ROBOffice class >> office3140 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point: ((-6.48@14.985600000000002)) orientation: 0.0405 id: 36); number: 3140; employees: {})
]

{ #category : #offices }
ROBOffice class >> office3142 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point: ((-6.766@7.202800000000001)) orientation: 3.1403000000000003 id: 32); number: 3142; employees: { ROBEmployee new charge: 'Gestionnaire Administrative'; name: 'Muriel MORGAN' ; titles: 'Muriel MORGAN; Muriel ; MORGAN'; work: '' .})
]

{ #category : #offices }
ROBOffice class >> office3143 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point: ((-6.572@13.222100000000001)) orientation: -3.0964 id: 34); number: 3143; employees: { ROBEmployee new charge: 'Chef du Department'; name: 'Philippe HASBROUCQ' ; titles: 'Philippe HASBROUCQ; Philippe ; HASBROUCQ; Chef ; '; work: '' .})
]

{ #category : #offices }
ROBOffice class >> office3144 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point: ((-6.625@14.157900000000001)) orientation: 3.1274 id: 35); number: 3144; employees: { ROBEmployee new charge: 'Secretariat'; name: 'Christine DELILLE' ; titles: 'Christine DELILLE ; Christine ; DELILLE '; work: '' .})
]

{ #category : #offices }
ROBOffice class >> office3145 [ 
^(ROBOffice new icon: (nil); image: (nil); location:( ROBUniquePose point: ((-6.496@18.9706)) orientation: -3.1105 id: 37); number: 3145; employees: { ROBEmployee new charge: 'Enseignant - chercheur '; name: 'Jannik Laval' ; titles: 'Jannik Laval ; Jannik ; Laval  '; work: '' .})
]

{ #category : #dump }
ROBOffice >> asDump [
	| es |
	es := (employees
				inject: '{'
				into: [:acc :mr | acc , mr asDump , '.'])
				, '}'.

	ROBOffice class
		compile: ('office{1} 
^{2}' format: {number asString. '(' , super asDump , '; number: {1};description:''{2}''; employees: {3})' format: {number asString . self description . es}}).
	^ 'ROBOffice office{1}' format: {number asString}
]

{ #category : #accessing }
ROBOffice >> description [
	^ description ifNil:[''].
]

{ #category : #accessing }
ROBOffice >> description: anObject [
	
	description := anObject
]

{ #category : #accessing }
ROBOffice >> employees [
	
	^ employees
]

{ #category : #accessing }
ROBOffice >> employees: aSet [ 
	aSet do: [  : e | self register:e  ].
]

{ #category : #accessing }
ROBOffice >> initialize [ 	
	employees := Set new.
]

{ #category : #accessing }
ROBOffice >> number [
	
	^ number
]

{ #category : #accessing }
ROBOffice >> number: aSmallInteger [ 
	number := aSmallInteger
]

{ #category : #accessing }
ROBOffice >> register: anEmployee [
	employees add: anEmployee.
	anEmployee office: self .
]
