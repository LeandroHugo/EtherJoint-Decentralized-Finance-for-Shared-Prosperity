![Alt text](../Images/Joint.png)
---

# Joint Savings Contract Guide

In this guide, we will walk through the steps to create a joint savings contract using Solidity. This contract will allow two users to jointly manage a balance of Ether.

## Step 1: Initialize the Contract

First, we define the version of the Solidity compiler we will use.

```solidity
pragma solidity ^0.5.0;
```

Next, we create our contract `JointSavings`.

```solidity
contract JointSavings {
    // The contract will be defined here.
}
```

## Step 2: Define Variables

Inside the contract, we will define the necessary variables.

```solidity
address payable accountOne;
address payable accountTwo;
address public lastToWithdraw;
uint public lastWithdrawAmount;
uint public contractBalance;
```

## Step 3: Define the Withdraw Function

We will define a function named `withdraw` that accepts an amount and a recipient as arguments. It checks if the recipient is one of the account holders and if there are enough funds for the withdrawal. It then transfers the specified amount to the recipient and updates the contract's balance and last withdrawal details.

```solidity
function withdraw(uint amount, address payable recipient) public {
    require(recipient == accountOne || recipient == accountTwo, "You don't own this account!");
    require(address(this).balance >= amount, "Insufficient funds!");
    
    if (lastToWithdraw != recipient) {
        lastToWithdraw = recipient;
    }
    
    recipient.transfer(amount);
    lastWithdrawAmount = amount;
    contractBalance = address(this).balance;
}
```

## Step 4: Define the Deposit Function

Next, we define a function named `deposit`. This function allows anyone to send Ether to the contract, which is then added to the contract's balance.

```solidity
function deposit() public payable {
    contractBalance = address(this).balance;
}
```

## Step 5: Define the Set Accounts Function

We also need a function to set the addresses of the two account holders. 

```solidity
function setAccounts(address payable account1, address payable account2) public{
    accountOne = account1;
    accountTwo = account2;
}
```

## Step 6: Add a Default Fallback Function

Finally, we add a default fallback function to automatically add any Ether sent to the contract to its balance.

```solidity
function() external payable { 
    contractBalance = address(this).balance;
}
```

That's it! You now have a basic joint savings contract. Please note that this contract does not restrict who can call the `setAccounts` and `deposit` functions, so you might want to add some access controls in a production environment.

---

This markdown content can be saved into a file named `JointSavingsGuide.md`.