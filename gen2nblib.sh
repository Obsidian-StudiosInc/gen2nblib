#!/bin/bash
# Copyright 2016 Obsidian-Studios, Inc.
# Author William L. Thomson Jr.
#        wlt@o-sinc.com
#
# Distributed under the terms of The GNU Public License v3.0 (GPLv3)
#
# Generate Netbeans library xml files for all Java libraries installed
# on a Gentoo/Funtoo based system

NBV="8.2"
NB_PATH="${HOME}/.netbeans/${NBV}/config/org-netbeans-api-project-libraries/Libraries"

if [[ ! -d "${NB_PATH}" ]]; then
	mkdir -p "${NB_PATH}" || exit 1
fi

write_xml() {
	local PKG_FILE
	local PKG_NAME

	PKG_NAME=$( basename "${1}" )
	PKG_FILE="${NB_PATH}/${PKG_NAME}.xml"

	[[ -f "${PKG_FILE}" ]] && rm "${PKG_FILE}"

	[[ ! -d "${1}/lib" ]] && continue

	local JARS
	JARS=( $(find "${1}/lib" -type f -name "*.jar" -print ) )

# Write xml
	echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<library xmlns=\"http://www.netbeans.org/ns/library-declaration/3\" version=\"3.0\">
    <name>${PKG_NAME}</name>
    <type>j2se</type>
    <display-name>${PKG_NAME}</display-name>
    <volume>
        <type>classpath</type>" >> "${PKG_FILE}"
	# Add jars
	for jar in "${JARS[@]}"; do
		echo "        <resource>jar:file:${jar}!/</resource>" \
			>> "${PKG_FILE}"
	done
	echo "    </volume>
    <volume>
        <type>src</type>" >> "${PKG_FILE}"
	local SRC_ZIP
	SRC_ZIP="${1}/sources/${PKG_NAME//-[0-9 -].*/}-src.zip"
	if [[ -f "${SRC_ZIP}" ]] ; then
		echo "        <resource>jar:file:${SRC_ZIP}!/</resource>" \
			>> "${PKG_FILE}"
	fi
	echo "    </volume>
    <volume>
        <type>javadoc</type>" >> "${PKG_FILE}"
	if [[ -L "${1}/api" ]] ; then
		echo "        <resource>file:$( readlink -f "${1}/api" )!/</resource>" \
			>> "${PKG_FILE}"
	fi
	echo "    </volume>
    <volume>
        <type>maven-pom</type>
    </volume>
    <properties/>
</library>"  >> "${PKG_FILE}"
}

PKGS=( $( find /usr/share -type f -name package.env -exec dirname {} \; ) )

for pkg in "${PKGS[@]}"; do
	write_xml "${pkg}"
done
