/* A Controller Class to hold the functionality if VF page for dynamic SOSL query */
public with sharing class DynamicApexPageController {

    public Map<String, Schema.SObjectType> mapObjectToType = Schema.getGlobalDescribe();
    public String query{get;set;} //string to hold query
    public String sortBy{get;set;} //string to hold sortby method
    public String searchString{get; set;} //string to hold string to be searched
    public Integer maxRecordsToDisp{get;set;} //integer to hold Limit of query
    public String SelectedObjectType{get;set;} //string to hold the selected object
    public List<SelectOption> objectTypes = new List<SelectOption>();  //list to hold the 
                                                                      //selectoptions of objecttypes
    public List<SelectOption> objFields = new List<SelectOption>();
    public List<SelectOption> selectedFields = new List<SelectOption>();
    public Set<String> objFieldsValues{get;set;} //set to hold field values 
    public List<sObject> sList{get; set;} // list to hold the result at 0th index of sosl query 
    public List<String> fList{get; set;} //list to hold string list of selected fields
    public List<List<SObject>> listRecords{get; set;} //to hold result of SOSL query
    public List<String> fieldsToUnselect{get;set;} //list of fields to be removed 
    public Boolean field{get;set;} //flag to set rendering as false
    //public Boolean objFlag {get; set;}
    public List<String> FieldsForQuery{get;set;} 
    public Set<String> selectedFieldsValue{get;set;}
    public List<Sobject> objList {get; set;}
    public map<String, Set<String>> mapObjectToSelectedFields;
    public Map<Schema.SObjectType, WrappRecordsAndFieldsAndObject> mapObjectToWrapper;
    public List<WrappRecordsAndFieldsAndObject> searchResultsInstance{get; set;}
    //public Set<string> tempList;

    // contructor for controller class
    public DynamicApexPageController(){ 
        fieldsToUnselect = new  List<String>();
        objFields = new List<SelectOption>();
        field = false;
        //objFlag = false;
        selectedFields = new List<SelectOption>();
        selectedFieldsValue = new  Set<String>();
        sList = new List<sObject>();
        fList = new List<String>();
        listRecords = new List<List<SObject>>();
        objList = new List<Sobject> ();
        mapObjectToSelectedFields = new map<String, Set<String>>();
        //mapIdToObject = new Map<Id, String>();
        //tempList = new Set<String>();
        objFieldsValues = new set<String>();
        mapObjectToWrapper = new Map<Schema.SObjectType, WrappRecordsAndFieldsAndObject>();
        searchResultsInstance = new List<WrappRecordsAndFieldsAndObject>();
        sortby = 'ASC';
    }
    
    // list to hold select options of fields for selectedObject
    public List<SelectOption> getobjFields() { 
          
            objFields.clear();
            for(String s : objFieldsValues){
               objFields.add(new selectOption (s,s));    
            }
            return objFields;    
        
    }
        
    // list to hold select options of selectedfields for selectedObject
    public List<SelectOption> getselectedFields() {
            selectedFields.clear();
            for(String s : selectedFieldsValue){
                selectedFields.add(new selectOption(s,s));
            }
            return selectedFields;
        }

    //
    
    public List<SelectOption> getobjectTypes(){
        objectTypes.clear();
        for(String objType : mapObjectToType.keySet()){
            if(mapObjectToType.get(objType).getDescribe().isSearchable() == true) {
                objectTypes.add(new selectOption(objType,objType));
            }
        } 
        objectTypes.sort();
        return objectTypes;    
    } 
    
    public void generateobjFields(){
        objFieldsValues = new Set<String>();
        field=true;
        Schema.Sobjecttype SelectedObject = Schema.getGlobalDescribe().get(SelectedObjectType);
        for(String field : SelectedObject.getDescribe().fields.getMap().keyset()){
            
            objFieldsValues.add(field);
        }   
        system.debug('-------------------------'+objFieldsValues);  
    }
    
    public void selectFields(){ 
        
        system.debug('B4 remove-->'+objFieldsValues.size());
        for(String temp : FieldsForQuery){ 
            selectedFieldsValue.add(temp);
            objFieldsValues.remove(temp);
            //selectedFields.add(new selectOption(temp,temp));
        }
        
        system.debug('after remove-->'+objFieldsValues.size());
    }
    
    public void deSelectFields(){
        system.debug('*************************');
        //system.debug('B4 remove-->'+objFieldsValues.size());
        for(String temp : fieldsToUnselect){ 
            objFieldsValues.add(temp);
            selectedFieldsValue.remove(temp);
            //remove selected fields here  
        }
        system.debug('after remove-->'+objFieldsValues.size());
    }
    
    public void generateQuery(){
        //addToMapObjectToWrapper();
       
       /* String fieldsToBeUsed ='';
        for(SelectOption sOp : selectedFields){ 
            fieldsToBeUsed=fieldsToBeUsed+sOp.getValue()+',';
            fList.add(sOp.getValue());
       } */
      //mapObjectToSelectedFields.put(selectedObjectType, fList);
       //fieldsToBeUsed = fieldsToBeUsed.removeEnd(',');
       //system.debug('111111.....searchString'+searchString);
       //system.debug('222222.....selectedObjectType'+selectedObjectType);
       ///system.debug('333333.....selectedFields[0].getValue()'+fList);
       //system.debug('444444.....sortBy'+sortBy);
       
        
            /*query = 'FIND' +' {'+searchString +'} ' +' '+'IN'+' '+'ALL FIELDS RETURNING ';
            query +=' '+selectedObjectType+ ' ' +fList;
            query  = query.removeEnd(')');
            query +=' ORDER BY id ' +sortBy+ ' ) LIMIT '+maxRecordsToDisp;*/
          
          
           query = 'FIND' +' {'+searchString +'} ' +' '+'IN'+' '+'ALL FIELDS RETURNING ';
            for(String str1 : mapObjectToSelectedFields.keySet()) {
                query += ' '+str1+ ' (';
                set<String> stringSet =  mapObjectToSelectedFields.get(str1);
                for(String stringtemp : stringSet) {
                 query += ' ' + stringtemp+ ' ,';
                }
                query  = query.removeEnd(',');
                query += ' ),';
            }
             query  = query.removeEnd(',');
             query  = query.removeEnd(')');
             query +=' ORDER BY name ' +sortBy+ ' ) LIMIT '+maxRecordsToDisp;
             //query +=' LIMIT'+' '+maxRecordsToDisp;   
             system.debug('##########' +query);
              
              
              
              /*String findkeyword = 'FIND';
              String inputSearchValue = searchString;
              String objectAndField='';
             for(String objectInstance : mapObjectToSelectedFields.keySet()) {
                
                objectAndField +=' '+ objectInstance + '(';
                Set<String> setOfFeilds =  mapObjectToSelectedFields.get(objectInstance);
                for(String nameOfField : setOfFeilds) 
                {
                    objectAndField += ' ' + nameOfField+ ' ,';
                }
                objectAndField  = objectAndField.removeEnd(',');
                objectAndField +=' ' + 'ORDER BY';
                objectAndField +=' ' + 'Name' + ' ' + sortby ;
                objectAndField += ' ),';
        }
        objectAndField=objectAndField.removeEnd(',');
        
        String returningFields='FIELDS RETURNING';
        
        query= (findkeyword +' {'+inputSearchValue +'} ' + ' ' + 'IN' + ' ' + 'ALL' + ' '
             + returningFields + ' ' + objectAndField + 'LIMIT' + ' ' + maxRecordsToDisp);
        System.debug(query);*/
    }
    
     public void executeQuery(){
         
         addToMapObjectToWrapper();
         generateQuery();
         system.debug('>>>>>>>>mapObjectToSelectedFields>>>>>>>>'+mapObjectToSelectedFields);
       if(searchString.length() == 0 ) { 
            apexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Invalid Query!!'));
        }
        else {
            try {
            listRecords = Search.Query(query);
            system.debug('++++++++++++listRecords++++++++++++'+listRecords);
            }
            catch(Exception e) {
                System.Debug('error message'+e.getMessage());
            }
        }
        
     }
        public List<WrappRecordsAndFieldsAndObject> getsearchResultsInstanceforresult() {
             if(listRecords != null) {
             for(List<SObject> listInstance : listRecords) {
                
                String sObjectTypeName = listInstance.getSObjectType().getDescribe().getLabel();
                system.debug('>>>>>>>>>>>>>>>>>>>>>>>>'+sObjectTypeName);
                if(mapObjectToWrapper.containsKey(mapObjectToType.get(sObjectTypeName))) {
                    WrappRecordsAndFieldsAndObject wrapInstance = new WrappRecordsAndFieldsAndObject();
                    wrapInstance = mapObjectToWrapper.get(mapObjectToType.get(sObjectTypeName));
               //system.debug('>>>>>>>>>>>>>>>>>>>>>>>>'+mapWithObjectAndWrapper.get(sObjectTypeName));
            
                    wrapInstance.sobjRecordList.addAll(new List<SObject>(listInstance));
                    System.debug('>>>>>>>>>>111111listInstance>>>>>>>>>>'+listInstance);
                    System.debug('>>>>>>>>>>222222wrapInstance>>>>>>>'+wrapInstance);
                    mapObjectToWrapper.put(mapObjectToType.get(sObjectTypeName), wrapInstance);
                    System.debug('>>>>>>>>>>333333333mapObjectToWrapper>>>>>>>'+mapObjectToWrapper);
                    //searchResultsInstance.add(wrapInstance);
                    System.debug('>>>>>>>>>>44444444searchResultsInstance>>>>>>>'+searchResultsInstance);
                }
              }
              searchResultsInstance.clear();
                 
                 if(!mapObjectToWrapper.values().isEmpty()){
                    
                    searchResultsInstance.addAll(mapObjectToWrapper.values());
                 } 
            }
            return searchResultsInstance; 
        } 

    
    public void addNewObject() {
        addToMapObjectToWrapper();
        objFields.clear();
        objFieldsValues.clear();
        selectedFieldsValue.clear();
        selectedObjectType = '';
        //fList.clear();
        selectedFields.clear();
        //system.debug('::::::mapObjectToSelectedFields  '+mapObjectToSelectedFields);
    }
    
    //method to add sobjecttype and its wrapper holding the fieldList in a map
    public void addToMapObjectToWrapper() {
        if(selectedObjectType <> NULL) {
         if(!mapObjectToWrapper.containsKey(mapObjectToType.get(selectedObjectType))) {
            System.debug('************************ SOBJECT NAME : \n\n\n\n' + selectedObjectType);
         WrappRecordsAndFieldsAndObject wrapInstance = new WrappRecordsAndFieldsAndObject();
         wrapInstance.sobjName = selectedObjectType;
         for(String strfieldInstance : selectedFieldsValue) {
            wrapInstance.strFieldList.add(strfieldInstance);
         }
         mapObjectToWrapper.put(mapObjectToType.get(selectedObjectType), wrapInstance);
        }
         
       
        if(!mapObjectToSelectedFields.containsKey(selectedObjectType)) {
            mapObjectToSelectedFields.put(selectedObjectType, new set<String>(selectedFieldsValue));
        }
        else {
            mapObjectToSelectedFields.put(selectedObjectType,selectedFieldsValue);
        }
        }
       
        system.debug('>>>>>>>>mapObjectToSelectedFields>>>>>>>>'+mapObjectToSelectedFields); 
    }
    
    
    //wrapper class to hold  list of recods and list of list of fields for a particular object
    public class WrappRecordsAndFieldsAndObject {
        public List<SObject> sobjRecordList{get; set;}
        public List<String> strFieldList{get; set;}
        public String sobjName{get; set;}
        public WrappRecordsAndFieldsAndObject() {
            sobjRecordList = new List<SObject>();
            strFieldList = new List<String>();
        }
    }
}

/*>>>>mapObjectToSelectedFields
>>>>Query
>>>>List<List<SObject>>
>>>>1st List instance Of List<List<SObject>>
....*/