Class {
	#name : #PenBlocCheckBoxDresser,
	#superclass : #PenBlocDresser,
	#instVars : [
		'ropedText',
		'pushed'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #styling }
PenBlocCheckBoxDresser >> backgroundColor: aValue [
	| box |
	box := self model interactor childNamed: #box.
	box background: aValue
]

{ #category : #styling }
PenBlocCheckBoxDresser >> border: aValue [
	| borderBuilder border |	
	borderBuilder := BlBorderBuilder new.	
		
	aValue do: 
	[ :property | 
		property isNumber 
		ifTrue: [ borderBuilder width: property ] 
		ifFalse: 
		[
			property isSymbol
			ifTrue: [ 
				(borderBuilder respondsTo: property) 
				ifTrue: [ borderBuilder perform: property ] 
			]
			ifFalse: [ 
				(property isKindOf: Color)
				ifTrue: [ borderBuilder paint: property ]
				ifFalse: [ self notYetImplemented ]
			]
		]
	].

	border := borderBuilder build.
	(self model interactor childNamed: #box) border: border.
	(self model interactor childNamed: #check) border: border.
]

{ #category : #styling }
PenBlocCheckBoxDresser >> color: aValue [
	| textElement |
	textElement := self model interactor childNamed: #text
		ifFound: [ :anElement | anElement ]
		ifNone: [ ^ self ].
	textElement text foreground: aValue
]

{ #category : #dressing }
PenBlocCheckBoxDresser >> doAfterApplyStyle [ 
	| var |

	"Position"
	var := self model position.
	var ifNotNil: [ self model interactor relocate: var ].

	"Width"
	var := self model width.
	var ifNotNil: [ self model interactor width: var pref ].
	
	"Height"
	var := self model height.
	var ifNotNil: [ self model interactor height: var pref ].
	
	"Apply roped text"
	self model interactor childNamed: #text
		ifFound: [ :anElement | anElement text: ropedText ]
		ifNone: [].
]

{ #category : #dressing }
PenBlocCheckBoxDresser >> doBeforeApplyStyle [ 
	(self model interactor childNamed: #check) visibility: (self model value
		ifTrue: [ BlVisibility visible ]
		ifFalse: [ BlVisibility gone ]).
		
	ropedText := self model text asRopedText

]

{ #category : #styling }
PenBlocCheckBoxDresser >> fontFamily: aValue [
	ropedText fontName: aValue first.
]

{ #category : #styling }
PenBlocCheckBoxDresser >> fontSize: aValue [
	| size box check |
	size := aValue value.

	ropedText fontSize: size.
	
	size := size - 3.
	
	box := self model interactor childNamed: #box.
	box size: size asPoint.
	
	check := box childNamed: #check.
	check geometry: (BlPolyline vertices: 
	{ 
		(0.18 * size) rounded @ (0.55 * size) rounded. 
		(0.36 * size) rounded @ (0.91 * size) rounded. 
		(0.91 * size) rounded @ (0.27 * size) rounded
	}).
]

{ #category : #dressing }
PenBlocCheckBoxDresser >> initInteractor [
	| box check |
	
	self model interactor: BlElement new.
	self model isLabelAfter
		ifTrue: [ self model interactor layout: BlLinearLayout horizontal leftToRight ]
		ifFalse: [ self model interactor layout: BlLinearLayout horizontal rightToLeft ].
	self model interactor constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	
	check := BlElement new.
	check geometry: (BlPolyline vertices: {2@6. 4@10. 10@3}). self flag: #moveInStyle.
	
	box := BlElement new.
	box addChild: check as: #check.
	box size: 14 @ 14. self flag: #moveInStyle.
	
	self model interactor addChild: box as: #box.
	self model interactor addChild: BlTextElement new as: #text.
	
	pushed := false.
	self model interactor when: BlMouseDownEvent do: [ :e | self whenMouseDownEvent ].
	self model interactor when: BlMouseUpEvent do: [ :e | self whenMouseUpEvent ].
	self model interactor when: BlMouseLeaveEvent do: [ :e | self whenMouseLeaveEvent ].
]

{ #category : #events }
PenBlocCheckBoxDresser >> whenMouseDownEvent [
	self model activatePseudoClass: #active.
	pushed := true.
]

{ #category : #events }
PenBlocCheckBoxDresser >> whenMouseLeaveEvent [
	pushed := false.
	self model deactivatePseudoClass: #active.
]

{ #category : #events }
PenBlocCheckBoxDresser >> whenMouseUpEvent [
	pushed ifFalse: [^ self].
	self model deactivatePseudoClass: #active.
	pushed := false.
]