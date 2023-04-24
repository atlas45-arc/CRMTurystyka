public with sharing class TripMailReminder {
    public static void sendMailReminder() {
        List<participation__c> participations= new List<participation__c>();
        Set<ID> tripsId= new Set<ID>();
        Set<ID> accountsID= new Set<ID>();
        List<Contact> contacts = new List <Contact>();
        List<Trip__c> trips = new  List<Trip__c>();

        trips =
        [
        SELECT Id, Trip_date__c, Date_of_payment__c, status__c, Day_when_reminder_will_be_sent__c
        FROM Trip__c WHERE Day_when_reminder_will_be_sent__c =:Date.today()
        ];

        for(Trip__c trip : trips){
            tripsId.add(trip.id);
        }


        participations =
        [
        SELECT Id, Account__c
        FROM participation__c
        WHERE Trip__c in :tripsId
        ];

        for(participation__c participant : participations){
            accountsID.add(participant.Account__c);
        }


        contacts =
        [
        SELECT Id, Email
        FROM Contact
        WHERE AccountId in:accountsID
        ];

        for(Contact contact : contacts){
            List<String> address = new List<String>();
            address.add(contact.email);
            SendEmailTemplateWithoutTemplate(address);
           
        }

    
    }
    public static void SendEmailTemplateWithoutTemplate(List<String> address ) {
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
                
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setSubject('The date of the trip is approaching');
        mail.setplaintextbody('Hi, we remind you about your trip that will take place' + Date.today()+ 7+ ' , have fun');
        mail.setToAddresses(address);
        emailList.add(mail);
            System.debug(emailList);
        if(!emailList.isEmpty()){
            Messaging.sendEmail(emailList);
        }	   
    } 
}