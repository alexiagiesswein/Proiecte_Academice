package Model;

import Controller.Controller;
import View.*;

import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;
import java.util.concurrent.atomic.AtomicBoolean;

public class SimulationManager implements Runnable{

    private int timeLimit=200;
    private int maxProcessingTime=4;
    private int minProcessingTime=2;
    private int minArrivalTime=1;
    private int maxArrivalTime=100;
    private int numberOfServers=3;
    private int numberOfClients=100;
    private int currentTime;
    private SelectionPolicy selectionPolicy;
    public static AtomicBoolean running=new AtomicBoolean(true);

    private float avergaWaitingTime=0;
    private float averageServiceTime=0;
    private int peakHour=0;

    private Scheduler scheduler;
    private QueueView frame;
    private ArrayList<Task> generatedTasks;

    private FileWriter file;
    private FileWriter file2;
    private FileWriter file3;

    public SimulationManager(int timeLimit, int maxProcessingTime, int minProcessingTime, int minArrivalTime, int maxArrivalTime, int numberOfServers, int numberOfClients, SelectionPolicy selectionPolicy) {
        running.set(true);
        this.timeLimit = timeLimit;
        this.maxProcessingTime = maxProcessingTime;
        this.minProcessingTime = minProcessingTime;
        this.minArrivalTime = minArrivalTime;
        this.maxArrivalTime = maxArrivalTime;
        this.numberOfServers = numberOfServers;
        this.numberOfClients = numberOfClients;
        this.selectionPolicy = selectionPolicy;
        scheduler=new Scheduler(numberOfServers,numberOfClients,selectionPolicy);
        scheduler.changeStrategy(selectionPolicy);
        generateNRandomTasks();
        frame=new QueueView();
        try {
            file=new FileWriter("logs.txt");
            file2=new FileWriter("logs2.txt");
            file3=new FileWriter("logs3.txt");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void generateNRandomTasks(){
        generatedTasks = new ArrayList<>();
        Random r=new Random();
        for(int i=0; i<numberOfClients; i++) {
            Task t=new Task();
            t.setServiceTime(r.nextInt(maxProcessingTime-minProcessingTime+1)+minProcessingTime);
            t.setArrivalTime(r.nextInt(maxArrivalTime-minArrivalTime+1)+minArrivalTime);
            t.setId(i);
            generatedTasks.add(t);
        }
        Collections.sort(generatedTasks);
        calculateAverageServiceTime();
    }
    @Override
    public void run() {
        int maxClientsInQueue=0;
        currentTime=0;
        boolean runningFlag=true;
        while(currentTime< timeLimit&&running.get()){
            runningFlag=false;
            ArrayList<Task> toDelete=new ArrayList<>();
         for(Task t:generatedTasks){
             runningFlag=true;
             if(t.getArrivalTime()<=currentTime){
                 scheduler.dispatchTask(t);
                 toDelete.add(t);
             }
         }
         generatedTasks.removeAll(toDelete);
            try {
                Thread.sleep(500);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }

            int clientsInQueue=0;
            for(Server server: scheduler.getServers())
                if(server.getTasks().size()>0) {
                    clientsInQueue+=server.getTasks().size();
                    runningFlag=true;
                }
            if(clientsInQueue>maxClientsInQueue){
                maxClientsInQueue=clientsInQueue;
                peakHour=currentTime;
            }

            printQueues();
            frame.update(currentTime,generatedTasks,scheduler.getServers());
            currentTime++;
            running.set(runningFlag);
        }

        avergaWaitingTime=(float)scheduler.getStrategy().getTotalWaitingTIme()/numberOfClients;

        frame.updateAverages(peakHour,avergaWaitingTime,averageServiceTime);

        try {
            file3.write("Peak hour: "+peakHour+"\nAverage waiting time: "+avergaWaitingTime+"\n"+"Average service time: "+averageServiceTime);
            file3.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void printQueues(){
        try{
            file3.write("Time: "+currentTime+"\n");
            file3.write("Waiting tasks: ");
            for(Task task:generatedTasks)
                file3.write(task.toString()+" ");
            file3.write("\n");
            int i=1;
            for(Server server:scheduler.getServers()){
                file3.write("Queue " + i + ": " + server+"\n");
                i++;
            }
            file3.write("\n");
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    public void calculateAverageServiceTime(){
        averageServiceTime=0;
        for(Task t:generatedTasks){
           averageServiceTime+=t.getServiceTime();
        }

        averageServiceTime=averageServiceTime/generatedTasks.size();

    }

    public static void main(String[] args){

        View view = new View();
        Controller controller = new Controller(view);


    }
}
