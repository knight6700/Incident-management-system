#! /bin/bash

if ! `swiftlint ../` ; then 
	exit 1
fi

if ! `swiftformat ..` ; then 
	exit 1
fi

if ! fastlane tests ; then 
	exit 1
fi