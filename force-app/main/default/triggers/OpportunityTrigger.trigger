trigger OpportunityTrigger on Opportunity (before update) {
    new OpportunityHelper().run();
}