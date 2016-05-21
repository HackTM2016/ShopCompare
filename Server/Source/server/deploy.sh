mvn pre-integration-test -Pdeploy -DskipTests -Ddomain.properties=$PRICEDIFF_BASE_PATH/Develop/domains/pricediff.properties -f server-web/pom.xml  $*
