// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// Interface for ERC20 token standard
interface IERC20 {
    function totalSupply() external view returns (uint);
    function balanceOf(address account) external view returns (uint);
    function transfer(address recipient, uint amount) external returns (bool);
    
    // Event to be emitted when a transfer occurs
    event Transfer(address indexed from, address indexed to, uint amount);
}

// ERC20 token contract that implements the IERC20 interface
contract ERC20 is IERC20 {
    // Immutable variable to store the contract owner's address
    address public immutable owner;

    // Total supply of the ERC20 token
    uint public totalSupply;

    // Mapping to store the balance of each address
    mapping (address => uint) public balanceOf;

    // Struct to represent an item
    struct Item {
        uint itemId;
        string itemName;
        uint itemPrice;
    }
    
    // Mapping to store the items by their IDs
    mapping(uint => Item) public items;
    
    // Variable to keep track of the number of items
    uint public itemCount;

    // Constructor that initializes the contract and sets the owner as the deployer of the contract
    constructor() {
        owner = msg.sender;
        totalSupply = 0;
    }

    // Modifier to restrict access to certain functions only to the contract owner
    modifier onlyOwner {
        require(msg.sender == owner, "Only the contract owner can execute this function");
        _;
    }

    // Public constant variables to store the name, symbol, and decimals of the ERC20 token
    string public constant name = "Degen";
    string public constant symbol = "DGN";
    uint8 public constant decimals = 0;

    // Function to transfer tokens from the sender to a recipient
    function transfer(address recipient, uint amount) external returns (bool) {
        // Check if the sender has sufficient balance to make the transfer
        require(balanceOf[msg.sender] >= amount, "The balance is insufficient");

        // Deduct the transferred amount from the sender's balance and add it to the recipient's balance
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;

        // Emit a Transfer event to log the transfer
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    // Function to mint new tokens (increase total supply) - can only be called by the owner
    function mint(address receiver, uint amount) external onlyOwner {
        // Increase the balance of the receiver and total supply by the specified amount
        balanceOf[receiver] += amount;
        totalSupply += amount;

        // Emit a Transfer event to log the minting
        emit Transfer(address(0), receiver, amount);
    }

    // Function to burn tokens (decrease total supply)
    function burn(uint amount) external {
        // Check if the amount to burn is greater than zero and the sender has sufficient balance
        require(amount > 0, "Amount should not be zero");
        require(balanceOf[msg.sender] >= amount, "The balance is insufficient");

        // Deduct the burned amount from the sender's balance and total supply
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;

        // Emit a Transfer event to log the burning
        emit Transfer(msg.sender, address(0), amount);
    }
    
    // Function to add an item to the store - can only be called by the owner
    function addItem(string memory itemName, uint256 itemPrice) external onlyOwner {
        // Increment the itemCount to create a new item ID
        itemCount++;

        // Create a new Item and store it in the items mapping
        Item memory newItem = Item(itemCount, itemName, itemPrice);
        items[itemCount] = newItem;
    }

    // Function to get all the items in the store
    function getItems() external view returns (Item[] memory) {
        // Create a new dynamic array to hold all the items
        Item[] memory allItems = new Item[](itemCount);
        
        // Iterate through all items and add them to the array
        for (uint i = 1; i <= itemCount; i++) {
            allItems[i - 1] = items[i];
        }
        
        // Return the array of items
        return allItems;
    }
    
    // Function to redeem an item from the store
    function redeem(uint itemId) external {
        // Check if the provided item ID is valid
        require(itemId > 0 && itemId <= itemCount, "Invalid item ID");
        
        // Retrieve the item based on the provided ID
        Item memory redeemedItem = items[itemId];
        
        // Check if the sender has sufficient balance to redeem the item
        require(balanceOf[msg.sender] >= redeemedItem.itemPrice, "Insufficient balance to redeem");
        
        // Deduct the item price from the sender's balance and add it to the owner's balance
        balanceOf[msg.sender] -= redeemedItem.itemPrice;
        balanceOf[owner] += redeemedItem.itemPrice;
        
        // Emit a Transfer event to log the redemption
        emit Transfer(msg.sender, address(0), redeemedItem.itemPrice);
    }
}
