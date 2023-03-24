package Controller;
import javax.swing.*;
import java.awt.event.*;

import Model.SelectionPolicy;
import Model.SimulationManager;
import View.View;

public class Controller {

    private View m_view;

    public Controller(View view) {

        m_view = view;

        view.getStart().addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {

                int numar1=0;
                int numar2=0;
                int numar3=0;
                int numar4=0;
                int numar5=0;
                int numar6=0;
                int numar7=0;
                int numar8 = 0;
                try{
                    numar1=Integer.parseInt(view.getNumCl().getText());
                    numar2=Integer.parseInt(view.getNumQ().getText());
                    numar3=Integer.parseInt(view.getMinAT().getText());
                    numar4=Integer.parseInt(view.getMaxAT().getText());
                    numar5=Integer.parseInt(view.getMinST().getText());
                    numar6=Integer.parseInt(view.getMaxST().getText());
                    numar7=Integer.parseInt(view.getTL().getText());
                    numar8=view.getStrategy().getSelectedIndex();

                }
                catch(Exception ex){
                    JOptionPane.showMessageDialog(new JFrame(),"Invalid input","Error",JOptionPane.ERROR_MESSAGE);
                }
                if(numar1>0 && numar2>0 && numar3>0 && numar4>0 && numar5>0 && numar6>0 && numar7>0 && numar3<=numar4 && numar5<=numar6){
                    SelectionPolicy policy=SelectionPolicy.SHORTEST_TIME;
                    if(numar8==1)
                        policy=SelectionPolicy.SHORTEST_QUEUE;

                    SimulationManager gen= new SimulationManager(numar7,numar6,numar5,numar3,numar4,numar2,numar1,policy);
                    Thread t= new Thread(gen);
                    t.start();
                }

                else
                    JOptionPane.showMessageDialog(new JFrame(),"Invalid input","Error",JOptionPane.ERROR_MESSAGE);
            }
        });
    }
}