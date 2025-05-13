# 🏦 Система управления банковскими картами (Backend)

Spring Boot приложение для управления банковскими картами с JWT аутентификацией и роль-базированным доступом.

## 📋 Функциональность

- **Аутентификация/Авторизация** (JWT)
- **Управление картами**:
  - Создание/блокировка/активация карт
  - Переводы между картами
  - Просмотр баланса
- **Ролевая модель**:
  - `ADMIN`: Полный доступ
  - `USER`: Только свои карты

## 🛠 Технологии

- **Java 17**
- **Spring Boot 3.2+**
- **Spring Security + JWT**
- **PostgreSQL**
- **Liquibase** (миграции БД)
- **Swagger** (документация API)

## 🚀 Запуск проекта

### Требования:
- JDK 17+
- PostgreSQL 15+
- Maven 3.9+

### 1. Настройка БД:
```bash
# Создайте БД
CREATE DATABASE card_management;

# Настройки в application.properties:
spring.datasource.url=jdbc:postgresql://localhost:5432/card_management
spring.datasource.username=postgres
spring.datasource.password=yourpassword
