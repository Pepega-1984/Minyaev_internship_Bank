package com.example.cardmanagement.controller;

import java.math.BigDecimal;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.cardmanagement.service.CardService;


@RestController
@RequestMapping("/api/cards")

public class CardController {
    private final CardService cardService;
    public CardController(CardService cardService) {
        this.cardService = cardService;
    }

    @PostMapping("/{cardId}/block")
    public void blockCard(@PathVariable Long cardId){
        cardService.blockCard(cardId);
    }

    @PostMapping("/transfer")
    public void transferMoney(
            @RequestParam Long fromCardId,
            @RequestParam Long toCardId,
            @RequestParam BigDecimal amount){
        cardService.transferMoney(fromCardId, toCardId, amount);
    }
}
