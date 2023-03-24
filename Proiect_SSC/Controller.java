import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Scanner;
import java.util.concurrent.TimeUnit;

public class Controller {

    public Controller(){
        View view = new View();
        view.getBtnStaticMemoryAllocation().addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                AlocareStatica alocareStatica = new AlocareStatica();
                double x=alocareStatica.ret();
                view.setTxt2(String.valueOf(x));
                DecimalFormat df = new DecimalFormat("#.#####");
                FileWriter MemoryAllocationFile = null;
                try {
                    MemoryAllocationFile = new FileWriter("StaticMemoryAllocationJava.txt",true);
                    MemoryAllocationFile.write(String.valueOf(df.format(x)));
                    MemoryAllocationFile.write(" ");
                    MemoryAllocationFile.close();
                } catch (IOException ex) {
                    ex.printStackTrace();
                }
                try {
                    Process p = Runtime.getRuntime().exec("ThreadMigration_C.exe");
                } catch (IOException ex) {
                    ex.printStackTrace();
                    System.out.println("Could not run exe");
                }
                try {
                    Process p = Runtime.getRuntime().exec("AlocareDeMemorieStatica_C.exe");
                } catch (IOException ex) {
                    ex.printStackTrace();
                    System.out.println("Could not run exe");
                }

                try {
                    TimeUnit.SECONDS.sleep(1);
                } catch (InterruptedException ex) {
                    ex.printStackTrace();
                }

                try {
                    File fp = new File("AlocareDeMemorieStaticaC.txt");
                    Scanner myReader = new Scanner(fp);
                    while (myReader.hasNextLine()) {
                        String data = myReader.nextLine();
                        view.setTxt1(String.valueOf(data));
                    }
                    myReader.close();
                } catch (FileNotFoundException e2) {
                    System.out.println("An error occurred.");
                    e2.printStackTrace();
                }

                try {
                    Process p = Runtime.getRuntime().exec("AlocareDeMemorieStatica_C++.exe");
                } catch (IOException ex) {
                    ex.printStackTrace();
                    System.out.println("Could not run exe");
                }

                try {
                    TimeUnit.SECONDS.sleep(1);
                } catch (InterruptedException ex) {
                    ex.printStackTrace();
                }

                try {
                    File fp = new File("AlocareDeMemorieStaticaCpp.txt");
                    Scanner myReader = new Scanner(fp);
                    while (myReader.hasNextLine()) {
                        String data = myReader.nextLine();
                        view.setTxt3(String.valueOf(data));
                    }
                    myReader.close();
                } catch (FileNotFoundException e2) {
                    System.out.println("An error occurred.");
                    e2.printStackTrace();
                }

                try {
                    TimeUnit.SECONDS.sleep(1);
                } catch (InterruptedException ex) {
                    ex.printStackTrace();
                }

                try {
                    File fp = new File("AlocareDeMemorieStaticaC.txt");
                    Scanner myReader = new Scanner(fp);
                    while (myReader.hasNextLine()) {
                        String data = myReader.nextLine();
                        view.setTxt1(String.valueOf(data));
                    }
                    myReader.close();
                } catch (FileNotFoundException e2) {
                    System.out.println("An error occurred.");
                    e2.printStackTrace();
                }
            }


        });


        view.getBtnDynamicMemoryAllocation().addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                long start1 = System.nanoTime();
                AlocareDinamica alocare2 = new AlocareDinamica();
                long end1 = System.nanoTime();
                double difference1 = end1 - start1;
                double executionTime1 = difference1 / 1000000;
                view.setTxt6(String.valueOf(executionTime1));

                DecimalFormat df = new DecimalFormat("#.#####");
                FileWriter DinamicmemoryAllocationFile = null;
                try {
                    DinamicmemoryAllocationFile = new FileWriter("DinamicmemoryAllocationJava.txt",true);
                    DinamicmemoryAllocationFile.write(String.valueOf(df.format(executionTime1)));
                    DinamicmemoryAllocationFile.write(" ");
                    DinamicmemoryAllocationFile.close();
                } catch (IOException ex) {
                    ex.printStackTrace();
                }

                try {
                    Process p = Runtime.getRuntime().exec("AlocareDeMemorieDinamica_C.exe");
                } catch (IOException ex) {
                    ex.printStackTrace();
                    System.out.println("Could not run exe");
                }

                try {
                    TimeUnit.SECONDS.sleep(1);
                } catch (InterruptedException ex) {
                    ex.printStackTrace();
                }

                try {
                    File fp = new File("AlocareDeMemorieDinamicaC.txt");
                    Scanner myReader = new Scanner(fp);
                    while (myReader.hasNextLine()) {
                        String data = myReader.nextLine();
                        view.setTxt4(String.valueOf(data));
                    }
                    myReader.close();
                } catch (FileNotFoundException e2) {
                    System.out.println("An error occurred.");
                    e2.printStackTrace();
                }

                try {
                    Process p = Runtime.getRuntime().exec("AlocareDeMemorieDinamica_C++.exe");
                } catch (IOException ex) {
                    ex.printStackTrace();
                    System.out.println("Could not run exe");
                }

                try {
                    TimeUnit.SECONDS.sleep(1);
                } catch (InterruptedException ex) {
                    ex.printStackTrace();
                }

                try {
                    File fp = new File("AlocareDeMemorieDinamicaCpp.txt");
                    Scanner myReader = new Scanner(fp);
                    while (myReader.hasNextLine()) {
                        String data = myReader.nextLine();
                        view.setTxt5(String.valueOf(data));
                    }
                    myReader.close();
                } catch (FileNotFoundException e2) {
                    System.out.println("An error occurred.");
                    e2.printStackTrace();
                }
            }

        });

        view.getBtnStaticMemoryAccess().addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                AccesulLaMemorie access = new AccesulLaMemorie();
                double start2 = System.nanoTime();
                access.memoryAccess();
                double end2 = System.nanoTime();
                double difference2 = end2 - start2;
                double executionTime2 =difference2/1000000;
                view.setTxt8(String.valueOf(executionTime2));

                DecimalFormat df = new DecimalFormat("#.#####");
                FileWriter StaticmemoryAccessFile = null;
                try {
                    StaticmemoryAccessFile = new FileWriter("StaticMemoryAccessJava.txt",true);
                    StaticmemoryAccessFile.write(String.valueOf(df.format(executionTime2)));
                    StaticmemoryAccessFile.write(" ");
                    StaticmemoryAccessFile.close();
                } catch (IOException ex) {
                    ex.printStackTrace();
                }
                try {
                    Process p = Runtime.getRuntime().exec("AccesulLaMemorieStatic_C.exe");
                } catch (IOException ex) {
                    ex.printStackTrace();
                    System.out.println("Could not run exe");
                }

                try {
                    TimeUnit.SECONDS.sleep(1);
                } catch (InterruptedException ex) {
                    ex.printStackTrace();
                }

                try {
                    File fp = new File("AccesulLaMemorieStaticC.txt");
                    Scanner myReader = new Scanner(fp);
                    while (myReader.hasNextLine()) {
                        String data = myReader.nextLine();
                        view.setTxt7(String.valueOf(data));
                    }
                    myReader.close();
                } catch (FileNotFoundException e2) {
                    System.out.println("An error occurred.");
                    e2.printStackTrace();
                }

                try {
                    Process p = Runtime.getRuntime().exec("AccesulLaMemorieStatic_C++.exe");
                } catch (IOException ex) {
                    ex.printStackTrace();
                    System.out.println("Could not run exe");
                }

                try {
                    TimeUnit.SECONDS.sleep(1);
                } catch (InterruptedException ex) {
                    ex.printStackTrace();
                }

                try {
                    File fp = new File("AccesulLaMemorieStaticCpp.txt");
                    Scanner myReader = new Scanner(fp);
                    while (myReader.hasNextLine()) {
                        String data = myReader.nextLine();
                        view.setTxt9(String.valueOf(data));
                    }
                    myReader.close();
                } catch (FileNotFoundException e2) {
                    System.out.println("An error occurred.");
                    e2.printStackTrace();
                }


            }


        });

        view.getBtnDynamicMemoryAccess().addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                AccesulLaMemorie access = new AccesulLaMemorie();
                double start2 = System.nanoTime();
                access.memoryAccess();
                double end2 = System.nanoTime();
                double difference2 = end2 - start2;
                double executionTime2 =difference2/1000000;
                view.setTxt12(String.valueOf(executionTime2));

                DecimalFormat df = new DecimalFormat("#.#####");
                FileWriter DinamicmemoryAccessFile = null;
                try {
                    DinamicmemoryAccessFile = new FileWriter("DinamicMemoryAccessJava.txt",true);
                    DinamicmemoryAccessFile.write(String.valueOf(df.format(executionTime2)));
                    DinamicmemoryAccessFile.write(" ");
                    DinamicmemoryAccessFile.close();
                } catch (IOException ex) {
                    ex.printStackTrace();
                }

                try {
                    Process p = Runtime.getRuntime().exec("AccesulLaMemorieDinamic_C.exe");
                } catch (IOException ex) {
                    ex.printStackTrace();
                    System.out.println("Could not run exe");
                }

                try {
                    TimeUnit.SECONDS.sleep(1);
                } catch (InterruptedException ex) {
                    ex.printStackTrace();
                }

                try {
                    File fp = new File("AccesLaMemorieDinamicC.txt");
                    Scanner myReader = new Scanner(fp);
                    while (myReader.hasNextLine()) {
                        String data = myReader.nextLine();
                        view.setTxt10(String.valueOf(data));
                    }
                    myReader.close();
                } catch (FileNotFoundException e2) {
                    System.out.println("An error occurred.");
                    e2.printStackTrace();
                }

                try {
                    Process p = Runtime.getRuntime().exec("AccesulLaMemorieDinamic_C++.exe");
                } catch (IOException ex) {
                    ex.printStackTrace();
                    System.out.println("Could not run exe");
                }

                try {
                    TimeUnit.SECONDS.sleep(1);
                } catch (InterruptedException ex) {
                    ex.printStackTrace();
                }

                try {
                    File fp = new File("AccesulLaMemorieDinamicCpp.txt");
                    Scanner myReader = new Scanner(fp);
                    while (myReader.hasNextLine()) {
                        String data = myReader.nextLine();
                        view.setTxt11(String.valueOf(data));
                    }
                    myReader.close();
                } catch (FileNotFoundException e2) {
                    System.out.println("An error occurred.");
                    e2.printStackTrace();
                }

            }



        });

        view.getBtnThreadCreation().addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                ThreadCreate thread1 = new ThreadCreate();
                double start3 = System.nanoTime();

                Thread t1 = new Thread(thread1);
                Thread t2 = new Thread(thread1);
                Thread t3 = new Thread(thread1);

                double end3 = System.nanoTime();
                double difference3 = end3 - start3;
                double executionTime3 =difference3/1000000;
                view.setTxt15(String.valueOf(executionTime3));

                DecimalFormat df = new DecimalFormat("#.#####");
                FileWriter ThreadCreationFile = null;
                try {
                    ThreadCreationFile = new FileWriter("ThreadCreationJava.txt",true);
                    ThreadCreationFile.write(String.valueOf(df.format(executionTime3)));
                    ThreadCreationFile.write(" ");
                    ThreadCreationFile.close();
                } catch (IOException ex) {
                    ex.printStackTrace();
                }

                try {
                    Process p = Runtime.getRuntime().exec("ThreadCreation_C.exe");
                } catch (IOException ex) {
                    ex.printStackTrace();
                    System.out.println("Could not run exe");
                }

                try {
                    TimeUnit.SECONDS.sleep(1);
                } catch (InterruptedException ex) {
                    ex.printStackTrace();
                }

                try {
                    File fp = new File("ThreadCreationC.txt");
                    Scanner myReader = new Scanner(fp);
                    while (myReader.hasNextLine()) {
                        String data = myReader.nextLine();
                        view.setTxt13(String.valueOf(data));
                    }
                    myReader.close();
                } catch (FileNotFoundException e2) {
                    System.out.println("An error occurred.");
                    e2.printStackTrace();
                }
                try {
                    Process p = Runtime.getRuntime().exec("ThreadCreation_C++.exe");
                } catch (IOException ex) {
                    ex.printStackTrace();
                    System.out.println("Could not run exe");
                }

                try {
                    TimeUnit.SECONDS.sleep(1);
                } catch (InterruptedException ex) {
                    ex.printStackTrace();
                }

                try {
                    File fp = new File("ThreadCreationCpp.txt");
                    Scanner myReader = new Scanner(fp);
                    while (myReader.hasNextLine()) {
                        String data = myReader.nextLine();
                        view.setTxt14(String.valueOf(data));
                    }
                    myReader.close();
                } catch (FileNotFoundException e2) {
                    System.out.println("An error occurred.");
                    e2.printStackTrace();
                }

            }


        });
        view.getBtnThreadContextSwitch().addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                ThreadContextSwitch threadContextSwitch = new ThreadContextSwitch();
                double x=threadContextSwitch.func2();
                view.setTxt18(String.valueOf(x));

                DecimalFormat df = new DecimalFormat("#.#####");
                FileWriter ThreadContextSwitchFile = null;
                try {
                    ThreadContextSwitchFile = new FileWriter("ThreadContextSwitchJava.txt",true);
                    ThreadContextSwitchFile.write(String.valueOf(df.format(x)));
                    ThreadContextSwitchFile.write(" ");
                    ThreadContextSwitchFile.close();
                } catch (IOException ex) {
                    ex.printStackTrace();
                }

                try {
                    Process p = Runtime.getRuntime().exec("ThreadContextSwitch_C.exe");
                } catch (IOException ex) {
                    ex.printStackTrace();
                    System.out.println("Could not run exe");
                }

                try {
                    TimeUnit.SECONDS.sleep(1);
                } catch (InterruptedException ex) {
                    ex.printStackTrace();
                }

                try {
                    File fp = new File("ThreadContextSwitchC.txt");
                    Scanner myReader = new Scanner(fp);
                    while (myReader.hasNextLine()) {
                        String data = myReader.nextLine();
                        view.setTxt16(String.valueOf(data));
                    }
                    myReader.close();
                } catch (FileNotFoundException e2) {
                    System.out.println("An error occurred.");
                    e2.printStackTrace();
                }
                try {
                    Process p2 = Runtime.getRuntime().exec("ThreadContextSwitch_C++.exe");
                } catch (IOException ex) {
                    ex.printStackTrace();
                    System.out.println("Could not run exe");
                }

                try {
                    TimeUnit.SECONDS.sleep(1);
                } catch (InterruptedException ex) {
                    ex.printStackTrace();
                }

                try {
                    File fp2 = new File("ThreadContextSwitchCpp.txt");
                    Scanner myReader2 = new Scanner(fp2);
                    while (myReader2.hasNextLine()) {
                        String data = myReader2.nextLine();
                        view.setTxt17(String.valueOf(data));
                    }
                    myReader2.close();
                } catch (FileNotFoundException e2) {
                    System.out.println("An error occurred.");
                    e2.printStackTrace();
                }
            }
        });
        view.getBtnThreadMigration().addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                DecimalFormat df = new DecimalFormat("#.#####");
                ThreadMigration threadMigration = new ThreadMigration();
                double x=threadMigration.ret();
                view.setTxt21(String.valueOf(df.format(x)));

                FileWriter ThreadMigrationFile = null;
                try {
                    ThreadMigrationFile = new FileWriter("ThreadMigrationJava.txt",true);
                    ThreadMigrationFile.write(String.valueOf(df.format(x)));
                    ThreadMigrationFile.write(" ");
                    ThreadMigrationFile.close();
                } catch (IOException ex) {
                    ex.printStackTrace();
                }
                try {
                    Process p = Runtime.getRuntime().exec("ThreadMigration_C.exe");
                } catch (IOException ex) {
                    ex.printStackTrace();
                    System.out.println("Could not run exe");
                }

                try {
                    TimeUnit.SECONDS.sleep(1);
                } catch (InterruptedException ex) {
                    ex.printStackTrace();
                }

                try {
                    File fp = new File("ThreadMigrationC.txt");
                    Scanner myReader = new Scanner(fp);
                    while (myReader.hasNextLine()) {
                        String data = myReader.nextLine();
                        view.setTxt19(String.valueOf(data));
                    }
                    myReader.close();
                } catch (FileNotFoundException e2) {
                    System.out.println("An error occurred.");
                    e2.printStackTrace();
                }

                try {
                    Process p = Runtime.getRuntime().exec("ThreadMigration_C++.exe");
                } catch (IOException ex) {
                    ex.printStackTrace();
                    System.out.println("Could not run exe");
                }

                try {
                    TimeUnit.SECONDS.sleep(1);
                } catch (InterruptedException ex) {
                    ex.printStackTrace();
                }

                try {
                    File fp = new File("ThreadMigrationCpp.txt");
                    Scanner myReader = new Scanner(fp);
                    while (myReader.hasNextLine()) {
                        String data = myReader.nextLine();
                        view.setTxt20(String.valueOf(data));
                    }
                    myReader.close();
                } catch (FileNotFoundException e2) {
                    System.out.println("An error occurred.");
                    e2.printStackTrace();
                }
            }
        });


    }
}
