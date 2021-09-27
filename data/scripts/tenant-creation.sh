#!/bin/bash
#apim="localhost" # local testing uncomment this

apim="am.wso2.com"
create_tenant(){
curl -X POST -k \
  https://$apim/services/TenantMgtAdminService \
  -H 'Authorization: Basic YWRtaW5AZ29nby5jb206YWRtaW4=' \
  -H 'Content-Type: text/xml' \
  -H 'SOAPAction: \"urn:addTenant\"' \
  -d '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://services.mgt.tenant.carbon.wso2.org" xmlns:xsd="http://beans.common.stratos.carbon.wso2.org/xsd">
   <soapenv:Header/>
   <soapenv:Body>
      <ser:addTenant>
         <ser:tenantInfoBean>
            <xsd:active>true</xsd:active>
            <xsd:admin>admin</xsd:admin>
            <xsd:adminPassword>admin</xsd:adminPassword>
            <xsd:email>'$3'</xsd:email>
            <xsd:firstname>'$1'</xsd:firstname>
            <xsd:lastname>'$1'</xsd:lastname>
            <xsd:tenantDomain>'$2'</xsd:tenantDomain>
         </ser:tenantInfoBean>
      </ser:addTenant>
   </soapenv:Body>
</soapenv:Envelope>'
}

function addUserWithRole()	 {
    curl -k -X POST \
            https://$apim/services/UserAdmin \
            -u $1:$2 \
            -H 'Content-Type: text/xml' \
            -H 'SOAPAction: "urn:addUser"' \
            -d '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://org.apache.axis2/xsd" xmlns:xsd1="http://common.mgt.user.carbon.wso2.org/xsd">
            <soapenv:Header/>
            <soapenv:Body>
                <xsd:addUser>
                    <xsd:userName>'$3'</xsd:userName>
                    <xsd:password>user123</xsd:password>
                    <xsd:roles>'$4'</xsd:roles>
                    <xsd:roles>'$5'</xsd:roles>
                </xsd:addUser>
            </soapenv:Body>
            </soapenv:Envelope>' --write-out "%{http_code}\n" --silent --output /dev/null 
}

function addUserWith3Role () {
    curl -k -X POST \
            https://$apim/services/UserAdmin \
            -u $1:$2 \
            -H 'Content-Type: text/xml' \
            -H 'SOAPAction: "urn:addUser"' \
            -d '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://org.apache.axis2/xsd" xmlns:xsd1="http://common.mgt.user.carbon.wso2.org/xsd">
            <soapenv:Header/>
            <soapenv:Body>
                <xsd:addUser>
                    <xsd:userName>'$3'</xsd:userName>
                    <xsd:password>user123</xsd:password>
                    <xsd:roles>'$4'</xsd:roles>
                    <xsd:roles>'$5'</xsd:roles>
                    <xsd:roles>'$6'</xsd:roles>
                </xsd:addUser>
            </soapenv:Body>
            </soapenv:Envelope>' --write-out "%{http_code}\n" --silent --output /dev/null 
}
function addUserWithMultipleRole () {
    curl -k -X POST \
            https://$apim/services/UserAdmin \
            -u $1:$2 \
            -H 'Content-Type: text/xml' \
            -H 'SOAPAction: "urn:addUser"' \
            -d '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://org.apache.axis2/xsd" xmlns:xsd1="http://common.mgt.user.carbon.wso2.org/xsd">
            <soapenv:Header/>
            <soapenv:Body>
                <xsd:addUser>
                    <xsd:userName>'$3'</xsd:userName>
                    <xsd:password>abc123</xsd:password>
                    <xsd:roles>'$4'</xsd:roles>
                    <xsd:roles>'$5'</xsd:roles>
                    <xsd:roles>'$6'</xsd:roles>
                    <xsd:roles>'$7'</xsd:roles>
                </xsd:addUser>
            </soapenv:Body>
            </soapenv:Envelope>' --write-out "%{http_code}\n" --silent --output /dev/null
}

