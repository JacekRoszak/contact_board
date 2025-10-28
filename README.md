# Contact Board

Prosta aplikacja do zarządzania kontaktami napisana w Rails 8 z Hotwire.

## Wymagania systemowe

- Ruby 3.4+
- Node.js 18+
- PostgreSQL 12+
- Yarn

## Instalacja na Linux

```bash
# Zainstaluj PostgreSQL
sudo apt update
sudo apt install postgresql postgresql-contrib libpq-dev

# Zainstaluj Ruby (przez rbenv lub rvm)
# Przykład z rbenv:
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
rbenv install 3.4.3
rbenv global 3.4.3

# Zainstaluj Node.js i Yarn
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install nodejs
npm install -g yarn

# Sklonuj repozytorium
git clone git@github.com:JacekRoszak/contact_board.git
cd contact_board

# Zainstaluj gemy
bundle install

# Zainstaluj pakiety JS
yarn install

# Skonfiguruj bazę danych
sudo -u postgres createuser -s $(whoami)
createdb contact_board_development
createdb contact_board_test

# Uruchom migracje i seed
bin/rails db:migrate
bin/rails db:seed
```

## Uruchomienie

```bash
# Uruchom serwer
bin/rails server

# W osobnym terminalu zbuduj assety (jeśli potrzeba)
yarn build
yarn build:css
```

Aplikacja będzie dostępna pod `http://localhost:3000`

## Logowanie

Domyślne konto:
- Email: `admin@contactboard.com`
- Hasło: `password123`

## Funkcjonalności

- CRUD kontaktów (dodawanie, edycja, usuwanie, wyświetlanie)
- Edycja inline z użyciem Stimulus
- Filtrowanie po kategorii (Turbo Frame)
- Automatyczne zliczanie kontaktów
- TurboStream dla operacji bez przeładowania strony
- Responsywny interfejs

## Testy

```bash
# Uruchom wszystkie testy
bundle exec rspec

# Testy modeli
bundle exec rspec spec/models/

# Testy feature
bundle exec rspec spec/features/
```

## Technologie

- Rails 8
- PostgreSQL
- Hotwire (Turbo + Stimulus)
- ViewComponent
- TailwindCSS + custom CSS
- RSpec + FactoryBot
- Devise + CanCanCan
