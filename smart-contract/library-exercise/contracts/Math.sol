// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.7.6;

import "hardhat/console.sol";

library Math {
    function max(uint256 _a, uint256 _b) internal pure returns (uint256) {
        // console.log("we are in Mathlib::max: %o", address(this));
        return _a >= _b ? _a : _b;
    }

    function min(uint256 _a, uint256 _b) internal pure returns (uint256) {
        // console.log("we are in Mathlib::min: %o", address(this));
        return _a <= _b ? _a : _b;
    }

    // could not pass compile if modified as internal here
    // ---------------------------------------------------
    // [Error Log]
    // NomicLabsHardhatPluginError:
    // You tried to link the contract Test with Math,
    // which is not one of its libraries.
    // This contract doesn't need linking any libraries.
    function findNum(uint256[] calldata _arr, uint256 _target)
        external
        pure
        returns (uint256)
    {
        // console.log("we are in Mathlib::findNum: %o", address(this));
        for (uint256 i = 0; i <= _arr.length; i++) {
            if (_arr[i] == _target) {
                return i;
            }
        }
        revert();
    }

    // could not pass _arr as `calldata` here
    function peekArr(uint256[] memory _arr) internal pure returns (uint256) {
        // console.log("we are in Mathlib::peekArr: %o", address(this));
        require(
            _arr.length > 0,
            "array length must contain at least one element"
        );
        // my guess: _arr[0] breaks calldata property (read-only)
        return _arr[0];
    }

    function stringOps(string calldata _str1, string calldata _str2)
        internal
        pure
        returns (string memory)
    {
        return string(abi.encodePacked(_str1, _str2));
    }
}
