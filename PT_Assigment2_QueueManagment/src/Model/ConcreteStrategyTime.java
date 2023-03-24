package Model;

import java.util.List;

public class ConcreteStrategyTime implements Strategy{
    public int totalWaitingTIme=0;
    @Override
    public void addTask(List<Server> servers, Task t) {

        int minim=Integer.MAX_VALUE;
        Server aux = null;
        for(Server s:servers){
            if(s.getWaitingPeriod().get()<minim){
                minim=s.getWaitingPeriod().get();
                aux=s;
            }
        }
        totalWaitingTIme+=aux.getWaitingPeriod().get();
        aux.addTask(t);
    }
    public int getTotalWaitingTIme(){
        return totalWaitingTIme;
    }
}
