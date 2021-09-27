FROM wso2/wso2ei-business-process:6.5.0

# Copy Certificate
#COPY certificates/client-truststore.jks ${WSO2_SERVER_HOME}/wso2/business-process/repository/resources/security/

# Copy bar
COPY UserSignUpMultiStep.bar ${WSO2_SERVER_HOME}/wso2/business-process/repository/deployment/server/bpmn/
