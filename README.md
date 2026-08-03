# 🐓 Cockfight — Virtual Rooster Fighting & Parody Betting Platform

A satirical, full-stack Web Application built with **Ruby on Rails**, **SQLite**, and **Tailwind CSS**. **Cockfight** allows users to manage user-owned barns, view upcoming match cards with real-time odds, place virtual bets using satire wallets, and enables admins to schedule fights, settle outcomes, record fight records, and automatically distribute payouts.

---

## ⚡ Features

### 👤 Owner / User Features
- **Satire Wallet:** Real-time wallet balance updates and virtual wagering integrity backed by atomic database transactions.
- **Rooster Roster:** Browse roosters, view fight records (`Wins / Losses`), weight classes, and stats scoped to user-owned barns.
- **Match Arena:** View upcoming match cards with calculated betting pools and dynamic odds multipliers.
- **Betting Engine:** Place bets on the **🔴 Red Corner** or **🔵 Blue Corner** directly from match pages.

### 🛡️ Admin Dashboard (`/admin`)
- **Rooster Management:** Oversee and manage rooster profiles across the platform.
- **Match Card Scheduling:** Setup match cards pitting two roosters against each other.
- **Match Settlement & Automated Payout Engine:** 
  - Declare the winning rooster and record the win condition (`KO`, `TKO`, `Decision`, `Opponent Fled`).
  - Automatically update rooster fight records (`record_wins` / `record_losses`).
  - Calculate proportional pool payouts and automatically credit satire winnings into winning users' wallets within an atomic database transaction.

---

## 🛠️ Tech Stack

- **Framework:** [Ruby on Rails 7/8](https://rubyonrails.org/)
- **Database:** SQLite3
- **Styling & UI:** Tailwind CSS
- **Authentication:** `bcrypt` (Custom Auth / Session Management)
- **Environment Management:** Nix / nix-shell

---

## 🚀 Getting Started

### Prerequisites

Ensure you have the following installed on your system:
* **Ruby** (v3.1+)
* **Rails** (v7.0+)
* **SQLite3**
* **Nix** *(optional, for reproducible nix-shell environment)*

---

### Installation & Setup

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/your-username/cockfight.git](https://github.com/your-username/cockfight.git)
   cd cockfight

Enter the Nix environment (if using Nix):

Bash
nix-shell
Install dependencies:

Bash
bundle install
Set up the database and run migrations:

Bash
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed
Start the Rails development server:

Bash
bin/rails server
Access the application:

Open your browser and navigate to http://localhost:3000

Access the Admin Dashboard at http://localhost:3000/admin

🗄️ Core Database Models
 [ User ] ────1:N────> [ Bet ] <────1:N──── [ MatchCard ]
   │                                             │  │
   └── wallet_balance                            │  ├── 1:1 ──> [ MatchResult ]
                                                 │  │
                                   red/blue corner  └── winning_chicken_id
                                           │
                                     [ Chicken ]
                                 (wins / losses record)
User: Manages authentication (bcrypt) and satire wallet_balance.

Chicken: Represents roosters owned by users with attributes like name, weight_class, record_wins, and record_losses.

MatchCard: Defines a fight between two roosters (red_corner_chicken vs blue_corner_chicken), total pools, and status (scheduled / completed).

Bet: Connects a User to a MatchCard with a chosen corner (red / blue) and wager amount.

MatchResult: Records victory methods (KO, TKO, etc.), details, and the winning_chicken_id.

⚙️ Routing Overview
Ruby
Rails.application.routes.draw do
  root "matches#index"

  resources :matches, only: [:index, :show] do
    resources :bets, only: [:create]
  end

  resources :chickens

  namespace :admin do
    get '/', to: 'dashboard#index', as: :dashboard

    resources :match_cards do
      resources :match_results, only: [:new, :create]
    end

    resources :chickens
  end
end
💡 How Match Settlement & Payout Engine Works
Admin navigates to /admin and selects Settle Fight & Pay for an unsettled match.

Admin selects the victorious rooster and victory method.

The controller executes an atomic ActiveRecord::Base.transaction:

Marks the match card as completed.

Records the MatchResult.

Increments the winner's record_wins and loser's record_losses.

Calculates the winning corner multiplier: Total Match Pool / Winning Corner Pool.

Distributes payouts to each winning bettor's wallet_balance.

⚠️ Disclaimer
This platform is a parody/satirical simulation designed strictly for entertainment and educational programming purposes. No real money or actual animal fighting is involved.
