TEMPLATE = subdirs

# Directories
SUBDIRS += \
	Analyzer \
	BinarySearcher \
	Bookmarks \
	BreakpointManager \
	CheckVersion \
	DebuggerCore \
	DumpState \
	Environment \
	FunctionDB \
	FunctionFinder \
	HardwareBreakpoints \
	OpcodeSearcher \
	References \
	ROPTool \
	SessionManager \
	StringSearcher \
	SymbolViewer

unix {
	!macx {
		SUBDIRS += ELFBinaryInfo
		SUBDIRS += HeapAnalyzer
	}

	linux-* {
		SUBDIRS += OpenFiles 
	}
}
