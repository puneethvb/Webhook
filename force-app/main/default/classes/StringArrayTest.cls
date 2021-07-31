public class StringArrayTest{
 public static List<String> generateStringArray(Integer num){
 List<String> result = new List<String>();
 for(Integer i = 0; i<num;i++){
 String res = 'Test '+i;
 result.add(res);
 }
 return result;
 }
}