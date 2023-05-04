trigger OpportunityTripTrigger on Opportunity_Trip__C (before insert, before update) {
    new OpportunityTripHelper().run();
}