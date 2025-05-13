package com.example.cardmanagement.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.cardmanagement.model.User;


public interface UserRepository extends JpaRepository<User, Long>{
    User findByUsername(String username);
}
