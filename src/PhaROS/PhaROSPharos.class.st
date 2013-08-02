Class {
	#name : #PhaROSPharos,
	#superclass : #PhaROSPackage,
	#category : #'PhaROS-PackageManager'
}

{ #category : #'as yet unclassified' }
PhaROSPharos class >> install [
	PhaROSPackageManager new install: self instance linkinVM: '~/VMS/CogVM'
]

{ #category : #'as yet unclassified' }
PhaROSPharos >> author [
	^ Author fullName
]

{ #category : #accessing }
PhaROSPharos >> description [
	^' pharos package'
]

{ #category : #'as yet unclassified' }
PhaROSPharos >> location [
	^ '/home/kompai1/workspace/'
]

{ #category : #'as yet unclassified' }
PhaROSPharos >> name [
	^ 'pharos'
]

{ #category : #'as yet unclassified' }
PhaROSPharos >> version [
	^ '0.1.0'
]
