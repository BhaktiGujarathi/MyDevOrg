//Generated by wsdl2apex

public class AsyncSoapSforceComSchemasClassLeadmanipu {
    public class deleteLeadInstanceResponse_elementFuture extends System.WebServiceCalloutFuture {
        public String getValue() {
            soapSforceComSchemasClassLeadmanipu.deleteLeadInstanceResponse_element response = (soapSforceComSchemasClassLeadmanipu.deleteLeadInstanceResponse_element)System.WebServiceCallout.endInvoke(this);
            return response.result;
        }
    }
    public class insertLeadInstanceResponse_elementFuture extends System.WebServiceCalloutFuture {
        public String getValue() {
            soapSforceComSchemasClassLeadmanipu.insertLeadInstanceResponse_element response = (soapSforceComSchemasClassLeadmanipu.insertLeadInstanceResponse_element)System.WebServiceCallout.endInvoke(this);
            return response.result;
        }
    }
    public class updateLeadInstanceResponse_elementFuture extends System.WebServiceCalloutFuture {
        public String getValue() {
            soapSforceComSchemasClassLeadmanipu.updateLeadInstanceResponse_element response = (soapSforceComSchemasClassLeadmanipu.updateLeadInstanceResponse_element)System.WebServiceCallout.endInvoke(this);
            return response.result;
        }
    }
    public class AsyncLeadManipulatorSoapService {
        public String endpoint_x = 'https://ap2.salesforce.com/services/Soap/class/LeadManipulatorSoapService';
        public Map<String,String> inputHttpHeaders_x;
        public String clientCertName_x;
        public Integer timeout_x;
        public soapSforceComSchemasClassLeadmanipu.SessionHeader_element SessionHeader;
        public soapSforceComSchemasClassLeadmanipu.CallOptions_element CallOptions;
        public soapSforceComSchemasClassLeadmanipu.DebuggingInfo_element DebuggingInfo;
        public soapSforceComSchemasClassLeadmanipu.DebuggingHeader_element DebuggingHeader;
        public soapSforceComSchemasClassLeadmanipu.AllowFieldTruncationHeader_element AllowFieldTruncationHeader;
        private String SessionHeader_hns = 'SessionHeader=http://soap.sforce.com/schemas/class/LeadManipulatorSoapService';
        private String CallOptions_hns = 'CallOptions=http://soap.sforce.com/schemas/class/LeadManipulatorSoapService';
        private String DebuggingInfo_hns = 'DebuggingInfo=http://soap.sforce.com/schemas/class/LeadManipulatorSoapService';
        private String DebuggingHeader_hns = 'DebuggingHeader=http://soap.sforce.com/schemas/class/LeadManipulatorSoapService';
        private String AllowFieldTruncationHeader_hns = 'AllowFieldTruncationHeader=http://soap.sforce.com/schemas/class/LeadManipulatorSoapService';
        private String[] ns_map_type_info = new String[]{'http://soap.sforce.com/schemas/class/LeadManipulatorSoapService', 'soapSforceComSchemasClassLeadmanipu'};
        public AsyncSoapSforceComSchemasClassLeadmanipu.deleteLeadInstanceResponse_elementFuture beginDeleteLeadInstance(System.Continuation continuation,String firstname,String lastname,String phone,String email) {
            soapSforceComSchemasClassLeadmanipu.deleteLeadInstance_element request_x = new soapSforceComSchemasClassLeadmanipu.deleteLeadInstance_element();
            request_x.firstname = firstname;
            request_x.lastname = lastname;
            request_x.phone = phone;
            request_x.email = email;
            return (AsyncSoapSforceComSchemasClassLeadmanipu.deleteLeadInstanceResponse_elementFuture) System.WebServiceCallout.beginInvoke(
              this,
              request_x,
              AsyncSoapSforceComSchemasClassLeadmanipu.deleteLeadInstanceResponse_elementFuture.class,
              continuation,
              new String[]{endpoint_x,
              '',
              'http://soap.sforce.com/schemas/class/LeadManipulatorSoapService',
              'deleteLeadInstance',
              'http://soap.sforce.com/schemas/class/LeadManipulatorSoapService',
              'deleteLeadInstanceResponse',
              'soapSforceComSchemasClassLeadmanipu.deleteLeadInstanceResponse_element'}
            );
        }
        public AsyncSoapSforceComSchemasClassLeadmanipu.insertLeadInstanceResponse_elementFuture beginInsertLeadInstance(System.Continuation continuation,String name,String company,String status,String phone,String email) {
            soapSforceComSchemasClassLeadmanipu.insertLeadInstance_element request_x = new soapSforceComSchemasClassLeadmanipu.insertLeadInstance_element();
            request_x.name = name;
            request_x.company = company;
            request_x.status = status;
            request_x.phone = phone;
            request_x.email = email;
            return (AsyncSoapSforceComSchemasClassLeadmanipu.insertLeadInstanceResponse_elementFuture) System.WebServiceCallout.beginInvoke(
              this,
              request_x,
              AsyncSoapSforceComSchemasClassLeadmanipu.insertLeadInstanceResponse_elementFuture.class,
              continuation,
              new String[]{endpoint_x,
              '',
              'http://soap.sforce.com/schemas/class/LeadManipulatorSoapService',
              'insertLeadInstance',
              'http://soap.sforce.com/schemas/class/LeadManipulatorSoapService',
              'insertLeadInstanceResponse',
              'soapSforceComSchemasClassLeadmanipu.insertLeadInstanceResponse_element'}
            );
        }
        public AsyncSoapSforceComSchemasClassLeadmanipu.updateLeadInstanceResponse_elementFuture beginUpdateLeadInstance(System.Continuation continuation,String firstName,String lastName,String phone,String email) {
            soapSforceComSchemasClassLeadmanipu.updateLeadInstance_element request_x = new soapSforceComSchemasClassLeadmanipu.updateLeadInstance_element();
            request_x.firstName = firstName;
            request_x.lastName = lastName;
            request_x.phone = phone;
            request_x.email = email;
            return (AsyncSoapSforceComSchemasClassLeadmanipu.updateLeadInstanceResponse_elementFuture) System.WebServiceCallout.beginInvoke(
              this,
              request_x,
              AsyncSoapSforceComSchemasClassLeadmanipu.updateLeadInstanceResponse_elementFuture.class,
              continuation,
              new String[]{endpoint_x,
              '',
              'http://soap.sforce.com/schemas/class/LeadManipulatorSoapService',
              'updateLeadInstance',
              'http://soap.sforce.com/schemas/class/LeadManipulatorSoapService',
              'updateLeadInstanceResponse',
              'soapSforceComSchemasClassLeadmanipu.updateLeadInstanceResponse_element'}
            );
        }
    }
}