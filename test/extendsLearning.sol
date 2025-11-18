// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract Humanbeing {
    uint256 public MaxHP;
    uint256 public HP;

    constructor() {
        MaxHP = 100;
        HP = MaxHP;
    }

    function heal() public virtual {
        require(MaxHP > HP);
        HP += 10;
    }

    // virtual: 表明为虚函数，这样继承他的合约可以override
    function attacked(uint256 damage) public virtual {
        if (damage >= HP) {
            HP = 0;
        } else {
            HP -= damage;
        }
    }
}

contract Soldier is Humanbeing {
    bool isReadyToDefense = false;

    function defense() public {
        isReadyToDefense = true;
    }

    function attacked(uint256 damage) public override {
        if (!isReadyToDefense) {
            super.attacked(damage);
        } else {
            isReadyToDefense = false;
        }
    }
}
