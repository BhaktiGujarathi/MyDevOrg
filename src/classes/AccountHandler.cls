public class AccountHandler{

    public static Account insertNewAccount(string nme){
        
        Account acc = new Account(name =nme);
        
        try{
            insert acc;
            return acc;
        }
        catch(exception e)
        {
            return null;
        }
    }

}