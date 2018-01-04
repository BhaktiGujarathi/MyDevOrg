public class ContactAndLeadSearch{
    public static List<List<Sobject>> searchContactsAndLeads( string parameter){
            return [FIND :parameter IN NAME FIELDS RETURNING Contact(Name),Lead(Name)];
    
    }

}