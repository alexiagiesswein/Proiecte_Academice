import javax.swing.JFrame;
import javax.swing.JLabel;
import java.awt.BorderLayout;
import java.awt.Font;
import java.awt.Color;
import javax.swing.JPanel;
import java.awt.SystemColor;
import javax.swing.JTextArea;
import javax.swing.JTextPane;
import javax.swing.JTextField;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JList;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import javax.swing.JRadioButton;

public class View extends JFrame  {

    JButton btnStaticMemoryAccess;
    JButton btnDynamicMemoryAccess;
    JButton btnStaticMemoryAllocation;
    JButton btnDynamicMemoryAllocation;
    JButton btnThreadCreation;
    JButton btnThreadContextSwitch;
    JButton btnThreadMigration;

    JTextArea txtAlocareStaticaC;
    JTextArea txtAlocareStaticaCpp;
    JTextArea txtAlocareStaticaJava;

    JTextArea txtAlocareDinamicaC;
    JTextArea txtAlocareDinamicaCpp;
    JTextArea txtAlocareDinamicaJava;

    JTextArea txtAccesStaticC;
    JTextArea txtAccesStaticCpp;
    JTextArea txtAccesStaticJava;

    JTextArea txtAccesDinamicC;
    JTextArea txtAccesDinamicCpp;
    JTextArea txtAccesDinamicJava;

    JTextArea txtThreadCreationC;
    JTextArea txtThreadCreationCpp;
    JTextArea txtThreadCreationJava;

    JTextArea txtThreadContextSwitchC;
    JTextArea txtThreadContextSwitchCpp;
    JTextArea txtThreadContextSwitchJava;

    JTextArea txtThreadMigrationC;
    JTextArea txtThreadMigrationCpp;
    JTextArea txtThreadMigrationJava;

    public void setTxt21(String s){
        txtThreadMigrationJava.setText(s);
    }

    public void setTxt20(String s){
        txtThreadMigrationCpp.setText(s);
    }

    public void setTxt19(String s){
        txtThreadMigrationC.setText(s);
    }

    public void setTxt18(String s){
        txtThreadContextSwitchJava.setText(s);
    }

    public void setTxt17(String s){
        txtThreadContextSwitchCpp.setText(s);
    }

    public void setTxt16(String s){
        txtThreadContextSwitchC.setText(s);
    }

    public void setTxt15(String s){
        txtThreadCreationJava.setText(s);
    }

    public void setTxt14(String s){
        txtThreadCreationCpp.setText(s);
    }

    public void setTxt13(String s){
        txtThreadCreationC.setText(s);
    }


    public void setTxt12(String s){
        txtAccesDinamicJava.setText(s);
    }

    public void setTxt11(String s){
        txtAccesDinamicCpp.setText(s);
    }

    public void setTxt10(String s){
        txtAccesDinamicC.setText(s);
    }

    public void setTxt9(String s){
        txtAccesStaticCpp.setText(s);
    }

    public void setTxt8(String s){
        txtAccesStaticJava.setText(s);
    }

    public void setTxt7(String s){
        txtAccesStaticC.setText(s);
    }

    public void setTxt6(String s){
        txtAlocareDinamicaJava.setText(s);
    }

    public void setTxt5(String s){
        txtAlocareDinamicaCpp.setText(s);
    }

    public void setTxt4(String s){
        txtAlocareDinamicaC.setText(s);
    }

    public void setTxt3(String s){
        txtAlocareStaticaCpp.setText(s);
    }

    public void setTxt2(String s){
        txtAlocareStaticaJava.setText(s);
    }

    public void setTxt1(String s){
        txtAlocareStaticaC.setText(s);
    }


    public JButton getBtnStaticMemoryAccess() {
        return btnStaticMemoryAccess;
    }
    public JButton getBtnDynamicMemoryAccess() {
        return btnDynamicMemoryAccess;
    }
    public JButton getBtnStaticMemoryAllocation() {
        return btnStaticMemoryAllocation;
    }
    public JButton getBtnDynamicMemoryAllocation() {
        return btnDynamicMemoryAllocation;
    }
    public JButton getBtnThreadCreation() {
        return btnThreadCreation;
    }
    public JButton getBtnThreadContextSwitch() {
        return btnThreadContextSwitch;
    }
    public JButton getBtnThreadMigration() {
        return btnThreadMigration;
    }


