Class {
	#name : #ROBProduct,
	#superclass : #Object,
	#instVars : [
		'label',
		'description',
		'imageURL',
		'price',
		'stargazerIdPosition'
	],
	#classInstVars : [
		'products'
	],
	#category : #'RoboShop-Model'
}

{ #category : #accessing }
ROBProduct class >> all [
	^self products
]

{ #category : #accessing }
ROBProduct class >> defaultProducts [

	^SortedCollection new
		add: (
			ROBProduct new
				label: 'Bande adhésive';
				description: 'Bande adhésive raccords plaques de plâtre AXTON, 50m x 48mm';
				imageURL: 'http://www.leroymerlin.fr/multimedia-storage/9/e083e78ef104702aeba3edb2638f4c3-66779363-1-2-3952925.jpg';
				price: 6.80;
				stargazerIdPosition: 18
		);
		add: (
			ROBProduct new
				label: 'Bande à fissures';
				description: 'Bande à fissures fines TOUPRET, 20m x 80mm';
				imageURL: 'http://www.leroymerlin.fr/multimedia-storage/e/9cdb946ff18990a46a3c58afdf2695e-65985661-1-4-4032836.jpg';
				price: 14.3;
				stargazerIdPosition: 2
		);
		add: (
			ROBProduct new
				label: 'Scie à onglet';
				description: 'Scie à onglet AEG 305mm';
				imageURL: 'http://www.leroymerlin.fr/multimedia-storage/c/84a3efb7a78d33e8d13445cca6db045-68250182-1-2-3841736.jpg';
				price: 849.9;
				stargazerIdPosition: 608
		);
		yourself
]

{ #category : #accessing }
ROBProduct class >> emdDemoProducts [

	^SortedCollection new
		add: (
			ROBProduct new
				label: 'Green Marker';
				description: '';
				imageURL: (ROBFileLibrary / #penGreenJpg) ;
				price: 1;
				stargazerIdPosition: 3
		);
		add: (
			ROBProduct new
				label: 'Red Marker';
				description: '';
				imageURL: (ROBFileLibrary / #penRedJpg) ;
				price: 6.80;
				stargazerIdPosition: 3
		);
		add: (
			ROBProduct new
				label: 'Gerble';
				description: '';
				imageURL: (ROBFileLibrary / #gerbleJpg) ;
				price: 18.80;
				stargazerIdPosition: 2
		);
		add: (
			ROBProduct new
				label: 'Grany';
				description: '';
				imageURL: (ROBFileLibrary / #granyJpg) ;
				price: 18.80;
				stargazerIdPosition: 2
		);
		add: (
			ROBProduct new
				label: 'Petits Ecolier';
				description: '';
				imageURL: (ROBFileLibrary / #petitEcolierJpg) ;
				price: 18.80;
				stargazerIdPosition: 2
		);
		add: (
			ROBProduct new
				label: 'Ricore';
				description: '';
				imageURL: (ROBFileLibrary / #ricoreJpg) ;
				price: 18.80;
				stargazerIdPosition: 4
		);
		add: (
			ROBProduct new
				label: 'Pespi';
				description: '';
				imageURL: (ROBFileLibrary / #pepsiJpg) ;
				price: 1.80;
				stargazerIdPosition: 4
		);
		yourself
]

{ #category : #accessing }
ROBProduct class >> imageUrl: imageName [
	^'http://car.mines-douai.fr/doc/imgs/', imageName
]

{ #category : #accessing }
ROBProduct class >> products [
	^products ifNil: [  products := self roboshopDemoProducts ]
]

{ #category : #'as yet unclassified' }
ROBProduct class >> reset [
	products := nil
]

{ #category : #accessing }
ROBProduct class >> roboshopDemoProducts [

	^SortedCollection new
		add: (
			ROBProduct new
				label: 'Kylii';
				description: '';
				imageURL: (ROBFileLibrary / #peintureSmallJpg) ;
				price: 1;
				stargazerIdPosition: 3
		);
		add: (
			ROBProduct new
				label: 'Onyme';
				description: '';
				imageURL: (ROBFileLibrary / #onymeJpg) ;
				price: 1;
				stargazerIdPosition: 2
		);
		add: (
			ROBProduct new
				label: 'Zetes-Glass';
				description: '';
				imageURL: (ROBFileLibrary / #glassesJpg) ;
				price: 1;
				stargazerIdPosition: 4
		);
		yourself
]

{ #category : #comparing }
ROBProduct >> <= aProduct [
	^self label <= aProduct label
]

{ #category : #accessing }
ROBProduct >> description [
	^ description
]

{ #category : #accessing }
ROBProduct >> description: anObject [
	description := anObject
]

{ #category : #accessing }
ROBProduct >> imageURL [
	^ imageURL
]

{ #category : #accessing }
ROBProduct >> imageURL: anObject [
	imageURL := anObject
]

{ #category : #accessing }
ROBProduct >> label [
	^ label
]

{ #category : #accessing }
ROBProduct >> label: anObject [
	label := anObject
]

{ #category : #accessing }
ROBProduct >> price [
	^ price
]

{ #category : #accessing }
ROBProduct >> price: anObject [
	price := anObject
]

{ #category : #accessing }
ROBProduct >> stargazerIdPosition [
	^ stargazerIdPosition
]

{ #category : #accessing }
ROBProduct >> stargazerIdPosition: anObject [
	stargazerIdPosition := anObject
]
