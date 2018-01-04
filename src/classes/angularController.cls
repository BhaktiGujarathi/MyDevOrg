global class angularController {
    public List<Account> accountList;
    @remoteAction
    global Static string getAccountList() {
        List<Account> accountList = new List<Account> ([SELECT Id,
                                                               Name,
                                                               AccountNumber,
                                                               Website,
                                                               Phone
                                                        FROM Account
                                                        Order By Name]);
        List<AccountWrapper> wrapperList = new List<AccountWrapper>();
        for(Account accountIterator : accountList) {
            wrapperList.add(new AccountWrapper(accountIterator.Id,
                                               accountIterator.Name,
                                               accountIterator.AccountNumber,
                                               accountIterator.Website,
                                               accountIterator.Phone
                                              )
                           );
        } 
        System.debug('>>>wrapperList' +wrapperList);
        return Json.serialize(wrapperList);
    }  
    
    public class AccountWrapper {
        private Id accoutnId;
        private String accountName;
        private String accountNumber;
        private String accountWebsite;
        private String accountPhone;
           public AccountWrapper(Id pId, String pName, String pNumber, String pWebsite, String pPhone) {
               accoutnId = pId;
               accountName = pName;
               accountNumber = pNumber;
               accountWebsite = pWebsite;
               accountPhone = pPhone;
           } 
    }
}