VENV_DIR?=.venv
VENV_ACTIVATE?=$(VENV_DIR)/bin/activate
WITH_VENV=. $(VENV_ACTIVATE);

$(VENV_ACTIVATE): requirements*.txt
	test -f $@ || virtualenv --python=python2.7 $(VENV_DIR)
	$(WITH_VENV) pip install --upgrade -r requirements.txt
	$(WITH_VENV) pip install --upgrade -r requirements-dev.txt
	$(WITH_VENV) pip install --upgrade -r requirements-packaging.txt
	touch $@

.PHONY: venv
venv: $(VENV_ACTIVATE)

.PHONY: test
test: $(VENV_ACTIVATE)
	$(WITH_VENV) py.test tests/

.PHONY: tox
tox: $(VENV_ACTIVATE)
	$(WITH_VENV) TOXENV=py27 tox --develop

.PHONY: authors
authors:
	git shortlog --numbered --summary --email | cut -f 2 > AUTHORS

readme.html: README.rst
	$(WITH_VENV) rst2html.py README.rst > readme.html

# Ensure the sdist builds correctly
.PHONY: sdist
sdist: authors $(VENV_ACTIVATE) readme.html
	$(WITH_VENV) python setup.py sdist bdist_wheel

.PHONY: clean
clean:
	python setup.py clean
	rm -rf build/
	rm -rf dist/
	rm -rf *.egg*
	find . -type f -name '*.pyc' -delete
	rm -rf htmlcov/

.PHONY: teardown
teardown:
	rm -rf .tox $(VENV_DIR)/
