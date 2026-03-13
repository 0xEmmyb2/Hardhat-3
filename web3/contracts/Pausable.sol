//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.19;


contract Pausable {
    bool public isPaused;

    event PauseToggled(bool isPaused);

    modifier notPaused() {
        require(!isPaused, "Contract is paused");
        _;
    }

    function togglePause() public {
        isPaused = !isPaused;
        emit PauseToggled(isPaused);
    }
}