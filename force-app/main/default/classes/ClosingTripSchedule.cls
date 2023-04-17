public with sharing class ClosingTripSchedule implements Schedulable  {
    public void execute(SchedulableContext context){
        System.enqueueJob(new ClosingTripService());


    }
}