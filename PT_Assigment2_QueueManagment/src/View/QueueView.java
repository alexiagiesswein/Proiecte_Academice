package View;
import Model.Server;
import Model.Task;

import javax.swing.*;
import java.awt.BorderLayout;
import java.awt.Font;
import java.awt.Color;
import java.awt.SystemColor;
import java.util.ArrayList;

public class QueueView extends JFrame{
    private JPanel panel;
    private JLabel timeText;
    private JTextArea waitingQueue;
    private JTextArea queuesText;
    private JLabel resultData1;
    private JLabel resultData2;
    private JLabel resultData3;

    public QueueView(){
        this.setSize(1400,620);
        this.setVisible(true);
        this.setResizable(false);

        panel=new JPanel();
        this.setContentPane(panel);
        panel.setLayout(null);
        panel.setBounds(0,0,1400,700);

        timeText = new JLabel("Current time: ");
        timeText.setFont(View.FONT);
        timeText.setBounds(20, 10, 176, 24);
        getContentPane().add(timeText);

        JLabel waitingText = new JLabel("Waiting:");
        waitingText.setFont(View.FONT);
        waitingText.setBounds(20, 50, 176, 24);
        getContentPane().add(waitingText);

        waitingQueue=new JTextArea();
        waitingQueue.setFont(View.FONT);
        waitingQueue.setEditable(false);
        getContentPane().add(waitingQueue);
        waitingQueue.setBounds(100,50,1250,24);

        queuesText=new JTextArea();
        queuesText.setFont(View.FONT);
        queuesText.setEditable(false);
        getContentPane().add(queuesText);
        queuesText.setBounds(20,100,1330,300);


        resultData1 = new JLabel("Peak hour:");
        resultData1.setFont(View.FONT);
        getContentPane().add(resultData1);
        resultData1.setBounds(20, 430, 650, 24);

        resultData2 = new JLabel("Average waiting time:");
        resultData2.setFont(View.FONT);
        getContentPane().add(resultData2);
        resultData2.setBounds(20, 470, 650, 24);

        resultData3 = new JLabel("Average service time:");
        resultData3.setFont(View.FONT);
        getContentPane().add(resultData3);
        resultData3.setBounds(20, 510, 650, 24);
    }

    public void update(int currentTime,ArrayList<Task> tasks, ArrayList<Server> servers){
        timeText.setText("Current time: "+currentTime);
        String s="";
        for(Task task:tasks)
            s+=task.toString()+" ";
        waitingQueue.setText(s);

        String s2="";
        for(int i=1;i<=servers.size();i++)
            s2+="Queue "+i+": "+servers.get(i-1)+"\n";
        queuesText.setText(s2);
    }

    public void updateAverages(int peakHour,float averageWaitingTime,float averageServiceTime){
        resultData1.setText("Peak hour: "+peakHour);
        resultData2.setText("Average waiting time: "+averageWaitingTime);
        resultData3.setText("Average service time: "+averageServiceTime);
    }
}
