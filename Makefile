# should always be at the top to be the default recipe
help::
	@echo "SkeletonGame Makefile usage:"


LINT_DIR:=lint

$(LINT_DIR):
	@# make the lint directory
	mkdir -p "$(LINT_DIR)"

help::
	@echo "    lint-compile - Compiles all Python files"

COMPILE_FILENAME:=$(LINT_DIR)/skeletongame_lint_$(shell date "+%s").log
# all files we want to lint
LINT_FILES:=./*.py \
			./SampleGame/*/*.py \
			./procgame/*/*.py \
			./tests/*/*.py \
			./tools/*/*.py

lint-compile: $(LINT_DIR)
	@python -m compileall $(LINT_FILES) 2>&1 > $(COMPILE_FILENAME) || echo "Errors found: check file $(COMPILE_FILENAME)"

help::
	@echo "    lint-clear - Clears all generated lint files"

lint-clear:
	rm -r "./$(LINT_DIR)"


help::
	@echo "    lint-ruff - checks codebase using ruff"

RUFF_FILENAME:=$(LINT_DIR)/ruff_lint_$(shell date "+%s").log
lint-ruff:
	@ruff check $(LINT_FILES) 2>&1 > $(RUFF_FILENAME) || echo "errors found: check file $(RUFF_FILENAME)"


help::
	@echo "    lint-ruff - Checks codebase using ruff and applies fixes to files with issues. Use sparingly."
lint-ruff-apply-fixes:
	@ruff check --fix $(LINT_FILES) 2>&1 > $(RUFF_FILENAME) || echo "Errors found: check file $(RUFF_FILENAME)"


help::
	@echo "    lint-pylint - checks codebase using pylint"

PYLINT_FILENAME:=$(LINT_DIR)/pylint_lint_$(shell date "+%s").log
lint-pylint:
	@pylint $(LINT_FILES) 2>&1 > $(PYLINT_FILENAME) || echo "Errors found: check file $(PYLINT_FILENAME)"


help::
	@echo "    lint-all - checks codebase using all available tools"
lint-all: lint-compile lint-ruff lint-pylint

