public class ContentController1 {
    public blob file { get; set; }

    public PageReference upload() {
        ContentVersion v = new ContentVersion();
        v.versionData = file;
        v.title = 'testing upload';
        v.pathOnClient ='/somepath.txt';
        insert v;
        return new PageReference('/' + v.id);
    }
}