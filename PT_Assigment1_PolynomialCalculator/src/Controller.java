import javax.swing.*;
import java.awt.event.*;

public class Controller {

    private Model m_model;
    private View m_view;

    Controller(Model model, View view) {
        m_model = model;
        m_view = view;

        view.getBtnA().addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                view.hideRest();
                Polinom a=null,b=null;
                try{
                    a=new Polinom(view.getPolinom1().getText());
                    b=new Polinom(view.getPolinom2().getText());
                }
                catch(Exception ex){
                    JOptionPane.showMessageDialog(new JFrame(),"Invalid input","Error",JOptionPane.ERROR_MESSAGE);
                }
                if(a!=null&&b!=null)
                    view.setResult(model.adunare(a,b));
                else
                    JOptionPane.showMessageDialog(new JFrame(),"Invalid input","Error",JOptionPane.ERROR_MESSAGE);
            }
        });
        view.getBtnS().addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                view.hideRest();
                Polinom a=null,b=null;
                try{
                    a=new Polinom(view.getPolinom1().getText());
                    b=new Polinom(view.getPolinom2().getText());
                }
                catch(Exception ex){
                    JOptionPane.showMessageDialog(new JFrame(),"Invalid input","Error",JOptionPane.ERROR_MESSAGE);
                }
                if(a!=null&&b!=null)
                    view.setResult(model.scadere(a,b));
                else
                    JOptionPane.showMessageDialog(new JFrame(),"Invalid input","Error",JOptionPane.ERROR_MESSAGE);
            }
        });
        view.getBtnM().addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                view.hideRest();
                Polinom a=null,b=null;
                try{
                    a=new Polinom(view.getPolinom1().getText());
                    b=new Polinom(view.getPolinom2().getText());
                }
                catch(Exception ex){
                    JOptionPane.showMessageDialog(new JFrame(),"Invalid input","Error",JOptionPane.ERROR_MESSAGE);
                }
                if(a!=null&&b!=null)
                    view.setResult(model.inmultire(a,b));
                else
                    JOptionPane.showMessageDialog(new JFrame(),"Invalid input","Error",JOptionPane.ERROR_MESSAGE);
            }
        });
        view.getBtnD().addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Polinom a=null,b=null;
                try{
                    a=new Polinom(view.getPolinom1().getText());
                    b=new Polinom(view.getPolinom2().getText());
                }
                catch(Exception ex){
                    JOptionPane.showMessageDialog(new JFrame(),"Invalid input","Error",JOptionPane.ERROR_MESSAGE);
                }
                if(a!=null&&b!=null) {
                    Polinom cat=model.impartire(a,b);
                    view.setResult(cat);
                    view.setRest(model.scadere(a,model.inmultire(cat,b)));
                }
                else
                    JOptionPane.showMessageDialog(new JFrame(),"Invalid input","Error",JOptionPane.ERROR_MESSAGE);
            }
        });
        view.getBtnI().addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                view.hideRest();
                Polinom a=null;
                try{
                    a=new Polinom(view.getPolinom1().getText());
                }
                catch(Exception ex){
                    JOptionPane.showMessageDialog(new JFrame(),"Invalid input","Error",JOptionPane.ERROR_MESSAGE);
                }
                if(a!=null)
                    view.setResult(model.integrare(a));
                else
                    JOptionPane.showMessageDialog(new JFrame(),"Invalid input","Error",JOptionPane.ERROR_MESSAGE);
            }
        });
        view.getBtnDx().addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                view.hideRest();
                Polinom a=null;
                try{
                    a=new Polinom(view.getPolinom1().getText());
                }
                catch(Exception ex){
                    JOptionPane.showMessageDialog(new JFrame(),"Invalid input","Error",JOptionPane.ERROR_MESSAGE);
                }
                if(a!=null)
                    view.setResult(model.derivare(a));
                else
                    JOptionPane.showMessageDialog(new JFrame(),"Invalid input","Error",JOptionPane.ERROR_MESSAGE);
            }
        });
    }
}
