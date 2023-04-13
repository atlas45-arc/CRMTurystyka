public with sharing class ClosingTripSchedule implements Schedule {
    public void execute(SchedulableContext context){
        System.enqueueJob(new ClosingTripService());


    }
}