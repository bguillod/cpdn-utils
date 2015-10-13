#!/bin/bash
# print a short version of ncdump -h
ncdump -h $1 | grep -P -v '\t\t'
