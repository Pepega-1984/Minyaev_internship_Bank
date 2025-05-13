package com.example.cardmanagement.repository;

import org.springframework.boot.autoconfigure.data.web.SpringDataWebProperties.Pageable;
import org.springframework.data.domain.Page;
import org.springframework.data.jpa.repository.JpaRepository;
import com.example.cardmanagement.model.BankCard;
import com.example.cardmanagement.model.User;

public interface BankCardRepository extends JpaRepository<BankCard, Long>{
    Page<BankCard> findByUser(User user, Pageable pageable);
}
