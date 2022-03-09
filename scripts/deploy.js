async function main() {
  const TrustFund = await ethers.getContractFactory("TrustFund");

  // Start deployment, returning a promise that resolves to a contract object
  const trustFund = await TrustFund.deploy();   
  console.log("Contract deployed to address:", trustFund.address);
}
 
main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });