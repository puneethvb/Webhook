public class ListViewButtonDemo {
    public List<Opportunity> opportunities{get;private set;}
    public ListViewButtonDemo(ApexPages.StandardSetController stdSetController){
        // Returns all selected records
        opportunities = (List<Opportunity>) stdSetController.getSelected();
    }
    public PageReference save(){
        PageReference pr = new ApexPages.Action('{​!List}​').invoke();
        //pr.setRedirect(true);
        return pr;
    }

    public PageReference save1(){
        return new ApexPages.Action('{​!list}​').invoke();
    }
}