    public View() {
        this.setSize(1200,800);
        this.setVisible(true);
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        getContentPane().setLayout(null);

        JLabel lblNewLabel = new JLabel("Limbajul C");
        lblNewLabel.setFont(new Font("Times New Roman", Font.BOLD, 30));
        lblNewLabel.setBounds(347, 11, 222, 92);
        getContentPane().add(lblNewLabel);

        JLabel lblNewLabel_1 = new JLabel("Limbajul C++");
        lblNewLabel_1.setFont(new Font("Times New Roman", Font.BOLD, 30));
        lblNewLabel_1.setBounds(579, 14, 207, 86);
        getContentPane().add(lblNewLabel_1);

        JLabel lblNewLabel_2 = new JLabel("Limbajul Java");
        lblNewLabel_2.setFont(new Font("Times New Roman", Font.BOLD, 30));
        lblNewLabel_2.setBounds(843, 14, 222, 86);
        getContentPane().add(lblNewLabel_2);

        btnStaticMemoryAllocation = new JButton("Alocare de memorie statica");
        btnStaticMemoryAllocation.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
            }
        });
        btnStaticMemoryAllocation.setFont(new Font("Times New Roman", Font.PLAIN, 15));
        btnStaticMemoryAllocation.setBounds(28, 92, 222, 60);
        getContentPane().add(btnStaticMemoryAllocation);

        btnStaticMemoryAccess = new JButton("Accesul la memorie static");
        btnStaticMemoryAccess.setFont(new Font("Times New Roman", Font.PLAIN, 15));
        btnStaticMemoryAccess.setBounds(28, 246, 222, 60);
        getContentPane().add(btnStaticMemoryAccess);

        btnDynamicMemoryAllocation = new JButton("Alocare de memorie dinamica");
        btnDynamicMemoryAllocation.setFont(new Font("Times New Roman", Font.PLAIN, 15));
        btnDynamicMemoryAllocation.setBounds(28, 163, 222, 60);
        getContentPane().add(btnDynamicMemoryAllocation);

        btnThreadCreation = new JButton("Thread creation");
        btnThreadCreation.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
            }
        });
        btnThreadCreation.setFont(new Font("Times New Roman", Font.PLAIN, 15));
        btnThreadCreation.setBounds(28, 413, 222, 60);
        getContentPane().add(btnThreadCreation);

        btnThreadContextSwitch = new JButton("Thread context switch");
        btnThreadContextSwitch.setFont(new Font("Times New Roman", Font.PLAIN, 15));
        btnThreadContextSwitch.setBounds(28, 498, 222, 60);
        getContentPane().add(btnThreadContextSwitch);

        btnThreadMigration = new JButton("Thread migration");
        btnThreadMigration.setFont(new Font("Times New Roman", Font.PLAIN, 15));
        btnThreadMigration.setBounds(28, 585, 222, 60);
        getContentPane().add(btnThreadMigration);

        JLabel lblNewLabel_3 = new JLabel("Procesul de masurat");
        lblNewLabel_3.setFont(new Font("Times New Roman", Font.BOLD, 30));
        lblNewLabel_3.setBounds(10, 34, 278, 47);
        getContentPane().add(lblNewLabel_3);

        txtAlocareStaticaC = new JTextArea();
        txtAlocareStaticaC.setFont(new Font("Times New Roman", Font.PLAIN, 13));
        txtAlocareStaticaC.setEditable(false);
        txtAlocareStaticaC.setBounds(333, 92, 171, 60);
        getContentPane().add(txtAlocareStaticaC);

        txtAlocareStaticaCpp = new JTextArea();
        txtAlocareStaticaCpp.setFont(new Font("Times New Roman", Font.PLAIN, 13));
        txtAlocareStaticaCpp.setEditable(false);
        txtAlocareStaticaCpp.setBounds(589, 92, 171, 60);
        getContentPane().add(txtAlocareStaticaCpp);

        txtAlocareStaticaJava = new JTextArea();
        txtAlocareStaticaJava.setFont(new Font("Times New Roman", Font.PLAIN, 13));
        txtAlocareStaticaJava.setEditable(false);
        txtAlocareStaticaJava.setBounds(853, 92, 171, 60);
        getContentPane().add(txtAlocareStaticaJava);

        txtAlocareDinamicaC = new JTextArea();
        txtAlocareDinamicaC.setFont(new Font("Times New Roman", Font.PLAIN, 13));
        txtAlocareDinamicaC.setEditable(false);
        txtAlocareDinamicaC.setBounds(333, 163, 171, 60);
        getContentPane().add(txtAlocareDinamicaC);

        txtAlocareDinamicaCpp = new JTextArea();
        txtAlocareDinamicaCpp.setFont(new Font("Times New Roman", Font.PLAIN, 13));
        txtAlocareDinamicaCpp.setEditable(false);
        txtAlocareDinamicaCpp.setBounds(589, 163, 171, 60);
        getContentPane().add(txtAlocareDinamicaCpp);

        txtAlocareDinamicaJava = new JTextArea();
        txtAlocareDinamicaJava.setFont(new Font("Times New Roman", Font.PLAIN, 13));
        txtAlocareDinamicaJava.setEditable(false);
        txtAlocareDinamicaJava.setBounds(853, 163, 171, 60);
        getContentPane().add(txtAlocareDinamicaJava);

        txtAccesStaticC = new JTextArea();
        txtAccesStaticC.setFont(new Font("Times New Roman", Font.PLAIN, 13));
        txtAccesStaticC.setEditable(false);
        txtAccesStaticC.setBounds(333, 246, 171, 60);
        getContentPane().add(txtAccesStaticC);

        txtAccesStaticCpp = new JTextArea();
        txtAccesStaticCpp.setFont(new Font("Times New Roman", Font.PLAIN, 13));
        txtAccesStaticCpp.setEditable(false);
        txtAccesStaticCpp.setBounds(589, 246, 171, 60);
        getContentPane().add(txtAccesStaticCpp);

        txtAccesStaticJava = new JTextArea();
        txtAccesStaticJava.setFont(new Font("Times New Roman", Font.PLAIN, 13));
        txtAccesStaticJava.setEditable(false);
        txtAccesStaticJava.setBounds(853, 246, 171, 60);
        getContentPane().add(txtAccesStaticJava);

        txtThreadCreationC = new JTextArea();
        txtThreadCreationC.setFont(new Font("Times New Roman", Font.PLAIN, 13));
        txtThreadCreationC.setEditable(false);
        txtThreadCreationC.setBounds(333, 413, 171, 60);
        getContentPane().add(txtThreadCreationC);

        txtThreadCreationCpp= new JTextArea();
        txtThreadCreationCpp.setFont(new Font("Times New Roman", Font.PLAIN, 13));
        txtThreadCreationCpp.setEditable(false);
        txtThreadCreationCpp.setBounds(589, 413, 171, 60);
        getContentPane().add(txtThreadCreationCpp);

        txtThreadCreationJava = new JTextArea();
        txtThreadCreationJava.setFont(new Font("Times New Roman", Font.PLAIN, 13));
        txtThreadCreationJava.setEditable(false);
        txtThreadCreationJava.setBounds(853, 413, 171, 60);
        getContentPane().add(txtThreadCreationJava);

        txtThreadContextSwitchC = new JTextArea();
        txtThreadContextSwitchC.setFont(new Font("Times New Roman", Font.PLAIN, 13));
        txtThreadContextSwitchC.setEditable(false);
        txtThreadContextSwitchC.setBounds(333, 498, 171, 60);
        getContentPane().add(txtThreadContextSwitchC);

        txtThreadContextSwitchCpp = new JTextArea();
        txtThreadContextSwitchCpp.setFont(new Font("Times New Roman", Font.PLAIN, 13));
        txtThreadContextSwitchCpp.setEditable(false);
        txtThreadContextSwitchCpp.setBounds(589, 498, 171, 60);
        getContentPane().add(txtThreadContextSwitchCpp);

        txtThreadContextSwitchJava = new JTextArea();
        txtThreadContextSwitchJava.setFont(new Font("Times New Roman", Font.PLAIN, 13));
        txtThreadContextSwitchJava.setEditable(false);
        txtThreadContextSwitchJava.setBounds(853, 498, 171, 60);
        getContentPane().add(txtThreadContextSwitchJava);

        txtThreadMigrationC = new JTextArea();
        txtThreadMigrationC.setFont(new Font("Times New Roman", Font.PLAIN, 13));
        txtThreadMigrationC.setEditable(false);
        txtThreadMigrationC.setBounds(333, 585, 171, 60);
        getContentPane().add(txtThreadMigrationC);

        txtThreadMigrationCpp = new JTextArea();
        txtThreadMigrationCpp.setFont(new Font("Times New Roman", Font.PLAIN, 13));
        txtThreadMigrationCpp.setEditable(false);
        txtThreadMigrationCpp.setBounds(589, 585, 171, 60);
        getContentPane().add(txtThreadMigrationCpp);

        txtThreadMigrationJava = new JTextArea();
        txtThreadMigrationJava.setFont(new Font("Times New Roman", Font.PLAIN, 13));
        txtThreadMigrationJava.setEditable(false);
        txtThreadMigrationJava.setBounds(853, 585, 171, 60);
        getContentPane().add(txtThreadMigrationJava);

        txtAccesDinamicC = new JTextArea();
        txtAccesDinamicC.setFont(new Font("Times New Roman", Font.PLAIN, 13));
        txtAccesDinamicC.setEditable(false);
        txtAccesDinamicC.setBounds(333, 335, 171, 60);
        getContentPane().add(txtAccesDinamicC);

        txtAccesDinamicCpp = new JTextArea();
        txtAccesDinamicCpp.setFont(new Font("Times New Roman", Font.PLAIN, 13));
        txtAccesDinamicCpp.setEditable(false);
        txtAccesDinamicCpp.setBounds(589, 335, 171, 60);
        getContentPane().add(txtAccesDinamicCpp);

        txtAccesDinamicJava = new JTextArea();
        txtAccesDinamicJava.setFont(new Font("Times New Roman", Font.PLAIN, 13));
        txtAccesDinamicJava.setEditable(false);
        txtAccesDinamicJava.setBounds(853, 335, 171, 60);
        getContentPane().add(txtAccesDinamicJava);

        btnDynamicMemoryAccess = new JButton("Accesul la memorie dinamic");
        btnDynamicMemoryAccess.setFont(new Font("Times New Roman", Font.PLAIN, 15));
        btnDynamicMemoryAccess.setBounds(28, 335, 222, 60);
        getContentPane().add(btnDynamicMemoryAccess);




        this.revalidate();
        this.repaint();




    }
}