function addRole () {
    curl -k -X POST \
            https://$apim/services/UserAdmin \
            -u $1:$2 \
            -H 'Content-Type: text/xml' \
            -H 'SOAPAction: "urn:addRole"' \
            -d '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://org.apache.axis2/xsd">
                <soapenv:Header/>
                <soapenv:Body>
                    <xsd:addRole>
                        <xsd:roleName>'$3'</xsd:roleName>
                        <xsd:isSharedRole>false</xsd:isSharedRole>
                    </xsd:addRole>
                </soapenv:Body>
                </soapenv:Envelope>' --write-out "%{http_code}\n" --silent --output /dev/null 
}

function enableSignup(){
curl -X POST \
  https://$apim/services/ResourceAdminService \
  -u $1:$2 \
  -H 'Content-Type: application/soap+xml;charset=UTF-8;action=\"urn:updateTextContent\"' \
  -d '<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:ser="http://services.resource.registry.carbon.wso2.org">
   <soap:Header />
   <soap:Body>
      <ser:updateTextContent>
         <ser:resourcePath>/_system/governance/apimgt/applicationdata/sign-up-config.xml</ser:resourcePath>
         <ser:contentText>&lt;SelfSignUp&gt;

    &lt;EnableSignup&gt;true&lt;/EnableSignup&gt;

    &lt;!-- user storage to store users --&gt;
    &lt;SignUpDomain&gt;PRIMARY&lt;/SignUpDomain&gt;

    &lt;!-- Tenant admin information. (for clustered setup credentials for AuthManager) --&gt;
    &lt;AdminUserName&gt;'$1'&lt;/AdminUserName&gt;
    &lt;AdminPassword&gt;'$2'&lt;/AdminPassword&gt;

    &lt;!-- List of roles for the tenant user --&gt;
    &lt;SignUpRoles&gt;
        &lt;SignUpRole&gt;
            &lt;RoleName&gt;subscriber&lt;/RoleName&gt;
            &lt;IsExternalRole&gt;false&lt;/IsExternalRole&gt;
        &lt;/SignUpRole&gt;
    &lt;/SignUpRoles&gt;

&lt;/SelfSignUp&gt;</ser:contentText>
      </ser:updateTextContent>
   </soap:Body>
</soap:Envelope>' -k
}

