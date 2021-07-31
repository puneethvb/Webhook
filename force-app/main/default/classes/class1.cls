public virtual class class1{
public String str1 = 'abc';
public string str2 {
get{
if(str2 == null) 
str2 = '12345';
return str2; 
}
set;
}
public class1(){
system.debug('I am constructor from base class');
}
public virtual void meth1(){
system.debug('I am meth1 from base class');
}

public virtual void meth2(){
system.debug('I am meth2 from base class');

}
public void meth3(){
system.debug('I am meth3 from base class');
}

}