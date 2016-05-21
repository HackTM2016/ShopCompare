#!/bin/sh
mvn initialize -Pstart-domain -DskipTests -Ddomain.properties=$PRICEDIFF_BASE_PATH/Develop/domains/pricediff.properties -f server-web/pom.xml $*
