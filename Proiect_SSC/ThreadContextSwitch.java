import java.text.DecimalFormat;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class ThreadContextSwitch implements Runnable {

    private Lock lock;


    public void func1() {
        lock = new ReentrantLock();
        lock.unlock();
    }

    public double func2() {
        long start = System.nanoTime();
        lock = new ReentrantLock();
        long end = System.nanoTime();
        double difference = end - start;
        double executionTime = difference / 1000000;

        DecimalFormat df = new DecimalFormat("#.#####");
        return executionTime;

    }

    public void switchContext() throws InterruptedException {
        Thread t1 = new Thread(new Runnable() {
            public void run() {
                for (int i = 0; i < 10; i++) {
                    //    System.out.println("Thread 1: " + i);
                }
            }
        });
        Thread t2 = new Thread(new Runnable() {
            public void run() {
                for (int i = 0; i < 10; i++) {
                    //    System.out.println("Thread 2: " + i);
                }
            }
        });
        t1.start();
        t2.start();

        t1.join();
        t2.join();

    }

    @Override
    public void run() {
        //System.out.println("thread is running...");
    }
}

