#!/bin/sh -e

################################################################################
##
##  Licensed to the Apache Software Foundation (ASF) under one or more
##  contributor license agreements.  See the NOTICE file distributed with
##  this work for additional information regarding copyright ownership.
##  The ASF licenses this file to You under the Apache License, Version 2.0
##  (the "License"); you may not use this file except in compliance with
##  the License.  You may obtain a copy of the License at
##
##      http://www.apache.org/licenses/LICENSE-2.0
##
##  Unless required by applicable law or agreed to in writing, software
##  distributed under the License is distributed on an "AS IS" BASIS,
##  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
##  See the License for the specific language governing permissions and
##  limitations under the License.
##
################################################################################

#
# Usage: checkAllPlayerGlobals "Apache Flex dir"
#
# This script should be used to check all versions of playerglobal.swc in an
# Apache Flex SDK for Mac OSX
# If a player global is missing to it will be downloaded form the Adobe site.

# Process the parameters.

IDE_SDK_DIR="$1"
if [ "${IDE_SDK_DIR}" = "" ] ; then
    echo Usage: $0 "Apache Flex directory"
    exit 1;
fi

echo The Apache Flex directory for the IDE is "$IDE_SDK_DIR"

# If this is an Apache Flex dir then there should be a NOTICE file.

if [ ! -f "${IDE_SDK_DIR}/NOTICE" ]
then
    echo ${IDE_SDK_DIR} does not appear to be an Apache Flex distribution.
    exit 1;
fi

agreeLicense()
{
	echo
	echo Playerglobal.swc is part of the Adobe Flash Player and is licensed
	echo "under the the Flash Player end user license agreement (EULA)."
	echo
	echo The 10.2 and 10.3 Flash Player EULA is specified here:
	echo http://www.adobe.com/products/eulas/pdfs/PlatformClients_PC_WWEULA_Combined_20100108_1657.pdf
	echo
	echo The 11.X Flash Player EULA is specified here:
	echo http://www.adobe.com/products/eulas/pdfs/PlatformClients_PC_WWEULA-MULTI-20110809_1357.pdf
	echo
	echo In addition to the Adobe EULA license terms, you also agree to be bound by the third-party
	echo terms specified here:
	echo http://www.adobe.com/products/eula/third_party/
	echo
	echo Adobe recommends that you review all licensing terms.
	echo
	echo "Please type Y to agree to terms of the license >"
	
	read -n 1 accept
	echo
		
	if [[ "${accept}" = "Y" || "${accept}" = "y" ]]
	then
	   echo License accepted
	else
		exit 1;
	fi
}

downloadPlayerGlobal()
{
    version=$1
    playerGlobalDir="${IDE_SDK_DIR}/frameworks/libs/player/${version}"
    playerGlobalSWC="${playerGlobalDir}/playerglobal.swc"
    MD5check=$2
    AdobeURL=$3
    
	mkdir -p "${playerGlobalDir}"
	if [ ! -f "${playerGlobalSWC}" ]
	then
	    echo Downloading player global ${version}
	    curl ${AdobeURL} > "${playerGlobalSWC}"
	else
		echo Player global ${version} exists
	fi
	
	MD5hash=`md5 -q "${playerGlobalSWC}"`
	
	if [ ${MD5check} == ${MD5hash} ]
	then
		echo MD5 hash correct
	else
		echo MD5 hash incorrect
        echo Downloading player global ${version}
        curl ${AdobeURL} > "${playerGlobalSWC}"
	fi
}

agreeLicense

# Note Adobe releases new versions of playerglobal.swf so if your checksum is wrong it may mean you just don't have the latest

