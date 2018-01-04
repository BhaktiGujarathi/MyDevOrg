/***************************************************************************************************
 *  Title              : Controller Class VF page to display history of queries
 *  Controller Class   : ResponsesToQueryController
 *  Author             : Bhakti Gujarathi
***************************************************************************************************/

public with sharing class ResponsesToQueryController {
    public List<Response_Item__c> resultResponseList{get; set;}
    public Id queryId{get; set;}
    public boolean resultFlag{get; set;}
    public List<Query__c> queryList;
    
    //instantiate the StandardSetController from a query locator
    public ApexPages.StandardSetController setOfQuery {
        get {
            if(setOfQuery == NULL) {
                setOfQuery = new ApexPages.StandardSetController(
                    Database.getQueryLocator([
                        SELECT Name,
                               Query_Text__c
                          FROM Query__c
                      ORDER BY Name
                    ])
                );
                setOfQuery.setPageSize(5);
            }
            return setOfQuery;
        }
        set;
    }
    
    // indicates whether there are more records after the current page set.
    public Boolean hasNext {
        get {
            return setOfQuery.getHasNext();
        }
        set;
    }

    // indicates whether there are more records before the current page set.
    public Boolean hasPrevious {
        get {
            return setOfQuery.getHasPrevious();
        }
        set;
    }

    // returns the page number of the current page set
    public Integer pageNumber {
        get {
            return setOfQuery.getPageNumber();
        }
        set;
    }

    // returns the first page of records
     public void first() {
         setOfQuery.first();
     }

     // returns the last page of records
     public void last() {
         setOfQuery.last();
     }

     // returns the previous page of records
     public void previous() {
         setOfQuery.previous();
     }

     // returns the next page of records
     public void next() {
         setOfQuery.next();
     }

     // returns the PageReference of the original page, if known, or the home page.
     public void cancel() {
         setOfQuery.cancel();
     }
     
     //returns List of all queries 
     public List<Query__c> getqueryList() {
         queryList = (List<Query__c>)setOfQuery.getrecords();
         return queryList;
     }
     
     //method to reset the flag 
     public void showresults() {
         resultFlag = true;
         resultResponseList = fetchresultResponseList();
     }
     
     //returns list of all related responses
     public List<Response_Item__c> fetchresultResponseList() {
         queryId = apexPages.currentPage().getParameters().get('idOfParent');
         resultResponseList = [SELECT Id,
                                      Name,
                                      Response_Title__c,
                                      Response_Link__c,
                                      Response_Description__c
                               FROM Response_Item__c
                               WHERE For_Query__c = :queryId];
         return resultResponseList;
     }
}