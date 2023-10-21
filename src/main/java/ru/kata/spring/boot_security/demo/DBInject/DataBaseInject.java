package ru.kata.spring.boot_security.demo.DBInject;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import ru.kata.spring.boot_security.demo.model.Role;
import ru.kata.spring.boot_security.demo.model.User;
import ru.kata.spring.boot_security.demo.repository.RoleRepository;
import ru.kata.spring.boot_security.demo.repository.UserRepository;

import javax.annotation.PostConstruct;
import java.util.Set;

@Configuration
public class DataBaseInject {
    private UserRepository userRepository;
    private RoleRepository roleRepository;
    private BCryptPasswordEncoder passwordEncoder;

    public DataBaseInject(UserRepository userRepository, RoleRepository roleRepository, BCryptPasswordEncoder passwordEncoder){
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.passwordEncoder = passwordEncoder;
    }
    @PostConstruct
    public void inject() {
        Role adminRole = new Role("ROLE_ADMIN");
        roleRepository.save(adminRole);
        Role userRole = new Role("ROLE_USER");
        roleRepository.save(userRole);

        User admin = new User("admin", "admin", "admin@mail.ru", "admin", passwordEncoder.encode("admin"));
        admin.setRoles(Set.of(adminRole, userRole));
        userRepository.save(admin);
        User user = new User("user", "user", "user@mail.ru", "user", passwordEncoder.encode("user"));
        user.setRoles(Set.of(userRole));
        userRepository.save(user);
    }
}
