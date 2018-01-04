@isTest
public class ConsumeServiceClassTest {
     @isTest static void loginMethod() {
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new LeadManipulationSoapServiceImpl());
        //call your webservice method in the 1st org
        //class generated from apexWSDL.class in which you have your method tobe called.methiod name(parameters to be passed)
        String output = new soapSforceComSchemasClassLeadmanipu.LeadManipulatorSoapService().insertLeadInstance('TestWebLead','WebService','Open','6236482','Test@webService.com');
        
        System.assertEquals('Inserted', output );  
     }
     @isTest static void updateTest() {
     
        Test.setMock(WebServiceMock.class, new LeadManipulationSoapServiceUpdateImpl());
        
        String updateOutput = new soapSforceComSchemasClassLeadmanipu.LeadManipulatorSoapService().updateLeadInstance('TestWebLead','TestLastName','389476','firstName@LastName.com');
        
        System.assertEquals('Updated', updateOutput );
    }
    
    @isTest static void deleteTest() {
     
        Test.setMock(WebServiceMock.class, new LeadManipulationSoapServiceDeleteImpl ());
        //Lead leadTestInstance = new Lead (FirstName = 'firstName', LastName = 'lastname', Company = 'Test.Pvt.Ltd', Status = 'Open');
       // insert leadTestInstance;
        String deleteOutput = new soapSforceComSchemasClassLeadmanipu.LeadManipulatorSoapService().deleteLeadInstance('abcdef459','fedcba459' , '41235346','abcdef@fedcba.com459');
        
        System.assertEquals('Deleted', deleteOutput );
    }
}