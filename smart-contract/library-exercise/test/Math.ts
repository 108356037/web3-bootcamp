import { expect } from "chai";
import { ethers } from "hardhat";
import { loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { BigNumber } from "ethers";

describe("Math library", () => {
  async function deployMathContract() {
    const [owner] = await ethers.getSigners();
    const Math = await ethers.getContractFactory("Math");
    const math = await Math.deploy();

    return { math, owner };
  }

  async function deployTestContract() {
    const [owner] = await ethers.getSigners();
    const MathLib = await ethers.getContractFactory("Math");
    const mathLib = await MathLib.deploy();
    await mathLib.deployed();

    const Test = await ethers.getContractFactory("Test", {
      signer: owner,
      libraries: {
        Math: mathLib.address,
      },
    });
    const A = 100;
    const B = 200;
    const C = 300;
    const test = await Test.deploy(A, B, C);

    return { test };
  }

  // it("can do comparison in math lib", async () => {
  //   const { math } = await loadFixture(deployMathContract);

  //   expect(await math.max(100, 200)).to.equal(200);
  //   expect(await math.min(100, 200)).to.equal(100);
  // });

  it("can see the whole array and find num", async () => {
    const { test } = await loadFixture(deployTestContract);
    const storageArr = await test.getStorageArr();

    expect(storageArr[0]).to.equal(BigNumber.from("100"));
    expect(storageArr[1]).to.equal(BigNumber.from("200"));
    expect(storageArr[2]).to.equal(BigNumber.from("300"));
    expect(await test.findNumInArr(storageArr, 100)).to.equal(0);
  });

  it("can peek items of private storage array", async () => {
    const { test } = await loadFixture(deployTestContract);
    const storageArr = await test.getStorageArr();
    const firstElement = await test.peekFirstItem(storageArr);

    expect(firstElement).to.equal("100");
  });

  it("can compare nums using lib", async () => {
    const { test } = await loadFixture(deployTestContract);

    expect(await test.getMaxUsingMathLib(100, 200)).to.equal(200);
    expect(await test.getMinUsingMathLib(100, 200)).to.equal(100);
  });
});
