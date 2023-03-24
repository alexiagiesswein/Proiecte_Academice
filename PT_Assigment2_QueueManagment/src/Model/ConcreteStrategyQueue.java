package Model;

import java.util.List;

public class ConcreteStrategyQueue implements Strategy{
    public int totalWaitingTIme=0;
    @Override
    public void addTask(List<Server> servers, Task t) {
        int minim=Integer.MAX_VALUE;
        Server aux = null;
        for(Server s:servers){
            if(s.getTasks().size()<minim){
                minim=s.getTasks().size();
                aux=s;
            }
        }
        totalWaitingTIme+=aux.getWaitingPeriod().get();
        aux.addTask(t);

    }

    @Override
    public int getTotalWaitingTIme() {
        return totalWaitingTIme;
    }
}
