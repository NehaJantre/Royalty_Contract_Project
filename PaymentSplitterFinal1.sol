pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Context.sol";

contract PaymentSplitterFinal is Context {
    using SafeMath for uint256;

    event PayeeAdded(address account, uint256 shares);
    event PayeeRemoved(address account);
    event PaymentReleased(address to, uint256 amount);
    event PaymentReceived(address from, uint256 amount);

    uint256 private _totalShares;
    uint256 private _totalReleased;

    mapping(address => uint256) private _shares;
    mapping(address => uint256) private _released;
    address[] private _payees;


    constructor (address[] memory payees, uint256[] memory shares) public payable {
        // solhint-disable-next-line max-line-length
        require(payees.length == shares.length, "PaymentSplitter: payees and shares length mismatch");
        require(payees.length > 0, "PaymentSplitter: no payees");

        for (uint256 i = 0; i < payees.length; i++) {
            _addPayee(payees[i], shares[i]);
        }
    }


    receive () external payable virtual {
        emit PaymentReceived(_msgSender(), msg.value);
    }

    //Getter for the total shares held by payees.
    function totalShares() public view returns (uint256) {
        return _totalShares;
    }

    
     // Getter for the total amount of Ether already released.
     
    function totalReleased() public view returns (uint256) {
        return _totalReleased;
    }

    
    // Getter for the amount of shares held by an account.
     
    function shares(address account) public view returns (uint256) {
        return _shares[account];
    }

    
    //Getter for the amount of Ether already released to a payee.
     
    function released(address account) public view returns (uint256) {
        return _released[account];
    }

    
    //Getter for the address of the payee number `index`.
     
    function payee(uint256 index) public view returns (address) {
        return _payees[index];
    }

    
     //Triggers a transfer to `account` of the amount of Ether they are owed, according to their percentage of the total shares and their previous withdrawals.
     
    function release(address payable account) public virtual {
        require(_shares[account] > 0, "PaymentSplitter: account has no shares");

        uint256 totalReceived = address(this).balance.add(_totalReleased);
        uint256 payment = totalReceived.mul(_shares[account]).div(_totalShares).sub(_released[account]);

        require(payment != 0, "PaymentSplitter: account is not due payment");

        _released[account] = _released[account].add(payment);
        _totalReleased = _totalReleased.add(payment);

        account.transfer(payment);
        emit PaymentReleased(account, payment);
    }


     //Add a new payee to the contract.
    function _addPayee(address account, uint256 shares_) public {
        require(account != address(0), "PaymentSplitter: account is the zero address");
        require(shares_ > 0, "PaymentSplitter: shares are 0");
        require(_shares[account] == 0, "PaymentSplitter: account already has shares");

        _payees.push(account);
        _shares[account] = shares_;
        _totalShares = _totalShares.add(shares_);
        emit PayeeAdded(account, shares_);
    }
    
     //Remove an existing payee from the contract (require the account and index #)
    function _removePayee(address account, uint256 index) public {
        require(
        index < _payees.length,
        "PaymentSplitter: index not in payee array"
    );
        require(
        account == _payees[index],
        "PaymentSplitter: account does not match payee array index"
    );

    _totalShares = _totalShares - _shares[account];
    _shares[account] = 0;
    _payees[index] = _payees[_payees.length - 1];
    _payees.pop();
    emit PayeeRemoved(account);
  }
}


/**
 ["0x5B38Da6a701c568545dCfcB03FcB875f56beddC4", 
 "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",
 "0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c",
 "0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db"]
 
 [50, 
 25,
 20,
 5];
 
withdrawPaymentsWithGas(address payable payee)

*/