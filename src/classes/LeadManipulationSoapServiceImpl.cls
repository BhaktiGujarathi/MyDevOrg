@isTest
global class LeadManipulationSoapServiceImpl implements WebserviceMock {
    global void doInvoke(Object stub,
                         Object request,
                         Map<String, Object> response,
                         String endpoint,
                         String soapAction,
                         String requestName,
                         String responseNS,
                         String responseName,
                         String responseType) {
         soapSforceComSchemasClassLeadmanipu.insertLeadInstanceResponse_element reponseInstance = 
             new soapSforceComSchemasClassLeadmanipu.insertLeadInstanceResponse_element();
         reponseInstance.Result = 'Inserted';
         response.put('response_x', reponseInstance); 

         
     }
}