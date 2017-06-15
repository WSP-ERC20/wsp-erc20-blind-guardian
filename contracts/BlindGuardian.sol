pragma solidity ^0.4.11;

import './StandardToken.sol';

contract BlindGuardian {
	address owner;														// Depositor
	address withdrawalAddress;								// Where funds go if nothing goes wrong
	address panicAddress;											// Where funds go if failsafes trigger override
	uint256 balance;													// Amount deposited
	bool guarding = false;										// True while contract guards Ether
	address[] failsafeList;										// List of trusted failsafes
	mapping (address => bool) isFailsafe;			// Easier than creating a function
	mapping (address => bool) panicSwitches;  // Track failsafe panic
	uint256 panicLimit;												// Number of failsafes to trigger panic mode
	uint256 startTime;												// When guarding begins
	uint256 lockTime;													// Time to store Ether
	uint256 panicTime;												// Additional storage time if in ortpanic

	modifier onlyOwner() {
		if (msg.sender == owner) _;
	}

	modifier onlyFailsafe() {
		if (isFailsafe[msg.sender] == true) _;
	}

	function () payable {
		balance += msg.value;
	}

	function BlindGuardian() onlyOwner {
		owner = msg.sender;
	}

	function startGuarding(address _withdrawalAddress, address _panicAddress, uint256 _lockTime, uint256 _panicTime) onlyOwner {
		withdrawalAddress = _withdrawalAddress;
		panicAddress = _panicAddress;
		lockTime = _lockTime;
		panicTime = _panicTime;
		startTime = now;
		guarding = true;
	}

	function addFallback(address _addr) onlyOwner {
		panicSwitches[_addr] = true;
		failsafeList.push(_addr);
	}

	function setPanicLimit(uint256 _limit) onlyOwner {
		panicLimit = _limit;
	}

	function panic() onlyFailsafe {
		overrides[msg.sender] = true;
	}

	function withdrawal() onlyOwner returns bool {
		uint256 delay = startTime + lockTime;
		address addr = withdrawalAddress;

		if (!isPanicMode()) {
			addr = panicAddress;
			delay += panicTime;
		}

		addr.send(balance);
	}

	function isPanicMode() returns bool {
		uint256 count = 0;
		for (uint256 i = 0; i < failsafeList.length; i++) {
			if (panicSwitches[failesafeList[i]] == true) {
				count++;
			}
		}
		if (count >= panicLimit) {
			return true;
		} else {
			return false;
		}
	}
}
