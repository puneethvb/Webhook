public with sharing class batchService {
	
	public static void popMap(Map<String,String> abcde){
       Decimal num = Math.random()*100;
       abcde.put('ABC'+String.valueOf(num),'Message1');
       system.debug(abcde);
       //return abcde;
	}
}