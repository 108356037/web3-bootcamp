// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.1;

contract WillThrow {
    function willThrowErr() public pure {
        require(false, "an error occurred");
    }
}

contract ErrorHandling {
    event ErrorLogging(string reason);

    function catchError() public {
        WillThrow willThrow = new WillThrow();
        try willThrow.willThrowErr() {
            // do something here if no error
        } catch Error(string memory reason) {
            emit ErrorLogging(reason);
        }
    }
}