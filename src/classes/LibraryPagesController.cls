public with sharing class LibraryPagesController {
    public Boolean loginFlag{get; set;}
    public Boolean registerationFlag{get; set;}
    public String memberName{get; set;}
    public String password{get; set;}
    
    //constructor
    public LibraryPagesController() {
        loginFlag = false;
        registerationFlag = false;
    }
    
    //method to show the block of login
    public void showLoginBlock() {
        loginFlag = true;
    }
    
    //method to show the registration block
    public void showRegisterationBlock() {
        registerationFlag = true;
    }
    
    //method to validate the login
    public void loginMethod() {
        
    }
}