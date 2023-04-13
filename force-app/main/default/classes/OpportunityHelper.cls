public with sharing class OpportunityHelper extends TriggerHandler{
    public override void beforeUpdate() {
        Map<Id, Opportunity> newOppMap = (Map<Id,Opportunity>)trigger.newMap;
        Map<Id, Opportunity> oldOppMap = (Map<Id,Opportunity>)trigger.oldMap;
        Map<Id, Opportunity> secondStepOps = new Map<Id,Opportunity>();
        List<Opportunity_Trip__c> trips = new List<Opportunity_Trip__c>();
        List<Opportunity_Trip__c> tripsForUpdate = new List<Opportunity_Trip__c>();
        List<Participation__c> participationsForInsert = new List<Participation__c>();

        
        for(Opportunity opp : newOppMap.values()){
            if(opp.StageName == 'Closed Won'){
                if(oldOppMap.get(opp.id).StageName != 'Closed Won'){
                    secondStepOps.put(opp.id,opp);
                }
            }
        }

        trips = [SELECT Id, Name,trip__c,Status__c, Opportunity__c,Entire_Cost__c,Number_of_reservations__c FROM Opportunity_Trip__c WHERE Opportunity__c IN :secondStepOps.keySet()];
System.debug(trips);
    
   

        for(Opportunity_Trip__c ot :trips){
            if(ot.status__c != 'Fullpaid' && ot.status__c != 'Closed Won' 
            && ot.status__c != 'Closed Lost'){
                ot.status__c='Closed Lost';
                tripsForUpdate.add(ot);
            }

            if(ot.status__c == 'Fullpaid'){
                Participation__c parti = new Participation__c();
                parti.Entire_Cost__c=ot.Entire_Cost__c;
                System.debug(secondStepOps.get(ot.Opportunity__c));
                parti.account__c=secondStepOps.get(ot.Opportunity__c).AccountId;
                parti.trip__c=ot.trip__c;
                parti.Number_of_reservations__c=ot.Number_of_reservations__c;
                participationsForInsert.add(parti);

                ot.status__c='Closed Won';
                tripsForUpdate.add(ot);
            }

        }

        
        

        System.debug(participationsForInsert);
        update tripsForUpdate;
        insert participationsForInsert;





    }
}