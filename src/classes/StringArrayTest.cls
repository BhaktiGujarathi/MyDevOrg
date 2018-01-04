public class StringArrayTest{
    
    public static List<string> strList = new List <string>();
    
    public StringArrayTest(){
    }
    
    public static List<string> generateStringArray(integer num){
        
        for(integer j=0; j < num; j++){
            string s = 'Test '+j;
            strList.add(s);
        }
        return strList;
    }



}