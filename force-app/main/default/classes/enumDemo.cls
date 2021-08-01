public with sharing class enumDemo {
    
    public enum Sports {Football, Formula1, Tennis, IPL }

    public static void enumMethods(){

        Sports sp = Sports.Football;

        system.debug(sp);
        system.debug(Sports.Football.ordinal());
        system.debug(Sports.Football.name());
        system.debug(sports.values());
    }
}
