public class MainClass {

    public static void main(String[] args) {

        Model model = new Model();
        View view = new View(model);
        Controller controller = new Controller(model, view);

        view.setSize(600,500);
        view.setVisible(true);

    }
}
