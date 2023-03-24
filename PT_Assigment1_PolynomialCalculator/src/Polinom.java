import javax.swing.*;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Polinom {
    private ArrayList<Monom> polinom = new ArrayList<Monom>();

    public Polinom(String s){
/*        if(s.charAt(0)!='-')*/
        s=s.replace("-","+-");
/*        else
            s="-"+s.substring(1).replace("-","+-");*/
        String[] termeni=s.split("\\+");
        for(String termen:termeni){
            if(termen.length()>0)
            {
                double coeficient;
                int putere;
                if(!termen.contains("x")) {
                    putere=0;
                    coeficient=Double.parseDouble(termen);
                }
                else{

                    if(termen.charAt(0)=='x')
                        coeficient=1;
                    else if(termen.charAt(0)=='-'&&termen.charAt(1)=='x')
                        coeficient=-1;
                    else
                        coeficient=Double.parseDouble(termen.substring(0,termen.indexOf('x')));

                    if(termen.contains("^"))
                        putere=Integer.parseInt((termen.substring(termen.indexOf('^')+1,termen.length())));
                    else
                        putere=1;
                }
                polinom.add(new Monom(coeficient,putere));
            }
        }
        combinare();
    }

    public Polinom(Polinom p){
        for(Monom monom:p.getPolinom())
            polinom.add(new Monom(monom));
    }

    public Polinom(Monom monom){
        polinom.add(new Monom(monom));
    }

    public Polinom() {

    }

    @Override
    public String toString() {
        String s="";
        boolean inceput=true;
        for(Monom monom:polinom){
            if(monom.getCoeficient()>0) {
                if(inceput)
                    s+=monom;
                else
                    s+="+"+monom;
                inceput=false;
            }
            else
            if(monom.getCoeficient()<0) {
                inceput=false;
                s+=monom;
            }
        }
        if(inceput==true)
            s="0";
        return s;
    }

    public void combinare(){
        if(polinom.size()==0)
            return;
        int i=0;
        while(i<polinom.size()) {
            Monom monom=polinom.get(i);
            int j=0;
            while(j<polinom.size()) {
                Monom monom2=polinom.get(j);
                if(monom!=monom2&&monom.getPutere()==monom2.getPutere()) {
                    monom.setCoeficient(monom.getCoeficient()+monom2.getCoeficient());
                    polinom.remove(monom2);
                    j--;
                }
                j++;
            }
            if(monom.getCoeficient()==0) {
                polinom.remove(monom);
                i--;
            }
            i++;
        }
        Collections.sort(polinom,Collections.reverseOrder());
    }

    public int getGrad(){
        combinare();
        if(polinom.size()==0)
            return -1;
        return polinom.get(0).getPutere();
    }

    public ArrayList<Monom> getPolinom() {
        return polinom;
    }

    public void addMonom(Monom monom){
        polinom.add(monom);
    }
}
