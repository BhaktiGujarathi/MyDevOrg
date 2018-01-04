@isTest
global class LeadManipulationSoapServiceUpdateImpl implements WebserviceMock {
    global void doInvoke(Object stub,
                         Object request,
                         Map<String, Object> response,
                         String endpoint,
                         String soapAction,
                         String requestName,
                         String responseNS,
                         String responseName,
                         String responseType) {
         soapSforceComSchemasClassLeadmanipu.updateLeadInstanceResponse_element updateReponseInstance = 
             new soapSforceComSchemasClassLeadmanipu.updateLeadInstanceResponse_element();
         updateReponseInstance.Result = 'Updated';
         response.put('response_x', updateReponseInstance );
     }
}