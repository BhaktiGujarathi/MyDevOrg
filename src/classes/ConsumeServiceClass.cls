public with sharing class ConsumeServiceClass {
    public partnerSoapSforceCom.LoginResult loginDetails;
   
    //partnerSoapSforceCom.Soap soapInstance = new partnerSoapSforceCom.Soap();
    public void loginMethod() {
        partnerSoapSforceCom.Soap soapInstance = new partnerSoapSforceCom.Soap();
        String password = 'neetabharat2708sH9E8QfBjzsfwRVR0DTunLtzn';
        String userName = 'bhakti.gujrathi@eternussolutions.com';
        loginDetails = soapInstance.login( userName, password);
        String sessionIdInstance = loginDetails.sessionId;
        system.debug('.........loginDetails'+sessionIdInstance);
        
        soapSforceComSchemasClassLeadmanipu.LeadManipulatorSoapService clsInstance = new soapSforceComSchemasClassLeadmanipu.LeadManipulatorSoapService();
        clsInstance.sessionHeader = new soapSforceComSchemasClassLeadmanipu.SessionHeader_element();
        clsInstance.sessionHeader.sessionID = loginDetails.SessionID;
        
        //soapSforceComSchemasClassLeadmanipu.serviceResponse responseInstance = new soapSforceComSchemasClassLeadmanipu.serviceResponse();
        string insertInstance =  clsInstance.insertLeadInstance('serviceLead1N', 'Eternus1', 'Open', '4363571', 'service@eternus1.com');
        //system.debug('++++++++++responseInstance.serviceStatus ' +insertInstance );
        system.debug('----------responseInstance' +insertInstance);
        String updateInstance =  clsInstance.updateLeadInstance('abcdef1', 'fedcba1', '4000000', 'service1@eternus.com');
        system.debug('----------responseInstance' +updateInstance);
        String deleteInstance =  clsInstance.deleteLeadInstance('rest1','rest2','9876543210','rest2@rest1.com');
        system.debug('----------responseInstance' +deleteInstance);
    }

}