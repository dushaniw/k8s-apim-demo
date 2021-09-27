FROM wso2/wso2am:4.0.0

# copy extensions to API-M server home
COPY dropins ${WSO2_SERVER_HOME}/repository/components/dropins/

# copy libs to API-M server home
COPY lib ${WSO2_SERVER_HOME}/repository/components/lib/

COPY artifacts/repository/resources/api_templates  ${WSO2_SERVER_HOME}/repository/resources/api_templates/

COPY artifacts/repository/resources/conf/templates  ${WSO2_SERVER_HOME}/repository/resources/conf/templates/

COPY artifacts/repository/resources/extensions  ${WSO2_SERVER_HOME}/repository/resources/extensions/

COPY artifacts/repository/deployment/server/jaggeryapps/publisher ${WSO2_SERVER_HOME}/repository/deployment/server/jaggeryapps/publisher/

COPY artifacts/repository/deployment/server/jaggeryapps/devportal ${WSO2_SERVER_HOME}/repository/deployment/server/jaggeryapps/devportal/

COPY artifacts/repository/deployment/server/webapps/accountrecoveryendpoint ${WSO2_SERVER_HOME}/repository/deployment/server/webapps/accountrecoveryendpoint/

COPY artifacts/repository/deployment/server/webapps/authenticationendpoint ${WSO2_SERVER_HOME}/repository/deployment/server/webapps/authenticationendpoint/


 
