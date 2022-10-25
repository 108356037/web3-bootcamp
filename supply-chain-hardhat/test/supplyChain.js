const { expect } = require("chai");
const { ethers } = require("hardhat");
const { loadFixture } = require("@nomicfoundation/hardhat-network-helpers");

describe("ItemManager Contract", async function () {
  async function deployItemManagerFixture() {
    const ItemManager = await ethers.getContractFactory("ItemManager");
    const [owner] = await ethers.getSigners();

    const itemManager = await ItemManager.deploy();
    await itemManager.deployed();

    return { itemManager, owner };
  }

  it("can create item in a sub contract", async function () {
    const { itemManager } = await loadFixture(deployItemManagerFixture);

    const getItemAddress = async function (itemIndex) {
      item = await itemManager.items(itemIndex);
      return await item._item;
    };

    // Created: 0, Paid: 1, Delivered: 2
    await expect(itemManager.createItem("this is npx test item", 1000))
      .to.emit(itemManager, "SupplyChainStep")
      .withArgs(0, 0, await getItemAddress(0));
  });
});
