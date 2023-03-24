package Model;

import java.nio.file.attribute.UserDefinedFileAttributeView;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.atomic.AtomicInteger;

public class Server implements Runnable {
    private ArrayBlockingQueue<Task> tasks;
    private AtomicInteger waitingPeriod;

    public void setTasks(ArrayBlockingQueue<Task> tasks) {
        this.tasks = tasks;
    }

    public AtomicInteger getWaitingPeriod() {
        return waitingPeriod;
    }

    public void setWaitingPeriod(AtomicInteger waitingPeriod) {
        this.waitingPeriod = waitingPeriod;
    }

    public Server(int numberOfClients){
       tasks= new ArrayBlockingQueue<Task>(numberOfClients);
       waitingPeriod = new AtomicInteger(0);
    }
    public void addTask(Task newTask){
     tasks.add(newTask);
     waitingPeriod.addAndGet(newTask.getServiceTime());
    }
    @Override
    public void run() {
        while(SimulationManager.running.get()){
          Task t=tasks.peek();
          if(t!=null){
              int x=t.getServiceTime();
              for(int i=0;i<x;i++){
                  try {
                      Thread.sleep(500);
                  } catch (InterruptedException e) {
                      e.printStackTrace();
                  }
                  waitingPeriod.addAndGet(-1);
                  t.setServiceTime(t.getServiceTime()-1);
              }
            tasks.remove();
          }
          else {
              try {
                  Thread.sleep(500);
              } catch (InterruptedException e) {
                  e.printStackTrace();
              }
          }
        }

    }

    public ArrayBlockingQueue getTasks(){

        return tasks;
    }

    public String toString(){
        if(tasks.size()==0)
            return "closed";
        String s="";
        for(Task task:tasks){
            s+=task+" ";
        }
        return s;
    }
}
