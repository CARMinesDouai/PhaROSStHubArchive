Class {
	#name : #PureROSPlottingExperiment,
	#superclass : #PureROSBasicExperiment,
	#instVars : [
		'plottingProcess'
	],
	#category : #PureROSExperiments
}

{ #category : #'configure-system' }
PureROSPlottingExperiment >> drawSquare [
	nil driveController drawSquare.
]

{ #category : #'configure-system' }
PureROSPlottingExperiment >> initialize [ 
	super initialize.	
	plottingProcess := Set new.
]

{ #category : #'configure-system' }
PureROSPlottingExperiment >> plot: aPlotSpecBlock [
	| builder |
	builder := PureROSPlotBuilder new.
	aPlotSpecBlock value: builder.
	plottingProcess add: ( self run: ({ 'rxtools' . 'rxplot' }, builder plottingLines asArray)).
]

{ #category : #'configure-system' }
PureROSPlottingExperiment >> teardown [ 
	super teardown .
	plottingProcess ifNotNil: [
	plottingProcess do: #finalize.
	plottingProcess removeAll.
	plottingProcess := nil.]
]
