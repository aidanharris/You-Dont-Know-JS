#!/usr/bin/env bash
for d in "$1"/*
do
	find "$d" -name "*.md" -not -path "*README*.md" -not -path "*preface*.md"	
done
