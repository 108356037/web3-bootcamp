const { expect } = require("chai");
const { ethers } = require("hardhat");
const { loadFixture } = require("@nomicfoundation/hardhat-network-helpers");

describe("Token Contract", function () {
  async function deployTokenFixture() {
    const Token = await ethers.getContractFactory("Token");
    const [owner, acc1, acc2] = await ethers.getSigners();

    const myToken = await Token.deploy();
    await myToken.deployed();

    return { Token, myToken, owner, acc1, acc2 };
  }

  it("Should assign the total supply of tokens to the owner", async function () {
    const { myToken, owner } = await loadFixture(deployTokenFixture);

    const ownerBalance = await myToken.balanceOf(owner.address);
    expect(await myToken.totalSupply()).to.equal(ownerBalance);
  });

  it("Should transfer tokens between accounts", async function () {
    const { myToken, owner, acc1, acc2 } = await loadFixture(
      deployTokenFixture
    );

    await expect(myToken.transfer(acc1.address, 50)).to.changeTokenBalances(
      myToken,
      [owner, acc1],
      [-50, 50]
    );

    await expect(
      myToken.connect(acc1).transfer(acc2.address, 50)
    ).to.changeTokenBalances(myToken, [acc1, acc2], [-50, 50]);
  });
});