function enableSingupWorkflow() {
    curl -X POST \
  https://$apim/services/ResourceAdminService \
  -u $1:$2 \
  -H 'Content-Type: application/soap+xml;charset=UTF-8;action=\"urn:updateTextContent\"' \
  -d '<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:ser="http://services.resource.registry.carbon.wso2.org">
   <soap:Header/>
   <soap:Body>
      <ser:updateTextContent>
         <ser:resourcePath>/_system/governance/apimgt/applicationdata/workflow-extensions.xml</ser:resourcePath>
          <ser:contentText>

&lt;WorkFlowExtensions&gt;
    &lt;ApplicationCreation executor=&quot;org.wso2.carbon.apimgt.impl.workflow.ApplicationCreationSimpleWorkflowExecutor&quot;/&gt;
    &lt;!--ApplicationCreation executor=&quot;org.wso2.carbon.apimgt.impl.workflow.ApplicationCreationApprovalWorkflowExecutor&quot;/--&gt;
    &lt;ProductionApplicationRegistration executor=&quot;org.wso2.carbon.apimgt.impl.workflow.ApplicationRegistrationSimpleWorkflowExecutor&quot;/&gt;
    &lt;!--ProductionApplicationRegistration executor=&quot;org.wso2.carbon.apimgt.impl.workflow.ApplicationRegistrationApprovalWorkflowExecutor&quot;/--&gt;
    &lt;SandboxApplicationRegistration executor=&quot;org.wso2.carbon.apimgt.impl.workflow.ApplicationRegistrationSimpleWorkflowExecutor&quot;/&gt;
    &lt;!--SandboxApplicationRegistration executor=&quot;org.wso2.carbon.apimgt.impl.workflow.ApplicationRegistrationApprovalWorkflowExecutor&quot;/--&gt;
    &lt;SubscriptionCreation executor=&quot;org.wso2.apim.monetization.impl.workflow.StripeSubscriptionCreationWorkflowExecutor&quot;/&gt;
    &lt;!--SubscriptionCreation executor=&quot;org.wso2.carbon.apimgt.impl.workflow.SubscriptionCreationApprovalWorkflowExecutor&quot;/--&gt;

    &lt;SubscriptionUpdate executor=&quot;org.wso2.carbon.apimgt.impl.workflow.SubscriptionUpdateSimpleWorkflowExecutor&quot;/&gt;
    &lt;!--SubscriptionUpdate executor=&quot;org.wso2.carbon.apimgt.impl.workflow.SubscriptionUpdateApprovalWorkflowExecutor&quot;/--&gt;
    &lt;!--SubscriptionUpdate executor=&quot;org.wso2.carbon.apimgt.impl.workflow.SubscriptionUpdateWSWorkflowExecutor&quot;&gt;
         &lt;Property name=&quot;serviceEndpoint&quot;&gt;http://localhost:9765/services/SubscriptionApprovalWorkFlowProcess/&lt;/Property&gt;
         &lt;Property name=&quot;username&quot;&gt;admin&lt;/Property&gt;
         &lt;Property name=&quot;password&quot;&gt;admin&lt;/Property&gt;
         &lt;Property name=&quot;callbackURL&quot;&gt;https://localhost:8243/services/WorkflowCallbackService&lt;/Property&gt;
    &lt;/SubscriptionUpdate--&gt;
    &lt;!--UserSignUp executor=&quot;org.wso2.carbon.apimgt.impl.workflow.UserSignUpSimpleWorkflowExecutor&quot;/--&gt;
    &lt;UserSignUp executor=&quot;org.wso2.carbon.apimgt.impl.workflow.UserSignUpApprovalWorkflowExecutor&quot;/&gt;

  &lt;!--
  ***NOTE:***
        Users of deletion workflows are expected to implement their own deletion workflow executors and services.
        By default API Manager only implements the core functionalities required to support deletion workflows and
        simple deletion workflow executors. Default WS deletion workflow implementations are not available with the
        distribution.
    --&gt;

    &lt;SubscriptionDeletion executor=&quot;org.wso2.apim.monetization.impl.workflow.StripeSubscriptionDeletionWorkflowExecutor&quot;/&gt;
    &lt;!--SubscriptionDeletion executor=&quot;org.wso2.carbon.apimgt.impl.workflow.SubscriptionDeletionSimpleWorkflowExecutor&quot;&gt;
         &lt;Property name=&quot;serviceEndpoint&quot;&gt;http://localhost:9765/services/SubscriptionApprovalWorkFlowProcess/&lt;/Property&gt;
         &lt;Property name=&quot;username&quot;&gt;admin&lt;/Property&gt;
         &lt;Property name=&quot;password&quot;&gt;admin&lt;/Property&gt;
         &lt;Property name=&quot;callbackURL&quot;&gt;https://localhost:8243/services/WorkflowCallbackService&lt;/Property&gt;
    &lt;/SubscriptionDeletion --&gt;
    &lt;ApplicationDeletion executor=&quot;org.wso2.carbon.apimgt.impl.workflow.ApplicationDeletionSimpleWorkflowExecutor&quot;/&gt;
    &lt;!--ApplicationDeletion executor=&quot;org.wso2.carbon.apimgt.impl.workflow.ApplicationDeletionSimpleWorkflowExecutor&quot;&gt;
         &lt;Property name=&quot;serviceEndpoint&quot;&gt;http://localhost:9765/services/ApplicationApprovalWorkFlowProcess/&lt;/Property&gt;
         &lt;Property name=&quot;username&quot;&gt;admin&lt;/Property&gt;
         &lt;Property name=&quot;password&quot;&gt;admin&lt;/Property&gt;
         &lt;Property name=&quot;callbackURL&quot;&gt;https://localhost:8243/services/WorkflowCallbackService&lt;/Property&gt;
    &lt;/ApplicationDeletion--&gt;
    
    &lt;!-- Publisher related workflows --&gt;
    &lt;APIStateChange executor=&quot;org.wso2.carbon.apimgt.impl.workflow.APIStateChangeSimpleWorkflowExecutor&quot; /&gt;
    &lt;!--APIStateChange executor=&quot;org.wso2.carbon.apimgt.impl.workflow.APIStateChangeApprovalWorkflowExecutor&quot;&gt;
        &lt;Property name=&quot;stateList&quot;&gt;Created:Publish,Published:Block&lt;/Property&gt;
    &lt;/APIStateChange--&gt;

&lt;/WorkFlowExtensions&gt;


    </ser:contentText>
      </ser:updateTextContent>
   </soap:Body>
</soap:Envelope>' -k
}

