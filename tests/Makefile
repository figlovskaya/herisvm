test:
	@echo 'running tests...'; \
	unset MAKEFLAGS; \
	set -e; \
	OBJDIR=${OBJDIR_scripts}; export OBJDIR; \
	env PATH="$OBJDIR_scripts:$SCRDIR_scripts:$$PATH" ${SH} ./test.sh

.include <mkc.mk>
