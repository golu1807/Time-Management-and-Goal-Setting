package com.timetrack.service;

import com.timetrack.model.User;
import com.timetrack.repository.UserRepository;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class UserService {

    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public List<User> getUsersWithFilters(String role, String status, String query) {
        List<User> users = userRepository.findAll();

        if (role != null && !role.isEmpty()) {
            users = users.stream()
                    .filter(u -> role.equals(u.getRole()))
                    .toList();
        }

        if (status != null && !status.isEmpty()) {
            users = users.stream()
                    .filter(u -> status.equals(u.getStatus()))
                    .toList();
        }

        if (query != null && !query.isEmpty()) {
            String lowerQuery = query.toLowerCase();
            users = users.stream()
                    .filter(u -> u.getName().toLowerCase().contains(lowerQuery) ||
                            u.getEmail().toLowerCase().contains(lowerQuery))
                    .toList();
        }

        return users;
    }

    public User updateUserStatus(Long id, String status) {
        User user = userRepository.findById(id).orElseThrow(() -> new RuntimeException("User not found"));
        user.setStatus(status);
        return userRepository.save(user);
    }

    public User updateUserRole(Long id, String role) {
        User user = userRepository.findById(id).orElseThrow(() -> new RuntimeException("User not found"));
        user.setRole(role);
        return userRepository.save(user);
    }
}