addStripeKey () {
   curl -X POST \
  https://$apim/services/ResourceAdminService \
  -u $1:$2 \
  -H 'Content-Type: application/soap+xml;charset=UTF-8;action=\"urn:updateTextContent\"' \
  -d '<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:ser="http://services.resource.registry.carbon.wso2.org">
   <soap:Header/>
   <soap:Body>
      <ser:updateTextContent>
         <ser:resourcePath>/_system/config/apimgt/applicationdata/tenant-conf.json</ser:resourcePath>
          <ser:contentText>

  &#34;EnableMonetization&#34; : false,
  &#34;EnableRecommendation&#34; : false,
  &#34;IsUnlimitedTierPaid&#34; : false,
  &#34;ContainerMgt&#34;: [
    {
      &#34;Type&#34;: &#34;Kubernetes&#34;,
      &#34;ContainerMgtInfo&#34;: [
        {
          &#34;ClusterName&#34;: &#34;&#34;,
          &#34;DisplayName&#34;: &#34;&#34;,
          &#34;Properties&#34;: {
            &#34;MasterURL&#34;: &#34;&#34;,
            &#34;AccessURL&#34;: &#34;&#34;,
            &#34;SAToken&#34;: &#34;&#34;,
            &#34;Namespace&#34;: &#34;default&#34;,
            &#34;Replicas&#34;: 1,
            &#34;BasicSecurityCustomResourceName&#34;: &#34;&#34;,
            &#34;OauthSecurityCustomResourceName&#34;: &#34;&#34;,
            &#34;JWTSecurityCustomResourceName&#34;: &#34;&#34;
          }
        }
      ]
    }
  ],
  &#34;ExtensionHandlerPosition&#34;: &#34;bottom&#34;,
  &#34;RESTAPIScopes&#34;: {
    &#34;Scope&#34;: [
      {
        &#34;Name&#34;: &#34;apim:api_publish&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/publisher&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:api_create&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/creator&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:api_generate_key&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/creator,Internal/publisher&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:api_view&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/publisher,Internal/creator,Internal/analytics&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:api_delete&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/creator&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:subscribe&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/subscriber,Internal/devops&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:tier_view&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/publisher,Internal/creator&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:tier_manage&#34;,
        &#34;Roles&#34;: &#34;admin&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:bl_view&#34;,
        &#34;Roles&#34;: &#34;admin&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:bl_manage&#34;,
        &#34;Roles&#34;: &#34;admin&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:subscription_view&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/creator,Internal/publisher&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:subscription_block&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/publisher&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:mediation_policy_view&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/creator&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:mediation_policy_create&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/creator&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:api_workflow_view&#34;,
        &#34;Roles&#34;: &#34;admin&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:api_workflow_approve&#34;,
        &#34;Roles&#34;: &#34;admin&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:admin&#34;,
        &#34;Roles&#34;: &#34;admin&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:app_owner_change&#34;,
        &#34;Roles&#34;: &#34;admin&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:app_import_export&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/devops&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:api_import_export&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/devops&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:api_product_import_export&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/devops&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:label_manage&#34;,
        &#34;Roles&#34;: &#34;admin&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:label_read&#34;,
        &#34;Roles&#34;: &#34;admin&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:app_update&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/subscriber&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:app_manage&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/subscriber,Internal/devops&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:sub_manage&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/subscriber,Internal/devops&#34;
      },
      {
        &#34;Name&#34; : &#34;apim:monetization_usage_publish&#34;,
        &#34;Roles&#34;: &#34;admin, Internal/publisher&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:document_create&#34;,
        &#34;Roles&#34;: &#34;admin, Internal/creator,Internal/publisher&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:ep_certificates_update&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/creator&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:client_certificates_update&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/creator&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:threat_protection_policy_manage&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/creator&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:document_manage&#34;,
        &#34;Roles&#34;: &#34;admin, Internal/creator,Internal/publisher&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:client_certificates_add&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/creator&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:publisher_settings&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/creator,Internal/publisher&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:store_settings&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/subscriber&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:admin_settings&#34;,
        &#34;Roles&#34;: &#34;admin&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:client_certificates_view&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/creator&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:mediation_policy_manage&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/creator&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:threat_protection_policy_create&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/creator&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:ep_certificates_add&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/creator&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:ep_certificates_view&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/creator&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:api_key&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/subscriber&#34;
      },
      {
        &#34;Name&#34;: &#34;apim_analytics:admin&#34;,
        &#34;Roles&#34;: &#34;admin&#34;
      },
      {
        &#34;Name&#34;: &#34;apim_analytics:monitoring_dashboard:own&#34;,
        &#34;Roles&#34;: &#34;admin&#34;
      },
      {
        &#34;Name&#34;: &#34;apim_analytics:monitoring_dashboard:edit&#34;,
        &#34;Roles&#34;: &#34;admin&#34;
      },
      {
        &#34;Name&#34;: &#34;apim_analytics:monitoring_dashboard:view&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/analytics&#34;
      },
      {
        &#34;Name&#34;: &#34;apim_analytics:business_analytics:own&#34;,
        &#34;Roles&#34;: &#34;admin&#34;
      },
      {
        &#34;Name&#34;: &#34;apim_analytics:business_analytics:edit&#34;,
        &#34;Roles&#34;: &#34;admin&#34;
      },
      {
        &#34;Name&#34;: &#34;apim_analytics:business_analytics:view&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/analytics&#34;
      },
      {
        &#34;Name&#34;: &#34;apim_analytics:api_analytics:own&#34;,
        &#34;Roles&#34;: &#34;admin&#34;
      },
      {
        &#34;Name&#34;: &#34;apim_analytics:api_analytics:edit&#34;,
        &#34;Roles&#34;: &#34;admin&#34;
      },
      {
        &#34;Name&#34;: &#34;apim_analytics:api_analytics:view&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/creator,Internal/publisher&#34;
      },
      {
        &#34;Name&#34;: &#34;apim_analytics:application_analytics:own&#34;,
        &#34;Roles&#34;: &#34;admin&#34;
      },
      {
        &#34;Name&#34;: &#34;apim_analytics:application_analytics:edit&#34;,
        &#34;Roles&#34;: &#34;admin&#34;
      },
      {
        &#34;Name&#34;: &#34;apim_analytics:application_analytics:view&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/subscriber&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:pub_alert_manage&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/creator&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:sub_alert_manage&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/subscriber&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:tenantInfo&#34;,
        &#34;Roles&#34;: &#34;admin&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:tenant_theme_manage&#34;,
        &#34;Roles&#34;: &#34;admin&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:admin_operations&#34;,
        &#34;Roles&#34;: &#34;admin&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:shared_scope_manage&#34;,
        &#34;Roles&#34;: &#34;admin&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:admin_alert_manage&#34;,
        &#34;Roles&#34;: &#34;admin&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:bot_data&#34;,
        &#34;Roles&#34;: &#34;admin&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:scope_manage&#34;,
        &#34;Roles&#34;: &#34;admin&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:role_manage&#34;,
        &#34;Roles&#34;: &#34;admin&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:environment_manage&#34;,
        &#34;Roles&#34;: &#34;admin&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:environment_read&#34;,
        &#34;Roles&#34;: &#34;admin&#34;
      },
      {
        &#34;Name&#34;: &#34;service_catalog:service_view&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/creator,Internal/publisher&#34;
      },
      {
        &#34;Name&#34;: &#34;service_catalog:service_write&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/creator&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:comment_view&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/creator,Internal/publisher&#34;
      },
      {
        &#34;Name&#34;: &#34;apim:comment_write&#34;,
        &#34;Roles&#34;: &#34;admin,Internal/creator,Internal/publisher&#34;
      }
    ]
  },
  &#34;Meta&#34; : {
    &#34;Migration&#34;: {
      &#34;3.0.0&#34;: true
    }
  },
  &#34;NotificationsEnabled&#34;:&#34;false&#34;,
  &#34;Notifications&#34;:[{
    &#34;Type&#34;:&#34;new_api_version&#34;,
    &#34;Notifiers&#34; :[{
      &#34;Class&#34;:&#34;org.wso2.carbon.apimgt.impl.notification.NewAPIVersionEmailNotifier&#34;,
      &#34;ClaimsRetrieverImplClass&#34;:&#34;org.wso2.carbon.apimgt.impl.token.DefaultClaimsRetriever&#34;,
      &#34;Title&#34;: &#34;Version $2 of $1 Released&#34;,
      &#34;Template&#34;: &#34; &lt;html&gt; &lt;body&gt; &lt;h3 style=\&#34;color:Black;\&#34;&gt;We’re happy to announce the arrival of the next major version $2 of $1 API which is now available in Our API Store.&lt;/h3&gt;&lt;a href=\&#34;https://localhost:9443/store\&#34;&gt;Click here to Visit WSO2 API Store&lt;/a&gt;&lt;/body&gt;&lt;/html&gt;&#34;
    }]
  }
  ],
  &#34;DefaultRoles&#34; : {
    &#34;PublisherRole&#34; : {
      &#34;CreateOnTenantLoad&#34; : true,
      &#34;RoleName&#34; : &#34;Internal/publisher&#34;
    },
    &#34;CreatorRole&#34; : {
      &#34;CreateOnTenantLoad&#34; : true,
      &#34;RoleName&#34; : &#34;Internal/creator&#34;
    },
    &#34;SubscriberRole&#34; : {
      &#34;CreateOnTenantLoad&#34; : true
    },
    &#34;DevOpsRole&#34; : {
      &#34;CreateOnTenantLoad&#34; : true,
      &#34;RoleName&#34; : &#34;Internal/devops&#34;
    }
  },
  &#34;MonetizationInfo&#34;: {&#34;BillingEnginePlatformAccountKey&#34;: &#34;sk_test_51IvpF4Hcnn50QHez7pm5jnuc1mhxfVFYglW2KbZRyLc3WPOEn9ZmLjWXpvzE5HEM6Ira6fxQDoMoB6ffS7cVoYeM00m58jPDda&#34;}

}
    </ser:contentText>
      </ser:updateTextContent>
   </soap:Body>
