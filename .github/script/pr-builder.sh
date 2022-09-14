PR_LINK=${PR_LINK%/}
USER=$(echo $PR_LINK | awk -F'/' '{print $4}')
REPO=$(echo $PR_LINK | awk -F'/' '{print $5}')
PULL_NUMBER=$(echo $PR_LINK | awk -F'/' '{print $7}')
echo "Applying PR $PULL_NUMBER as a diff..."
echo "=========================================================="
cd carbon-apimgt
wget -q --output-document=diff.diff $PR_LINK.diff
cat diff.diff
git apply diff.diff || {
    echo 'Applying diff failed. Exiting...'
    echo "::error::Applying diff failed."
    exit 1
}
mvn clean install -Dmaven.test.skip=true
APIMGT_DEPENDENCY_VERSION=$(python -c "import xml.etree.ElementTree as ET; print(ET.parse(open('pom.xml')).getroot().find( '{http://maven.apache.org/POM/4.0.0}version').text)")
echo '==================='
echo $APIMGT_DEPENDENCY_VERSION
cd ../
sed -i "s/<carbon.apimgt.version>.*<\/carbon.apimgt.version>/<carbon.apimgt.version>$APIMGT_DEPENDENCY_VERSION<\/carbon.apimgt.version>/" product-apim/pom.xml
cd product-apim
mvn clean install -Dmaven.test.skip=true
cd ../
cat product-apim/pom.xml