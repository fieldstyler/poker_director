# 🃏 Poker Director

**Poker Director** is a tournament management web application built with Ruby on Rails and TailwindCSS. It helps organize and track poker games, leagues, and player statistics — making it easy to manage blind structures, points, knockouts, and more.

---

## 🚀 Features

- Player and League management
- Blind level configuration
- In-game countdown
- Season and session scoring
- Many-to-many relationships (players ↔ leagues)
- Responsive UI styled with TailwindCSS
- Dynamic search, sortable tables, and more

---

## 🧠 Design Highlights

- **Timer Logic**: Custom countdown timer per blind level, with dynamic break and knockout handling.
- **Scoring System**: League sessions award points based on placement and knockouts.
- **Data Relationships**: Players can belong to multiple leagues. Sessions auto-associate GamePlayers.
- **Dynamic UI**: JavaScript-enhanced modals, game progress without page refresh, conditional controls based on session state.

---

## 📦 Tech Stack

- **Ruby on Rails** (v7+)
- **TailwindCSS** for styling
- **Turbo/Hotwire** (coming soon)
- **PostgreSQL** or SQLite (dev)
- **Heroicons** and Flowbite UI

---

## 🧪 Development Notes

- Rebuys and multi-table support planned
- Email summaries and stats export coming soon
- Turbo + Stimulus integration in progress
- Expanding testing coverage as features stabilize.

---

## 🛠️ Setup Instructions

```bash
# Clone the repo
git clone https://github.com/YOUR_USERNAME/poker_director.git
cd poker_director

# Install dependencies
bundle install

# Set up the database
bin/rails db:setup

# Start the app
bin/dev
