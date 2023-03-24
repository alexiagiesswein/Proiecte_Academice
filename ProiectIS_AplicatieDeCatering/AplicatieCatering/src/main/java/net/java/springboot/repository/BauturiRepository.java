package net.java.springboot.repository;

import net.java.springboot.model.Bauturi;
import net.java.springboot.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BauturiRepository extends JpaRepository<Bauturi, Long> {

}
