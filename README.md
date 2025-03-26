# Crowdfunding Dapp (Solidity Practice)

This project is a smart contract for a basic crowdfunding platform, written in Solidity. It allows people to contribute funds toward a target amount before a deadline. The contract tracks individual contributions and prevents donations after the deadline has passed.

This project is being built and iterated on as part of my learning process.

---

## 🧠 Features (Current)

- Accepts ETH contributions from multiple users
- Sets a **target funding amount** and a **deadline** (based on block timestamp)
- Tracks:
  - Number of contributors
  - Total raised amount
  - Individual contributions
- Enforces a **minimum contribution** of `100 wei`
- Only allows contributions **before the deadline**
- Contract balance is viewable

---

## 🚧 Features Planned (Next Steps)

> These will be developed in future branches as I continue learning.

- Refunds: If the target isn’t met before the deadline, contributors can withdraw their ETH
- Fund withdrawal: If the target *is* met, the manager can withdraw funds
- Events: Emit events for key actions like contribution, refund, and payout
- Modifiers: Add custom modifiers to simplify function restrictions
- Testing: Add test coverage using Hardhat or Truffle

---

## 🛠️ How It Works (Current Flow)

1. Contract is deployed by a manager with:
   - A target amount
   - A deadline (in seconds from now)
2. Users can send ETH by calling `sendEth()`
3. Contributions must be at least `100 wei`
4. Contributions are tracked per address
5. The contract keeps track of total raised amount and contributor count

---

## 📄 Contract Overview

```solidity
function sendEth() public payable
