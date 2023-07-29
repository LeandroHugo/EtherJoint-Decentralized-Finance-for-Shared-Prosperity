pragma solidity ^0.5.0;

// Define a new contract named `JointSavings`
contract JointSavings {

    // Two variables of type `address payable` named `accountOne` and `accountTwo`
    address payable accountOne;
    address payable accountTwo;

    // A variable of type `address public` named `lastToWithdraw`
    address public lastToWithdraw;

    // Two variables of type `uint public` named `lastWithdrawAmount` and `contractBalance`.
    uint public lastWithdrawAmount;
    uint public contractBalance;

    // Withdraw function
    function withdraw(uint amount, address payable recipient) public {
        // Check if the recipient is either `accountOne` or `accountTwo`
        require(recipient == accountOne || recipient == accountTwo, "You don't own this account!");

        // Check if there are enough funds
        require(address(this).balance >= amount, "Insufficient funds!");

        // Check if `lastToWithdraw` is not equal to `recipient`
        if (lastToWithdraw != recipient) {
            lastToWithdraw = recipient;
        }

        // Transfer the `amount`
        recipient.transfer(amount);

        // Set `lastWithdrawAmount` equal to `amount`
        lastWithdrawAmount = amount;

        // Update `contractBalance` variable
        contractBalance = address(this).balance;
    }

    // Deposit function
    function deposit() public payable {
        // Update `contractBalance` variable
        contractBalance = address(this).balance;
    }

    // Set accounts function
    function setAccounts(address payable account1, address payable account2) public{
        accountOne = account1;
        accountTwo = account2;
    }

    // Default fallback function
    function() external payable {
        // Update `contractBalance` variable
        contractBalance = address(this).balance;
    }
}
