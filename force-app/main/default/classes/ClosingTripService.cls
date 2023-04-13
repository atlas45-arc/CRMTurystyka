public with sharing class ClosingTripService implements Queueable {
 
    public static void execute(QueueableContext context) {
        runClosingTrip();

    }
    public static void runClosingTrip(){
        List<Trip__c> trips = [SELECT Id, Trip_date__c,Date_of_payment__c,status__c FROM Trip__c];
        List<Trip__c> tripsToUpdate = new List<Trip__c>();
        
        Date today = Date.today();
        
        for (Trip__c obj : trips) {
            if (obj.Trip_date__c == today) {
                obj.status__c='done';
                tripsToUpdate.add(obj);
            }
        }
        for (Trip__c obj : trips) {
            if ((obj.Date_of_payment__c == today) && (obj.status__c == 'open booking)')) {
        
                obj.status__c = 'closed booking';
                tripsToUpdate.add(obj);
            }
        }
        update tripsToUpdate;
    }


}
