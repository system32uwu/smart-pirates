// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Bread is ERC20 {
    IERC20 public doubloon;
    address public merchant;
    uint256 public constant EXCHANGE_RATE = 2; // 2 DBL for a pack of bread

    constructor(address _doubloon, address _baker) ERC20("Bread", "BRD") {
        doubloon = IERC20(_doubloon);
        merchant = _baker;
    }

    function buy() external {
        uint256 amount = doubloon.allowance(msg.sender, address(this));
        require(amount > 0, "Start the trade first");
        require(amount >= EXCHANGE_RATE, "Amount too low");

        doubloon.transferFrom(msg.sender, merchant, amount); // pay the baker

        _mint(msg.sender, amount / EXCHANGE_RATE); // bake the bread
    }
}
