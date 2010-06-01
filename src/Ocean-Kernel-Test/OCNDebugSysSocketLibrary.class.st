Class {
	#name : #OCNDebugSysSocketLibrary,
	#superclass : #OCNSysSocketLibrary,
	#category : #'Ocean-Kernel-TestSupport'
}

{ #category : #compiling }
OCNDebugSysSocketLibrary class >> buildDebugSysSocketLibraryDylibFile [
	"self buildDebugSysSocketLibraryDylibFile"
	
	OSProcess waitForCommand: 
		'cd ', SmalltalkImage current imagePath, ' ; ', 
		'gcc ', self debugSysSocketLibraryCFileName, ' -c;', 
		'libtool -dynamic ', self debugSysSocketLibraryOFileName, ' -o ', self debugSysSocketLibraryDylibFileName, ' -lSystem'
	"
Compilation :
	gcc debugSysSocketLibrary.c -c 
	libtool -dynamic debugSysSocketLibrary.o -o debugSysSocketLibrary.dylib -lSystem

Put the debugSysSocketLibrary.dylib in the .image directory
"


]

{ #category : #accessing }
OCNDebugSysSocketLibrary class >> debugSysSocketLibraryBaseName [
	^'debugSysSocketLibrary'
]

{ #category : #accessing }
OCNDebugSysSocketLibrary class >> debugSysSocketLibraryCFileContent [
^'#include <errno.h>
#include <netdb.h>
#include <netinet/in.h>	// struct sockaddr_in
#include <signal.h>		// signal
#include <stdlib.h>		// exit
#include <stdio.h>		// printf
#include <string.h>		// bzero
#include <stdarg.h>		// va_list
#include <time.h>

#define LOGFILEPATH "', SmalltalkImage current imagePath , '/ocean.log"


void o_log_date(void) {
	FILE *logFile = NULL;
	time_t clock= time(NULL);
    logFile = fopen(LOGFILEPATH,"a");
	fprintf(logFile,"@@ %s",ctime(&clock));	
    fclose(logFile);	
}

void o_log(char const *format, ...)
{
	FILE *logFile = NULL;
	va_list ap;
	va_start(ap, format);
    logFile = fopen(LOGFILEPATH,"a");
	vfprintf(logFile,format,ap);	
    fclose(logFile);
}


int myPrintTabOfInt(int* tab,int size) {
	int i, sizeLimited = size, res = 0;
	if( sizeLimited > 20 )
		sizeLimited = 20;
	
	// o_log("  Int [%i] tab :  ",sizeof(int));
	for(i = 0 ; i < sizeLimited ; i++) {
		res += tab[i];
		o_log("%i ",ntohl(tab[i]));
	}
	o_log("\t[%i int\n",sizeLimited);
	return res;
}

int myPrintTabOfShort(short* tab,int size) {
	int i, sizeLimited = size, res = 0;
	if( sizeLimited > 20 )
		sizeLimited = 20;
	
	// o_log("  Short [%i] tab :  ",sizeof(short));
	for(i = 0 ; i < sizeLimited ; i++) {
		res += tab[i];
		o_log("%i ",ntohs(tab[i])); //ntohs ! http://betterexplained.com/articles/understanding-big-and-little-endian-byte-order/
	}
	o_log("\t[%i short]\n",sizeLimited);
	return res;
}

int myPrintTabOfByte(char* tab,int size) {
	int i, sizeLimited = size, res = 0;
	if( sizeLimited > 20 )
		sizeLimited = 20;
	
	// o_log("  unsigned char [%i] tab :  ",sizeof(unsigned char));
	for(i = 0 ; i < sizeLimited ; i++) {
		res += tab[i];
		o_log("%i ",tab[i]);
	}
	o_log("\t[%i byte]\n",sizeLimited);
	return res;
}

int myPrintTabOfChar(char* tab,int size) {
	int i, sizeLimited = size, res = 0;
	if( sizeLimited > 20 )
		sizeLimited = 20;
	
	// o_log("  unsigned char [%i] tab :  ",sizeof(unsigned char));
	for(i = 0 ; i < sizeLimited ; i++) {
		res += tab[i];
		o_log("%c ",tab[i]);
	}
	o_log("\t[%i char]\n",sizeLimited);
	return res;
}


int connect_for_debug(int socket, const struct sockaddr *address, socklen_t address_len) {
	int i;
	short * p_address = (short *) address;
	o_log_date();
	o_log("++ connect_for_debug [%i]\n",address_len);
	o_log("\tsocket: %i\n",socket);
	o_log("\tsockaddr:\n");
	o_log("\t\tsa_family: ");myPrintTabOfShort((short *)address,1);
	o_log("\t\tport: ");myPrintTabOfShort((short *)address+1,1);
	o_log("\t\tsa_data: ");myPrintTabOfByte((char *)address+4,address_len-4);
	o_log("-- connect_for_debug\n");
	return connect(socket,address,address_len);
}

ssize_t send_for_debug(int socket, const void *buffer, size_t length, int flags) {
	int i;
	o_log_date();
	o_log("++ send_for_debug\n");
	o_log("\tsocket: %i\n",socket);
	o_log("\tbuffer: ");myPrintTabOfChar((char *)buffer,length);
	o_log("\tflags: %i\n",flags);
	o_log("-- send_for_debug\n");
	return send(socket,buffer,length,flags);
}'


]

{ #category : #accessing }
OCNDebugSysSocketLibrary class >> debugSysSocketLibraryCFileName [
	^self debugSysSocketLibraryBaseName, '.c'
]

{ #category : #accessing }
OCNDebugSysSocketLibrary class >> debugSysSocketLibraryDylibFileName [
	^self debugSysSocketLibraryBaseName, '.dylib'
]

{ #category : #accessing }
OCNDebugSysSocketLibrary class >> debugSysSocketLibraryOFileName [
	^self debugSysSocketLibraryBaseName, '.o'
]

{ #category : #'file handling' }
OCNDebugSysSocketLibrary class >> deleteAllGeneratedFiles [
	self deleteDebugSysSocketLibraryCFile.
	self deleteDebugSysSocketLibraryDylibFile.
	self deleteDebugSysSocketLibraryOFile 
]

{ #category : #'file handling' }
OCNDebugSysSocketLibrary class >> deleteDebugSysSocketLibraryCFile [
	FileDirectory default deleteFileNamed: self debugSysSocketLibraryCFileName ifAbsent: []
	
]

{ #category : #'file handling' }
OCNDebugSysSocketLibrary class >> deleteDebugSysSocketLibraryDylibFile [
	FileDirectory default deleteFileNamed: self debugSysSocketLibraryDylibFileName ifAbsent: []
	
]

{ #category : #'file handling' }
OCNDebugSysSocketLibrary class >> deleteDebugSysSocketLibraryOFile [
	FileDirectory default deleteFileNamed: self debugSysSocketLibraryOFileName ifAbsent: []
	
]

{ #category : #'file handling' }
OCNDebugSysSocketLibrary class >> generateDebugSysSocketLibraryCFile [
	"self generateDebugSysSocketLibraryCFile"
	| debugSysSocketLibraryCFileStr |
	debugSysSocketLibraryCFileStr := FileDirectory default fileNamed: self debugSysSocketLibraryCFileName.
	[debugSysSocketLibraryCFileStr nextPutAll: self debugSysSocketLibraryCFileContent] ensure: [
		debugSysSocketLibraryCFileStr close]
]

{ #category : #initialization }
OCNDebugSysSocketLibrary class >> initialize [
	self rebuildDebugSysSocketLibraryDylibFile
]

{ #category : #compiling }
OCNDebugSysSocketLibrary class >> rebuildDebugSysSocketLibraryDylibFile [
	"self rebuildDebugSysSocketLibraryDylibFile"
	
	self deleteDebugSysSocketLibraryDylibFile.
	self deleteDebugSysSocketLibraryOFile.
	self deleteDebugSysSocketLibraryCFile.
	self generateDebugSysSocketLibraryCFile.
	self buildDebugSysSocketLibraryDylibFile
]

{ #category : #'socket functions' }
OCNDebugSysSocketLibrary >> connectFunctionName [
	^'connect_for_debug'
]

{ #category : #accessing }
OCNDebugSysSocketLibrary >> libraryName [
	^SmalltalkImage current imagePath , '/debugSysSocketLibrary.dylib'

]

{ #category : #'as yet unclassified' }
OCNDebugSysSocketLibrary >> printTab: aByteArray size: size [
"int myPrintTab(int* tab,int size);"

	| result alienMethod |
	result := Alien new: 4.
	alienMethod := self alienMethodNamed:'myPrintTab'.
	alienMethod
		primFFICallResult: result
		with: aByteArray 
		with: size.	
	^ result
]

{ #category : #'as yet unclassified' }
OCNDebugSysSocketLibrary >> printTabOfByte: aByteArray size: size [
"int myPrintTab(int* tab,int size);"

	| result alienMethod |
	result := Alien new: 4.
	alienMethod := self alienMethodNamed:'myPrintTabOfByte'.
	alienMethod
		primFFICallResult: result
		with: aByteArray 
		with: size.	
	^ result
]

{ #category : #'as yet unclassified' }
OCNDebugSysSocketLibrary >> printTabOfChar: anArrayOfChar size: size [

	| result alienMethod |
	result := Alien new: 4.
	alienMethod := self alienMethodNamed:'myPrintTabOfChar'.
	alienMethod
		primFFICallResult: result
		with: anArrayOfChar 
		with: size.	
	^ result
]

{ #category : #'as yet unclassified' }
OCNDebugSysSocketLibrary >> printTabOfInt: aByteArray size: size [
"int myPrintTab(int* tab,int size);"

	| result alienMethod |
	result := Alien new: 4.
	alienMethod := self alienMethodNamed:'myPrintTabOfInt'.
	alienMethod
		primFFICallResult: result
		with: aByteArray 
		with: size.	
	^ result
]
