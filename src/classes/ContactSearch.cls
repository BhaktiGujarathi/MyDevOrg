public class ContactSearch{
    
    public static List<contact> searchForContacts( string n,string l){
        
        return [select id,name from contact where mailingpostalcode = :l and lastname = :n];
    
    }

}