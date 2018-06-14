#!/bin/bash

for f in *.ipynb; do NEW=${f%.ipynb}_FEEDBACK.ipynb; mv ${f} "${NEW}"; done
