!classDefinition: #I category: #'Cuarta Actividad'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cuarta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Cuarta Actividad'!
I class
	instanceVariableNames: 'next previous'!

!I class methodsFor: 'as yet unclassified' stamp: 'PO 3/29/2018 19:36:53'!
- aPeanoNumber
	self error: self descripcionDeErrorDeNumerosNegativosNoSoportados ! !

!I class methodsFor: 'as yet unclassified' stamp: 'PB 3/30/2018 14:44:59'!
/ aPeanoNumber
	aPeanoNumber = I
	ifTrue:[
		"Same number"
		^I
		]
	ifFalse: [
		self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor 
		]! !

!I class methodsFor: 'as yet unclassified' stamp: 'PB 3/30/2018 19:55:07'!
// aPeanoNumber
	^aPeanoNumber previous! !

!I class methodsFor: 'as yet unclassified' stamp: 'PB 3/30/2018 14:44:27'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'! !

!I class methodsFor: 'as yet unclassified' stamp: 'PO 3/29/2018 19:36:14'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'Numeros negativos no soportados'! !

!I class methodsFor: 'as yet unclassified' stamp: 'PO 3/22/2018 20:59:09'!
next
	"comment stating purpose of message"

	| |
	^II! !

!I class methodsFor: 'as yet unclassified' stamp: 'PB 3/30/2018 19:59:45'!
previous
	self error: self  descripcionDeErrorDeNumerosNegativosNoSoportados! !


!I class methodsFor: 'nil' stamp: 'PO 3/26/2018 20:56:20'!
* aPeanoNumber
	"comment stating purpose of message"

	| |
	^aPeanoNumber! !

!I class methodsFor: 'nil' stamp: 'PO 3/26/2018 20:56:27'!
+ aPeanoNumber
	"comment stating purpose of message"

	| |
	^aPeanoNumber next! !

!I class methodsFor: 'nil' stamp: 'PO 3/26/2018 21:38:50'!
<= aPeanoNumber
	^true! !

I instVarNamed: 'next' put: II!
I instVarNamed: 'previous' put: nil!

!classDefinition: #II category: #'Cuarta Actividad'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cuarta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Cuarta Actividad'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'PB 3/30/2018 20:02:41'!
// aPeanoNumber
	^ (self previous // aPeanoNumber ) previous
	
! !

!II class methodsFor: 'as yet unclassified' stamp: 'PO 3/29/2018 19:35:51'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'! !

!II class methodsFor: 'as yet unclassified' stamp: 'PO 3/29/2018 19:39:12'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'Numeros negativos no soportados'! !

!II class methodsFor: 'as yet unclassified' stamp: 'PO 3/26/2018 20:44:54'!
next
	next = nil ifTrue: [
		next := self cloneNamed: self name , 'I'.
		next previous: self.
		].
	^next
	
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'PO 3/26/2018 20:44:01'!
previous
	^previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'PO 3/29/2018 19:01:52'!
previous: peanoNumber
	previous:=peanoNumber! !


!II class methodsFor: 'nil' stamp: 'PB 3/30/2018 14:16:02'!
* aPeanoNumber
	^aPeanoNumber + (previous * aPeanoNumber) ! !

!II class methodsFor: 'nil' stamp: 'PO 3/26/2018 20:56:31'!
+ aPeanoNumber
	^self previous + aPeanoNumber next! !

!II class methodsFor: 'nil' stamp: 'PB 3/30/2018 19:57:25'!
- aPeanoNumber
	^ aPeanoNumber // self
	! !

!II class methodsFor: 'nil' stamp: 'PB 3/30/2018 15:11:46'!
/ aPeanoNumber
	| |
	aPeanoNumber = I
	ifTrue: [
		^self
		] 
	ifFalse: [
	self <= aPeanoNumber 
		ifTrue:[
			"Both are equal or error"
			aPeanoNumber <= self
				"First Case: Both numbers are equal"
				ifTrue:[^I]
				"Second Case: Raise exception"
				ifFalse:[self error:self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor]
			] 
		ifFalse: [
			"self > aPeanoNumber > at least one substraction"
			| divisionParcial resta|
			resta := self - aPeanoNumber.
			(resta <= aPeanoNumber) & (resta ~= aPeanoNumber)
			"Coverting the case III/II and similar"
			ifTrue: [
				^I
				] 
			ifFalse: [
				divisionParcial := resta / aPeanoNumber.
				^divisionParcial next.				
				]
			]		
		] 
! !

!II class methodsFor: 'nil' stamp: 'PO 3/26/2018 21:18:43'!
<= aPeanoNumber
	aPeanoNumber = I ifTrue:[^self = I] ifFalse:[^self previous <= aPeanoNumber previous]! !

!II class methodsFor: 'nil' stamp: 'PB 3/30/2018 13:39:44'!
removeAllSubsequent
next = nil
ifTrue:[]
ifFalse:[
	next removeAllSubsequent.
	next removeFromSystem.
	next := nil.
	]


! !

II instVarNamed: 'next' put: nil!
II instVarNamed: 'previous' put: I!