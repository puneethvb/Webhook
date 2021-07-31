public class QueuableClass implements Queueable { 
    
    public void execute(QueueableContext context) {        
        System.debug('Queuable Class');
    }
}