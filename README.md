# Degen Token (ERC-20): Unlocking the Future of Gaming
The project is a custom token contract in Solidity with a redeemable item system and ownership-controlled minting and burning functions.

##Description
The project is a Solidity smart contract that implements a custom token, referred to as "MyToken" (MTK), adhering to the MIT license. The contract includes functionalities to manage the token supply, token balances, and token transfers. It also provides features to mint new tokens, burn existing tokens, and allows the owner, designated during contract deployment, to execute specific functions exclusively.

The token contract comprises an interface called "ICustomToken" that defines four external functions: "getTotalSupply()", "getBalance(address account)", "transfer(address recipient, uint amount)", and an "event TokenTransfer(address indexed from, address indexed to, uint amount)" to track token transfers.

The "CustomToken" contract itself implements the "ICustomToken" interface and maintains essential state variables like "owner" (the contract deployer's address) and "totalSupply" to keep track of the overall token supply. It uses a mapping "balanceOf" to record the token balance of each address on the blockchain.

Additionally, the contract introduces a struct named "CustomItem" to represent individual items for a redeemable item system. Each item is associated with a unique "itemId," an "itemName," and an "itemPrice" in tokens. The contract maintains a mapping "customItems" to store the details of these custom items, and an "itemCount" variable to track the number of items added.

The contract includes several functions to manage the item system. The "addItem" function allows the contract owner to add new custom items to the system by specifying the "itemName" and "itemPrice." The "getItems" function enables anyone to retrieve a list of all available custom items.

For token holders to redeem an item, they can use the "redeem" function, providing the "itemId" of the desired item. The function checks if the token holder has sufficient balance to redeem the item, and if so, it transfers the "itemPrice" tokens from the token holder to the contract owner, effectively "burning" the tokens, as they are removed from circulation.

The contract features an "onlyOwner" modifier to restrict specific functions to be executed solely by the contract owner, ensuring better control over token minting, and some critical operations.

The contract provides standard ERC-20-like functions like "transfer" and "getBalance," allowing token holders to transfer tokens to other addresses and check their token balances, respectively.

##Executing 

Step 1: Compile and Deploy the Smart Contract on Ethereum Blockchain

Using Remix or your preferred Ethereum development environment, deploy the "CustomToken" smart contract onto the Ethereum blockchain. Ensure that you have a connection to the Ethereum network and enough ETH in your account to cover the deployment costs.

Step 2: Configure Token Information

During contract deployment, provide the desired name and symbol for the custom token ("MyToken" and "MTK," respectively). These details will uniquely identify your token on the Ethereum blockchain.

Step 3: Initial Token Minting

After deploying the contract, as the contract owner, use the "mint" function to mint and distribute the initial supply of tokens to various addresses. This kickstarts your project's ecosystem by providing tokens to users, contracts, or stakeholders.

Step 4: Populate the In-Game Store

As the contract owner, use the "addItem" function to add a range of in-game items to the store. Each item should be assigned a unique ID, have a descriptive name, and be priced in "MyToken" tokens. This allows players to redeem their tokens for these in-game items.

Step 5: Token Functionality for Players

Players can interact with the "MyToken" contract through several functions:

Transfer tokens to other players or addresses using the "transfer" function.
"Burn" tokens to decrease their supply, typically in special game scenarios or mechanics.
Check their token balance using the "getBalance" function to keep track of their in-game currency.

Step 6: Explore Available In-Game Items

Implement the "getItems" function in your smart contract to enable players to explore all available in-game items and their corresponding details. Players can query this function to learn about the items they can redeem.

Step 7: Redeem In-Game Items

Players can redeem in-game items using the "redeem" function with the specific item ID. Upon redemption, the corresponding number of "MyToken" tokens will be deducted from the player's balance, and they will receive the redeemed item.

Step 8: Special Owner Functions

As the contract owner, you have exclusive access to specific functions. For example, you can add new items to the store, mint additional tokens, and manage crucial operations using the "onlyOwner" modifier to ensure secure and controlled administration.

Before deploying the contract on the Ethereum mainnet or any production network, thoroughly test the smart contract to identify and fix potential issues, ensuring the seamless operation of your in-game economy and token mechanics.

##Authors
Ashi Yadav

##Licenses
This Contract is using the MIT License



