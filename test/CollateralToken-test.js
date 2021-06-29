const { expect } = require('chai');
const { ethers } = require('hardhat');

describe('Collateral Token', async function () {
  let CT, ct, dev;
  const NAME = 'Collateral Token';
  const SYMBOL = 'CT';
  const SUPPLY = ethers.utils.parseEther('1000000');
  beforeEach(async function () {
    dev = await ethers.getSigner();
    CT = await ethers.getContractFactory('CollateralToken');
    ct = await CT.connect(dev).deploy(SUPPLY);
    await ct.deployed();
  });
  it('should be the good name', async function () {
    expect(await ct.name()).to.equal(NAME);
  });
  it('should be the good symbol', async function () {
    expect(await ct.symbol()).to.equal(SYMBOL);
  });
  it('should mint the good supply', async function () {
    expect(await ct.balanceOf(dev.address)).to.equal(SUPPLY);
    const receipt = await ct.deployTransaction.wait();
    await expect(receipt.transactionHash)
      .to.emit(ct, 'Transfer')
      .withArgs(ethers.constants.AddressZero, dev.address, SUPPLY);
  });
});
