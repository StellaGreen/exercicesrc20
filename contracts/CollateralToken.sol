//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.5;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract CollateralToken is ERC20 {
  constructor(uint initialSupply) ERC20("Collateral Token", "CT") {
    _mint(msg.sender, initialSupply);
  }
}