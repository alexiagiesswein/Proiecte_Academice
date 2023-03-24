import java.text.DecimalFormat;

public class AccesulLaMemorie {

    int[] x = new int[1000];
    double[] d= new double[1000];

    DecimalFormat df = new DecimalFormat("#.#####");

    long start = System.nanoTime();
    public void memoryAccess(){
        for (int i = 0; i < x.length; i++) {
            x[i] = i;
            d[i] = i;
        }

    }
    long end = System.nanoTime();

    double difference = end - start;
    public double executionTime =difference/1000000;


    public void print(){
        System.out.println("Memory access execution time " + df.format(executionTime) + " * 10^(-3) seconds");
    }




}
