public class iftest {
    public integer acclimit { get; set;}
    public integer total { get; set;}
    public list<account> acclist { get; set;}
     
    public iftest(){
        acclimit = 5;
        total = [select count() from account];
        acclist = [select id, name from account limit :acclimit];
    }
     
    public void allacc(){
        acclist = [select id, name from account];
    }
}