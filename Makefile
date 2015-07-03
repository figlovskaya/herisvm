PROJECTNAME =	herisvm
SUBPRJ      =	doc scripts:tests

MKC_REQD    =	0.29.0

NODEPS      =	*:test-tests

test : all-tests test-tests
	@:

.include <mkc.mk>
