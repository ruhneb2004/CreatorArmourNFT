# CreatorArmour Smart Contract

This project uses [Foundry](https://book.getfoundry.sh/) for Ethereum smart contract development.

## 🚀 Getting Started

Follow these steps to set up the project after cloning:

### 1. Clone the Repository

```bash
git clone <repo-url>
cd <repo-name>
```

### 2. Install Foundry (if not already installed)

```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

> You may need to restart your terminal after installing Foundry.

### 3. Install Dependencies

```bash
forge install
```

This will install any dependencies listed in `foundry.toml` into the `lib/` directory.

### 4. Build the Project

```bash
make build
```

### 5. Set Environment Variables

If the project uses a `.env` file for secrets or configuration:

```bash
cp .env.example .env
```

Then open `.env` and update it with your credentials or RPC URLs.

### 6. Run Tests

```bash
make test
```

Check the make file to explore different testing options provided like

```bash
    make test-sepolia
```

### 7. Deploy or Run Scripts

Example for deploying with a local node:

```bash
    make deploy
```

for deploying to anvil

```bash
    make deploy-sepolia
```

for sepolia, and so on...

---

## 📂 Project Structure

- `src/` – Contract source files
- `script/` – Deployment and scripting logic
- `test/` – Unit tests
- `lib/` – External libraries (auto-installed)
- `foundry.toml` – Foundry project config

---

## 🛠 Requirements

- [Foundry](https://book.getfoundry.sh/getting-started/installation)
- Git
- (Optional) A local Ethereum node (e.g., Anvil or Hardhat)

---

## 📄 License

MIT
