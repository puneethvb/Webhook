public with sharing class UtilExamples implements Comparable {

    Integer x;
    String y;

    public UtilExamples(Integer x, String y){
        this.x = x;
        this.y = y;
    }

    public Integer compareTo(Object obj){

        UtilExamples util = (UtilExamples)obj;
        
        if(x == util.x){
            return 0;
        }

        if(x > util.x)
        return 1;

        return -1;

    }  
}