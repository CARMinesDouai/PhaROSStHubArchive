Extension { #name : #PhaROSPackageDependency }

{ #category : #'*StarGazer' }
PhaROSPackageDependency classSide >> stargazer [
	^ self new 
			    packageName: #StarGazer;
			     url: 'http://car.mines-douai.fr/squeaksource/Peripherics'; 
			     yourself.
]
