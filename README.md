# python-2.4-docker

Docker image build recipe for CPython 2.4.6, mainly for legacy Python 2.4 syntax/compile checks.

## Purpose

This repository builds a small Docker image containing CPython 2.4.6.

The intended use case is checking whether old Python code can still be parsed/compiled by Python 2.4. This is useful for legacy embedded-Python projects such as games (e.g., [AdvCiv-SAS](https://github.com/wonderingabout/AdvCiv-SAS)), tools, or applications that still depend on Python 2.4.

This image is not meant for modern Python development.

## Image

Planned GHCR image:

```text
ghcr.io/wonderingabout/python-2.4:2.4.6
```

For long-term CI use, prefer pinning the image by digest instead of using `latest`.

## Build locally

```bash
docker build -t python-2.4:local .
docker run --rm python-2.4:local python -V
```

Expected version:

```text
Python 2.4.6
```

## Notes

The image currently builds CPython 2.4.6 from the official Python.org source archive.

The GitHub Actions workflow is manual-only at first. A monthly schedule can be added after the Dockerfile is known to build reliably.
