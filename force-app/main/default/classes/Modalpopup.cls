public class Modalpopup{       
public boolean gre{get;set;}
     public Boolean displayselrecord { get; set; }    
    public id id1{get; set;}    
    public List<Account> mycar{set; get;}
    public Account selectedcar{ set; get; }    
public Modalpopup (){
mycar = [select Name, Rating from Account];
}
public PageReference RecordId() {
    system.debug('id:valueeeeeeeeeeeeeeeeeee::::'+id1);
    selectedcar=[select Name, Rating from Account where id = : id1];
   displayselrecord = true;
    return null;        
}
public PageReference closepopup() {
     displayselrecord = false;     
        return null;
    }
 public PageReference Updatepopup() {
       update selectedcar;
                     mycar = [select Name, Rating from Account];
       displayselrecord = false;
        return null;
    }
}