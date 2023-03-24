package net.java.springboot.web;

import net.java.springboot.service.BauturiService;
import net.java.springboot.service.DesertService;
import net.java.springboot.web.dto.BauturiDto;
import net.java.springboot.web.dto.DesertDto;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/desert")
public class DesertController {

    private DesertService desertService;

    public DesertController(DesertService desertService){
        this.desertService = desertService;
    }

    @ModelAttribute("desert")
    public DesertDto bauturiSave() {
        return new DesertDto();
    }

    @GetMapping
    public String showRegistrationForm() {
        return "desert";
    }

    @PostMapping
    public String registerUserAccount(@ModelAttribute("desert") DesertDto desertDto) {

        desertService.save(desertDto);

        return "redirect:/admin/info";
    }
}
