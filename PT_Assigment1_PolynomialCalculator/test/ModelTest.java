import static org.junit.Assert.*;

public class ModelTest {

    @org.junit.Test
    public void adunare() {
        Model model=new Model();
        Polinom a=new Polinom("x^3+8x^2-6x");
        Polinom b=new Polinom("x-2");
        Polinom res=new Polinom("x^3+8x^2-5x-2");
        assertEquals(""+res,""+model.adunare(a,b));
    }

    @org.junit.Test
    public void scadere() {
        Model model=new Model();
        Polinom a=new Polinom("x^3+8x^2-6x");
        Polinom b=new Polinom("x-2");
        Polinom res=new Polinom("x^3+8x^2-7x+2");
        assertEquals(""+res,""+model.scadere(a,b));
    }

    @org.junit.Test
    public void inmultire() {
        Model model=new Model();
        Polinom a=new Polinom("x^3+8x^2-6x");
        Polinom b=new Polinom("x-2");
        Polinom res=new Polinom("x^4+6x^3-22x^2+12x");
        assertEquals(""+res,""+model.inmultire(a,b));
    }

    @org.junit.Test
    public void impartire() {
        Model model=new Model();
        Polinom a=new Polinom("x^3+8x^2-6x");
        Polinom b=new Polinom("x-2");
        Polinom res=new Polinom("x^2+10x+14");
        assertEquals(""+res,""+model.impartire(a,b));
    }

    @org.junit.Test
    public void derivare() {
        Model model=new Model();
        Polinom a=new Polinom("x^3+8x^2-6x");
        Polinom res=new Polinom("3x^2+16x-6");
        assertEquals(""+res,""+model.derivare(a));
    }

    @org.junit.Test
    public void integrare() {
        Model model=new Model();
        Polinom a=new Polinom("x^3+8x^2-6x");
        Polinom res=new Polinom("0.25x^4+2.67x^3-3x^2");
        assertEquals(""+res,""+model.integrare(a));
    }
}