import java.text.DecimalFormat;

public class Masuratori {

    public static void main(String args[])
    {
        //Alocarea statica a memoriei
        AlocareStatica alocareStatica = new AlocareStatica();
        alocareStatica.print();

        //Alocarea dinamica a memoriei
        long start1 = System.nanoTime();
        AlocareDinamica alocare2 = new AlocareDinamica();
        long end1 = System.nanoTime();
        double difference1 = end1 - start1;
        double executionTime1 =difference1/1000000;

        DecimalFormat df = new DecimalFormat("#.#####");
        System.out.println();
        System.out.println("Dynamic memory allocation execution time " + df.format(executionTime1) + " *10^(-3) seconds");

        //Accesul la memorie
        AccesulLaMemorie access = new AccesulLaMemorie();
        double start2 = System.nanoTime();
        access.memoryAccess();
        double end2 = System.nanoTime();
        double difference2 = end2 - start2;
        double executionTime2 =difference2/1000000;

        System.out.println();
        System.out.println("Memory access execution time " + df.format(executionTime2) + " 10^(-3) seconds");

        //Thread Creation
        ThreadCreate thread1 = new ThreadCreate();
        double start3 = System.nanoTime();

        Thread t1 = new Thread(thread1);
        Thread t2 = new Thread(thread1);
        Thread t3 = new Thread(thread1);

        double end3 = System.nanoTime();
        double difference3 = end3 - start3;
        double executionTime3 =difference3/1000000;

        System.out.println();
        System.out.println("Thread creation execution time " + df.format(executionTime3) + " *10^(-3) seconds");

        new Controller();
    }


}