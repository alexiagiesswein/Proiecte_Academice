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
public class View extends JFrame  {

    private JTextField polinom1;
    private JTextField polinom2;
    private JTextField result;
    private JTextPane txtRest;
    private Model m_model;
    private JButton btnM;
    private JButton btnD;
    private JButton btnA;
    private JButton btnDx;
    private JButton btnI;
    private JButton btnS;

    public void hideRest(){
        txtRest.setVisible(false);
    }

    public void setRest(Polinom a){
        txtRest.setText("Rest = "+a);
        txtRest.setVisible(true);
    }

    public JTextField getPolinom1() {
        return polinom1;
    }

    public JTextField getPolinom2() {
        return polinom2;
    }

    public Model getM_model() {
        return m_model;
    }

    public JButton getBtnM() {
        return btnM;
    }

    public JButton getBtnD() {
        return btnD;
    }

    public JButton getBtnA() {
        return btnA;
    }

    public JButton getBtnDx() {
        return btnDx;
    }

    public JButton getBtnI() {
        return btnI;
    }

    public JButton getBtnS() {
        return btnS;
    }

    public void setResult(Polinom a){
        result.setText(a.toString());
    }

    public View(Model model) {
        m_model = model;
        getContentPane().setLayout(null);

        JPanel panel = new JPanel();
        panel.setBackground(new Color(204, 204, 255));
        panel.setBounds(50, 25, 486, 400);
        getContentPane().add(panel);
        panel.setLayout(null);

        JTextArea txtrPolynomialCalculator = new JTextArea();
        txtrPolynomialCalculator.setEditable(false);
        txtrPolynomialCalculator.setBackground(new Color(204, 204, 255));
        txtrPolynomialCalculator.setForeground(Color.BLACK);
        txtrPolynomialCalculator.setFont(new Font("Times New Roman", Font.PLAIN, 25));
        txtrPolynomialCalculator.setText("Polynomial Calculator");
        txtrPolynomialCalculator.setBounds(115, 31, 237, 34);
        panel.add(txtrPolynomialCalculator);

        JTextArea txtrPolynomCalculator = new JTextArea();
        txtrPolynomCalculator.setEditable(false);
        txtrPolynomCalculator.setFont(new Font("Times New Roman", Font.PLAIN, 20));
        txtrPolynomCalculator.setBackground(Color.GRAY);
        txtrPolynomCalculator.setForeground(SystemColor.text);
        txtrPolynomCalculator.setText("Polynom Calculator");
        txtrPolynomCalculator.setBounds(0, 0, 486, 28);
        panel.add(txtrPolynomCalculator);

        JTextPane txtpnFirstPolynomial = new JTextPane();
        txtpnFirstPolynomial.setForeground(Color.BLACK);
        txtpnFirstPolynomial.setBackground(new Color(204, 204, 255));
        txtpnFirstPolynomial.setFont(new Font("Times New Roman", Font.PLAIN, 20));
        txtpnFirstPolynomial.setEditable(false);
        txtpnFirstPolynomial.setText("First Polynomial =");
        txtpnFirstPolynomial.setBounds(24, 76, 171, 34);
        panel.add(txtpnFirstPolynomial);

        JTextPane txtpnSecondPolynomial = new JTextPane();
        txtpnSecondPolynomial.setEditable(false);
        txtpnSecondPolynomial.setBackground(new Color(204, 204, 255));
        txtpnSecondPolynomial.setFont(new Font("Times New Roman", Font.PLAIN, 20));
        txtpnSecondPolynomial.setText("Second Polynomial =");
        txtpnSecondPolynomial.setBounds(24, 121, 191, 28);
        panel.add(txtpnSecondPolynomial);

        polinom1 = new JTextField();
        polinom1.setBounds(225, 76, 237, 34);
        panel.add(polinom1);
        polinom1.setColumns(10);

        polinom2 = new JTextField();
        polinom2.setBounds(225, 115, 237, 34);
        panel.add(polinom2);
        polinom2.setColumns(10);

        btnM = new JButton("Multiplicate");
        btnM.setBackground(new Color(255, 255, 153));
        btnM.setFont(new Font("Times New Roman", Font.PLAIN, 20));
        btnM.setBounds(0, 242, 215, 53);
        panel.add(btnM);

        btnD = new JButton("Divide");
        btnD.setFont(new Font("Times New Roman", Font.PLAIN, 20));
        btnD.setBackground(new Color(255, 255, 153));
        btnD.setBounds(0, 291, 215, 46);
        panel.add(btnD);

        btnA = new JButton("Add");
        btnA.setFont(new Font("Times New Roman", Font.PLAIN, 20));
        btnA.setBackground(new Color(255, 255, 153));
        btnA.setBounds(0, 337, 215, 41);
        panel.add(btnA);

        btnS = new JButton("Substract");
        btnS.setFont(new Font("Times New Roman", Font.PLAIN, 20));
        btnS.setBackground(new Color(255, 255, 153));
        btnS.setBounds(265, 242, 221, 53);
        panel.add(btnS);

        btnDx = new JButton("Derivative");
        btnDx.setFont(new Font("Times New Roman", Font.PLAIN, 20));
        btnDx.setBackground(new Color(255, 255, 153));
        btnDx.setBounds(265, 291, 221, 46);
        panel.add(btnDx);

        btnI = new JButton("Integral");
        btnI.setFont(new Font("Times New Roman", Font.PLAIN, 20));
        btnI.setBackground(new Color(255, 255, 153));
        btnI.setBounds(265, 337, 221, 41);
        panel.add(btnI);

        result = new JTextField();
        result.setEditable(false);
        result.setBounds(225, 157, 237, 34);
        panel.add(result);
        result.setColumns(10);

        JTextPane txtpnResult = new JTextPane();
        txtpnResult.setEditable(false);
        txtpnResult.setBackground(new Color(204, 204, 255));
        txtpnResult.setFont(new Font("Times New Roman", Font.PLAIN, 20));
        txtpnResult.setText("Result =");
        txtpnResult.setBounds(24, 160, 158, 31);
        panel.add(txtpnResult);

        txtRest = new JTextPane();
        txtRest.setEditable(false);
        txtRest.setVisible(false);
        txtRest.setBackground(new Color(204, 204, 255));
        txtRest.setFont(new Font("Times New Roman", Font.PLAIN, 20));
        txtRest.setText("Rest =");
        txtRest.setBounds(24, 196, 158, 31);
        panel.add(txtRest);
    }
}



