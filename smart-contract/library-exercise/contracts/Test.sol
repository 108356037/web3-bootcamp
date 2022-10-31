// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.7.6;

import {Math} from "./Math.sol";
import "hardhat/console.sol";

contract Test {
    using Math for uint256[];
    using Math for uint256;
    uint256[] private testArr;

    constructor(
        uint256 _a,
        uint256 _b,
        uint256 _c
    ) {
        testArr = new uint256[](3);
        testArr[0] = _a;
        testArr[1] = _b;
        testArr[2] = _c;
    }

    function viewAddressLib() external view returns (address) {
        return address(this);
    }

    function getStorageArr() external view returns (uint256[] memory) {
        return testArr;
    }

    function getMaxUsingMathLib(uint256 _a, uint256 _b)
        external
        pure
        returns (uint256)
    {
        return _a.max(_b);
    }

    function getMinUsingMathLib(uint256 _a, uint256 _b)
        external
        pure
        returns (uint256)
    {
        return _a.min(_b);
    }

    function findNumInArr(uint256[] calldata _arr, uint256 _target)
        external
        pure
        returns (uint256)
    {
        //console.log("we are in Test.sol::findNumInArr: %o", address(this));
        return _arr.findNum(_target);
    }

    function peekFirstItem(uint256[] calldata _arr)
        external
        pure
        returns (uint256)
    {
        //console.log("we are in Test.sol::peekFirstItem: %o", address(this));
        return _arr.peekArr();
    }
}
