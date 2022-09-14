echo ""
echo "=========================================================="
PR_LINK=${PR_LINK%/}
JDK_VERSION=${JDK_VERSION%/}
JAVA_8_HOME=${JAVA_8_HOME%/}
JAVA_11_HOME=${JAVA_11_HOME%/}
echo "    PR_LINK: $PR_LINK"
echo "    JAVA 8 Home: $JAVA_8_HOME"
echo "    JAVA 11 Home: $JAVA_11_HOME"
echo "    User Input: $JDK_VERSION"
echo "::warning::Build ran for PR $PR_LINK"