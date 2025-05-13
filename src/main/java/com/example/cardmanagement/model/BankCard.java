package com.example.cardmanagement.model;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Table(name = "bank_cards")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class BankCard {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "card_number_encrypted", nullable = false)
    private String cardNumberEncrypted;

    @Column(name = "card_number_masked", nullable = false)
    private String cardNumberMasked;

    @Column(nullable = false)
    private String cardHolder;

    @Column(nullable = false)
    private LocalDate expiryDate;

    @Column(nullable = false, columnDefinition = "DECIMAL(15,2) DEFAULT 0.00")
    private BigDecimal balance = BigDecimal.ZERO;

    @Column(name = "is_blocked")
    private boolean isBlocked;

    @Enumerated(EnumType.STRING)
    private CardStatus status;

    public enum CardStatus {
        ACTIVE, BLOCKED, EXPIRED
    }
}
