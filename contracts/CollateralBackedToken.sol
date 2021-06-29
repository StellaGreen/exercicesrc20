//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.5;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./CollateralToken.sol";

contract CollateralBackedToken is ERC20 {
  CollateralToken private _ct;
  uint private _rate;


  constructor(address tokenAddress, uint rate_) ERC20("Collateral Backed Token", "CBT") {
    _ct = CollateralToken(tokenAddress);
    _rate = rate_;
  }

  function balanceLocked() public view returns (uint) {
    return balanceOf(msg.sender) * _rate;
  } 
  
  function deposit(uint amount) public {
    _ct.transferFrom(msg.sender, address(this), amount);
    _mint(msg.sender, amount /_rate);
  }
  
  function withdraw(uint amount) public {
    _burn(msg.sender, amount / _rate);
    _ct.transfer(msg.sender, amount);
  }
}