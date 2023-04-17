public with sharing class ClosingTripService implements Queueable {
 
    public static void execute(QueueableContext context) {
        runClosingTrip();

    }
    public static void runClosingTrip(){
        List<Trip__c> trips = [SELECT Id, Trip_date__c,Date_of_payment__c,status__c FROM Trip__c];
        System.debug([SELECT Id, Trip_date__c,Date_of_payment__c,status__c FROM Trip__c where  id = 'a010900002dCB60AAG']);
        System.debug(trips);
        List<Trip__c> tripsToUpdate = new List<Trip__c>();
        List<Trip__c> tripsOfPaymentDateCheck = new List<Trip__c>();
        
        Date today = Date.today();
        
        for (Trip__c obj : trips) {
            System.debug(obj);
            if (obj.Trip_date__c == today) {
                obj.status__c='done';
                tripsToUpdate.add(obj);
                
            }else{tripsOfPaymentDateCheck.add(obj);}
        } System.debug(tripsOfPaymentDateCheck);
        for (Trip__c obj : tripsOfPaymentDateCheck) {
            System.debug(obj);
            if ((obj.Date_of_payment__c == today) && (obj.status__c == 'open booking')) {
                System.debug(obj);
                obj.status__c = 'closed booking';
                tripsToUpdate.add(obj);
            }
        }
        System.debug(tripsToUpdate);
        update tripsToUpdate;
    }


}
