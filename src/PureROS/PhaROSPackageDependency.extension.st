Extension { #name : #PhaROSPackageDependency }

{ #category : #'*PureROS' }
PhaROSPackageDependency classSide >> kompai [ 
	^ self pureROSPackage: #PureROSNodeletsKompai.
]

{ #category : #'*PureROS' }
PhaROSPackageDependency classSide >> mapFuser [
	^ self pureROSPackage: #PureROSNodeletsCaire
]

{ #category : #'*PureROS' }
PhaROSPackageDependency classSide >> movement [
	^ self pureROSPackage: #PureROSNodeletsMovement.
]

{ #category : #'*PureROS' }
PhaROSPackageDependency classSide >> pureROSPackage: aPackageName [
	^ self new 
			    packageName: aPackageName;
			     configurationOfName: #ConfigurationOfPureROS ; 
			     url: 'http://car.mines-douai.fr/squeaksource/Pure'; 
			     needsCredentials;
			     yourself.
]

{ #category : #'*PureROS' }
PhaROSPackageDependency classSide >> pureros [
	^ self pureROSPackage: #default.
]
