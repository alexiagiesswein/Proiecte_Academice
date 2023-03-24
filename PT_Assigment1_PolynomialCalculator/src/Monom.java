import javax.swing.*;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Monom implements Comparable{
    private double coeficient;
    private int putere;

    public double getCoeficient() {
        return coeficient;
    }

    public void setCoeficient(double coeficient) {
        this.coeficient = coeficient;
    }

    public int getPutere() {
        return putere;
    }

    public void setPutere(int putere) {
        this.putere = putere;
    }

    public Monom(double coeficient, int putere){
        if(putere<0)
            throw new RuntimeException("NegativePowerException");
        this.coeficient = coeficient;
        this.putere = putere;
    }

    public Monom(Monom monom){
        if(monom.getPutere()<0)
            throw new RuntimeException("NegativePowerException");
        coeficient=monom.getCoeficient();
        putere=monom.getPutere();
    }

    public String toString(){
        String s="";
        if(coeficient!=0)
        {
            if(coeficient==-1)
                if(putere==0)
                    s="-1";
                else
                s+="-";
            else {
                if (coeficient != 1) {

                    if (coeficient == (long) coeficient)
                        s += (long)coeficient;
                   else
                     s += String.format("%.2f", coeficient);
                }
                else
                    if(putere==0)
                        s="1";
            }
            if(putere>0){
                s+="x";
                if(putere>1)
                    s+="^"+putere;
            }
        }
        return s;
    }

    @Override
    public int compareTo(Object o) {
        Monom monom=(Monom)o;
        return putere-monom.putere;
    }
}
