public class Model {

    public Polinom adunare(Polinom a,Polinom b){
        Polinom res=new Polinom(a);
        for(Monom x:b.getPolinom())
            res.addMonom(new Monom(x));
        res.combinare();
        return res;
    }

    public Polinom scadere(Polinom a,Polinom b) {
        return adunare(a,inmultire(b,new Polinom(new Monom(-1,0))));
    }

    public Polinom inmultire(Polinom a, Polinom b){
        Polinom res=new Polinom();
        a.combinare();
        b.combinare();
        for(Monom x:a.getPolinom()){
            for(Monom y:b.getPolinom()) {
                Monom monom=new Monom(x.getCoeficient()*y.getCoeficient(),x.getPutere()+y.getPutere());
                res.addMonom(monom);
            }
        }
        res.combinare();
        return res;
    }

    public Polinom impartire(Polinom a,Polinom b){
        a.combinare();
        b.combinare();
        Polinom rest=new Polinom(a);
        Polinom res=new Polinom();
        while(rest.getGrad()>=b.getGrad()) {
            Monom x=new Monom(rest.getPolinom().get(0).getCoeficient()/b.getPolinom().get(0).getCoeficient(),rest.getPolinom().get(0).getPutere()-b.getPolinom().get(0).getPutere());
            res.addMonom(x);
            rest=scadere(rest,inmultire(b,new Polinom(x)));
        }
        return res;
    }

    public Polinom derivare(Polinom a){
        Polinom res= new Polinom();
        double coeficient;
        int putere;
        for(Monom monom: a.getPolinom())
            if(monom.getPutere()>0)
            {
                coeficient=monom.getCoeficient()*monom.getPutere();
                putere=monom.getPutere()-1;
                res.addMonom(new Monom(coeficient, putere));
            }
        res.combinare();
        return res;
    }
    public Polinom integrare(Polinom a){
        Polinom res= new Polinom();
        double coeficient;
        int putere;
        for(Monom monom: a.getPolinom()){
            coeficient=monom.getCoeficient()/(monom.getPutere()+1);
            putere=monom.getPutere()+1;
            res.addMonom(new Monom(coeficient, putere));


        }
        res.combinare();
        return res;
    }
}

