package Model;

public class Task implements Comparable {
    private int id;
    private int arrivalTime;
    private int serviceTime;

    public int getArrivalTime() {
        return arrivalTime;
    }

    public void setArrivalTime(int arrivalTime) {
        this.arrivalTime = arrivalTime;
    }

    public int getServiceTime() {
        return serviceTime;
    }

    public void setServiceTime(int serviceTime) {
        this.serviceTime = serviceTime;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Override
    public int compareTo(Object o) {
        return this.arrivalTime-((Task)o).arrivalTime;
    }

    @Override
    public String toString() {
        return "("+id+","+arrivalTime+","+serviceTime+")";
    }
}
