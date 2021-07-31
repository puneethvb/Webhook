public with sharing class JSONUtils {
    public class serial1{
        String p1;
        String p2;
        Integer P3;

        public serial1(String p1, String p2, Integer p3){
            this.p1 = p1;
            this.p2 = p2;
            this.p3 = p3;
        }
    }

    public void roundTRip(){
        FutureMeth.generateError();
        serial1 s1 = new serial1('Lewis','Sebastien',14);
        serial1 s2 = new serial1('Fernando','MAx',44);
        List<serial1> slist = new List<serial1>();
        slist.add(s1);
        slist.add(s2);
        String des = JSON.serialize(slist);
        System.debug('Serialized :'+des);
        List<serial1> slist1 = (List<serial1>)JSON.deserialize(des,List<serial1>.Class);
        System.debug('deserialized: '+slist1);
    }

    public void generate(){
        List<Integer> intList = new List<Integer>();
        serial1 s2 = new serial1('Fernando','MAx',44);
        intList.add(1);
        intList.add(2);
        intList.add(3);
        JSONgenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeStringField('Champ','Alonso');
        gen.writeFieldName('OBJ');
        gen.writeStartObject();
        gen.writeObjectField('Number Array',intList);
        gen.writeEndObject();
        //gen.writeStartObject();
        gen.writeFieldName('String Array');
        gen.writeObject(s2);
        gen.writeEndObject();

        System.debug(gen.getAsString());


    }

}