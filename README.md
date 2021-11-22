# Quotes Crawler

Web crawler que efetua buscas de frases no site <a href="http://quotes.toscrape.com/">Quotes to Scrape</a>.

## Requisitos

- Ruby 2.7.4
- Rails 6.1.4
- MongoDB 5.0.3

## Documentação
 
Todos os endpoints estão documentados conforme a especificação OpenAPI 3.1, disponível em https://quotes-crawler.herokuapp.com.

### Segurança

Os endpoints ```/quotes``` são protegidos por um token de acesso (JWT). Para obtê-lo é necessário um usuário e senha, caso não tenha utilize o endpoint ```/auth/sign-up``` para se cadastrar ou ```/auth/sign-in``` para acessar. Ambos retornam um JWT válido por 5 minutos.

