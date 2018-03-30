!classDefinition: #I category: #'Cuarta Actividad'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cuarta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Cuarta Actividad'!
I class
	instanceVariableNames: 'next'!

!I class methodsFor: 'as yet unclassified' stamp: 'PO 3/29/2018 19:36:53'!
- aPeanoNumber
	self error: self descripcionDeErrorDeNumerosNegativosNoSoportados ! !

!I class methodsFor: 'as yet unclassified' stamp: 'PO 3/29/2018 19:36:14'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'Numeros negativos no soportados'! !

!I class methodsFor: 'as yet unclassified' stamp: 'PO 3/22/2018 20:59:09'!
next
	"comment stating purpose of message"

	| |
	^II! !


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

!II class methodsFor: 'nil' stamp: 'PO 3/26/2018 21:09:28'!
- aPeanoNumber
	aPeanoNumber = I ifTrue: [^self previous] ifFalse:[^self previous - aPeanoNumber previous]
	! !

!II class methodsFor: 'nil' stamp: 'PO 3/29/2018 19:36:38'!
/ aPeanoNumber
	| | 
	self <= aPeanoNumber 
		ifTrue:[
			aPeanoNumber <= self
				ifTrue:[^I]
				ifFalse:[self error:self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor]
			] 
		ifFalse: [
			| divisionParcial resta|
			resta:=self - aPeanoNumber.
			resta <= aPeanoNumber
				ifTrue:[^I]
				ifFalse:[
					divisionParcial := resta / aPeanoNumber.
					^divisionParcial next
				]
			]! !

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

II instVarNamed: 'next' put: III!
II instVarNamed: 'previous' put: I!

!classDefinition: #III category: #'Cuarta Actividad'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cuarta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #'Cuarta Actividad'!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'as yet unclassified' stamp: 'PB 3/30/2018 14:16:10'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'! !

!III class methodsFor: 'as yet unclassified' stamp: 'PB 3/30/2018 14:16:10'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'Numeros negativos no soportados'! !

!III class methodsFor: 'as yet unclassified' stamp: 'PB 3/30/2018 14:16:10'!
next
	next = nil ifTrue: [
		next := self cloneNamed: self name , 'I'.
		next previous: self.
		].
	^next
	
	! !

!III class methodsFor: 'as yet unclassified' stamp: 'PB 3/30/2018 14:16:10'!
previous
	^previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'PB 3/30/2018 14:16:10'!
previous: peanoNumber
	previous:=peanoNumber! !


!III class methodsFor: 'nil' stamp: 'PB 3/30/2018 14:16:10'!
* aPeanoNumber
	^aPeanoNumber + (previous * aPeanoNumber) ! !

!III class methodsFor: 'nil' stamp: 'PB 3/30/2018 14:16:10'!
+ aPeanoNumber
	^self previous + aPeanoNumber next! !

!III class methodsFor: 'nil' stamp: 'PB 3/30/2018 14:16:10'!
- aPeanoNumber
	aPeanoNumber = I ifTrue: [^self previous] ifFalse:[^self previous - aPeanoNumber previous]
	! !

!III class methodsFor: 'nil' stamp: 'PB 3/30/2018 14:16:10'!
/ aPeanoNumber
	| | 
	self <= aPeanoNumber 
		ifTrue:[
			aPeanoNumber <= self
				ifTrue:[^I]
				ifFalse:[self error:self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor]
			] 
		ifFalse: [
			| divisionParcial resta|
			resta:=self - aPeanoNumber.
			resta <= aPeanoNumber
				ifTrue:[^I]
				ifFalse:[
					divisionParcial := resta / aPeanoNumber.
					^divisionParcial next
				]
			]! !

!III class methodsFor: 'nil' stamp: 'PB 3/30/2018 14:16:10'!
<= aPeanoNumber
	aPeanoNumber = I ifTrue:[^self = I] ifFalse:[^self previous <= aPeanoNumber previous]! !

!III class methodsFor: 'nil' stamp: 'PB 3/30/2018 14:16:10'!
removeAllSubsequent
next = nil
ifTrue:[]
ifFalse:[
	next removeAllSubsequent.
	next removeFromSystem.
	next := nil.
	]


! !

III instVarNamed: 'next' put: IIII!
III instVarNamed: 'previous' put: II!

!classDefinition: #IIII category: #'Cuarta Actividad'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cuarta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #'Cuarta Actividad'!
IIII class
	instanceVariableNames: 'next previous'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'PB 3/30/2018 14:16:11'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'PB 3/30/2018 14:16:11'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'Numeros negativos no soportados'! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'PB 3/30/2018 14:16:11'!
next
	next = nil ifTrue: [
		next := self cloneNamed: self name , 'I'.
		next previous: self.
		].
	^next
	
	! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'PB 3/30/2018 14:16:11'!
previous
	^previous! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'PB 3/30/2018 14:16:11'!
previous: peanoNumber
	previous:=peanoNumber! !


!IIII class methodsFor: 'nil' stamp: 'PB 3/30/2018 14:16:11'!
* aPeanoNumber
	^aPeanoNumber + (previous * aPeanoNumber) ! !

!IIII class methodsFor: 'nil' stamp: 'PB 3/30/2018 14:16:11'!
+ aPeanoNumber
	^self previous + aPeanoNumber next! !

!IIII class methodsFor: 'nil' stamp: 'PB 3/30/2018 14:16:11'!
- aPeanoNumber
	aPeanoNumber = I ifTrue: [^self previous] ifFalse:[^self previous - aPeanoNumber previous]
	! !

!IIII class methodsFor: 'nil' stamp: 'PB 3/30/2018 14:16:11'!
/ aPeanoNumber
	| | 
	self <= aPeanoNumber 
		ifTrue:[
			aPeanoNumber <= self
				ifTrue:[^I]
				ifFalse:[self error:self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor]
			] 
		ifFalse: [
			| divisionParcial resta|
			resta:=self - aPeanoNumber.
			resta <= aPeanoNumber
				ifTrue:[^I]
				ifFalse:[
					divisionParcial := resta / aPeanoNumber.
					^divisionParcial next
				]
			]! !

!IIII class methodsFor: 'nil' stamp: 'PB 3/30/2018 14:16:11'!
<= aPeanoNumber
	aPeanoNumber = I ifTrue:[^self = I] ifFalse:[^self previous <= aPeanoNumber previous]! !

!IIII class methodsFor: 'nil' stamp: 'PB 3/30/2018 14:16:11'!
removeAllSubsequent
next = nil
ifTrue:[]
ifFalse:[
	next removeAllSubsequent.
	next removeFromSystem.
	next := nil.
	]


! !

IIII instVarNamed: 'next' put: nil!
IIII instVarNamed: 'previous' put: III!