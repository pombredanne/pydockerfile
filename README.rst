.. image:: https://travis-ci.org/sbuss/pydockerfile.svg?branch=master
    :target: https://travis-ci.org/sbuss/pydockerfile

.. image:: https://codecov.io/github/sbuss/pydockerfile/coverage.svg?branch=master
    :target: https://codecov.io/github/sbuss/pydockerfile?branch=master

pydockerfile
============

``pydockerfile`` gives simplistic Dockerfile parsing. It performs no validation.


Installation
------------

.. code-block:: bash

    pip install pydockerfile

Usage
-----

.. code-block:: python

    import pydockerfile
    dockerfile = pydockerfile.parse_file('/path/to/Dockerfile')
    assert dockerfile.FROM
