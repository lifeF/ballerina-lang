import ballerina/io;
import ballerina/math;
import ballerina/runtime;
import ballerina/task;

int app1Count = 0;
task:Appointment? appointment1 = ();

public function main() {
    worker w1 {
        io:println("------------- Scheduling Appointments -------------");

        (function() returns error?) onTriggerFunction = appointment1Cleanup;
        (function(error)) onErrorFunction = cleanupError;

        //job 1 runs every 20 seconds.
        appointment1 = new task:Appointment(onTriggerFunction,
                                            onErrorFunction,
                                            "0/20 * * * * ?");

        appointment1.schedule();

        //job 2 runs every other minute (at 15 seconds past the minute).
        onTriggerFunction = appointment2Cleanup;
        task:Appointment appointment2 =
                  new task:Appointment(onTriggerFunction,
                                       onErrorFunction,
                                       "15 0/2 * * * ?");

        appointment2.schedule();

        //job 3 runs every other minute but only between 8am and 5pm.
        onTriggerFunction = appointment3Cleanup;
        task:Appointment appointment3 =
                  new task:Appointment(onTriggerFunction,
                                       onErrorFunction,
                                       "0 0/2 8-17 * * ?");

        appointment3.schedule();

        //job 4 runs every three minutes but only between 5pm and 11pm.
        onTriggerFunction = appointment4Cleanup;
        task:Appointment appointment4 =
                  new task:Appointment(onTriggerFunction,
                                       onErrorFunction,
                                       "0 0/3 17-23 * * ?");

        appointment4.schedule();

        //job 5 runs at 10am on the 1st and the 15th days of the month.
        onTriggerFunction = appointment5Cleanup;
        task:Appointment appointment5 =
                  new task:Appointment(onTriggerFunction,
                                       onErrorFunction,
                                       "0 0 10am 1,15 * ?");

        appointment5.schedule();

        //job 6 runs every 30 seconds but only on weekdays
        // (i.e., Monday through Friday).
        onTriggerFunction = appointment6Cleanup;
        task:Appointment appointment6 =
                  new task:Appointment(onTriggerFunction,
                                       onErrorFunction,
                                       "0,30 * * ? * MON-FRI");

        appointment6.schedule();

        //job 7 runs every 30 seconds but only on weekends
        // (i.e., Saturday and Sunday).
        onTriggerFunction = appointment7Cleanup;
        task:Appointment appointment7 =
                  new task:Appointment(onTriggerFunction,
                                       onErrorFunction,
                                       "0,30 * * ? * SAT,SUN");

        appointment7.schedule();

        runtime:sleep(60000); // Sleep thread to avoid exiting
    }
    wait w1; // Wait for the worker to finish.
}

function appointment1Cleanup() returns (error?) {
    io:println("Appointment#1 cleanup running...");
    app1Count = app1Count + 1;
    if (app1Count == 5) {
        io:println("Stopping Appointment#1 cleanup task since it
                       has run 5 times");

        // This is how you cancel an appointment.
        appointment1.cancel();
    }
    return cleanup();
}

function appointment2Cleanup() returns (error?) {
    io:println("Appointment#2 cleanup running...");
    return cleanup();
}

function appointment3Cleanup() returns (error?) {
    io:println("Appointment#3 cleanup running...");
    return cleanup();
}

function appointment4Cleanup() returns (error?) {
    io:println("Appointment#4 cleanup running...");
    return cleanup();
}

function appointment5Cleanup() returns (error?) {
    io:println("Appointment#5 cleanup running...");
    return cleanup();
}

function appointment6Cleanup() returns (error?) {
    io:println("Appointment#6 cleanup running...");
    return cleanup();
}

function appointment7Cleanup() returns (error?) {
    io:println("Appointment#7 cleanup running...");
    return cleanup();
}

function cleanup() returns (error?) {
    io:println("Cleaning up");
    if (math:randomInRange(0, 10) == 5) {
        error e = error("Cleanup error");
        return e;
    }
    return ();
}

function cleanupError(error e) {
    io:print("[ERROR] cleanup failed");
    io:println(e);
}
