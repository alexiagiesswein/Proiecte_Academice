package View;
import javax.swing.*;
import java.awt.BorderLayout;
import java.awt.Font;
import java.awt.Color;
import java.awt.SystemColor;

public class View extends JFrame  {

    public static final Font FONT=new Font("Times New Roman", Font.PLAIN, 20);
    private JTextField NumCl;
    private JTextField NumQ;
    private JTextField MinAT;
    private JTextField MaxAT;
    private JTextField MinST;
    private JTextField MaxST;
    private JTextField TL;
    private  JButton Start;
    private  JComboBox Strategy;

    public JTextField getNumCl() {
        return NumCl;
    }

    public void setNumCl(JTextField numCl) {
        NumCl = numCl;
    }

    public JTextField getNumQ() {
        return NumQ;
    }

    public void setNumQ(JTextField numQ) {
        NumQ = numQ;
    }

    public JTextField getMinAT() {
        return MinAT;
    }

    public void setMinAT(JTextField minAT) {
        MinAT = minAT;
    }

    public JTextField getMaxAT() {
        return MaxAT;
    }

    public void setMaxAT(JTextField maxAT) {
        MaxAT = maxAT;
    }

    public JTextField getMinST() {
        return MinST;
    }

    public void setMinST(JTextField minST) {
        MinST = minST;
    }

    public JTextField getMaxST() {
        return MaxST;
    }

    public void setMaxST(JTextField maxST) {
        MaxST = maxST;
    }

    public JTextField getTL() {
        return TL;
    }

    public void setTL(JTextField TL) {
        this.TL = TL;
    }

    public JButton getStart() {
        return Start;
    }

    public void setStart(JButton start) {
        Start = start;
    }

    public JComboBox getStrategy() {
        return Strategy;
    }

    public void setStrategy(JComboBox strategy) {
        Strategy = strategy;
    }

    public View() {

        getContentPane().setLayout(null);

        JLabel title = new JLabel("Queue management system");
        title.setForeground(Color.BLACK);
        title.setFont(FONT);
        title.setBounds(151, 11, 260, 34);
        getContentPane().add(title);

        NumCl = new JTextField();
        NumCl.setBounds(272, 68, 177, 34);
        getContentPane().add(NumCl);
        NumCl.setColumns(10);

        NumQ = new JTextField();
        NumQ.setBounds(272, 119, 177, 34);
        getContentPane().add(NumQ);
        NumQ.setColumns(10);

        MinAT = new JTextField();
        MinAT.setBounds(272, 171, 177, 34);
        getContentPane().add(MinAT);
        MinAT.setColumns(10);

        MaxAT = new JTextField();
        MaxAT.setBounds(272, 227, 177, 34);
        getContentPane().add(MaxAT);
        MaxAT.setColumns(10);

        MinST = new JTextField();
        MinST.setBounds(272, 289, 177, 32);
        getContentPane().add(MinST);
        MinST.setColumns(10);

        MaxST = new JTextField();
        MaxST.setBounds(272, 343, 177, 34);
        getContentPane().add(MaxST);
        MaxST.setColumns(10);

        TL = new JTextField();
        TL.setBounds(272, 388, 177, 34);
        getContentPane().add(TL);
        TL.setColumns(10);

        JLabel NumberOfClients = new JLabel("Number of clients");
        NumberOfClients.setFont(FONT);
        NumberOfClients.setBounds(68, 67, 161, 32);
        getContentPane().add(NumberOfClients);

        JLabel NumberOfQueues = new JLabel("Number of queues");
        NumberOfQueues.setFont(FONT);
        NumberOfQueues.setBounds(68, 129, 143, 24);
        getContentPane().add(NumberOfQueues);

        JLabel Min1 = new JLabel("Minimum arrival time");
        Min1.setFont(FONT);
        Min1.setBounds(68, 185, 176, 24);
        getContentPane().add(Min1);

        JLabel Max1 = new JLabel("Maximum arrival time");
        Max1.setFont(FONT);
        Max1.setBounds(68, 237, 176, 24);
        getContentPane().add(Max1);

        JLabel Min2 = new JLabel("Minimum service time");
        Min2.setFont(FONT);
        Min2.setBounds(68, 297, 194, 24);
        getContentPane().add(Min2);

        JLabel Max2 = new JLabel("Maximum service time");
        Max2.setFont(FONT);
        Max2.setBounds(68, 346, 194, 24);
        getContentPane().add(Max2);

        JLabel TimeLimit = new JLabel("Time limit");
        TimeLimit.setFont(FONT);
        TimeLimit.setBounds(68, 401, 176, 24);
        getContentPane().add(TimeLimit);

        Start = new JButton("START");
        Start.setFont(new Font("Times New Roman", Font.PLAIN, 16));
        Start.setBounds(221, 495, 98, 34);
        getContentPane().add(Start);

        JLabel Stra = new JLabel("Strategy");
        Stra.setFont(FONT);
        Stra.setBounds(68, 450, 114, 25);
        getContentPane().add(Stra);

        Strategy = new JComboBox();
        Strategy.setBounds(272, 436, 177, 32);
        Strategy.addItem("SHORTEST QUEUE");
        Strategy.addItem("SHORTEST TIME");
        getContentPane().add(Strategy);

        this.setSize(600,600);
        this.setVisible(true);
    }

}
