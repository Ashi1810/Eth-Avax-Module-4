// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

interface ICustomToken {
    function getTotalSupply() external view returns (uint);
    function getBalance(address account) external view returns (uint);
    function transfer(address recipient, uint amount) external returns (bool);
    
    event TokenTransfer(address indexed from, address indexed to, uint amount);
}

contract CustomToken is ICustomToken {
    address public immutable owner;
    uint public totalSupply;
    mapping (address => uint) public balanceOf;

    struct CustomItem {
        uint itemId;
        string itemName;
        uint itemPrice;
    }
    
    mapping(uint => CustomItem) public customItems;
    uint public itemCount;

    constructor() {
        owner = msg.sender;
        totalSupply = 0;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Only the contract owner can execute this function");
        _;
    }

    string public constant name = "MyToken";
    string public constant symbol = "MTK";
    uint8 public constant decimals = 0;

    function transfer(address recipient, uint amount) external returns (bool) {
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");

        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;

        emit TokenTransfer(msg.sender, recipient, amount);
        return true;
    }

    function mint(address receiver, uint amount) external onlyOwner {
        balanceOf[receiver] += amount;
        totalSupply += amount;
        emit TokenTransfer(address(0), receiver, amount);
    }

    function burn(uint amount) external {
        require(amount > 0, "Amount should not be zero");
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;

        emit TokenTransfer(msg.sender, address(0), amount);
    }
    
    function addItem(string memory itemName, uint256 itemPrice) external onlyOwner {
        itemCount++;
        CustomItem memory newItem = CustomItem(itemCount, itemName, itemPrice);
        customItems[itemCount] = newItem;
    }

    function getItems() external view returns (CustomItem[] memory) {
        CustomItem[] memory allItems = new CustomItem[](itemCount);
        
        for (uint i = 1; i <= itemCount; i++) {
            allItems[i - 1] = customItems[i];
        }
        
        return allItems;
    }
    
    function redeem(uint itemId) external {
        require(itemId > 0 && itemId <= itemCount, "Invalid item ID");
        CustomItem memory redeemedItem = customItems[itemId];
        
        require(balanceOf[msg.sender] >= redeemedItem.itemPrice, "Insufficient balance to redeem");
        
        balanceOf[msg.sender] -= redeemedItem.itemPrice;
        balanceOf[owner] += redeemedItem.itemPrice;
        emit TokenTransfer(msg.sender, address(0), redeemedItem.itemPrice);
    }

    function getTotalSupply() external view returns (uint) {
        return totalSupply;
    }

    function getBalance(address account) external view returns (uint) {
        return balanceOf[account];
    }
}
