package net.java.springboot.repository;

import net.java.springboot.model.Desert;
import net.java.springboot.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DesertRepository extends JpaRepository<Desert, Long> {
}
