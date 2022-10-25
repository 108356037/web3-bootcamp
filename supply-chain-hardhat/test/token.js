const { expect } = require("chai");
const { ethers } = require("hardhat");
const { loadFixture } = require("@nomicfoundation/hardhat-network-helpers");

describe("Token Contract", function () {
  async function deployTokenFixture() {
    const Token = await ethers.getContractFactory("Token");
    const [owner, acc1, acc2] = await ethers.getSigners();

    const myToken = await Token.deploy(10000);
    await myToken.deployed();

    return { Token, myToken, owner, acc1, acc2 };
  }

  it("Owner balance has totalSupply", async function () {
    const { myToken, owner } = await loadFixture(deployTokenFixture);

    const ownerBalance = await myToken.balanceOf(owner.getAddress());
    expect(await myToken.getTotalSupply()).to.equal(ownerBalance);
  });

  it("Can transfer tokens between accounts", async function () {
    const { myToken, owner, acc1, acc2 } = await loadFixture(
      deployTokenFixture
    );

    expect(
      await myToken.transfer(10, acc1.getAddress())
    ).to.changeTokenBalances(myToken, [owner, acc1], [-10, 10]);

    expect(
      await myToken.connect(acc1).transfer(1, acc2.address)
    ).to.changeTokenBalances(myToken, [acc1, acc2], [-1, 1]);

    expect(await myToken.transfer(120, acc2.address))
      .to.emit(myToken, "Transfer")
      .withArgs(owner.address, acc2.address, 120);
  });
});
