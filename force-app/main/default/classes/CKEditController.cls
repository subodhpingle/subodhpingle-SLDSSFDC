public class CKEditController
{
    public string Parameter{get; set;}
    public CKEditController()
    {
        Parameter = ApexPages.currentPage().getParameters().get('p7');
        system.debug(Parameter);
       
    //    return null;
    }
}