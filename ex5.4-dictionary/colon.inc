%macro colon 2
	%2:
	%ifdef firstDictionaryEntry
		dq firstDictionaryEntry
	%else
		dq 0
	%endif
	%define firstDictionaryEntry %2
	db %1, 0
%endmacro
