"
BGSCar2012LogConverterToExcel convertToExcelFileAllLogsIn: (Smalltalk image imagePath, '/scripts/experiment/').

BGSCar2012LogConverterToExcel loadLog: (Smalltalk image imagePath, '/scripts/experiment/result-01.st').

"
Class {
	#name : #BGSCar2012LogConverterToExcel,
	#superclass : #Object,
	#category : #'BOSS-Exploration-CAR2012'
}

{ #category : #'log processing' }
BGSCar2012LogConverterToExcel class >> convertToExcelFileAllLogsIn: fullDirectoryName [
	|fs experimentFiles allExperimentValues |
	
	fs :=  FSFilesystem disk referenceTo: fullDirectoryName.
	experimentFiles := fs glob: [ :node| (node basename beginsWith: 'result') and: [ node extension = 'st' ]]. 
	
	allExperimentValues := Dictionary new.
	experimentFiles do: [ :experimentFile | 
		allExperimentValues at: experimentFile basename put: (self loadLog: experimentFile fullName) ].
	
	self writeExcelFile: (fs / fs basename, 'xml') with: allExperimentValues.
	
]

{ #category : #'log processing' }
BGSCar2012LogConverterToExcel class >> loadLog: fullFileName [
	|stream values|
	stream := FileStream fileNamed: fullFileName.
	stream readOnly.
	values := OrderedCollection new.
	
	[ stream atEnd ] whileFalse: [ 
		| line |
		line := stream nextLine.
		(line first = ${) ifTrue: [
			values add: (Compiler evaluate: line)
		] ifFalse: [ 
			values add: (Array with: line)
		]
	].
	^values
	
]

{ #category : #'excel writing' }
BGSCar2012LogConverterToExcel class >> writeExcelFile: resultFileRef with: experimentValuesDict [
	| stream |
	
	stream := resultFileRef writeStream.
	self writeHeaderOn: stream.
	self writeStatisticsSpreadSheetOfValues: experimentValuesDict on: stream.
	experimentValuesDict keys sort do: [ :spreadSheetName |
		self writeSpreadSheetNamed: spreadSheetName withValues: (experimentValuesDict at: spreadSheetName) on: stream ].
	self writeFooterOn: stream.
	stream close
]

{ #category : #'excel writing' }
BGSCar2012LogConverterToExcel class >> writeFooterOn: stream [
	
	stream nextPutAll: '</Workbook>'
]

{ #category : #'excel writing' }
BGSCar2012LogConverterToExcel class >> writeHeaderOn: stream [
	
	stream nextPutAll: '<?xml version="1.0"?>';lf;
		nextPutAll: '<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:html="http://www.w3.org/TR/REC-html40">'; lf
]

{ #category : #'excel writing' }
BGSCar2012LogConverterToExcel class >> writeSpreadSheetNamed: spreadSheetName withValues: values on: stream [
	
	stream nextPutAll: '<Worksheet ss:Name="';
		nextPutAll: spreadSheetName;
		nextPutAll: '">'; lf;
		nextPutAll: '<Table>'; lf.
		
	values do: [ :row | 
		stream nextPutAll: '   <Row>'; lf.
		
		row do: [ :value | 
			stream nextPutAll: '      <Cell>'.
			self writeValue: value on: stream.
			stream nextPutAll: '</Cell>';lf.
		].
		stream nextPutAll: '   </Row>'; lf.
	].

	stream nextPutAll: '</Table>'; lf;
		nextPutAll: '</Worksheet>'; lf
]

{ #category : #'excel writing' }
BGSCar2012LogConverterToExcel class >> writeStatisticsSpreadSheetOfValues: experimentValuesDict on: stream [
	
	stream nextPutAll: '<Worksheet ss:Name="';
		nextPutAll: 'Statistics';
		nextPutAll: '">'; lf;
		nextPutAll: '<Table>'; lf;
		nextPutAll: '   <Row>'; lf;
		nextPutAll: '      <Cell><Data ss:Type="String">nbOfRobots</Data></Cell>';lf;
		nextPutAll: '      <Cell><Data ss:Type="String">nbOfSteps</Data></Cell>';lf;
		nextPutAll: '   </Row>'; lf.
	
	experimentValuesDict keys sort do: [ :spreadSheetName |
		stream nextPutAll: '   <Row>'; lf.
		stream nextPutAll: '<Cell ss:Formula="=''';
			nextPutAll: spreadSheetName;
			nextPutAll: '''!R4C1"><Data ss:Type="Number"></Data></Cell>';lf;
			nextPutAll: '<Cell ss:Formula="=MAX(''';
			nextPutAll: spreadSheetName;
			nextPutAll: '''!C1)"><Data ss:Type="Number"></Data></Cell>';
			nextPutAll: '   </Row>'; lf.
	].

	stream 	nextPutAll: '</Table>';lf;
		nextPutAll: '</Worksheet>'; lf
]

{ #category : #'excel writing' }
BGSCar2012LogConverterToExcel class >> writeValue: value on: stream [
	|type|
	
	value isNumber 
		ifTrue: [ type := 'Number' ]
		ifFalse: [ type := 'String' ].
	
	stream nextPutAll: '<Data ss:Type="';
		nextPutAll: type;
		nextPutAll: '">';
		nextPutAll: value printString;
		nextPutAll: '</Data>'
]
