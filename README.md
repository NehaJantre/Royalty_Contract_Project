# Royalty_Contract_Project

Our team identified an opportunity to improve an ongoing payment  system issue across the world. We developed a flexible solution to provide individuals and companies across different industries (artist, suppliers, royalty holders, nonprofits etc.) a secure and instant access to their funds from the product being sold. This effectively can eliminate scandals while also reducing the turn around time for people to be paid while providing a layer of trust that they are getting their agreed upon percentage that was committed. 

The solution our team developed is a Royalty Smart Contract written in Solidity for the ETH blockchain that delivers a customizable distribution of incoming funds. This fintech solution automates a type of payment system that is inherently trustless via the smart contract logic and leveraging blockchain decentralization. This enables a set and forget aspect that can reduce some of the business admin oversight costs required with auditing.


Deployment steps:
1) clone repo
2) open remix https://remix.ethereum.org/
3) install and open ganache
4) install and open metamask
5) under networks in metamask add a new rpc network, name it devnetwork and input the following as seen in ganache quick start into the devnetwork fields. NETWORK ID = 
5777
RPC SERVER = HTTP://127.0.0.1:7545
6) save network in metamask and then grab several private keys from the ganache accounts and import those into the metamask devnetwork.
7) in remix copy the solidity code from the file named PaymentSplitterFinal1.sol
8) compile the contract code with the correspoding compiler version
9) on the deployment tab change the Environment to injected web3. This should automatically open the metamask app requesting your password and which account you would like to connect, select account (with 100 eth) click connect
10) in remix select the account that will be the contract sender account
11) under the contract name in remix click the arrow to the right of deploy and input the address's and the number of shares coorespoding with each account
12) click transact 

