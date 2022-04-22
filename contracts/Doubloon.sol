// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./Gold.sol";

contract Doubloon is ERC20 {
    uint256 public constant EXCHANGE_RATE = 100; // 1 GOLD Lingot = 100 doubloon
    Gold public gold;

    constructor(uint256 _intialSupply, address _gold) ERC20("Doubloon", "DBL") {
        _mint(msg.sender, _intialSupply);
        gold = Gold(_gold);
    }

    function makeDoubloon(uint256 goldAmount) external {
        require(goldAmount >= 0, "Provide at least 1 GOLD");
        require(
            gold.allowance(msg.sender, address(this)) > 0,
            "Approve to spend your gold"
        );

        gold.transferFrom(msg.sender, address(this), goldAmount);

        gold.meltGold(goldAmount);

        _mint(msg.sender, goldAmount * 100);
    }

    function approveMakeDoubloon(uint256 goldAmount) external {
        require(goldAmount >= 0, "Provide at least 1 GOLD");
        gold.approve(address(this), goldAmount);
    }

    function decimals() public view virtual override returns (uint8) {
        return 0;
    }
}
