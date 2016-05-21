#!/bin/sh
mvn initialize -Pstop-domain -DskipTests -Ddomain.properties=$PRICEDIFF_BASE_PATH/Develop/domains/pricediff.properties -f  server-web/pom.xml  $*
