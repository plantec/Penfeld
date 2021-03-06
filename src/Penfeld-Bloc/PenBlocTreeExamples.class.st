Class {
	#name : #PenBlocTreeExamples,
	#superclass : #Object,
	#category : #'Penfeld-Bloc-Examples'
}

{ #category : #examples }
PenBlocTreeExamples class >> example [
	| model |
	model := PenTree new.
	model root: (self nodeForClass: PenComponent).
	model dresser: PenBlocTreeDresser new.
	model sortingBlock: [ :a :b | a key < b key ].
	model open
]

{ #category : #examples }
PenBlocTreeExamples class >> exampleExpandAll [
	| component |
	component := PenTree new.
	component root: (self nodeForClass: PenComponent).
	component dresser: PenBlocTreeDresser new.
	component sortingBlock: [ :a :b | a key < b key ].
	component expandAll.
	component open 
]

{ #category : #examples }
PenBlocTreeExamples class >> examplePropagateClosure [
	| component |
	component := PenTree new.
	component root: (self nodeForClass: PenComponent).
	component dresser: PenBlocTreeDresser new.
	component sortingBlock: [ :a :b | a key < b key ].
	component expandAll.
	component showRoot: true.
	component propagateCollapse: true.
	component open
]

{ #category : #examples }
PenBlocTreeExamples class >> exampleWithRoot [
	| component |
	component := PenTree new.
	component root: (self nodeForClass: PenComponent).
	component showRoot: true.
	component dresser: PenBlocTreeDresser new.
	component sortingBlock: [ :a :b | a key < b key ].
	component open
]

{ #category : #testing }
PenBlocTreeExamples class >> isDeprecated [ 
	^ true
]

{ #category : #'examples - instance creation' }
PenBlocTreeExamples class >> nodeForClass: aClass [
	| node |
	node := PenTreeNode new.
	node key: aClass name asSymbol.
	node dresser: PenBlocTreeNodeDresser new.
	node content: (PenLabel new text: aClass name).
	aClass subclasses do: [ :subclass | 
		node addNode: (self nodeForClass: subclass)].
	^ node
]

{ #category : #opening }
PenBlocTreeExamples class >> spaceBackground [
	^ Color r: 128 g: 128 b: 128 range: 255
]

{ #category : #'see class side' }
PenBlocTreeExamples >> seeClassSide [
]
