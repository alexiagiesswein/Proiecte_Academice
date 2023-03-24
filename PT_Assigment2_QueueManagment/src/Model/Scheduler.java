package Model;

import java.util.ArrayList;
import java.util.List;

public class Scheduler {
    private ArrayList<Server> servers;
    private Strategy strategy;

    public Scheduler(int maxNoServers,int maxTasksPerServer,SelectionPolicy selectionPolicy){
        changeStrategy(selectionPolicy);
        servers=new ArrayList<>();
        for(int i=0; i<maxNoServers; i++){
          Server s= new Server(maxTasksPerServer);
          servers.add(s);
          Thread t= new Thread(s);
          t.start();
        }
    }

    public void changeStrategy(SelectionPolicy policy){

        if(policy == SelectionPolicy.SHORTEST_QUEUE){
            strategy=new ConcreteStrategyQueue();
        }
        if(policy == SelectionPolicy.SHORTEST_TIME){
            strategy=new ConcreteStrategyTime();
        }
    }

    public void dispatchTask(Task t){
     strategy.addTask(servers,t);
    }
    public ArrayList<Server> getServers(){
        return servers;
    }
    public Strategy getStrategy(){
        return strategy;
    }
}
