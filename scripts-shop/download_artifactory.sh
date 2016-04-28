#!/bin/bash

[ ! -d target ] && mkdir target
[ ! -d src/main/config ] && mkdir -p src/main/config
pushd target
curl -O 'http://espina:8081/artifactory/ext-snapshot-local/Calavera/target/CalaveraMain.jar'
curl -O 'http://espina:8081/artifactory/ext-snapshot-local/Calavera/target/web.xml'
popd
cp target/web.xml src/main/config
curl -O 'http://espina:8081/artifactory/ext-snapshot-local/Calavera/build.xml'
curl -O 'http://espina:8081/artifactory/ext-snapshot-local/Calavera/jmeter.jmx'
