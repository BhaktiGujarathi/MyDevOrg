public virtual class BaseParentClass {
    public WrapperClass wrprObj;
    
    public BaseParentClass() {
        wrprObj = new WrapperClass();
        wrprObj.NameStr = 'Bhakti';
        wrprObj.birthYear = 1993;
        wrprObj.age = 2017 - wrprObj.birthYear;
    }
    
    public class WrapperClass {
        public String NameStr;
        public Integer birthYear;
        public Integer age; 
        public WrapperClass() {
            NameStr = '';
            birthYear = 00;
            age = 00;
        }
    }
}