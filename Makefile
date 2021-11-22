VENV ?= .venv
TMP_DIR ?= $(HOME)/.tmp
TARGET_IMAGE ?= ubuntu2004
PYTHON_VERSION ?= 3.8

.PHONY: setup

$(VENV):
	python3 -m venv $(VENV)
	$(VENV)/bin/pip install --upgrade pip setuptools wheel pip-tools
	$(VENV)/bin/pip install -r requirements.txt

requirements.txt: requirements.in
	$(VENV)/bin/pip-compile

clean:
	rm -rf $(VENV)
	rm -fr dist/
	rm -fr .eggs/
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.egg' -exec rm -rf {} +

ansible-requirements:
	ansible-galaxy install -r requirements.yml

sanity-test: ansible-requirements
	ansible-test sanity --docker default --python $(PYTHON_VERSION)

unit-test: ansible-requirements
	ansible-test units --docker $(TARGET_IMAGE) --python $(PYTHON_VERSION)

integration-test: ansible-requirements
	ANSIBLE_KEEP_REMOTE_FILES=1 ansible-test integration \
		--docker $(TARGET_IMAGE) \
		--python $(PYTHON_VERSION) \
		--allow-destructive \
		--docker-terminate never

test: sanity-test integration-test

shell:
	ansible-test shell --docker $(TARGET_IMAGE) --python $(PYTHON_VERSION) --debug