</soap:Envelope>' -k

}

####################################################################################################
#create tenants
#echo "Creating tenant quantis.com"
#create_tenant "admin" "quantis.com" "admin@quantis.com"
#sleep 3
echo "Adding sample users to quantis.com domain"
#addUserWithRole "admin@gogo.com@quantis.com" "admin" "andy@gogo.com" "Internal/creator" "Internal/publisher"
#addUserWithRole "admin@gogo.com@quantis.com" "admin" "bob@gogo.com" "Internal/subscriber" "Internal/everyone"
#addUserWithRole "admin@gogo.com@quantis.com" "admin" "logan@gogo.com" "Internal/subscriber" "Internal/everyone"
#addUserWithRole "admin@gogo.com@quantis.com" "admin" "sindy@gogo.com" "Internal/subscriber" "Internal/everyone"
#addUserWithRole "admin@gogo.com@quantis.com" "admin" "kate@gogo.com" "Internal/subscriber" "Internal/everyone"
#addUserWithRole "admin@gogo.com@quantis.com" "admin" "apiprovider@gogo.com" "Internal/creator" "Internal/publisher"
#addUserWithRole "admin@gogo.com@quantis.com" "admin" "devuser@gogo.com" "Internal/subscriber" "Internal/everyone"
#echo "Enable signup and workflow"
#enableSignup "admin@quantis.com" "admin"
#enableSingupWorkflow "admin@gogo.com" "admin"
#sleep 3
###
#echo "Creating tenant coltrain.com"
#create_tenant "admin" "coltrain.com" "admin@coltrain.com"
#sleep 3
#echo "Adding roles to coltrain.com domain"
#addRole "admin@coltrain.com" "admin" "schedule_admin"
#addRole "admin@coltrain.com" "admin" "coltrain_employee"
#echo "Adding sample users to coltrain.com domain"
#addUserWithRole "admin@coltrain.com" "admin" "bill" "Internal/creator" "Internal/publisher"
#addUserWith3Role "admin@coltrain.com" "admin" "george" "Internal/subscriber" "Internal/everyone" "coltrain_employee"
#addUserWith3Role "admin@coltrain.com" "admin" "jenny" "Internal/subscriber" "schedule_admin" "coltrain_employee"
#addUserWithRole "admin@coltrain.com" "admin" "apiprovider" "Internal/creator" "Internal/publisher"
#addUserWithRole "admin@coltrain.com" "admin" "devuser" "Internal/subscriber" "Internal/everyone"
#sleep 3
###
#echo "Creating tenant railco.com"
#create_tenant "admin" "railco.com" "admin@railco.com"
#sleep 3
#echo "Adding sample users to railco.com domain"
#addUserWithRole "admin@railco.com" "admin" "jill" "Internal/creator" "Internal/publisher"
#addUserWithRole "admin@railco.com" "admin" "tom" "Internal/subscriber" "Internal/everyone"
#addUserWithRole "admin@railco.com" "admin" "apiprovider" "Internal/creator" "Internal/publisher"
#addUserWithRole "admin@railco.com" "admin" "devuser" "Internal/subscriber" "Internal/everyone"
#sleep 3

#echo "Adding sample users to super tenant"
#addUserWithRole "admin@gogo.com" "admin" "peter@gogo.com" "Internal/subscriber" "Internal/everyone"
#addUserWithRole "admin@gogo.com" "admin" "apiprovider@gogo.com" "Internal/creator" "Internal/publisher"
#addUserWithMultipleRole "admin@gogo.com" "admin" "devuser@gogo.com" "Internal/subscriber" "Internal/everyone" "Internal/publisher" "Internal/creator"
#addUserWithMultipleRole "admin@gogo.com" "admin" "productmanager@gogo.com" "Internal/subscriber" "Internal/everyone" "Internal/publisher" "Internal/creator"
#addUserWithMultipleRole "admin@gogo.com" "admin" "apicreator@gogo.com" "Internal/subscriber" "Internal/everyone" "Internal/publisher" "Internal/creator"

#sleep 3

#echo "Adding Stipe key"
#addStripeKey "admin" "admin"
#addStripeKey "admin@quantis.com" "admin"


