pragma solidity ^0.8.13;
// SPDX-License-Identifier: None

/*
             ,;:;;,
           ;;;;;
   .=',    ;:;;:,    ░░░░░    Ｈｉｐｐｉｅ   ░░░░░
  /_', "=. ';:;:;    ░░░░░   Ｈｉｐｓｔｅｒ   ░░░░░ 
  @=:__,  \,;:;:'    ░░░░░  Ｃｈｉｐｍｕｎｋｓ ░░░░░
    _(\.=  ;:;;'
   `"_(  _/="`
   `"'``
                    𝕓𝕪 @𝕖𝕧𝕞_𝕝𝕒𝕓𝕤 & @𝕕𝕚𝕞𝕚𝕣𝕖𝕒𝕕𝕤𝕥𝕙𝕚𝕟𝕘𝕤 (𝕋𝕨𝕚𝕥𝕥𝕖𝕣)
*/

import "@openzeppelin/contracts/access/Ownable.sol";


contract Hipnation is Ownable{

    mapping(string => address payable) internal Charities;
    string [] CharitiesArray = ["UNICEF", "UKRAINE"]; // TODO: Add full list
    string public CharityOfTheMonth;
    address public DAOadmin = owner();
    uint256 public balance;
    uint256 private DonationDate = 1656680400; // July 1st 2021, 9AM EDT
    uint256 private donationWindow = 259200; // seconds in 3 days

    constructor(){
        Charities["UNICEF"] = payable(address(0)); // TODO: Add full list
        Charities["UKRAINE"] = payable(address(0));
    }

    modifier onlyEvery4thFriday(){
        require(
            (block.timestamp > DonationDate) && (block.timestamp < (DonationDate + donationWindow)),
            "Donation window is not open."
        );
        _;
    }

    modifier onlyOwnerOrAdmin(){
        require(
            (msg.sender == owner()) || (msg.sender == DAOadmin),
            "The message was not sent by the owner or an admin."
        );
        _;
    }

    function transferToCharity(uint256 _amountInWei) external onlyOwnerOrAdmin onlyEvery4thFriday{
        require(
            _amountInWei <= address(this).balance,
            "Requested amount exceeds available funds."
        );
        (bool success, ) = Charities[CharityOfTheMonth].call{value:_amountInWei}(""); 
        require(success, "Failed to Deposit. Transfer transaction was not successful.");
        updateDonationDate();
    }

    function setCharity(string memory _charity) external onlyOwnerOrAdmin{
        CharityOfTheMonth = _charity;
    }

    function updateCharityAddress(string memory _charity, address payable _address) external onlyOwnerOrAdmin{
        Charities[_charity] = _address;
    }

    function setDAOAdmin(address _admin) external onlyOwnerOrAdmin{
        DAOadmin = _admin;
    } 

    function getBalance() external {
        balance = address(this).balance;
    }

    function updateDonationDate() internal {
        DonationDate += 2419200; // 4 weeks
    }

    receive() external payable {}

    fallback() external payable {}
}