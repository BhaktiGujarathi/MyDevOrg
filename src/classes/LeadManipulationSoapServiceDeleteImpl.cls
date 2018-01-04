@isTest
global class LeadManipulationSoapServiceDeleteImpl implements WebserviceMock {
    global void doInvoke(Object stub,
                         Object request,
                         Map<String, Object> response,
                         String endpoint,
                         String soapAction,
                         String requestName,
                         String responseNS,
                         String responseName,
                         String responseType) {
         soapSforceComSchemasClassLeadmanipu.deleteLeadInstanceResponse_element reponseInstance = 
             new soapSforceComSchemasClassLeadmanipu.deleteLeadInstanceResponse_element();
         reponseInstance.Result = 'Deleted';
         response.put('response_x', reponseInstance); 

         
     }
}