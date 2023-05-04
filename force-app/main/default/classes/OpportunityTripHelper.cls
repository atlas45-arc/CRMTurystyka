public with sharing class OpportunityTripHelper extends TriggerHandler {

    public  override void beforeUpdate() {
        List<Participation__c> participationNew = trigger.new;
        countingEntireCost(participationNew);
        System.debug(participationNew);
    }

    public  override void beforeInsert() {
         List<Participation__c> participationNew = trigger.new;
        countingEntireCost(participationNew);
        System.debug(participationNew);
    }

    public static void countingEntireCost(List<Participation__c> participationNew){
        Set<Id> tripsIds = new Set<Id>();
        System.debug(participationNew);
            for (Participation__c participation : participationNew) {
                tripsIds.add(participation.Trip__c);
        }
        Map<Id, Trip__c> trips = new Map<Id, Trip__c>(
            [SELECT Id, Cost_per_participant__c, Maximum_number_of_participants__c
            FROM Trip__c 
            WHERE Id IN :tripsIds
        ]);
        for(Participation__c participation : participationNew){
            participation.Entire_Cost__c= trips.get(participation.Trip__c).Cost_per_participant__c * participation.Number_of_reservations__c;
        }
        // recountingNumberOfParticipants(trips,participationNew);
//////////////////////////////////////////////////////////////////////////////////////////////
    }
    // public static void recountingNumberOfParticipants(Map<Id, Trip__c> trips,Map<Id, Participation__c> participationNew ){
    //     Map<Id, Participation__c> participations = new Map<Id, Participation__c>([
    //         SELECT Id, Number_of_reservations__c, trip__c
    //         FROM Participation__c
    //         WHERE trip__c IN :trips.keyset()
    //     ]);
    //     System.debug(trips.keyset());
    //     System.debug(participations);
    //     System.debug(trips);

    //     for(Trip__c trip : trips.values()){
    //         System.debug(trip.id);
    //         trip.Actual_number_of_participants__c=0;
    //         for(Participation__c participation : participations.values()){
    //             System.debug(participation.trip__c);
    //             if(participation.trip__c==trip.id){
    //                 System.debug(participation);
    //                 if(trip.Actual_number_of_participants__c+participation.Number_of_reservations__c>trip.Maximum_number_of_participants__c){
    //                     String error = 'The actual number of participants is over limit';
    //                     participation.addError(error,false);
    //                 }
    //                 trip.Actual_number_of_participants__c+= participation.Number_of_reservations__c;
                    
    //         }
    //     }
    // }

    

    // System.debug(trips.values());
    // update trips.values();


    // }
}