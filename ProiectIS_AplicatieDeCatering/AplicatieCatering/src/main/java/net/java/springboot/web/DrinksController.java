package net.java.springboot.web;

import net.java.springboot.service.BauturiService;
import net.java.springboot.web.dto.BauturiDto;
import net.java.springboot.web.dto.UserRegistrationDto;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.persistence.Column;

@Controller
@RequestMapping("/drinks")
public class DrinksController {

    private BauturiService bauturiService;

    public DrinksController(BauturiService bauturiService){
        this.bauturiService = bauturiService;
    }

    @ModelAttribute("drinks")
    public BauturiDto bauturiSave() {
        return new BauturiDto();
    }

    @GetMapping
    public String showRegistrationForm() {
        return "drinks";
    }

    @PostMapping
    public String registerUserAccount(@ModelAttribute("drinks") BauturiDto bauturiDto) {

        bauturiService.save(bauturiDto);

        return "redirect:/admin/info";
    }


}