downloadPlayerGlobal 10.2 aa7d785dd5715626201f5e30fc1deb51 http://fpdownload.macromedia.com/get/flashplayer/installers/archive/playerglobal/playerglobal10_2.swc
downloadPlayerGlobal 10.3 6092b3d4e2784212d174ca10904412bd http://fpdownload.macromedia.com/get/flashplayer/installers/archive/playerglobal/playerglobal10_3.swc
downloadPlayerGlobal 11.0 5f5a291f02105cd83fb582b76646e603 http://fpdownload.macromedia.com/get/flashplayer/updaters/11/playerglobal11_0.swc
downloadPlayerGlobal 11.1 e3a0e0e8c703ae5b1847b8ac25bbdc5f http://fpdownload.macromedia.com/get/flashplayer/updaters/11/playerglobal11_1.swc
downloadPlayerGlobal 11.2 c544a069518897880e0d732457b6fdeb http://fpdownload.macromedia.com/get/flashplayer/updaters/11/playerglobal11_2.swc
downloadPlayerGlobal 11.3 e2a9ee439d9660feaf756aa05e7e6412 http://fpdownload.macromedia.com/get/flashplayer/updaters/11/playerglobal11_3.swc
downloadPlayerGlobal 11.4 e15587856cdb5e21fa1acb6b0610a032 http://fpdownload.macromedia.com/get/flashplayer/updaters/11/playerglobal11_4.swc
downloadPlayerGlobal 11.5 00384b24157442c59ca5d625ecfd11a2 http://fpdownload.macromedia.com/get/flashplayer/updaters/11/playerglobal11_5.swc
downloadPlayerGlobal 11.6 1b841a0a26ada3e5da26eb70c32ab263 http://fpdownload.macromedia.com/get/flashplayer/updaters/11/playerglobal11_6.swc
downloadPlayerGlobal 11.7 12656571c57b2ad641838e5695a00e27 http://fpdownload.macromedia.com/get/flashplayer/updaters/11/playerglobal11_7.swc
downloadPlayerGlobal 11.8 35bc69eec5091f70e221b4e63b66b60f http://fpdownload.macromedia.com/get/flashplayer/updaters/11/playerglobal11_8.swc
downloadPlayerGlobal 11.9 d18244c3c00c61a41f2d4d791d09fedb http://fpdownload.macromedia.com/get/flashplayer/updaters/11/playerglobal11_9.swc
downloadPlayerGlobal 12.0 4db4e934f39f774ba68fcd9a79654971 http://fpdownload.macromedia.com/get/flashplayer/updaters/12/playerglobal12_0.swc
downloadPlayerGlobal 13.0 b824fb3db644d065bc27cae2382eb361 http://fpdownload.macromedia.com/get/flashplayer/updaters/13/playerglobal13_0.swc
downloadPlayerGlobal 14.0 0d7aa820d62ba76fa7bc353ee552bd49 http://fpdownload.macromedia.com/get/flashplayer/updaters/14/playerglobal14_0.swc
downloadPlayerGlobal 15.0 8bb52e65abb4e0c6a357f2ccde1ec626 http://fpdownload.macromedia.com/get/flashplayer/updaters/15/playerglobal15_0.swc
downloadPlayerGlobal 16.0 5bf5a05a4065a247bf65e7342a4c770f http://fpdownload.macromedia.com/get/flashplayer/updaters/16/playerglobal16_0.swc
downloadPlayerGlobal 17.0 e86a0fd5131fe3c2fd1e052314237ca9 http://fpdownload.macromedia.com/get/flashplayer/updaters/17/playerglobal17_0.swc
downloadPlayerGlobal 18.0 7451e9a7e6296c6a09022f42adcf57a5 http://fpdownload.macromedia.com/get/flashplayer/updaters/17/playerglobal18_0.swc
downloadPlayerGlobal 19.0 e2e67b0851afaa512c2e2f31c43d5fba http://fpdownload.macromedia.com/get/flashplayer/updaters/17/playerglobal19_0.swc
downloadPlayerGlobal 20.0 d308cdf324f086e7b2f0c1317f698c0c http://fpdownload.macromedia.com/get/flashplayer/updaters/17/playerglobal20_0.swc
