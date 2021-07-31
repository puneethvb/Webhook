public with sharing class VfExampleCont {
    
    String state = 'no';
    public Integer counter{get{
        if(counter == null)
        counter = 0;
        return counter;
    }set;}
    public List<String> strings{
        get{
            if(strings == null){
                strings = new List<String>();
                for(Integer i = 0; i<10; i++){
                    strings.add('Test'+i);
                }
            } 
            return strings;
        }
        set;}

    public String getState(){
        return state;
    }
    
    public Pagereference actFun(){

        return null;
    }

    public void setState(String a){
        state = a;
    }

    public Pagereference increaseCount(){
        counter++;
        return null;

    }
}