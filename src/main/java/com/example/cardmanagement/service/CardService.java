package com.example.cardmanagement.service;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.cardmanagement.model.BankCard;
import com.example.cardmanagement.repository.BankCardRepository;

@Service
public class CardService {
    private final BankCardRepository cardRepository;

    public CardService(BankCardRepository cardRepository) {
        this.cardRepository = cardRepository;
    }

    @Transactional
    public BankCard createCard(BankCard card) {
        return cardRepository.save(card);
    }

    public List<BankCard> getAllCards() {
        return cardRepository.findAll();
    }

    @Transactional
    public void blockCard(Long cardId) {
        BankCard card = cardRepository.findById(cardId)
                .orElseThrow(() -> new RuntimeException("Карта не найдена"));
        card.setBlocked(true);
        cardRepository.save(card);
    }

    @Transactional
    public void transferMoney(Long fromCardId, Long toCardId, BigDecimal amount) {
        BankCard fromCard = cardRepository.findById(fromCardId)
                .orElseThrow(() -> new RuntimeException("Исходная карта не найдена"));
        
        BankCard toCard = cardRepository.findById(toCardId)
                .orElseThrow(() -> new RuntimeException("Искомая катра не найдена"));

        fromCard.setBalance(fromCard.getBalance().subtract(amount));
        toCard.setBalance(toCard.getBalance().add(amount));

        cardRepository.save(fromCard);
        cardRepository.save(toCard);
    }
}
