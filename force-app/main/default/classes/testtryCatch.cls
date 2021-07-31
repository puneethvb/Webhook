public class testtryCatch{

public static void abcde(){
Integer i =0;
try{
 i = 1/0;
}
catch(Exception ex){
system.debug('Hi in Exception');
}
System.debug('I am Still here');
}
}