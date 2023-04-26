public with sharing class ParticipationHelper extends TriggerHandler {
    public  override void beforeUpdate() {
        Map<Id, Participation__c> participationNew = (Map<Id,Participation__c>)trigger.newMap;
        System.debug('pizda');
        countingEntireCost(participationNew);
    }
    public  override void beforeInsert() {
        Map<Id, Participation__c> participationNew = (Map<Id,Participation__c>)trigger.newMap;
        System.debug('pizda');

        countingEntireCost(participationNew);
    }

    public static void countingEntireCost(Map<Id, Participation__c> participationNew){
        Map<Id, Trip__c> trips = new Map<Id, Trip__c>([SELECT Id, Cost_per_participant__c FROM Trip__c WHERE Id IN :participationNew.keySet()
        


        ]);
        System.debug('pizda');

        for(Participation__c participation : participationNew.values()){
            System.debug( participation.Entire_Cost__c+'='+trips.get(participation.Trip__c).Cost_per_participant__c+'*'+participation.Number_of_reservations__c);
            if(  participation.Entire_Cost__c== null){
                participation.Entire_Cost__c= 0;
            }
            participation.Entire_Cost__c= trips.get(participation.Trip__c).Cost_per_participant__c * participation.Number_of_reservations__c;
            System.debug( participation.Entire_Cost__c+'='+trips.get(participation.Trip__c).Cost_per_participant__c+'*'+participation.Number_of_reservations__c);


        }


    }
}