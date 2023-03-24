import java.text.DecimalFormat;

public class AlocareStatica {

    long start = System.nanoTime();

    int[] x = new int[1000];
    String s= new String();
    double[] d= new double[100];

    long end = System.nanoTime();

    double difference = end - start;
    public double executionTime =difference/1000000;

    DecimalFormat df = new DecimalFormat("#.#####");


    public void print(){
        System.out.println("Static memory allocation execution time " + df.format(executionTime) + " * 10^(-3) seconds");
    }



    public double ret(){
        return executionTime;
    }

}
